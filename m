From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 17/24] read-cache: read cache-tree in index-v5
Date: Sun, 18 Aug 2013 21:42:06 +0200
Message-ID: <1376854933-31241-18-git-send-email-t.gummerer@gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk,
	t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 18 21:49:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB8yL-0004CM-TG
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 21:49:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754972Ab3HRTtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 15:49:04 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:39726 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754935Ab3HRTtB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 15:49:01 -0400
Received: by mail-wg0-f48.google.com with SMTP id f12so2890433wgh.15
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 12:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yjbvtI6bYmGg1OKYaes7S9Ad1snFf/JLgQZujN6fwMY=;
        b=oSwDQjjraRdIj65VBgSsG4+MJC7thf4zampeTJeFL309rNBFEoAAVT+/iTEGelcUFo
         UNHbsj8EjiYIG0rk7ImZg848hW/7uDEzqWsIhz6tjytEbjFDcaYs0ljZXK4/XATdlIWn
         aXFVsziU3Mfha23e+WKf72o4iI9zc8ztYj5N6hVn1O7W+sAcn6yR6S0Uh9KXCef6Rsb2
         zuEEabp8MVKkOsHID/9O9EQj+1/82L7GbjsbxXXNZntj/FVnXR6XbwkuVHa4LAoKm3Gh
         wQoUpGplrLW37W5I73+Fvuz4u1qGt767SHJ1uWAIOPJblmAUwK4VuC06zPOrjgOoxm0U
         TwsA==
X-Received: by 10.181.12.18 with SMTP id em18mr5514793wid.51.1376855340063;
        Sun, 18 Aug 2013 12:49:00 -0700 (PDT)
Received: from localhost (host105-104-dynamic.0-79-r.retail.telecomitalia.it. [79.0.104.105])
        by mx.google.com with ESMTPSA id a8sm11925478wie.6.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 18 Aug 2013 12:48:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1231.g9fbf354.dirty
In-Reply-To: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232505>

Since the cache-tree data is saved as part of the directory data,
we already read it at the beginning of the index. The cache-tree
is only converted from this directory data.

The cache-tree data is arranged in a tree, with the children sorted by
pathlen at each node, while the ondisk format is sorted lexically.
So we have to rebuild this format from the on-disk directory list.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 cache-tree.c    |  2 +-
 cache-tree.h    |  1 +
 read-cache-v5.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/cache-tree.c b/cache-tree.c
index 0bbec43..1209732 100644
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
index f1923ad..9818926 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -25,6 +25,7 @@ struct cache_tree *cache_tree(void);
 void cache_tree_free(struct cache_tree **);
 void cache_tree_invalidate_path(struct cache_tree *, const char *);
 struct cache_tree_sub *cache_tree_sub(struct cache_tree *, const char *);
+int subtree_name_cmp(const char *, int, const char *, int);
 
 void cache_tree_write(struct strbuf *, struct cache_tree *root);
 struct cache_tree *cache_tree_read(const char *buffer, unsigned long size);
diff --git a/read-cache-v5.c b/read-cache-v5.c
index 85a2069..b14505a 100644
--- a/read-cache-v5.c
+++ b/read-cache-v5.c
@@ -471,6 +471,83 @@ static int convert_resolve_undo(struct index_state *istate,
 	return 0;
 }
 
+static struct cache_tree *convert_one(struct directory_entry *de)
+{
+	int i;
+	struct cache_tree *it;
+
+	it = cache_tree();
+	it->entry_count = de->de_nentries;
+	if (0 <= it->entry_count)
+		hashcpy(it->sha1, de->sha1);
+
+	/*
+	 * Just a heuristic -- we do not add directories that often but
+	 * we do not want to have to extend it immediately when we do,
+	 * hence +2.
+	 */
+	it->subtree_alloc = de->de_nsubtrees + 2;
+	it->down = xcalloc(it->subtree_alloc, sizeof(struct cache_tree_sub *));
+	for (i = 0; i < de->de_nsubtrees; i++) {
+		struct cache_tree *sub;
+		struct cache_tree_sub *subtree;
+		char *buf, *name;
+
+		sub = convert_one(de->sub[i]);
+		if(!sub)
+			goto free_return;
+
+		name = "";
+		buf = strtok(de->sub[i]->pathname, "/");
+		while (buf) {
+			name = buf;
+			buf = strtok(NULL, "/");
+		}
+		subtree = cache_tree_sub(it, name);
+		subtree->cache_tree = sub;
+	}
+	if (de->de_nsubtrees != it->subtree_nr)
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
+	de1 = (const struct directory_entry *) a;
+	de2 = (const struct directory_entry *) b;
+	return subtree_name_cmp(de1->pathname, de1->de_pathlen,
+				de2->pathname, de2->de_pathlen);
+}
+
+static void sort_directories(struct directory_entry *de)
+{
+	int i;
+
+	for (i = 0; i < de->de_nsubtrees; i++) {
+		if (de->sub[i]->de_nsubtrees)
+			sort_directories(de->sub[i]);
+	}
+	qsort(de->sub, de->de_nsubtrees, sizeof(struct directory_entry *),
+	      compare_cache_tree_elements);
+}
+
+/*
+ * This function modifies the directory argument that is given to it.
+ * Don't use it if the directory entries are still needed after.
+ */
+static struct cache_tree *cache_tree_convert_v5(struct directory_entry *de)
+{
+	if (!de->de_nentries)
+		return NULL;
+	sort_directories(de);
+	return convert_one(de);
+}
+
 static int read_entries(struct index_state *istate, struct directory_entry *de,
 			unsigned int first_entry_offset, void *mmap,
 			unsigned long mmap_size, unsigned int *nr,
@@ -591,6 +668,7 @@ static int read_index_v5(struct index_state *istate, void *mmap,
 		}
 		de = de->next;
 	}
+	istate->cache_tree = cache_tree_convert_v5(root_directory);
 	istate->cache_nr = nr;
 	return 0;
 }
-- 
1.8.3.4.1231.g9fbf354.dirty
