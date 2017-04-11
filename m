Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5484C1FAFB
	for <e@80x24.org>; Tue, 11 Apr 2017 07:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753714AbdDKHFg (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 03:05:36 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47318 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753224AbdDKHFf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 03:05:35 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 01B6A1FAFB;
        Tue, 11 Apr 2017 07:05:34 +0000 (UTC)
Date:   Tue, 11 Apr 2017 07:05:34 +0000
From:   Eric Wong <e@80x24.org>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 6/5] run-command: avoid potential dangers in forked child
Message-ID: <20170411070534.GA10552@whir>
References: <20170410234919.34586-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170410234919.34586-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brandon, this series tickles an old itch of mine, so I
started working off of it.  I'm only somewhat concerned
with the path resolution in execvp(e) pontentially calling
malloc on some libcs; but I suppose that's a separate patch
for another time.

Only lightly-tested at the moment, but things seem to work...

------8<-----
Subject: [PATCH] run-command: avoid potential dangers in forked child

All of our standard error handling paths have the potential to
call malloc or take stdio locks; so we must avoid them inside
the forked child.

Instead, the child only writes an 8 byte struct atomically to
the parent through the notification pipe to propagate an error.
All user-visible error reporting happens from the parent;
even avoiding functions like atexit(3) and exit(3).

Finally, we block signals and disable pthreads cancellation to
avoid nasty surprises from other threads and signal handlers
firing inside the child.

This prepares us for eventual use of vfork, where the child and
parent share heap until the child calls execve or _exit.

The only somewhat questionable part I see left is the PATH
searching in execvpe; which could be performed in the parent
(taking into account chdir usage).

Signed-off-by: Eric Wong <e@80x24.org>
---
 run-command.c | 273 +++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 196 insertions(+), 77 deletions(-)

diff --git a/run-command.c b/run-command.c
index 2b3249de4..3d7a57385 100644
--- a/run-command.c
+++ b/run-command.c
@@ -117,55 +117,35 @@ static inline void close_pair(int fd[2])
 	close(fd[1]);
 }
 
-#ifndef GIT_WINDOWS_NATIVE
-static inline void dup_devnull(int to)
-{
-	int fd = open("/dev/null", O_RDWR);
-	if (fd < 0)
-		die_errno(_("open /dev/null failed"));
-	if (dup2(fd, to) < 0)
-		die_errno(_("dup2(%d,%d) failed"), fd, to);
-	close(fd);
-}
-#endif
-
-static char *locate_in_PATH(const char *file)
+static int exists_in_PATH(const char *file)
 {
 	const char *p = getenv("PATH");
-	struct strbuf buf = STRBUF_INIT;
+	char buf[PATH_MAX];
 
 	if (!p || !*p)
-		return NULL;
+		return 0;
 
 	while (1) {
 		const char *end = strchrnul(p, ':');
-
-		strbuf_reset(&buf);
+		char *dst = buf;
 
 		/* POSIX specifies an empty entry as the current directory. */
 		if (end != p) {
-			strbuf_add(&buf, p, end - p);
-			strbuf_addch(&buf, '/');
+			memcpy(dst, p, end - p);
+			dst += end - p;
+			*dst++ = '/';
 		}
-		strbuf_addstr(&buf, file);
+		strcpy(dst, file);
 
-		if (!access(buf.buf, F_OK))
-			return strbuf_detach(&buf, NULL);
+		if (!access(buf, F_OK))
+			return 1;
 
 		if (!*end)
 			break;
 		p = end + 1;
 	}
 
-	strbuf_release(&buf);
-	return NULL;
-}
-
-static int exists_in_PATH(const char *file)
-{
-	char *r = locate_in_PATH(file);
-	free(r);
-	return r != NULL;
+	return 0;
 }
 
 int sane_execvpe(const char *file, char * const argv[], char *const envp[])
@@ -227,16 +207,145 @@ static const char **prepare_shell_cmd(struct argv_array *out, const char **argv)
 
 #ifndef GIT_WINDOWS_NATIVE
 static int child_notifier = -1;
+enum child_errcode {
+	CHILD_ERR_NULL_STDIN,
+	CHILD_ERR_NULL_STDOUT,
+	CHILD_ERR_NULL_STDERR,
+	CHILD_ERR_CHDIR,
+	CHILD_ERR_SIGPROCMASK,
+	CHILD_ERR_ENOENT,
+	CHILD_ERR_ENOENT_SILENT,
+	CHILD_ERR_ERRNO,
+};
+
+struct child_err {
+	enum child_errcode err;
+	int syserr; /* errno */
+};
 
-static void notify_parent(void)
+static void child_die(enum child_errcode err)
 {
-	/*
-	 * execvp failed.  If possible, we'd like to let start_command
-	 * know, so failures like ENOENT can be handled right away; but
-	 * otherwise, finish_command will still report the error.
-	 */
-	xwrite(child_notifier, "", 1);
+	struct child_err buf;
+
+	buf.err = err;
+	buf.syserr = errno;
+
+	/* write(2) on buf smaller than PIPE_BUF (min 512) is atomic: */
+	xwrite(child_notifier, &buf, sizeof(buf));
+	_exit(1);
+}
+
+/*
+ * parent will make it look like the child spewed a fatal error and died
+ * this is needed to prevent changes to t0061.
+ */
+static void fake_fatal(const char *err, va_list params)
+{
+	vreportf("fatal: ", err, params);
 }
+
+static void child_error_fn(const char *err, va_list params)
+{
+	const char msg[] = "error() should not be called in child\n"; \
+	xwrite(2, msg, sizeof(msg) - 1); \
+}
+
+static void child_warn_fn(const char *err, va_list params)
+{
+	const char msg[] = "warn() should not be called in child\n"; \
+	xwrite(2, msg, sizeof(msg) - 1); \
+}
+
+static void NORETURN child_die_fn(const char *err, va_list params)
+{
+	const char msg[] = "die() should not be called in child\n"; \
+	xwrite(2, msg, sizeof(msg) - 1); \
+	_exit(2);
+}
+
+/* this runs in the parent process */
+static void child_err_spew(struct child_process *cmd, struct child_err *cerr)
+{
+	static void (*old_errfn)(const char *err, va_list params);
+
+	old_errfn = get_error_routine();
+	set_error_routine(fake_fatal);
+	errno = cerr->syserr;
+
+	switch (cerr->err) {
+	case CHILD_ERR_NULL_STDIN:
+		error_errno("error redirecting stdin to /dev/null");
+		break;
+	case CHILD_ERR_NULL_STDOUT:
+		error_errno("error redirecting stdout to /dev/null");
+		break;
+	case CHILD_ERR_NULL_STDERR:
+		error_errno("error redirecting stderr to /dev/null");
+		break;
+	case CHILD_ERR_CHDIR:
+		error_errno("exec '%s': cd to '%s' failed",
+				cmd->argv[0], cmd->dir);
+		break;
+	case CHILD_ERR_SIGPROCMASK:
+		error_errno("sigprocmask failed restoring signals");
+	case CHILD_ERR_ENOENT:
+		error_errno("cannot run %s", cmd->argv[0]);
+	case CHILD_ERR_ENOENT_SILENT:
+		break;
+	case CHILD_ERR_ERRNO:
+		error_errno("cannot exec '%s'", cmd->argv[0]);
+	}
+	set_error_routine(old_errfn);
+}
+
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
+	fflush(NULL);
+}
+
+static void atfork_parent(struct atfork_state *as)
+{
+#ifdef NO_PTHREADS
+	if (sigprocmask(SIG_SETMASK, &af->old, NULL))
+		die_errno("sigprocmask");
+#else
+	bug_die(pthread_setcancelstate(as->cs, NULL),
+		"re-enabling cancellation");
+	bug_die(pthread_sigmask(SIG_SETMASK, &as->old, NULL),
+		"restoring signal mask");
+#endif
+}
+
 #endif
 
 static inline void set_cloexec(int fd)
@@ -274,13 +383,6 @@ static int wait_or_whine(pid_t pid, const char *argv0, int in_signal)
 		code += 128;
 	} else if (WIFEXITED(status)) {
 		code = WEXITSTATUS(status);
-		/*
-		 * Convert special exit code when execvp failed.
-		 */
-		if (code == 127) {
-			code = -1;
-			failed_errno = ENOENT;
-		}
 	} else {
 		error("waitpid is confused (%s)", argv0);
 	}
@@ -435,18 +537,21 @@ int start_command(struct child_process *cmd)
 {
 	int notify_pipe[2];
 	char **childenv;
-	FILE *child_err = NULL;
 	struct argv_array argv = ARGV_ARRAY_INIT;
+	int null_fd = -1;
+	struct child_err cerr;
+	struct atfork_state as;
 
 	if (pipe(notify_pipe))
 		notify_pipe[0] = notify_pipe[1] = -1;
 
 	childenv = prep_childenv(cmd->env);
 
-	if (cmd->no_stderr || need_err) {
-		int child_err_fd = dup(2);
-		set_cloexec(child_err_fd);
-		child_err = fdopen(child_err_fd, "w");
+	if (cmd->no_stdin || cmd->no_stdout || cmd->no_stderr) {
+		null_fd = open("/dev/null", O_RDWR | O_CLOEXEC | O_NONBLOCK);
+		if (null_fd < 0)
+			die_errno(_("open /dev/null failed"));
+		set_cloexec(null_fd);
 	}
 
 	if (cmd->git_cmd) {
@@ -466,25 +571,28 @@ int start_command(struct child_process *cmd)
 	 * held by another thread at the time of forking, causing the lock to
 	 * never be released in the child process.
 	 */
+	atfork_prepare(&as);
 	cmd->pid = fork();
 	failed_errno = errno;
 	if (!cmd->pid) {
+		int sig;
+
 		/*
-		 * Redirect the channel to write syscall error messages to
-		 * before redirecting the process's stderr so that all die()
-		 * in subsequent call paths use the parent's stderr.
+		 * make sure the default routines do not get called,
+		 * they can take stdio locks and malloc:
 		 */
-		if (child_err)
-			set_error_handle(child_err);
+		set_die_routine(child_die_fn);
+		set_error_routine(child_error_fn);
+		set_warn_routine(child_warn_fn);
 
 		close(notify_pipe[0]);
 		set_cloexec(notify_pipe[1]);
 		child_notifier = notify_pipe[1];
-		atexit(notify_parent);
 
-		if (cmd->no_stdin)
-			dup_devnull(0);
-		else if (need_in) {
+		if (cmd->no_stdin) {
+			if (dup2(null_fd, 0) < 0)
+				child_die(CHILD_ERR_NULL_STDIN);
+		} else if (need_in) {
 			dup2(fdin[0], 0);
 			close_pair(fdin);
 		} else if (cmd->in) {
@@ -492,9 +600,10 @@ int start_command(struct child_process *cmd)
 			close(cmd->in);
 		}
 
-		if (cmd->no_stderr)
-			dup_devnull(2);
-		else if (need_err) {
+		if (cmd->no_stderr) {
+			if (dup2(null_fd, 2) < 0)
+				child_die(CHILD_ERR_NULL_STDERR);
+		} else if (need_err) {
 			dup2(fderr[1], 2);
 			close_pair(fderr);
 		} else if (cmd->err > 1) {
@@ -502,9 +611,10 @@ int start_command(struct child_process *cmd)
 			close(cmd->err);
 		}
 
-		if (cmd->no_stdout)
-			dup_devnull(1);
-		else if (cmd->stdout_to_stderr)
+		if (cmd->no_stdout) {
+			if (dup2(null_fd, 1) < 0)
+				child_die(CHILD_ERR_NULL_STDOUT);
+		} else if (cmd->stdout_to_stderr)
 			dup2(2, 1);
 		else if (need_out) {
 			dup2(fdout[1], 1);
@@ -515,21 +625,29 @@ int start_command(struct child_process *cmd)
 		}
 
 		if (cmd->dir && chdir(cmd->dir))
-			die_errno("exec '%s': cd to '%s' failed", cmd->argv[0],
-			    cmd->dir);
+			child_die(CHILD_ERR_CHDIR);
+
+		/*
+		 * restore default signal handlers here, in case
+		 * we catch a signal right before sane_execvpe below
+		 */
+		for (sig = 1; sig < NSIG; sig++)
+			(void)signal(sig, SIG_DFL);
+
+		if (sigprocmask(SIG_SETMASK, &as.old, NULL) != 0)
+			child_die(CHILD_ERR_SIGPROCMASK);
 
 		sane_execvpe(argv.argv[0], (char *const*) argv.argv,
 			     (char *const*) childenv);
-
 		if (errno == ENOENT) {
-			if (!cmd->silent_exec_failure)
-				error("cannot run %s: %s", cmd->argv[0],
-					strerror(ENOENT));
-			exit(127);
+			if (cmd->silent_exec_failure)
+				child_die(CHILD_ERR_ENOENT_SILENT);
+			child_die(CHILD_ERR_ENOENT);
 		} else {
-			die_errno("cannot exec '%s'", cmd->argv[0]);
+			child_die(CHILD_ERR_ERRNO);
 		}
 	}
+	atfork_parent(&as);
 	if (cmd->pid < 0)
 		error_errno("cannot fork() for %s", cmd->argv[0]);
 	else if (cmd->clean_on_exit)
@@ -538,24 +656,25 @@ int start_command(struct child_process *cmd)
 	/*
 	 * Wait for child's execvp. If the execvp succeeds (or if fork()
 	 * failed), EOF is seen immediately by the parent. Otherwise, the
-	 * child process sends a single byte.
+	 * child process sends a child_err struct.
 	 * Note that use of this infrastructure is completely advisory,
 	 * therefore, we keep error checks minimal.
 	 */
 	close(notify_pipe[1]);
-	if (read(notify_pipe[0], &notify_pipe[1], 1) == 1) {
+	if (null_fd >= 0)
+		close(null_fd);
+	if (xread(notify_pipe[0], &cerr, sizeof(cerr)) == sizeof(cerr)) {
 		/*
 		 * At this point we know that fork() succeeded, but execvp()
 		 * failed. Errors have been reported to our stderr.
 		 */
 		wait_or_whine(cmd->pid, cmd->argv[0], 0);
+		child_err_spew(cmd, &cerr);
 		failed_errno = errno;
 		cmd->pid = -1;
 	}
 	close(notify_pipe[0]);
 
-	if (child_err)
-		fclose(child_err);
 	free(childenv);
 	argv_array_clear(&argv);
 }
-- 
EW
