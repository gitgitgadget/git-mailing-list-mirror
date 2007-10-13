From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 06/14] Have start_command() create a pipe to read the stderr of the child.
Date: Sat, 13 Oct 2007 22:06:16 +0200
Message-ID: <1192305984-22594-7-git-send-email-johannes.sixt@telecom.at>
References: <1192305984-22594-1-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-2-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-3-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-4-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-5-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-6-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Oct 13 22:08:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgnH3-0008Ve-Ua
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 22:07:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758535AbXJMUG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 16:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758011AbXJMUGy
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 16:06:54 -0400
Received: from smtp5.srv.eunet.at ([193.154.160.227]:52582 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757166AbXJMUG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 16:06:28 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id 2F13613A6EB;
	Sat, 13 Oct 2007 22:06:27 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.3.1134.gee562
In-Reply-To: <1192305984-22594-6-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60769>

This adds another stanza that allocates a pipe that is connected to the
child's stderr and that the caller can read from. In order to request this
pipe, the caller sets cmd->err to -1.

The implementation is not exactly modeled after the stdout case: For stdout
the caller can supply an existing file descriptor, but this facility is
nowhere needed in the stderr case. Additionally, the caller is required to
close cmd->err.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 run-command.c |   26 ++++++++++++++++++++++++--
 run-command.h |    1 +
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/run-command.c b/run-command.c
index 7e779d3..d00c03b 100644
--- a/run-command.c
+++ b/run-command.c
@@ -17,8 +17,8 @@ static inline void dup_devnull(int to)
 
 int start_command(struct child_process *cmd)
 {
-	int need_in, need_out;
-	int fdin[2], fdout[2];
+	int need_in, need_out, need_err;
+	int fdin[2], fdout[2], fderr[2];
 
 	need_in = !cmd->no_stdin && cmd->in < 0;
 	if (need_in) {
@@ -41,12 +41,26 @@ int start_command(struct child_process *cmd)
 		cmd->close_out = 1;
 	}
 
+	need_err = cmd->err < 0;
+	if (need_err) {
+		if (pipe(fderr) < 0) {
+			if (need_in)
+				close_pair(fdin);
+			if (need_out)
+				close_pair(fdout);
+			return -ERR_RUN_COMMAND_PIPE;
+		}
+		cmd->err = fderr[0];
+	}
+
 	cmd->pid = fork();
 	if (cmd->pid < 0) {
 		if (need_in)
 			close_pair(fdin);
 		if (need_out)
 			close_pair(fdout);
+		if (need_err)
+			close_pair(fderr);
 		return -ERR_RUN_COMMAND_FORK;
 	}
 
@@ -73,6 +87,11 @@ int start_command(struct child_process *cmd)
 			close(cmd->out);
 		}
 
+		if (need_err) {
+			dup2(fderr[1], 2);
+			close_pair(fderr);
+		}
+
 		if (cmd->dir && chdir(cmd->dir))
 			die("exec %s: cd to %s failed (%s)", cmd->argv[0],
 			    cmd->dir, strerror(errno));
@@ -102,6 +121,9 @@ int start_command(struct child_process *cmd)
 	else if (cmd->out > 1)
 		close(cmd->out);
 
+	if (need_err)
+		close(fderr[1]);
+
 	return 0;
 }
 
diff --git a/run-command.h b/run-command.h
index 7958eb1..35b9fb6 100644
--- a/run-command.h
+++ b/run-command.h
@@ -16,6 +16,7 @@ struct child_process {
 	pid_t pid;
 	int in;
 	int out;
+	int err;
 	const char *dir;
 	const char *const *env;
 	unsigned close_in:1;
-- 
1.5.3.3.1134.gee562
