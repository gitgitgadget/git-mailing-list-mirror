From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 4/4] fast-import: allow moving the root tree
Date: Sun, 23 Jun 2013 15:58:22 +0100
Message-ID: <08c4486c228eff5754b95708d8f5d56e95620278.1371999369.git.john@keeping.me.uk>
References: <cover.1371999369.git.john@keeping.me.uk>
Cc: Dave Abrahams <dave@boostpro.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 23 16:59:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqllA-0001W3-Al
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 16:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812Ab3FWO7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jun 2013 10:59:16 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:60967 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764Ab3FWO7P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 10:59:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 267786064FD;
	Sun, 23 Jun 2013 15:59:15 +0100 (BST)
X-Quarantine-ID: <1qhbS6an7t0D>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1qhbS6an7t0D; Sun, 23 Jun 2013 15:59:14 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id ABC376064E3;
	Sun, 23 Jun 2013 15:59:14 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id A054A161E461;
	Sun, 23 Jun 2013 15:59:14 +0100 (BST)
X-Quarantine-ID: <rZY8UwTBVLMg>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rZY8UwTBVLMg; Sun, 23 Jun 2013 15:59:14 +0100 (BST)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 3A544161E3F1;
	Sun, 23 Jun 2013 15:59:04 +0100 (BST)
X-Mailer: git-send-email 1.8.3.1.676.gaae6535
In-Reply-To: <cover.1371999369.git.john@keeping.me.uk>
In-Reply-To: <cover.1371999369.git.john@keeping.me.uk>
References: <cover.1371999369.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228745>

Because fast-import.c::tree_content_remove does not check for the empty
path, it is not possible to move the root tree to a subdirectory.
Instead the error "Path  not in branch" is produced (note the double
space where the empty path has been inserted).

Fix this by explicitly checking for the empty path and handling it.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 fast-import.c          | 21 ++++++++++++++-------
 t/t9300-fast-import.sh |  2 +-
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index e2c9d50..21db3fc 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1568,7 +1568,8 @@ static int tree_content_set(
 static int tree_content_remove(
 	struct tree_entry *root,
 	const char *p,
-	struct tree_entry *backup_leaf)
+	struct tree_entry *backup_leaf,
+	int allow_root)
 {
 	struct tree_content *t;
 	const char *slash1;
@@ -1583,6 +1584,12 @@ static int tree_content_remove(
 
 	if (!root->tree)
 		load_tree(root);
+
+	if (!*p && allow_root) {
+		e = root;
+		goto del_entry;
+	}
+
 	t = root->tree;
 	for (i = 0; i < t->entry_count; i++) {
 		e = t->entries[i];
@@ -1599,7 +1606,7 @@ static int tree_content_remove(
 				goto del_entry;
 			if (!e->tree)
 				load_tree(e);
-			if (tree_content_remove(e, slash1 + 1, backup_leaf)) {
+			if (tree_content_remove(e, slash1 + 1, backup_leaf, 0)) {
 				for (n = 0; n < e->tree->entry_count; n++) {
 					if (e->tree->entries[n]->versions[1].mode) {
 						hashclr(root->versions[1].sha1);
@@ -2188,7 +2195,7 @@ static uintmax_t do_change_note_fanout(
 			}
 
 			/* Rename fullpath to realpath */
-			if (!tree_content_remove(orig_root, fullpath, &leaf))
+			if (!tree_content_remove(orig_root, fullpath, &leaf, 0))
 				die("Failed to remove path %s", fullpath);
 			tree_content_set(orig_root, realpath,
 				leaf.versions[1].sha1,
@@ -2323,7 +2330,7 @@ static void file_change_m(struct branch *b)
 
 	/* Git does not track empty, non-toplevel directories. */
 	if (S_ISDIR(mode) && !memcmp(sha1, EMPTY_TREE_SHA1_BIN, 20) && *p) {
-		tree_content_remove(&b->branch_tree, p, NULL);
+		tree_content_remove(&b->branch_tree, p, NULL, 0);
 		return;
 	}
 
@@ -2384,7 +2391,7 @@ static void file_change_d(struct branch *b)
 			die("Garbage after path in: %s", command_buf.buf);
 		p = uq.buf;
 	}
-	tree_content_remove(&b->branch_tree, p, NULL);
+	tree_content_remove(&b->branch_tree, p, NULL, 1);
 }
 
 static void file_change_cr(struct branch *b, int rename)
@@ -2422,7 +2429,7 @@ static void file_change_cr(struct branch *b, int rename)
 
 	memset(&leaf, 0, sizeof(leaf));
 	if (rename)
-		tree_content_remove(&b->branch_tree, s, &leaf);
+		tree_content_remove(&b->branch_tree, s, &leaf, 1);
 	else
 		tree_content_get(&b->branch_tree, s, &leaf, 1);
 	if (!leaf.versions[1].mode)
@@ -2530,7 +2537,7 @@ static void note_change_n(struct branch *b, unsigned char *old_fanout)
 	}
 
 	construct_path_with_fanout(sha1_to_hex(commit_sha1), *old_fanout, path);
-	if (tree_content_remove(&b->branch_tree, path, NULL))
+	if (tree_content_remove(&b->branch_tree, path, NULL, 0))
 		b->num_notes--;
 
 	if (is_null_sha1(sha1))
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 04385a7..31a770d 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1050,7 +1050,7 @@ cat >expect <<EOF
 :100755 100755 e74b7d465e52746be2b4bae983670711e6e66657 e74b7d465e52746be2b4bae983670711e6e66657 R100	newdir/exec.sh	sub/newdir/exec.sh
 :100644 100644 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 R100	newdir/interesting	sub/newdir/interesting
 EOF
-test_expect_failure \
+test_expect_success \
 	'M: rename root to subdirectory' \
 	'git fast-import <input &&
 	 git diff-tree -M -r M4^ M4 >actual &&
-- 
1.8.3.1.676.gaae6535
