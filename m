From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 02/10] revert: Propogate errors upwards from do_pick_commit
Date: Wed, 25 May 2011 14:16:57 +0000
Message-ID: <1306333025-29893-3-git-send-email-artagnon@gmail.com>
References: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 25 16:17:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPEuE-0003uG-E9
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 16:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273Ab1EYORO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 10:17:14 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:36798 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757794Ab1EYORL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 10:17:11 -0400
Received: by mail-qy0-f174.google.com with SMTP id 7so2121342qyk.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 07:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=zDwfw0xF2X1fD88p6F95F+JOeWxN+M74gXD/6tvSTLU=;
        b=VQerD4lktFKqgra9/kjspUcH7/ypjDUQJWryG6BWuhlEbI2yFuy8Mw8IYB5c+3sRTe
         U9V4dmrGGfVtzO7z6X03zmG/XnjccD8vKBioDWm/0cHoiFP+t8Ht8GL/n2/UEo7i5a9w
         +TXPExQwI++EZu5y0ENOYCoLsjTszL8aMfNKo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pVKIGQ/neSBY+H5InZvV8YBb8+D+yo46JvlXfiK+b1VWs7XDzKxRwZfIJcwm3UIn3o
         udpx7xRiQZZPhTsllVHUzaRI3lyd1vbnZZHGIURY9RJo/MZNOP5x+1esKqWNQTz3GelS
         r+g9qx1LMLgzzTJaehrpLCrCxoFrc18rGqdk8=
Received: by 10.224.45.80 with SMTP id d16mr4005594qaf.112.1306333031134;
        Wed, 25 May 2011 07:17:11 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id t17sm5285636qcs.35.2011.05.25.07.17.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 May 2011 07:17:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174399>

Introduce error_dirty_index, based on die_dirty_index which prints
some hints, and returns an error to be handled by its caller,
do_pick_commit.  do_pick_commit, in turn, propogates the error
upwards, and the error is finally handled by cmd_cherry_pick and
cmd_revert.  Set a simple convention for error-handling as follows:
positive return values from do_pick_commit indicate conflicts, while
negative ones indicate other errors.

Mentored-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   72 ++++++++++++++++++++++++++++-------------------------
 1 files changed, 38 insertions(+), 34 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index f697e66..523d41a 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -266,25 +266,15 @@ static struct tree *empty_tree(void)
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
+	int ret = error(_("Your local changes would be overwritten by %s.\n"), me);
+	if (advice_commit_before_merge)
+		advise(_("Please, commit your changes or stash them to proceed."));
+	return ret;
 }
 
 static int fast_forward_to(const unsigned char *to, const unsigned char *from)
@@ -398,18 +388,18 @@ static int do_pick_commit(void)
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
@@ -418,20 +408,20 @@ static int do_pick_commit(void)
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
 
@@ -441,12 +431,12 @@ static int do_pick_commit(void)
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
@@ -594,14 +584,28 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 
 int cmd_revert(int argc, const char **argv, const char *prefix)
 {
+	int res = 0;
 	if (isatty(0))
 		edit = 1;
 	action = REVERT;
-	return revert_or_cherry_pick(argc, argv);
+	res = revert_or_cherry_pick(argc, argv);
+	if (res > 0)
+		/* Exit status from conflict */
+		return res;
+	if (res < 0)
+		/* Other error */
+		exit(128);
+	return 0;
 }
 
 int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 {
+	int res = 0;
 	action = CHERRY_PICK;
-	return revert_or_cherry_pick(argc, argv);
+	res = revert_or_cherry_pick(argc, argv);
+	if (res > 0)
+		return res;
+	if (res < 0)
+		exit(128);
+	return 0;
 }
-- 
1.7.5.GIT
