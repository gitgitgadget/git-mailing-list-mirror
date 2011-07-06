From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 05/14] revert: Propogate errors upwards from do_pick_commit
Date: Wed,  6 Jul 2011 07:54:19 +0000
Message-ID: <1309938868-2028-6-git-send-email-artagnon@gmail.com>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 06 09:54:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeMwf-0005vT-1U
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 09:54:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347Ab1GFHyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 03:54:41 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:43982 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039Ab1GFHyh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 03:54:37 -0400
Received: by mail-qw0-f46.google.com with SMTP id 3so3221737qwk.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 00:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=PF8HXACuiM/3yAw6z12AVhI8TXDj1ShNf1VbjuuYAU4=;
        b=JOyPpLBBv3CVbzH7bJupRgQTrIRyRggIJn0MP0UfQQdUpJ2GoGpZvYOgjnNoHbhe/Y
         IF4pD+i/iEZJv0j+MR1nggoQpjTlS8Ht6DQiaOBdFTa0GWYd+EIjrQwt6vEDELZJab2N
         sYzanfrOdDMgNh3PcSg+7WOal/xpl3L45rzVE=
Received: by 10.224.17.194 with SMTP id t2mr6481367qaa.320.1309938877019;
        Wed, 06 Jul 2011 00:54:37 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id e18sm6212790qcs.5.2011.07.06.00.54.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 00:54:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176651>

Currently, the return value from revert_or_cherry_pick is a
non-negative number representing the intended exit status from `git
revert` or `git cherry-pick`.  Change this by replacing some of the
calls to "die" with calls to "error", so that it can return negative
values too.  Postive return values indicate conflicts, while negative
ones indicate other errors.  This return status is propogated updwards
from do_pick_commit, to be finally handled in cmd_cherry_pick and
cmd_revert.

In the same spirit, also introduce a new function error_dirty_index,
based on die_dirty_index, which prints some hints and returns an error
to its caller do_pick_commit.

While the full benefits of this patch will only be seen once all the
"die" calls are replaced with calls to "error", its immediate impact
is to change some of the "die:" messages to "error:" messages and
print a new "fatal: cherry-pick failed" message when the operation
fails.

Inspired-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Jonathan Nieder <jrnieder@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   69 ++++++++++++++++++++++++++++-------------------------
 1 files changed, 36 insertions(+), 33 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 1612911..3de7ec4 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -250,25 +250,20 @@ static struct tree *empty_tree(void)
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
+		error(_("Your local changes would be overwritten by %s."), me);
+	else
+		error(_("Your local changes would be overwritten by %s."), me);
+
+	if (advice_commit_before_merge)
+		advise(_("Please, commit your changes or stash them to proceed."));
+	return -1;
 }
 
 static int fast_forward_to(const unsigned char *to, const unsigned char *from)
@@ -382,12 +377,12 @@ static int do_pick_commit(void)
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
 
@@ -400,20 +395,20 @@ static int do_pick_commit(void)
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
 
@@ -423,12 +418,12 @@ static int do_pick_commit(void)
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
@@ -581,14 +576,22 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 
 int cmd_revert(int argc, const char **argv, const char *prefix)
 {
+	int res;
 	if (isatty(0))
 		edit = 1;
 	action = REVERT;
-	return revert_or_cherry_pick(argc, argv);
+	res = revert_or_cherry_pick(argc, argv);
+	if (res < 0)
+		die(_("%s failed"), me);
+	return res;
 }
 
 int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 {
+	int res;
 	action = CHERRY_PICK;
-	return revert_or_cherry_pick(argc, argv);
+	res = revert_or_cherry_pick(argc, argv);
+	if (res < 0)
+		die(_("%s failed"), me);
+	return res;
 }
-- 
1.7.5.GIT
