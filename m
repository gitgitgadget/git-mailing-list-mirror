From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] ls-tree: handle trailing slashes in the pathspec properly.
Date: Tue, 31 May 2005 16:18:53 -0700
Message-ID: <7v8y1vvvaa.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505310827330.1876@ppc970.osdl.org>
	<7vvf4zvzfw.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505311507010.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 01 01:17:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdFyK-0001HP-2r
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 01:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVEaXTP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 19:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVEaXTP
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 19:19:15 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:17301 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261162AbVEaXSy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2005 19:18:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050531231852.LAOS19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 31 May 2005 19:18:52 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505311507010.1876@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 31 May 2005 15:19:13 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> I just checked in a fix for this in diffcore-patchspec.c, I'd hope that 
LT> ls-tree could get it right too. Removing trailing slashes is a bandaid 
LT> that hides one bug by making it appear as a different bug.

I take it to mean that you took my other patch for diffcore-pathspec.

Here is a fixed ls-tree, with a couple of new tests in an
existing test script, to catch this bug.

------------
This fixes one problem while avoiding the same mistake earlier
diffcore-pathspec had:

 - "drivers/char" which is a tree was not shown given
   "drivers/char/".

 - "drivers/char" which is not a tree is not shown given
   "drivers/char/".

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 ls-tree.c                   |   57 ++++++++++++++++++++++++++-----------------
 t/t3100-ls-tree-restrict.sh |   39 ++++++++++++++++++++++++++----
 2 files changed, 68 insertions(+), 28 deletions(-)

diff --git a/ls-tree.c b/ls-tree.c
--- a/ls-tree.c
+++ b/ls-tree.c
@@ -54,13 +54,22 @@ static int prepare_children(struct tree_
 	return 0;
 }
 
-static struct tree_entry_list *find_entry_0(struct tree_entry_list *elem,
-					    const char *path,
-					    const char *path_end)
+static struct tree_entry_list *find_entry(const char *path,
+					  const char *path_end,
+					  int require_tree)
 {
-	const char *ep;
 	int len;
+	struct tree_entry_list *elem = &root_entry;
+	const char *ep;
 
+	if (path == path_end)
+		/* Special.  This is the root level */
+		return elem;
+
+	/* Find tree element, descending from root, that
+	 * corresponds to the named path, lazily expanding
+	 * the tree if possible.
+	 */
 	while (path < path_end) {
 		if (prepare_children(elem))
 			return NULL;
@@ -81,27 +90,25 @@ static struct tree_entry_list *find_entr
 				break;
 			elem = elem->next;
 		}
-		if (path_end <= ep || !elem)
+		if (!elem)
+			return NULL;
+		if (path_end <= ep) {
+			/* elem matches the specified path.  However,
+			 * if the user said "drivers/char/" and
+			 * elem is "drivers/char", _and_ it is not
+			 * a tree, then we should reject, just like
+			 * "/bin/ls -a ls-tree.c/" says "Not a directory".
+			 */
+			if (require_tree && !elem->directory)
+				return NULL;
 			return elem;
+		}
 		while (*ep == '/' && ep < path_end)
 			ep++;
 		path = ep;
 	}
 	return NULL;
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
 }
 
 static void show_entry_name(struct tree_entry_list *e)
@@ -180,10 +187,10 @@ static int show_entry(struct tree_entry_
 	return err;
 }
 
-static int list_one(const char *path, const char *path_end)
+static int list_one(const char *path, const char *path_end, int require_tree)
 {
 	int err = 0;
-	struct tree_entry_list *e = find_entry(path, path_end);
+	struct tree_entry_list *e = find_entry(path, path_end, require_tree);
 	if (!e) {
 		/* traditionally ls-tree does not complain about
 		 * missing path.  We may change this later to match
@@ -201,9 +208,13 @@ static int list(char **path)
 	int err = 0;
 	for (i = 0; path[i]; i++) {
 		int len = strlen(path[i]);
-		while (0 <= len && path[i][len] == '/')
-			len--;
-		err = err | list_one(path[i], path[i] + len);
+		int require_tree = 0;
+		if (0 < len && path[i][len-1] == '/') {
+			require_tree = 1;
+			while (0 < len && path[i][len-1] == '/')
+				len--;
+		}
+		err = err | list_one(path[i], path[i] + len, require_tree);
 	}
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
------------

