From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 3/3] fast-import: prevent producing bad delta
Date: Fri, 12 Aug 2011 16:32:50 +0600
Message-ID: <1313145170-24471-4-git-send-email-divanorama@gmail.com>
References: <1313145170-24471-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 12:32:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qrp2o-0007xL-5K
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 12:32:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508Ab1HLKck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 06:32:40 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38647 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331Ab1HLKch (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 06:32:37 -0400
Received: by bke11 with SMTP id 11so1552708bke.19
        for <git@vger.kernel.org>; Fri, 12 Aug 2011 03:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=o1KmzNCLgDSVlye6Eraq2QofwMeYvg3HAjamHnIrIJg=;
        b=KST6wk1Nedq7333kceaZzw2sQMyxiUTq/SAmm6vd0LS3EWT/liRorQ8dEojGdbehvv
         mfwyncEa6+rvmUXM6mR9+Lqspwq8I6gXIsOYZrjEE8Vi7zMqyKwHu7NNxQdwCyQuIBUb
         m+e1Kzff1/Q8mAEIRvWY2G//trcave5kUbKMg=
Received: by 10.204.9.7 with SMTP id j7mr271068bkj.57.1313145155647;
        Fri, 12 Aug 2011 03:32:35 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id i14sm763298bkd.6.2011.08.12.03.32.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 12 Aug 2011 03:32:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1313145170-24471-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179226>

To produce deltas for tree objects fast-import tracks two versions
of tree's entries - base and current one. Base version stands both
for a delta base of this tree, and for a entry inside a delta base
of a parent tree. So care should be taken to keep it in sync.

tree_content_set cuts away a whole subtree and replaces it with a
new one (or NULL for lazy load of a tree with known sha1). It
keeps a base sha1 for this subtree (needed for parent tree). And
here is the problem, 'subtree' tree root doesn't have the implied
base version entries.

Adjusting the subtree to include them would mean a deep rewrite of
subtree. Invalidating the subtree base version would mean recursive
invalidation of parents' base versions. So just mark this tree as
do-not-delta me. Abuse setuid bit for this purpose.

tree_content_replace is the same as tree_content_set except that is
is used to replace the root, so just clearing base sha1 here (instead
of setting the bit) is fine.

[di: log message]

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c          |   33 +++++++++++++++++++++++++++++----
 t/t9300-fast-import.sh |    2 +-
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 8196d1b..d9049af 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -170,6 +170,11 @@ Format of STDIN stream:
 #define DEPTH_BITS 13
 #define MAX_DEPTH ((1<<DEPTH_BITS)-1)
 
+/*
+ * We abuse the setuid bit on directories to mean "do not delta".
+ */
+#define NO_DELTA S_ISUID
+
 struct object_entry {
 	struct pack_idx_entry idx;
 	struct object_entry *next;
@@ -1434,8 +1439,9 @@ static void mktree(struct tree_content *t, int v, struct strbuf *b)
 		struct tree_entry *e = t->entries[i];
 		if (!e->versions[v].mode)
 			continue;
-		strbuf_addf(b, "%o %s%c", (unsigned int)e->versions[v].mode,
-					e->name->str_dat, '\0');
+		strbuf_addf(b, "%o %s%c",
+			(unsigned int)(e->versions[v].mode & ~NO_DELTA),
+			e->name->str_dat, '\0');
 		strbuf_add(b, e->versions[v].sha1, 20);
 	}
 }
@@ -1445,7 +1451,7 @@ static void store_tree(struct tree_entry *root)
 	struct tree_content *t = root->tree;
 	unsigned int i, j, del;
 	struct last_object lo = { STRBUF_INIT, 0, 0, /* no_swap */ 1 };
-	struct object_entry *le;
+	struct object_entry *le = NULL;
 
 	if (!is_null_sha1(root->versions[1].sha1))
 		return;
@@ -1456,6 +1462,7 @@ static void store_tree(struct tree_entry *root)
 	}
 
 	if (!is_null_sha1(root->versions[0].sha1)
+					&& !(root->versions[0].mode & NO_DELTA)
 					&& S_ISDIR(root->versions[0].mode)) {
 		unsigned char old_tree_sha1[20];
 		mktree(t, 0, &old_tree);
@@ -1499,6 +1506,7 @@ static void tree_content_replace(
 {
 	if (!S_ISDIR(mode))
 		die("Root cannot be a non-directory");
+	hashclr(root->versions[0].sha1);
 	hashcpy(root->versions[1].sha1, sha1);
 	if (root->tree)
 		release_tree_content_recursive(root->tree);
@@ -1543,6 +1551,23 @@ static int tree_content_set(
 				if (e->tree)
 					release_tree_content_recursive(e->tree);
 				e->tree = subtree;
+
+				/*
+				 * We need to leave e->versions[0].sha1 alone
+				 * to avoid modifying the preimage tree used
+				 * when writing out the parent directory.
+				 * But after replacing the subdir with a
+				 * completely different one, it's not a good
+				 * delta base any more, and besides, we've
+				 * thrown away the tree entries needed to
+				 * make a delta against it.
+				 *
+				 * So let's just explicitly disable deltas
+				 * for the subtree.
+				 */
+				if (S_ISDIR(e->versions[0].mode))
+					e->versions[0].mode |= NO_DELTA;
+
 				hashclr(root->versions[1].sha1);
 				return 1;
 			}
@@ -2957,7 +2982,7 @@ static void print_ls(int mode, const unsigned char *sha1, const char *path)
 		/* mode SP type SP object_name TAB path LF */
 		strbuf_reset(&line);
 		strbuf_addf(&line, "%06o %s %s\t",
-				mode, type, sha1_to_hex(sha1));
+				mode & ~NO_DELTA, type, sha1_to_hex(sha1));
 		quote_c_style(path, &line, NULL, 0);
 		strbuf_addch(&line, '\n');
 	}
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index c70e489..50b22f0 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -764,7 +764,7 @@ M 040000 @E g/b
 M 040000 @E g/b/h
 INPUT_END
 
-test_expect_failure \
+test_expect_success \
     'L: verify internal tree delta base' \
 	'git fast-import <input &&
 	A=$(git ls-tree L2 a | tr " " "\t" | cut -f 3) &&
-- 
1.7.3.4
