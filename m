From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/9 v5] bisect: add "git bisect replace" subcommand
Date: Mon, 24 Nov 2008 22:13:03 +0100
Message-ID: <20081124221303.7ec1c862.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"H. Peter Anvin" <hpa@zytor.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 00:58:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4lJw-00086p-5C
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 00:58:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558AbYKXX5I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Nov 2008 18:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752286AbYKXX5H
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 18:57:07 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:56044 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752150AbYKXX5G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Nov 2008 18:57:06 -0500
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 78C80337A;
	Tue, 25 Nov 2008 00:20:31 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g19.free.fr (Postfix) with SMTP id 07B73A5C6;
	Mon, 24 Nov 2008 22:11:31 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101634>

This subcommand should be used when you have a branch or a part of a
branch that isn't easily bisectable because of a bug that has been
fixed latter.

We suppose that a bug as been introduced at some point, say A, and
that it has been fixed latter at another point, say B, but that
between these points the code is not easily testable because of the
bug, so it's not easy to bisect between these points.

In this case you can create a branch starting at the parent of A, say
O, that has a fixed history. In this fixed history for example, there
could be first a commit C that is the result of squashing A and B
together and then all the commits between A and B that have been
cherry picked.

=46or example, let's say the commits between A and B are X1, X2, ... Xn
and they have been cherry picked after C as Y1, Y2, ... Yn:

        C--Y1--Y2--...--Yn
      /
=2E..--O--A--X1--X2--...--Xn--B--...

By design, the last cherry picked commit (Yn) should point to the same
tree as commit B.

So in this case you can say:

$ git bisect replace B Yn

and a special ref will be created that points to commit Yn. This ref
will be named: "refs/replace/bisect/B"

When bisecting, the refs in "refs/replace/bisect/" will be scanned and
each ref named X found there and pointing to commit Y will be grafted
so that X will only have Y as parent.

In the example above, that means that instead of the above graph, the
following graph will be bisected:

        C--Y1--Y2--...--Yn
      /                   \
=2E..--O                     B--...

This means that the bisections on this branch will be much easier
because the bug introduced by commit A and fixed by commit B will not
annoy you anymore.

As the refs created by "git bisect replace" can be shared between
developers, this feature might be especially usefull on big projects
where many people often bisect the same code base.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-rev-list.c |   71 ++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
 git-bisect.sh      |   36 +++++++++++++++++++++++++-
 refs.c             |    5 +++
 refs.h             |    1 +
 4 files changed, 110 insertions(+), 3 deletions(-)

	Junio wrote:
	>
	> I have a separate idea make 'grafts' easier on object transfer, that=
 is
	> somewhat related to this one, by the way. =A0Instead of making the g=
rafts
	> completely a local matter as we do now, we can reserve refs/replace/
	> namespace, and record a new commit object to replace an existing com=
mit
	> whose object name is $sha1 as refs/replace/$sha1. =A0We make almost =
all the
	> commands except object enumeration (fsck, receive-pack, send-pack, p=
rune,
	> etc. =A0Roughly speaking, anything that involves "rev-list --objects=
") honor
	> this commit replacement, so that any time you ask for commit $sha1, =
the
	> object layer gives you the replacement commit object back. =A0In thi=
s way,
	> you can clone or fetch from such a repository (along with refs in
	> refs/replace/ hierarchy) and fsck/prune won't lose the original pare=
nts
	> (because it does not see replacements). =A0Things like paranoid upda=
te hook
	> needs to become very careful about refs/replace/ for security reason=
s, but
	> I think this would make the grafts much easier to use.

	In this new version the "bisect-replace-*" branches have been replaced=
 by
	refs like "refs/replace/bisect/$sha1". Most of the code changes are in=
 the
	first patch. But there are also many documentation changes in the seri=
es.=20

	I will see later if I can change usual grafts into refs in "refs/repla=
ce/grafts/"
	or something like that.


diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 857742a..8adf269 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -574,6 +574,72 @@ static struct commit_list *find_bisection(struct c=
ommit_list *list,
 	return best;
 }
=20
+static void replace_parents(struct commit *commit,
+			    const char *refname,
+			    const unsigned char *sha1)
+{
+	struct commit *new_parent =3D lookup_commit(sha1);
+	if (!new_parent) {
+		warning("replace ref '%s' points to unknown commit '%s'",
+			refname, sha1_to_hex(sha1));
+		return;
+	}
+
+	free_commit_list(commit->parents);
+	commit->parents =3D NULL;
+	commit_list_insert(new_parent, &commit->parents);
+}
+
+static int bisect_replace(const char *refname, const unsigned char *sh=
a1,
+			  int flag, void *cb_data)
+{
+	unsigned char child[20];
+	struct object *obj;
+	struct commit_graft *graft;
+
+	if (prefixcmp(refname, "bisect/"))
+		return 0;
+
+	if (get_sha1_hex(refname + 7, child)) {
+		warning("bad sha1 in replace ref named '%s'", refname);
+		return 0;
+	}
+
+	/* Check if child commit exist and is already parsed */
+
+	obj =3D lookup_object(child);
+	if (obj) {
+		struct commit *commit;
+		if (obj->type !=3D OBJ_COMMIT) {
+			warning("replace ref name '%s' refers to non commit '%s'",
+				refname, refname + 7);
+			return 0;
+		}
+		commit =3D (struct commit *) obj;
+		if (commit->object.parsed) {
+			replace_parents(commit, refname, sha1);
+			return 0;
+		}
+	}
+
+	/* Create a graft to replace child commit parents */
+
+	graft =3D xmalloc(sizeof(*graft) + 20);
+
+	hashcpy(graft->sha1, child);
+	graft->nr_parent =3D 1;
+	hashcpy(graft->parent[0], sha1);
+
+	register_commit_graft(graft, 1);
+
+	return 0;
+}
+
+static void bisect_replace_all(void)
+{
+	for_each_replace_ref(bisect_replace, NULL);
+}
+
 int cmd_rev_list(int argc, const char **argv, const char *prefix)
 {
 	struct commit_list *list;
@@ -646,8 +712,11 @@ int cmd_rev_list(int argc, const char **argv, cons=
t char *prefix)
=20
 	save_commit_buffer =3D revs.verbose_header ||
 		revs.grep_filter.pattern_list;
-	if (bisect_list)
+
+	if (bisect_list) {
+		bisect_replace_all();
 		revs.limited =3D 1;
+	}
=20
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
diff --git a/git-bisect.sh b/git-bisect.sh
index 0d0e278..ed7c620 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
=20
-USAGE=3D'[help|start|bad|good|skip|next|reset|visualize|replay|log|run=
]'
+USAGE=3D'[help|start|bad|good|skip|next|reset|visualize|replay|log|rep=
lace|run]'
 LONG_USAGE=3D'git bisect help
         print this long help message.
 git bisect start [<bad> [<good>...]] [--] [<pathspec>...]
@@ -21,6 +21,8 @@ git bisect replay <logfile>
         replay bisection log.
 git bisect log
         show bisect log.
+git bisect replace <rev> [<rev>]
+        use another branch for bisection.
 git bisect run <cmd>...
         use <cmd>... to automatically bisect.
=20
@@ -566,6 +568,35 @@ bisect_replay () {
 	bisect_auto_next
 }
=20
+bisect_replace() {
+    test "$#" -ge 1 -a "$#" -le 2 ||
+        die "'git bisect replace' accept one or two arguments"
+
+    source=3D"$1"
+    target=3D"${2:-HEAD}"
+
+    # Check arguments
+    src_commit=3D$(git rev-parse --verify "$source^{commit}") ||
+        die "Bad rev input: $source"
+    tgt_commit=3D$(git rev-parse --verify "$target^{commit}") ||
+        die "Bad rev input: $target"
+
+    test "$src_commit" !=3D "tgt_commit" ||
+        die "source and target should be different commits"
+
+    # Check that trees from source and target are identical
+    src_tree=3D$(git rev-parse --verify "$src_commit^{tree}") ||
+        die "Could not get tree for source: $source"
+    tgt_tree=3D$(git rev-parse --verify "$tgt_commit^{tree}") ||
+        die "Could not get tree for target: $target"
+
+    test "$src_tree" =3D "$tgt_tree" ||
+        die "source and target should point to the same tree"
+
+    # Create a ref in "refs/replace/bisect/" for the target commit
+    git update-ref -m bisect "refs/replace/bisect/$src_commit" "$tgt_c=
ommit"
+}
+
 bisect_run () {
     bisect_next_check fail
=20
@@ -618,7 +649,6 @@ bisect_run () {
     done
 }
=20
-
 case "$#" in
 0)
     usage ;;
@@ -643,6 +673,8 @@ case "$#" in
 	bisect_replay "$@" ;;
     log)
 	cat "$GIT_DIR/BISECT_LOG" ;;
+    replace)
+        bisect_replace "$@" ;;
     run)
         bisect_run "$@" ;;
     *)
diff --git a/refs.c b/refs.c
index 33ced65..042106d 100644
--- a/refs.c
+++ b/refs.c
@@ -632,6 +632,11 @@ int for_each_remote_ref(each_ref_fn fn, void *cb_d=
ata)
 	return do_for_each_ref("refs/remotes/", fn, 13, cb_data);
 }
=20
+int for_each_replace_ref(each_ref_fn fn, void *cb_data)
+{
+	return do_for_each_ref("refs/replace/", fn, 13, cb_data);
+}
+
 /*
  * Make sure "ref" is something reasonable to have under ".git/refs/";
  * We do not like it if:
diff --git a/refs.h b/refs.h
index 06ad260..8d2ee5a 100644
--- a/refs.h
+++ b/refs.h
@@ -23,6 +23,7 @@ extern int for_each_ref(each_ref_fn, void *);
 extern int for_each_tag_ref(each_ref_fn, void *);
 extern int for_each_branch_ref(each_ref_fn, void *);
 extern int for_each_remote_ref(each_ref_fn, void *);
+extern int for_each_replace_ref(each_ref_fn, void *);
=20
 /*
  * Extra refs will be listed by for_each_ref() before any actual refs
--=20
1.5.6.1.1657.g6a50
