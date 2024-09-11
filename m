Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34593F9FB
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 06:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726035016; cv=none; b=e/4x/Olx3+Q2KajNOzCo9t7oBAoilQjRtV7+87cwqQIB7qhKW6f9Ec0X3GXp4jQEvkF2IVzgo5h1Cr5FswqhlwSJTpcoraklkqZjkXTMPYyjGdugZoP9LhY0MFcrk3XCJQEV3YSvlWa2fVOlL+9ePPkkLACIIZiNCs/iEaQJgCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726035016; c=relaxed/simple;
	bh=4dq+QbcIZe0mMNV6TSKpJ/sVhP+BMm0CeDTKaUjJg44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDxXHiGcBod2wl6CJrrbqG9hZA4q6ElUi7nOTOBCD/woSjLbcnFbGvFR7EaVw0/PxC+8eziOILeB3AqKhHIv8ouwAJq628nlUik+HuyRmLvN1Pfh0G3gM1NwRtnhNv0wycK0mjrz+Fy4olSN3PxU/yHG4fOgzRgOgeynfVgw3eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 9448 invoked by uid 109); 11 Sep 2024 06:10:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Sep 2024 06:10:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5741 invoked by uid 111); 11 Sep 2024 06:10:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Sep 2024 02:10:10 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 11 Sep 2024 02:10:09 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 5/9] i5500-git-daemon.sh: use compile-able version of
 Git without OpenSSL
Message-ID: <20240911061009.GA1538383@coredump.intra.peff.net>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1725651952.git.me@ttaylorr.com>
 <bfe992765cd562b036cb235dfdddb78f5e662812.1725651952.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bfe992765cd562b036cb235dfdddb78f5e662812.1725651952.git.me@ttaylorr.com>

On Fri, Sep 06, 2024 at 03:46:19PM -0400, Taylor Blau wrote:

> Let's work around the issue by using a slightly more modern, but still
> quite old v1.6.6.3, which is used by the i0000-basic.sh test script as
> well.

So I know I shouldn't care that much about which ancient version the
interop tests are using. But it feels like we should be able to provide
the tools to make this work.

How about this instead?

-- >8 --
Subject: [PATCH] t/interop: allow per-version make options

Building older versions of Git may require tweaking some build knobs. In
particular, very old versions of Git will fail to build with recent
OpenSSL, because the bignum type switched from a struct to a pointer.

The i5500 interop test uses Git v1.0.0 by default, which triggers this
problem. You can work around it by setting NO_OPENSSL in your
GIT_TEST_MAKE_OPTS variable. But there are two downsides:

  1. You have to know to do this, and it's not at all obvious.

  2. That sets the options for _all_ versions of Git that we build. And
     it's possible for two versions to require conflicting knobs. E.g.,
     building with "make NO_OPENSSL=Nope OPENSSL_SHA1=Yes" causes
     imap-send.c to barf, because it declares a fallback typdef for SSL.
     This is something we may want to fix, but of course many historical
     versions are affected, and the interop scripts should be flexible
     enough to build everything.

So let's introduce per-version make options, along with the ability for
scripts to specify knobs that match their default versions. That should
make everything build out of the box, but also allow testers flexibility
if they are testing interoperability between non-default versions.

We'll set NO_OPENSSL by default for v1.0.0 in i5500. It doesn't have to
worry about the conflict with OPENSSL_SHA1 because imap-send did not
exist back then (but if it did, it could also just explicitly use a
different hash implementation).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/interop/README              | 7 +++++++
 t/interop/i5500-git-daemon.sh | 1 +
 t/interop/interop-lib.sh      | 8 +++++---
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/t/interop/README b/t/interop/README
index 72d42bd856..4e0608f857 100644
--- a/t/interop/README
+++ b/t/interop/README
@@ -83,3 +83,10 @@ You can then use test_expect_success as usual, with a few differences:
      should create one with the appropriate version of git.
 
 At the end of the script, call test_done as usual.
+
+Some older versions may need a few build knobs tweaked (e.g., ancient
+versions of Git no longer build with modern OpenSSL). Your script can
+set MAKE_OPTS_A and MAKE_OPTS_B, which will be passed alongside
+GIT_INTEROP_MAKE_OPTS. Users can override them per-script by setting
+GIT_INTEROP_MAKE_OPTS_{A,B} in the environment, just like they can set
+GIT_TEST_VERSION_{A,B}.
diff --git a/t/interop/i5500-git-daemon.sh b/t/interop/i5500-git-daemon.sh
index 4d22e42f84..88712d1b5d 100755
--- a/t/interop/i5500-git-daemon.sh
+++ b/t/interop/i5500-git-daemon.sh
@@ -2,6 +2,7 @@
 
 VERSION_A=.
 VERSION_B=v1.0.0
+MAKE_OPTS_B="NO_OPENSSL=TooOld"
 
 : ${LIB_GIT_DAEMON_PORT:=5500}
 LIB_GIT_DAEMON_COMMAND='git.a daemon'
diff --git a/t/interop/interop-lib.sh b/t/interop/interop-lib.sh
index 62f4481b6e..1b5864d2a7 100644
--- a/t/interop/interop-lib.sh
+++ b/t/interop/interop-lib.sh
@@ -45,7 +45,7 @@ build_version () {
 
 	(
 		cd "$dir" &&
-		make $GIT_INTEROP_MAKE_OPTS >&2 &&
+		make $2 $GIT_INTEROP_MAKE_OPTS >&2 &&
 		touch .built
 	) || return 1
 
@@ -76,9 +76,11 @@ generate_wrappers () {
 
 VERSION_A=${GIT_TEST_VERSION_A:-$VERSION_A}
 VERSION_B=${GIT_TEST_VERSION_B:-$VERSION_B}
+MAKE_OPTS_A=${GIT_INTEROP_MAKE_OPTS_A:-$MAKE_OPTS_A}
+MAKE_OPTS_B=${GIT_INTEROP_MAKE_OPTS_B:-$MAKE_OPTS_B}
 
-if ! DIR_A=$(build_version "$VERSION_A") ||
-   ! DIR_B=$(build_version "$VERSION_B")
+if ! DIR_A=$(build_version "$VERSION_A" "$MAKE_OPTS_A") ||
+   ! DIR_B=$(build_version "$VERSION_B" "$MAKE_OPTS_B")
 then
 	echo >&2 "fatal: unable to build git versions"
 	exit 1
-- 
2.46.0.883.g5805d96482

