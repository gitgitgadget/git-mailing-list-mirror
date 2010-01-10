From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 1/4] start_command: report child process setup errors to the parent's stderr
Date: Sun, 10 Jan 2010 14:07:52 +0100
Message-ID: <201001101407.52281.j6t@kdbg.org>
References: <1263044757-12560-1-git-send-email-ilari.liusvaara@elisanet.fi> <1263044757-12560-2-git-send-email-ilari.liusvaara@elisanet.fi> <201001101404.22258.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Sun Jan 10 14:08:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTxXF-0008QZ-Jm
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 14:08:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949Ab0AJNIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2010 08:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752289Ab0AJNIp
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 08:08:45 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:22097 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752856Ab0AJNIo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 08:08:44 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 105D0CDF83;
	Sun, 10 Jan 2010 14:08:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 564E019F610;
	Sun, 10 Jan 2010 14:07:52 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <201001101404.22258.j6t@kdbg.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136577>

When the child process's environment is set up in start_command(), error
messages were written to wherever the parent redirected the child's stderr
channel. However, even if the parent redirected the child's stderr, errors
during this setup process, including the exec itself, are usually an
indication of a problem in the parent's environment. Therefore, the error
messages should go to the parent's stderr.

Redirection of the child's error messages is usually only used to redirect
hook error messages during client-server exchanges. In these cases, hook
setup errors could be regarded as information leak.

This patch makes a copy of stderr if necessary and uses a special
die routine that is used for all die() calls in the child that sends the
errors messages to the parent's stderr.

The trace call that reported a failed execvp is removed (because it writes
to stderr) and replaced by die_errno() with special treatment of ENOENT.
The improvement in the error message can be seen with this sequence:

   mkdir .git/hooks/pre-commit
   git commit

Previously, the error message was

   error: cannot run .git/hooks/pre-commit: No such file or directory

and now it is

   fatal: cannot exec '.git/hooks/pre-commit': Permission denied

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 This should address your concern that "errors go to who-knows-where",
 that I meanwhile share with you.

 run-command.c |   46 +++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/run-command.c b/run-command.c
index cf2d8f7..02c7bfb 100644
--- a/run-command.c
+++ b/run-command.c
@@ -15,6 +15,30 @@ static inline void dup_devnull(int to)
 	close(fd);
 }
 
+#ifndef WIN32
+static int child_err = 2;
+
+static NORETURN void die_child(const char *err, va_list params)
+{
+	char msg[4096];
+	int len = vsnprintf(msg, sizeof(msg), err, params);
+	if (len > sizeof(msg))
+		len = sizeof(msg);
+
+	write(child_err, "fatal: ", 7);
+	write(child_err, msg, len);
+	write(child_err, "\n", 1);
+	exit(128);
+}
+
+static inline void set_cloexec(int fd)
+{
+	int flags = fcntl(fd, F_GETFD);
+	if (flags >= 0)
+		fcntl(fd, F_SETFD, flags | FD_CLOEXEC);
+}
+#endif
+
 int start_command(struct child_process *cmd)
 {
 	int need_in, need_out, need_err;
@@ -79,6 +103,17 @@ fail_pipe:
 	fflush(NULL);
 	cmd->pid = fork();
 	if (!cmd->pid) {
+		/*
+		 * Redirect the channel to write syscall error messages to
+		 * before redirecting the process's stderr so that all die()
+		 * in subsequent call paths use the parent's stderr.
+		 */
+		if (cmd->no_stderr || need_err) {
+			child_err = dup(2);
+			set_cloexec(child_err);
+		}
+		set_die_routine(die_child);
+
 		if (cmd->no_stdin)
 			dup_devnull(0);
 		else if (need_in) {
@@ -126,9 +161,14 @@ fail_pipe:
 		} else {
 			execvp(cmd->argv[0], (char *const*) cmd->argv);
 		}
-		trace_printf("trace: exec '%s' failed: %s\n", cmd->argv[0],
-				strerror(errno));
-		exit(127);
+		/*
+		 * Do not check for cmd->silent_exec_failure; the parent
+		 * process will check it when it sees this exit code.
+		 */
+		if (errno == ENOENT)
+			exit(127);
+		else
+			die_errno("cannot exec '%s'", cmd->argv[0]);
 	}
 	if (cmd->pid < 0)
 		error("cannot fork() for %s: %s", cmd->argv[0],
-- 
1.6.6.115.gd1ab3
