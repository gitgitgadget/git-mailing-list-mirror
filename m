From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 4/7] run_command: report system call errors instead of returning error codes
Date: Sat,  4 Jul 2009 21:26:40 +0200
Message-ID: <ea2d8110ea70b8698bb3674ca4482db64053d841.1246734159.git.j6t@kdbg.org>
References: <cover.1246734159.git.j6t@kdbg.org>
 <b73cf4b4cd09f4225098e71182044f64e12380aa.1246734159.git.j6t@kdbg.org>
 <d63e9230d57698a058c8a550709155e5e3222348.1246734159.git.j6t@kdbg.org>
 <4fe5ad61e7500735d1bbc12c98a863dd3499ea31.1246734159.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 04 21:27:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNAtm-00052P-5B
	for gcvg-git-2@gmane.org; Sat, 04 Jul 2009 21:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734AbZGDT1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jul 2009 15:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752557AbZGDT1i
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jul 2009 15:27:38 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:17676 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752428AbZGDT1b (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jul 2009 15:27:31 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 147B8CDF86;
	Sat,  4 Jul 2009 21:27:34 +0200 (CEST)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id D6AC95BAC7;
	Sat,  4 Jul 2009 21:27:33 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.17.g1665f
In-Reply-To: <4fe5ad61e7500735d1bbc12c98a863dd3499ea31.1246734159.git.j6t@kdbg.org>
In-Reply-To: <cover.1246734159.git.j6t@kdbg.org>
References: <cover.1246734159.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122726>

The motivation for this change is that system call failures are serious
errors that should be reported to the user, but only few callers took the
burden to decode the error codes that the functions returned into error
messages.

If at all, then only an unspecific error message was given. A prominent
example is this:

   $ git upload-pack . | :
   fatal: unable to run 'git-upload-pack'

In this example, git-upload-pack, the external command invoked through the
git wrapper, dies due to SIGPIPE, but the git wrapper does not bother to
report the real cause. In fact, this very error message is copied to the
syslog if git-daemon's client aborts the connection early.

With this change, system call failures are reported immediately after the
failure and only a generic failure code is returned to the caller. In the
above example the error is now to the point:

   $ git upload-pack . | :
   error: git-upload-pack died of signal

Note that there is no error report if the invoked program terminated with
a non-zero exit code, because it is reasonable to expect that the invoked
program has already reported an error. (But many run_command call sites
nevertheless write a generic error message.)

There was one special return code that was used to identify the case where
run_command failed because the requested program could not be exec'd. This
special case is now treated like a system call failure with errno set to
ENOENT. No error is reported in this case, because the call site in git.c
expects this as a normal result. Therefore, the callers that carefully
decoded the return value still check for this condition.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 builtin-receive-pack.c       |   22 +---------
 git.c                        |    8 +---
 run-command.c                |   89 +++++++++++++++++++++++-------------------
 run-command.h                |   10 -----
 t/t5530-upload-pack-error.sh |    5 ++-
 transport.c                  |   12 +-----
 6 files changed, 59 insertions(+), 87 deletions(-)

diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index 6235903..1dcdb1a 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -125,27 +125,11 @@ static const char post_receive_hook[] = "hooks/post-receive";
 
 static int run_status(int code, const char *cmd_name)
 {
-	switch (code) {
-	case 0:
-		return 0;
-	case -ERR_RUN_COMMAND_FORK:
-		return error("fork of %s failed", cmd_name);
-	case -ERR_RUN_COMMAND_EXEC:
+	if (code < 0 && errno == ENOENT)
 		return error("execute of %s failed", cmd_name);
-	case -ERR_RUN_COMMAND_PIPE:
-		return error("pipe failed");
-	case -ERR_RUN_COMMAND_WAITPID:
-		return error("waitpid failed");
-	case -ERR_RUN_COMMAND_WAITPID_WRONG_PID:
-		return error("waitpid is confused");
-	case -ERR_RUN_COMMAND_WAITPID_SIGNAL:
-		return error("%s died of signal", cmd_name);
-	case -ERR_RUN_COMMAND_WAITPID_NOEXIT:
-		return error("%s died strangely", cmd_name);
-	default:
+	else if (code > 0)
 		error("%s exited with error code %d", cmd_name, code);
-		return code;
-	}
+	return code;
 }
 
 static int run_receive_hook(const char *hook_name)
diff --git a/git.c b/git.c
index 662f21e..2fb7093 100644
--- a/git.c
+++ b/git.c
@@ -417,12 +417,8 @@ static void execv_dashed_external(const char **argv)
 	 * OK to return. Otherwise, we just pass along the status code.
 	 */
 	status = run_command_v_opt(argv, 0);
-	if (status != -ERR_RUN_COMMAND_EXEC) {
-		if (status < 0)
-			die("unable to run '%s'", argv[0]);
-		exit(status);
-	}
-	errno = ENOENT; /* as if we called execvp */
+	if (status >= 0 || errno != ENOENT)
+		exit(status & 0xff);
 
 	argv[0] = tmp;
 
diff --git a/run-command.c b/run-command.c
index a4e309e..4b3fda0 100644
--- a/run-command.c
+++ b/run-command.c
@@ -19,6 +19,7 @@ int start_command(struct child_process *cmd)
 {
 	int need_in, need_out, need_err;
 	int fdin[2], fdout[2], fderr[2];
+	int failed_errno;
 
 	/*
 	 * In case of errors we must keep the promise to close FDs
@@ -28,9 +29,10 @@ int start_command(struct child_process *cmd)
 	need_in = !cmd->no_stdin && cmd->in < 0;
 	if (need_in) {
 		if (pipe(fdin) < 0) {
+			failed_errno = errno;
 			if (cmd->out > 0)
 				close(cmd->out);
-			return -ERR_RUN_COMMAND_PIPE;
+			goto fail_pipe;
 		}
 		cmd->in = fdin[1];
 	}
@@ -40,11 +42,12 @@ int start_command(struct child_process *cmd)
 		&& cmd->out < 0;
 	if (need_out) {
 		if (pipe(fdout) < 0) {
+			failed_errno = errno;
 			if (need_in)
 				close_pair(fdin);
 			else if (cmd->in)
 				close(cmd->in);
-			return -ERR_RUN_COMMAND_PIPE;
+			goto fail_pipe;
 		}
 		cmd->out = fdout[0];
 	}
@@ -52,6 +55,7 @@ int start_command(struct child_process *cmd)
 	need_err = !cmd->no_stderr && cmd->err < 0;
 	if (need_err) {
 		if (pipe(fderr) < 0) {
+			failed_errno = errno;
 			if (need_in)
 				close_pair(fdin);
 			else if (cmd->in)
@@ -60,7 +64,11 @@ int start_command(struct child_process *cmd)
 				close_pair(fdout);
 			else if (cmd->out)
 				close(cmd->out);
-			return -ERR_RUN_COMMAND_PIPE;
+fail_pipe:
+			error("cannot create pipe for %s: %s",
+				cmd->argv[0], strerror(failed_errno));
+			errno = failed_errno;
+			return -1;
 		}
 		cmd->err = fderr[0];
 	}
@@ -122,6 +130,9 @@ int start_command(struct child_process *cmd)
 				strerror(errno));
 		exit(127);
 	}
+	if (cmd->pid < 0)
+		error("cannot fork() for %s: %s", cmd->argv[0],
+			strerror(failed_errno = errno));
 #else
 	int s0 = -1, s1 = -1, s2 = -1;	/* backups of stdin, stdout, stderr */
 	const char **sargv = cmd->argv;
@@ -173,6 +184,9 @@ int start_command(struct child_process *cmd)
 	}
 
 	cmd->pid = mingw_spawnvpe(cmd->argv[0], cmd->argv, env);
+	if (cmd->pid < 0 && errno != ENOENT)
+		error("cannot spawn %s: %s", cmd->argv[0],
+			strerror(failed_errno = errno));
 
 	if (cmd->env)
 		free_environ(env);
@@ -189,7 +203,6 @@ int start_command(struct child_process *cmd)
 #endif
 
 	if (cmd->pid < 0) {
-		int err = errno;
 		if (need_in)
 			close_pair(fdin);
 		else if (cmd->in)
@@ -200,9 +213,8 @@ int start_command(struct child_process *cmd)
 			close(cmd->out);
 		if (need_err)
 			close_pair(fderr);
-		return err == ENOENT ?
-			-ERR_RUN_COMMAND_EXEC :
-			-ERR_RUN_COMMAND_FORK;
+		errno = failed_errno;
+		return -1;
 	}
 
 	if (need_in)
@@ -221,33 +233,41 @@ int start_command(struct child_process *cmd)
 	return 0;
 }
 
-static int wait_or_whine(pid_t pid)
+static int wait_or_whine(pid_t pid, const char *argv0)
 {
-	for (;;) {
-		int status, code;
-		pid_t waiting = waitpid(pid, &status, 0);
-
-		if (waiting < 0) {
-			if (errno == EINTR)
-				continue;
-			error("waitpid failed (%s)", strerror(errno));
-			return -ERR_RUN_COMMAND_WAITPID;
-		}
-		if (waiting != pid)
-			return -ERR_RUN_COMMAND_WAITPID_WRONG_PID;
-		if (WIFSIGNALED(status))
-			return -ERR_RUN_COMMAND_WAITPID_SIGNAL;
-
-		if (!WIFEXITED(status))
-			return -ERR_RUN_COMMAND_WAITPID_NOEXIT;
+	int status, code = -1;
+	pid_t waiting;
+	int failed_errno = 0;
+
+	while ((waiting = waitpid(pid, &status, 0)) < 0 && errno == EINTR)
+		;	/* nothing */
+
+	if (waiting < 0) {
+		failed_errno = errno;
+		error("waitpid for %s failed: %s", argv0, strerror(errno));
+	} else if (waiting != pid) {
+		error("waitpid is confused (%s)", argv0);
+	} else if (WIFSIGNALED(status)) {
+		error("%s died of signal", argv0);
+	} else if (WIFEXITED(status)) {
 		code = WEXITSTATUS(status);
-		return code == 127 ? -ERR_RUN_COMMAND_EXEC : code;
+		/*
+		 * Convert special exit code when execvp failed.
+		 */
+		if (code == 127) {
+			code = -1;
+			failed_errno = ENOENT;
+		}
+	} else {
+		error("waitpid is confused (%s)", argv0);
 	}
+	errno = failed_errno;
+	return code;
 }
 
 int finish_command(struct child_process *cmd)
 {
-	return wait_or_whine(cmd->pid);
+	return wait_or_whine(cmd->pid, cmd->argv[0]);
 }
 
 int run_command(struct child_process *cmd)
@@ -331,10 +351,7 @@ int start_async(struct async *async)
 int finish_async(struct async *async)
 {
 #ifndef __MINGW32__
-	int ret = 0;
-
-	if (wait_or_whine(async->pid))
-		ret = error("waitpid (async) failed");
+	int ret = wait_or_whine(async->pid, "child process");
 #else
 	DWORD ret = 0;
 	if (WaitForSingleObject(async->tid, INFINITE) != WAIT_OBJECT_0)
@@ -378,15 +395,7 @@ int run_hook(const char *index_file, const char *name, ...)
 		hook.env = env;
 	}
 
-	ret = start_command(&hook);
+	ret = run_command(&hook);
 	free(argv);
-	if (ret) {
-		warning("Could not spawn %s", argv[0]);
-		return ret;
-	}
-	ret = finish_command(&hook);
-	if (ret == -ERR_RUN_COMMAND_WAITPID_SIGNAL)
-		warning("%s exited due to uncaught signal", argv[0]);
-
 	return ret;
 }
diff --git a/run-command.h b/run-command.h
index 0211e1d..ac6c09c 100644
--- a/run-command.h
+++ b/run-command.h
@@ -1,16 +1,6 @@
 #ifndef RUN_COMMAND_H
 #define RUN_COMMAND_H
 
-enum {
-	ERR_RUN_COMMAND_FORK = 10000,
-	ERR_RUN_COMMAND_EXEC,
-	ERR_RUN_COMMAND_PIPE,
-	ERR_RUN_COMMAND_WAITPID,
-	ERR_RUN_COMMAND_WAITPID_WRONG_PID,
-	ERR_RUN_COMMAND_WAITPID_SIGNAL,
-	ERR_RUN_COMMAND_WAITPID_NOEXIT,
-};
-
 struct child_process {
 	const char **argv;
 	pid_t pid;
diff --git a/t/t5530-upload-pack-error.sh b/t/t5530-upload-pack-error.sh
index f5102b9..82ca300 100755
--- a/t/t5530-upload-pack-error.sh
+++ b/t/t5530-upload-pack-error.sh
@@ -53,7 +53,10 @@ test_expect_success 'upload-pack fails due to error in rev-list' '
 	! echo "0032want $(git rev-parse HEAD)
 00000009done
 0000" | git upload-pack . > /dev/null 2> output.err &&
-	grep "waitpid (async) failed" output.err
+	# pack-objects survived
+	grep "Total.*, reused" output.err &&
+	# but there was an error, which must have been in rev-list
+	grep "bad tree object" output.err
 '
 
 test_expect_success 'create empty repository' '
diff --git a/transport.c b/transport.c
index 501a77b..0885801 100644
--- a/transport.c
+++ b/transport.c
@@ -417,18 +417,8 @@ static int curl_transport_push(struct transport *transport, int refspec_nr, cons
 		argv[argc++] = *refspec++;
 	argv[argc] = NULL;
 	err = run_command_v_opt(argv, RUN_GIT_CMD);
-	switch (err) {
-	case -ERR_RUN_COMMAND_FORK:
-		error("unable to fork for %s", argv[0]);
-	case -ERR_RUN_COMMAND_EXEC:
+	if (err < 0 && errno == ENOENT)
 		error("unable to exec %s", argv[0]);
-		break;
-	case -ERR_RUN_COMMAND_WAITPID:
-	case -ERR_RUN_COMMAND_WAITPID_WRONG_PID:
-	case -ERR_RUN_COMMAND_WAITPID_SIGNAL:
-	case -ERR_RUN_COMMAND_WAITPID_NOEXIT:
-		error("%s died with strange error", argv[0]);
-	}
 	return !!err;
 }
 
-- 
1.6.3.17.g1665f
