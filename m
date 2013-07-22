From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH] log: use true parents for diff even when rewriting
Date: Mon, 22 Jul 2013 23:22:01 +0200
Message-ID: <a598aec3e3c90de4d2c08e58ee0a4828edc80ac2.1374527806.git.trast@inf.ethz.ch>
References: <20130722090854.GA22222@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>,
	Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 22 23:22:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1NYa-0003gk-Ae
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 23:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932705Ab3GVVWH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Jul 2013 17:22:07 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:13152 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932316Ab3GVVWF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 17:22:05 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 22 Jul
 2013 23:22:01 +0200
Received: from linux-k42r.Speedport_W723_V_Typ_A_1_00_096 (217.235.0.128) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 22 Jul 2013 23:22:02 +0200
X-Mailer: git-send-email 1.8.3.3.1182.ga598aec
In-Reply-To: <20130722090854.GA22222@pengutronix.de>
X-Originating-IP: [217.235.0.128]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230992>

When using pathspec filtering in combination with diff-based log
output, parent simplification happens before the diff is computed.
The diff is therefore against the *simplified* parents.

This works okay, arguably by accident, in the normal case: the pruned
commits did not affect the paths being filtered, so the diff against
the prune-result is the same as against the diff against the true
parents.

However, --full-diff breaks this guarantee, and indeed gives pretty
spectacular results when comparing the output of

  git log --graph --stat ...
  git log --graph --full-diff --stat ...

(--graph internally kicks in parent simplification, much like
--parents).

Reported-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---

Perhaps like this.  It's getting a bit late, so I'm not sure if I'm
missing another user of the "true" parent list, but it does fix the
issue you reported.

 combine-diff.c               |  3 ++-
 commit.c                     | 16 ++++++++++++++++
 commit.h                     |  3 +++
 log-tree.c                   |  2 +-
 revision.c                   | 30 +++++++++++++++++++++++++++++-
 revision.h                   | 15 +++++++++++++++
 t/t6012-rev-list-simplify.sh |  6 ++++++
 7 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 6dc0609..abd2397 100644
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
+	struct commit_list *parent =3D get_saved_parents(commit);
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
index 35cc4e2..ca766d2 100644
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
index a49d8e8..b1d5747 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -738,7 +738,7 @@ static int log_tree_diff(struct rev_info *opt, stru=
ct commit *commit, struct log
 	sha1 =3D commit->tree->object.sha1;
=20
 	/* Root commit? */
-	parents =3D commit->parents;
+	parents =3D get_saved_parents(commit);
 	if (!parents) {
 		if (opt->show_root_diff) {
 			diff_root_tree_sha1(sha1, "", &opt->diffopt);
diff --git a/revision.c b/revision.c
index 84ccc05..3fdd0ae 100644
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
@@ -2820,6 +2821,7 @@ enum commit_action simplify_commit(struct rev_inf=
o *revs, struct commit *commit)
 	if (action =3D=3D commit_show &&
 	    !revs->show_all &&
 	    revs->prune && revs->dense && want_ancestry(revs)) {
+		save_parents(commit);
 		if (rewrite_parents(revs, commit, rewrite_one) < 0)
 			return commit_error;
 	}
@@ -3069,3 +3071,29 @@ void put_revision_mark(const struct rev_info *re=
vs, const struct commit *commit)
 	fputs(mark, stdout);
 	putchar(' ');
 }
+
+define_commit_slab(saved_parents, struct commit_list *);
+struct saved_parents saved_parents_slab;
+static int saved_parents_initialized;
+
+void save_parents(struct commit *commit)
+{
+	struct commit_list **pp;
+
+	if (!saved_parents_initialized) {
+		init_saved_parents(&saved_parents_slab);
+		saved_parents_initialized =3D 1;
+	}
+
+	pp =3D saved_parents_at(&saved_parents_slab, commit);
+	assert(*pp =3D=3D NULL);
+	*pp =3D copy_commit_list(commit->parents);
+}
+
+struct commit_list *get_saved_parents(struct commit *commit)
+{
+	if (!saved_parents_initialized)
+		return commit->parents;
+
+	return *saved_parents_at(&saved_parents_slab, commit);
+}
diff --git a/revision.h b/revision.h
index 95859ba..0717518 100644
--- a/revision.h
+++ b/revision.h
@@ -273,4 +273,19 @@ enum rewrite_result {
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
+ * get_original_parents() will transparently return commit->parents if
+ * history simplification is off.
+ */
+extern void save_parents(struct commit *commit);
+extern struct commit_list *get_original_parents(struct commit *commit)=
;
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
1.8.3.3.1180.gbf33142
