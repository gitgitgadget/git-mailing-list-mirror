From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 2/4] run-command: move wait_or_whine earlier
Date: Sun, 10 Jan 2010 14:08:45 +0100
Message-ID: <201001101408.45603.j6t@kdbg.org>
References: <1263044757-12560-1-git-send-email-ilari.liusvaara@elisanet.fi> <1263044757-12560-2-git-send-email-ilari.liusvaara@elisanet.fi> <201001101404.22258.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Sun Jan 10 14:09:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTxY5-0000BU-Oe
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 14:09:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987Ab0AJNJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2010 08:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690Ab0AJNJi
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 08:09:38 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:22337 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751136Ab0AJNJh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 08:09:37 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 2C7D2CDF86;
	Sun, 10 Jan 2010 14:09:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id A15BF19F610;
	Sun, 10 Jan 2010 14:08:45 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <201001101404.22258.j6t@kdbg.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136578>

We want to reuse it from start_command.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 run-command.c |   84 ++++++++++++++++++++++++++++----------------------------
 1 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/run-command.c b/run-command.c
index 02c7bfb..dccac37 100644
--- a/run-command.c
+++ b/run-command.c
@@ -39,6 +39,48 @@ static inline void set_cloexec(int fd)
 }
 #endif
 
+static int wait_or_whine(pid_t pid, const char *argv0, int silent_exec_failure)
+{
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
+		code = WTERMSIG(status);
+		error("%s died of signal %d", argv0, code);
+		/*
+		 * This return value is chosen so that code & 0xff
+		 * mimics the exit code that a POSIX shell would report for
+		 * a program that died from this signal.
+		 */
+		code -= 128;
+	} else if (WIFEXITED(status)) {
+		code = WEXITSTATUS(status);
+		/*
+		 * Convert special exit code when execvp failed.
+		 */
+		if (code == 127) {
+			code = -1;
+			failed_errno = ENOENT;
+			if (!silent_exec_failure)
+				error("cannot run %s: %s", argv0,
+					strerror(ENOENT));
+		}
+	} else {
+		error("waitpid is confused (%s)", argv0);
+	}
+	errno = failed_errno;
+	return code;
+}
+
 int start_command(struct child_process *cmd)
 {
 	int need_in, need_out, need_err;
@@ -272,48 +314,6 @@ fail_pipe:
 	return 0;
 }
 
-static int wait_or_whine(pid_t pid, const char *argv0, int silent_exec_failure)
-{
-	int status, code = -1;
-	pid_t waiting;
-	int failed_errno = 0;
-
-	while ((waiting = waitpid(pid, &status, 0)) < 0 && errno == EINTR)
-		;	/* nothing */
-
-	if (waiting < 0) {
-		failed_errno = errno;
-		error("waitpid for %s failed: %s", argv0, strerror(errno));
-	} else if (waiting != pid) {
-		error("waitpid is confused (%s)", argv0);
-	} else if (WIFSIGNALED(status)) {
-		code = WTERMSIG(status);
-		error("%s died of signal %d", argv0, code);
-		/*
-		 * This return value is chosen so that code & 0xff
-		 * mimics the exit code that a POSIX shell would report for
-		 * a program that died from this signal.
-		 */
-		code -= 128;
-	} else if (WIFEXITED(status)) {
-		code = WEXITSTATUS(status);
-		/*
-		 * Convert special exit code when execvp failed.
-		 */
-		if (code == 127) {
-			code = -1;
-			failed_errno = ENOENT;
-			if (!silent_exec_failure)
-				error("cannot run %s: %s", argv0,
-					strerror(ENOENT));
-		}
-	} else {
-		error("waitpid is confused (%s)", argv0);
-	}
-	errno = failed_errno;
-	return code;
-}
-
 int finish_command(struct child_process *cmd)
 {
 	return wait_or_whine(cmd->pid, cmd->argv[0], cmd->silent_exec_failure);
-- 
1.6.6.115.gd1ab3
