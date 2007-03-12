From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/4] Simplify closing two fds at once in run-command.c
Date: Mon, 12 Mar 2007 14:37:28 -0400
Message-ID: <20070312183728.GA15996@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 12 19:37:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQpOt-00086F-TL
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 19:37:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbXCLShd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 14:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbXCLShd
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 14:37:33 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50647 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbXCLShc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 14:37:32 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HQpOc-00060W-JX; Mon, 12 Mar 2007 14:37:22 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E238920FBAE; Mon, 12 Mar 2007 14:37:28 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42053>

I started hacking on a change to add stdout redirection support to
the run_command family, but found I was using a lot of close calls
on two pipes in an array (such as for pipe).  So I'm doing a tiny
bit of refactoring first to make the next set of changes clearer.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 run-command.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/run-command.c b/run-command.c
index 03ff7bc..bef9775 100644
--- a/run-command.c
+++ b/run-command.c
@@ -2,6 +2,12 @@
 #include "run-command.h"
 #include "exec_cmd.h"
 
+static inline void close_pair(int fd[2])
+{
+	close(fd[0]);
+	close(fd[1]);
+}
+
 int start_command(struct child_process *cmd)
 {
 	int need_in = !cmd->no_stdin && cmd->in < 0;
@@ -16,10 +22,8 @@ int start_command(struct child_process *cmd)
 
 	cmd->pid = fork();
 	if (cmd->pid < 0) {
-		if (need_in) {
-			close(fdin[0]);
-			close(fdin[1]);
-		}
+		if (need_in)
+			close_pair(fdin);
 		return -ERR_RUN_COMMAND_FORK;
 	}
 
@@ -30,8 +34,7 @@ int start_command(struct child_process *cmd)
 			close(fd);
 		} else if (need_in) {
 			dup2(fdin[0], 0);
-			close(fdin[0]);
-			close(fdin[1]);
+			close_pair(fdin);
 		} else if (cmd->in) {
 			dup2(cmd->in, 0);
 			close(cmd->in);
-- 
1.5.0.3.985.gcf0b4
