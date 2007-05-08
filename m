From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Use .git/MERGE_MSG in cherry-pick/revert
Date: Mon, 7 May 2007 21:54:47 -0400
Message-ID: <20070508015447.GA22253@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 08 03:54:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlEum-0005aq-2z
	for gcvg-git@gmane.org; Tue, 08 May 2007 03:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966591AbXEHByw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 21:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966602AbXEHByw
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 21:54:52 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51479 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966591AbXEHByv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 21:54:51 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HlEuT-0002Xb-VM; Mon, 07 May 2007 21:54:38 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AB79720FBAE; Mon,  7 May 2007 21:54:47 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46512>

Rather than storing the temporary commit message data in .msg (in
the working tree) we now store the message data in .git/MERGE_MSG.

By storing the message in the .git/ directory we are sure we will
never have a collision with a user file, should a project actually
have a ".msg" file in their top level tree.  We also don't need to
worry about leaving this stale file behind during a `reset --hard`
and have it show up in the output of status.

We are using .git/MERGE_MSG here to store the temporary message as
it is an already established convention between git-merge, git-am
and git-rebase that git-commit will default the user's edit buffer
to the contents of .git/MERGE_MSG.  If the user is going to need
to resolve this commit or wants to edit the message on their own
prepping that file with the desired message "just works".

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Resend of earlier patch, but with proper commit message.  ;-)

 builtin-revert.c |   17 ++++++-----------
 1 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index 4ba0ee6..67c13a3 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -237,6 +237,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	int i;
 	char *oneline, *reencoded_message = NULL;
 	const char *message, *encoding;
+	const char *defmsg = git_path("MERGE_MSG");
 
 	git_config(git_default_config);
 	me = action == REVERT ? "revert" : "cherry-pick";
@@ -280,7 +281,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	 * reverse of it if we are revert.
 	 */
 
-	msg_fd = hold_lock_file_for_update(&msg_file, ".msg", 1);
+	msg_fd = hold_lock_file_for_update(&msg_file, defmsg, 1);
 
 	encoding = get_encoding(message);
 	if (!encoding)
@@ -330,7 +331,6 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 				sha1_to_hex(head), "HEAD",
 				sha1_to_hex(next->object.sha1), oneline) ||
 			write_tree(head, 0, NULL)) {
-		const char *target = git_path("MERGE_MSG");
 		add_to_msg("\nConflicts:\n\n");
 		read_cache();
 		for (i = 0; i < active_nr;) {
@@ -345,10 +345,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 			}
 		}
 		if (close(msg_fd) || commit_lock_file(&msg_file) < 0)
-			die ("Error wrapping up .msg");
-		unlink(target);
-		if (rename(".msg", target))
-			die ("Could not move .msg to %s", target);
+			die ("Error wrapping up %s", defmsg);
 		fprintf(stderr, "Automatic %s failed.  "
 			"After resolving the conflicts,\n"
 			"mark the corrected paths with 'git-add <paths>'\n"
@@ -362,7 +359,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 		exit(1);
 	}
 	if (close(msg_fd) || commit_lock_file(&msg_file) < 0)
-		die ("Error wrapping up .msg");
+		die ("Error wrapping up %s", defmsg);
 	fprintf(stderr, "Finished one %s.\n", me);
 
 	/*
@@ -376,11 +373,9 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 
 	if (!no_commit) {
 		if (edit)
-			return execl_git_cmd("commit", "-n", "-F", ".msg",
-				"-e", NULL);
+			return execl_git_cmd("commit", "-n", NULL);
 		else
-			return execl_git_cmd("commit", "-n", "-F", ".msg",
-				NULL);
+			return execl_git_cmd("commit", "-n", "-F", defmsg, NULL);
 	}
 	if (reencoded_message)
 		free(reencoded_message);
-- 
1.5.2.rc2.716.gba45c
