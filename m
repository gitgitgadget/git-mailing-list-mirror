From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 14/19] read-cache: read cache-tree in index-v5
Date: Fri, 12 Jul 2013 19:26:59 +0200
Message-ID: <1373650024-3001-15-git-send-email-t.gummerer@gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
Cc: t.gummerer@gmail.com, trast@inf.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 19:31:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxhBs-0005Wy-Kd
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 19:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965217Ab3GLRb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 13:31:27 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:44041 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964965Ab3GLRb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 13:31:26 -0400
Received: by mail-pd0-f173.google.com with SMTP id v14so8749643pde.18
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 10:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ataiT3bmxI4FG+D2i0dxmHevfMvNFm3/AqjmUirBAXc=;
        b=sxgnXUKHbJsXV5DH/UBooPzGeOJFG05bfYFxNu5xPG6Uqh7SFk58087qv5xrAelb6X
         q+Q3+6+OllA9RRIMBTEv4F6SBKC9YP6h4g05f+bm8XeEnYOesWpczq+SZeUHPIfcqfOt
         IMMdSm5Qkr9Bk1Wq+QAmbXNOWeDG01TMQ2KysRJvaRYxWtOxyjVD0Nu9lTyoOXjPzwT+
         uVZ4DE/2+si0316EGX6mMi+9P83j4j4CCjo2ayPnlHwReS0WgRKfxYi7TwjtqOUQ+IAw
         jJaCdzM5n67LB+RpOas0VVcGaiCYME4bJLTRmKueSHCGRyqqsudjlFbgb+LTTfk7SUJp
         nFYw==
X-Received: by 10.66.67.5 with SMTP id j5mr43519836pat.176.1373650285904;
        Fri, 12 Jul 2013 10:31:25 -0700 (PDT)
Received: from localhost ([2001:470:6d:596:9227:e4ff:feea:9196])
        by mx.google.com with ESMTPSA id lk9sm31386452pab.2.2013.07.12.10.30.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 10:31:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
In-Reply-To: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230226>

Since the cache-tree data is saved as part of the directory data,
we already read it at the beginning of the index. The cache-tree
is only converted from this directory data.

The cache-tree data is arranged in a tree, with the children sorted by
pathlen at each node, while the ondisk format is sorted lexically.
So we have to rebuild this format from the on-disk directory list.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 cache-tree.c    |   2 +-
 cache-tree.h    |   6 ++++
 read-cache-v5.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/cache-tree.c b/cache-tree.c
index 37e4d00..f4b0917 100644
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
index 55d0f59..9aac493 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -21,10 +21,16 @@ struct cache_tree {
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
index 853b97d..0b9c320 100644
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
+	 * Just a heuristic -- we do not add directories that often but
+	 * we do not want to have to extend it immediately when we do,
+	 * hence +2.
+	 */
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
+ * This function modifies the directory argument that is given to it.
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
 				    struct conflict_entry *conflict)
 {
@@ -644,6 +741,7 @@ static int read_index_filtered_v5(struct index_state *istate, void *mmap,
 		} else
 			de = de->next;
 	}
+	istate->cache_tree = cache_tree_convert_v5(root_directory);
 	istate->cache_nr = nr;
 	return 0;
 }
@@ -665,6 +763,8 @@ static int read_index_v5(struct index_state *istate, void *mmap,
 		if (read_entries(istate, &de, &entry_offset, &mmap,
 				 mmap_size, &nr, &foffsetblock) < 0)
 			return -1;
+
+	istate->cache_tree = cache_tree_convert_v5(root_directory);
 	istate->cache_nr = nr;
 	return 0;
 }
-- 
1.8.3.453.g1dfc63d
