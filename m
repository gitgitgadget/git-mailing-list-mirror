From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 19/22] read-cache: write index-v5 cache-tree data
Date: Sun,  7 Jul 2013 10:11:57 +0200
Message-ID: <1373184720-29767-20-git-send-email-t.gummerer@gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 07 10:13:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvk6K-0006b7-F6
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 10:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170Ab3GGINk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 04:13:40 -0400
Received: from mail-ee0-f42.google.com ([74.125.83.42]:33394 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130Ab3GGINh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 04:13:37 -0400
Received: by mail-ee0-f42.google.com with SMTP id c4so2174773eek.29
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 01:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=3YWVlrweFDJxCDIiUTzBghKmbWZJB4ruwn385Weex3E=;
        b=WTjhwJ7vOJd63gbuind6/pjZomFY5y/mSXgHFqJTAo0Iue4/L4vlLYie+b0QQqNGIc
         a/gJU8Fy9XNxpB/H8KfbwMrPDE6X/oXoPwRN6csmUGugXs2o16hULoPlRvFVlfU8n0Vs
         PxBmLYeoLOg1tQQtFSrGlAS+jsvFReDdO/4wLu86YwazfUzg03T5JODPe3A/PgL9Pncc
         D+7+8xJtifh6HionM5mZrRaI2p4F8EZdFVFCBq7CV/K8pUXEfLVoP/rZWWoV8TGqQKjV
         nJfGhLCkxqtqh6U4MdTkNvzdXLda1syuUEPC1B8hIyqWIYFpb5eXacuAjuQl8XjeKoUy
         Ds2A==
X-Received: by 10.14.8.197 with SMTP id 45mr19390116eer.66.1373184815846;
        Sun, 07 Jul 2013 01:13:35 -0700 (PDT)
Received: from localhost (host252-23-dynamic.0-87-r.retail.telecomitalia.it. [87.0.23.252])
        by mx.google.com with ESMTPSA id b7sm30646140eef.16.2013.07.07.01.13.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Jul 2013 01:13:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
In-Reply-To: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229747>

Write the cache-tree data for the index version 5 file format. The
in-memory cache-tree data is converted to the ondisk format, by adding
it to the directory entries, that were compiled from the cache-entries
in the step before.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 read-cache-v5.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/read-cache-v5.c b/read-cache-v5.c
index f056f6b..306de30 100644
--- a/read-cache-v5.c
+++ b/read-cache-v5.c
@@ -960,6 +960,57 @@ static struct conflict_entry *create_conflict_entry_from_ce(struct cache_entry *
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
@@ -1065,6 +1116,8 @@ static struct directory_entry *compile_directory_data(struct index_state *istate
 			previous_entry->next = no_subtrees;
 		}
 	}
+	if (istate->cache_tree)
+		cache_tree_to_ondisk_v5(&table, istate->cache_tree);
 	return de;
 }
 
-- 
1.8.3.453.g1dfc63d
