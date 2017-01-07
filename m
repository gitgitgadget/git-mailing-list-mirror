Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 329501FEB3
	for <e@80x24.org>; Sat,  7 Jan 2017 01:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161211AbdAGBW1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 20:22:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:36311 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935564AbdAGBWZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 20:22:25 -0500
Received: (qmail 29891 invoked by uid 109); 7 Jan 2017 01:22:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 07 Jan 2017 01:22:25 +0000
Received: (qmail 22044 invoked by uid 111); 7 Jan 2017 01:23:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Jan 2017 20:23:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Jan 2017 20:22:23 -0500
Date:   Fri, 6 Jan 2017 20:22:23 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Trygve Aaberge <trygveaa@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: [PATCH 3/3] execv_dashed_external: wait for child on signal death
Message-ID: <20170107012223.c27toqr6ck44kfpj@sigill.intra.peff.net>
References: <20170107011445.3e4fv6vdtimrwhgv@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170107011445.3e4fv6vdtimrwhgv@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When you hit ^C to interrupt a git command going to a pager,
this usually leaves the pager running. But when a dashed
external is in use, the pager ends up in a funny state and
quits (but only after eating one more character from the
terminal!). This fixes it.

Explaining the reason will require a little background.

When git runs a pager, it's important for the git process to
hang around and wait for the pager to finish, even though it
has no more data to feed it. This is because git spawns the
pager as a child, and thus the git process is the session
leader on the terminal. After it dies, the pager will finish
its current read from the terminal (eating the one
character), and then get EIO trying to read again.

When you hit ^C, that sends SIGINT to git and to the pager,
and it's a similar situation.  The pager ignores it, but the
git process needs to hang around until the pager is done. We
addressed that long ago in a3da882120 (pager: do
wait_for_pager on signal death, 2009-01-22).

But when you have a dashed external (or an alias pointing to
a builtin, which will re-exec git for the builtin), there's
an extra process in the mix. For instance, running:

  git -c alias.l=log log

will end up with a process tree like:

  git (parent)
    \
     git-log (child)
      \
       less (pager)

If you hit ^C, SIGINT goes to all of them. The pager ignores
it, and the child git process will end up in wait_for_pager().
But the parent git process will die, and the usual EIO
trouble happens.

So we really want the parent git process to wait_for_pager(),
but of course it doesn't know anything about the pager at
all, since it was started by the child.  However, we can
have it wait on the git-log child, which in turn is waiting
on the pager. And that's what this patch does.

There are a few design decisions here worth explaining:

  1. The new feature is attached to run-command's
     clean_on_exit feature. Partly this is convenience,
     since that feature already has a signal handler that
     deals with child cleanup.

     But it's also a meaningful connection. The main reason
     that dashed externals use clean_on_exit is to bind the
     two processes together. If somebody kills the parent
     with a signal, we propagate that to the child (in this
     instance with SIGINT, we do propagate but it doesn't
     matter because the original signal went to the whole
     process group). Likewise, we do not want the parent
     to go away until the child has done so.

     In a traditional Unix world, we'd probably accomplish
     this binding by just having the parent execve() the
     child directly. But since that doesn't work on Windows,
     everything goes through run_command's more spawn-like
     interface.

  2. We do _not_ automatically waitpid() on any
     clean_on_exit children. For dashed externals this makes
     sense; we know that the parent is doing nothing but
     waiting for the child to exit anyway. But with other
     children, it's possible that the child, after getting
     the signal, could be waiting on the parent to do
     something (like closing a descriptor). If we were to
     wait on such a child, we'd end up in a deadlock. So
     this errs on the side of caution, and lets callers
     enable the feature explicitly.

  3. When we send children the cleanup signal, we send all
     the signals first, before waiting on any children. This
     is to avoid the case where one child might be waiting
     on another one to exit, causing a deadlock. We inform
     all of them that it's time to die before reaping any.

     In practice, there is only ever one dashed external run
     from a given process, so this doesn't matter much now.
     But it future-proofs us if other callers start using
     the wait_after_clean mechanism.

There's no automated test here, because it would end up racy
and unportable. But it's easy to reproduce the situation by
running the log command given above and hitting ^C.

Signed-off-by: Jeff King <peff@peff.net>
---
 git.c         |  1 +
 run-command.c | 19 +++++++++++++++++++
 run-command.h |  1 +
 3 files changed, 21 insertions(+)

diff --git a/git.c b/git.c
index bc2f2a7ec9..c8fe6637df 100644
--- a/git.c
+++ b/git.c
@@ -588,6 +588,7 @@ static void execv_dashed_external(const char **argv)
 	argv_array_pushf(&cmd.args, "git-%s", argv[0]);
 	argv_array_pushv(&cmd.args, argv + 1);
 	cmd.clean_on_exit = 1;
+	cmd.wait_after_clean = 1;
 	cmd.silent_exec_failure = 1;
 
 	trace_argv_printf(cmd.args.argv, "trace: exec:");
diff --git a/run-command.c b/run-command.c
index ca905a9e80..73bfba7ef9 100644
--- a/run-command.c
+++ b/run-command.c
@@ -29,6 +29,8 @@ static int installed_child_cleanup_handler;
 
 static void cleanup_children(int sig, int in_signal)
 {
+	struct child_to_clean *children_to_wait_for = NULL;
+
 	while (children_to_clean) {
 		struct child_to_clean *p = children_to_clean;
 		children_to_clean = p->next;
@@ -45,6 +47,23 @@ static void cleanup_children(int sig, int in_signal)
 		}
 
 		kill(p->pid, sig);
+
+		if (p->process->wait_after_clean) {
+			p->next = children_to_wait_for;
+			children_to_wait_for = p;
+		} else {
+			if (!in_signal)
+				free(p);
+		}
+	}
+
+	while (children_to_wait_for) {
+		struct child_to_clean *p = children_to_wait_for;
+		children_to_wait_for = p->next;
+
+		while (waitpid(p->pid, NULL, 0) < 0 && errno == EINTR)
+			; /* spin waiting for process exit or error */
+
 		if (!in_signal)
 			free(p);
 	}
diff --git a/run-command.h b/run-command.h
index dd1c78c28d..4fa8f65adb 100644
--- a/run-command.h
+++ b/run-command.h
@@ -43,6 +43,7 @@ struct child_process {
 	unsigned stdout_to_stderr:1;
 	unsigned use_shell:1;
 	unsigned clean_on_exit:1;
+	unsigned wait_after_clean:1;
 	void (*clean_on_exit_handler)(struct child_process *process);
 	void *clean_on_exit_handler_cbdata;
 };
-- 
2.11.0.527.gfef230ca76
