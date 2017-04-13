Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DDFE20960
	for <e@80x24.org>; Thu, 13 Apr 2017 21:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751205AbdDMVOa (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 17:14:30 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:39620 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751083AbdDMVO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 17:14:29 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 71B1220960;
        Thu, 13 Apr 2017 21:14:28 +0000 (UTC)
Date:   Thu, 13 Apr 2017 21:14:28 +0000
From:   Eric Wong <e@80x24.org>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: [PATCH 7/6] run-command: block signals between fork and execve
Message-ID: <20170413211428.GA5961@whir>
References: <20170410234919.34586-1-bmwill@google.com>
 <20170413183252.4713-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170413183252.4713-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> wrote:
> v2 does a bit of restructuring based on comments from reviewers.  I took the
> patch by Eric and broke it up and tweaked it a bit to flow better with v2.  I
> left out the part of Eric's patch which did signal manipulation as I wasn't
> experienced enough to know what it was doing or why it was necessary.  Though I
> believe the code is structured in such a way that Eric could make another patch
> on top of this series with just the signal changes.

Yeah, I think a separate commit message might be necessary to
explain the signal changes.

-------8<-----
Subject: [PATCH] run-command: block signals between fork and execve

Signal handlers of the parent firing in the forked child may
have unintended side effects.  Rather than auditing every signal
handler we have and will ever have, block signals while forking
and restore default signal handlers in the child before execve.

Restoring default signal handlers is required because
execve does not unblock signals, it only restores default
signal handlers.  So we must restore them with sigprocmask
before execve, leaving a window when signal handlers
we control can fire in the child.  Continue ignoring
ignored signals, but reset the rest to defaults.

Similarly, disable pthread cancellation to future-proof our code
in case we start using cancellation; as cancellation is
implemented with signals in glibc.

Signed-off-by: Eric Wong <e@80x24.org>
---
  Changes from my original in <20170411070534.GA10552@whir>:

  - fixed typo in NO_PTHREADS code

  - dropped fflush(NULL) before fork, consider us screwed anyways
    if the child uses stdio

  - respect SIG_IGN in child; that seems to be the prevailing
    wisdom from reading https://ewontfix.com/7/ and process.c
    in ruby (git clone https://github.com/ruby/ruby.git)

 run-command.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/run-command.c b/run-command.c
index 1c36e692d..59a8b4806 100644
--- a/run-command.c
+++ b/run-command.c
@@ -213,6 +213,7 @@ static int child_notifier = -1;
 
 enum child_errcode {
 	CHILD_ERR_CHDIR,
+	CHILD_ERR_SIGPROCMASK,
 	CHILD_ERR_ENOENT,
 	CHILD_ERR_SILENT,
 	CHILD_ERR_ERRNO,
@@ -277,6 +278,8 @@ static void child_err_spew(struct child_process *cmd, struct child_err *cerr)
 		error_errno("exec '%s': cd to '%s' failed",
 			    cmd->argv[0], cmd->dir);
 		break;
+	case CHILD_ERR_SIGPROCMASK:
+		error_errno("sigprocmask failed restoring signals");
 	case CHILD_ERR_ENOENT:
 		error_errno("cannot run %s", cmd->argv[0]);
 		break;
@@ -388,6 +391,53 @@ static char **prep_childenv(const char *const *deltaenv)
 }
 #endif
 
+struct atfork_state {
+#ifndef NO_PTHREADS
+	int cs;
+#endif
+	sigset_t old;
+};
+
+#ifndef NO_PTHREADS
+static void bug_die(int err, const char *msg)
+{
+	if (err) {
+		errno = err;
+		die_errno("BUG: %s", msg);
+	}
+}
+#endif
+
+static void atfork_prepare(struct atfork_state *as)
+{
+	sigset_t all;
+
+	if (sigfillset(&all))
+		die_errno("sigfillset");
+#ifdef NO_PTHREADS
+	if (sigprocmask(SIG_SETMASK, &all, &as->old))
+		die_errno("sigprocmask");
+#else
+	bug_die(pthread_sigmask(SIG_SETMASK, &all, &as->old),
+		"blocking all signals");
+	bug_die(pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &as->cs),
+		"disabling cancellation");
+#endif
+}
+
+static void atfork_parent(struct atfork_state *as)
+{
+#ifdef NO_PTHREADS
+	if (sigprocmask(SIG_SETMASK, &as->old, NULL))
+		die_errno("sigprocmask");
+#else
+	bug_die(pthread_setcancelstate(as->cs, NULL),
+		"re-enabling cancellation");
+	bug_die(pthread_sigmask(SIG_SETMASK, &as->old, NULL),
+		"restoring signal mask");
+#endif
+}
+
 static inline void set_cloexec(int fd)
 {
 	int flags = fcntl(fd, F_GETFD);
@@ -511,6 +561,7 @@ int start_command(struct child_process *cmd)
 	char **childenv;
 	struct argv_array argv = ARGV_ARRAY_INIT;
 	struct child_err cerr;
+	struct atfork_state as;
 
 	if (pipe(notify_pipe))
 		notify_pipe[0] = notify_pipe[1] = -1;
@@ -524,6 +575,7 @@ int start_command(struct child_process *cmd)
 
 	prepare_cmd(&argv, cmd);
 	childenv = prep_childenv(cmd->env);
+	atfork_prepare(&as);
 
 	/*
 	 * NOTE: In order to prevent deadlocking when using threads special
@@ -537,6 +589,7 @@ int start_command(struct child_process *cmd)
 	cmd->pid = fork();
 	failed_errno = errno;
 	if (!cmd->pid) {
+		int sig;
 		/*
 		 * Ensure the default die/error/warn routines do not get
 		 * called, they can take stdio locks and malloc.
@@ -584,6 +637,21 @@ int start_command(struct child_process *cmd)
 		if (cmd->dir && chdir(cmd->dir))
 			child_die(CHILD_ERR_CHDIR);
 
+		/*
+		 * restore default signal handlers here, in case
+		 * we catch a signal right before execve below
+		 */
+		for (sig = 1; sig < NSIG; sig++) {
+			sighandler_t old = signal(sig, SIG_DFL);
+
+			/* ignored signals get reset to SIG_DFL on execve */
+			if (old == SIG_IGN)
+				signal(sig, SIG_IGN);
+		}
+
+		if (sigprocmask(SIG_SETMASK, &as.old, NULL) != 0)
+			child_die(CHILD_ERR_SIGPROCMASK);
+
 		execve(argv.argv[0], (char *const *) argv.argv,
 		       (char *const *) childenv);
 
@@ -595,6 +663,7 @@ int start_command(struct child_process *cmd)
 			child_die(CHILD_ERR_ERRNO);
 		}
 	}
+	atfork_parent(&as);
 	if (cmd->pid < 0)
 		error_errno("cannot fork() for %s", cmd->argv[0]);
 	else if (cmd->clean_on_exit)
-- 
EW
