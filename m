From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 6/8] Refactor run_command error handling in receive-pack
Date: Sat, 10 Mar 2007 03:28:11 -0500
Message-ID: <20070310082811.GF4133@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 10 09:28:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPwwI-0003b1-66
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 09:28:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933576AbXCJI2Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 03:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933574AbXCJI2Q
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 03:28:16 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60133 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1766895AbXCJI2O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 03:28:14 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HPwvz-0003aD-Lz; Sat, 10 Mar 2007 03:28:11 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5ED0A20FB65; Sat, 10 Mar 2007 03:28:11 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41860>

I'm pulling the error handling used to decode the result of
run_command up into a new function so that I can reuse it.
No changes, just a simple code movement.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 receive-pack.c |   43 ++++++++++++++++++++++++-------------------
 1 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/receive-pack.c b/receive-pack.c
index 675c88f..e147076 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -71,6 +71,29 @@ static const char update_hook[] = "hooks/update";
 static const char pre_receive_hook[] = "hooks/pre-receive";
 static const char post_receive_hook[] = "hooks/post-receive";
 
+static int hook_status(int code, const char *hook_name)
+{
+	switch (code) {
+	case 0:
+		return 0;
+	case -ERR_RUN_COMMAND_FORK:
+		return error("hook fork failed");
+	case -ERR_RUN_COMMAND_EXEC:
+		return error("hook execute failed");
+	case -ERR_RUN_COMMAND_WAITPID:
+		return error("waitpid failed");
+	case -ERR_RUN_COMMAND_WAITPID_WRONG_PID:
+		return error("waitpid is confused");
+	case -ERR_RUN_COMMAND_WAITPID_SIGNAL:
+		return error("%s died of signal", hook_name);
+	case -ERR_RUN_COMMAND_WAITPID_NOEXIT:
+		return error("%s died strangely", hook_name);
+	default:
+		error("%s exited with error code %d", hook_name, -code);
+		return -code;
+	}
+}
+
 static int run_hook(const char *hook_name,
 	struct command *first_cmd,
 	int single)
@@ -108,25 +131,7 @@ static int run_hook(const char *hook_name,
 		free((char*)argv[argc]);
 	free(argv);
 
-	switch (code) {
-	case 0:
-		return 0;
-	case -ERR_RUN_COMMAND_FORK:
-		return error("hook fork failed");
-	case -ERR_RUN_COMMAND_EXEC:
-		return error("hook execute failed");
-	case -ERR_RUN_COMMAND_WAITPID:
-		return error("waitpid failed");
-	case -ERR_RUN_COMMAND_WAITPID_WRONG_PID:
-		return error("waitpid is confused");
-	case -ERR_RUN_COMMAND_WAITPID_SIGNAL:
-		return error("%s died of signal", hook_name);
-	case -ERR_RUN_COMMAND_WAITPID_NOEXIT:
-		return error("%s died strangely", hook_name);
-	default:
-		error("%s exited with error code %d", hook_name, -code);
-		return -code;
-	}
+	return hook_status(code, hook_name);
 }
 
 static const char *update(struct command *cmd)
-- 
1.5.0.3.942.g299f
