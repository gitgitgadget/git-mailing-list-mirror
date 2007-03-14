From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 5/5] try-to-simplify-commit: use diff-tree --quiet machinery.
Date: Wed, 14 Mar 2007 14:26:52 -0700
Message-ID: <7v7itj7bz7.fsf@assigned-by-dhcp.cox.net>
References: <7vwt1j8z0e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 14 22:27:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRb05-0002bm-Ne
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 22:27:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbXCNV0y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 17:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751593AbXCNV0y
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 17:26:54 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:34778 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbXCNV0x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 17:26:53 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070314212651.VMAZ28911.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Mar 2007 17:26:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id alSs1W00R1kojtg0000000; Wed, 14 Mar 2007 17:26:52 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42234>

This uses diff-tree --quiet machinery to terminate the internal
diff-tree between a commit and its parents via revs.pruning (not
revs.diffopt) as soon as we find enough about the tree change.

With respect to the optionally given pathspec, we are interested
if the tree of commit is identical to the parent's, only adds
new paths to the parent's, or there are other differences.  As
soon as we find out that there is one such other kind of
difference, we do not have to compare the rest of the tree.

Because we do not call standard diff_addremove/diff_change, we
instruct the diff-tree machinery to stop early by setting
has_changes when we say we found the trees to be different.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 revision.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index 129d197..bcdb6a1 100644
--- a/revision.c
+++ b/revision.c
@@ -243,6 +243,8 @@ static void file_add_remove(struct diff_options *options,
 		diff = REV_TREE_NEW;
 	}
 	tree_difference = diff;
+	if (tree_difference == REV_TREE_DIFFERENT)
+		options->has_changes = 1;
 }
 
 static void file_change(struct diff_options *options,
@@ -252,6 +254,7 @@ static void file_change(struct diff_options *options,
 		 const char *base, const char *path)
 {
 	tree_difference = REV_TREE_DIFFERENT;
+	options->has_changes = 1;
 }
 
 int rev_compare_tree(struct rev_info *revs, struct tree *t1, struct tree *t2)
@@ -261,6 +264,7 @@ int rev_compare_tree(struct rev_info *revs, struct tree *t1, struct tree *t2)
 	if (!t2)
 		return REV_TREE_DIFFERENT;
 	tree_difference = REV_TREE_SAME;
+	revs->pruning.has_changes = 0;
 	if (diff_tree_sha1(t1->object.sha1, t2->object.sha1, "",
 			   &revs->pruning) < 0)
 		return REV_TREE_DIFFERENT;
@@ -285,6 +289,7 @@ int rev_same_tree_as_empty(struct rev_info *revs, struct tree *t1)
 	empty.size = 0;
 
 	tree_difference = REV_TREE_SAME;
+	revs->pruning.has_changes = 0;
 	retval = diff_tree(&empty, &real, "", &revs->pruning);
 	free(tree);
 
@@ -552,6 +557,7 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 	revs->ignore_merges = 1;
 	revs->simplify_history = 1;
 	revs->pruning.recursive = 1;
+	revs->pruning.quiet = 1;
 	revs->pruning.add_remove = file_add_remove;
 	revs->pruning.change = file_change;
 	revs->lifo = 1;
-- 
1.5.0.3.1036.g6baf1
