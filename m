From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 13/16] Write index-v5 cache-tree data
Date: Thu,  2 Aug 2012 13:02:03 +0200
Message-ID: <1343905326-23790-14-git-send-email-t.gummerer@gmail.com>
References: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 02 13:03:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwtBo-0005Lo-JG
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 13:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754643Ab2HBLDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 07:03:20 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:40752 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754375Ab2HBLDP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 07:03:15 -0400
Received: by mail-ee0-f46.google.com with SMTP id l10so2331137eei.19
        for <git@vger.kernel.org>; Thu, 02 Aug 2012 04:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=GHXhc2haJfzs1Gpu60w+OdDnpPa9cGzhe/PIy+B8wfU=;
        b=dUiK57RWxDOi7uOBE6AAvONZvU2TyYOrmBqrXz1rY/xHPnGCI8MSxyjS48U0/mMwF3
         29rM0O2reXn1K1ViYOxhyv+/eWxY/qzdV/tKScxHuhS44kC7Fou14zetf2fgLHchpeDr
         zIYE3RVS/wvNgzJ+17aldHEuhPKQ32vDvk6oSXFDjOu07SeUDDf5+sG0Qb/CrUROwFVn
         +pDoLgtLPcqNeWkOXkcbXHzPro0gEFkAr0V/NNjynd2/pwbXAGTdgGfm9D+GIZJWxUhs
         LxD+qRGhQUMLLG9bhy7i9uor+ulW4ib8uiIXFUtxi1ZXh9tYUwldNDFC4+Vj05dlz3kQ
         VCqA==
Received: by 10.14.210.194 with SMTP id u42mr26516983eeo.11.1343905394404;
        Thu, 02 Aug 2012 04:03:14 -0700 (PDT)
Received: from localhost ([2a01:7e00::f03c:91ff:fedf:f4db])
        by mx.google.com with ESMTPS id w5sm16469096eeo.1.2012.08.02.04.03.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Aug 2012 04:03:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.886.gdf6792c.dirty
In-Reply-To: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202760>

Write the cache-tree data for the index version 5 file format. The
in-memory cache-tree data is converted to the ondisk format, by adding
it to the directory entries, that were compiled from the cache-entries
in the step before.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 cache-tree.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 cache-tree.h |  1 +
 read-cache.c |  2 ++
 3 files changed, 55 insertions(+)

diff --git a/cache-tree.c b/cache-tree.c
index 6a314aa..bf945ef 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -612,6 +612,58 @@ struct cache_tree *cache_tree_convert_v5(struct directory_entry *de)
 	return convert_one(queue, 0);
 }
 
+
+static void convert_one_to_ondisk_v5(struct hash_table *table, struct cache_tree *it,
+				const char *path, int pathlen, uint32_t crc)
+{
+	int i;
+	struct directory_entry *found, *search;
+
+	crc = crc32(crc, (Bytef*)path, pathlen);
+	found = lookup_hash(crc, table);
+	search = found;
+	while (search && strcmp(path, search->pathname + search->de_pathlen - strlen(path)) != 0)
+		search = search->next_hash;
+	if (!search)
+		return;
+	/*
+	 * The number of subtrees is already calculated by
+	 * compile_directory_data, therefore we only need to
+	 * add the entry_count
+	 */
+	search->de_nentries = it->entry_count;
+	if (0 <= it->entry_count)
+		hashcpy(search->sha1, it->sha1);
+	if (strcmp(path, "") != 0)
+		crc = crc32(crc, (Bytef*)"/", 1);
+
+#if DEBUG
+	if (0 <= it->entry_count)
+		fprintf(stderr, "cache-tree <%.*s> (%d ent, %d subtree) %s\n",
+			pathlen, path, it->entry_count, it->subtree_nr,
+			sha1_to_hex(it->sha1));
+	else
+		fprintf(stderr, "cache-tree <%.*s> (%d subtree) invalid\n",
+			pathlen, path, it->subtree_nr);
+#endif
+
+	for (i = 0; i < it->subtree_nr; i++) {
+		struct cache_tree_sub *down = it->down[i];
+		if (i) {
+			struct cache_tree_sub *prev = it->down[i-1];
+			if (subtree_name_cmp(down->name, down->namelen,
+					     prev->name, prev->namelen) <= 0)
+				die("fatal - unsorted cache subtree");
+		}
+		convert_one_to_ondisk_v5(table, down->cache_tree, down->name, down->namelen, crc);
+	}
+}
+
+void cache_tree_to_ondisk_v5(struct hash_table *table, struct cache_tree *root)
+{
+	convert_one_to_ondisk_v5(table, root, "", 0, 0);
+}
+
 static struct cache_tree *cache_tree_find(struct cache_tree *it, const char *path)
 {
 	if (!it)
diff --git a/cache-tree.h b/cache-tree.h
index f4131a6..a41b684 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -33,6 +33,7 @@ struct cache_tree_sub *cache_tree_sub(struct cache_tree *, const char *);
 void cache_tree_write(struct strbuf *, struct cache_tree *root);
 struct cache_tree *cache_tree_read(const char *buffer, unsigned long size);
 struct cache_tree *cache_tree_convert_v5(struct directory_entry *de);
+void cache_tree_to_ondisk_v5(struct hash_table *table, struct cache_tree *root);
 
 int cache_tree_fully_valid(struct cache_tree *);
 int cache_tree_update(struct cache_tree *, struct cache_entry **, int, int);
diff --git a/read-cache.c b/read-cache.c
index 0f1a218..6538ddf 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2742,6 +2742,8 @@ static struct directory_entry *compile_directory_data(struct index_state *istate
 			previous_entry->next = no_subtrees;
 		}
 	}
+	if (istate->cache_tree)
+		cache_tree_to_ondisk_v5(&table, istate->cache_tree);
 	return de;
 }
 
-- 
1.7.10.886.gdf6792c.dirty
