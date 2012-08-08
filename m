From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/RFC v3 08/13] Read cache-tree in index-v5
Date: Wed,  8 Aug 2012 13:17:56 +0200
Message-ID: <1344424681-31469-9-git-send-email-t.gummerer@gmail.com>
References: <1344424681-31469-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 08 13:26:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sz4Pe-0004pP-CQ
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 13:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756044Ab2HHL0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 07:26:49 -0400
Received: from li348-43.members.linode.com ([178.79.179.43]:36948 "EHLO
	tgummerer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755897Ab2HHL01 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 07:26:27 -0400
Received: by tgummerer.com (Postfix, from userid 1001)
	id DF37F4EFF2; Wed,  8 Aug 2012 13:18:48 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.GIT
In-Reply-To: <1344424681-31469-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203073>

Since the cache-tree data is saved as part of the directory data,
we already read it at the beginning of the index. The cache-tree
is only converted from this directory data.

The cache-tree data is arranged in a tree, with the children sorted by
pathlen at each node, while the ondisk format is sorted lexically.
So we have to rebuild this format from the on-disk directory list.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 cache-tree.c    |   93 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 cache-tree.h    |   10 ++++++
 read-cache-v5.c |    1 +
 3 files changed, 104 insertions(+)

diff --git a/cache-tree.c b/cache-tree.c
index 28ed657..440cd04 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -519,6 +519,99 @@ struct cache_tree *cache_tree_read(const char *buffer, unsigned long size)
 	return read_one(&buffer, &size);
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
+struct cache_tree *cache_tree_convert_v5(struct directory_entry *de)
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
 static struct cache_tree *cache_tree_find(struct cache_tree *it, const char *path)
 {
 	if (!it)
diff --git a/cache-tree.h b/cache-tree.h
index d8cb2e9..7f29d26 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -20,6 +20,11 @@ struct cache_tree {
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
@@ -27,6 +32,11 @@ struct cache_tree_sub *cache_tree_sub(struct cache_tree *, const char *);
 
 void cache_tree_write(struct strbuf *, struct cache_tree *root);
 struct cache_tree *cache_tree_read(const char *buffer, unsigned long size);
+/*
+ * This function modifys the directory argument that is given to it.
+ * Don't use it if the directory entries are still needed after.
+ */
+struct cache_tree *cache_tree_convert_v5(struct directory_entry *de);
 
 int cache_tree_fully_valid(struct cache_tree *);
 int cache_tree_update(struct cache_tree *, struct cache_entry **, int, int);
diff --git a/read-cache-v5.c b/read-cache-v5.c
index b47398d..57d0fb5 100644
--- a/read-cache-v5.c
+++ b/read-cache-v5.c
@@ -580,6 +580,7 @@ static void read_index_v5(struct index_state *istate, void *mmap, int mmap_size,
 	while (de)
 		de = read_entries(istate, de, &entry_offset,
 				&mmap, mmap_size, &nr, &foffsetblock, fd);
+	istate->cache_tree = cache_tree_convert_v5(root_directory);
 }
 
 struct index_ops v5_ops = {
-- 
1.7.10.GIT
