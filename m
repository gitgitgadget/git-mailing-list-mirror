From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Make 'diff C^!' show the same diff as 'show C'
Date: Fri, 21 Aug 2009 00:10:07 +0200
Message-ID: <86d1201d8adf53c1f48c0f3526d8e81475b18244.1250806019.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Bj=C3=B6rn=20Steinbrink?= <B.Steinbrink@gmx.de>,
	Abhijit Menon-Sen <ams@toroid.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 21 00:10:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeFqB-0003R3-36
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 00:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754858AbZHTWKa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2009 18:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754531AbZHTWK3
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 18:10:29 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:22017 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754292AbZHTWK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 18:10:28 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.1.375.2; Fri, 21 Aug
 2009 00:10:28 +0200
Received: from localhost.localdomain (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Fri, 21 Aug
 2009 00:10:29 +0200
X-Mailer: git-send-email 1.6.4.363.g2183a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ideally, we'd like 'git diff C^!' to show the same diff that 'git show =
C'
does (with log.showroot enabled).  This gives easy access to a readable
diff for the commit, irrespective of how many parents it has and withou=
t
any trickery to remove the commit message from the git-show output.

cmd_diff relied on telling the various diff invocations apart from
only the number of revisions parsed by setup_revision() (with a twist
for A...B).  In the case of C^! this failed on two counts:

* If C has no parents, setup_revision() turns C^! into simply C.  This
  meant that 'git diff C^!' compared the current worktree to C, which
  is certainly not what the user asked for.

* Otherwise setup_revision puts C itself last, i.e., the rev.pending
  are ^C^1 ... ^C^N C.  So the first revision is uninteresting and in
  the case of exactly two parents, the symmetric difference revspec
  (diff A...B) case fired, and compared C only to C^1 (instead of
  showing a combined diff).

Detect the presence of A...B or C^! style arguments before running
setup_revisions(), so that we know in which case we are in.  We can
then dispatch to the right case without peeking at UNINTERESTING
flags.

There's still some complication in builtin_diff_combined() because
0fe7c1d (built-in diff: assorted updates., 2006-04-29) advertises that
'git diff T0 T1 ... Tn' does a combined diff of arbitrary trees where T=
0
is the merge result, so we have to handle both this case and C^!.

Note that UNINTERESTING is not a good criterion at all, as it is
tacked onto *trees*; if any of the involved revisions share the same
trees, the flags will overwrite each other.

Thanks to Abhijit "crab" Menon-Sen for noticing that 'diff C^!' didn't
work as expected on root commits, and Bj=C3=B6rn "doener" Steinbrink fo=
r
helpful discussions.
---

Error checking is still iffy, but I'm not sure that can be fixed
without throwing out the whole "argument parsing through
setup_revisions" code and handrolling it.


 Documentation/git-diff.txt  |   10 +++++++-
 builtin-diff.c              |   54 +++++++++++++++++++++++++++++++++++=
-------
 t/t4013-diff-various.sh     |    3 ++
 t/t4013/diff.diff_initial^! |   28 ++++++++++++++++++++++
 t/t4013/diff.diff_master^!  |   29 +++++++++++++++++++++++
 t/t4013/diff.diff_side^!    |   32 +++++++++++++++++++++++++
 6 files changed, 146 insertions(+), 10 deletions(-)
 create mode 100644 t/t4013/diff.diff_initial^!
 create mode 100644 t/t4013/diff.diff_master^!
 create mode 100644 t/t4013/diff.diff_side^!

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 0ac7112..5d0f2a6 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -62,9 +62,17 @@ forced by --no-index.
 	"git diff $(git-merge-base A B) B".  You can omit any one
 	of <commit>, which has the same effect as using HEAD instead.
=20
+'git diff' [--options] <commit>^{caret}! [--] [<path>...]::
+
+	This shows the changes that <commit> made relative to its
+	parents.  For an ordinary commit it is the same as `git diff
+	<commit>{caret} <commit>`.  For a root commit it shows a
+	creation patch and for a merge commit it shows a combined
+	diff.
+
 Just in case if you are doing something exotic, it should be
 noted that all of the <commit> in the above description, except
-for the last two forms that use ".." notations, can be any
+for the two forms that use ".." notations, can be any
 <tree-ish>.
=20
 For a more complete list of ways to spell <commit>, see
diff --git a/builtin-diff.c b/builtin-diff.c
index ffcdd05..285bf29 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -163,10 +163,17 @@ static int builtin_diff_tree(struct rev_info *rev=
s,
 	return 0;
 }
=20
+enum diff_mode {
+	DIFF_MODE_NORMAL,
+	DIFF_MODE_SYMMETRIC,
+	DIFF_MODE_SHOW
+};
+
 static int builtin_diff_combined(struct rev_info *revs,
 				 int argc, const char **argv,
 				 struct object_array_entry *ent,
-				 int ents)
+				 int ents,
+				 enum diff_mode mode)
 {
 	const unsigned char (*parent)[20];
 	int i;
@@ -177,8 +184,18 @@ static int builtin_diff_combined(struct rev_info *=
revs,
 	if (!revs->dense_combined_merges && !revs->combine_merges)
 		revs->dense_combined_merges =3D revs->combine_merges =3D 1;
 	parent =3D xmalloc(ents * sizeof(*parent));
-	for (i =3D 0; i < ents; i++)
-		hashcpy((unsigned char *)(parent + i), ent[i].item->sha1);
+
+	if (mode =3D=3D DIFF_MODE_SHOW) {
+		/* diff C^!, we exploit knowledge that C is last */
+		for (i =3D 1; i < ents; i++)
+			hashcpy((unsigned char *)(parent + i),
+				ent[i-1].item->sha1);
+		hashcpy((unsigned char *)(parent),
+			ent[ents-1].item->sha1);
+	} else {
+		for (i =3D 0; i < ents; i++)
+			hashcpy((unsigned char *)(parent + i), ent[i].item->sha1);
+	}
 	diff_tree_combined(parent[0], parent + 1, ents - 1,
 			   revs->dense_combined_merges, revs);
 	return 0;
@@ -254,6 +271,7 @@ int cmd_diff(int argc, const char **argv, const cha=
r *prefix)
 	struct blobinfo blob[2];
 	int nongit;
 	int result =3D 0;
+	enum diff_mode mode =3D DIFF_MODE_NORMAL;
=20
 	/*
 	 * We could get N tree-ish in the rev.pending_objects list.
@@ -292,6 +310,17 @@ int cmd_diff(int argc, const char **argv, const ch=
ar *prefix)
 	/* Otherwise, we are doing the usual "git" diff */
 	rev.diffopt.skip_stat_unmatch =3D !!diff_auto_refresh_index;
=20
+	for (i =3D 1; i < argc; i++) {
+		if (prefixcmp(argv[i], "--")) {
+			if (strstr(argv[i], "..."))
+				mode =3D DIFF_MODE_SYMMETRIC;
+			else if (strstr(argv[i], "^!"))
+				mode =3D DIFF_MODE_SHOW;
+		} else if (!strcmp(argv[i], "--")) {
+			break;
+		}
+	}
+
 	/* Default to let external and textconv be used */
 	DIFF_OPT_SET(&rev.diffopt, ALLOW_EXTERNAL);
 	DIFF_OPT_SET(&rev.diffopt, ALLOW_TEXTCONV);
@@ -403,11 +432,7 @@ int cmd_diff(int argc, const char **argv, const ch=
ar *prefix)
 	}
 	else if (blobs)
 		usage(builtin_diff_usage);
-	else if (ents =3D=3D 1)
-		result =3D builtin_diff_index(&rev, argc, argv);
-	else if (ents =3D=3D 2)
-		result =3D builtin_diff_tree(&rev, argc, argv, ent);
-	else if ((ents =3D=3D 3) && (ent[0].item->flags & UNINTERESTING)) {
+	else if (mode =3D=3D DIFF_MODE_SYMMETRIC) {
 		/* diff A...B where there is one sane merge base between
 		 * A and B.  We have ent[0] =3D=3D merge-base, ent[1] =3D=3D A,
 		 * and ent[2] =3D=3D B.  Show diff between the base and B.
@@ -415,9 +440,20 @@ int cmd_diff(int argc, const char **argv, const ch=
ar *prefix)
 		ent[1] =3D ent[2];
 		result =3D builtin_diff_tree(&rev, argc, argv, ent);
 	}
+	else if (ents =3D=3D 1 && mode =3D=3D DIFF_MODE_SHOW) {
+		/* diff R^! where R is a root commit: creation patch */
+		diff_tree_sha1((const unsigned char *) EMPTY_TREE_SHA1_BIN,
+			       ent[0].item->sha1, "", &rev.diffopt);
+		log_tree_diff_flush(&rev);
+		result =3D 0;
+	}
+	else if (ents =3D=3D 1)
+		result =3D builtin_diff_index(&rev, argc, argv);
+	else if (ents =3D=3D 2)
+		result =3D builtin_diff_tree(&rev, argc, argv, ent);
 	else
 		result =3D builtin_diff_combined(&rev, argc, argv,
-					     ent, ents);
+					       ent, ents, mode);
 	result =3D diff_result_code(&rev.diffopt, result);
 	if (1 < rev.diffopt.skip_stat_unmatch)
 		refresh_index_quietly();
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 8b33321..2ce7204 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -273,6 +273,9 @@ diff --no-index --name-status -- dir2 dir
 diff --no-index dir dir3
 diff master master^ side
 diff --dirstat master~1 master~2
+diff initial^!
+diff side^!
+diff master^!
 EOF
=20
 test_done
diff --git a/t/t4013/diff.diff_initial^! b/t/t4013/diff.diff_initial^!
new file mode 100644
index 0000000..22f6bb7
--- /dev/null
+++ b/t/t4013/diff.diff_initial^!
@@ -0,0 +1,28 @@
+$ git diff initial^!
+diff --git a/dir/sub b/dir/sub
+new file mode 100644
+index 0000000..35d242b
+--- /dev/null
++++ b/dir/sub
+@@ -0,0 +1,2 @@
++A
++B
+diff --git a/file0 b/file0
+new file mode 100644
+index 0000000..01e79c3
+--- /dev/null
++++ b/file0
+@@ -0,0 +1,3 @@
++1
++2
++3
+diff --git a/file2 b/file2
+new file mode 100644
+index 0000000..01e79c3
+--- /dev/null
++++ b/file2
+@@ -0,0 +1,3 @@
++1
++2
++3
+$
diff --git a/t/t4013/diff.diff_master^! b/t/t4013/diff.diff_master^!
new file mode 100644
index 0000000..ca2eaa1
--- /dev/null
+++ b/t/t4013/diff.diff_master^!
@@ -0,0 +1,29 @@
+$ git diff master^!
+diff --cc dir/sub
+index cead32e,7289e35..992913c
+--- a/dir/sub
++++ b/dir/sub
+@@@ -1,6 -1,4 +1,8 @@@
+  A
+  B
+ +C
+ +D
+ +E
+ +F
++ 1
++ 2
+diff --cc file0
+index b414108,f4615da..10a8a9f
+--- a/file0
++++ b/file0
+@@@ -1,6 -1,6 +1,9 @@@
+  1
+  2
+  3
+ +4
+ +5
+ +6
++ A
++ B
++ C
+$
diff --git a/t/t4013/diff.diff_side^! b/t/t4013/diff.diff_side^!
new file mode 100644
index 0000000..6d4378a
--- /dev/null
+++ b/t/t4013/diff.diff_side^!
@@ -0,0 +1,32 @@
+$ git diff side^!
+diff --git a/dir/sub b/dir/sub
+index 35d242b..7289e35 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -1,2 +1,4 @@
+ A
+ B
++1
++2
+diff --git a/file0 b/file0
+index 01e79c3..f4615da 100644
+--- a/file0
++++ b/file0
+@@ -1,3 +1,6 @@
+ 1
+ 2
+ 3
++A
++B
++C
+diff --git a/file3 b/file3
+new file mode 100644
+index 0000000..7289e35
+--- /dev/null
++++ b/file3
+@@ -0,0 +1,4 @@
++A
++B
++1
++2
+$
--=20
1.6.4.363.g2183a
