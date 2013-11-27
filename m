From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 14/24] read-cache: read cache-tree in index-v5
Date: Wed, 27 Nov 2013 13:00:49 +0100
Message-ID: <1385553659-9928-15-git-send-email-t.gummerer@gmail.com>
References: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Cc: t.gummerer@gmail.com, gitster@pobox.com, tr@thomasrast.ch,
	mhagger@alum.mit.edu, pclouds@gmail.com,
	robin.rosenberg@dewire.com, sunshine@sunshineco.com,
	ramsay@ramsay1.demon.co.uk
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 27 13:02:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vldoz-00024B-UU
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 13:02:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755260Ab3K0MCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 07:02:18 -0500
Received: from mail-lb0-f169.google.com ([209.85.217.169]:54824 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755178Ab3K0MCP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 07:02:15 -0500
Received: by mail-lb0-f169.google.com with SMTP id y6so5341923lbh.14
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 04:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pAsQdGcY8BeGRcceBbhhi7OqaUS/wfi72OemZeQu6SA=;
        b=eEN7zB4U9C5Y43cNbjF07ZjdJG+513ZxaBhbH658XpNACHsvxjViCeJXnBlfRsihoQ
         FXo+OBdV25lu9dpIsL1tSvfELb03/NTOT4daionVIYizgLoKv/NBE1+auhHoOVV8MIm2
         qLUKZzC8qZSx7LoBtjjymRRmyj5X49Q0PpJWOmbbLc+j4aCMCpszV1S0U+Ey1ylZq46p
         MX4LAt8nk444DmOoFTDf3SQ6ljM5L9xgKxXZzXuw70nK+t1zVkg0jlZHWBTJJKcorDC7
         ijJ4FE5RkvH92hoNdBPGCF9qoFDrw8m+UKZOnf77FQjJPz+JkaL1PTUL7hzgu9kdoUZx
         1PJw==
X-Received: by 10.152.28.230 with SMTP id e6mr23945601lah.3.1385553734120;
        Wed, 27 Nov 2013 04:02:14 -0800 (PST)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id c15sm7728515lbq.11.2013.11.27.04.02.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2013 04:02:13 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238428>

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
 read-cache-v5.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 1 deletion(-)

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
index a9c687f..01f1c88 100644
--- a/read-cache-v5.c
+++ b/read-cache-v5.c
@@ -418,6 +418,73 @@ static int read_index_extension(struct index_state *istate,
 	return 0;
 }
 
+static int compare_cache_tree(const void *a, const void *b)
+{
+	const struct cache_tree_sub *it1, *it2;
+
+	it1 = *(const struct cache_tree_sub **) a;
+	it2 = *(const struct cache_tree_sub **) b;
+	return subtree_name_cmp(it1->name, it1->namelen,
+				it2->name, it2->namelen);
+}
+
+/*
+ * Convert the directory entries to cache-tree entries
+ * recursively.
+ */
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
+		struct cache_tree *sub = convert_one(de->sub[i]);
+		struct cache_tree_sub *subtree;
+		/* -1 for removing the / at the end of the pathname */
+		int namelen = de->sub[i]->de_pathlen - de->de_pathlen - 1;
+
+		if (!sub)
+			goto free_return;
+
+		subtree = xmalloc(sizeof(*subtree) + namelen + 1);
+		subtree->cache_tree = sub;
+		subtree->namelen = namelen;
+		memcpy(subtree->name, de->sub[i]->pathname + de->de_pathlen, namelen);
+		subtree->name[namelen] = '\0';
+		it->down[i] = subtree;
+		it->subtree_nr++;
+	}
+	qsort(it->down, it->subtree_nr, sizeof(struct cache_tree_sub *),
+	      compare_cache_tree);
+	return it;
+free_return:
+	cache_tree_free(&it);
+	return NULL;
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
+	return convert_one(de);
+}
+
 /*
  * Read all file entries from the index.  This function is recursive to get
  * the ordering right. In the index file the entries are sorted def, abc/def,
@@ -558,6 +625,7 @@ static int read_index_v5(struct index_state *istate, void *mmap,
 				return -1;
 		}
 	}
+	istate->cache_tree = cache_tree_convert_v5(root_directory);
 	free_directory_tree(root_directory);
 	istate->cache_nr = nr;
 	return 0;
-- 
1.8.4.2
