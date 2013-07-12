From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 16/19] read-cache: write index-v5 cache-tree data
Date: Fri, 12 Jul 2013 19:27:01 +0200
Message-ID: <1373650024-3001-17-git-send-email-t.gummerer@gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
Cc: t.gummerer@gmail.com, trast@inf.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 19:33:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxhDY-0006kC-JU
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 19:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965188Ab3GLRdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 13:33:13 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:45583 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932813Ab3GLRdM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 13:33:12 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp12so9163095pab.21
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 10:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=WO0fvHWIhVIyCbWLoWc3qxdL1nxObgNnufvo1IUYzUk=;
        b=BxCZDew3v661He8bs7QboFRXGhLhi1/qmPdFZ6XSaqloogQ5BV9JaM3v20w3JBJUdV
         ZDgD5Vyrbg3xZ2y3I4PdhQsxfBlSQzQ+XvlYTcJdwHaoGkqFDXBocIKcyKk+Iv0mZMJC
         QcYuP6MAcN8YggEHWZggEyeOsiC1ZhxG/uLp+f3etg4oXVLXem8H0sLl/vMJbX1qgTm4
         6Sjyi+cCKK3Zhyx/3bf51UTI5EIpyw8ButQi5NZkVVvaPbPczK9KBXnqrqrxKteKH7JE
         Nt2PYRZvc1Pj8fOEbWxhV1pWWZqkswpuTAvcGHvd+zBIqHV1Qo9aHgyppHeZtJgNJ1Hx
         ccpw==
X-Received: by 10.66.182.166 with SMTP id ef6mr43504297pac.35.1373650391546;
        Fri, 12 Jul 2013 10:33:11 -0700 (PDT)
Received: from localhost ([2001:470:6d:596:9227:e4ff:feea:9196])
        by mx.google.com with ESMTPSA id qv4sm46431296pbc.16.2013.07.12.10.33.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 10:33:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
In-Reply-To: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230228>

Write the cache-tree data for the index version 5 file format. The
in-memory cache-tree data is converted to the ondisk format, by adding
it to the directory entries, that were compiled from the cache-entries
in the step before.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 read-cache-v5.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/read-cache-v5.c b/read-cache-v5.c
index 33667d7..cd819b4 100644
--- a/read-cache-v5.c
+++ b/read-cache-v5.c
@@ -941,6 +941,57 @@ static struct conflict_entry *create_conflict_entry_from_ce(struct cache_entry *
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
@@ -1046,6 +1097,8 @@ static struct directory_entry *compile_directory_data(struct index_state *istate
 			previous_entry->next = no_subtrees;
 		}
 	}
+	if (istate->cache_tree)
+		cache_tree_to_ondisk_v5(&table, istate->cache_tree);
 	return de;
 }
 
-- 
1.8.3.453.g1dfc63d
