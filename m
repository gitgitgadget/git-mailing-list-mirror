Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EFB19F117
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 09:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726134453; cv=none; b=jLt75R6bJk97AefR+64jN/no4koFbWONLcEmjlkIa0wdHudN1ojaR2S8kPwOLZWLEJEAOokccuOhA3CJGHey/y2xGI5u34scwvCrmnLlJdDFDYHtH6+VTIwFtY5hqk8Ek0Im+PRKTS4cW5cjNQ0f+Ct2vedh7dq2e8UAZDFRMJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726134453; c=relaxed/simple;
	bh=RJOHpm/WcLqlNi1wKFQs2REbMSCHENxgsNCnOsu9CEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YN58XLqfxYKauPmE4BhU83ASjaDI03hitdKZ14IfIdHeHZSox11zCjTw25Z7NyFgadtH1YIWWLsR01Ee8yjme0Y7VzVf4wYJR/DPP1HtyMAdDctQ6EIw4aze4zWrWGX7P1Bgyd2i8ckbc8o/lploDrhSDvW1/FrA2POdi7PTqDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17317 invoked by uid 109); 12 Sep 2024 09:47:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Sep 2024 09:47:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23174 invoked by uid 111); 12 Sep 2024 09:47:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Sep 2024 05:47:30 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 12 Sep 2024 05:47:30 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: [PATCH 3/4] ci: use more recent linux32 image
Message-ID: <20240912094730.GC589828@coredump.intra.peff.net>
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

The Xenial image we're using was released more than 8 years ago. This is
a problem for using some recent GitHub Actions scripts, as they require
Node.js 20, and all of the binaries they ship need glibc 2.28 or later.
We're not using them yet, but moving forward prepares us for a future
patch which will.

Xenial was actually the last official 32-bit Ubuntu release, but you can
still find i386 images for more recent releases. This patch uses Focal,
which was released in 2020 (and is the oldest one with glibc 2.28).

There are two small downsides here:

  - while Xenial is pretty old, it is still in LTS support until April
    2026. So there's probably some value in testing with such an old
    system, and we're losing that.

  - there are no i386 subversion packages in the Focal repository. So we
    won't be able to test that (OTOH, we had never tested it until the
    previous patch which unified the 32/64-bit dependency code).

Signed-off-by: Jeff King <peff@peff.net>
---
 .github/workflows/main.yml |  4 ++--
 ci/install-dependencies.sh | 11 ++++++++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 97f9b06310..db8e8f75a4 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -339,8 +339,8 @@ jobs:
           image: alpine
           distro: alpine-latest
         - jobname: linux32
-          image: daald/ubuntu32:xenial
-          distro: ubuntu32-16.04
+          image: i386/ubuntu:focal
+          distro: ubuntu32-20.04
         - jobname: pedantic
           image: fedora
           distro: fedora-latest
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 00cb7df67a..735ee6f463 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -37,9 +37,18 @@ ubuntu-*|ubuntu32-*)
 	# Required so that apt doesn't wait for user input on certain packages.
 	export DEBIAN_FRONTEND=noninteractive
 
+	case "$distro" in
+	ubuntu-*)
+		SVN='libsvn-perl subversion'
+		;;
+	*)
+		SVN=
+		;;
+	esac
+
 	sudo apt-get -q update
 	sudo apt-get -q -y install \
-		language-pack-is libsvn-perl apache2 cvs cvsps git gnupg subversion \
+		language-pack-is apache2 cvs cvsps git gnupg $SVN \
 		make libssl-dev libcurl4-openssl-dev libexpat-dev wget sudo default-jre \
 		tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl \
 		libemail-valid-perl libio-pty-perl libio-socket-ssl-perl libnet-smtp-ssl-perl libdbd-sqlite3-perl libcgi-pm-perl \
-- 
2.46.0.918.gab30941bff

