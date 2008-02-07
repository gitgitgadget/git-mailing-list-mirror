From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH v2 05/11] Add "skip_unmerged" option to unpack_trees.
Date: Thu, 7 Feb 2008 11:40:02 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802071129130.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 07 17:41:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN9oh-0007U1-6h
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 17:41:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755594AbYBGQkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 11:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755572AbYBGQkH
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 11:40:07 -0500
Received: from iabervon.org ([66.92.72.58]:39484 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754720AbYBGQkE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 11:40:04 -0500
Received: (qmail 29767 invoked by uid 1000); 7 Feb 2008 16:40:02 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Feb 2008 16:40:02 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72968>

This option allows the caller to reset everything that isn't unmerged,
leaving the unmerged things to be resolved. If, after a merge of
"working" and "HEAD", this is used with "HEAD" (reset, !update), the
result will be that all of the changes from "local" are in the working
tree but not added to the index (either with the index clean but
unchanged, or with the index unmerged, depending on whether there are
conflicts).

This will be used in checkout -m.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 unpack-trees.c |   20 +++++++++++++++++---
 unpack-trees.h |    1 +
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 99aa45f..f9c4829 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -85,6 +85,7 @@ static int unpack_trees_rec(struct tree_entry_list **posns, int len,
 		int any_dirs = 0;
 		char *cache_name;
 		int ce_stage;
+		int skip_entry = 0;
 
 		/* Find the first name in the input. */
 
@@ -153,6 +154,8 @@ static int unpack_trees_rec(struct tree_entry_list **posns, int len,
 			any_files = 1;
 			src[0] = active_cache[o->pos];
 			remove = o->pos;
+			if (o->skip_unmerged && ce_stage(src[0]))
+				skip_entry = 1;
 		}
 
 		for (i = 0; i < len; i++) {
@@ -181,6 +184,12 @@ static int unpack_trees_rec(struct tree_entry_list **posns, int len,
 				continue;
 			}
 
+			if (skip_entry) {
+				subposns[i] = df_conflict_list;
+				posns[i] = posns[i]->next;
+				continue;
+			}
+
 			if (!o->merge)
 				ce_stage = 0;
 			else if (i + 1 < o->head_idx)
@@ -205,7 +214,13 @@ static int unpack_trees_rec(struct tree_entry_list **posns, int len,
 			posns[i] = posns[i]->next;
 		}
 		if (any_files) {
-			if (o->merge) {
+			if (skip_entry) {
+				o->pos++;
+				while (o->pos < active_nr &&
+				       !strcmp(active_cache[o->pos]->name,
+					       src[0]->name))
+					o->pos++;
+			} else if (o->merge) {
 				int ret;
 
 #if DBRT_DEBUG > 1
@@ -731,9 +746,8 @@ int threeway_merge(struct cache_entry **stages,
 	 * If we have an entry in the index cache, then we want to
 	 * make sure that it matches head.
 	 */
-	if (index && !same(index, head)) {
+	if (index && !same(index, head))
 		return o->gently ? -1 : reject_merge(index);
-	}
 
 	if (head) {
 		/* #5ALT, #15 */
diff --git a/unpack-trees.h b/unpack-trees.h
index 83d1229..a2df544 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -16,6 +16,7 @@ struct unpack_trees_options {
 	int trivial_merges_only;
 	int verbose_update;
 	int aggressive;
+	int skip_unmerged;
 	int gently;
 	const char *prefix;
 	int pos;
-- 
1.5.4
