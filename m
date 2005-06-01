From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] ls-tree: handle trailing slashes in the pathspec properly.
Date: Tue, 31 May 2005 18:46:47 -0700
Message-ID: <7vy89uu9vc.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505310827330.1876@ppc970.osdl.org>
	<7vvf4zvzfw.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505311507010.1876@ppc970.osdl.org>
	<7v8y1vvvaa.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505311636260.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 01 03:45:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdIHf-0005jL-US
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 03:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVFABrY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 21:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVFABrY
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 21:47:24 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:43701 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261225AbVFABqt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2005 21:46:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050601014648.CZAH26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 31 May 2005 21:46:48 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505311636260.1876@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 31 May 2005 16:48:42 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This fixes the problem with ls-tree which failed to show
"drivers/char" directory when the user asked for "drivers/char/"
from the command line.  At the same time, if "drivers/char" were
a non directory, "drivers/char/" would not show it.  This is
consistent with the way diffcore-pathspec has been recently
fixed.

This adds back the diffcore-pathspec test,dropped when my
earlier diffcore-pathspec fix was rejected. 

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** OK, this is the third try (2 1/2nd to be exact).  I love how
*** you always turn out to be right ;-).  BTW could you limit
*** git-apply --stat output to 79 cols not 80?

 ls-tree.c                   |   94 ++++++++++++++++++++++----------------------
 t/t3100-ls-tree-restrict.sh |   39 ++++++++++++++++--
 t/t4010-diff-pathspec.sh    |   65 ++++++++++++++++++++++++++++++
3 files changed, 146 insertions(+), 52 deletions(-)

diff --git a/ls-tree.c b/ls-tree.c
--- a/ls-tree.c
+++ b/ls-tree.c
@@ -54,54 +54,58 @@ static int prepare_children(struct tree_
 	return 0;
 }
 
-static struct tree_entry_list *find_entry_0(struct tree_entry_list *elem,
-					    const char *path,
-					    const char *path_end)
+static struct tree_entry_list *find_entry(const char *path)
 {
-	const char *ep;
+	const char *next, *slash;
 	int len;
+	struct tree_entry_list *elem = &root_entry;
 
-	while (path < path_end) {
-		if (prepare_children(elem))
-			return NULL;
+	/* Find tree element, descending from root, that
+	 * corresponds to the named path, lazily expanding
+	 * the tree if possible.
+	 */
 
-		/* In elem->tree->entries, find the one that has name
-		 * that matches what is between path and ep.
+	while (path) {
+		/* The fact we still have path means that the caller
+		 * wants us to make sure that elem at this point is a
+		 * directory, and possibly descend into it.  Even what
+		 * is left is just trailing slashes, we loop back to
+		 * here, and this call to prepare_children() will
+		 * catch elem not being a tree.  Nice.
 		 */
-		elem = elem->item.tree->entries;
+		if (prepare_children(elem))
+			return NULL;
 
-		ep = strchr(path, '/');
-		if (!ep || path_end <= ep)
-			ep = path_end;
-		len = ep - path;
-
-		while (elem) {
-			if ((strlen(elem->name) == len) &&
-			    !strncmp(elem->name, path, len))
-				break;
-			elem = elem->next;
+		slash = strchr(path, '/');
+		if (!slash) {
+			len = strlen(path);
+			next = 0;
+		}
+		else {
+			next = slash + 1;
+			len = slash - path;
 		}
-		if (path_end <= ep || !elem)
-			return elem;
-		while (*ep == '/' && ep < path_end)
-			ep++;
-		path = ep;
+		if (len) {
+			/* (len == 0) if the original path was "drivers/char/"
+			 * and we have run already two rounds, having elem
+			 * pointing at the drivers/char directory.
+			 */
+			elem = elem->item.tree->entries;
+			while (elem) {
+				if ((strlen(elem->name) == len) &&
+				    !strncmp(elem->name, path, len)) {
+					/* found */
+					break;
+				}
+				elem = elem->next;
+			}
+			if (!elem)
+				return NULL;
+		}
+		path = next;
 	}
-	return NULL;
-}
 
-static struct tree_entry_list *find_entry(const char *path,
-					  const char *path_end)
-{
-	/* Find tree element, descending from root, that
-	 * corresponds to the named path, lazily expanding
-	 * the tree if possible.
-	 */
-	if (path == path_end) {
-		/* Special.  This is the root level */
-		return &root_entry;
-	}
-	return find_entry_0(&root_entry, path, path_end);
+	return elem;
 }
 
 static void show_entry_name(struct tree_entry_list *e)
@@ -180,10 +184,10 @@ static int show_entry(struct tree_entry_
 	return err;
 }
 
-static int list_one(const char *path, const char *path_end)
+static int list_one(const char *path)
 {
 	int err = 0;
-	struct tree_entry_list *e = find_entry(path, path_end);
+	struct tree_entry_list *e = find_entry(path);
 	if (!e) {
 		/* traditionally ls-tree does not complain about
 		 * missing path.  We may change this later to match
@@ -199,12 +203,8 @@ static int list(char **path)
 {
 	int i;
 	int err = 0;
-	for (i = 0; path[i]; i++) {
-		int len = strlen(path[i]);
-		while (0 <= len && path[i][len] == '/')
-			len--;
-		err = err | list_one(path[i], path[i] + len);
-	}
+	for (i = 0; path[i]; i++)
+		err = err | list_one(path[i]);
 	return err;
 }
 
diff --git a/t/t3100-ls-tree-restrict.sh b/t/t3100-ls-tree-restrict.sh
--- a/t/t3100-ls-tree-restrict.sh
+++ b/t/t3100-ls-tree-restrict.sh
@@ -14,7 +14,7 @@ This test runs git-ls-tree with the foll
     path2/baz/b - a file in a directory in a directory
 
 The new path restriction code should do the right thing for path2 and
-path2/baz
+path2/baz.  Also path0/ should snow nothing.
 '
 . ./test-lib.sh
 
@@ -63,7 +63,7 @@ EOF
      test_output'
 
 test_expect_success \
-    'ls-tree filtered' \
+    'ls-tree filtered with path' \
     'git-ls-tree $tree path >current &&
      cat >expected <<\EOF &&
 EOF
@@ -71,7 +71,7 @@ EOF
 
 
 test_expect_success \
-    'ls-tree filtered' \
+    'ls-tree filtered with path1 path0' \
     'git-ls-tree $tree path1 path0 >current &&
      cat >expected <<\EOF &&
 120000 blob X	path1
@@ -80,7 +80,14 @@ EOF
      test_output'
 
 test_expect_success \
-    'ls-tree filtered' \
+    'ls-tree filtered with path0/' \
+    'git-ls-tree $tree path0/ >current &&
+     cat >expected <<\EOF &&
+EOF
+     test_output'
+
+test_expect_success \
+    'ls-tree filtered with path2' \
     'git-ls-tree $tree path2 >current &&
      cat >expected <<\EOF &&
 040000 tree X	path2
@@ -91,7 +98,7 @@ EOF
      test_output'
 
 test_expect_success \
-    'ls-tree filtered' \
+    'ls-tree filtered with path2/baz' \
     'git-ls-tree $tree path2/baz >current &&
      cat >expected <<\EOF &&
 040000 tree X	path2/baz
@@ -99,4 +106,26 @@ test_expect_success \
 EOF
      test_output'
 
+test_expect_success \
+    'ls-tree filtered with path2' \
+    'git-ls-tree $tree path2 >current &&
+     cat >expected <<\EOF &&
+040000 tree X	path2
+040000 tree X	path2/baz
+120000 blob X	path2/bazbo
+100644 blob X	path2/foo
+EOF
+     test_output'
+
+test_expect_success \
+    'ls-tree filtered with path2/' \
+    'git-ls-tree $tree path2/ >current &&
+     cat >expected <<\EOF &&
+040000 tree X	path2
+040000 tree X	path2/baz
+120000 blob X	path2/bazbo
+100644 blob X	path2/foo
+EOF
+     test_output'
+
 test_done
diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
new file mode 100644
--- /dev/null
+++ b/t/t4010-diff-pathspec.sh
@@ -0,0 +1,65 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+test_description='Pathspec restrictions
+
+Prepare:
+        file0
+        path1/file1
+'
+. ./test-lib.sh
+. ../diff-lib.sh ;# test-lib chdir's into trash
+
+test_expect_success \
+    setup \
+    'echo frotz >file0 &&
+     mkdir path1 &&
+     echo rezrov >path1/file1 &&
+     git-update-cache --add file0 path1/file1 &&
+     tree=`git-write-tree` &&
+     echo "$tree" &&
+     echo nitfol >file0 &&
+     echo yomin >path1/file1 &&
+     git-update-cache file0 path1/file1' 
+
+cat >expected <<\EOF
+EOF
+test_expect_success \
+    'limit to path should show nothing' \
+    'git-diff-cache --cached $tree path >current &&
+     compare_diff_raw current expected'
+
+cat >expected <<\EOF
+:100644 100644 766498d93a4b06057a8e49d23f4068f1170ff38f 0a41e115ab61be0328a19b29f18cdcb49338d516 M	path1/file1
+EOF
+test_expect_success \
+    'limit to path1 should show path1/file1' \
+    'git-diff-cache --cached $tree path1 >current &&
+     compare_diff_raw current expected'
+
+cat >expected <<\EOF
+:100644 100644 766498d93a4b06057a8e49d23f4068f1170ff38f 0a41e115ab61be0328a19b29f18cdcb49338d516 M	path1/file1
+EOF
+test_expect_success \
+    'limit to path1/ should show path1/file1' \
+    'git-diff-cache --cached $tree path1/ >current &&
+     compare_diff_raw current expected'
+
+cat >expected <<\EOF
+:100644 100644 766498d93a4b06057a8e49d23f4068f1170ff38f 0a41e115ab61be0328a19b29f18cdcb49338d516 M	file0
+EOF
+test_expect_success \
+    'limit to file0 should show file0' \
+    'git-diff-cache --cached $tree file0 >current &&
+     compare_diff_raw current expected'
+
+cat >expected <<\EOF
+EOF
+test_expect_success \
+    'limit to file0/ should emit nothing.' \
+    'git-diff-cache --cached $tree file0/ >current &&
+     compare_diff_raw current expected'
+
+test_done
------------

