From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3/5] Add return value to 'traverse_tree()' callback
Date: Wed, 5 Mar 2008 19:44:06 -0800
Message-ID: <b76bfb983fb30e3f9b6a7391ed2c11ac7e131f01.1204777699.git.torvalds@linux-foundation.org>
References: <cover.1204777699.git.torvalds@linux-foundation.org>
To: undisclosed-recipients:;
X-From: git-owner@vger.kernel.org Thu Mar 06 05:38:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX7rr-0003zU-N3
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 05:38:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756840AbYCFEhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 23:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756801AbYCFEhV
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 23:37:21 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45899 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756661AbYCFEhT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2008 23:37:19 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m264bMG0006326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 5 Mar 2008 20:37:23 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m264b3mj008938;
	Wed, 5 Mar 2008 20:37:03 -0800
In-Reply-To: <cover.1204777699.git.torvalds@linux-foundation.org>
X-Spam-Status: No, hits=-3.918 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76324>

This allows the callback to return an error value, but it can also
specify which of the tree entries that it actually used up by returning
a positive mask value.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 merge-tree.c |    9 +++++----
 tree-walk.c  |   22 +++++++++++++++-------
 tree-walk.h  |    4 ++--
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/merge-tree.c b/merge-tree.c
index a3511b7..8be0b9f 100644
--- a/merge-tree.c
+++ b/merge-tree.c
@@ -287,31 +287,32 @@ static void unresolved(const struct traverse_info *info, struct name_entry n[3])
  * The successful merge rules are the same as for the three-way merge
  * in git-read-tree.
  */
-static void threeway_callback(int n, unsigned long mask, struct name_entry *entry, struct traverse_info *info)
+static int threeway_callback(int n, unsigned long mask, struct name_entry *entry, struct traverse_info *info)
 {
 	/* Same in both? */
 	if (same_entry(entry+1, entry+2)) {
 		if (entry[0].sha1) {
 			resolve(info, NULL, entry+1);
-			return;
+			return mask;
 		}
 	}
 
 	if (same_entry(entry+0, entry+1)) {
 		if (entry[2].sha1 && !S_ISDIR(entry[2].mode)) {
 			resolve(info, entry+1, entry+2);
-			return;
+			return mask;
 		}
 	}
 
 	if (same_entry(entry+0, entry+2)) {
 		if (entry[1].sha1 && !S_ISDIR(entry[1].mode)) {
 			resolve(info, NULL, entry+1);
-			return;
+			return mask;
 		}
 	}
 
 	unresolved(info, entry);
+	return mask;
 }
 
 static void merge_trees(struct tree_desc t[3], const char *base)
diff --git a/tree-walk.c b/tree-walk.c
index f9f7d22..7170e37 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -135,8 +135,9 @@ char *make_traverse_path(char *path, const struct traverse_info *info, const str
 	return path;
 }
 
-void traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
+int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 {
+	int ret = 0;
 	struct name_entry *entry = xmalloc(n*sizeof(*entry));
 
 	for (;;) {
@@ -171,19 +172,26 @@ void traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 			break;
 
 		/*
-		 * Update the tree entries we've walked, and clear
-		 * all the unused name-entries.
+		 * Clear all the unused name-entries.
 		 */
 		for (i = 0; i < n; i++) {
-			if (mask & (1ul << i)) {
-				update_tree_entry(t+i);
+			if (mask & (1ul << i))
 				continue;
-			}
 			entry_clear(entry + i);
 		}
-		info->fn(n, mask, entry, info);
+		ret = info->fn(n, mask, entry, info);
+		if (ret < 0)
+			break;
+		if (ret)
+			mask &= ret;
+		ret = 0;
+		for (i = 0; i < n; i++) {
+			if (mask & (1ul << i))
+				update_tree_entry(t + i);
+		}
 	}
 	free(entry);
+	return ret;
 }
 
 static int find_tree_entry(struct tree_desc *t, const char *name, unsigned char *result, unsigned *mode)
diff --git a/tree-walk.h b/tree-walk.h
index 7c4ae64..c123cfe 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -34,8 +34,8 @@ int tree_entry(struct tree_desc *, struct name_entry *);
 void *fill_tree_descriptor(struct tree_desc *desc, const unsigned char *sha1);
 
 struct traverse_info;
-typedef void (*traverse_callback_t)(int n, unsigned long mask, struct name_entry *entry, struct traverse_info *);
-void traverse_trees(int n, struct tree_desc *t, struct traverse_info *info);
+typedef int (*traverse_callback_t)(int n, unsigned long mask, struct name_entry *entry, struct traverse_info *);
+int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info);
 
 struct traverse_info {
 	struct traverse_info *prev;
-- 
1.5.4.3.452.g67136


