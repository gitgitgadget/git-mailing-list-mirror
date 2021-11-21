Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BA3C433EF
	for <git@archiver.kernel.org>; Sun, 21 Nov 2021 23:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbhKUXOD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Nov 2021 18:14:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:35948 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhKUXOD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Nov 2021 18:14:03 -0500
Received: (qmail 18036 invoked by uid 109); 21 Nov 2021 23:10:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 21 Nov 2021 23:10:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7339 invoked by uid 111); 21 Nov 2021 23:10:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 21 Nov 2021 18:10:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 21 Nov 2021 18:10:56 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] t7006: clean up SIGPIPE handling in trace2 tests
Message-ID: <YZrSALOrdhuunHwp@coredump.intra.peff.net>
References: <xmqq1r4b8ezp.fsf@gitster.g>
 <20211024170349.GA2101@szeder.dev>
 <YZqSgu4XjPWnURju@coredump.intra.peff.net>
 <YZrCmPb5AIW8YYQ0@coredump.intra.peff.net>
 <YZrOLy03s5ZWMQ+t@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YZrOLy03s5ZWMQ+t@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 21, 2021 at 05:54:39PM -0500, Jeff King wrote:

> That's actually pretty easy to do. So I came up with the patch below, in
> the interests of wrapping up this thread.
> 
> I'm not 100% sure this fixes any possible races, as the race Junio
> initially reported seemed to be in the "propagated signals from pager"
> test, which I don't think has these flaky-SIGPIPE problems. But I think
> it's at least correcting some of the confusion. And we can see if it
> happens again (I haven't been able to trigger any failures with --stress
> myself).
> 
> -- >8 --
> Subject: [PATCH] t7006: clean up SIGPIPE handling in trace2 tests

This one is optional on top. It's just cleanup, but IMHO makes it easier
to understand what's going on.

-- >8 --
Subject: [PATCH] t7006: simplify exit-code checks for sigpipe tests

Some tests in t7006 check for a SIGPIPE result by recording $? and
comparing it with test_match_signal. Before the previous commit, the
command was on the left-hand side of a pipe, and so we had to do some
subshell trickery to extract it.

But now that this is no longer the case, we can do things much more
simply: just run the command directly, using braces to avoid wrecking
the &&-chain, and then record $?. We could almost use test_expect_code
here, but it doesn't know about test_match_signal.

Likewise, for tests which expect success (i.e., not SIGPIPE), we can
just put them in the &&-chain as usual. That even lets us get rid of the
!MINGW check, since the expectation is the same on both sides.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7006-pager.sh | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 577e51b47a..851961c798 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -677,7 +677,7 @@ test_expect_success TTY 'git returns SIGPIPE on early pager exit' '
 
 	if test_have_prereq !MINGW
 	then
-		OUT=$( ((test_terminal git log; echo $? 1>&3) >/dev/null) 3>&1 ) &&
+		{ test_terminal git log >/dev/null; OUT=$?; } &&
 		test_match_signal 13 "$OUT"
 	else
 		test_terminal git log
@@ -698,7 +698,7 @@ test_expect_success TTY 'git returns SIGPIPE on early pager non-zero exit' '
 
 	if test_have_prereq !MINGW
 	then
-		OUT=$( ((test_terminal git log; echo $? 1>&3) >/dev/null) 3>&1 ) &&
+		{ test_terminal git log >/dev/null; OUT=$?; } &&
 		test_match_signal 13 "$OUT"
 	else
 		test_terminal git log
@@ -717,13 +717,7 @@ test_expect_success TTY 'git discards pager non-zero exit without SIGPIPE' '
 	export GIT_TRACE2 &&
 	test_when_finished "unset GIT_TRACE2" &&
 
-	if test_have_prereq !MINGW
-	then
-		OUT=$( ((test_terminal git log; echo $? 1>&3) >/dev/null) 3>&1 ) &&
-		test "$OUT" -eq 0
-	else
-		test_terminal git log
-	fi &&
+	test_terminal git log &&
 
 	grep child_exit trace.normal >child-exits &&
 	test_line_count = 1 child-exits &&
@@ -738,13 +732,7 @@ test_expect_success TTY 'git skips paging nonexisting command' '
 	export GIT_TRACE2 &&
 	test_when_finished "unset GIT_TRACE2" &&
 
-	if test_have_prereq !MINGW
-	then
-		OUT=$( ((test_terminal git log; echo $? 1>&3) >/dev/null) 3>&1 ) &&
-		test "$OUT" -eq 0
-	else
-		test_terminal git log
-	fi &&
+	test_terminal git log &&
 
 	grep child_exit trace.normal >child-exits &&
 	test_line_count = 1 child-exits &&
@@ -760,7 +748,7 @@ test_expect_success TTY 'git returns SIGPIPE on propagated signals from pager' '
 
 	if test_have_prereq !MINGW
 	then
-		OUT=$( ((test_terminal git log; echo $? 1>&3) >/dev/null) 3>&1 ) &&
+		{ test_terminal git log >/dev/null; OUT=$?; } &&
 		test_match_signal 13 "$OUT"
 	else
 		test_terminal git log
-- 
2.34.0.636.g3d595567a1

