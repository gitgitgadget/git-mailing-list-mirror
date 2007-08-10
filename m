From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Start moving unpack-trees to "struct tree_desc"
Date: Thu, 9 Aug 2007 22:21:29 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708092213240.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 10 07:21:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJMwc-0004WB-52
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 07:21:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbXHJFVu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 01:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbXHJFVu
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 01:21:50 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49666 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750802AbXHJFVs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Aug 2007 01:21:48 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7A5LZwF014899
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 9 Aug 2007 22:21:36 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7A5LTa9005254;
	Thu, 9 Aug 2007 22:21:30 -0700
X-Spam-Status: No, hits=-4.523 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_31,J_CHICKENPOX_42,J_CHICKENPOX_66,J_CHICKENPOX_73,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: lf$Revision: 1.184 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55505>


This doesn't actually change any real code, but it changes the interface 
to unpack_trees() to take an array of "struct tree_desc" entries, the same 
way the tree-walk.c functions do.

The reason for this is that we would be much better off if we can do the 
tree-unpacking using the generic "traverse_trees()" functionality instead 
of having to the special "unpack" infrastructure.

This really is a pretty minimal diff, just to change the calling 
convention. It passes all the tests, and looks sane. There were only two 
users of "unpack_trees()": builtin-read-tree and merge-recursive, and I 
tried to keep the changes minimal.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

My plan is that with the more regular interfaces, we can hopefully migrate 
the cases that "unpack_trees()" handles one by one to other interfaces - 
but in order to do that, it has to use the *common* tree traversal 
interface, rather than a special one that requires munging from one 
format to another.

		Linus

---
 builtin-read-tree.c |   26 ++++++++++++++++++--------
 merge-recursive.c   |   16 +++++++++++-----
 unpack-trees.c      |   25 +++++++++----------------
 unpack-trees.h      |    2 +-
 4 files changed, 39 insertions(+), 30 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index a3b17a3..1967d10 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -13,14 +13,19 @@
 #include "dir.h"
 #include "builtin.h"
 
-static struct object_list *trees;
+static int nr_trees;
+static struct tree *trees[4];
 
 static int list_tree(unsigned char *sha1)
 {
-	struct tree *tree = parse_tree_indirect(sha1);
+	struct tree *tree;
+
+	if (nr_trees >= 4)
+		return -1;
+	tree = parse_tree_indirect(sha1);
 	if (!tree)
 		return -1;
-	object_list_append(&tree->object, &trees);
+	trees[nr_trees++] = tree;
 	return 0;
 }
 
@@ -76,11 +81,10 @@ static void prime_cache_tree_rec(struct cache_tree *it, struct tree *tree)
 
 static void prime_cache_tree(void)
 {
-	struct tree *tree = (struct tree *)trees->item;
-	if (!tree)
+	if (!nr_trees)
 		return;
 	active_cache_tree = cache_tree();
-	prime_cache_tree_rec(active_cache_tree, tree);
+	prime_cache_tree_rec(active_cache_tree, trees[0]);
 
 }
 
@@ -92,6 +96,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 {
 	int i, newfd, stage = 0;
 	unsigned char sha1[20];
+	struct tree_desc t[3];
 	struct unpack_trees_options opts;
 
 	memset(&opts, 0, sizeof(opts));
@@ -258,7 +263,12 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 			opts.head_idx = 1;
 	}
 
-	unpack_trees(trees, &opts);
+	for (i = 0; i < nr_trees; i++) {
+		struct tree *tree = trees[i];
+		parse_tree(tree);
+		init_tree_desc(t+i, tree->buffer, tree->size);
+	}
+	unpack_trees(nr_trees, t, &opts);
 
 	/*
 	 * When reading only one tree (either the most basic form,
@@ -266,7 +276,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	 * valid cache-tree because the index must match exactly
 	 * what came from the tree.
 	 */
-	if (trees && trees->item && !opts.prefix && (!opts.merge || (stage == 2))) {
+	if (nr_trees && !opts.prefix && (!opts.merge || (stage == 2))) {
 		cache_tree_free(&active_cache_tree);
 		prime_cache_tree();
 	}
diff --git a/merge-recursive.c b/merge-recursive.c
index c8539ec..f7d1b84 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -216,13 +216,19 @@ static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
  */
 static int index_only = 0;
 
+static void init_tree_desc_from_tree(struct tree_desc *desc, struct tree *tree)
+{
+	parse_tree(tree);
+	init_tree_desc(desc, tree->buffer, tree->size);
+}
+
 static int git_merge_trees(int index_only,
 			   struct tree *common,
 			   struct tree *head,
 			   struct tree *merge)
 {
 	int rc;
-	struct object_list *trees = NULL;
+	struct tree_desc t[3];
 	struct unpack_trees_options opts;
 
 	memset(&opts, 0, sizeof(opts));
@@ -234,11 +240,11 @@ static int git_merge_trees(int index_only,
 	opts.head_idx = 2;
 	opts.fn = threeway_merge;
 
-	object_list_append(&common->object, &trees);
-	object_list_append(&head->object, &trees);
-	object_list_append(&merge->object, &trees);
+	init_tree_desc_from_tree(t+0, common);
+	init_tree_desc_from_tree(t+1, head);
+	init_tree_desc_from_tree(t+2, merge);
 
-	rc = unpack_trees(trees, &opts);
+	rc = unpack_trees(3, t, &opts);
 	cache_tree_free(&active_cache_tree);
 	return rc;
 }
diff --git a/unpack-trees.c b/unpack-trees.c
index dfd985b..5d1ffd1 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -16,19 +16,13 @@ struct tree_entry_list {
 	const unsigned char *sha1;
 };
 
-static struct tree_entry_list *create_tree_entry_list(struct tree *tree)
+static struct tree_entry_list *create_tree_entry_list(struct tree_desc *desc)
 {
-	struct tree_desc desc;
 	struct name_entry one;
 	struct tree_entry_list *ret = NULL;
 	struct tree_entry_list **list_p = &ret;
 
-	if (!tree->object.parsed)
-		parse_tree(tree);
-
-	init_tree_desc(&desc, tree->buffer, tree->size);
-
-	while (tree_entry(&desc, &one)) {
+	while (tree_entry(desc, &one)) {
 		struct tree_entry_list *entry;
 
 		entry = xmalloc(sizeof(struct tree_entry_list));
@@ -173,9 +167,11 @@ static int unpack_trees_rec(struct tree_entry_list **posns, int len,
 
 			if (S_ISDIR(posns[i]->mode)) {
 				struct tree *tree = lookup_tree(posns[i]->sha1);
+				struct tree_desc t;
 				any_dirs = 1;
 				parse_tree(tree);
-				subposns[i] = create_tree_entry_list(tree);
+				init_tree_desc(&t, tree->buffer, tree->size);
+				subposns[i] = create_tree_entry_list(&t);
 				posns[i] = posns[i]->next;
 				src[i + o->merge] = o->df_conflict_entry;
 				continue;
@@ -331,12 +327,10 @@ static void check_updates(struct cache_entry **src, int nr,
 		stop_progress(&progress);;
 }
 
-int unpack_trees(struct object_list *trees, struct unpack_trees_options *o)
+int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options *o)
 {
-	unsigned len = object_list_length(trees);
 	struct tree_entry_list **posns;
 	int i;
-	struct object_list *posn = trees;
 	struct tree_entry_list df_conflict_list;
 	static struct cache_entry *dfc;
 
@@ -356,10 +350,9 @@ int unpack_trees(struct object_list *trees, struct unpack_trees_options *o)
 
 	if (len) {
 		posns = xmalloc(len * sizeof(struct tree_entry_list *));
-		for (i = 0; i < len; i++) {
-			posns[i] = create_tree_entry_list((struct tree *) posn->item);
-			posn = posn->next;
-		}
+		for (i = 0; i < len; i++)
+			posns[i] = create_tree_entry_list(t+i);
+
 		if (unpack_trees_rec(posns, len, o->prefix ? o->prefix : "",
 				     o, &df_conflict_list))
 			return -1;
diff --git a/unpack-trees.h b/unpack-trees.h
index fee7da4..9cd39a2 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -26,7 +26,7 @@ struct unpack_trees_options {
 	struct cache_entry *df_conflict_entry;
 };
 
-extern int unpack_trees(struct object_list *trees,
+extern int unpack_trees(unsigned n, struct tree_desc *t,
 		struct unpack_trees_options *options);
 
 int threeway_merge(struct cache_entry **stages, struct unpack_trees_options *o);
