From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 2/2] fast-import: allow top directory as an argument for some commands
Date: Tue, 16 Aug 2011 16:08:57 +0600
Message-ID: <1313489337-2523-3-git-send-email-divanorama@gmail.com>
References: <1313489337-2523-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 12:08:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtGZE-00071R-O7
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 12:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292Ab1HPKID (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 06:08:03 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62745 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200Ab1HPKIA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 06:08:00 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so3592725bke.19
        for <git@vger.kernel.org>; Tue, 16 Aug 2011 03:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=apYThToicetwfLzQ8MOof+x6pnG5UlPzx6tWhslqM/k=;
        b=I/j+I+WP+qGfCYbtCiGm861OhfLzR1R+NMEILVzbGsSWt1vLesjpFIXaULWUQqCwDa
         upR7QrWG6G3qcDYkvyJsHTTt99uqCP6dhc/ZYubaOAWS5qrfgoiT/K7B7lEiB9xeVwny
         oOEieESYcZ/PogfdgDfZwtoBibdoRqX8g4Fo4=
Received: by 10.204.188.2 with SMTP id cy2mr1216709bkb.172.1313489279430;
        Tue, 16 Aug 2011 03:07:59 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id y8sm1836823bks.54.2011.08.16.03.07.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 16 Aug 2011 03:07:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1313489337-2523-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179427>

fast-import allows to operate on the toplevel directory. This includes
setting the value by sha1/mark, copying/renaming some subdirectory to
a toplevel one.

But it's not possible to 'ls' it or copy/rename it so somewhere, or
delete it with 'D' command.

For ls it's quite reasonable input so just handle it. The special case
is empty directory, for other empty directories we report 'missing' so
stick with this behaviour with toplevel too.

For copy/rename it looks like a normal operation too so handle it too.
But if it's empty, do nothing - there is nothing to copy/rename and the
destination is nonexistent because toplevel is empty.

For 'D ""' we already have deleteall command so probably it's not worth
adding one more way to do the same thing.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c          |   75 +++++++++++++++++++++++++++++++++++++++++------
 t/t9300-fast-import.sh |   58 +++++++++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+), 10 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 3a0aaad..8643e23 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1552,6 +1552,31 @@ static int tree_content_set(
 	return 1;
 }
 
+static int tree_content_clear(
+	struct tree_entry *root,
+	struct tree_entry *backup_leaf)
+{
+	if (backup_leaf)
+		memcpy(backup_leaf, root, sizeof(*backup_leaf));
+	else if (root->tree)
+		release_tree_content_recursive(root->tree);
+	root->tree = NULL;
+	hashclr(root->versions[1].sha1);
+	return 1;
+}
+
+static int is_empty_tree(struct tree_entry *root)
+{
+	int n;
+	if (!root->tree)
+		load_tree(root);
+	for (n = 0; n < root->tree->entry_count; n++) {
+		if (root->tree->entries[n]->versions[1].mode)
+			return 0;
+	}
+	return 1;
+}
+
 static int tree_content_remove(
 	struct tree_entry *root,
 	const char *p,
@@ -1587,11 +1612,9 @@ static int tree_content_remove(
 			if (!e->tree)
 				load_tree(e);
 			if (tree_content_remove(e, slash1 + 1, backup_leaf)) {
-				for (n = 0; n < e->tree->entry_count; n++) {
-					if (e->tree->entries[n]->versions[1].mode) {
-						hashclr(root->versions[1].sha1);
-						return 1;
-					}
+				if (!is_empty_tree(e)) {
+					hashclr(root->versions[1].sha1);
+					return 1;
 				}
 				backup_leaf = NULL;
 				goto del_entry;
@@ -1613,6 +1636,19 @@ del_entry:
 	return 1;
 }
 
+static int tree_content_copy_root(
+	struct tree_entry *root,
+	struct tree_entry *leaf
+)
+{
+	memcpy(leaf, root, sizeof(*leaf));
+	if (root->tree && is_null_sha1(root->versions[1].sha1))
+		leaf->tree = dup_tree_content(root->tree);
+	else
+		leaf->tree = NULL;
+	return 1;
+}
+
 static int tree_content_get(
 	struct tree_entry *root,
 	const char *p,
@@ -2329,10 +2365,17 @@ static void file_change_cr(struct branch *b, int rename)
 	}
 
 	memset(&leaf, 0, sizeof(leaf));
-	if (rename)
-		tree_content_remove(&b->branch_tree, s, &leaf);
-	else
-		tree_content_get(&b->branch_tree, s, &leaf);
+	if (rename) {
+		if (!*s)
+			tree_content_clear(&b->branch_tree, &leaf);
+		else
+			tree_content_remove(&b->branch_tree, s, &leaf);
+	} else {
+		if (!*s)
+			tree_content_copy_root(&b->branch_tree, &leaf);
+		else
+			tree_content_get(&b->branch_tree, s, &leaf);
+	}
 	if (!leaf.versions[1].mode)
 		die("Path %s not in branch", s);
 	if (!*d) {	/* C "path/to/subdir" "" */
@@ -2342,6 +2385,14 @@ static void file_change_cr(struct branch *b, int rename)
 			leaf.tree);
 		return;
 	}
+	/*
+	 * Git does not track empty, non-toplevel directories.
+	 * At this point destination is non-toplevel, so if source is
+	 * toplevel and empty, leave it as is all empty.
+	 */
+	if (!*s && is_empty_tree(&leaf)) {
+		return;
+	}
 	tree_content_set(&b->branch_tree, d,
 		leaf.versions[1].sha1,
 		leaf.versions[1].mode,
@@ -2969,7 +3020,11 @@ static void parse_ls(struct branch *b)
 			die("Garbage after path in: %s", command_buf.buf);
 		p = uq.buf;
 	}
-	tree_content_get(root, p, &leaf);
+	if (!*p) {
+		if (!is_empty_tree(root))
+			tree_content_copy_root(root, &leaf);
+	} else
+		tree_content_get(root, p, &leaf);
 	/*
 	 * A directory in preparation would have a sha1 of zero
 	 * until it is saved.  Save, for simplicity.
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index f256475..0e46cf0 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -978,6 +978,64 @@ test_expect_success PIPE 'N: empty directory reads as missing' '
 '
 
 test_expect_success \
+	'N: ls root directory' \
+	'cat >expect <<-\EOF &&
+	missing
+	040000
+	EOF
+	cat >input <<-EOF &&
+	commit refs/heads/ls-root
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	On empty tree: ls add file ls.
+	COMMIT
+	ls ""
+	M 644 inline file1
+	data 0
+	ls ""
+	EOF
+	git fast-import --quiet <input >tmp &&
+	cat tmp | cut -d " " -f 1 >actual &&
+	test_cmp expect actual'
+
+test_expect_success \
+	'N: move root directory' \
+	'echo "root/a/b" >expect &&
+	cat >input <<-EOF &&
+	commit refs/heads/move-root
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	Add stuff and move it.
+	COMMIT
+	M 644 inline a/b
+	data 0
+	R "" root
+	EOF
+	git fast-import <input &&
+	git ls-tree -r --name-only refs/heads/move-root >actual &&
+	test_cmp expect actual'
+
+test_expect_success \
+	'N: copy root directory' \
+	'cat <<-\EOF >expect &&
+	a/b
+	a/root/a/b
+	EOF
+	cat >input <<-EOF &&
+	commit refs/heads/copy-root
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	Add stuff and move it.
+	COMMIT
+	M 644 inline a/b
+	data 0
+	C "" a/root
+	EOF
+	git fast-import <input &&
+	git ls-tree -r --name-only refs/heads/copy-root >actual &&
+	test_cmp expect actual'
+
+test_expect_success \
 	'N: copy root directory by tree hash' \
 	'cat >expect <<-\EOF &&
 	:100755 000000 f1fb5da718392694d0076d677d6d0e364c79b0bc 0000000000000000000000000000000000000000 D	file3/newf
-- 
1.7.3.4
