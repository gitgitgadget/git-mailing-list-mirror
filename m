From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH] ls-tree: dump full tree if it was named as such
Date: Mon, 8 Feb 2010 16:59:45 +0100
Message-ID: <f3e853a9329a68cc9b1d544b204ed6a0469b10a2.1265644609.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 08 17:00:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeW1h-00030Z-89
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 16:59:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387Ab0BHP7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 10:59:48 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:8198 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752946Ab0BHP7r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 10:59:47 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 8 Feb
 2010 16:59:47 +0100
Received: from localhost.localdomain (82.130.80.94) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 8 Feb
 2010 16:59:45 +0100
X-Mailer: git-send-email 1.7.0.rc2.178.g109e1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139295>

git-ls-tree acted weird when it was called in a subdirectory but with
a tree (not commit) argument.  For example,

  # in git.git
  mkdir valgrind
  cd valgrind
  git ls-tree HEAD:t

would list the contents of HEAD:t/valgrind even though the user is
looking at /valgrind.

Fix this by not doing the implied-prefix logic when the specified
object is a tree (as in 'HEAD:t' or 'HEAD:'), as opposed to a commit
('HEAD').

To this end, we first introduce a variant of parse_tree_indirect()
that also reports back how many levels it had to traverse.  Then we
teach cmd_ls_tree() to ignore the prefix if that depth was 0.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

RFC because I'm breaking an existing test, though I can't see why
anyone would rely on such weird behaviour.


 builtin-ls-tree.c          |    9 +++++++--
 t/t3101-ls-tree-dirname.sh |   19 ++++++++++++++++++-
 tree.c                     |   11 ++++++++++-
 tree.h                     |    1 +
 4 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
index 4484185..04c6a65 100644
--- a/builtin-ls-tree.c
+++ b/builtin-ls-tree.c
@@ -121,6 +121,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	unsigned char sha1[20];
 	struct tree *tree;
 	int full_tree = 0;
+	int depth;
 	const struct option ls_tree_options[] = {
 		OPT_BIT('d', NULL, &ls_options, "only show trees",
 			LS_TREE_ONLY),
@@ -166,10 +167,14 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	if (get_sha1(argv[0], sha1))
 		die("Not a valid object name %s", argv[0]);
 
-	pathspec = get_pathspec(prefix, argv + 1);
-	tree = parse_tree_indirect(sha1);
+	tree = parse_tree_indirect_depth(sha1, &depth);
 	if (!tree)
 		die("not a tree object");
+	if (!depth) {
+		ls_tree_prefix = prefix = NULL;
+		chomp_prefix = 0;
+	}
+	pathspec = get_pathspec(prefix, argv + 1);
 	read_tree_recursive(tree, "", 0, 0, pathspec, show_tree, NULL);
 
 	return 0;
diff --git a/t/t3101-ls-tree-dirname.sh b/t/t3101-ls-tree-dirname.sh
index 06654c6..a3cd80a 100755
--- a/t/t3101-ls-tree-dirname.sh
+++ b/t/t3101-ls-tree-dirname.sh
@@ -37,6 +37,7 @@ test_expect_success \
      find *.txt path* \( -type f -o -type l \) -print |
      xargs git update-index --add &&
      tree=`git write-tree` &&
+     commit=`echo dummy | git commit-tree $tree` &&
      echo $tree'
 
 test_output () {
@@ -142,7 +143,7 @@ test_expect_success 'ls-tree filter is leading path match' '
 test_expect_success 'ls-tree --full-name' '
 	(
 		cd path0 &&
-		git ls-tree --full-name $tree a
+		git ls-tree --full-name $commit a
 	) >current &&
 	cat >expected <<\EOF &&
 040000 tree X	path0/a
@@ -224,4 +225,20 @@ EOF
 	test_output
 '
 
+test_expect_success 'ls-tree $tree does not restrict to pwd' '
+	(
+		cd path0 &&
+		git ls-tree $tree
+	) >current &&
+	cat >expected <<\EOF &&
+100644 blob X	1.txt
+100644 blob X	2.txt
+040000 tree X	path0
+040000 tree X	path1
+040000 tree X	path2
+040000 tree X	path3
+EOF
+	test_output
+'
+
 test_done
diff --git a/tree.c b/tree.c
index 5ab90af..e9e8481 100644
--- a/tree.c
+++ b/tree.c
@@ -266,9 +266,11 @@ int parse_tree(struct tree *item)
 	return parse_tree_buffer(item, buffer, size);
 }
 
-struct tree *parse_tree_indirect(const unsigned char *sha1)
+struct tree *parse_tree_indirect_depth(const unsigned char *sha1,
+				       int *depth)
 {
 	struct object *obj = parse_object(sha1);
+	*depth = 0;
 	do {
 		if (!obj)
 			return NULL;
@@ -282,5 +284,12 @@ struct tree *parse_tree_indirect(const unsigned char *sha1)
 			return NULL;
 		if (!obj->parsed)
 			parse_object(obj->sha1);
+		(*depth)++;
 	} while (1);
 }
+
+struct tree *parse_tree_indirect(const unsigned char *sha1)
+{
+	int unused;
+	return parse_tree_indirect_depth(sha1, &unused);
+}
diff --git a/tree.h b/tree.h
index 2ff01a4..97f171c 100644
--- a/tree.h
+++ b/tree.h
@@ -18,6 +18,7 @@ struct tree {
 int parse_tree(struct tree *tree);
 
 /* Parses and returns the tree in the given ent, chasing tags and commits. */
+struct tree *parse_tree_indirect_depth(const unsigned char *sha1, int *depth);
 struct tree *parse_tree_indirect(const unsigned char *sha1);
 
 #define READ_TREE_RECURSIVE 1
-- 
1.7.0.rc2.178.g109e1
