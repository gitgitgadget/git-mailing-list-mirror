Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D51C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 21:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhKVVbf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 16:31:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:36708 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229502AbhKVVbc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 16:31:32 -0500
Received: (qmail 22347 invoked by uid 109); 22 Nov 2021 21:28:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Nov 2021 21:28:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25716 invoked by uid 111); 22 Nov 2021 21:28:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Nov 2021 16:28:14 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 22 Nov 2021 16:28:13 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH] run-command: unify signal and regular logic for
 wait_or_whine()
Message-ID: <YZwLbV/9GWZ8LsGf@coredump.intra.peff.net>
References: <xmqq1r4b8ezp.fsf@gitster.g>
 <20211024170349.GA2101@szeder.dev>
 <YZqSgu4XjPWnURju@coredump.intra.peff.net>
 <YZrCmPb5AIW8YYQ0@coredump.intra.peff.net>
 <YZrOLy03s5ZWMQ+t@coredump.intra.peff.net>
 <xmqqa6hxlysf.fsf@gitster.g>
 <YZsh6mnjuKbbIrw8@coredump.intra.peff.net>
 <YZsih3ar+g1ZTZOc@coredump.intra.peff.net>
 <xmqq5yskn3ir.fsf@gitster.g>
 <YZvrVj8w8j2Fb14O@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YZvrVj8w8j2Fb14O@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 22, 2021 at 02:11:18PM -0500, Jeff King wrote:

> On Sun, Nov 21, 2021 at 09:49:32PM -0800, Junio C Hamano wrote:
> 
> > > That's a lot more tedious "if (!in_signal)" checks, but:
> > >
> > >   - we don't have to duplicate any of the actual application logic
> > >
> > >   - we'd now cover the extra cases for waitpid failing or returning the
> > >     wrong pid (previously if waitpid() failed we'd still look at status,
> > >     which could contain complete garbage!)
> > 
> > Yeah, the repeated "if (!in_signal)" look a bit ugly, but fixing
> > that "we only deal with ifexited in in_signal case" to do the right
> > thing would make the code even more annoying and harder to maintain.
> 
> OK. Let me see if I can clean this up into a full series that actually
> fixes the race you saw, and breaks down the other fixes a bit more.

Hmm. So I had thought to maybe split apart the earlier patches and
interweave this one at the right spot. But really there is a mutual
dependency in the test fixes: fixing the SIGPIPE issue means that this
will start to fail (but only sometimes, if /bin/sh is bash!), but fixing
the "exec" thing means it is only testing something sometimes (because
of the pipe raciness).

So I ended up doing this as just a separate preparatory fix, which is in
the patch below. I see you picked up the earlier diff as
jk/pager-exit-fix.  This one gives much more explanation, and adjusts
the test to actually cover this case. It can be applied directly on top
of ab/pager-exit-log, replacing what's in jk/pager-exit-fix.

And then I'd apply the other two (which are currently in
jk/t7006-sigpipe-tests-fix) directly on top of that. IMHO it should all
just be a single series that graduates together, but we could do the
other test fixups separately (they are fixing races, but I think the
races err on the side of the tests doing nothing, not failing
erroneously).

-- >8 --
Subject: run-command: unify signal and regular logic for wait_or_whine()

Since 507d7804c0 (pager: don't use unsafe functions in signal handlers,
2015-09-04), we have a separate code path in wait_or_whine() for the
case that we're in a signal handler. But that code path misses some of
the cases handled by the main logic.

This was improved in be8fc53e36 (pager: properly log pager exit code
when signalled, 2021-02-02), but that covered only case: actually
returning the correct error code. But there are some other cases:

  - if waitpid() returns failure, we wouldn't notice and would look at
    uninitialized garbage in the status variable; it's not clear if it's
    possible to trigger this or not

  - if the process exited by signal, then we would still report "-1"
    rather than the correct signal code

This latter case even had a test added in be8fc53e36, but it doesn't
work reliably. It sets the pager command to:

  >pager-used; test-tool sigchain

The latter command will die by signal, but because there are multiple
commands, there will be a shell in between. And it's the shell whose
waitpid() call will see the signal death, and it will then exit with
code 143, which is what Git will see.

To make matters even more confusing, some shells (such as bash) will
realize that there's nothing for the shell to do after test-tool
finishes, and will turn it into an exec. So the test was only checking
what it thought when /bin/sh points to a shell like bash (we're relying
on the shell used internally by Git to spawn sub-commands here, so even
running the test under bash would not be enough).

This patch adjusts the tests to explicitly call "exec" in the pager
command, which produces a consistent outcome regardless of shell. Note
that without the code change in this patch it _should_ fail reliably,
but doesn't. That test, like its siblings, tries to trigger SIGPIPE in
the git-log process writing to the pager, but only do so racily. That
will be fixed in a follow-on patch.

For the code change here, we have two options:

  - we can teach the in_signal code to handle WIFSIGNALED()

  - we can stop returning early when in_signal is set, and instead
    annotate individual calls that we need to skip in this case

The former is a simpler patch, but means we're essentially duplicating
all of the logic. So instead I went with the latter. The result is a
bigger patch, and we do run the risk of new code being added but
forgetting to handle in_signal. But in the long run it seems more
maintainable.

I've skipped any non-trivial calls for the in_signal case, like calling
error(). We'll also skip the call to clear_child_for_cleanup(), as we
were before. This is arguably the wrong thing to do, since we wouldn't
want to try to clean it up again. But:

  - we can't call it as-is, because it calls free(), which we must avoid
    in a signal handler (we'd have to pass in_signal so it can skip the
    free() call)

  - we'll only go through the list of children to clean once, since our
    cleanup_children_on_signal() handler pops itself after running (and
    then re-raises, so eventually we'd just exit). So this cleanup only
    matters if a process is on the cleanup list _and_ it has a separate
    handler to clean itself up. Which is questionable in the first place
    (and AFAIK we do not do).

  - double-cleanup isn't actually that bad anyway. waitpid() will just
    return an error, which we won't even report because of in_signal.

Signed-off-by: Jeff King <peff@peff.net>
---
 run-command.c    | 19 +++++++++----------
 t/t7006-pager.sh |  2 +-
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/run-command.c b/run-command.c
index 509841bf27..350593928d 100644
--- a/run-command.c
+++ b/run-command.c
@@ -551,20 +551,17 @@ static int wait_or_whine(pid_t pid, const char *argv0, int in_signal)
 
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
@@ -575,10 +572,12 @@ static int wait_or_whine(pid_t pid, const char *argv0, int in_signal)
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
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 0e7cf75435..032bde278e 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -767,7 +767,7 @@ test_expect_success TTY 'git attempts to page to nonexisting pager command, gets
 
 test_expect_success TTY 'git returns SIGPIPE on propagated signals from pager' '
 	test_when_finished "rm pager-used trace.normal" &&
-	test_config core.pager ">pager-used; test-tool sigchain" &&
+	test_config core.pager ">pager-used; exec test-tool sigchain" &&
 	GIT_TRACE2="$(pwd)/trace.normal" &&
 	export GIT_TRACE2 &&
 	test_when_finished "unset GIT_TRACE2" &&
-- 
2.34.0.639.g83a0ed08a8

