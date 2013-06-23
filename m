From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 3/4] fast-import: allow ls or filecopy of the root tree
Date: Sun, 23 Jun 2013 15:58:21 +0100
Message-ID: <acdb5e89bd99ad1374e857624181d8323f72cef8.1371999369.git.john@keeping.me.uk>
References: <cover.1371999369.git.john@keeping.me.uk>
Cc: Dave Abrahams <dave@boostpro.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 23 16:59:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uqll2-0001L7-LZ
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 16:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790Ab3FWO7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jun 2013 10:59:08 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:53318 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764Ab3FWO7H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 10:59:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id CB87DCDA5CF;
	Sun, 23 Jun 2013 15:59:06 +0100 (BST)
X-Quarantine-ID: <yTXucPs4ZTAr>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yTXucPs4ZTAr; Sun, 23 Jun 2013 15:59:06 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id B8824CDA5BB;
	Sun, 23 Jun 2013 15:59:05 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 97B7E161E3F1;
	Sun, 23 Jun 2013 15:59:05 +0100 (BST)
X-Quarantine-ID: <H3Azg2Lhm0-9>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H3Azg2Lhm0-9; Sun, 23 Jun 2013 15:59:04 +0100 (BST)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 75414161E424;
	Sun, 23 Jun 2013 15:58:54 +0100 (BST)
X-Mailer: git-send-email 1.8.3.1.676.gaae6535
In-Reply-To: <cover.1371999369.git.john@keeping.me.uk>
In-Reply-To: <cover.1371999369.git.john@keeping.me.uk>
References: <cover.1371999369.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228744>

Commit 178e1de (fast-import: don't allow 'ls' of path with empty
components, 2012-03-09) restricted paths which:

    . contain an empty directory component (e.g. foo//bar is invalid),
    . end with a directory separator (e.g. foo/ is invalid),
    . start with a directory separator (e.g. /foo is invalid).

However, the implementation also caught the empty path, which should
represent the root tree.  Relax this restriction so that the empty path
is explicitly allowed and refers to the root tree.

Reported-by: Dave Abrahams <dave@boostpro.com>
Signed-off-by: John Keeping <john@keeping.me.uk>
---
 fast-import.c          | 35 ++++++++++++++++++++++-------------
 t/t9300-fast-import.sh |  4 ++--
 2 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index bdbadea..e2c9d50 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1629,7 +1629,8 @@ del_entry:
 static int tree_content_get(
 	struct tree_entry *root,
 	const char *p,
-	struct tree_entry *leaf)
+	struct tree_entry *leaf,
+	int allow_root)
 {
 	struct tree_content *t;
 	const char *slash1;
@@ -1641,31 +1642,39 @@ static int tree_content_get(
 		n = slash1 - p;
 	else
 		n = strlen(p);
-	if (!n)
+	if (!n && !allow_root)
 		die("Empty path component found in input");
 
 	if (!root->tree)
 		load_tree(root);
+
+	if (!n) {
+		e = root;
+		goto found_entry;
+	}
+
 	t = root->tree;
 	for (i = 0; i < t->entry_count; i++) {
 		e = t->entries[i];
 		if (e->name->str_len == n && !strncmp_icase(p, e->name->str_dat, n)) {
-			if (!slash1) {
-				memcpy(leaf, e, sizeof(*leaf));
-				if (e->tree && is_null_sha1(e->versions[1].sha1))
-					leaf->tree = dup_tree_content(e->tree);
-				else
-					leaf->tree = NULL;
-				return 1;
-			}
+			if (!slash1)
+				goto found_entry;
 			if (!S_ISDIR(e->versions[1].mode))
 				return 0;
 			if (!e->tree)
 				load_tree(e);
-			return tree_content_get(e, slash1 + 1, leaf);
+			return tree_content_get(e, slash1 + 1, leaf, 0);
 		}
 	}
 	return 0;
+
+found_entry:
+	memcpy(leaf, e, sizeof(*leaf));
+	if (e->tree && is_null_sha1(e->versions[1].sha1))
+		leaf->tree = dup_tree_content(e->tree);
+	else
+		leaf->tree = NULL;
+	return 1;
 }
 
 static int update_branch(struct branch *b)
@@ -2415,7 +2424,7 @@ static void file_change_cr(struct branch *b, int rename)
 	if (rename)
 		tree_content_remove(&b->branch_tree, s, &leaf);
 	else
-		tree_content_get(&b->branch_tree, s, &leaf);
+		tree_content_get(&b->branch_tree, s, &leaf, 1);
 	if (!leaf.versions[1].mode)
 		die("Path %s not in branch", s);
 	if (!*d) {	/* C "path/to/subdir" "" */
@@ -3067,7 +3076,7 @@ static void parse_ls(struct branch *b)
 			die("Garbage after path in: %s", command_buf.buf);
 		p = uq.buf;
 	}
-	tree_content_get(root, p, &leaf);
+	tree_content_get(root, p, &leaf, 1);
 	/*
 	 * A directory in preparation would have a sha1 of zero
 	 * until it is saved.  Save, for simplicity.
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index f4b9355..04385a7 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1253,7 +1253,7 @@ test_expect_success \
 	 git diff-tree -C --find-copies-harder -r N4 N6 >actual &&
 	 compare_diff_raw expect actual'
 
-test_expect_failure \
+test_expect_success \
 	'N: copy root by path' \
 	'cat >expect <<-\EOF &&
 	:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	oldroot/file2/newf
@@ -2988,7 +2988,7 @@ test_expect_success 'S: ls with garbage after sha1 must fail' '
 ###
 # Setup is carried over from series S.
 
-test_expect_failure 'T: ls root tree' '
+test_expect_success 'T: ls root tree' '
 	sed -e "s/Z\$//" >expect <<-EOF &&
 	040000 tree $(git rev-parse S^{tree})	Z
 	EOF
-- 
1.8.3.1.676.gaae6535
