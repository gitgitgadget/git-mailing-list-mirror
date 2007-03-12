From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/4] Teach run-command about stdout redirection
Date: Mon, 12 Mar 2007 14:37:45 -0400
Message-ID: <20070312183745.GB15996@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 12 19:38:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQpPG-0008Js-U5
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 19:38:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbXCLShu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 14:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbXCLSht
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 14:37:49 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50654 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbXCLSht (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 14:37:49 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HQpOt-000613-FK; Mon, 12 Mar 2007 14:37:39 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id F092520FBAE; Mon, 12 Mar 2007 14:37:45 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42055>

Some potential callers of the run_command family of functions need
to control not only the stdin redirection of the child, but also
the stdout redirection of the child.  This can now be setup much
like the already existing stdin redirection.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 run-command.c |   30 +++++++++++++++++++++++++++++-
 run-command.h |    2 ++
 2 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/run-command.c b/run-command.c
index bef9775..d20a6ef 100644
--- a/run-command.c
+++ b/run-command.c
@@ -11,7 +11,8 @@ static inline void close_pair(int fd[2])
 int start_command(struct child_process *cmd)
 {
 	int need_in = !cmd->no_stdin && cmd->in < 0;
-	int fdin[2];
+	int need_out = !cmd->stdout_to_stderr && cmd->out < 0;
+	int fdin[2], fdout[2];
 
 	if (need_in) {
 		if (pipe(fdin) < 0)
@@ -20,10 +21,22 @@ int start_command(struct child_process *cmd)
 		cmd->close_in = 1;
 	}
 
+	if (need_out) {
+		if (pipe(fdout) < 0) {
+			if (need_in)
+				close_pair(fdin);
+			return -ERR_RUN_COMMAND_PIPE;
+		}
+		cmd->out = fdout[0];
+		cmd->close_out = 1;
+	}
+
 	cmd->pid = fork();
 	if (cmd->pid < 0) {
 		if (need_in)
 			close_pair(fdin);
+		if (need_out)
+			close_pair(fdout);
 		return -ERR_RUN_COMMAND_FORK;
 	}
 
@@ -42,6 +55,14 @@ int start_command(struct child_process *cmd)
 
 		if (cmd->stdout_to_stderr)
 			dup2(2, 1);
+		else if (need_out) {
+			dup2(fdout[1], 1);
+			close_pair(fdout);
+		} else if (cmd->out > 1) {
+			dup2(cmd->out, 1);
+			close(cmd->out);
+		}
+
 		if (cmd->git_cmd) {
 			execv_git_cmd(cmd->argv);
 		} else {
@@ -55,6 +76,11 @@ int start_command(struct child_process *cmd)
 	else if (cmd->in)
 		close(cmd->in);
 
+	if (need_out)
+		close(fdout[1]);
+	else if (cmd->out > 1)
+		close(cmd->out);
+
 	return 0;
 }
 
@@ -62,6 +88,8 @@ int finish_command(struct child_process *cmd)
 {
 	if (cmd->close_in)
 		close(cmd->in);
+	if (cmd->close_out)
+		close(cmd->out);
 
 	for (;;) {
 		int status, code;
diff --git a/run-command.h b/run-command.h
index ff09067..1c9126b 100644
--- a/run-command.h
+++ b/run-command.h
@@ -15,7 +15,9 @@ struct child_process {
 	const char **argv;
 	pid_t pid;
 	int in;
+	int out;
 	unsigned close_in:1;
+	unsigned close_out:1;
 	unsigned no_stdin:1;
 	unsigned git_cmd:1; /* if this is to be git sub-command */
 	unsigned stdout_to_stderr:1;
-- 
1.5.0.3.985.gcf0b4
