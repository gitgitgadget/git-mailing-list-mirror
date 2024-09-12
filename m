Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5E3195980
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726134220; cv=none; b=O38We27lwkcg0d+iuRo1DKkuwHrlyhuo8SyiT4FntNl+EDuqtkzlgRrNqw0Kv60QgzngBai+XPHzkg6uiC+aSUrQrH+4YUWwiOGU+ipY+GEeHiMS/Lstm/kYAPj00EMFrmGwm1fcj8b28O6gV2RVK2pvzwgXca30EANp5uUQ5G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726134220; c=relaxed/simple;
	bh=/2RlBHwLlobZMJ51m4fnc071Fvv/0DpZwaBTxyb8Wvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b36uma2FA7IjwTdqjNxx/czrCJC4RZr8Ubrb/5X5G/xPiSsOM3oWTp9qCTedE/kFT/+DVD+sFxZsTTM6rgCLDd6T2iWG/A4VTmBVFK3db7kPf/F6EoDooMicP0y3DkuW94JHlMWJ8txyGp4cwdNba6YvTrTvkPBzMMZmwJQrGUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17299 invoked by uid 109); 12 Sep 2024 09:43:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Sep 2024 09:43:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23131 invoked by uid 111); 12 Sep 2024 09:43:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Sep 2024 05:43:37 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 12 Sep 2024 05:43:36 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: [PATCH 1/4] ci: drop run-docker scripts
Message-ID: <20240912094336.GA589828@coredump.intra.peff.net>
References: <20240912094238.GA589050@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240912094238.GA589050@coredump.intra.peff.net>

We haven't used these scripts since 4a6e4b9602 (CI: remove Travis CI
support, 2021-11-23), as the GitHub Actions config has support for
directly running jobs within docker containers.

It's possible we might want to resurrect something like this in order to
be more agnostic to the CI platform. But it's not clear exactly what it
would look like. And in the meantime, it's just a maintenance burden as
we make changes to CI config, and is subject to bitrot. In fact it's
already broken; it references ci/install-docker-dependencies.sh, which
went away in 9cdeb34b96 (ci: merge scripts which install dependencies,
2024-04-12).

Signed-off-by: Jeff King <peff@peff.net>
---
I think this is worth doing even if we don't take the rest of the
patches. But obviously it gets even more bit-rotted as the other patches
change the CI config file.

 ci/run-docker-build.sh | 66 ------------------------------------------
 ci/run-docker.sh       | 47 ------------------------------
 2 files changed, 113 deletions(-)
 delete mode 100755 ci/run-docker-build.sh
 delete mode 100755 ci/run-docker.sh

diff --git a/ci/run-docker-build.sh b/ci/run-docker-build.sh
deleted file mode 100755
index 6cd832efb9..0000000000
--- a/ci/run-docker-build.sh
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-#
-# Build and test Git inside container
-#
-# Usage:
-#   run-docker-build.sh <host-user-id>
-#
-
-set -ex
-
-if test $# -ne 1 || test -z "$1"
-then
-	echo >&2 "usage: run-docker-build.sh <host-user-id>"
-	exit 1
-fi
-
-case "$jobname" in
-linux32)
-	switch_cmd="linux32 --32bit i386"
-	;;
-linux-musl)
-	switch_cmd=
-	useradd () { adduser -D "$@"; }
-	;;
-*)
-	exit 1
-	;;
-esac
-
-"${0%/*}/install-docker-dependencies.sh"
-
-# If this script runs inside a docker container, then all commands are
-# usually executed as root. Consequently, the host user might not be
-# able to access the test output files.
-# If a non 0 host user id is given, then create a user "ci" with that
-# user id to make everything accessible to the host user.
-HOST_UID=$1
-if test $HOST_UID -eq 0
-then
-	# Just in case someone does want to run the test suite as root.
-	CI_USER=root
-else
-	CI_USER=ci
-	if test "$(id -u $CI_USER 2>/dev/null)" = $HOST_UID
-	then
-		echo "user '$CI_USER' already exists with the requested ID $HOST_UID"
-	else
-		useradd -u $HOST_UID $CI_USER
-	fi
-fi
-
-# Build and test
-command $switch_cmd su -m -l $CI_USER -c "
-	set -ex
-	export DEVELOPER='$DEVELOPER'
-	export DEFAULT_TEST_TARGET='$DEFAULT_TEST_TARGET'
-	export GIT_PROVE_OPTS='$GIT_PROVE_OPTS'
-	export GIT_TEST_OPTS='$GIT_TEST_OPTS'
-	export GIT_TEST_CLONE_2GB='$GIT_TEST_CLONE_2GB'
-	export MAKEFLAGS='$MAKEFLAGS'
-	export cache_dir='$cache_dir'
-	cd /usr/src/git
-	test -n '$cache_dir' && ln -s '$cache_dir/.prove' t/.prove
-	make
-	make test
-"
diff --git a/ci/run-docker.sh b/ci/run-docker.sh
deleted file mode 100755
index af89d1624a..0000000000
--- a/ci/run-docker.sh
+++ /dev/null
@@ -1,47 +0,0 @@
-#!/bin/sh
-#
-# Download and run Docker image to build and test Git
-#
-
-. ${0%/*}/lib.sh
-
-case "$jobname" in
-linux32)
-	CI_CONTAINER="daald/ubuntu32:xenial"
-	;;
-linux-musl)
-	CI_CONTAINER=alpine
-	;;
-*)
-	exit 1
-	;;
-esac
-
-docker pull "$CI_CONTAINER"
-
-# Use the following command to debug the docker build locally:
-# <host-user-id> must be 0 if podman is used as drop-in replacement for docker
-# $ docker run -itv "${PWD}:/usr/src/git" --entrypoint /bin/sh "$CI_CONTAINER"
-# root@container:/# export jobname=<jobname>
-# root@container:/# /usr/src/git/ci/run-docker-build.sh <host-user-id>
-
-container_cache_dir=/tmp/container-cache
-
-docker run \
-	--interactive \
-	--env DEVELOPER \
-	--env DEFAULT_TEST_TARGET \
-	--env GIT_PROVE_OPTS \
-	--env GIT_TEST_OPTS \
-	--env GIT_TEST_CLONE_2GB \
-	--env MAKEFLAGS \
-	--env jobname \
-	--env cache_dir="$container_cache_dir" \
-	--volume "${PWD}:/usr/src/git" \
-	--volume "$cache_dir:$container_cache_dir" \
-	"$CI_CONTAINER" \
-	/usr/src/git/ci/run-docker-build.sh $(id -u $USER)
-
-check_unignored_build_artifacts
-
-save_good_tree
-- 
2.46.0.918.gab30941bff

