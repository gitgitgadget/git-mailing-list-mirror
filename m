From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Have git-revert, git-cherry-pick cleanup ./.msg upon successful completion.
Date: Fri, 4 May 2007 23:46:15 -0400
Message-ID: <20070505034615.GE16538@spearce.org>
References: <20070504143022.8539.qmail@4071cc1c178e73.315fe32.mid.smarden.org> <20070504143210.8690.qmail@a4171e0dbe98e3.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Sat May 05 05:46:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkBE8-0004is-Da
	for gcvg-git@gmane.org; Sat, 05 May 2007 05:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423974AbXEEDqX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 23:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423976AbXEEDqX
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 23:46:23 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52862 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423974AbXEEDqX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 23:46:23 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HkBDk-0003Tb-Dt; Fri, 04 May 2007 23:46:08 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CF4E920FBAE; Fri,  4 May 2007 23:46:15 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070504143210.8690.qmail@a4171e0dbe98e3.315fe32.mid.smarden.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46240>

Gerrit Pape <pape@smarden.org> wrote:
> git-revert and git-cherry-pick left behind the commit message file ./.msg,
> have them use the -f option to git-commit to properly cleanup the
> automatically created file.

I'm actually sort of against changing the behavior of git-commit
-f to mean "delete the file".  We never did that before.  Users
might get surprised when their file goes away!

What about this change instead?  We make cherry-pick/revert
use the same temporary file as merge, which is under .git/
(something Alex mentioned he wanted).  I think the use of ".msg"
in cherry-pick/revert has always just been a bug, and not a feature,
so I'm really not against changing things around like this.


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
Shawn.
