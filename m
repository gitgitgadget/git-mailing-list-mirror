From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/3] Remove unnecessary argc parameter from run_command_v.
Date: Sat, 30 Dec 2006 21:55:15 -0500
Message-ID: <20061231025515.GA5530@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 03:55:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0qr8-0003qv-GW
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 03:55:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWLaCzU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 21:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932685AbWLaCzU
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 21:55:20 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:40246 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932215AbWLaCzT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 21:55:19 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H0qqn-0002fp-4v; Sat, 30 Dec 2006 21:55:05 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 87AC620FB65; Sat, 30 Dec 2006 21:55:15 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35656>

The argc parameter is never used by the run_command_v family of
functions.  Instead they require that the passed argv[] be NULL
terminated so they can rely on the operating system's execvp
function to correctly pass the arguments to the new process.

Making the caller pass the argc is just confusing, as the caller
could be mislead into believing that the argc might take precendece
over the argv, or that the argv does not need to be NULL terminated.
So goodbye argc.  Don't come back.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-push.c |    2 +-
 receive-pack.c |    4 ++--
 run-command.c  |    8 ++++----
 run-command.h  |    4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index b7412e8..7a3d2bb 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -275,7 +275,7 @@ static int do_push(const char *repo)
 		argv[dest_argc] = NULL;
 		if (verbose)
 			fprintf(stderr, "Pushing to %s\n", dest);
-		err = run_command_v(argc, argv);
+		err = run_command_v(argv);
 		if (!err)
 			continue;
 		switch (err) {
diff --git a/receive-pack.c b/receive-pack.c
index eea7e48..af05a61 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -187,7 +187,7 @@ static void run_update_post_hook(struct command *cmd)
 		argc++;
 	}
 	argv[argc] = NULL;
-	run_command_v_opt(argc, argv, RUN_COMMAND_NO_STDIO);
+	run_command_v_opt(argv, RUN_COMMAND_NO_STDIO);
 }
 
 /*
@@ -283,7 +283,7 @@ static const char *unpack(void)
 		unpacker[0] = "unpack-objects";
 		unpacker[1] = hdr_arg;
 		unpacker[2] = NULL;
-		code = run_command_v_opt(1, unpacker, RUN_GIT_CMD);
+		code = run_command_v_opt(unpacker, RUN_GIT_CMD);
 		switch (code) {
 		case 0:
 			return NULL;
diff --git a/run-command.c b/run-command.c
index 492ad3e..d0330c3 100644
--- a/run-command.c
+++ b/run-command.c
@@ -2,7 +2,7 @@
 #include "run-command.h"
 #include "exec_cmd.h"
 
-int run_command_v_opt(int argc, const char **argv, int flags)
+int run_command_v_opt(const char **argv, int flags)
 {
 	pid_t pid = fork();
 
@@ -46,9 +46,9 @@ int run_command_v_opt(int argc, const char **argv, int flags)
 	}
 }
 
-int run_command_v(int argc, const char **argv)
+int run_command_v(const char **argv)
 {
-	return run_command_v_opt(argc, argv, 0);
+	return run_command_v_opt(argv, 0);
 }
 
 int run_command(const char *cmd, ...)
@@ -69,5 +69,5 @@ int run_command(const char *cmd, ...)
 	va_end(param);
 	if (MAX_RUN_COMMAND_ARGS <= argc)
 		return error("too many args to run %s", cmd);
-	return run_command_v_opt(argc, argv, 0);
+	return run_command_v_opt(argv, 0);
 }
diff --git a/run-command.h b/run-command.h
index 70b477a..82a0861 100644
--- a/run-command.h
+++ b/run-command.h
@@ -13,8 +13,8 @@ enum {
 
 #define RUN_COMMAND_NO_STDIO 1
 #define RUN_GIT_CMD	     2	/*If this is to be git sub-command */
-int run_command_v_opt(int argc, const char **argv, int opt);
-int run_command_v(int argc, const char **argv);
+int run_command_v_opt(const char **argv, int opt);
+int run_command_v(const char **argv);
 int run_command(const char *cmd, ...);
 
 #endif
-- 
1.5.0.rc0.g6bb1
