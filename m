From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/RFC v2 13/16] Write index-v5 cache-tree data
Date: Sun,  5 Aug 2012 23:49:10 +0200
Message-ID: <1344203353-2819-14-git-send-email-t.gummerer@gmail.com>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pcouds@gmail.com, robin.rosenberg@dewire.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 23:51:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sy8jF-00025m-AX
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 23:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755247Ab2HEVuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 17:50:50 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:51564 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755197Ab2HEVuK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 17:50:10 -0400
Received: by mail-ey0-f174.google.com with SMTP id c11so648692eaa.19
        for <git@vger.kernel.org>; Sun, 05 Aug 2012 14:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=qTZY05K2oCS3pj/xryXCc3ue10umF0cQAtZCu3UYtXs=;
        b=uFK5Zu4gxfMvESKm5BK9vqzK7yTdQtts1SxMToTassjOQ1DQEpYbSAj2U31jZkF5GL
         8r50ynmSkO5b2o4pzzgDGFPW9etZPKFJ84x4yNzumrGyxISTXLDiy75ekDCTLvXAtOUm
         WgIRMGFL0hB785/qRvTS8hsuUSyDE+3zyXZUqmovJoEf+NWSrRjYD4O8Phky0iTdwkbq
         /LALM02YFjHB8JhM/nqxUtoKTxrBnFV9+zN14T3108lMBK+eJFbmPYrh4Zp+m1VLGi1v
         5+KQBoGQfSGV45aKzwTgY1Qj8I/wLUxDSbzFc5u1QhCpLXqozMDk8rrMAMjgyU44jR4h
         +FFQ==
Received: by 10.14.173.71 with SMTP id u47mr10488671eel.22.1344203409465;
        Sun, 05 Aug 2012 14:50:09 -0700 (PDT)
Received: from localhost ([2a01:7e00::f03c:91ff:fedf:f4db])
        by mx.google.com with ESMTPS id d48sm42268065eeo.10.2012.08.05.14.50.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Aug 2012 14:50:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.GIT
In-Reply-To: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202932>

Write the cache-tree data for the index version 5 file format. The
in-memory cache-tree data is converted to the ondisk format, by adding
it to the directory entries, that were compiled from the cache-entries
in the step before.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 cache-tree.c |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 cache-tree.h |    1 +
 read-cache.c |    2 ++
 3 files changed, 55 insertions(+)

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
index 2c47a97..d18383f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2763,6 +2763,8 @@ static struct directory_entry *compile_directory_data(struct index_state *istate
 			previous_entry->next = no_subtrees;
 		}
 	}
+	if (istate->cache_tree)
+		cache_tree_to_ondisk_v5(&table, istate->cache_tree);
 	return de;
 }
 
-- 
1.7.10.GIT
