From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/4] Teach run-command to redirect stdout to /dev/null
Date: Mon, 12 Mar 2007 14:37:55 -0400
Message-ID: <20070312183755.GC15996@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 12 19:38:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQpPJ-0008Js-Bt
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 19:38:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbXCLSiA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 14:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbXCLSiA
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 14:38:00 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50660 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbXCLSh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 14:37:59 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HQpP3-00061a-EP; Mon, 12 Mar 2007 14:37:49 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EAFD320FBAE; Mon, 12 Mar 2007 14:37:55 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42054>

Some run-command callers may wish to just discard any data that
is sent to stdout from the child.  This is a lot like our existing
no_stdin support, we just open /dev/null and duplicate the descriptor
into position.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 run-command.c |   26 ++++++++++++++++++--------
 run-command.h |    1 +
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/run-command.c b/run-command.c
index d20a6ef..eff523e 100644
--- a/run-command.c
+++ b/run-command.c
@@ -8,12 +8,19 @@ static inline void close_pair(int fd[2])
 	close(fd[1]);
 }
 
+static inline void dup_devnull(int to)
+{
+	int fd = open("/dev/null", O_RDWR);
+	dup2(fd, to);
+	close(fd);
+}
+
 int start_command(struct child_process *cmd)
 {
-	int need_in = !cmd->no_stdin && cmd->in < 0;
-	int need_out = !cmd->stdout_to_stderr && cmd->out < 0;
+	int need_in, need_out;
 	int fdin[2], fdout[2];
 
+	need_in = !cmd->no_stdin && cmd->in < 0;
 	if (need_in) {
 		if (pipe(fdin) < 0)
 			return -ERR_RUN_COMMAND_PIPE;
@@ -21,6 +28,9 @@ int start_command(struct child_process *cmd)
 		cmd->close_in = 1;
 	}
 
+	need_out = !cmd->no_stdout
+		&& !cmd->stdout_to_stderr
+		&& cmd->out < 0;
 	if (need_out) {
 		if (pipe(fdout) < 0) {
 			if (need_in)
@@ -41,11 +51,9 @@ int start_command(struct child_process *cmd)
 	}
 
 	if (!cmd->pid) {
-		if (cmd->no_stdin) {
-			int fd = open("/dev/null", O_RDWR);
-			dup2(fd, 0);
-			close(fd);
-		} else if (need_in) {
+		if (cmd->no_stdin)
+			dup_devnull(0);
+		else if (need_in) {
 			dup2(fdin[0], 0);
 			close_pair(fdin);
 		} else if (cmd->in) {
@@ -53,7 +61,9 @@ int start_command(struct child_process *cmd)
 			close(cmd->in);
 		}
 
-		if (cmd->stdout_to_stderr)
+		if (cmd->no_stdout)
+			dup_devnull(1);
+		else if (cmd->stdout_to_stderr)
 			dup2(2, 1);
 		else if (need_out) {
 			dup2(fdout[1], 1);
diff --git a/run-command.h b/run-command.h
index 1c9126b..3680ef9 100644
--- a/run-command.h
+++ b/run-command.h
@@ -19,6 +19,7 @@ struct child_process {
 	unsigned close_in:1;
 	unsigned close_out:1;
 	unsigned no_stdin:1;
+	unsigned no_stdout:1;
 	unsigned git_cmd:1; /* if this is to be git sub-command */
 	unsigned stdout_to_stderr:1;
 };
-- 
1.5.0.3.985.gcf0b4
