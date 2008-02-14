From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/6] Automatically close stderr pipes created by run_command
Date: Thu, 14 Feb 2008 01:22:29 -0500
Message-ID: <20080214062229.GB30516@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 14 07:23:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPXV2-0002xP-PJ
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 07:23:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753399AbYBNGWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 01:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753001AbYBNGWd
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 01:22:33 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58362 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506AbYBNGWc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 01:22:32 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JPXUN-0003nC-6S
	for git@vger.kernel.org; Thu, 14 Feb 2008 01:22:31 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C083920FBAE; Thu, 14 Feb 2008 01:22:29 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73851>

Like the out pipe and in pipe, we now automatically close the err
pipe if it was requested by the caller and it hasn't been closed
by the caller.  This simplifies anyone who wants to get a pipe to
the stderr stream for another process.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 run-command.c |    3 +++
 run-command.h |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/run-command.c b/run-command.c
index 52f80be..7bf2cd7 100644
--- a/run-command.c
+++ b/run-command.c
@@ -51,6 +51,7 @@ int start_command(struct child_process *cmd)
 			return -ERR_RUN_COMMAND_PIPE;
 		}
 		cmd->err = fderr[0];
+		cmd->close_err = 1;
 	}
 
 	cmd->pid = fork();
@@ -161,6 +162,8 @@ int finish_command(struct child_process *cmd)
 		close(cmd->in);
 	if (cmd->close_out)
 		close(cmd->out);
+	if (cmd->close_err)
+		close(cmd->err);
 	return wait_or_whine(cmd->pid);
 }
 
diff --git a/run-command.h b/run-command.h
index 1fc781d..705cf2f 100644
--- a/run-command.h
+++ b/run-command.h
@@ -21,6 +21,7 @@ struct child_process {
 	const char *const *env;
 	unsigned close_in:1;
 	unsigned close_out:1;
+	unsigned close_err:1;
 	unsigned no_stdin:1;
 	unsigned no_stdout:1;
 	unsigned no_stderr:1;
-- 
1.5.4.1.1309.g833c2
