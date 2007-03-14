From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/5] Teach --quiet to diff backends.
Date: Wed, 14 Mar 2007 14:26:50 -0700
Message-ID: <7vird37bz9.fsf@assigned-by-dhcp.cox.net>
References: <7vwt1j8z0e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 14 22:27:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRb06-0002bm-87
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 22:27:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbXCNV04 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 17:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751623AbXCNV0z
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 17:26:55 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:48505 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbXCNV0z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 17:26:55 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070314212652.VQTR321.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Mar 2007 17:26:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id alSq1W00x1kojtg0000000; Wed, 14 Mar 2007 17:26:51 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42235>

This teaches git-diff-files, git-diff-index and git-diff-tree
backends to exit early under --quiet option.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 diff-lib.c  |    6 ++++++
 tree-diff.c |    2 ++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index f9a1a10..5c5b05b 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -324,6 +324,9 @@ int run_diff_files(struct rev_info *revs, int silent_on_removed)
 		struct cache_entry *ce = active_cache[i];
 		int changed;
 
+		if (revs->diffopt.quiet && revs->diffopt.has_changes)
+			break;
+
 		if (!ce_path_match(ce, revs->prune_data))
 			continue;
 
@@ -565,6 +568,9 @@ static int diff_cache(struct rev_info *revs,
 		struct cache_entry *ce = *ac;
 		int same = (entries > 1) && ce_same_name(ce, ac[1]);
 
+		if (revs->diffopt.quiet && revs->diffopt.has_changes)
+			break;
+
 		if (!ce_path_match(ce, pathspec))
 			goto skip_entry;
 
diff --git a/tree-diff.c b/tree-diff.c
index c827582..44cde74 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -161,6 +161,8 @@ static void show_entry(struct diff_options *opt, const char *prefix, struct tree
 int diff_tree(struct tree_desc *t1, struct tree_desc *t2, const char *base, struct diff_options *opt)
 {
 	while (t1->size | t2->size) {
+		if (opt->quiet && opt->has_changes)
+			break;
 		if (opt->nr_paths && t1->size && !interesting(t1, base, opt)) {
 			update_tree_entry(t1);
 			continue;
-- 
1.5.0.3.1036.g6baf1
