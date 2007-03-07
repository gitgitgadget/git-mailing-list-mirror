From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/5] Refactor run_update_hook to be more useful
Date: Wed, 7 Mar 2007 16:51:09 -0500
Message-ID: <20070307215109.GC28649@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 07 22:51:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HP432-0004gg-7Z
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 22:51:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965684AbXCGVvP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 16:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992640AbXCGVvP
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 16:51:15 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53863 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992634AbXCGVvN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 16:51:13 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HP42I-0003WZ-E1; Wed, 07 Mar 2007 16:51:02 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A423920FBAE; Wed,  7 Mar 2007 16:51:09 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41693>

This is a simple refactoring of run_update_hook to allow the function
to be passed the name of the hook it runs and also to build the
argument list from a list of struct commands, rather than just one
struct command.

The refactoring is to support new pre-receive and post-receive
hooks that will be given the entire list of struct commands,
rather than just one struct command.  These new hooks will follow
in another patch.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 receive-pack.c |   63 +++++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/receive-pack.c b/receive-pack.c
index e32e301..c55d905 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -67,18 +67,45 @@ struct command {
 
 static struct command *commands;
 
-static char update_hook[] = "hooks/update";
+static const char update_hook[] = "hooks/update";
 
-static int run_update_hook(const char *refname,
-			   char *old_hex, char *new_hex)
+static int run_hook(const char *hook_name,
+	struct command *first_cmd,
+	int single)
 {
-	int code;
+	struct command *cmd;
+	int argc, code;
+	const char **argv;
+
+	for (argc = 0, cmd = first_cmd; cmd; cmd = cmd->next) {
+		if (!cmd->error_string)
+			argc += 3;
+		if (single)
+			break;
+	}
 
-	if (access(update_hook, X_OK) < 0)
+	if (!argc || access(hook_name, X_OK) < 0)
 		return 0;
-	code = run_command_opt(RUN_COMMAND_NO_STDIN
-		| RUN_COMMAND_STDOUT_TO_STDERR,
-		update_hook, refname, old_hex, new_hex, NULL);
+
+	argv = xmalloc(sizeof(*argv) * (2 + argc));
+	argv[0] = hook_name;
+	for (argc = 1, cmd = first_cmd; cmd; cmd = cmd->next) {
+		if (!cmd->error_string) {
+			argv[argc++] = xstrdup(cmd->ref_name);
+			argv[argc++] = xstrdup(sha1_to_hex(cmd->old_sha1));
+			argv[argc++] = xstrdup(sha1_to_hex(cmd->new_sha1));
+		}
+		if (single)
+			break;
+	}
+	argv[argc] = NULL;
+
+	code = run_command_v_opt(argv,
+		RUN_COMMAND_NO_STDIN | RUN_COMMAND_STDOUT_TO_STDERR);
+	while (--argc > 0)
+		free((char*)argv[argc]);
+	free(argv);
+
 	switch (code) {
 	case 0:
 		return 0;
@@ -91,11 +118,11 @@ static int run_update_hook(const char *refname,
 	case -ERR_RUN_COMMAND_WAITPID_WRONG_PID:
 		return error("waitpid is confused");
 	case -ERR_RUN_COMMAND_WAITPID_SIGNAL:
-		return error("%s died of signal", update_hook);
+		return error("%s died of signal", hook_name);
 	case -ERR_RUN_COMMAND_WAITPID_NOEXIT:
-		return error("%s died strangely", update_hook);
+		return error("%s died strangely", hook_name);
 	default:
-		error("%s exited with error code %d", update_hook, -code);
+		error("%s exited with error code %d", hook_name, -code);
 		return -code;
 	}
 }
@@ -105,7 +132,6 @@ static int update(struct command *cmd)
 	const char *name = cmd->ref_name;
 	unsigned char *old_sha1 = cmd->old_sha1;
 	unsigned char *new_sha1 = cmd->new_sha1;
-	char new_hex[41], old_hex[41];
 	struct ref_lock *lock;
 
 	cmd->error_string = NULL;
@@ -115,13 +141,10 @@ static int update(struct command *cmd)
 			     name);
 	}
 
-	strcpy(new_hex, sha1_to_hex(new_sha1));
-	strcpy(old_hex, sha1_to_hex(old_sha1));
-
 	if (!is_null_sha1(new_sha1) && !has_sha1_file(new_sha1)) {
 		cmd->error_string = "bad pack";
 		return error("unpack should have generated %s, "
-			     "but I can't find it!", new_hex);
+			     "but I can't find it!", sha1_to_hex(new_sha1));
 	}
 	if (deny_non_fast_forwards && !is_null_sha1(new_sha1) &&
 	    !is_null_sha1(old_sha1) &&
@@ -140,7 +163,7 @@ static int update(struct command *cmd)
 			return error("denying non-fast forward;"
 				     " you should pull first");
 	}
-	if (run_update_hook(name, old_hex, new_hex)) {
+	if (run_hook(update_hook, cmd, 1)) {
 		cmd->error_string = "hook declined";
 		return error("hook declined to update %s", name);
 	}
@@ -150,7 +173,8 @@ static int update(struct command *cmd)
 			cmd->error_string = "failed to delete";
 			return error("failed to delete %s", name);
 		}
-		fprintf(stderr, "%s: %s -> deleted\n", name, old_hex);
+		fprintf(stderr, "%s: %s -> deleted\n", name,
+			sha1_to_hex(old_sha1));
 	}
 	else {
 		lock = lock_any_ref_for_update(name, old_sha1);
@@ -162,7 +186,8 @@ static int update(struct command *cmd)
 			cmd->error_string = "failed to write";
 			return -1; /* error() already called */
 		}
-		fprintf(stderr, "%s: %s -> %s\n", name, old_hex, new_hex);
+		fprintf(stderr, "%s: %s -> %s\n", name,
+			sha1_to_hex(old_sha1), sha1_to_hex(new_sha1));
 	}
 	return 0;
 }
-- 
1.5.0.3.895.g09890
