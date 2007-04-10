From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/4] git-log --cherry-pick A...B
Date: Tue, 10 Apr 2007 15:40:27 -0700
Message-ID: <7vfy77ua3o.fsf_-_@assigned-by-dhcp.cox.net>
References: <1175686583.19898.68.camel@okra.transitives.com>
	<Pine.LNX.4.64.0704040744160.6730@woody.linux-foundation.org>
	<7vircbwfym.fsf@assigned-by-dhcp.cox.net>
	<7virc524cd.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 07:54:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbP1P-0001J8-Fy
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 00:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030722AbXDJWks (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 18:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030725AbXDJWkr
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 18:40:47 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:51358 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030616AbXDJWk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 18:40:29 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070410224028.MWXW1257.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Tue, 10 Apr 2007 18:40:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id lagT1W00J1kojtg0000000; Tue, 10 Apr 2007 18:40:28 -0400
In-Reply-To: <7virc524cd.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 09 Apr 2007 04:07:46 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44190>

This is meant to be a saner replacement for "git-cherry".

When used with "A...B", this filters out commits whose patch
text has the same patch-id as a commit on the other side.  It
would probably most useful to use with --left-right.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 revision.c |   88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 revision.h |    1 +
 2 files changed, 89 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index 486393c..e9de865 100644
--- a/revision.c
+++ b/revision.c
@@ -8,6 +8,7 @@
 #include "revision.h"
 #include "grep.h"
 #include "reflog-walk.h"
+#include "patch-ids.h"
 
 static char *path_name(struct name_path *path, const char *name)
 {
@@ -422,6 +423,86 @@ static void add_parents_to_list(struct rev_info *revs, struct commit *commit, st
 	}
 }
 
+static void cherry_pick_list(struct commit_list *list)
+{
+	struct commit_list *p;
+	int left_count = 0, right_count = 0;
+	int left_first;
+	struct patch_ids ids;
+
+	/* First count the commits on the left and on the right */
+	for (p = list; p; p = p->next) {
+		struct commit *commit = p->item;
+		unsigned flags = commit->object.flags;
+		if (flags & BOUNDARY)
+			;
+		else if (flags & SYMMETRIC_LEFT)
+			left_count++;
+		else
+			right_count++;
+	}
+
+	left_first = left_count < right_count;
+	init_patch_ids(&ids);
+
+	/* Compute patch-ids for one side */
+	for (p = list; p; p = p->next) {
+		struct commit *commit = p->item;
+		unsigned flags = commit->object.flags;
+
+		if (flags & BOUNDARY)
+			continue;
+		/*
+		 * If we have fewer left, left_first is set and we omit
+		 * commits on the right branch in this loop.  If we have
+		 * fewer right, we skip the left ones.
+		 */
+		if (left_first != !!(flags & SYMMETRIC_LEFT))
+			continue;
+		commit->util = add_commit_patch_id(commit, &ids);
+	}
+
+	/* Check the other side */
+	for (p = list; p; p = p->next) {
+		struct commit *commit = p->item;
+		struct patch_id *id;
+		unsigned flags = commit->object.flags;
+
+		if (flags & BOUNDARY)
+			continue;
+		/*
+		 * If we have fewer left, left_first is set and we omit
+		 * commits on the left branch in this loop.
+		 */
+		if (left_first == !!(flags & SYMMETRIC_LEFT))
+			continue;
+
+		/*
+		 * Have we seen the same patch id?
+		 */
+		id = has_commit_patch_id(commit, &ids);
+		if (!id)
+			continue;
+		id->seen = 1;
+		commit->object.flags |= SHOWN;
+	}
+
+	/* Now check the original side for seen ones */
+	for (p = list; p; p = p->next) {
+		struct commit *commit = p->item;
+		struct patch_id *ent;
+
+		ent = commit->util;
+		if (!ent)
+			continue;
+		if (ent->seen)
+			commit->object.flags |= SHOWN;
+		commit->util = NULL;
+	}
+
+	free_patch_ids(&ids);
+}
+
 static void limit_list(struct rev_info *revs)
 {
 	struct commit_list *list = revs->commits;
@@ -449,6 +530,9 @@ static void limit_list(struct rev_info *revs)
 			continue;
 		p = &commit_list_insert(commit, p)->next;
 	}
+	if (revs->cherry_pick)
+		cherry_pick_list(newlist);
+
 	revs->commits = newlist;
 }
 
@@ -913,6 +997,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				revs->left_right = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--cherry-pick")) {
+				revs->cherry_pick = 1;
+				continue;
+			}
 			if (!strcmp(arg, "--objects")) {
 				revs->tag_objects = 1;
 				revs->tree_objects = 1;
diff --git a/revision.h b/revision.h
index 55e6b53..b69624a 100644
--- a/revision.h
+++ b/revision.h
@@ -47,6 +47,7 @@ struct rev_info {
 			left_right:1,
 			parents:1,
 			reverse:1,
+			cherry_pick:1,
 			first_parent_only:1;
 
 	/* Diff flags */
-- 
1.5.1.777.gd14d3
