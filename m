From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH 2/3 v2] Teach git diff-tree --stdin to diff trees
Date: Sat, 09 Aug 2008 14:11:18 +0200
Message-ID: <20080809120816.11085.66578.stgit@yoghurt>
References: <20080809095605.GA10804@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 09 14:12:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRnJS-0007TT-Ly
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 14:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbYHIML1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Aug 2008 08:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbYHIML1
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 08:11:27 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3909 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbYHIML0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 08:11:26 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KRnda-0003Uu-00; Sat, 09 Aug 2008 13:33:38 +0100
In-Reply-To: <20080809095605.GA10804@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.14.3.222.g9ef2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91767>

When feeding trees on the command line, you can give exactly two
trees, not three nor one; --stdin now supports this "two tree" form on
its input, in addition to accepting lines with one or more commits.

When diffing trees (either specified on the command line or from the
standard input), the -m, -s, -v, --pretty, --abbrev-commit,
--encoding, --no-commit-id, -c, --cc, and --always options are
ignored, since they do not apply to trees.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

With updated commit message. (And I checked -- your earlier doc patch
_is_ obsoleted by this patch, so I saw no need to change anything
else.)

 Documentation/git-diff-tree.txt |   14 +++++++++-----
 builtin-diff-tree.c             |   35 +++++++++++++++++++++++++++++++=
----
 2 files changed, 40 insertions(+), 9 deletions(-)


diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-t=
ree.txt
index 1fdf20d..0b1ade8 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -49,13 +49,17 @@ include::diff-options.txt[]
 --stdin::
 	When '--stdin' is specified, the command does not take
 	<tree-ish> arguments from the command line.  Instead, it
-	reads either one <commit> or a list of <commit>
-	separated with a single space from its standard input.
+	reads lines containing either two <tree>, one <commit>, or a
+	list of <commit> from its standard input.  (Use a single space
+	as separator.)
 +
-When a single commit is given on one line of such input, it compares
-the commit with its parents.  The following flags further affects its
-behavior.  The remaining commits, when given, are used as if they are
+When two trees are given, it compares the first tree with the second.
+When a single commit is given, it compares the commit with its
+parents.  The remaining commits, when given, are used as if they are
 parents of the first commit.
++
+The following flags further affects the behavior when comparing
+commits (but not trees).
=20
 -m::
 	By default, 'git-diff-tree --stdin' does not show
diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
index ebbd631..0bdb1cf 100644
--- a/builtin-diff-tree.c
+++ b/builtin-diff-tree.c
@@ -42,21 +42,48 @@ static int stdin_diff_commit(struct commit *commit,=
 char *line, int len)
 	return log_tree_commit(&log_tree_opt, commit);
 }
=20
+/* Diff two trees. */
+static int stdin_diff_trees(struct tree *tree1, char *line, int len)
+{
+	unsigned char sha1[20];
+	struct tree *tree2;
+	if (len !=3D 82 || !isspace(line[40]) || get_sha1_hex(line + 41, sha1=
)) {
+		error("Need precisely two trees, separated by one space");
+		return -1;
+	}
+	tree2 =3D lookup_tree(sha1);
+	if (!tree2 || parse_tree(tree2))
+		return -1;
+	printf("%s %s\n", sha1_to_hex(tree1->object.sha1),
+			  sha1_to_hex(tree2->object.sha1));
+	diff_tree_sha1(tree1->object.sha1, tree2->object.sha1,
+		       "", &log_tree_opt.diffopt);
+	log_tree_diff_flush(&log_tree_opt);
+	return 0;
+}
+
 static int diff_tree_stdin(char *line)
 {
 	int len =3D strlen(line);
 	unsigned char sha1[20];
-	struct commit *commit;
+	struct object *obj;
=20
 	if (!len || line[len-1] !=3D '\n')
 		return -1;
 	line[len-1] =3D 0;
 	if (get_sha1_hex(line, sha1))
 		return -1;
-	commit =3D lookup_commit(sha1);
-	if (!commit || parse_commit(commit))
+	obj =3D lookup_object(sha1);
+	obj =3D obj ? obj : parse_object(sha1);
+	if (!obj)
 		return -1;
-	return stdin_diff_commit(commit, line, len);
+	if (obj->type =3D=3D OBJ_COMMIT)
+		return stdin_diff_commit((struct commit *)obj, line, len);
+	if (obj->type =3D=3D OBJ_TREE)
+		return stdin_diff_trees((struct tree *)obj, line, len);
+	error("Object %s is a %s, not a commit or tree",
+	      sha1_to_hex(sha1), typename(obj->type));
+	return -1;
 }
=20
 static const char diff_tree_usage[] =3D
