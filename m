From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 3/4] start_command: detect execvp failures early
Date: Sun, 10 Jan 2010 14:11:22 +0100
Message-ID: <201001101411.22418.j6t@kdbg.org>
References: <1263044757-12560-1-git-send-email-ilari.liusvaara@elisanet.fi> <1263044757-12560-2-git-send-email-ilari.liusvaara@elisanet.fi> <201001101404.22258.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Sun Jan 10 14:12:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTxad-00015T-8X
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 14:12:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354Ab0AJNMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2010 08:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752287Ab0AJNMP
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 08:12:15 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:23238 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752171Ab0AJNMO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 08:12:14 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 6272610018;
	Sun, 10 Jan 2010 14:12:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 7B03719F610;
	Sun, 10 Jan 2010 14:11:22 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <201001101404.22258.j6t@kdbg.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136579>

Previously, failures during execvp could be detected only by
finish_command. However, in some situations it is beneficial for the
parent process to know earlier that the child process will not run.

The idea to use a pipe to signal failures to the parent process and
the test case were lifted from patches by Ilari Liusvaara.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Makefile               |    1 +
 run-command.c          |   47 ++++++++++++++++++++++++++++++++++++++++++++++-
 t/t0061-run-command.sh |   14 ++++++++++++++
 test-run-command.c     |   35 +++++++++++++++++++++++++++++++++++
 4 files changed, 96 insertions(+), 1 deletions(-)
 create mode 100755 t/t0061-run-command.sh
 create mode 100644 test-run-command.c

diff --git a/Makefile b/Makefile
index 87fc7ff..22c1546 100644
--- a/Makefile
+++ b/Makefile
@@ -1785,6 +1785,7 @@ TEST_PROGRAMS += test-genrandom$X
 TEST_PROGRAMS += test-match-trees$X
 TEST_PROGRAMS += test-parse-options$X
 TEST_PROGRAMS += test-path-utils$X
+TEST_PROGRAMS += test-run-command$X
 TEST_PROGRAMS += test-sha1$X
 TEST_PROGRAMS += test-sigchain$X
 
diff --git a/run-command.c b/run-command.c
index dccac37..473b7f8 100644
--- a/run-command.c
+++ b/run-command.c
@@ -17,6 +17,12 @@ static inline void dup_devnull(int to)
 
 #ifndef WIN32
 static int child_err = 2;
+static int child_notifier = -1;
+
+static void notify_parent()
+{
+	write(child_notifier, "", 1);
+}
 
 static NORETURN void die_child(const char *err, va_list params)
 {
@@ -142,6 +148,11 @@ fail_pipe:
 	trace_argv_printf(cmd->argv, "trace: run_command:");
 
 #ifndef WIN32
+{
+	int notify_pipe[2];
+	if (pipe(notify_pipe))
+		notify_pipe[0] = notify_pipe[1] = -1;
+
 	fflush(NULL);
 	cmd->pid = fork();
 	if (!cmd->pid) {
@@ -156,6 +167,11 @@ fail_pipe:
 		}
 		set_die_routine(die_child);
 
+		close(notify_pipe[0]);
+		set_cloexec(notify_pipe[1]);
+		child_notifier = notify_pipe[1];
+		atexit(notify_parent);
+
 		if (cmd->no_stdin)
 			dup_devnull(0);
 		else if (need_in) {
@@ -196,8 +212,16 @@ fail_pipe:
 					unsetenv(*cmd->env);
 			}
 		}
-		if (cmd->preexec_cb)
+		if (cmd->preexec_cb) {
+			/*
+			 * We cannot predict what the pre-exec callback does.
+			 * Forgo parent notification.
+			 */
+			close(child_notifier);
+			child_notifier = -1;
+
 			cmd->preexec_cb();
+		}
 		if (cmd->git_cmd) {
 			execv_git_cmd(cmd->argv);
 		} else {
@@ -215,6 +239,27 @@ fail_pipe:
 	if (cmd->pid < 0)
 		error("cannot fork() for %s: %s", cmd->argv[0],
 			strerror(failed_errno = errno));
+
+	/*
+	 * Wait for child's execvp. If the execvp succeeds (or if fork()
+	 * failed), EOF is seen immediately by the parent. Otherwise, the
+	 * child process sends a single byte.
+	 * Note that use of this infrastructure is completely advisory,
+	 * therefore, we keep error checks minimal.
+	 */
+	close(notify_pipe[1]);
+	if (read(notify_pipe[0], &notify_pipe[1], 1) == 1) {
+		/*
+		 * At this point we know that fork() succeeded, but execvp()
+		 * failed. Errors have been reported to our stderr.
+		 */
+		wait_or_whine(cmd->pid, cmd->argv[0],
+			      cmd->silent_exec_failure);
+		failed_errno = errno;
+		cmd->pid = -1;
+	}
+	close(notify_pipe[0]);
+}
 #else
 {
 	int s0 = -1, s1 = -1, s2 = -1;	/* backups of stdin, stdout, stderr */
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
new file mode 100755
index 0000000..10b26e4
--- /dev/null
+++ b/t/t0061-run-command.sh
@@ -0,0 +1,14 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Ilari Liusvaara
+#
+
+test_description='Test run command'
+
+. ./test-lib.sh
+
+test_expect_success 'start_command reports ENOENT' '
+	test-run-command start-command-ENOENT ./does-not-exist
+'
+
+test_done
diff --git a/test-run-command.c b/test-run-command.c
new file mode 100644
index 0000000..a1d5306
--- /dev/null
+++ b/test-run-command.c
@@ -0,0 +1,35 @@
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
+	struct child_process proc;
+
+	memset(&proc, 0, sizeof(proc));
+
+	if(argc < 3)
+		return 1;
+	proc.argv = (const char **)argv+2;
+
+	if (!strcmp(argv[1], "start-command-ENOENT")) {
+		if (start_command(&proc) < 0 && errno == ENOENT)
+			return 0;
+		fprintf(stderr, "FAIL %s\n", argv[1]);
+		return 1;
+	}
+
+	fprintf(stderr, "check usage\n");
+	return 1;
+}
-- 
1.6.6.115.gd1ab3
