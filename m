Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF14C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 04:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbhKVEzB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Nov 2021 23:55:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:36034 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231656AbhKVEzB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Nov 2021 23:55:01 -0500
Received: (qmail 18568 invoked by uid 109); 22 Nov 2021 04:51:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Nov 2021 04:51:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9573 invoked by uid 111); 22 Nov 2021 04:51:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 21 Nov 2021 23:51:56 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 21 Nov 2021 23:51:54 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] t7006: clean up SIGPIPE handling in trace2 tests
Message-ID: <YZsh6mnjuKbbIrw8@coredump.intra.peff.net>
References: <xmqq1r4b8ezp.fsf@gitster.g>
 <20211024170349.GA2101@szeder.dev>
 <YZqSgu4XjPWnURju@coredump.intra.peff.net>
 <YZrCmPb5AIW8YYQ0@coredump.intra.peff.net>
 <YZrOLy03s5ZWMQ+t@coredump.intra.peff.net>
 <xmqqa6hxlysf.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa6hxlysf.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 21, 2021 at 06:17:04PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'm not 100% sure this fixes any possible races, as the race Junio
> > initially reported seemed to be in the "propagated signals from pager"
> > test, which I don't think has these flaky-SIGPIPE problems. But I think
> > it's at least correcting some of the confusion. And we can see if it
> > happens again (I haven't been able to trigger any failures with --stress
> > myself).
> 
> Applying this (or this and the follow-up) seems to make t7006, which
> used to be flaky, to consistently fail at test "git returns SIGPIPE
> on propagated signals from pager" for me ;-)

Well, I guess it's good that we made things more consistent. :) It is
curious that you get failures and I don't, though. I wonder what the
difference is.

One curiosity is that the test does this:

	test_config core.pager ">pager-used; test-tool sigchain"

While "test-tool sigchain" will die with SIGTERM, it's the shell itself
which will waitpid() on it. And so in the end, what Git will generally
see is the same as if the shell had done "exit 143".

I wonder if the difference is between our shells. I know from previous
experience that bash will sometimes directly exec the final command in a
"-c" command, as an optimization. I don't get any difference running the
test with dash or bash, but that makes sense; the pager command is run
internally by Git via "sh -c".

Aha, that's it. If I recompile with SHELL_PATH=/bin/bash, then I see a
failure. Likewise, if I change the test like this:

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 851961c798..a87ef37803 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -741,7 +741,7 @@ test_expect_success TTY 'git skips paging nonexisting command' '
 
 test_expect_success TTY 'git returns SIGPIPE on propagated signals from pager' '
 	test_when_finished "rm pager-used trace.normal" &&
-	test_config core.pager ">pager-used; test-tool sigchain" &&
+	test_config core.pager ">pager-used; exec test-tool sigchain" &&
 	GIT_TRACE2="$(pwd)/trace.normal" &&
 	export GIT_TRACE2 &&
 	test_when_finished "unset GIT_TRACE2" &&

then it fails even with dash. And that is, I think, closer to what the
test was actually trying to cover (since checking a shell's "exit 143"
is really no different than "exit 1", and we checked that earlier).

So why is it failing? It looks like trace2 reports this as code "-1"
rather than 143. I think that is because the fix from be8fc53e36 (pager:
properly log pager exit code when signalled, 2021-02-02) is incomplete.
It sets WEXITSTATUS() if the pager exited, but it doesn't handle signal
death at all. I think it needs:

diff --git a/run-command.c b/run-command.c
index f40df01c77..ef9d1d4236 100644
--- a/run-command.c
+++ b/run-command.c
@@ -555,6 +555,8 @@ static int wait_or_whine(pid_t pid, const char *argv0, int in_signal)
 	if (in_signal) {
 		if (WIFEXITED(status))
 			code = WEXITSTATUS(status);
+		else if (WIFSIGNALED(status))
+			code = 128 + WTERMSIG(status); /* see comment below */
 		return code;
 	}
 

-Peff
