From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 4/8] Split run_command into two halves (start/finish)
Date: Sat, 10 Mar 2007 03:28:05 -0500
Message-ID: <20070310082805.GD4133@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 10 09:28:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPwwH-0003b1-66
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 09:28:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933572AbXCJI2L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 03:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933574AbXCJI2K
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 03:28:10 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60124 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933572AbXCJI2I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 03:28:08 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HPwvt-0003Zm-KW; Sat, 10 Mar 2007 03:28:05 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4C08C20FBAE; Sat, 10 Mar 2007 03:28:05 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41859>

If the calling process wants to send data to stdin of a
child process it will need to arrange for a pipe and get
the child process running, feed data to it, then wait
for the child process to finish.  So we split the run
function into two halves, allowing callers to first
start the child then later finish it.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 run-command.c |   26 +++++++++++++++++++-------
 run-command.h |    3 +++
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/run-command.c b/run-command.c
index 1fb7fa5..a866a06 100644
--- a/run-command.c
+++ b/run-command.c
@@ -2,13 +2,12 @@
 #include "run-command.h"
 #include "exec_cmd.h"
 
-int run_command(struct child_process *cmd)
+int start_command(struct child_process *cmd)
 {
-	pid_t pid = fork();
-
-	if (pid < 0)
+	cmd->pid = fork();
+	if (cmd->pid < 0)
 		return -ERR_RUN_COMMAND_FORK;
-	if (!pid) {
+	if (!cmd->pid) {
 		if (cmd->no_stdin) {
 			int fd = open("/dev/null", O_RDWR);
 			dup2(fd, 0);
@@ -23,9 +22,14 @@ int run_command(struct child_process *cmd)
 		}
 		die("exec %s failed.", cmd->argv[0]);
 	}
+	return 0;
+}
+
+int finish_command(struct child_process *cmd)
+{
 	for (;;) {
 		int status, code;
-		pid_t waiting = waitpid(pid, &status, 0);
+		pid_t waiting = waitpid(cmd->pid, &status, 0);
 
 		if (waiting < 0) {
 			if (errno == EINTR)
@@ -33,7 +37,7 @@ int run_command(struct child_process *cmd)
 			error("waitpid failed (%s)", strerror(errno));
 			return -ERR_RUN_COMMAND_WAITPID;
 		}
-		if (waiting != pid)
+		if (waiting != cmd->pid)
 			return -ERR_RUN_COMMAND_WAITPID_WRONG_PID;
 		if (WIFSIGNALED(status))
 			return -ERR_RUN_COMMAND_WAITPID_SIGNAL;
@@ -47,6 +51,14 @@ int run_command(struct child_process *cmd)
 	}
 }
 
+int run_command(struct child_process *cmd)
+{
+	int code = start_command(cmd);
+	if (code)
+		return code;
+	return finish_command(cmd);
+}
+
 int run_command_v_opt(const char **argv, int opt)
 {
 	struct child_process cmd;
diff --git a/run-command.h b/run-command.h
index f9db2a7..24cdb4e 100644
--- a/run-command.h
+++ b/run-command.h
@@ -12,11 +12,14 @@ enum {
 
 struct child_process {
 	const char **argv;
+	pid_t pid;
 	unsigned no_stdin:1;
 	unsigned git_cmd:1; /* if this is to be git sub-command */
 	unsigned stdout_to_stderr:1;
 };
 
+int start_command(struct child_process *);
+int finish_command(struct child_process *);
 int run_command(struct child_process *);
 
 #define RUN_COMMAND_NO_STDIN 1
-- 
1.5.0.3.942.g299f
