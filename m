From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 16/24] read-cache: write index-v5 cache-tree data
Date: Wed, 27 Nov 2013 13:00:51 +0100
Message-ID: <1385553659-9928-17-git-send-email-t.gummerer@gmail.com>
References: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Cc: t.gummerer@gmail.com, gitster@pobox.com, tr@thomasrast.ch,
	mhagger@alum.mit.edu, pclouds@gmail.com,
	robin.rosenberg@dewire.com, sunshine@sunshineco.com,
	ramsay@ramsay1.demon.co.uk
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 27 13:02:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vldp4-00027J-Dg
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 13:02:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755267Ab3K0MCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 07:02:22 -0500
Received: from mail-lb0-f172.google.com ([209.85.217.172]:34871 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325Ab3K0MCV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 07:02:21 -0500
Received: by mail-lb0-f172.google.com with SMTP id z5so5333629lbh.17
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 04:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jbCAJ2mDCQq0uMTJXvEvVBV/8G9KmpRfzBez8PKuAng=;
        b=Rj/cxc26sCt0eps6NuTK9ivef0sVXjRRqG+BtW0JSNYaNchg/pvwlRe7fjeJxwd4sg
         QxNwu0T6mSLayE+JsMWMRcg8la3PFW7nluReVDwls/YQhanJONd3X6uc0wpSbBfwJUNn
         xPaH8AYTVSrK4pcPBnEW+hsYaxJeLRX08lxTYJd26Z5ntkd1gUKKsb7Jp50QUv57zQDl
         20tlyUM1FLLuc20MWUXuLeYZQjWa+bp1BglMVRBSKHbrAb/Asr5FARjYzLFOuv3UTXiv
         sARkCdhj/H/c0WywfXI9twROGLcqjuYpKbwDHIt9o4NxvkCtSwYkRLQgRoyKRfKKDFZ2
         Yx6w==
X-Received: by 10.112.155.70 with SMTP id vu6mr1302385lbb.41.1385553740320;
        Wed, 27 Nov 2013 04:02:20 -0800 (PST)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id e10sm63588670laa.6.2013.11.27.04.02.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2013 04:02:19 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238429>

Write the cache-tree data for the index version 5 file format. The
in-memory cache-tree data is converted to the ondisk format, by adding
it to the directory entries, that were compiled from the cache-entries
in the step before.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 read-cache-v5.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/read-cache-v5.c b/read-cache-v5.c
index 797022f..0d06cfe 100644
--- a/read-cache-v5.c
+++ b/read-cache-v5.c
@@ -789,6 +789,57 @@ static struct directory_entry *get_directory(char *dir, unsigned int dir_len,
 	return ret;
 }
 
+static void convert_one_to_ondisk(struct hash_table *table, struct cache_tree *it,
+				  const char *path, int pathlen, uint32_t crc)
+{
+	int i, path_len = strlen(path);
+	struct directory_entry *search;
+
+	crc = crc32(crc, (Bytef*)path, pathlen);
+	search = lookup_hash(crc, table);
+	while (search && (path_len > search->de_pathlen
+			  || strcmp(path, search->pathname + search->de_pathlen - path_len)))
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
+	if (strcmp(path, ""))
+		crc = crc32(crc, (Bytef*)"/", 1);
+	for (i = 0; i < it->subtree_nr; i++) {
+		struct cache_tree_sub *down = it->down[i];
+		if (i) {
+			struct cache_tree_sub *prev = it->down[i-1];
+			if (subtree_name_cmp(down->name, down->namelen,
+					     prev->name, prev->namelen) <= 0)
+				die("fatal - unsorted cache subtree");
+		}
+		convert_one_to_ondisk(table, down->cache_tree, down->name, down->namelen, crc);
+	}
+}
+
+static void cache_tree_to_ondisk(struct hash_table *table, struct cache_tree *root)
+{
+	convert_one_to_ondisk(table, root, "", 0, 0);
+}
+
 static void ce_queue_push(struct cache_entry **head,
 			  struct cache_entry **tail,
 			  struct cache_entry *ce)
@@ -844,6 +895,8 @@ static struct directory_entry *compile_directory_data(struct index_state *istate
 			*total_file_len -= search->de_pathlen + 1;
 		ce_queue_push(&(search->ce), &(search->ce_last), cache[i]);
 	}
+	if (istate->cache_tree)
+		cache_tree_to_ondisk(&table, istate->cache_tree);
 	return de;
 }
 
-- 
1.8.4.2
