From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/3] Redirect update hook stdout to stderr.
Date: Sat, 30 Dec 2006 21:55:19 -0500
Message-ID: <20061231025519.GB5530@spearce.org>
References: <a0aecffe21074288c911c396f92901bfb558d591.1167533707.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 03:55:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0qr9-0003qv-14
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 03:55:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932685AbWLaCzX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 21:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932690AbWLaCzX
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 21:55:23 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:40255 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932685AbWLaCzW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 21:55:22 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H0qqq-0002gB-Ln; Sat, 30 Dec 2006 21:55:08 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2F98D20FB65; Sat, 30 Dec 2006 21:55:19 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <a0aecffe21074288c911c396f92901bfb558d591.1167533707.git.spearce@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35655>

If an update hook outputs to stdout then that output will be sent
back over the wire to the push client as though it were part of
the git protocol.  This tends to cause protocol errors on the
client end of the connection, as the hook output is not expected
in that context.  Most hook developers work around this by making
sure their hook outputs everything to stderr.

But hooks shouldn't need to perform such special behavior.  Instead
we can just dup stderr to stdout prior to invoking the update hook.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 receive-pack.c |    3 ++-
 run-command.c  |   32 ++++++++++++++++++++++++++------
 run-command.h  |    2 ++
 3 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/receive-pack.c b/receive-pack.c
index af05a61..64289e9 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -73,7 +73,8 @@ static int run_update_hook(const char *refname,
 
 	if (access(update_hook, X_OK) < 0)
 		return 0;
-	code = run_command(update_hook, refname, old_hex, new_hex, NULL);
+	code = run_command_opt(RUN_COMMAND_STDOUT_TO_STDERR,
+		update_hook, refname, old_hex, new_hex, NULL);
 	switch (code) {
 	case 0:
 		return 0;
diff --git a/run-command.c b/run-command.c
index d0330c3..7e4ca43 100644
--- a/run-command.c
+++ b/run-command.c
@@ -14,7 +14,8 @@ int run_command_v_opt(const char **argv, int flags)
 			dup2(fd, 0);
 			dup2(fd, 1);
 			close(fd);
-		}
+		} else if (flags & RUN_COMMAND_STDOUT_TO_STDERR)
+			dup2(2, 1);
 		if (flags & RUN_GIT_CMD) {
 			execv_git_cmd(argv);
 		} else {
@@ -51,14 +52,12 @@ int run_command_v(const char **argv)
 	return run_command_v_opt(argv, 0);
 }
 
-int run_command(const char *cmd, ...)
+static int run_command_va_opt(int opt, const char *cmd, va_list param)
 {
 	int argc;
 	const char *argv[MAX_RUN_COMMAND_ARGS];
 	const char *arg;
-	va_list param;
 
-	va_start(param, cmd);
 	argv[0] = (char*) cmd;
 	argc = 1;
 	while (argc < MAX_RUN_COMMAND_ARGS) {
@@ -66,8 +65,29 @@ int run_command(const char *cmd, ...)
 		if (!arg)
 			break;
 	}
-	va_end(param);
 	if (MAX_RUN_COMMAND_ARGS <= argc)
 		return error("too many args to run %s", cmd);
-	return run_command_v_opt(argv, 0);
+	return run_command_v_opt(argv, opt);
+}
+
+int run_command_opt(int opt, const char *cmd, ...)
+{
+	va_list params;
+	int r;
+
+	va_start(params, cmd);
+	r = run_command_va_opt(opt, cmd, params);
+	va_end(params);
+	return r;
+}
+
+int run_command(const char *cmd, ...)
+{
+	va_list params;
+	int r;
+
+	va_start(params, cmd);
+	r = run_command_va_opt(0, cmd, params);
+	va_end(params);
+	return r;
 }
diff --git a/run-command.h b/run-command.h
index 82a0861..8156eac 100644
--- a/run-command.h
+++ b/run-command.h
@@ -13,8 +13,10 @@ enum {
 
 #define RUN_COMMAND_NO_STDIO 1
 #define RUN_GIT_CMD	     2	/*If this is to be git sub-command */
+#define RUN_COMMAND_STDOUT_TO_STDERR 4
 int run_command_v_opt(const char **argv, int opt);
 int run_command_v(const char **argv);
+int run_command_opt(int opt, const char *cmd, ...);
 int run_command(const char *cmd, ...);
 
 #endif
-- 
1.5.0.rc0.g6bb1
