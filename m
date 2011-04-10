From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 01/11] revert: Avoid calling die; return error instead
Date: Sun, 10 Apr 2011 20:41:47 +0530
Message-ID: <1302448317-32387-2-git-send-email-artagnon@gmail.com>
References: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 10 17:13:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8wK9-00084V-5k
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 17:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754569Ab1DJPNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 11:13:07 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49368 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753691Ab1DJPNF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 11:13:05 -0400
Received: by iyb14 with SMTP id 14so4855877iyb.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 08:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=WeDSysuuyzXrVhI4C05jzmlqZNJ9nOOWLLOa+WmhCrs=;
        b=RVIK8FgKdWeTW63N8cqWFcfixlBQUJlrscGx6JjYZ7j6v8Gl7B6crskPtCINq3XgxZ
         PZ6FJVBqP/qpn3RXfDurA1724eCI1mwUqbWcuRO6M8Rx2Rs78+jN5T7wNvwF89ehHvQh
         iM7+eGM8T32Qd/0frlep+Bo14UUJ06nuXD6aY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=whaNwecI2kgSBvanSDDPWst9QVkn6iLjJQYNR46oL0S7ECCguleRcSbMiQK9LtWPpU
         /uLE9z/spOjdsuymvuzhAC+zKJb/SeNq8FO68XxqQ9Z7msVjp8ToT9BfLlOt17urYWP8
         oerFcNCOJ8IoO64qy20ISY/SnJd86qghdn1g0=
Received: by 10.42.141.202 with SMTP id p10mr6834315icu.124.1302448384994;
        Sun, 10 Apr 2011 08:13:04 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id f28sm3367928ibh.67.2011.04.10.08.13.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 08:13:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171256>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   71 ++++++++++++++++++++++++++++-------------------------
 1 files changed, 37 insertions(+), 34 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 2bb13eb..017b1af 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -265,23 +265,23 @@ static struct tree *empty_tree(void)
 	return tree;
 }
 
-static NORETURN void die_dirty_index(const char *me)
+static int error_dirty_index(const char *me)
 {
 	if (read_cache_unmerged()) {
 		die_resolve_conflict(me);
 	} else {
 		if (advice_commit_before_merge) {
 			if (action == REVERT)
-				die(_("Your local changes would be overwritten by revert.\n"
+				return error(_("Your local changes would be overwritten by revert.\n"
 					  "Please, commit your changes or stash them to proceed."));
 			else
-				die(_("Your local changes would be overwritten by cherry-pick.\n"
+				return error(_("Your local changes would be overwritten by cherry-pick.\n"
 					  "Please, commit your changes or stash them to proceed."));
 		} else {
 			if (action == REVERT)
-				die(_("Your local changes would be overwritten by revert.\n"));
+				return error(_("Your local changes would be overwritten by revert.\n"));
 			else
-				die(_("Your local changes would be overwritten by cherry-pick.\n"));
+				return error(_("Your local changes would be overwritten by cherry-pick.\n"));
 		}
 	}
 }
@@ -331,7 +331,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	    (write_cache(index_fd, active_cache, active_nr) ||
 	     commit_locked_index(&index_lock)))
 		/* TRANSLATORS: %s will be "revert" or "cherry-pick" */
-		die(_("%s: Unable to write new index file"), me);
+		return error(_("%s: Unable to write new index file"), me);
 	rollback_lock_file(&index_lock);
 
 	if (!clean) {
@@ -397,18 +397,18 @@ static int do_pick_commit(void)
 		 * to work on.
 		 */
 		if (write_cache_as_tree(head, 0, NULL))
-			die (_("Your index file is unmerged."));
+			return error(_("Your index file is unmerged."));
 	} else {
 		if (get_sha1("HEAD", head))
-			die (_("You do not have a valid HEAD"));
+			return error(_("You do not have a valid HEAD"));
 		if (index_differs_from("HEAD", 0))
-			die_dirty_index(me);
+			return error_dirty_index(me);
 	}
 	discard_cache();
 
 	if (!commit->parents) {
 		if (action == REVERT)
-			die (_("Cannot revert a root commit"));
+			return error(_("Cannot revert a root commit"));
 		parent = NULL;
 	}
 	else if (commit->parents->next) {
@@ -417,19 +417,19 @@ static int do_pick_commit(void)
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
+			return error(_("Commit %s does not have parent %d"),
 			    sha1_to_hex(commit->object.sha1), mainline);
 		parent = p->item;
-	} else if (0 < mainline)
-		die(_("Mainline was specified but commit %s is not a merge."),
+	} else if (mainline > 0)
+		return error(_("Mainline was specified but commit %s is not a merge."),
 		    sha1_to_hex(commit->object.sha1));
 	else
 		parent = commit->parents->item;
@@ -440,11 +440,11 @@ static int do_pick_commit(void)
 	if (parent && parse_commit(parent) < 0)
 		/* TRANSLATORS: The first %s will be "revert" or
 		   "cherry-pick", the second %s a SHA1 */
-		die(_("%s: cannot parse parent commit %s"),
+		return error(_("%s: cannot parse parent commit %s"),
 		    me, sha1_to_hex(parent->object.sha1));
 
 	if (get_message(commit->buffer, &msg) != 0)
-		die(_("Cannot get commit message for %s"),
+		return error(_("Cannot get commit message for %s"),
 				sha1_to_hex(commit->object.sha1));
 
 	/*
@@ -523,7 +523,7 @@ static int do_pick_commit(void)
 	return res;
 }
 
-static void prepare_revs(struct rev_info *revs)
+static int prepare_revs(struct rev_info *revs)
 {
 	int argc;
 
@@ -533,34 +533,39 @@ static void prepare_revs(struct rev_info *revs)
 		revs->reverse = 1;
 
 	argc = setup_revisions(commit_argc, commit_argv, revs, NULL);
-	if (argc > 1)
-		usage(*revert_or_cherry_pick_usage());
+	if (argc > 1) {
+		fprintf(stderr, "usage: %s", _(*revert_or_cherry_pick_usage()));
+		return 129;
+	}
 
 	if (prepare_revision_walk(revs))
-		die(_("revision walk setup failed"));
+		return error(_("revision walk setup failed"));
 
 	if (!revs->commits)
-		die(_("empty commit set passed"));
+		return error(_("empty commit set passed"));
+	return 0;
 }
 
-static void read_and_refresh_cache(const char *me)
+static int read_and_refresh_cache(const char *me)
 {
 	static struct lock_file index_lock;
 	int index_fd = hold_locked_index(&index_lock, 0);
 	if (read_index_preload(&the_index, NULL) < 0)
-		die(_("git %s: failed to read the index"), me);
+		return error(_("%s: failed to read the index"), me);
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
 	if (the_index.cache_changed) {
 		if (write_index(&the_index, index_fd) ||
 		    commit_locked_index(&index_lock))
-			die(_("git %s: failed to refresh the index"), me);
+			return error(_("%s: failed to refresh the index"), me);
 	}
 	rollback_lock_file(&index_lock);
+	return 0;
 }
 
 static int revert_or_cherry_pick(int argc, const char **argv)
 {
 	struct rev_info revs;
+	int res;
 
 	git_config(git_default_config, NULL);
 	me = action == REVERT ? "revert" : "cherry-pick";
@@ -578,17 +583,15 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 			die(_("cherry-pick --ff cannot be used with --edit"));
 	}
 
-	read_and_refresh_cache(me);
+	if ((res = read_and_refresh_cache(me)) ||
+		(res = prepare_revs(&revs)))
+		return res;
 
-	prepare_revs(&revs);
+	while ((commit = get_revision(&revs)) &&
+		!(res = do_pick_commit(commit)))
+		;
 
-	while ((commit = get_revision(&revs))) {
-		int res = do_pick_commit();
-		if (res)
-			return res;
-	}
-
-	return 0;
+	return res;
 }
 
 int cmd_revert(int argc, const char **argv, const char *prefix)
-- 
1.7.4.rc1.7.g2cf08.dirty
