From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/8] Remove unused run_command variants
Date: Sat, 10 Mar 2007 03:27:52 -0500
Message-ID: <20070310082752.GB4133@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 10 09:28:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPwwG-0003b1-5l
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 09:28:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933568AbXCJI15 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 03:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933572AbXCJI15
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 03:27:57 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60117 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933568AbXCJI14 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 03:27:56 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HPwvh-0003ZR-1P; Sat, 10 Mar 2007 03:27:53 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A7B3420FBAE; Sat, 10 Mar 2007 03:27:52 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41855>

We don't actually use these va_list based variants of run_command
anymore.  I'm removing them before I make further improvements.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This and the remaining patches are on top of master.

 builtin-push.c |    2 +-
 run-command.c  |   45 ---------------------------------------------
 run-command.h  |    4 ----
 3 files changed, 1 insertions(+), 50 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 979efcc..6ab9a28 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -336,7 +336,7 @@ static int do_push(const char *repo)
 		argv[dest_argc] = NULL;
 		if (verbose)
 			fprintf(stderr, "Pushing to %s\n", dest);
-		err = run_command_v(argv);
+		err = run_command_v_opt(argv, 0);
 		if (!err)
 			continue;
 		switch (err) {
diff --git a/run-command.c b/run-command.c
index cfbad74..94ace50 100644
--- a/run-command.c
+++ b/run-command.c
@@ -46,48 +46,3 @@ int run_command_v_opt(const char **argv, int flags)
 		return 0;
 	}
 }
-
-int run_command_v(const char **argv)
-{
-	return run_command_v_opt(argv, 0);
-}
-
-static int run_command_va_opt(int opt, const char *cmd, va_list param)
-{
-	int argc;
-	const char *argv[MAX_RUN_COMMAND_ARGS];
-	const char *arg;
-
-	argv[0] = (char*) cmd;
-	argc = 1;
-	while (argc < MAX_RUN_COMMAND_ARGS) {
-		arg = argv[argc++] = va_arg(param, char *);
-		if (!arg)
-			break;
-	}
-	if (MAX_RUN_COMMAND_ARGS <= argc)
-		return error("too many args to run %s", cmd);
-	return run_command_v_opt(argv, opt);
-}
-
-int run_command_opt(int opt, const char *cmd, ...)
-{
-	va_list params;
-	int r;
-
-	va_start(params, cmd);
-	r = run_command_va_opt(opt, cmd, params);
-	va_end(params);
-	return r;
-}
-
-int run_command(const char *cmd, ...)
-{
-	va_list params;
-	int r;
-
-	va_start(params, cmd);
-	r = run_command_va_opt(0, cmd, params);
-	va_end(params);
-	return r;
-}
diff --git a/run-command.h b/run-command.h
index 59c4476..2646d38 100644
--- a/run-command.h
+++ b/run-command.h
@@ -1,7 +1,6 @@
 #ifndef RUN_COMMAND_H
 #define RUN_COMMAND_H
 
-#define MAX_RUN_COMMAND_ARGS 256
 enum {
 	ERR_RUN_COMMAND_FORK = 10000,
 	ERR_RUN_COMMAND_EXEC,
@@ -15,8 +14,5 @@ enum {
 #define RUN_GIT_CMD	     2	/*If this is to be git sub-command */
 #define RUN_COMMAND_STDOUT_TO_STDERR 4
 int run_command_v_opt(const char **argv, int opt);
-int run_command_v(const char **argv);
-int run_command_opt(int opt, const char *cmd, ...);
-int run_command(const char *cmd, ...);
 
 #endif
-- 
1.5.0.3.942.g299f
