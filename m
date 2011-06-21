From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 04/13] revert: Propogate errors upwards from do_pick_commit
Date: Tue, 21 Jun 2011 13:04:40 +0000
Message-ID: <1308661489-20080-5-git-send-email-artagnon@gmail.com>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 21 15:06:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ0fI-00076C-2L
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 15:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756474Ab1FUNGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 09:06:43 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:46336 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755769Ab1FUNGm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 09:06:42 -0400
Received: by vxb39 with SMTP id 39so1680952vxb.19
        for <git@vger.kernel.org>; Tue, 21 Jun 2011 06:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=Q4SM/StR4B+hzjtNYEXlnP6Gcy0mrKNTS3/yw6geii0=;
        b=OqU199rizQ3h/SPCwheJ4m5KI+DrWn4wmJCh52KBdQony4yrFFiFUF4ymjXQOANINN
         xl1AIidYRDds2ZxZmUVLFrfMf5jhY3x8kcykoG41ci6ipfUG9+ccsQ/VrbvZbWMtFKx9
         e0GHdlzR1uvvoRtZEzC8XqkK2wLIkVQg9BfgA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=f93c9Zl1kiWJ2Liba1zhfISwZ+GNj5TFsOlbvt9q9dMHgHZzwjC0PqkokCBP3osGUF
         PAGvcd66dLo5kTEKu8ts8p+5KhpdijJvkVVZkrD4QKyaAZGZwHDQPaPseK9jJPs7lIrM
         kcGEPL/srzvT3AwJi1MaOQ3dNSuf7Gg7Aq5q4=
Received: by 10.52.115.229 with SMTP id jr5mr1384475vdb.145.1308661500316;
        Tue, 21 Jun 2011 06:05:00 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id k9sm1575853vbn.0.2011.06.21.06.04.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Jun 2011 06:04:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176152>

Earlier, revert_or_cherry_pick only used to return a non-negative
number or die.  Change this so that it can return negative values too;
postive return values indicate conflicts, while negative ones indicate
other errors, and this return status is propogated updwards from
do_pick_commit, to be finally handled in cmd_cherry_pick and
cmd_revert.  While revert_or_cherry_pick can still die due to several
other reasons, this patches attempts to factor out some of the die
calls.  In the same spirit, also introduce a new function
error_dirty_index, based on die_dirty_index which prints some hints
and returns an error to its caller do_pick_commit.

Mentored-by: Jonathan Nieder <jrnieder@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   70 ++++++++++++++++++++++++++++-------------------------
 1 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 2de2e75..26f39d1 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -250,25 +250,15 @@ static struct tree *empty_tree(void)
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
+	error(_("Your local changes would be overwritten by %s.\n"), me);
+	if (advice_commit_before_merge)
+		advise(_("Please, commit your changes or stash them to proceed."));
+	return -1;
 }
 
 static int fast_forward_to(const unsigned char *to, const unsigned char *from)
@@ -382,12 +372,12 @@ static int do_pick_commit(void)
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
 
@@ -400,20 +390,20 @@ static int do_pick_commit(void)
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
 
@@ -423,12 +413,12 @@ static int do_pick_commit(void)
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
@@ -582,14 +572,28 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 
 int cmd_revert(int argc, const char **argv, const char *prefix)
 {
+	int res;
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
+		die(_("%s failed"), me);
+	return 0;
 }
 
 int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 {
+	int res;
 	action = CHERRY_PICK;
-	return revert_or_cherry_pick(argc, argv);
+	res = revert_or_cherry_pick(argc, argv);
+	if (res > 0)
+		return res;
+	if (res < 0)
+		die(_("%s failed"), me);
+	return 0;
 }
-- 
1.7.5.GIT
