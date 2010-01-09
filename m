From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [RFC PATCH v2 1/2] Report exec errors from run-command
Date: Sat,  9 Jan 2010 15:45:56 +0200
Message-ID: <1263044757-12560-2-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1263044757-12560-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 09 14:46:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTbdu-0002WI-Kp
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 14:46:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754564Ab0AINqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2010 08:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754538Ab0AINqG
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 08:46:06 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:43777 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753990Ab0AINqE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 08:46:04 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id 8986913B57B
	for <git@vger.kernel.org>; Sat,  9 Jan 2010 15:46:01 +0200 (EET)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A00B107AC57; Sat, 09 Jan 2010 15:46:01 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id 3705027D88
	for <git@vger.kernel.org>; Sat,  9 Jan 2010 15:46:00 +0200 (EET)
X-Mailer: git-send-email 1.6.6.3.gaa2e1
In-Reply-To: <1263044757-12560-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136532>

Previously run-command was unable to report errors happening in exec
call. Change it to pass errno from failed exec to errno value at
return. Also add special mode that diffrentiates between ENOENT
from exec and ENOENT from other source.

The errno value passing can be done by opening close-on-exec pipe and
piping the error code through in case of failure. In case of success,
close-on-exec closes the pipe on successful exec and parent process
gets end of file on read.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 Documentation/technical/api-run-command.txt |    2 +
 Makefile                                    |    1 +
 run-command.c                               |  196 +++++++++++++++++++++++++--
 run-command.h                               |    2 +
 t/t0061-run-command.sh                      |   20 +++
 test-run-command.c                          |   74 ++++++++++
 6 files changed, 282 insertions(+), 13 deletions(-)
 create mode 100755 t/t0061-run-command.sh
 create mode 100644 test-run-command.c

diff --git a/Documentation/technical/api-run-command.txt b/Documentation/technical/api-run-command.txt
index b26c281..f37d8ba 100644
--- a/Documentation/technical/api-run-command.txt
+++ b/Documentation/technical/api-run-command.txt
@@ -49,6 +49,8 @@ The functions above do the following:
 
 . If the program was not found, then -1 is returned and errno is set to
   ENOENT; a diagnostic is printed only if .silent_exec_failure is 0.
+  (if extended_error_code flag is true, instead of -1, the return value
+  is -2 in this case).
 
 . Otherwise, the program is run. If it terminates regularly, its exit
   code is returned. No diagnistic is printed, even if the exit code is
diff --git a/Makefile b/Makefile
index a2fce5a..92eed68 100644
--- a/Makefile
+++ b/Makefile
@@ -1753,6 +1753,7 @@ TEST_PROGRAMS_NEED_X += test-path-utils
 TEST_PROGRAMS_NEED_X += test-sha1
 TEST_PROGRAMS_NEED_X += test-sigchain
 TEST_PROGRAMS_NEED_X += test-index-version
+TEST_PROGRAMS_NEED_X += test-run-command
 
 TEST_PROGRAMS = $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
 
diff --git a/run-command.c b/run-command.c
index 47ced57..b1af9c4 100644
--- a/run-command.c
+++ b/run-command.c
@@ -15,6 +15,20 @@ static inline void dup_devnull(int to)
 	close(fd);
 }
 
+static inline void force_close(int fd)
+{
+	/*
+	 * Assume all errors except EINTR are persistent and
+	 * that EBADF signals already closed fd.
+	 */
+	while (close(fd) < 0 && errno != EBADF)
+		if (errno != EINTR) {
+			warning("Close returned error %s",
+				strerror(errno));
+			break;
+		}
+}
+
 static const char **prepare_shell_cmd(const char **argv)
 {
 	int argc, nargc = 0;
@@ -49,6 +63,8 @@ static const char **prepare_shell_cmd(const char **argv)
 }
 
 #ifndef WIN32
+int child_err = -1;
+
 static int execv_shell_cmd(const char **argv)
 {
 	const char **nargv = prepare_shell_cmd(argv);
@@ -57,6 +73,26 @@ static int execv_shell_cmd(const char **argv)
 	free(nargv);
 	return -1;
 }
+
+static void error_child(const char *err, ...)
+{
+	char msg[4096];
+	int len;
+	va_list args;
+	va_start(args, err);
+	len = vsnprintf(msg, sizeof(msg), err, args);
+	va_end(args);
+	if (len >= sizeof(msg))
+		len = sizeof(msg) - 1;
+
+	if (child_err < 0)
+		return;
+
+	write(child_err, "error: ", 7);
+	write(child_err, msg, len);
+	write(child_err, "\n", 1);
+}
+
 #endif
 
 int start_command(struct child_process *cmd)
@@ -64,6 +100,7 @@ int start_command(struct child_process *cmd)
 	int need_in, need_out, need_err;
 	int fdin[2], fdout[2], fderr[2];
 	int failed_errno = failed_errno;
+	int func_ret = 0;
 
 	/*
 	 * In case of errors we must keep the promise to close FDs
@@ -120,9 +157,91 @@ fail_pipe:
 	trace_argv_printf(cmd->argv, "trace: run_command:");
 
 #ifndef WIN32
+{
+	int report_pipe[2] = {-1, -1};
+
+	if (pipe(report_pipe) < 0) {
+		report_pipe[0] = -1;
+		report_pipe[1] = -1;
+		warning("Can't open pipe for exec status report: %s\n",
+			strerror(errno));
+	}
+
 	fflush(NULL);
 	cmd->pid = fork();
-	if (!cmd->pid) {
+	if (cmd->pid > 0) {
+		int r = 0, ret = 0;
+		force_close(report_pipe[1]);
+read_again:
+		if (report_pipe[0] >= 0)
+			r = read(report_pipe[0], &ret, sizeof(ret));
+		if (r < 0 && (errno == EAGAIN || errno == EINTR ||
+			errno == EWOULDBLOCK))
+			goto read_again;
+		else if (r < 0)
+			warning("Can't read exec status report: %s\n",
+				strerror(errno));
+		else if (r == 0)
+			;
+		else if (r < sizeof(ret)) {
+			warning("Received incomplete exec status report.\n");
+		} else {
+			failed_errno = ret;
+			/*
+			 * Clean up the process that did the failed execution
+			 * so no zombies remain.
+			 */
+			while (waitpid(cmd->pid, &ret, 0) < 0 && errno == EINTR)
+				/* Nothing. */ ;
+			if (WIFEXITED(ret) && WEXITSTATUS(ret) == 127)
+				/* Program was not found. */
+				func_ret = -2;
+			cmd->pid = -1;
+		}
+	} else if (!cmd->pid) {
+		int r = 0;
+		int errored = 0;
+		int flags;
+		force_close(report_pipe[0]);
+
+		flags = fcntl(report_pipe[1], F_GETFD);
+		if (flags < 0)
+			r = -1;
+		r = (r || fcntl(report_pipe[1], F_SETFD, flags | FD_CLOEXEC));
+		if (r) {
+			warning("Can't FD_CLOEXEC pipe for exec status report: %s",
+				strerror(errno));
+			force_close(report_pipe[1]);
+			report_pipe[1] = -1;
+		}
+
+		/*
+		 * Redirect the channel to write syscall error messages to
+		 * before redirecting the process's stderr so that all error
+		 * messages in subsequent call paths use the parent's stderr.
+		 */
+		if (cmd->no_stderr || need_err) {
+			child_err = dup(2);
+			if (child_err < 0 && errno != EBADF)
+				/* EBADF => No stderr, nowhere to go. */
+				warning("Can't dup fd for child exec errors: %s",
+					strerror(errno));
+			if (child_err < 0)
+				goto no_error_chan;
+
+			flags = fcntl(child_err, F_GETFL);
+			if (flags < 0)
+				flags = 0;
+			if (fcntl(child_err, F_SETFL, flags | FD_CLOEXEC) < 0) {
+				warning("Can't FD_CLOEXEC fd for child exec errors: %s",
+					strerror(errno));
+				force_close(report_pipe[1]);
+				child_err = -1;
+			}
+		} else
+			child_err = 2;
+no_error_chan:
+
 		if (cmd->no_stdin)
 			dup_devnull(0);
 		else if (need_in) {
@@ -152,9 +271,15 @@ fail_pipe:
 			close(cmd->out);
 		}
 
-		if (cmd->dir && chdir(cmd->dir))
-			die_errno("exec '%s': cd to '%s' failed", cmd->argv[0],
-			    cmd->dir);
+		if (cmd->dir && chdir(cmd->dir)) {
+			failed_errno = errno;
+			error_child("exec '%s': cd to '%s' failed: %s",
+				cmd->argv[0], cmd->dir, strerror(errno));
+			trace_printf("trace: exec '%s': cd to '%s' failed: %s\n",
+				cmd->argv[0], cmd->dir, strerror(errno));
+			errored = 1;
+			goto throw_fault;
+		}
 		if (cmd->env) {
 			for (; *cmd->env; cmd->env++) {
 				if (strchr(*cmd->env, '='))
@@ -163,8 +288,23 @@ fail_pipe:
 					unsetenv(*cmd->env);
 			}
 		}
-		if (cmd->preexec_cb)
+		if (cmd->preexec_cb) {
+			/*
+			 * We don't know what pre-exec callbacks do, and they
+			 * may do something that causes deadlock with exec
+			 * reporting. The sole user of this hook seems to
+			 * be pager, and it is run through shell, so one
+			 * wouldn't get useful error from exec reporting
+			 * and would get useful error from shell anyway. So
+			 * just disable exec reporting for such comamnds.
+			 * (unless explicitly specified otherwise).
+			 */
+			if (!cmd->report_preexec_cb) {
+				force_close(report_pipe[1]);
+				report_pipe[1] = -1;
+			}
 			cmd->preexec_cb();
+		}
 		if (cmd->git_cmd) {
 			execv_git_cmd(cmd->argv);
 		} else if (cmd->use_shell) {
@@ -172,13 +312,36 @@ fail_pipe:
 		} else {
 			execvp(cmd->argv[0], (char *const*) cmd->argv);
 		}
+		failed_errno = errno;
+
 		trace_printf("trace: exec '%s' failed: %s\n", cmd->argv[0],
 				strerror(errno));
-		exit(127);
-	}
-	if (cmd->pid < 0)
+
+		if (!cmd->silent_exec_failure || errno != ENOENT)
+			error_child("cannot exec '%s': %s",
+				cmd->argv[0], strerror(failed_errno));
+throw_fault:
+		r = 0;
+write_again:
+		if (report_pipe[1] >= 0)
+			r = write(report_pipe[1], &failed_errno,
+				sizeof(failed_errno));
+		if (r < 0 && (errno == EAGAIN || errno == EINTR ||
+			errno == EWOULDBLOCK))
+			goto write_again;
+
+		/*
+		 * Diffrentiate between program doesn't exist and other
+		 * errors.
+		 */
+		if (errored || errno != ENOENT)
+			exit(128);
+		else
+			exit(127);
+	} else if (cmd->pid < 0)
 		error("cannot fork() for %s: %s", cmd->argv[0],
 			strerror(failed_errno = errno));
+}
 #else
 {
 	int s0 = -1, s1 = -1, s2 = -1;	/* backups of stdin, stdout, stderr */
@@ -233,6 +396,8 @@ fail_pipe:
 	failed_errno = errno;
 	if (cmd->pid < 0 && (!cmd->silent_exec_failure || errno != ENOENT))
 		error("cannot spawn %s: %s", cmd->argv[0], strerror(errno));
+	if (cmd->pid < 0 && errno == ENOENT)
+		func_ret = -2;
 
 	if (cmd->env)
 		free_environ(env);
@@ -261,7 +426,10 @@ fail_pipe:
 		if (need_err)
 			close_pair(fderr);
 		errno = failed_errno;
-		return -1;
+		if (cmd->extended_error_code && func_ret)
+			return func_ret;
+		else
+			return -1;
 	}
 
 	if (need_in)
@@ -280,7 +448,8 @@ fail_pipe:
 	return 0;
 }
 
-static int wait_or_whine(pid_t pid, const char *argv0, int silent_exec_failure)
+static int wait_or_whine(pid_t pid, const char *argv0, int silent_exec_failure,
+	int extended_err)
 {
 	int status, code = -1;
 	pid_t waiting;
@@ -309,7 +478,7 @@ static int wait_or_whine(pid_t pid, const char *argv0, int silent_exec_failure)
 		 * Convert special exit code when execvp failed.
 		 */
 		if (code == 127) {
-			code = -1;
+			code = extended_err ? -2 : -1;
 			failed_errno = ENOENT;
 			if (!silent_exec_failure)
 				error("cannot run %s: %s", argv0,
@@ -324,7 +493,8 @@ static int wait_or_whine(pid_t pid, const char *argv0, int silent_exec_failure)
 
 int finish_command(struct child_process *cmd)
 {
-	return wait_or_whine(cmd->pid, cmd->argv[0], cmd->silent_exec_failure);
+	return wait_or_whine(cmd->pid, cmd->argv[0], cmd->silent_exec_failure,
+		cmd->extended_error_code);
 }
 
 int run_command(struct child_process *cmd)
@@ -410,7 +580,7 @@ int start_async(struct async *async)
 int finish_async(struct async *async)
 {
 #ifndef WIN32
-	int ret = wait_or_whine(async->pid, "child process", 0);
+	int ret = wait_or_whine(async->pid, "child process", 0, 0);
 #else
 	DWORD ret = 0;
 	if (WaitForSingleObject(async->tid, INFINITE) != WAIT_OBJECT_0)
diff --git a/run-command.h b/run-command.h
index 967ba8c..f6b4caf 100644
--- a/run-command.h
+++ b/run-command.h
@@ -34,6 +34,8 @@ struct child_process {
 	unsigned silent_exec_failure:1;
 	unsigned stdout_to_stderr:1;
 	unsigned use_shell:1;
+	unsigned extended_error_code:1;
+	unsigned report_preexec_cb:1;
 	void (*preexec_cb)(void);
 };
 
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
new file mode 100755
index 0000000..0c217b1
--- /dev/null
+++ b/t/t0061-run-command.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Ilari Liusvaara
+#
+
+test_description='Test run command'
+
+. ./test-lib.sh
+
+test_expect_success "reporting ENOENT (non-extended)" \
+"test-run-command 2"
+
+test_expect_success "reporting ENOENT (extended)" \
+"test-run-command 1"
+
+test_expect_success "reporting chdir failed (extended)" \
+"test-run-command 3"
+
+
+test_done
diff --git a/test-run-command.c b/test-run-command.c
new file mode 100644
index 0000000..db664f3
--- /dev/null
+++ b/test-run-command.c
@@ -0,0 +1,74 @@
+/*
+ * test-run-command.c: test run command API.
+ *
+ * (C) 2009 Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "git-compat-util.h"
+#include "run-command.h"
+#include <string.h>
+#include <errno.h>
+
+int main(int argc, char **argv)
+{
+	char* procs[2];
+	struct child_process proc;
+	char test = argv[1][0];
+	memset(&proc, 0, sizeof(proc));
+
+	if(argc < 2)
+		return 1;
+
+
+	switch(test) {
+	case '1':
+		procs[0] = "does-not-exist-62896869286";
+		procs[1] = NULL;
+		proc.argv = (const char **)procs;
+		proc.extended_error_code = 1;
+
+		if (start_command(&proc) != -2) {
+			fprintf(stderr, "FAIL A\n");
+			return 1;
+		}
+		if (test == '1' && errno == ENOENT)
+			return 0;
+	case '2':
+		procs[0] = "does-not-exist-62896869286";
+		procs[1] = NULL;
+		proc.argv = (const char **)procs;
+		proc.extended_error_code = 0;
+
+		if (start_command(&proc) != -1) {
+			fprintf(stderr, "FAIL A\n");
+			return 1;
+		}
+		if (errno == ENOENT)
+			return 0;
+	case '3':
+#ifdef WIN32
+		/* This can't work on Win32, so just skip it. */
+		return 0;
+#endif
+		procs[0] = "does-not-exist-62896869286";
+		procs[1] = NULL;
+		proc.argv = (const char **)procs;
+		proc.dir = "does-not-exist-52632632733";
+		proc.extended_error_code = 1;
+
+		if (start_command(&proc) != -1) {
+			fprintf(stderr, "FAIL A\n");
+			return 1;
+		}
+		if (errno == ENOENT)
+			return 0;
+	}
+
+	fprintf(stderr, "FAIL B\n");
+
+	return 1;
+}
-- 
1.6.6.3.gaa2e1
