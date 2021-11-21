Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65460C433EF
	for <git@archiver.kernel.org>; Sun, 21 Nov 2021 22:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbhKUW5r (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Nov 2021 17:57:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:35934 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230039AbhKUW5q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Nov 2021 17:57:46 -0500
Received: (qmail 17984 invoked by uid 109); 21 Nov 2021 22:54:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 21 Nov 2021 22:54:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7211 invoked by uid 111); 21 Nov 2021 22:54:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 21 Nov 2021 17:54:41 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 21 Nov 2021 17:54:39 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH] t7006: clean up SIGPIPE handling in trace2 tests
Message-ID: <YZrOLy03s5ZWMQ+t@coredump.intra.peff.net>
References: <xmqq1r4b8ezp.fsf@gitster.g>
 <20211024170349.GA2101@szeder.dev>
 <YZqSgu4XjPWnURju@coredump.intra.peff.net>
 <YZrCmPb5AIW8YYQ0@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YZrCmPb5AIW8YYQ0@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 21, 2021 at 05:05:12PM -0500, Jeff King wrote:

> On Sun, Nov 21, 2021 at 01:40:02PM -0500, Jeff King wrote:
> 
> > It seems like this thread stalled. Ævar, were you planning to fix these
> > tests?
> > 
> > It's not too hard to swap out a "yes" as I showed above, but it further
> > confuses the trace2 output, because now we have the child yes (or its
> > shell equivalent) exiting as well.
> > [...]
> 
> I think it also probably doesn't test what the patch adding these tests
> was interested in. Specifically, it's trying to check the case of
> reporting the pager exit code while we're in a signal handler. So we
> have to get the SIGPIPE in the main git process to trigger that. Which
> means it has to be a builtin.
> 
> So you really do need a builtin that produces infinite output. Or at the
> very least, enough that we expect it to fill any possible OS pipe
> buffer. I guess the latter is actually not that hard. A 1MB
> commit-message would be plenty (or if you prefer, a big file with "log
> -p").

That's actually pretty easy to do. So I came up with the patch below, in
the interests of wrapping up this thread.

I'm not 100% sure this fixes any possible races, as the race Junio
initially reported seemed to be in the "propagated signals from pager"
test, which I don't think has these flaky-SIGPIPE problems. But I think
it's at least correcting some of the confusion. And we can see if it
happens again (I haven't been able to trigger any failures with --stress
myself).

-- >8 --
Subject: [PATCH] t7006: clean up SIGPIPE handling in trace2 tests

Comit c24b7f6736 (pager: test for exit code with and without SIGPIPE,
2021-02-02) introduced some tests that don't reliably generate SIGPIPE
where we expect it (i.e., when our pager doesn't read all of the output
from git-log).

There are two problems that somewhat cancel each other out.

First is that the output of git-log isn't very large (only around 800
bytes). So even if the pager doesn't read all of our output, it's racy
whether or not we'll actually get a SIGPIPE (we won't if we write all of
the output into the pipe buffer before the pager exits).

But we wrap git-log with test_terminal, which is supposed to propagate
the exit status of git-log. However, it doesn't always do so;
test_terminal will copy to stdout any lines that it got from our fake
pager, and it pipes to an empty command. So most of the time we are
seeing a SIGPIPE from test_terminal itself (though this is likewise
racy).

Let's try to make this more robust in two ways:

  1. We'll put a commit with a huge message at the tip of history. Since
     this is over a megabyte, it should fill the OS pipe buffer
     completely, causing git-log to keep trying to write even after the
     pager has exited.

  2. We'll redirect the output of test_terminal to /dev/null. That means
     it can never get SIGPIPE itself, and will always be giving us the
     exit code from git-log.

These two changes reveal that one of the tests was looking for the wrong
behavior. If we try to start a pager that does not exist (according to
execve()), then the error propagates from start_command() back to the
pager code as an error, and we avoid redirecting git-log's stdout to the
broken pager entirely.  Instead, it goes straight to the original stdout
(test_terminal's pty in this case), and we do not see a SIGPIPE at all.

So the test "git attempts to page to nonexisting pager command, gets
SIGPIPE" is checking the wrong outcome; it should be looking for a
successful exit (and was only confused by test_terminal's SIGPIPE).

There's a related test, "git discards nonexisting pager without
SIGPIPE", which sets the pager to a shell command which will read all
input and _then_ run a non-existing command. But that doesn't trigger
the same execve() behavior. We really do run the shell there and
redirect git-log's stdout to it. And the fact that the shell then exits
127 is not interesting. It is not different at that point than the
earlier test to check for "exit 1". So we can drop that test entirely.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7006-pager.sh | 42 ++++++++++++++----------------------------
 1 file changed, 14 insertions(+), 28 deletions(-)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 0e7cf75435..577e51b47a 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -661,6 +661,13 @@ test_expect_success 'setup trace2' '
 	export GIT_TRACE2_BRIEF
 '
 
+test_expect_success 'setup large log output' '
+	perl -e "
+		print \"this is a long commit message\" x 50000
+	" >commit-msg &&
+	git commit --allow-empty -F commit-msg
+'
+
 test_expect_success TTY 'git returns SIGPIPE on early pager exit' '
 	test_when_finished "rm pager-used trace.normal" &&
 	test_config core.pager ">pager-used; head -n 1; exit 0" &&
@@ -670,7 +677,7 @@ test_expect_success TTY 'git returns SIGPIPE on early pager exit' '
 
 	if test_have_prereq !MINGW
 	then
-		OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
+		OUT=$( ((test_terminal git log; echo $? 1>&3) >/dev/null) 3>&1 ) &&
 		test_match_signal 13 "$OUT"
 	else
 		test_terminal git log
@@ -691,7 +698,7 @@ test_expect_success TTY 'git returns SIGPIPE on early pager non-zero exit' '
 
 	if test_have_prereq !MINGW
 	then
-		OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
+		OUT=$( ((test_terminal git log; echo $? 1>&3) >/dev/null) 3>&1 ) &&
 		test_match_signal 13 "$OUT"
 	else
 		test_terminal git log
@@ -712,7 +719,7 @@ test_expect_success TTY 'git discards pager non-zero exit without SIGPIPE' '
 
 	if test_have_prereq !MINGW
 	then
-		OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
+		OUT=$( ((test_terminal git log; echo $? 1>&3) >/dev/null) 3>&1 ) &&
 		test "$OUT" -eq 0
 	else
 		test_terminal git log
@@ -724,28 +731,7 @@ test_expect_success TTY 'git discards pager non-zero exit without SIGPIPE' '
 	test_path_is_file pager-used
 '
 
-test_expect_success TTY 'git discards nonexisting pager without SIGPIPE' '
-	test_when_finished "rm pager-used trace.normal" &&
-	test_config core.pager "wc >pager-used; does-not-exist" &&
-	GIT_TRACE2="$(pwd)/trace.normal" &&
-	export GIT_TRACE2 &&
-	test_when_finished "unset GIT_TRACE2" &&
-
-	if test_have_prereq !MINGW
-	then
-		OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
-		test "$OUT" -eq 0
-	else
-		test_terminal git log
-	fi &&
-
-	grep child_exit trace.normal >child-exits &&
-	test_line_count = 1 child-exits &&
-	grep " code:127 " child-exits &&
-	test_path_is_file pager-used
-'
-
-test_expect_success TTY 'git attempts to page to nonexisting pager command, gets SIGPIPE' '
+test_expect_success TTY 'git skips paging nonexisting command' '
 	test_when_finished "rm trace.normal" &&
 	test_config core.pager "does-not-exist" &&
 	GIT_TRACE2="$(pwd)/trace.normal" &&
@@ -754,8 +740,8 @@ test_expect_success TTY 'git attempts to page to nonexisting pager command, gets
 
 	if test_have_prereq !MINGW
 	then
-		OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
-		test_match_signal 13 "$OUT"
+		OUT=$( ((test_terminal git log; echo $? 1>&3) >/dev/null) 3>&1 ) &&
+		test "$OUT" -eq 0
 	else
 		test_terminal git log
 	fi &&
@@ -774,7 +760,7 @@ test_expect_success TTY 'git returns SIGPIPE on propagated signals from pager' '
 
 	if test_have_prereq !MINGW
 	then
-		OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
+		OUT=$( ((test_terminal git log; echo $? 1>&3) >/dev/null) 3>&1 ) &&
 		test_match_signal 13 "$OUT"
 	else
 		test_terminal git log
-- 
2.34.0.636.g3d595567a1

