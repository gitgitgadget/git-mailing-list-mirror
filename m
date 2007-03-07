From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 4/5] Refactor handling of error_string in receive-pack
Date: Wed, 7 Mar 2007 16:51:59 -0500
Message-ID: <20070307215159.GD28649@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 07 22:52:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HP43O-0004qe-4S
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 22:52:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965686AbXCGVwG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 16:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965688AbXCGVwF
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 16:52:05 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53898 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965686AbXCGVwE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 16:52:04 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HP436-0003cB-9E; Wed, 07 Mar 2007 16:51:52 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8AB3020FBAE; Wed,  7 Mar 2007 16:51:59 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41694>

I discovered we did not send an ng line in the report-status feedback
if the ref was not updated because the repository has the config
option receive.denyNonFastForwards enabled.  I think the reason this
happened is that it is simply too easy to forget to set error_string
when returning back a failure from update()

We now return an ng line for a non-fastforward update, which in
turn will cause send-pack to exit with a non-zero exit status.
Hence the modified test.

This refactoring changes update to return a const char* describing
the error, which execute_commands always loads into error_string.
The result is what I think is cleaner code, and allows us to
initialize the error_string member to NULL when we read_head_info.

I want error_string to be NULL in all commands before we call
execute_commands, so that we can reuse the run_hook function to
execute a new pre-receive hook.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 receive-pack.c       |   62 ++++++++++++++++++++++++++-----------------------
 t/t5400-send-pack.sh |    4 +-
 2 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/receive-pack.c b/receive-pack.c
index c55d905..ff746e7 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -127,24 +127,22 @@ static int run_hook(const char *hook_name,
 	}
 }
 
-static int update(struct command *cmd)
+static const char *update(struct command *cmd)
 {
 	const char *name = cmd->ref_name;
 	unsigned char *old_sha1 = cmd->old_sha1;
 	unsigned char *new_sha1 = cmd->new_sha1;
 	struct ref_lock *lock;
 
-	cmd->error_string = NULL;
 	if (!prefixcmp(name, "refs/") && check_ref_format(name + 5)) {
-		cmd->error_string = "funny refname";
-		return error("refusing to create funny ref '%s' locally",
-			     name);
+		error("refusing to create funny ref '%s' locally", name);
+		return "funny refname";
 	}
 
 	if (!is_null_sha1(new_sha1) && !has_sha1_file(new_sha1)) {
-		cmd->error_string = "bad pack";
-		return error("unpack should have generated %s, "
-			     "but I can't find it!", sha1_to_hex(new_sha1));
+		error("unpack should have generated %s, "
+		      "but I can't find it!", sha1_to_hex(new_sha1));
+		return "bad pack";
 	}
 	if (deny_non_fast_forwards && !is_null_sha1(new_sha1) &&
 	    !is_null_sha1(old_sha1) &&
@@ -159,37 +157,39 @@ static int update(struct command *cmd)
 			if (!hashcmp(old_sha1, ent->item->object.sha1))
 				break;
 		free_commit_list(bases);
-		if (!ent)
-			return error("denying non-fast forward;"
-				     " you should pull first");
+		if (!ent) {
+			error("denying non-fast forward %s"
+			      " (you should pull first)", name);
+			return "non-fast forward";
+		}
 	}
 	if (run_hook(update_hook, cmd, 1)) {
-		cmd->error_string = "hook declined";
-		return error("hook declined to update %s", name);
+		error("hook declined to update %s", name);
+		return "hook declined";
 	}
 
 	if (is_null_sha1(new_sha1)) {
 		if (delete_ref(name, old_sha1)) {
-			cmd->error_string = "failed to delete";
-			return error("failed to delete %s", name);
+			error("failed to delete %s", name);
+			return "failed to delete";
 		}
 		fprintf(stderr, "%s: %s -> deleted\n", name,
 			sha1_to_hex(old_sha1));
+		return NULL; /* good */
 	}
 	else {
 		lock = lock_any_ref_for_update(name, old_sha1);
 		if (!lock) {
-			cmd->error_string = "failed to lock";
-			return error("failed to lock %s", name);
+			error("failed to lock %s", name);
+			return "failed to lock";
 		}
 		if (write_ref_sha1(lock, new_sha1, "push")) {
-			cmd->error_string = "failed to write";
-			return -1; /* error() already called */
+			return "failed to write"; /* error() already called */
 		}
 		fprintf(stderr, "%s: %s -> %s\n", name,
 			sha1_to_hex(old_sha1), sha1_to_hex(new_sha1));
+		return NULL; /* good */
 	}
-	return 0;
 }
 
 static char update_post_hook[] = "hooks/post-update";
@@ -224,15 +224,20 @@ static void run_update_post_hook(struct command *cmd)
 		| RUN_COMMAND_STDOUT_TO_STDERR);
 }
 
-/*
- * This gets called after(if) we've successfully
- * unpacked the data payload.
- */
-static void execute_commands(void)
+static void execute_commands(const char *unpacker_error)
 {
 	struct command *cmd = commands;
+
+	if (unpacker_error) {
+		while (cmd) {
+			cmd->error_string = "n/a (unpacker error)";
+			cmd = cmd->next;
+		}
+		return;
+	}
+
 	while (cmd) {
-		update(cmd);
+		cmd->error_string = update(cmd);
 		cmd = cmd->next;
 	}
 }
@@ -270,7 +275,7 @@ static void read_head_info(void)
 		hashcpy(cmd->old_sha1, old_sha1);
 		hashcpy(cmd->new_sha1, new_sha1);
 		memcpy(cmd->ref_name, line + 82, len - 81);
-		cmd->error_string = "n/a (unpacker error)";
+		cmd->error_string = NULL;
 		cmd->next = NULL;
 		*p = cmd;
 		p = &cmd->next;
@@ -473,8 +478,7 @@ int main(int argc, char **argv)
 
 		if (!delete_only(commands))
 			unpack_status = unpack();
-		if (!unpack_status)
-			execute_commands();
+		execute_commands(unpack_status);
 		if (pack_lockfile)
 			unlink(pack_lockfile);
 		if (report_status)
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index fc4a126..477b267 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -108,8 +108,8 @@ test_expect_success \
 	cd victim &&
 	git-config receive.denyNonFastforwards true &&
 	cd .. &&
-	git-update-ref refs/heads/master master^ &&
-	git-send-pack --force ./victim/.git/ master &&
+	git-update-ref refs/heads/master master^ || return 1
+	git-send-pack --force ./victim/.git/ master && return 1
 	! git diff .git/refs/heads/master victim/.git/refs/heads/master
 '
 
-- 
1.5.0.3.895.g09890
