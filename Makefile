run:
	python main.py
.PHONY:test
test:
	PYTHONPATN=. py.test --verbose -s
deps:
	pip install -r requirements.txt; \
	pip install -r test_requirements.txt
lint:
	flake8 hello_world test
docker_build:
	docker build -t hello-world-printer .
docker_run: docker_build
	docker run \
	--name hello-world-printer-dev \
	-p 5000:5000 \
	-d hello-world-printer
USERNAME=Albert
TAG=$(USERNAME)/hello-world-printer-8am
docker_push: docker_build
	@docker login --username $(USERNAME) --password $${DOCKER_PASSWORD}; \
	docker tag hello-world-printer $(TAG); \
	docker push $(TAG); \
	docker logout;