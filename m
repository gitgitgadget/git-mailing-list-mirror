From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v2 2/2] fast-import: prevent producing bad delta
Date: Mon, 15 Aug 2011 00:32:24 +0600
Message-ID: <1313346744-30340-3-git-send-email-divanorama@gmail.com>
References: <1313145170-24471-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 14 20:32:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsfTh-0005BU-8o
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 20:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754640Ab1HNSbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Aug 2011 14:31:53 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56452 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754629Ab1HNSbu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2011 14:31:50 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so2601545bke.19
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 11:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=NeFHg4UXfCmcIMMp8G+rilQ91zeZ54SXvseLK3VSs9U=;
        b=YTwyUThhqOcIiOlX7Ck8b0IsG4Ts2reD5Q5KSwzpje3aFu29NPW/j/4Ah7WjIVfKWj
         +6h50ghf3QEMDYGxP5yZOTDgIDPPH8Lv868GEdwXk71YzC9fSzK8qeBqLMwHlMH1peUf
         jKtr6O8uWA7STu5y6UAvIwnLqZihaoUlU/Yv4=
Received: by 10.204.225.65 with SMTP id ir1mr112970bkb.376.1313346709589;
        Sun, 14 Aug 2011 11:31:49 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id n11sm1334281bkd.47.2011.08.14.11.31.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Aug 2011 11:31:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1313145170-24471-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179341>

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
 fast-import.c          |   35 ++++++++++++++++++++++++++++++-----
 t/t9300-fast-import.sh |    2 +-
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 7cc2262..0be7629 100644
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
@@ -1416,8 +1421,9 @@ static void mktree(struct tree_content *t, int v, struct strbuf *b)
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
@@ -1427,7 +1433,7 @@ static void store_tree(struct tree_entry *root)
 	struct tree_content *t = root->tree;
 	unsigned int i, j, del;
 	struct last_object lo = { STRBUF_INIT, 0, 0, /* no_swap */ 1 };
-	struct object_entry *le;
+	struct object_entry *le = NULL;
 
 	if (!is_null_sha1(root->versions[1].sha1))
 		return;
@@ -1437,7 +1443,8 @@ static void store_tree(struct tree_entry *root)
 			store_tree(t->entries[i]);
 	}
 
-	le = find_object(root->versions[0].sha1);
+	if (!(root->versions[0].mode & NO_DELTA))
+		le = find_object(root->versions[0].sha1);
 	if (S_ISDIR(root->versions[0].mode) && le && le->pack_id == pack_id) {
 		mktree(t, 0, &old_tree);
 		lo.data = old_tree;
@@ -1471,6 +1478,7 @@ static void tree_content_replace(
 {
 	if (!S_ISDIR(mode))
 		die("Root cannot be a non-directory");
+	hashclr(root->versions[0].sha1);
 	hashcpy(root->versions[1].sha1, sha1);
 	if (root->tree)
 		release_tree_content_recursive(root->tree);
@@ -1515,6 +1523,23 @@ static int tree_content_set(
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
@@ -2929,7 +2954,7 @@ static void print_ls(int mode, const unsigned char *sha1, const char *path)
 		/* mode SP type SP object_name TAB path LF */
 		strbuf_reset(&line);
 		strbuf_addf(&line, "%06o %s %s\t",
-				mode, type, sha1_to_hex(sha1));
+				mode & ~NO_DELTA, type, sha1_to_hex(sha1));
 		quote_c_style(path, &line, NULL, 0);
 		strbuf_addch(&line, '\n');
 	}
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index e2b94b5..106e3f3 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -765,7 +765,7 @@ g/b/f
 g/b/h
 EOF
 
-test_expect_failure \
+test_expect_success \
     'L: nested tree copy does not corrupt deltas' \
 	'git fast-import <input &&
 	git ls-tree L2 g/b/ >tmp &&
-- 
1.7.3.4
