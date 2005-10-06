From: robfitz@273k.net
Subject: [PATCH] Fix wrong filename listing bug in git-ls-tree.
Date: Thu, 6 Oct 2005 21:52:13 +0000
Message-ID: <112863553379-git-send-email-robfitz@273k.net>
Reply-To: robfitz@273k.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Robert Fitzsimons <robfitz@273k.net>
X-From: git-owner@vger.kernel.org Thu Oct 06 23:44:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENdWg-0000sZ-PL
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 23:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbVJFVnV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Oct 2005 17:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbVJFVnU
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Oct 2005 17:43:20 -0400
Received: from igraine.blacknight.ie ([217.114.173.147]:16304 "EHLO
	igraine.blacknight.ie") by vger.kernel.org with ESMTP
	id S1750871AbVJFVnU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2005 17:43:20 -0400
Received: from [212.17.39.138] (helo=earth)
	by igraine.blacknight.ie with smtp (Exim 4.42)
	id 1ENdW7-0006mD-F3; Thu, 06 Oct 2005 22:43:07 +0100
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (score=0.178, required 7.5, NO_REAL_NAME 0.18)
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9785>

This patch fixes a bug in git-ls-tee in which the wrong filenames are
listed if the exact same file and directory contents are present in
another location in the tree.

Added a new series of test cases for directory and filename handling.

Signed-off-by: Robert Fitzsimons <robfitz@273k.net>

---

 ls-tree.c                  |   55 ++++++++-------
 t/t3101-ls-tree-dirname.sh |  160 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 189 insertions(+), 26 deletions(-)
 create mode 100644 t/t3101-ls-tree-dirname.sh

applies-to: 9eec9ff9326032bca405a12a265918725edf4ac7
223dbed3ac931657f88466fec22e30e10197403e
diff --git a/ls-tree.c b/ls-tree.c
--- a/ls-tree.c
+++ b/ls-tree.c
@@ -54,11 +54,13 @@ static int prepare_children(struct tree_
 	return 0;
 }
 
-static struct tree_entry_list *find_entry(const char *path)
+static struct tree_entry_list *find_entry(const char *path, char *pathbuf)
 {
 	const char *next, *slash;
 	int len;
-	struct tree_entry_list *elem = &root_entry;
+	struct tree_entry_list *elem = &root_entry, *oldelem = NULL;
+
+	*(pathbuf) = '\0';
 
 	/* Find tree element, descending from root, that
 	 * corresponds to the named path, lazily expanding
@@ -86,6 +88,10 @@ static struct tree_entry_list *find_entr
 			len = slash - path;
 		}
 		if (len) {
+			if (oldelem) {
+				pathbuf += sprintf(pathbuf, "%s/", oldelem->name);
+			}
+
 			/* (len == 0) if the original path was "drivers/char/"
 			 * and we have run already two rounds, having elem
 			 * pointing at the drivers/char directory.
@@ -101,6 +107,8 @@ static struct tree_entry_list *find_entr
 			}
 			if (!elem)
 				return NULL;
+
+			oldelem = elem;
 		}
 		path = next;
 	}
@@ -108,19 +116,6 @@ static struct tree_entry_list *find_entr
 	return elem;
 }
 
-static void show_entry_name(struct tree_entry_list *e)
-{
-	/* This is yucky.  The root level is there for
-	 * our convenience but we really want to do a
-	 * forest.
-	 */
-	if (e->parent && e->parent != &root_entry) {
-		show_entry_name(e->parent);
-		putchar('/');
-	}
-	printf("%s", e->name);
-}
-
 static const char *entry_type(struct tree_entry_list *e)
 {
 	return (e->directory ? "tree" : "blob");
@@ -134,28 +129,35 @@ static const char *entry_hex(struct tree
 }
 
 /* forward declaration for mutually recursive routines */
-static int show_entry(struct tree_entry_list *, int);
+static int show_entry(struct tree_entry_list *, int, char *pathbuf);
 
-static int show_children(struct tree_entry_list *e, int level)
+static int show_children(struct tree_entry_list *e, int level, char *pathbuf)
 {
+	int oldlen = strlen(pathbuf);
+
+	if (e != &root_entry)
+		sprintf(pathbuf + oldlen, "%s/", e->name);
+
 	if (prepare_children(e))
 		die("internal error: ls-tree show_children called with non tree");
 	e = e->item.tree->entries;
 	while (e) {
-		show_entry(e, level);
+		show_entry(e, level, pathbuf);
 		e = e->next;
 	}
+
+	pathbuf[oldlen] = '\0';
+
 	return 0;
 }
 
-static int show_entry(struct tree_entry_list *e, int level)
+static int show_entry(struct tree_entry_list *e, int level, char *pathbuf)
 {
 	int err = 0; 
 
 	if (e != &root_entry) {
-		printf("%06o %s %s	", e->mode, entry_type(e),
-		       entry_hex(e));
-		show_entry_name(e);
+		printf("%06o %s %s	%s%s", e->mode, entry_type(e),
+		       entry_hex(e), pathbuf, e->name);
 		putchar(line_termination);
 	}
 
@@ -176,10 +178,10 @@ static int show_entry(struct tree_entry_
 		 */
 		if (level == 0 && !(ls_options & LS_TREE_ONLY))
 			/* case (1)-a and (1)-b */
-			err = err | show_children(e, level+1);
+			err = err | show_children(e, level+1, pathbuf);
 		else if (level && ls_options & LS_RECURSIVE)
 			/* case (2)-b */
-			err = err | show_children(e, level+1);
+			err = err | show_children(e, level+1, pathbuf);
 	}
 	return err;
 }
@@ -187,7 +189,8 @@ static int show_entry(struct tree_entry_
 static int list_one(const char *path)
 {
 	int err = 0;
-	struct tree_entry_list *e = find_entry(path);
+	char pathbuf[MAXPATHLEN + 1];
+	struct tree_entry_list *e = find_entry(path, pathbuf);
 	if (!e) {
 		/* traditionally ls-tree does not complain about
 		 * missing path.  We may change this later to match
@@ -195,7 +198,7 @@ static int list_one(const char *path)
 		 */
 		return err;
 	}
-	err = err | show_entry(e, 0);
+	err = err | show_entry(e, 0, pathbuf);
 	return err;
 }
 
diff --git a/t/t3101-ls-tree-dirname.sh b/t/t3101-ls-tree-dirname.sh
new file mode 100644
--- /dev/null
+++ b/t/t3101-ls-tree-dirname.sh
@@ -0,0 +1,160 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+# Copyright (c) 2005 Robert Fitzsimons
+#
+
+test_description='git-ls-tree directory and filenames handling.
+
+This test runs git-ls-tree with the following in a tree.
+
+    1.txt              - a file
+    2.txt              - a file
+    path0/a/b/c/1.txt  - a file in a directory
+    path1/b/c/1.txt    - a file in a directory
+    path2/1.txt        - a file in a directory
+    path3/1.txt        - a file in a directory
+    path3/2.txt        - a file in a directory
+
+Test the handling of mulitple directories which have matching file
+entries.  Also test odd filename and missing entries handling.
+'
+. ./test-lib.sh
+
+test_expect_success \
+    'setup' \
+    'echo 111 >1.txt &&
+     echo 222 >2.txt &&
+     mkdir path0 path0/a path0/a/b path0/a/b/c &&
+     echo 111 >path0/a/b/c/1.txt &&
+     mkdir path1 path1/b path1/b/c &&
+     echo 111 >path1/b/c/1.txt &&
+     mkdir path2 &&
+     echo 111 >path2/1.txt &&
+     mkdir path3 &&
+     echo 111 >path3/1.txt &&
+     echo 222 >path3/2.txt &&
+     find *.txt path* \( -type f -o -type l \) -print |
+     xargs git-update-index --add &&
+     tree=`git-write-tree` &&
+     echo $tree'
+
+_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
+_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
+test_output () {
+    sed -e "s/ $_x40	/ X	/" <current >check
+    diff -u expected check
+}
+
+test_expect_success \
+    'ls-tree plain' \
+    'git-ls-tree $tree >current &&
+     cat >expected <<\EOF &&
+100644 blob X	1.txt
+100644 blob X	2.txt
+040000 tree X	path0
+040000 tree X	path1
+040000 tree X	path2
+040000 tree X	path3
+EOF
+     test_output'
+
+test_expect_success \
+    'ls-tree recursive' \
+    'git-ls-tree -r $tree >current &&
+     cat >expected <<\EOF &&
+100644 blob X	1.txt
+100644 blob X	2.txt
+040000 tree X	path0
+040000 tree X	path0/a
+040000 tree X	path0/a/b
+040000 tree X	path0/a/b/c
+100644 blob X	path0/a/b/c/1.txt
+040000 tree X	path1
+040000 tree X	path1/b
+040000 tree X	path1/b/c
+100644 blob X	path1/b/c/1.txt
+040000 tree X	path2
+100644 blob X	path2/1.txt
+040000 tree X	path3
+100644 blob X	path3/1.txt
+100644 blob X	path3/2.txt
+EOF
+     test_output'
+
+test_expect_success \
+    'ls-tree filter 1.txt' \
+    'git-ls-tree $tree 1.txt >current &&
+     cat >expected <<\EOF &&
+100644 blob X	1.txt
+EOF
+     test_output'
+
+test_expect_success \
+    'ls-tree filter path1/b/c/1.txt' \
+    'git-ls-tree $tree path1/b/c/1.txt >current &&
+     cat >expected <<\EOF &&
+100644 blob X	path1/b/c/1.txt
+EOF
+     test_output'
+
+test_expect_success \
+    'ls-tree filter all 1.txt files' \
+    'git-ls-tree $tree 1.txt path0/a/b/c/1.txt path1/b/c/1.txt path2/1.txt path3/1.txt >current &&
+     cat >expected <<\EOF &&
+100644 blob X	1.txt
+100644 blob X	path0/a/b/c/1.txt
+100644 blob X	path1/b/c/1.txt
+100644 blob X	path2/1.txt
+100644 blob X	path3/1.txt
+EOF
+     test_output'
+
+test_expect_success \
+    'ls-tree filter directories' \
+    'git-ls-tree $tree path3 path2 path0/a/b/c path1/b/c path0/a >current &&
+     cat >expected <<\EOF &&
+040000 tree X	path3
+100644 blob X	path3/1.txt
+100644 blob X	path3/2.txt
+040000 tree X	path2
+100644 blob X	path2/1.txt
+040000 tree X	path0/a/b/c
+100644 blob X	path0/a/b/c/1.txt
+040000 tree X	path1/b/c
+100644 blob X	path1/b/c/1.txt
+040000 tree X	path0/a
+040000 tree X	path0/a/b
+EOF
+     test_output'
+
+test_expect_success \
+    'ls-tree filter odd names' \
+    'git-ls-tree $tree 1.txt /1.txt //1.txt path3/1.txt /path3/1.txt //path3//1.txt path3 /path3/ path3// >current &&
+     cat >expected <<\EOF &&
+100644 blob X	1.txt
+100644 blob X	1.txt
+100644 blob X	1.txt
+100644 blob X	path3/1.txt
+100644 blob X	path3/1.txt
+100644 blob X	path3/1.txt
+040000 tree X	path3
+100644 blob X	path3/1.txt
+100644 blob X	path3/2.txt
+040000 tree X	path3
+100644 blob X	path3/1.txt
+100644 blob X	path3/2.txt
+040000 tree X	path3
+100644 blob X	path3/1.txt
+100644 blob X	path3/2.txt
+EOF
+     test_output'
+
+test_expect_success \
+    'ls-tree filter missing files and extra slashes' \
+    'git-ls-tree $tree 1.txt/ abc.txt path3//23.txt path3/2.txt/// >current &&
+     cat >expected <<\EOF &&
+EOF
+     test_output'
+
+test_done
---
0.99.8.GIT
