From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/RFC v4 08/13] Read cache-tree in index-v5
Date: Thu, 16 Aug 2012 11:58:44 +0200
Message-ID: <1345111129-6925-9-git-send-email-t.gummerer@gmail.com>
References: <1345111129-6925-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, pclouds@gmail.com, mhagger@alum.mit.edu,
	gitster@pobox.com, robin.rosenberg@dewire.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 16 11:59:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1wrp-0000D2-S7
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 11:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756564Ab2HPJ7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 05:59:37 -0400
Received: from li348-43.members.linode.com ([178.79.179.43]:48205 "EHLO
	tgummerer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756239Ab2HPJ7O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 05:59:14 -0400
Received: by tgummerer.com (Postfix, from userid 1001)
	id EE65E4EFF2; Thu, 16 Aug 2012 11:59:09 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.GIT
In-Reply-To: <1345111129-6925-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the cache-tree data is saved as part of the directory data,
we already read it at the beginning of the index. The cache-tree
is only converted from this directory data.

The cache-tree data is arranged in a tree, with the children sorted by
pathlen at each node, while the ondisk format is sorted lexically.
So we have to rebuild this format from the on-disk directory list.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 cache-tree.c    |  2 +-
 cache-tree.h    |  6 ++++
 read-cache-v5.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/cache-tree.c b/cache-tree.c
index 28ed657..61544d8 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -31,7 +31,7 @@ void cache_tree_free(struct cache_tree **it_p)
 	*it_p = NULL;
 }
 
-static int subtree_name_cmp(const char *one, int onelen,
+int subtree_name_cmp(const char *one, int onelen,
 			    const char *two, int twolen)
 {
 	if (onelen < twolen)
diff --git a/cache-tree.h b/cache-tree.h
index d8cb2e9..7416007 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -20,10 +20,16 @@ struct cache_tree {
 	struct cache_tree_sub **down;
 };
 
+struct directory_queue {
+	struct directory_queue *down;
+	struct directory_entry *de;
+};
+
 struct cache_tree *cache_tree(void);
 void cache_tree_free(struct cache_tree **);
 void cache_tree_invalidate_path(struct cache_tree *, const char *);
 struct cache_tree_sub *cache_tree_sub(struct cache_tree *, const char *);
+int subtree_name_cmp(const char *, int, const char *, int);
 
 void cache_tree_write(struct strbuf *, struct cache_tree *root);
 struct cache_tree *cache_tree_read(const char *buffer, unsigned long size);
diff --git a/read-cache-v5.c b/read-cache-v5.c
index fb549de..b497726 100644
--- a/read-cache-v5.c
+++ b/read-cache-v5.c
@@ -448,6 +448,103 @@ static int read_conflicts(struct conflict_entry **head,
 	return 0;
 }
 
+static struct cache_tree *convert_one(struct directory_queue *queue, int dirnr)
+{
+	int i, subtree_nr;
+	struct cache_tree *it;
+	struct directory_queue *down;
+
+	it = cache_tree();
+	it->entry_count = queue[dirnr].de->de_nentries;
+	subtree_nr = queue[dirnr].de->de_nsubtrees;
+	if (0 <= it->entry_count)
+		hashcpy(it->sha1, queue[dirnr].de->sha1);
+
+	/*
+	* Just a heuristic -- we do not add directories that often but
+	* we do not want to have to extend it immediately when we do,
+	* hence +2.
+	*/
+	it->subtree_alloc = subtree_nr + 2;
+	it->down = xcalloc(it->subtree_alloc, sizeof(struct cache_tree_sub *));
+	down = queue[dirnr].down;
+	for (i = 0; i < subtree_nr; i++) {
+		struct cache_tree *sub;
+		struct cache_tree_sub *subtree;
+		char *buf, *name;
+
+		name = "";
+		buf = strtok(down[i].de->pathname, "/");
+		while (buf) {
+			name = buf;
+			buf = strtok(NULL, "/");
+		}
+		sub = convert_one(down, i);
+		if(!sub)
+			goto free_return;
+		subtree = cache_tree_sub(it, name);
+		subtree->cache_tree = sub;
+	}
+	if (subtree_nr != it->subtree_nr)
+		die("cache-tree: internal error");
+	return it;
+ free_return:
+	cache_tree_free(&it);
+	return NULL;
+}
+
+static int compare_cache_tree_elements(const void *a, const void *b)
+{
+	const struct directory_entry *de1, *de2;
+
+	de1 = ((const struct directory_queue *)a)->de;
+	de2 = ((const struct directory_queue *)b)->de;
+	return subtree_name_cmp(de1->pathname, de1->de_pathlen,
+				de2->pathname, de2->de_pathlen);
+}
+
+static struct directory_entry *sort_directories(struct directory_entry *de,
+						struct directory_queue *queue)
+{
+	int i, nsubtrees;
+
+	nsubtrees = de->de_nsubtrees;
+	for (i = 0; i < nsubtrees; i++) {
+		struct directory_entry *new_de;
+		de = de->next;
+		new_de = xmalloc(directory_entry_size(de->de_pathlen));
+		memcpy(new_de, de, directory_entry_size(de->de_pathlen));
+		queue[i].de = new_de;
+		if (de->de_nsubtrees) {
+			queue[i].down = xcalloc(de->de_nsubtrees,
+					sizeof(struct directory_queue));
+			de = sort_directories(de,
+					queue[i].down);
+		}
+	}
+	qsort(queue, nsubtrees, sizeof(struct directory_queue),
+			compare_cache_tree_elements);
+	return de;
+}
+
+/*
+ * This function modifys the directory argument that is given to it.
+ * Don't use it if the directory entries are still needed after.
+ */
+static struct cache_tree *cache_tree_convert_v5(struct directory_entry *de)
+{
+	struct directory_queue *queue;
+
+	if (!de->de_nentries)
+		return NULL;
+	queue = xcalloc(1, sizeof(struct directory_queue));
+	queue[0].de = de;
+	queue[0].down = xcalloc(de->de_nsubtrees, sizeof(struct directory_queue));
+
+	sort_directories(de, queue[0].down);
+	return convert_one(queue, 0);
+}
+
 static void resolve_undo_convert_v5(struct index_state *istate,
 					struct conflict_entry *ce)
 {
@@ -583,6 +680,7 @@ static int read_index_v5(struct index_state *istate, void *mmap, int mmap_size)
 		if (read_entries(istate, &de, &entry_offset,
 				&mmap, mmap_size, &nr, &foffsetblock) < 0)
 			return -1;
+	istate->cache_tree = cache_tree_convert_v5(root_directory);
 	return 0;
 }
 
-- 
1.7.11.2
