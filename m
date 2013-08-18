From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 19/24] read-cache: write index-v5 cache-tree data
Date: Sun, 18 Aug 2013 21:42:08 +0200
Message-ID: <1376854933-31241-20-git-send-email-t.gummerer@gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk,
	t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 18 21:49:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB8yS-0004HB-Sj
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 21:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755029Ab3HRTtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 15:49:12 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:40981 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754975Ab3HRTtH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 15:49:07 -0400
Received: by mail-wi0-f178.google.com with SMTP id j17so594288wiw.17
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 12:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gUVR2UPrTQG5p/NtXU5Um5kgrF9DJqEz/shFJjkytoo=;
        b=0a0nGt0Oqkv9srr8zqCU33CTZFe3h8acaXKI8t/bGs265+Z+kSwoqbtjcL0VvQQzE8
         R4sGwDy6JQ7FpWSjhoES7zLdb3+QNTVhK5g8FKx9DSkfpmTwWgXbYeTKpatjFw3j+9vf
         E6LTeEowSAUgE3h53rCRkshezJRhGzgezqIuUTvrojY4MkLz7SYK+tQ89Jr9GAivrTzL
         6qG69ahoidcy2VXD3KvrUoWLNxYfHPRwf8RRKo96t2Yk1Zxshbj9+rr9pWjOhxfzrBXt
         mpmfpWamY09VoREWiuL1JbNAJwbv4x4Am69BU6MMQu02CAof00vaTclSzfrd6BGpdVuH
         /Jqw==
X-Received: by 10.180.78.229 with SMTP id e5mr5441759wix.58.1376855347009;
        Sun, 18 Aug 2013 12:49:07 -0700 (PDT)
Received: from localhost (host105-104-dynamic.0-79-r.retail.telecomitalia.it. [79.0.104.105])
        by mx.google.com with ESMTPSA id z2sm11765405wiv.11.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 18 Aug 2013 12:49:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1231.g9fbf354.dirty
In-Reply-To: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232507>

Write the cache-tree data for the index version 5 file format. The
in-memory cache-tree data is converted to the ondisk format, by adding
it to the directory entries, that were compiled from the cache-entries
in the step before.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 read-cache-v5.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/read-cache-v5.c b/read-cache-v5.c
index 85b912b..ed52b7c 100644
--- a/read-cache-v5.c
+++ b/read-cache-v5.c
@@ -891,6 +891,57 @@ static struct conflict_entry *create_conflict_entry_from_ce(struct cache_entry *
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
 static void ce_queue_push(struct cache_entry **head,
 			  struct cache_entry **tail,
 			  struct cache_entry *ce)
@@ -961,6 +1012,8 @@ static struct directory_entry *compile_directory_data(struct index_state *istate
 			add_part_to_conflict_entry(search, conflict_entry, conflict_part);
 		}
 	}
+	if (istate->cache_tree)
+		cache_tree_to_ondisk_v5(&table, istate->cache_tree);
 	return de;
 }
 
-- 
1.8.3.4.1231.g9fbf354.dirty
