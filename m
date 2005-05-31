From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] diff: Fix trailing slash handling.
Date: Tue, 31 May 2005 14:48:02 -0700
Message-ID: <7v64wzxe25.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505310827330.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 31 23:55:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdEf7-0000uQ-Rd
	for gcvg-git@gmane.org; Tue, 31 May 2005 23:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVEaVyt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 17:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVEaVw7
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 17:52:59 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:28858 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261619AbVEaVsG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2005 17:48:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050531214804.WIXR7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 31 May 2005 17:48:04 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505310827330.1876@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 31 May 2005 08:32:15 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

When limiting the world to "drivers/char/", we should not
consider "drivers/char" which is not a directory.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 t/t4010-diff-pathspec.sh |   65 ++++++++++++++++++++++++++++++++++++++++++++++
 diffcore-pathspec.c      |   60 +++++++++++++++++++++++++++++++++++++------
 2 files changed, 117 insertions(+), 8 deletions(-)

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
diff --git a/diffcore-pathspec.c b/diffcore-pathspec.c
--- a/diffcore-pathspec.c
+++ b/diffcore-pathspec.c
@@ -8,9 +8,13 @@
 struct path_spec {
 	const char *spec;
 	int len;
+	int reject_non_tree;
 };
 
-static int matches_pathspec(const char *name, struct path_spec *s, int cnt)
+static int matches_pathspec(const char *name,
+			    int obviously_non_tree,
+			    struct path_spec *s,
+			    int cnt)
 {
 	int i;
 	int namelen;
@@ -21,10 +25,25 @@ static int matches_pathspec(const char *
 	namelen = strlen(name);
 	for (i = 0; i < cnt; i++) {
 		int len = s[i].len;
-		if (! strncmp(s[i].spec, name, len) &&
-		    len <= namelen &&
-		    (name[len] == 0 || name[len] == '/'))
-			return 1;
+		if (!strncmp(s[i].spec, name, len)) {
+			/* Leading part matches. */
+			if (len == namelen) {
+				/* Exact match: spec "drivers/char/"
+				 * should not match against path
+				 * "drivers/char".
+				 */
+				if (s[i].reject_non_tree && obviously_non_tree)
+					continue;
+				return 1;
+			}
+			else if ((len < namelen) && name[len] == '/') {
+				/* Spec is leading path */
+				return 1;
+			}
+			/* otherwise, it is a false match of spec "abc"
+			 * against path "abcdefg", so we continue.
+			 */
+		}
 	}
 	return 0;
 }
@@ -47,14 +66,39 @@ void diffcore_pathspec(const char **path
 		int l;
 		spec[i].spec = pathspec[i];
 		l = strlen(pathspec[i]);
-		while (l > 0 && pathspec[i][l-1] == '/')
-			l--;
+		if (l > 0 && pathspec[i][l-1] == '/') {
+			spec[i].reject_non_tree = 1;
+			while (l > 0 && pathspec[i][l-1] == '/')
+				l--;
+		}
 		spec[i].len = l;
 	}
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
-		if (matches_pathspec(p->two->path, spec, speccnt))
+		int obviously_non_tree;
+#ifndef DIFF_TREE_CALLS_PATHSPEC
+		/*
+		 * NOTE: This relies on the current behaviour of
+		 * diff-tree which does not use diffcore-pathspec
+		 * and we would not ever see "tree" objects
+		 * in our input.
+		 */
+		obviously_non_tree = 1;
+#else
+		if (DIFF_FILE_VALID(p->two))
+			obviously_non_tree = !S_ISDIR(p->two->mode);
+		else if (DIFF_FILE_VALID(p->one))
+			/* path is being deleted.  is it a tree? */
+			obviously_non_tree = !S_ISDIR(p->one->mode);
+		else
+			/* path is unmerged, which comes from cache
+			 * so it cannot be a tree
+			 */
+			obviously_non_tree = 1;
+#endif
+		if (matches_pathspec(p->two->path, obviously_non_tree,
+				     spec, speccnt))
 			diff_q(&outq, p);
 		else
 			diff_free_filepair(p);
------------

