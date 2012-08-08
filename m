From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/RFC v3 10/13] Write index-v5 cache-tree data
Date: Wed,  8 Aug 2012 13:17:58 +0200
Message-ID: <1344424681-31469-11-git-send-email-t.gummerer@gmail.com>
References: <1344424681-31469-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 08 13:27:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sz4Q3-0005W3-Vb
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 13:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756262Ab2HHL0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 07:26:46 -0400
Received: from li348-43.members.linode.com ([178.79.179.43]:36955 "EHLO
	tgummerer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756041Ab2HHL02 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 07:26:28 -0400
Received: by tgummerer.com (Postfix, from userid 1001)
	id 3CC344EFF4; Wed,  8 Aug 2012 13:18:49 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.GIT
In-Reply-To: <1344424681-31469-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203077>

Write the cache-tree data for the index version 5 file format. The
in-memory cache-tree data is converted to the ondisk format, by adding
it to the directory entries, that were compiled from the cache-entries
in the step before.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 cache-tree.c |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 cache-tree.h |    1 +
 read-cache.c |    1 +
 3 files changed, 54 insertions(+)

diff --git a/cache-tree.c b/cache-tree.c
index 440cd04..e167b61 100644
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
index 7f29d26..e08bc31 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -37,6 +37,7 @@ struct cache_tree *cache_tree_read(const char *buffer, unsigned long size);
  * Don't use it if the directory entries are still needed after.
  */
 struct cache_tree *cache_tree_convert_v5(struct directory_entry *de);
+void cache_tree_to_ondisk_v5(struct hash_table *table, struct cache_tree *root);
 
 int cache_tree_fully_valid(struct cache_tree *);
 int cache_tree_update(struct cache_tree *, struct cache_entry **, int, int);
diff --git a/read-cache.c b/read-cache.c
index 199ba75..962d6a2 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1310,6 +1310,7 @@ void update_index_if_able(struct index_state *istate, struct lock_file *lockfile
 	else
 		rollback_lock_file(lockfile);
 }
+
 int write_index(struct index_state *istate, int newfd)
 {
 	set_istate_ops(istate);
-- 
1.7.10.GIT
