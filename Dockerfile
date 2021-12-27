# pull official base image
FROM python:3.9.6-alpine

ENV HOME=/home/app
ENV HOME_APP=$HOME/locallibrary

RUN mkdir -p $HOME_APP
RUN mkdir -p $HOME_APP/staticfiles

# set work directory
WORKDIR $HOME_APP

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install dependencies
RUN pip install --upgrade pip
COPY ./requirements.txt .
RUN pip install -r requirements.txt

# copy project
COPY . $HOME_APP
CMD gunicorn locallibrary.wsgi:application --bind 0.0.0.0:8000
