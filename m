From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH v2] log: use true parents for diff even when rewriting
Date: Wed, 31 Jul 2013 22:13:20 +0200
Message-ID: <e7f2ead2267ff78940aab00fe36c378a2ce5d85e.1375301293.git.trast@inf.ethz.ch>
References: <a598aec3e3c90de4d2c08e58ee0a4828edc80ac2.1374527806.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 31 22:13:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4cmE-0002SH-5u
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 22:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757089Ab3GaUNY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Jul 2013 16:13:24 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:28660 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755143Ab3GaUNX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 16:13:23 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 31 Jul
 2013 22:13:15 +0200
Received: from hexa.v.cablecom.net (46.126.8.85) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 31 Jul
 2013 22:13:20 +0200
X-Mailer: git-send-email 1.8.4.rc0.408.gad6868d
In-Reply-To: <a598aec3e3c90de4d2c08e58ee0a4828edc80ac2.1374527806.git.trast@inf.ethz.ch>
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231453>

When using pathspec filtering in combination with diff-based log
output, parent simplification happens before the diff is computed.
The diff is therefore against the *simplified* parents.

This works okay, arguably by accident, in the normal case:
simplification reduces to one parent as long as the commit is TREESAME
to it.  So the simplified parent of any given commit must have the
same tree contents on the filtered paths as its true (unfiltered)
parent.

However, --full-diff breaks this guarantee, and indeed gives pretty
spectacular results when comparing the output of

  git log --graph --stat ...
  git log --graph --full-diff --stat ...

(--graph internally kicks in parent simplification, much like
--parents).

To fix it, store a copy of the parent list before simplification (in a
slab) whenever --full-diff is in effect.  Then use the stored parents
instead of the simplified ones in the commit display code paths.  The
latter do not actually check for --full-diff to avoid duplicated code;
they just grab the original parents if save_parents() has not been
called for this revision walk.

=46or ordinary commits it should be obvious that this is the right thin=
g
to do.

Merge commits are a bit subtle.  Observe that with default
simplification, merge simplification is an all-or-nothing decision:
either the merge is TREESAME to one parent and disappears, or it is
different from all parents and the parent list remains intact.
Redundant parents are not pruned, so the existing code also shows them
as a merge.

So if we do show a merge commit, the parent list just consists of the
rewrite result on each parent.  Running, e.g., --cc on this in
--full-diff mode is not very useful: if any commits were skipped, some
hunks will disagree with all sides of the merge (with one side,
because commits were skipped; with the others, because they didn't
have those changes in the first place).  This triggers --cc showing
these hunks spuriously.

Therefore I believe that even for merge commits it is better to show
the diffs wrt. the original parents.

Reported-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---

New in this version:

* Junio's and Ramsay's suggestions squashed

* Moved the slab variable from file-static to within the struct
  rev_info.  In practice there is no difference, because you cannot
  run two walks in parallel anyway (they would stomp over each others'
  parent lists!).  But it was easy, feels slightly cleaner, and avoids
  having yet another global variable.

* Wrote an actual commit message.  I hope the logic wrt. merge commits
  is correct.


 combine-diff.c               |  3 ++-
 commit.c                     | 16 ++++++++++++++++
 commit.h                     |  3 +++
 log-tree.c                   |  2 +-
 revision.c                   | 43 ++++++++++++++++++++++++++++++++++++=
++++++-
 revision.h                   | 20 ++++++++++++++++++++
 t/t6012-rev-list-simplify.sh |  6 ++++++
 7 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 6dc0609..3d2aaf3 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -10,6 +10,7 @@
 #include "refs.h"
 #include "userdiff.h"
 #include "sha1-array.h"
+#include "revision.h"
=20
 static struct combine_diff_path *intersect_paths(struct combine_diff_p=
ath *curr, int n, int num_parent)
 {
@@ -1383,7 +1384,7 @@ void diff_tree_combined(const unsigned char *sha1=
,
 void diff_tree_combined_merge(const struct commit *commit, int dense,
 			      struct rev_info *rev)
 {
-	struct commit_list *parent =3D commit->parents;
+	struct commit_list *parent =3D get_saved_parents(rev, commit);
 	struct sha1_array parents =3D SHA1_ARRAY_INIT;
=20
 	while (parent) {
diff --git a/commit.c b/commit.c
index e5862f6..5ecdb38 100644
--- a/commit.c
+++ b/commit.c
@@ -377,6 +377,22 @@ unsigned commit_list_count(const struct commit_lis=
t *l)
 	return c;
 }
=20
+struct commit_list *copy_commit_list(struct commit_list *list)
+{
+	struct commit_list *head =3D NULL;
+	struct commit_list **pp =3D &head;
+	while (list) {
+		struct commit_list *new;
+		new =3D xmalloc(sizeof(struct commit_list));
+		new->item =3D list->item;
+		new->next =3D NULL;
+		*pp =3D new;
+		pp =3D &new->next;
+		list =3D list->next;
+	}
+	return head;
+}
+
 void free_commit_list(struct commit_list *list)
 {
 	while (list) {
diff --git a/commit.h b/commit.h
index d912a9d..f9504f7 100644
--- a/commit.h
+++ b/commit.h
@@ -62,6 +62,9 @@ struct commit_list *commit_list_insert_by_date(struct=
 commit *item,
 				    struct commit_list **list);
 void commit_list_sort_by_date(struct commit_list **list);
=20
+/* Shallow copy of the input list */
+struct commit_list *copy_commit_list(struct commit_list *list);
+
 void free_commit_list(struct commit_list *list);
=20
 /* Commit formats */
diff --git a/log-tree.c b/log-tree.c
index a49d8e8..8534d91 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -738,7 +738,7 @@ static int log_tree_diff(struct rev_info *opt, stru=
ct commit *commit, struct log
 	sha1 =3D commit->tree->object.sha1;
=20
 	/* Root commit? */
-	parents =3D commit->parents;
+	parents =3D get_saved_parents(opt, commit);
 	if (!parents) {
 		if (opt->show_root_diff) {
 			diff_root_tree_sha1(sha1, "", &opt->diffopt);
diff --git a/revision.c b/revision.c
index 84ccc05..e3ca936 100644
--- a/revision.c
+++ b/revision.c
@@ -15,6 +15,7 @@
 #include "string-list.h"
 #include "line-log.h"
 #include "mailmap.h"
+#include "commit-slab.h"
=20
 volatile show_early_output_fn_t show_early_output;
=20
@@ -2763,7 +2764,7 @@ static int commit_match(struct commit *commit, st=
ruct rev_info *opt)
 	return retval;
 }
=20
-static inline int want_ancestry(struct rev_info *revs)
+static inline int want_ancestry(const struct rev_info *revs)
 {
 	return (revs->rewrite_parents || revs->children.name);
 }
@@ -2820,6 +2821,14 @@ enum commit_action simplify_commit(struct rev_in=
fo *revs, struct commit *commit)
 	if (action =3D=3D commit_show &&
 	    !revs->show_all &&
 	    revs->prune && revs->dense && want_ancestry(revs)) {
+		/*
+		 * --full-diff on simplified parents is no good: it
+		 * will show spurious changes from the commits that
+		 * were elided.  So we save the parents on the side
+		 * when --full-diff is in effect.
+		 */
+		if (revs->full_diff)
+			save_parents(revs, commit);
 		if (rewrite_parents(revs, commit, rewrite_one) < 0)
 			return commit_error;
 	}
@@ -3038,6 +3047,8 @@ struct commit *get_revision(struct rev_info *revs=
)
 	c =3D get_revision_internal(revs);
 	if (c && revs->graph)
 		graph_update(revs->graph, c);
+	if (!c)
+		free_saved_parents(revs);
 	return c;
 }
=20
@@ -3069,3 +3080,33 @@ void put_revision_mark(const struct rev_info *re=
vs, const struct commit *commit)
 	fputs(mark, stdout);
 	putchar(' ');
 }
+
+define_commit_slab(saved_parents, struct commit_list *);
+
+void save_parents(struct rev_info *revs, struct commit *commit)
+{
+	struct commit_list **pp;
+
+	if (!revs->saved_parents_slab) {
+		revs->saved_parents_slab =3D xmalloc(sizeof(struct saved_parents));
+		init_saved_parents(revs->saved_parents_slab);
+	}
+
+	pp =3D saved_parents_at(revs->saved_parents_slab, commit);
+	assert(*pp =3D=3D NULL);
+	*pp =3D copy_commit_list(commit->parents);
+}
+
+struct commit_list *get_saved_parents(struct rev_info *revs, const str=
uct commit *commit)
+{
+	if (!revs->saved_parents_slab)
+		return commit->parents;
+
+	return *saved_parents_at(revs->saved_parents_slab, commit);
+}
+
+void free_saved_parents(struct rev_info *revs)
+{
+	if (revs->saved_parents_slab)
+		clear_saved_parents(revs->saved_parents_slab);
+}
diff --git a/revision.h b/revision.h
index 95859ba..e7f1d21 100644
--- a/revision.h
+++ b/revision.h
@@ -25,6 +25,7 @@
 struct rev_info;
 struct log_info;
 struct string_list;
+struct saved_parents;
=20
 struct rev_cmdline_info {
 	unsigned int nr;
@@ -187,6 +188,9 @@ struct rev_info {
=20
 	/* line level range that we are chasing */
 	struct decoration line_log_data;
+
+	/* copies of the parent lists, for --full-diff display */
+	struct saved_parents *saved_parents_slab;
 };
=20
 #define REV_TREE_SAME		0
@@ -273,4 +277,20 @@ enum rewrite_result {
=20
 extern int rewrite_parents(struct rev_info *revs, struct commit *commi=
t,
 	rewrite_parent_fn_t rewrite_parent);
+
+/*
+ * Save a copy of the parent list, and return the saved copy.  This is
+ * used by the log machinery to retrieve the original parents when
+ * commit->parents has been modified by history simpification.
+ *
+ * You may only call save_parents() once per commit (this is checked
+ * for non-root commits).
+ *
+ * get_saved_parents() will transparently return commit->parents if
+ * history simplification is off.
+ */
+extern void save_parents(struct rev_info *revs, struct commit *commit)=
;
+extern struct commit_list *get_saved_parents(struct rev_info *revs, co=
nst struct commit *commit);
+extern void free_saved_parents(struct rev_info *revs);
+
 #endif
diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.s=
h
index 57ce239..fde5e71 100755
--- a/t/t6012-rev-list-simplify.sh
+++ b/t/t6012-rev-list-simplify.sh
@@ -127,4 +127,10 @@ test_expect_success 'full history simplification w=
ithout parent' '
 	}
 '
=20
+test_expect_success '--full-diff is not affected by --parents' '
+	git log -p --pretty=3D"%H" --full-diff -- file >expected &&
+	git log -p --pretty=3D"%H" --full-diff --parents -- file >actual &&
+	test_cmp expected actual
+'
+
 test_done
--=20
1.8.4.rc0.408.gad6868d
