Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F428C54EBC
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 13:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjAJNkD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 08:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238677AbjAJNjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 08:39:25 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9747D1ED
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 05:39:22 -0800 (PST)
Received: (qmail 17446 invoked by uid 109); 10 Jan 2023 13:39:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Jan 2023 13:39:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27618 invoked by uid 111); 10 Jan 2023 13:39:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Jan 2023 08:39:21 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 10 Jan 2023 08:39:20 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH] t/interop: allow tests to run "git env--helper"
Message-ID: <Y71qiCs+oAS2OegH@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The interop test library sets up wrappers "git.a" and "git.b" to
represent the two versions to be tested. It also wraps vanilla "git" to
report an error, with the goal of catching tests which accidentally fail
to use one of the version-specific wrappers (which could invalidate the
tests in a very subtle way).

As a result, t/interop/i5700 has refused to run since 3b072c577b (tests:
replace test_tristate with "git env--helper", 2019-06-21). The problem
is that lib-git-daemon.sh uses "git env--helper" to decide whether to
run daemon tests, which triggers the vanilla wrapper. That produces an
error, and we think that the daemon tests are disabled.

Let's make our wrapper a little smarter, and allow env--helper
specifically. It's not an interesting part of Git to test for interop,
and it's used extensively in test setup. The matching is rudimentary
(e.g., it would not catch "git --some-arg env--helper", but it's enough
for our small set of interop tests).

Let's likewise improve the error message from the wrapper (when it does
complain) to show the arguments to git. That makes debugging a situation
like this much easier, since otherwise you are clueless about who is
calling "git" and why.

Signed-off-by: Jeff King <peff@peff.net>
---
Obviously nobody has run these for a while. I just happened to do so
today while investigating something else. Maybe they're not worth
keeping around, and we should consider it all a failed experiment.
But it's easy enough to fix in the meantime.

Arguably "git env--helper" should be "test-tool", which wouldn't run
into this problem, but it's probably not worth refactoring it for the
sake of these tests.

By the way, if you do try to run the whole set of tests, note that Git
v1.0.0 no longer builds with modern openssl (you can't declare a BIGNUM
anymore; you have to get it from BN_new()), and thus i5500 fails. You
can work around it with:

  # this gets baked into GIT-BUILD-OPTIONS
  make GIT_INTEROP_MAKE_OPTS=NO_OPENSSL=Nope

  # and now interop tests will use it for building other versions
  cd t/interop
  make

 t/interop/interop-lib.sh | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/t/interop/interop-lib.sh b/t/interop/interop-lib.sh
index 3e0a2911d4..f65baa607d 100644
--- a/t/interop/interop-lib.sh
+++ b/t/interop/interop-lib.sh
@@ -67,9 +67,18 @@ generate_wrappers () {
 	mkdir -p .bin &&
 	wrap_git .bin/git.a "$DIR_A" &&
 	wrap_git .bin/git.b "$DIR_B" &&
+	GENERIC_GIT="$TEST_DIRECTORY/../bin-wrappers/git" &&
+	export GENERIC_GIT &&
 	write_script .bin/git <<-\EOF &&
-	echo >&2 fatal: test tried to run generic git
-	exit 1
+	case "$1" in
+	env--helper)
+		exec "$GENERIC_GIT" "$@"
+		;;
+	*)
+		echo >&2 fatal: test tried to run generic git: $*
+		exit 1
+		;;
+	esac
 	EOF
 	PATH=$(pwd)/.bin:$PATH
 }
-- 
2.39.0.508.g93b13bde48
