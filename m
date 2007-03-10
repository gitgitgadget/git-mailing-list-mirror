From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 5/8] Teach run_command how to setup a stdin pipe
Date: Sat, 10 Mar 2007 03:28:08 -0500
Message-ID: <20070310082808.GE4133@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 10 09:28:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPwwH-0003b1-ME
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 09:28:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993183AbXCJI2O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 03:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933573AbXCJI2N
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 03:28:13 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60129 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933574AbXCJI2M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 03:28:12 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HPwvx-0003Zu-03; Sat, 10 Mar 2007 03:28:09 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AA04220FBAE; Sat, 10 Mar 2007 03:28:08 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41857>

Sometimes callers trying to use run_command to execute a child
process will want to setup a pipe or file descriptor to redirect
into the child's stdin.

This idea is completely stolen from builtin-bundle's fork_with_pipe,
written by Johannes Schindelin.  All credit (and blame) should lie
with Dscho.  ;-)

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 run-command.c |   35 ++++++++++++++++++++++++++++++++++-
 run-command.h |    3 +++
 2 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/run-command.c b/run-command.c
index a866a06..03ff7bc 100644
--- a/run-command.c
+++ b/run-command.c
@@ -4,15 +4,39 @@
 
 int start_command(struct child_process *cmd)
 {
+	int need_in = !cmd->no_stdin && cmd->in < 0;
+	int fdin[2];
+
+	if (need_in) {
+		if (pipe(fdin) < 0)
+			return -ERR_RUN_COMMAND_PIPE;
+		cmd->in = fdin[1];
+		cmd->close_in = 1;
+	}
+
 	cmd->pid = fork();
-	if (cmd->pid < 0)
+	if (cmd->pid < 0) {
+		if (need_in) {
+			close(fdin[0]);
+			close(fdin[1]);
+		}
 		return -ERR_RUN_COMMAND_FORK;
+	}
+
 	if (!cmd->pid) {
 		if (cmd->no_stdin) {
 			int fd = open("/dev/null", O_RDWR);
 			dup2(fd, 0);
 			close(fd);
+		} else if (need_in) {
+			dup2(fdin[0], 0);
+			close(fdin[0]);
+			close(fdin[1]);
+		} else if (cmd->in) {
+			dup2(cmd->in, 0);
+			close(cmd->in);
 		}
+
 		if (cmd->stdout_to_stderr)
 			dup2(2, 1);
 		if (cmd->git_cmd) {
@@ -22,11 +46,20 @@ int start_command(struct child_process *cmd)
 		}
 		die("exec %s failed.", cmd->argv[0]);
 	}
+
+	if (need_in)
+		close(fdin[0]);
+	else if (cmd->in)
+		close(cmd->in);
+
 	return 0;
 }
 
 int finish_command(struct child_process *cmd)
 {
+	if (cmd->close_in)
+		close(cmd->in);
+
 	for (;;) {
 		int status, code;
 		pid_t waiting = waitpid(cmd->pid, &status, 0);
diff --git a/run-command.h b/run-command.h
index 24cdb4e..ff09067 100644
--- a/run-command.h
+++ b/run-command.h
@@ -4,6 +4,7 @@
 enum {
 	ERR_RUN_COMMAND_FORK = 10000,
 	ERR_RUN_COMMAND_EXEC,
+	ERR_RUN_COMMAND_PIPE,
 	ERR_RUN_COMMAND_WAITPID,
 	ERR_RUN_COMMAND_WAITPID_WRONG_PID,
 	ERR_RUN_COMMAND_WAITPID_SIGNAL,
@@ -13,6 +14,8 @@ enum {
 struct child_process {
 	const char **argv;
 	pid_t pid;
+	int in;
+	unsigned close_in:1;
 	unsigned no_stdin:1;
 	unsigned git_cmd:1; /* if this is to be git sub-command */
 	unsigned stdout_to_stderr:1;
-- 
1.5.0.3.942.g299f
