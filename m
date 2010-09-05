From: Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 04/15] When unpacking in a sparse repository, avoid traversing missing trees/blobs
Date: Sat,  4 Sep 2010 18:13:56 -0600
Message-ID: <1283645647-1891-5-git-send-email-newren@gmail.com>
References: <1283645647-1891-1-git-send-email-newren@gmail.com>
Cc: pclouds@gmail.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 05 02:13:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os2rd-0008IQ-Pw
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 02:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754539Ab0IEANI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 20:13:08 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57812 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754490Ab0IEANA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 20:13:00 -0400
Received: by mail-pz0-f46.google.com with SMTP id 9so971230pzk.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 17:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=jGsI9tf4zINc+RBXMDQrEWvEa6XWmVtg0p0ND5R4WyE=;
        b=eSlnLV0oxBZGYs2qOjzM8Wv296ts0ZyHgGLN0O2RGR0wkSYMd/jvZFsBK69T0So1kV
         DusNZ4JYScw+ggcD6g0jz3vyIE5YoUpFIoUHpCcnbbFgj1XZNpYRHTWhOms3FN/zRKWg
         j/zTa03/u1OgJ/IugV+9Fn67yVywtbykQ/VCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=eu49gHLmy7VDXLVPzlnYfvNMKkSOO9GVdBtW5Th/heA4ozvhY25ntLkp/l9ahK2Hcz
         2Z4+vbs1lTAg4hOuLHk17Th8HqZ3KqnofxTE6w4TjMYi34MmUpjGZEedbeAlf3d3phCe
         XVH4Lhf+NV/6OxJEgOsvXNlC5DoWqtrjQwnF0=
Received: by 10.114.53.20 with SMTP id b20mr1454516waa.56.1283645580339;
        Sat, 04 Sep 2010 17:13:00 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 33sm7341833wad.18.2010.09.04.17.12.58
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 17:12:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.140.gd06af
In-Reply-To: <1283645647-1891-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155390>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diff.h                              |    1 -
 t/t5720-sparse-repository-basics.sh |   10 +++---
 tree-diff.c                         |    2 +-
 tree-walk.c                         |   48 ++++++++++++++++++++++++++++++----
 tree-walk.h                         |    3 ++
 5 files changed, 51 insertions(+), 13 deletions(-)

diff --git a/diff.h b/diff.h
index 986a015..e17383c 100644
--- a/diff.h
+++ b/diff.h
@@ -171,7 +171,6 @@ extern int diff_tree_sha1(const unsigned char *old, const unsigned char *new,
 			  const char *base, struct diff_options *opt);
 extern int diff_root_tree_sha1(const unsigned char *new, const char *base,
                                struct diff_options *opt);
-extern int tree_entry_interesting(struct tree_desc *desc, const char *base, int baselen, struct diff_options *opt);
 
 struct combine_diff_path {
 	struct combine_diff_path *next;
diff --git a/t/t5720-sparse-repository-basics.sh b/t/t5720-sparse-repository-basics.sh
index b8e9a3a..b946c23 100755
--- a/t/t5720-sparse-repository-basics.sh
+++ b/t/t5720-sparse-repository-basics.sh
@@ -41,7 +41,7 @@ test_expect_success 'setup' '
 	)
 '
 
-test_expect_failure 'make sparse repository' '
+test_expect_success 'make sparse repository' '
 	git clone -q "file://$(pwd)/src" dst &&
 	(
 		cd dst &&
@@ -55,7 +55,7 @@ test_expect_failure 'make sparse repository' '
 cd dst 2>/dev/null || test_done
 srcgit="--git-dir=../src/.git"
 
-test_expect_failure 'plumbing: ls-files works' '
+test_expect_success 'plumbing: ls-files works' '
 	git ls-files > output &&
 	test "sub/b/file" = "$(cat output)"
 '
@@ -98,19 +98,19 @@ test_expect_failure 'basic: diff works' '
 	git diff master~3
 '
 
-test_expect_failure 'basic: checkout works' '
+test_expect_success 'basic: checkout works' '
 	git checkout master~2 &&
 	git checkout master
 '
 
-test_expect_failure 'basic: status works with modified stuff' '
+test_expect_success 'basic: status works with modified stuff' '
 	git status &&
 	echo more content >> sub/b/file &&
 	echo newfile content >> sub/b/whatever &&
 	git status
 '
 
-test_expect_failure 'basic: add works' '
+test_expect_success 'basic: add works' '
 	git add sub/b/file &&
 	git add sub/b/whatever
 '
diff --git a/tree-diff.c b/tree-diff.c
index 951b53b..95e956e 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -261,7 +261,7 @@ static void show_entry(struct diff_options *opt, const char *prefix, struct tree
 	}
 }
 
-static void skip_uninteresting(struct tree_desc *t, const char *base, int baselen, struct diff_options *opt, int *all_interesting)
+void skip_uninteresting(struct tree_desc *t, const char *base, int baselen, struct diff_options *opt, int *all_interesting)
 {
 	while (t->size) {
 		int show = tree_entry_interesting(t, base, baselen, opt);
diff --git a/tree-walk.c b/tree-walk.c
index a9bbf4e..a584dd8 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -66,8 +66,19 @@ static void entry_clear(struct name_entry *a)
 	memset(a, 0, sizeof(*a));
 }
 
-static void entry_extract(struct tree_desc *t, struct name_entry *a)
+struct tree_sparse_info {
+	int all_interesting;
+	const char *base;
+	int baselen;
+	struct diff_options *diffopt; /* really is const too */
+};
+
+static void entry_extract(struct tree_desc *t, struct name_entry *a,
+			  struct tree_sparse_info *i)
 {
+	if (!i->all_interesting)
+		skip_uninteresting(t, i->base, i->baselen,
+				   i->diffopt, &i->all_interesting);
 	*a = t->entry;
 }
 
@@ -219,7 +230,8 @@ static int check_entry_match(const char *a, int a_len, const char *b, int b_len)
 static void extended_entry_extract(struct tree_desc_x *t,
 				   struct name_entry *a,
 				   const char *first,
-				   int first_len)
+				   int first_len,
+				   struct tree_sparse_info *i)
 {
 	const char *path;
 	int len;
@@ -235,7 +247,7 @@ static void extended_entry_extract(struct tree_desc_x *t,
 			entry_clear(a);
 			break; /* not found */
 		}
-		entry_extract(&t->d, a);
+		entry_extract(&t->d, a, i);
 		for (skip = t->skip; skip; skip = skip->prev)
 			if (a->path == skip->ptr)
 				break; /* found */
@@ -268,7 +280,7 @@ static void extended_entry_extract(struct tree_desc_x *t,
 	 */
 	probe = t->d;
 	while (probe.size) {
-		entry_extract(&probe, a);
+		entry_extract(&probe, a, i);
 		path = a->path;
 		len = tree_entry_len(a->path, a->sha1);
 		switch (check_entry_match(first, first_len, path, len)) {
@@ -315,6 +327,28 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 	struct name_entry *entry = xmalloc(n*sizeof(*entry));
 	int i;
 	struct tree_desc_x *tx = xcalloc(n, sizeof(*tx));
+	char prefix[PATH_MAX];
+	struct tree_sparse_info sparse_info;
+	if (!git_sparse_pathspecs)
+		sparse_info.all_interesting = 1;
+	else {
+		if (info->prev)
+			make_traverse_path(prefix, info->prev, &info->name);
+		else
+			strcpy(prefix, info->name.path);
+		sparse_info.baselen = strlen(prefix);
+
+		/* prefix must be slash terminated if non-empty */
+		if (sparse_info.baselen) {
+			sparse_info.baselen += 1;
+			prefix[sparse_info.baselen-1] = '/';
+			prefix[sparse_info.baselen] = '\0';
+		}
+
+		sparse_info.all_interesting = 0;
+		sparse_info.base = prefix;
+		sparse_info.diffopt = &git_sparse_diffopts;
+	}
 
 	for (i = 0; i < n; i++)
 		tx[i].d = t[i];
@@ -328,7 +362,7 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 
 		for (i = 0; i < n; i++) {
 			e = entry + i;
-			extended_entry_extract(tx + i, e, NULL, 0);
+			extended_entry_extract(tx + i, e, NULL, 0, &sparse_info);
 		}
 
 		/*
@@ -356,7 +390,9 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 		if (first) {
 			for (i = 0; i < n; i++) {
 				e = entry + i;
-				extended_entry_extract(tx + i, e, first, first_len);
+				extended_entry_extract(tx + i, e,
+						       first, first_len,
+						       &sparse_info);
 				/* Cull the ones that are not the earliest */
 				if (!e->path)
 					continue;
diff --git a/tree-walk.h b/tree-walk.h
index 7e3e0b5..eae1997 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -60,4 +60,7 @@ static inline int traverse_path_len(const struct traverse_info *info, const stru
 	return info->pathlen + tree_entry_len(n->path, n->sha1);
 }
 
+void skip_uninteresting(struct tree_desc *t, const char *base, int baselen, struct diff_options *opt, int *all_interesting);
+int tree_entry_interesting(struct tree_desc *desc, const char *base, int baselen, struct diff_options *opt);
+
 #endif
-- 
1.7.2.2.140.gd06af
