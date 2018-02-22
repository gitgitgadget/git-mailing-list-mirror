Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D57081F576
	for <e@80x24.org>; Thu, 22 Feb 2018 06:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752576AbeBVGsj (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 01:48:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:60506 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752557AbeBVGsj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 01:48:39 -0500
Received: (qmail 13645 invoked by uid 109); 22 Feb 2018 06:48:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Feb 2018 06:48:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32497 invoked by uid 111); 22 Feb 2018 06:49:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 22 Feb 2018 01:49:26 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Feb 2018 01:48:37 -0500
Date:   Thu, 22 Feb 2018 01:48:37 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH] t: send verbose test-helper output to fd 4
Message-ID: <20180222064836.GA10719@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a repost of the two patches from:

  https://public-inbox.org/git/20180209185710.GA23403@sigill.intra.peff.net/

(now just one patch, since sg/test-i18ngrep graduated and we can do it
all in one step). The idea got positive feedback, but nobody commented
on patches and I didn't see them in "What's cooking".

-- >8 --
Test helper functions like test_must_fail may produce
messages to stderr when they see a problem. When the tests
are run with "--verbose", this ends up on the test script's
stderr, and the user can read it.

But there's a problem. Some tests record stderr as part of
the test, like:

  test_must_fail git foo 2>output &&
  test_i18ngrep expected.message output

In this case the error text goes into "output". This makes
the --verbose output less useful (it also means we might
accidentally match it in the second, though in practice we
tend to produce these messages only on error, so we'd abort
the test when the first command fails).

Let's instead send this user-facing output directly to
descriptor 4, which always points to the original stderr (or
/dev/null in non-verbose mode). And it's already forbidden
to redirect descriptor 4, since we use it for BASH_XTRACEFD,
as explained in 9be795fbce (t5615: avoid re-using descriptor
4, 2017-12-08).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib-functions.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 67b5994afb..aabee13e5d 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -625,22 +625,22 @@ test_must_fail () {
 	exit_code=$?
 	if test $exit_code -eq 0 && ! list_contains "$_test_ok" success
 	then
-		echo >&2 "test_must_fail: command succeeded: $*"
+		echo >&4 "test_must_fail: command succeeded: $*"
 		return 1
 	elif test_match_signal 13 $exit_code && list_contains "$_test_ok" sigpipe
 	then
 		return 0
 	elif test $exit_code -gt 129 && test $exit_code -le 192
 	then
-		echo >&2 "test_must_fail: died by signal $(($exit_code - 128)): $*"
+		echo >&4 "test_must_fail: died by signal $(($exit_code - 128)): $*"
 		return 1
 	elif test $exit_code -eq 127
 	then
-		echo >&2 "test_must_fail: command not found: $*"
+		echo >&4 "test_must_fail: command not found: $*"
 		return 1
 	elif test $exit_code -eq 126
 	then
-		echo >&2 "test_must_fail: valgrind error: $*"
+		echo >&4 "test_must_fail: valgrind error: $*"
 		return 1
 	fi
 	return 0
@@ -678,7 +678,7 @@ test_expect_code () {
 		return 0
 	fi
 
-	echo >&2 "test_expect_code: command exited with $exit_code, we wanted $want_code $*"
+	echo >&4 "test_expect_code: command exited with $exit_code, we wanted $want_code $*"
 	return 1
 }
 
@@ -742,18 +742,18 @@ test_i18ngrep () {
 		shift
 		! grep "$@" && return 0
 
-		echo >&2 "error: '! grep $@' did find a match in:"
+		echo >&4 "error: '! grep $@' did find a match in:"
 	else
 		grep "$@" && return 0
 
-		echo >&2 "error: 'grep $@' didn't find a match in:"
+		echo >&4 "error: 'grep $@' didn't find a match in:"
 	fi
 
 	if test -s "$last_arg"
 	then
-		cat >&2 "$last_arg"
+		cat >&4 "$last_arg"
 	else
-		echo >&2 "<File '$last_arg' is empty>"
+		echo >&4 "<File '$last_arg' is empty>"
 	fi
 
 	return 1
@@ -764,7 +764,7 @@ test_i18ngrep () {
 # not output anything when they fail.
 verbose () {
 	"$@" && return 0
-	echo >&2 "command failed: $(git rev-parse --sq-quote "$@")"
+	echo >&4 "command failed: $(git rev-parse --sq-quote "$@")"
 	return 1
 }
 
-- 
2.16.2.580.g650ee5408b
