From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4/5] Make 'traverse_trees()' traverse conflicting DF entries in parallel
Date: Wed, 5 Mar 2008 20:06:18 -0800
Message-ID: <1d928e552af6d508dfebe507a7a556d0b3c1084d.1204777699.git.torvalds@linux-foundation.org>
References: <cover.1204777699.git.torvalds@linux-foundation.org>
To: undisclosed-recipients:;
X-From: git-owner@vger.kernel.org Thu Mar 06 05:38:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX7rr-0003zU-2D
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 05:38:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756826AbYCFEhQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 23:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756661AbYCFEhP
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 23:37:15 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35521 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756616AbYCFEhN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2008 23:37:13 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m264bTdc006335
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 5 Mar 2008 20:37:30 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m264b9cf008943;
	Wed, 5 Mar 2008 20:37:10 -0800
In-Reply-To: <cover.1204777699.git.torvalds@linux-foundation.org>
X-Spam-Status: No, hits=-3.907 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76323>

This makes the traverse_trees() entry comparator routine use the more
relaxed form of name comparison that considers files and directories
with the same name identical.

We pass in a separate mask for just the directory entries, so that the
callback routine can decide (if it wants to) to only handle one or the
other type, but generally most (all?) users are expected to really want
to see the case of a name 'foo' showing up in one tree as a file and in
another as a directory at the same time.

In particular, moving 'unpack_trees()' over to use this tree traversal
mechanism requires this.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 merge-tree.c |    2 +-
 tree-walk.c  |    8 ++++++--
 tree-walk.h  |    3 ++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/merge-tree.c b/merge-tree.c
index 8be0b9f..02fc10f 100644
--- a/merge-tree.c
+++ b/merge-tree.c
@@ -287,7 +287,7 @@ static void unresolved(const struct traverse_info *info, struct name_entry n[3])
  * The successful merge rules are the same as for the three-way merge
  * in git-read-tree.
  */
-static int threeway_callback(int n, unsigned long mask, struct name_entry *entry, struct traverse_info *info)
+static int threeway_callback(int n, unsigned long mask, unsigned long dirmask, struct name_entry *entry, struct traverse_info *info)
 {
 	/* Same in both? */
 	if (same_entry(entry+1, entry+2)) {
diff --git a/tree-walk.c b/tree-walk.c
index 7170e37..842cb6a 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -62,7 +62,7 @@ void *fill_tree_descriptor(struct tree_desc *desc, const unsigned char *sha1)
 
 static int entry_compare(struct name_entry *a, struct name_entry *b)
 {
-	return base_name_compare(
+	return df_name_compare(
 			a->path, tree_entry_len(a->path, a->sha1), a->mode,
 			b->path, tree_entry_len(b->path, b->sha1), b->mode);
 }
@@ -142,6 +142,7 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 
 	for (;;) {
 		unsigned long mask = 0;
+		unsigned long dirmask = 0;
 		int i, last;
 
 		last = -1;
@@ -166,10 +167,13 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 					mask = 0;
 			}
 			mask |= 1ul << i;
+			if (S_ISDIR(entry[i].mode))
+				dirmask |= 1ul << i;
 			last = i;
 		}
 		if (!mask)
 			break;
+		dirmask &= mask;
 
 		/*
 		 * Clear all the unused name-entries.
@@ -179,7 +183,7 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 				continue;
 			entry_clear(entry + i);
 		}
-		ret = info->fn(n, mask, entry, info);
+		ret = info->fn(n, mask, dirmask, entry, info);
 		if (ret < 0)
 			break;
 		if (ret)
diff --git a/tree-walk.h b/tree-walk.h
index c123cfe..42110a4 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -34,7 +34,7 @@ int tree_entry(struct tree_desc *, struct name_entry *);
 void *fill_tree_descriptor(struct tree_desc *desc, const unsigned char *sha1);
 
 struct traverse_info;
-typedef int (*traverse_callback_t)(int n, unsigned long mask, struct name_entry *entry, struct traverse_info *);
+typedef int (*traverse_callback_t)(int n, unsigned long mask, unsigned long dirmask, struct name_entry *entry, struct traverse_info *);
 int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info);
 
 struct traverse_info {
@@ -42,6 +42,7 @@ struct traverse_info {
 	struct name_entry name;
 	int pathlen;
 
+	unsigned long conflicts;
 	traverse_callback_t fn;
 	void *data;
 };
-- 
1.5.4.3.452.g67136


