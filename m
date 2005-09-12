From: Chuck Lever <cel@netapp.com>
Subject: [PATCH 21/22] teach the merge algorithm about cache iterators
Date: Mon, 12 Sep 2005 10:56:29 -0400
Message-ID: <20050912145629.28120.70337.stgit@dexter.citi.umich.edu>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon Sep 12 16:58:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEpjs-0000SG-UN
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 16:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbVILO4v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 10:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbVILO4t
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 10:56:49 -0400
Received: from citi.umich.edu ([141.211.133.111]:36143 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751302AbVILO43 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 10:56:29 -0400
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 5B0CE1BAF3
	for <git@vger.kernel.org>; Mon, 12 Sep 2005 10:56:29 -0400 (EDT)
To: git@vger.kernel.org
In-Reply-To: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8382>

For now, we simply replace indpos with a cache cursor.  Likely more
changes will be needed after we successfully replace the cache array
with an abstract data type.

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 read-tree.c |   23 ++++++++++++++---------
 1 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/read-tree.c b/read-tree.c
--- a/read-tree.c
+++ b/read-tree.c
@@ -50,7 +50,8 @@ static int entcmp(char *name1, int dir1,
 }
 
 static int unpack_trees_rec(struct tree_entry_list **posns, int len,
-			    const char *base, merge_fn_t fn, int *indpos)
+			    const char *base, merge_fn_t fn,
+			    struct cache_cursor *cc)
 {
 	int baselen = strlen(base);
 	int src_size = len + 1;
@@ -73,7 +74,7 @@ static int unpack_trees_rec(struct tree_
 		cache_name = NULL;
 
 		/* Check the cache */
-		if (merge && *indpos < active_nr) {
+		if (merge && !cache_eof(cc)) {
 			/* This is a bit tricky: */
 			/* If the index has a subdirectory (with
 			 * contents) as the first name, it'll get a
@@ -91,7 +92,7 @@ static int unpack_trees_rec(struct tree_
 			 * file case.
 			 */
 
-			cache_name = active_cache[*indpos]->name;
+			cache_name = cc_to_ce(cc)->name;
 			if (strlen(cache_name) > baselen &&
 			    !memcmp(cache_name, base, baselen)) {
 				cache_name += baselen;
@@ -133,8 +134,8 @@ static int unpack_trees_rec(struct tree_
 
 		if (cache_name && !strcmp(cache_name, first)) {
 			any_files = 1;
-			src[0] = active_cache[*indpos];
-			remove_cache_entry_at(*indpos);
+			src[0] = cc_to_ce(cc);
+			remove_cache_entry_at(cc->pos);
 		}
 
 		for (i = 0; i < len; i++) {
@@ -203,7 +204,8 @@ static int unpack_trees_rec(struct tree_
 #if DBRT_DEBUG > 1
 				printf("Added %d entries\n", ret);
 #endif
-				*indpos += ret;
+				while (ret--)
+					next_cc(cc);
 			} else {
 				for (i = 0; i < src_size; i++) {
 					if (src[i]) {
@@ -219,7 +221,7 @@ static int unpack_trees_rec(struct tree_
 			newbase[baselen + pathlen] = '/';
 			newbase[baselen + pathlen + 1] = '\0';
 			if (unpack_trees_rec(subposns, len, newbase, fn,
-					     indpos))
+					     cc))
 				return -1;
 		}
 		free(subposns);
@@ -261,18 +263,21 @@ out:
 
 static int unpack_trees(merge_fn_t fn)
 {
-	int indpos = 0;
+	struct cache_cursor cc;
 	unsigned len = object_list_length(trees);
 	struct tree_entry_list **posns = 
 		xmalloc(len * sizeof(struct tree_entry_list *));
 	int i;
 	struct object_list *posn = trees;
+
 	merge_size = len;
 	for (i = 0; i < len; i++) {
 		posns[i] = ((struct tree *) posn->item)->entries;
 		posn = posn->next;
 	}
-	if (unpack_trees_rec(posns, len, "", fn, &indpos))
+
+	init_cc(&cc);
+	if (unpack_trees_rec(posns, len, "", fn, &cc))
 		return -1;
 
 	walk_cache(check_one_out);
