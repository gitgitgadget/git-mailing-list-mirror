From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 06/18] revert: Propogate errors upwards from do_pick_commit
Date: Tue, 19 Jul 2011 22:47:44 +0530
Message-ID: <1311095876-3098-7-git-send-email-artagnon@gmail.com>
References: <1311095876-3098-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 19 19:19:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjDx7-00037m-9R
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 19:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376Ab1GSRTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 13:19:09 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:36451 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043Ab1GSRTI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 13:19:08 -0400
Received: by mail-pv0-f174.google.com with SMTP id 12so4030753pvg.19
        for <git@vger.kernel.org>; Tue, 19 Jul 2011 10:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=F5dieLxtgLNmNRVRNWUCvgDdCvM4APiuBYi4v1qhXcw=;
        b=ZZFp7r/kdKYFznzgCv+KkHNQ2tD7sEL6FCiq+7ckA+N6DUeJdrUPfbj07AkjfJkxdP
         RVXro8QG0hCvmn8AW1W9s7ose3LNJI4YLzT3uNTXn9jDo5amsOAFRa0gHQjCgxbSb6qv
         ESAs852TxZONiD2cRSr1RjkZRmLMrszr+LBI4=
Received: by 10.143.93.2 with SMTP id v2mr3556472wfl.98.1311095948064;
        Tue, 19 Jul 2011 10:19:08 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id r12sm4276415wfe.1.2011.07.19.10.19.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Jul 2011 10:19:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1311095876-3098-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177472>

Currently, revert_or_cherry_pick can fail in two ways.  If it
encounters a conflict, it returns a positive number indicating the
intended exit status for the git wrapper to pass on; for all other
errors, it calls die().  The latter behavior is inconsiderate towards
callers, as it denies them the opportunity to recover from errors and
do other things.

After this patch, revert_or_cherry_pick will still return a positive
return value to indicate an exit status for conflicts as before, while
for some other errors, it will print an error message and return -1
instead of die()-ing.  The cmd_revert and cmd_cherry_pick are adjusted
to handle the fatal errors by die()-ing themselves.

While the full benefits of this patch will only be seen once all the
"die" calls are replaced with calls to "error", its immediate impact
is to change some "fatal:" messages to say "error:" and to add a new
"fatal: cherry-pick failed" message at the end when the operation
fails.

Inspired-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Jonathan Nieder <jrnieder@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   67 ++++++++++++++++++++++++++++-------------------------
 1 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 794c050..5dbea40 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -241,25 +241,20 @@ static struct tree *empty_tree(void)
 	return tree;
 }
 
-static NORETURN void die_dirty_index(const char *me)
+static int error_dirty_index(const char *me)
 {
-	if (read_cache_unmerged()) {
-		die_resolve_conflict(me);
-	} else {
-		if (advice_commit_before_merge) {
-			if (action == REVERT)
-				die(_("Your local changes would be overwritten by revert.\n"
-					  "Please, commit your changes or stash them to proceed."));
-			else
-				die(_("Your local changes would be overwritten by cherry-pick.\n"
-					  "Please, commit your changes or stash them to proceed."));
-		} else {
-			if (action == REVERT)
-				die(_("Your local changes would be overwritten by revert.\n"));
-			else
-				die(_("Your local changes would be overwritten by cherry-pick.\n"));
-		}
-	}
+	if (read_cache_unmerged())
+		return error_resolve_conflict(me);
+
+	/* Different translation strings for cherry-pick and revert */
+	if (action == CHERRY_PICK)
+		error(_("Your local changes would be overwritten by cherry-pick."));
+	else
+		error(_("Your local changes would be overwritten by revert."));
+
+	if (advice_commit_before_merge)
+		advise(_("Please, commit your changes or stash them to proceed."));
+	return -1;
 }
 
 static int fast_forward_to(const unsigned char *to, const unsigned char *from)
@@ -376,9 +371,9 @@ static int do_pick_commit(void)
 			die (_("Your index file is unmerged."));
 	} else {
 		if (get_sha1("HEAD", head))
-			die (_("You do not have a valid HEAD"));
+			return error(_("You do not have a valid HEAD"));
 		if (index_differs_from("HEAD", 0))
-			die_dirty_index(me);
+			return error_dirty_index(me);
 	}
 	discard_cache();
 
@@ -391,20 +386,20 @@ static int do_pick_commit(void)
 		struct commit_list *p;
 
 		if (!mainline)
-			die(_("Commit %s is a merge but no -m option was given."),
-			    sha1_to_hex(commit->object.sha1));
+			return error(_("Commit %s is a merge but no -m option was given."),
+				sha1_to_hex(commit->object.sha1));
 
 		for (cnt = 1, p = commit->parents;
 		     cnt != mainline && p;
 		     cnt++)
 			p = p->next;
 		if (cnt != mainline || !p)
-			die(_("Commit %s does not have parent %d"),
-			    sha1_to_hex(commit->object.sha1), mainline);
+			return error(_("Commit %s does not have parent %d"),
+				sha1_to_hex(commit->object.sha1), mainline);
 		parent = p->item;
 	} else if (0 < mainline)
-		die(_("Mainline was specified but commit %s is not a merge."),
-		    sha1_to_hex(commit->object.sha1));
+		return error(_("Mainline was specified but commit %s is not a merge."),
+			sha1_to_hex(commit->object.sha1));
 	else
 		parent = commit->parents->item;
 
@@ -414,12 +409,12 @@ static int do_pick_commit(void)
 	if (parent && parse_commit(parent) < 0)
 		/* TRANSLATORS: The first %s will be "revert" or
 		   "cherry-pick", the second %s a SHA1 */
-		die(_("%s: cannot parse parent commit %s"),
-		    me, sha1_to_hex(parent->object.sha1));
+		return error(_("%s: cannot parse parent commit %s"),
+			me, sha1_to_hex(parent->object.sha1));
 
 	if (get_message(commit->buffer, &msg) != 0)
-		die(_("Cannot get commit message for %s"),
-				sha1_to_hex(commit->object.sha1));
+		return error(_("Cannot get commit message for %s"),
+			sha1_to_hex(commit->object.sha1));
 
 	/*
 	 * "commit" is an existing commit.  We would want to apply
@@ -580,14 +575,22 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 
 int cmd_revert(int argc, const char **argv, const char *prefix)
 {
+	int res;
 	if (isatty(0))
 		edit = 1;
 	action = REVERT;
-	return revert_or_cherry_pick(argc, argv);
+	res = revert_or_cherry_pick(argc, argv);
+	if (res < 0)
+		die(_("revert failed"));
+	return res;
 }
 
 int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 {
+	int res;
 	action = CHERRY_PICK;
-	return revert_or_cherry_pick(argc, argv);
+	res = revert_or_cherry_pick(argc, argv);
+	if (res < 0)
+		die(_("cherry-pick failed"));
+	return res;
 }
-- 
1.7.4.rc1.7.g2cf08.dirty
