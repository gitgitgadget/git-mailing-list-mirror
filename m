From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 17/22] read-cache: read cache-tree in index-v5
Date: Sun,  7 Jul 2013 10:11:55 +0200
Message-ID: <1373184720-29767-18-git-send-email-t.gummerer@gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 07 10:13:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvk6F-0006Vz-V6
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 10:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141Ab3GGINe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 04:13:34 -0400
Received: from mail-ea0-f182.google.com ([209.85.215.182]:54855 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130Ab3GGINa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 04:13:30 -0400
Received: by mail-ea0-f182.google.com with SMTP id d10so2275957eaj.27
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 01:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Y2FeaXoP8EBPzb7CSNh7FOynse1keaVTwJ1aeEW1N10=;
        b=ygaZ0RDap6bPfR3X6w5vuzWQ3yElLSe09PTnJ7O4y3qyFQN3ZBJAaVESDyX0yZ7J63
         cG4RQb6VjmmnTjqnsdqkB778gFhqRSwfcj4v7fsM1OJD0UfgVtn30xzeovsZnNL7UtNS
         PQTLEZCEPcu+MCc9Xjc8Md+Yi7aut/Ooez3Q9VCLtaZgyOpGtOOvaVR65/PMxLMJMbOc
         x78eg6iKBC48WlHmwWkwe+gSGqVprvXqIOCg6EUVXawxyAAoYOZO9eAW4kFuvJ4YkNXD
         l6Mgng5wPi/Ii6Jh5p1G0qODJgsXa5wReGzR1vScjJyRtL40Tx0Y6ikkdrX38CUnMZiG
         jKFA==
X-Received: by 10.14.180.4 with SMTP id i4mr19189942eem.148.1373184808071;
        Sun, 07 Jul 2013 01:13:28 -0700 (PDT)
Received: from localhost (host252-23-dynamic.0-87-r.retail.telecomitalia.it. [87.0.23.252])
        by mx.google.com with ESMTPSA id a4sm30839114eez.0.2013.07.07.01.13.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Jul 2013 01:13:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
In-Reply-To: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229748>

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
index 193970a..f1ad132 100644
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
 				    struct conflict_entry *conflict)
 {
@@ -650,6 +747,7 @@ static int read_index_filtered_v5(struct index_state *istate, void *mmap,
 		} else
 			de = de->next;
 	}
+	istate->cache_tree = cache_tree_convert_v5(root_directory);
 	istate->cache_nr = nr;
 	istate->partially_read = 1;
 	return 0;
@@ -673,6 +771,8 @@ static int read_index_v5(struct index_state *istate, void *mmap,
 		if (read_entries(istate, &de, &entry_offset, &mmap,
 				 mmap_size, &nr, &foffsetblock, &prev) < 0)
 			return -1;
+
+	istate->cache_tree = cache_tree_convert_v5(root_directory);
 	istate->cache_nr = nr;
 	istate->partially_read = 0;
 	return 0;
-- 
1.8.3.453.g1dfc63d
