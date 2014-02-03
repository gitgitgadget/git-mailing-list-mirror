From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 7/8] combine-diff: Fast changed-to-all-parents paths scanning
Date: Mon,  3 Feb 2014 16:47:21 +0400
Message-ID: <c0ad49d850377aedffa0a593fef8738112019b01.1391430523.git.kirr@mns.spb.ru>
References: <cover.1391430523.git.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 03 13:46:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAIuz-00075i-TA
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 13:46:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbaBCMqX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Feb 2014 07:46:23 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:37571 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751765AbaBCMqW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 07:46:22 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WAIup-0004aS-MH; Mon, 03 Feb 2014 16:46:20 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WAIwd-0007Fy-9n; Mon, 03 Feb 2014 16:48:11 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
In-Reply-To: <cover.1391430523.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1391430523.git.kirr@mns.spb.ru>
References: <cover.1391430523.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241433>

As was recently shown (c839f1bd "combine-diff: optimize
combine_diff_path sets intersection"), combine-diff runs very slowly. I=
n
that commit we optimized paths sets intersection, but that accounted
only for ~ 25% of the slowness, and as my tracing showed, for linux.git
v3.10..v3.11, for merges a lot of time is spent computing
diff(commit,commit^2) just to only then intersect that huge diff to
almost small set of files from diff(commit,commit^1).

That's because at present, to compute combine-diff, for first finding
paths, that "every parent touches", we use the following combine-diff
property/definition:

    D(A,P1...Pn) =3D D(A,P1) ^ ... ^ D(A,Pn)      (w.r.t. paths)

where

    D(A,P1...Pn) is combined diff between commit A, and parents Pi

and

    D(A,Pi) is usual two-tree diff Pi..A

So if any of that D(A,Pi) is huge, tracting 1 n-parent combine-diff as =
n
1-parent diffs and intersecting results will be slow.

And usually, for linux.git and other topic-based workflows, that
D(A,P2) is huge, because, if merge-base of A and P2, is several dozens
of merges (from A, via first parent) below, that D(A,P2) will be diffin=
g
sum of merges from several subsystems to 1 subsystem.

The solution is to avoid computing n 1-parent diffs, and to find
changed-to-all-parents paths via scanning A's and all Pi's trees
simultaneously, at each step comparing their entries, and based on that
comparison, populate paths result, and deduce we could *skip*
*recursing* into subdirectories, if at least for 1 parent, sha1 of that
dir tree is the same as in A. That would save us from doing significant
amount of needless work.

Such approach is very similar to what diff_tree() does, only there we
deal with scanning only 2 trees simultaneously, and for n+1 tree, the
logic is a bit more complex:

    D(A,X1...Xn) calculation scheme
    -------------------------------

    D(A,X1...Xn) =3D D(A,X1) ^ ... ^ D(A,Xn)       (regarding resulting=
 paths set)

         D(A,Xj)         - diff between A..Xj
         D(A,X1...Xn)    - combined diff from A to parents X1,...,Xn

    We start from all trees, which are sorted, and compare their entrie=
s in
    lock-step:

          A     X1       Xn
          -     -        -
         |a|   |x1|     |xn|
         |-|   |--| ... |--|      i =3D argmin(x1...xn)
         | |   |  |     |  |
         |-|   |--|     |--|
         |.|   |. |     |. |
          .     .        .
          .     .        .

    at any time there could be 3 cases:

         1)  a < xi;
         2)  a > xi;
         3)  a =3D xi.

    Schematic deduction of what every case means, and what to do, follo=
ws:

    1)  a < xi  ->  =E2=88=80j a =E2=88=89 Xj  ->  "+a" =E2=88=88 D(A,X=
j)  ->  D +=3D "+a";  a=E2=86=93

    2)  a > xi

        2.1) =E2=88=83j: xj > xi  ->  "-xi" =E2=88=89 D(A,Xj)  ->  D +=3D=
 =C3=B8;  =E2=88=80 xk=3Dxi  xk=E2=86=93
        2.2) =E2=88=80j  xj =3D xi  ->  xj =E2=88=89 A  ->  "-xj" =E2=88=
=88 D(A,Xj)  ->  D +=3D "-xi";  =E2=88=80j xj=E2=86=93

    3)  a =3D xi

        3.1) =E2=88=83j: xj > xi  ->  "+a" =E2=88=88 D(A,Xj)  ->  only =
xk=3Dxi remains to investigate
        3.2) xj =3D xi  ->  investigate =CE=B4(a,xj)
         |
         |
         v

        3.1+3.2) looking at =CE=B4(a,xk) =E2=88=80k: xk=3Dxi - if all !=
=3D =C3=B8  ->

                          =E2=8E=A7=CE=B4(a,xk)  - if xk=3Dxi
                 ->  D +=3D =E2=8E=A8
                          =E2=8E=A9"+a"     - if xk>xi

        in any case a=E2=86=93  =E2=88=80 xk=3Dxi  xk=E2=86=93

~

=46or comparison, here is how diff_tree() works:

    D(A,B) calculation scheme
    -------------------------

        A     B
        -     -
       |a|   |b|    a < b   ->  a =E2=88=89 B   ->   D(A,B) +=3D  +a   =
 a=E2=86=93
       |-|   |-|    a > b   ->  b =E2=88=89 A   ->   D(A,B) +=3D  -b   =
 b=E2=86=93
       | |   | |    a =3D b   ->  investigate =CE=B4(a,b)            a=E2=
=86=93 b=E2=86=93
       |-|   |-|
       |.|   |.|
        .     .
        .     .

=46or now there is a limitation however - for simple scan to work, we h=
ave
to know in advance, a user had not asked for finding rename/copies
detection. At present, if he/she has, we fallback to calling old n
1-parent diffs code. I think that restriction, at least in theory,
could be lifted. I propose we have fast code for at least common case,
and move on incrementally.

Another similar limitation, is that if diffcore transforms which
filter-out paths, are active, we also fallback to old code. The reason
here is pure "technical" - all transforms expect to find paths in
diff_filepair's queue, which applies only to 1-parent case. If needed,
The solution here would be to generalize diff_filepair to
combine_diff_path everywhere, and do not differentiate between plain an=
d
combined diffs (all diffs will be combined with diff(A,B) being
combined diff with only 1 parent), but again, let's move on
incrementally.

I consciously placed trees-scanning code in tree-diff.c, foreseeing dif=
f
and combine-diff merge, and because that code is very similar to
diff_tree - to keep similar codes near.

Timings for `git log --raw --no-abbrev --no-renames` without `-c` ("git=
 log")
and with `-c` ("git log -c") and with `-c --merges` ("git log -c --merg=
es")
before and after the patch are as follows:

                linux.git v3.10..v3.11

            log     log -c     log -c --merges

    before  1.9s   16.6s      15.5s
    after   1.9s    2.4s       1.1s(*)

The result stayed the same.

(*) that 15.5/1.1 =3D ~14.1 ratio, is the most appropriate estimate for
    combine-diff speedup.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 combine-diff.c |  85 +++++++++++-
 diff.c         |   1 +
 diff.h         |   6 +
 tree-diff.c    | 411 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 4 files changed, 498 insertions(+), 5 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 427a7c1..3e3f328 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1305,7 +1305,7 @@ static const char *path_path(void *obj)
=20
=20
 /* find set of paths that every parent touches */
-static struct combine_diff_path *find_paths(const unsigned char *sha1,
+static struct combine_diff_path *find_paths_generic(const unsigned cha=
r *sha1,
 	const struct sha1_array *parents, struct diff_options *opt)
 {
 	struct combine_diff_path *paths =3D NULL;
@@ -1318,6 +1318,7 @@ static struct combine_diff_path *find_paths(const=
 unsigned char *sha1,
 	/* tell diff_tree to emit paths in sorted (=3Dtree) order */
 	opt->orderfile =3D NULL;
=20
+	/* D(A,P1...Pn) =3D D(A,P1) ^ ... ^ D(A,Pn)  (wrt paths) */
 	for (i =3D 0; i < num_parent; i++) {
 		/* show stat against the first parent even
 		 * when doing combined diff.
@@ -1347,6 +1348,35 @@ static struct combine_diff_path *find_paths(cons=
t unsigned char *sha1,
 }
=20
=20
+/*
+ * find set of paths that everybody touches, assuming diff is run with=
out
+ * rename/copy detection, etc, comparing all trees simultaneously (=3D=
 faster).
+ */
+static struct combine_diff_path *find_paths_multitree(
+	const unsigned char *sha1, const struct sha1_array *parents,
+	struct diff_options *opt)
+{
+	int i, nparent =3D parents->nr;
+	const unsigned char **parents_sha1;
+
+	parents_sha1 =3D xmalloc(nparent * sizeof(parents_sha1[0]));
+	for (i =3D 0; i < nparent; i++)
+		parents_sha1[i] =3D parents->sha1[i];
+
+	/* fake list head, so worker can assume it is non-NULL */
+	struct combine_diff_path paths_head;
+	paths_head.next =3D NULL;
+
+	struct strbuf base;
+	strbuf_init(&base, PATH_MAX);
+
+	diff_tree_combined_paths(&paths_head, sha1, parents_sha1, nparent, &b=
ase, opt);
+
+	free(parents_sha1);
+	return paths_head.next;
+}
+
+
 void diff_tree_combined(const unsigned char *sha1,
 			const struct sha1_array *parents,
 			int dense,
@@ -1356,6 +1386,7 @@ void diff_tree_combined(const unsigned char *sha1=
,
 	struct diff_options diffopts;
 	struct combine_diff_path *p, *paths;
 	int i, num_paths, needsep, show_log_first, num_parent =3D parents->nr=
;
+	int need_generic_pathscan;
=20
 	/* nothing to do, if no parents */
 	if (!num_parent)
@@ -1378,11 +1409,55 @@ void diff_tree_combined(const unsigned char *sh=
a1,
=20
 	/* find set of paths that everybody touches
 	 *
-	 * NOTE find_paths() also handles --stat, as it computes
-	 * diff(sha1,parent_i) for all i to do the job, specifically
-	 * for parent0.
+	 * NOTE
+	 *
+	 * Diffcore transformations are bound to diff_filespec and logic
+	 * comparing two entries - i.e. they do not apply directly to combine
+	 * diff.
+	 *
+	 * If some of such transformations is requested - we launch generic
+	 * path scanning, which works significantly slower compared to
+	 * simultaneous all-trees-in-one-go scan in find_paths_multitree().
+	 *
+	 * TODO some of the filters could be ported to work on
+	 * combine_diff_paths - i.e. all functionality that skips paths, so i=
n
+	 * theory, we could end up having only multitree path scanning.
+	 *
+	 * NOTE please keep this semantically in sync with diffcore_std()
 	 */
-	paths =3D find_paths(sha1, parents, &diffopts);
+	need_generic_pathscan =3D opt->skip_stat_unmatch	||
+			DIFF_OPT_TST(opt, FOLLOW_RENAMES)	||
+			opt->break_opt !=3D -1	||
+			opt->detect_rename	||
+			opt->pickaxe		||
+			opt->filter;
+
+
+	if (need_generic_pathscan) {
+		/* NOTE generic case also handles --stat, as it computes
+		 * diff(sha1,parent_i) for all i to do the job, specifically
+		 * for parent0.
+		 */
+		paths =3D find_paths_generic(sha1, parents, &diffopts);
+	}
+	else {
+		paths =3D find_paths_multitree(sha1, parents, &diffopts);
+
+		/* show stat against the first parent even
+		 * when doing combined diff.
+		 */
+		int stat_opt =3D (opt->output_format &
+				(DIFF_FORMAT_NUMSTAT|DIFF_FORMAT_DIFFSTAT));
+		if (stat_opt) {
+			diffopts.output_format =3D stat_opt;
+
+			diff_tree_sha1(parents->sha1[0], sha1, "", &diffopts);
+			diffcore_std(&diffopts);
+			if (opt->orderfile)
+				diffcore_order(opt->orderfile);
+			diff_flush(&diffopts);
+		}
+	}
=20
 	/* find out number of surviving paths */
 	for (num_paths =3D 0, p =3D paths; p; p =3D p->next)
diff --git a/diff.c b/diff.c
index 49e71f4..29ede0b 100644
--- a/diff.c
+++ b/diff.c
@@ -4755,6 +4755,7 @@ void diffcore_fix_diff_index(struct diff_options =
*options)
=20
 void diffcore_std(struct diff_options *options)
 {
+	/* NOTE please keep the following in sync with diff_tree_combined() *=
/
 	if (options->skip_stat_unmatch)
 		diffcore_skip_stat_unmatch(options);
 	if (!options->found_follow) {
diff --git a/diff.h b/diff.h
index a24a767..5496560 100644
--- a/diff.h
+++ b/diff.h
@@ -214,6 +214,12 @@ struct combine_diff_path {
 extern void show_combined_diff(struct combine_diff_path *elem, int num=
_parent,
 			      int dense, struct rev_info *);
=20
+extern
+struct combine_diff_path *diff_tree_combined_paths(
+	struct combine_diff_path *p, const unsigned char *sha1,
+	const unsigned char **parent_sha1, int nparent,
+	struct strbuf *base, struct diff_options *opt);
+
 extern void diff_tree_combined(const unsigned char *sha1, const struct=
 sha1_array *parents, int dense, struct rev_info *rev);
=20
 extern void diff_tree_combined_merge(const struct commit *commit, int =
dense, struct rev_info *rev);
diff --git a/tree-diff.c b/tree-diff.c
index f7b3ade..7f4f917 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -172,6 +172,417 @@ int diff_tree(struct tree_desc *t1, struct tree_d=
esc *t2,
 	return 0;
 }
=20
+
+/*
+ * Compare two tree descriptors, taking into account only path/mode,
+ * but not their sha1's.
+ *
+ * NOTE files and directories *always* compare differently, even when =
having
+ *      the same name - thanks to base_name_compare().
+ *
+ * NOTE empty (=3Dinvalid) descriptor(s) take part in comparison as +i=
nfty.
+ */
+static int tree_desc_pathcmp(struct tree_desc *t1, struct tree_desc *t=
2)
+{
+	const unsigned char *t1_sha1, *t2_sha1;
+	const char *path1, *path2;
+	int path1_len, path2_len;
+	unsigned mode1, mode2;
+	int cmp;
+
+	if (!t1->size)
+		return t2->size ? +1 /* +=E2=88=9E > c */  : 0 /* +=E2=88=9E =3D +=E2=
=88=9E */;
+	else if (!t2->size)
+		return -1;	/* c < +=E2=88=9E */
+
+
+	t1_sha1 =3D tree_entry_extract(t1, &path1, &mode1);
+	t2_sha1 =3D tree_entry_extract(t2, &path2, &mode2);
+
+	path1_len =3D tree_entry_len(&t1->entry);
+	path2_len =3D tree_entry_len(&t2->entry);
+
+	cmp =3D base_name_compare(path1, path1_len, mode1,
+				path2, path2_len, mode2);
+	return cmp;
+}
+
+
+/*
+ * Make a new combine_diff_path from path/mode/sha1
+ * and append it to paths list tail.
+ *
+ * p->parent[] remains uninitialized.
+ */
+static struct combine_diff_path *__path_appendnew(struct combine_diff_=
path *last,
+	int nparent, const struct strbuf *base, const char *path, int pathlen=
,
+	unsigned mode, const unsigned char *sha1)
+{
+	struct combine_diff_path *p;
+	int len =3D base->len + pathlen;
+
+	p =3D xmalloc(combine_diff_path_size(nparent, len));
+	p->next =3D NULL;
+	p->path =3D (char *)&(p->parent[nparent]);
+	memcpy(p->path, base->buf, base->len);
+	memcpy(p->path + base->len, path, pathlen);
+	p->path[len] =3D 0;
+	p->mode =3D mode;
+	hashcpy(p->sha1, sha1);
+
+	last->next =3D p;
+	return p;
+}
+
+/* new path should be added to combine diff
+ *
+ * 3 cases on how/when it should be called and behaves:
+ *
+ *	 t, !tp		-> path added, all parents lack it
+ *	!t,  tp		-> path removed from all parents
+ *	 t,  tp		-> path modified/added
+ *			   (M for tp[i]=3Dtp[imin], A otherwise)
+ */
+static struct combine_diff_path *path_appendnew(struct combine_diff_pa=
th *p,
+	struct strbuf *base, struct diff_options *opt, int nparent,
+	struct tree_desc *t, struct tree_desc *tp,
+	int imin, int *xmin_pathcmpv)
+{
+	int i, isdir, recurse=3D0, emitthis=3D1;
+
+	const unsigned char *sha1;
+	const char *path;
+	int pathlen;
+	unsigned mode;
+
+	/* at least something has to be valid */
+	assert(t || tp);
+
+	if (t) {
+		/* path present in resulting tree */
+		sha1 =3D tree_entry_extract(t, &path, &mode);
+		pathlen =3D tree_entry_len(&t->entry);
+		isdir =3D S_ISDIR(mode);
+	}
+	else {
+		/* a path was removed - take path from imin parent. Also take
+		 * mode from that parent, to decide on recursion(1).
+		 *
+		 * 1) all modes for tp[k]=3Dtp[imin] should be the same wrt
+		 *    S_ISDIR, thanks to base_name_compare().
+		 */
+		tree_entry_extract(&tp[imin], &path, &mode);
+		pathlen =3D tree_entry_len(&tp[imin].entry);
+
+		isdir =3D S_ISDIR(mode);
+		sha1 =3D null_sha1;
+		mode =3D 0;
+	}
+
+
+	if (DIFF_OPT_TST(opt, RECURSIVE) && isdir) {
+		recurse =3D 1;
+		emitthis =3D DIFF_OPT_TST(opt, TREE_IN_RECURSIVE);
+	}
+
+	if (emitthis) {
+		p =3D __path_appendnew(p, nparent, base, path, pathlen, mode, sha1);
+		for (i =3D 0; i < nparent; ++i) {
+			/* tp[i] is valid, if present and if tp[i]=3D=3Dtp[imin] -
+			 * otherwise, we should ignore it.
+			 */
+			int tpi_valid =3D tp && !xmin_pathcmpv[i];
+
+			const unsigned char *sha1_i;
+			unsigned mode_i;
+
+			p->parent[i].status =3D
+				!t ? DIFF_STATUS_DELETED :
+					tpi_valid ?
+						DIFF_STATUS_MODIFIED :
+						DIFF_STATUS_ADDED;
+
+			if (tpi_valid) {
+				sha1_i =3D tp[i].entry.sha1;
+				mode_i =3D canon_mode(tp[i].entry.mode);
+			}
+			else {
+				sha1_i =3D null_sha1;
+				mode_i =3D 0;
+			}
+
+			p->parent[i].mode =3D mode_i;
+			hashcpy(p->parent[i].sha1, sha1_i);
+		}
+	}
+
+	if (recurse) {
+		const unsigned char **parents_sha1;
+		int old_baselen =3D base->len;
+
+		parents_sha1 =3D xmalloc(nparent * sizeof(parents_sha1[0]));
+		for (i =3D 0; i < nparent; ++i) {
+			/* same rule as in emitthis */
+			int tpi_valid =3D tp && !xmin_pathcmpv[i];
+
+			parents_sha1[i] =3D tpi_valid ? tp[i].entry.sha1
+						    : null_sha1;
+		}
+
+		/* base +=3D path+'/' */
+		strbuf_add(base, path, pathlen);
+		strbuf_addch(base, '/');
+
+		p =3D diff_tree_combined_paths(p, sha1, parents_sha1, nparent, base,=
 opt);
+
+		/* restore base */
+		strbuf_setlen(base, old_baselen);
+
+		free(parents_sha1);
+	}
+
+	return p;
+}
+
+
+/* Like fill_tree_descriptor, but returns empty tree_desc for null_sha=
1 */
+static void *xfill_tree_descriptor(struct tree_desc *t, const unsigned=
 char *sha1)
+{
+	if (!is_null_sha1(sha1))
+		return fill_tree_descriptor(t, sha1);
+
+	init_tree_desc(t, NULL, 0);
+	return NULL;
+}
+
+
+/* generate paths for combined diff D(sha1,parents_sha1[])
+ *
+ * The paths are generated scanning new tree and all parents trees
+ * simultaneously, similarly to what diff_tree() does for 2 trees. The=
 theory
+ * behind such scan is as follows:
+ *
+ *
+ * D(A,X1...Xn) calculation scheme
+ * -------------------------------
+ *
+ * D(A,X1...Xn) =3D D(A,X1) ^ ... ^ D(A,Xn)	(regarding resulting paths=
 set)
+ *
+ *	D(A,Xj)		- diff between A..Xj
+ *	D(A,X1...Xn)	- combined diff from A to parents X1,...,Xn
+ *
+ *
+ * We start from all trees, which are sorted, and compare their entrie=
s in
+ * lock-step:
+ *
+ *	 A     X1       Xn
+ *	 -     -        -
+ *	|a|   |x1|     |xn|
+ *	|-|   |--| ... |--|      i =3D argmin(x1...xn)
+ *	| |   |  |     |  |
+ *	|-|   |--|     |--|
+ *	|.|   |. |     |. |
+ *	 .     .        .
+ *	 .     .        .
+ *
+ * at any time there could be 3 cases:
+ *
+ *	1)  a < xi;
+ *	2)  a > xi;
+ *	3)  a =3D xi.
+ *
+ * Schematic deduction of what every case means, and what to do, follo=
ws:
+ *
+ * 1)  a < xi  ->  =E2=88=80j a =E2=88=89 Xj  ->  "+a" =E2=88=88 D(A,X=
j)  ->  D +=3D "+a";  a=E2=86=93
+ *
+ * 2)  a > xi
+ *
+ *     2.1) =E2=88=83j: xj > xi  ->  "-xi" =E2=88=89 D(A,Xj)  ->  D +=3D=
 =C3=B8;  =E2=88=80 xk=3Dxi  xk=E2=86=93
+ *     2.2) =E2=88=80j  xj =3D xi  ->  xj =E2=88=89 A  ->  "-xj" =E2=88=
=88 D(A,Xj)  ->  D +=3D "-xi";  =E2=88=80j xj=E2=86=93
+ *
+ * 3)  a =3D xi
+ *
+ *     3.1) =E2=88=83j: xj > xi  ->  "+a" =E2=88=88 D(A,Xj)  ->  only =
xk=3Dxi remains to investigate
+ *     3.2) xj =3D xi  ->  investigate =CE=B4(a,xj)
+ *      |
+ *      |
+ *      v
+ *
+ *     3.1+3.2) looking at =CE=B4(a,xk) =E2=88=80k: xk=3Dxi - if all !=
=3D =C3=B8  ->
+ *
+ *                       =E2=8E=A7=CE=B4(a,xk)  - if xk=3Dxi
+ *              ->  D +=3D =E2=8E=A8
+ *                       =E2=8E=A9"+a"     - if xk>xi
+ *
+ *
+ *     in any case a=E2=86=93  =E2=88=80 xk=3Dxi  xk=E2=86=93
+ */
+struct combine_diff_path *diff_tree_combined_paths(
+	struct combine_diff_path *p, const unsigned char *sha1,
+	const unsigned char **parents_sha1, int nparent,
+	struct strbuf *base, struct diff_options *opt)
+{
+	struct tree_desc t, *tp;
+	void *ttree, **tptree;
+	int *xmin_pathcmpv;	/* [i] =3D pathcmp(tp[i], tp[imin]) */
+	int i;
+
+	tp     =3D xmalloc(nparent * sizeof(tp[0]));
+	tptree =3D xmalloc(nparent * sizeof(tptree[0]));
+
+	ttree =3D xfill_tree_descriptor(&t, sha1);
+	for (i =3D 0; i < nparent; i++)
+		tptree[i] =3D xfill_tree_descriptor(&tp[i], parents_sha1[i]);
+
+	xmin_pathcmpv =3D xmalloc(nparent * sizeof(xmin_pathcmpv[0]));
+
+	/* Enable recursion indefinitely */
+	opt->pathspec.recursive =3D DIFF_OPT_TST(opt, RECURSIVE);
+
+	for (;;) {
+		int imin, xmin_eqtotal, cmp, alldifferent;
+		int a_next, tp_next;
+		const unsigned char *entry_sha1;
+		const char *path;
+		unsigned mode;
+
+
+		/* TODO Something similiar to if diff_can_quit_early -> break */
+
+		if (opt->pathspec.nr) {
+			skip_uninteresting(&t, base, opt);
+			for (i =3D 0; i < nparent; i++)
+				skip_uninteresting(&tp[i], base, opt);
+		}
+
+		/* comparing is finished when all trees are done */
+		if (!t.size) {
+			int done =3D 1;
+			for (i =3D 0; i < nparent; ++i)
+				if (tp[i].size) {
+					done =3D 0;
+					break;
+				}
+			if (done)
+				break;
+		}
+
+
+
+		/* lookup imin =3D argmin(x1...xn),  build X compare vector along th=
e way */
+		imin =3D 0;		/* argmin(x1...xn)	*/
+		xmin_eqtotal =3D 1;	/* len([xk: xk=3Dximin])	*/
+		xmin_pathcmpv[0] =3D 0;
+
+		for (i =3D 1; i < nparent; ++i) {
+			cmp =3D tree_desc_pathcmp(&tp[i], &tp[imin]);
+			if (cmp =3D=3D -1) {
+				imin =3D i;
+				xmin_eqtotal =3D 1;
+				xmin_pathcmpv[i] =3D 0;
+			}
+			else {
+				xmin_pathcmpv[i] =3D cmp;
+				if (cmp =3D=3D 0)
+					xmin_eqtotal++;
+			}
+		}
+
+		/* fixup compare vector for entries before imin */
+		for (i =3D 0; i < imin; ++i)
+			xmin_pathcmpv[i] =3D +1;	/* x[i] > x[imin] */
+
+
+		/* what tree entries will we update, in the end of this step? */
+		a_next  =3D 0;	/* a */
+		tp_next =3D 0;	/* tp[k: xk=3Dxmin] */
+
+
+		/* compare a vs x[imin] */
+		cmp =3D tree_desc_pathcmp(&t, &tp[imin]);
+
+		switch (cmp) {
+		/* a < xi */
+		case -1:
+			/* D +=3D "+a" */
+			p =3D path_appendnew(p, base, opt, nparent,
+					&t, /*tp=3D*/NULL, -1, NULL);
+
+			/* a=E2=86=93 */
+			a_next =3D 1;
+			break;
+
+
+		/* a > xi */
+		case +1:
+			/* =E2=88=80j xj=3Dximin -> D +=3D "-xi" */
+			if (xmin_eqtotal =3D=3D nparent)
+				p =3D path_appendnew(p, base, opt, nparent,
+					/*t=3D*/NULL, tp, imin, xmin_pathcmpv);
+
+			/* =E2=88=80 xk=3Dximin  xk=E2=86=93 */
+			tp_next =3D 1;
+			break;
+
+
+		/* a =3D xi */
+		case 0:
+			/* are either xk > xi or diff(a,xk) !=3D =C3=B8 ? */
+			alldifferent =3D 1;
+			entry_sha1 =3D tree_entry_extract(&t, &path, &mode);
+			for (i =3D 0; i < nparent; i++) {
+				const unsigned char *sha1_i;
+				const char *path_i;
+				unsigned mode_i;
+
+				/* x[i] > x[imin] */
+				if (xmin_pathcmpv[i])
+					continue;
+
+				/* diff(a,xk) !=3D =C3=B8 */
+				sha1_i =3D tree_entry_extract(&tp[i], &path_i, &mode_i);
+				if (hashcmp(entry_sha1, sha1_i) || (mode !=3D mode_i))
+					continue;
+
+				alldifferent =3D 0;
+				break;
+			}
+
+			/* D +=3D {=CE=B4(a,xk) if xk=3Dxi;  "+a" if xk > xi} */
+			if (alldifferent)
+				p =3D path_appendnew(p, base, opt, nparent,
+						&t, tp, imin, xmin_pathcmpv);
+
+			/* a=E2=86=93,  =E2=88=80 xk=3Dximin  xk=E2=86=93 */
+			a_next  =3D 1;
+			tp_next =3D 1;
+			break;
+		}
+
+		/* perform scheduled tree entries updates: */
+		if (a_next)
+			/* a=E2=86=93 */
+			update_tree_entry(&t);
+
+		if (tp_next)
+			/* =E2=88=80 xk=3Dxi  xk=E2=86=93 */
+			for (i =3D 0; i < nparent; ++i)
+				if (!xmin_pathcmpv[i])
+					update_tree_entry(&tp[i]);
+	}
+
+	free(xmin_pathcmpv);
+	for (i =3D nparent-1; i >=3D 0; i--)
+		free(tptree[i]);
+	free(ttree);
+	free(tptree);
+	free(tp);
+
+	return p;
+}
+
+
+
 /*
  * Does it look like the resulting diff might be due to a rename?
  *  - single entry
--=20
1.9.rc1.181.g641f458
