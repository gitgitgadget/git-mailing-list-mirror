From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 7/8] Split back out update_hook handling in receive-pack
Date: Sat, 10 Mar 2007 03:28:13 -0500
Message-ID: <20070310082813.GG4133@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 10 09:28:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPwwI-0003b1-NW
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 09:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766895AbXCJI2T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 03:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766903AbXCJI2S
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 03:28:18 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60136 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933575AbXCJI2R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 03:28:17 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HPww2-0003aN-5q; Sat, 10 Mar 2007 03:28:14 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D9A2020FBAE; Sat, 10 Mar 2007 03:28:13 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41861>

Since we have decided to change the calling conventions for the
pre-receive and post-receive hooks to take the ref data on stdin
rather than on the command line we cannot use the same logic to
invoke the update hook anymore.

So we take a small step backwards towards what we used to have,
and create a specialized function for executing just the update
hook.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 receive-pack.c |   26 ++++++++++++++++++++++++--
 1 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/receive-pack.c b/receive-pack.c
index e147076..4d7170f 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -67,7 +67,6 @@ struct command {
 
 static struct command *commands;
 
-static const char update_hook[] = "hooks/update";
 static const char pre_receive_hook[] = "hooks/pre-receive";
 static const char post_receive_hook[] = "hooks/post-receive";
 
@@ -134,6 +133,29 @@ static int run_hook(const char *hook_name,
 	return hook_status(code, hook_name);
 }
 
+static int run_update_hook(struct command *cmd)
+{
+	static const char update_hook[] = "hooks/update";
+	struct child_process proc;
+	const char *argv[5];
+
+	if (access(update_hook, X_OK) < 0)
+		return 0;
+
+	argv[0] = update_hook;
+	argv[1] = cmd->ref_name;
+	argv[2] = sha1_to_hex(cmd->old_sha1);
+	argv[3] = sha1_to_hex(cmd->new_sha1);
+	argv[4] = NULL;
+
+	memset(&proc, 0, sizeof(proc));
+	proc.argv = argv;
+	proc.no_stdin = 1;
+	proc.stdout_to_stderr = 1;
+
+	return hook_status(run_command(&proc), update_hook);
+}
+
 static const char *update(struct command *cmd)
 {
 	const char *name = cmd->ref_name;
@@ -170,7 +192,7 @@ static const char *update(struct command *cmd)
 			return "non-fast forward";
 		}
 	}
-	if (run_hook(update_hook, cmd, 1)) {
+	if (run_update_hook(cmd)) {
 		error("hook declined to update %s", name);
 		return "hook declined";
 	}
-- 
1.5.0.3.942.g299f
