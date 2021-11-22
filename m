Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA570C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 04:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhKVE5i (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Nov 2021 23:57:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:36046 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231656AbhKVE5i (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Nov 2021 23:57:38 -0500
Received: (qmail 18582 invoked by uid 109); 22 Nov 2021 04:54:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Nov 2021 04:54:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9588 invoked by uid 111); 22 Nov 2021 04:54:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 21 Nov 2021 23:54:33 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 21 Nov 2021 23:54:31 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] t7006: clean up SIGPIPE handling in trace2 tests
Message-ID: <YZsih3ar+g1ZTZOc@coredump.intra.peff.net>
References: <xmqq1r4b8ezp.fsf@gitster.g>
 <20211024170349.GA2101@szeder.dev>
 <YZqSgu4XjPWnURju@coredump.intra.peff.net>
 <YZrCmPb5AIW8YYQ0@coredump.intra.peff.net>
 <YZrOLy03s5ZWMQ+t@coredump.intra.peff.net>
 <xmqqa6hxlysf.fsf@gitster.g>
 <YZsh6mnjuKbbIrw8@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YZsh6mnjuKbbIrw8@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 21, 2021 at 11:51:54PM -0500, Jeff King wrote:

> So why is it failing? It looks like trace2 reports this as code "-1"
> rather than 143. I think that is because the fix from be8fc53e36 (pager:
> properly log pager exit code when signalled, 2021-02-02) is incomplete.
> It sets WEXITSTATUS() if the pager exited, but it doesn't handle signal
> death at all. I think it needs:
> 
> diff --git a/run-command.c b/run-command.c
> index f40df01c77..ef9d1d4236 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -555,6 +555,8 @@ static int wait_or_whine(pid_t pid, const char *argv0, int in_signal)
>  	if (in_signal) {
>  		if (WIFEXITED(status))
>  			code = WEXITSTATUS(status);
> +		else if (WIFSIGNALED(status))
> +			code = 128 + WTERMSIG(status); /* see comment below */
>  		return code;
>  	}

I'm tempted to say that this would be clearer if the in_signal code path
just followed the main logic, like this:

diff --git a/run-command.c b/run-command.c
index f40df01c77..1f58c17b6c 100644
--- a/run-command.c
+++ b/run-command.c
@@ -552,20 +552,17 @@ static int wait_or_whine(pid_t pid, const char *argv0, int in_signal)
 
 	while ((waiting = waitpid(pid, &status, 0)) < 0 && errno == EINTR)
 		;	/* nothing */
-	if (in_signal) {
-		if (WIFEXITED(status))
-			code = WEXITSTATUS(status);
-		return code;
-	}
 
 	if (waiting < 0) {
 		failed_errno = errno;
-		error_errno("waitpid for %s failed", argv0);
+		if (!in_signal)
+			error_errno("waitpid for %s failed", argv0);
 	} else if (waiting != pid) {
-		error("waitpid is confused (%s)", argv0);
+		if (!in_signal)
+			error("waitpid is confused (%s)", argv0);
 	} else if (WIFSIGNALED(status)) {
 		code = WTERMSIG(status);
-		if (code != SIGINT && code != SIGQUIT && code != SIGPIPE)
+		if (!in_signal && code != SIGINT && code != SIGQUIT && code != SIGPIPE)
 			error("%s died of signal %d", argv0, code);
 		/*
 		 * This return value is chosen so that code & 0xff
@@ -576,10 +573,12 @@ static int wait_or_whine(pid_t pid, const char *argv0, int in_signal)
 	} else if (WIFEXITED(status)) {
 		code = WEXITSTATUS(status);
 	} else {
-		error("waitpid is confused (%s)", argv0);
+		if (!in_signal)
+			error("waitpid is confused (%s)", argv0);
 	}
 
-	clear_child_for_cleanup(pid);
+	if (!in_signal)
+		clear_child_for_cleanup(pid);
 
 	errno = failed_errno;
 	return code;

That's a lot more tedious "if (!in_signal)" checks, but:

  - we don't have to duplicate any of the actual application logic

  - we'd now cover the extra cases for waitpid failing or returning the
    wrong pid (previously if waitpid() failed we'd still look at status,
    which could contain complete garbage!)

-Peff
