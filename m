From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/RFC v4 10/13] Write index-v5 cache-tree data
Date: Thu, 16 Aug 2012 11:58:46 +0200
Message-ID: <1345111129-6925-11-git-send-email-t.gummerer@gmail.com>
References: <1345111129-6925-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, pclouds@gmail.com, mhagger@alum.mit.edu,
	gitster@pobox.com, robin.rosenberg@dewire.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 16 11:59:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1wrq-0000D2-B9
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 11:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756591Ab2HPJ7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 05:59:38 -0400
Received: from li348-43.members.linode.com ([178.79.179.43]:48207 "EHLO
	tgummerer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756266Ab2HPJ7O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 05:59:14 -0400
Received: by tgummerer.com (Postfix, from userid 1001)
	id 6A74D4EFF3; Thu, 16 Aug 2012 11:59:10 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.GIT
In-Reply-To: <1345111129-6925-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Write the cache-tree data for the index version 5 file format. The
in-memory cache-tree data is converted to the ondisk format, by adding
it to the directory entries, that were compiled from the cache-entries
in the step before.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 read-cache-v5.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/read-cache-v5.c b/read-cache-v5.c
index a2afc94..d740d0b 100644
--- a/read-cache-v5.c
+++ b/read-cache-v5.c
@@ -856,6 +856,57 @@ static struct conflict_entry *create_conflict_entry_from_ce(struct cache_entry *
 	return create_new_conflict(ce->name, ce_namelen(ce), pathlen);
 }
 
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
+static void cache_tree_to_ondisk_v5(struct hash_table *table, struct cache_tree *root)
+{
+	convert_one_to_ondisk_v5(table, root, "", 0, 0);
+}
+
 static struct directory_entry *compile_directory_data(struct index_state *istate,
 						int nfile,
 						unsigned int *ndir,
-- 
1.7.11.2
