From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: [PATCH 7/8] combine-diff: Fast changed-to-all-parents paths
 scanning
Date: Tue, 4 Feb 2014 20:34:00 +0400
Organization: Marine Bridge & Navigation Systems
Message-ID: <20140204163400.GA20436@tugrik.mns.mnsspb.ru>
References: <cover.1391430523.git.kirr@mns.spb.ru>
 <c0ad49d850377aedffa0a593fef8738112019b01.1391430523.git.kirr@mns.spb.ru>
 <xmqqk3dbbwwf.fsf@gitster.dls.corp.google.com>
 <xmqqeh3jbwbt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 04 17:33:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAivn-0004To-TT
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 17:33:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754671AbaBDQca convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Feb 2014 11:32:30 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:37813 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753823AbaBDQcP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 11:32:15 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WAiuv-0002mw-BJ; Tue, 04 Feb 2014 20:32:09 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WAiwi-0005Ke-Pg; Tue, 04 Feb 2014 20:34:00 +0400
Content-Disposition: inline
In-Reply-To: <xmqqeh3jbwbt.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241531>

On Mon, Feb 03, 2014 at 03:39:02PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > Kirill Smelkov <kirr@mns.spb.ru> writes:
> >
> >> As was recently shown (c839f1bd "combine-diff: optimize
> >> combine_diff_path sets intersection"), combine-diff runs very slow=
ly. In
> >> that commit we optimized paths sets intersection, but that account=
ed
> >> only for ~ 25% of the slowness, and as my tracing showed, for linu=
x.git
> >> v3.10..v3.11, for merges a lot of time is spent computing
> >> diff(commit,commit^2) just to only then intersect that huge diff t=
o
> >> almost small set of files from diff(commit,commit^1).
> >>
> >> That's because at present, to compute combine-diff, for first find=
ing
> >> paths, that "every parent touches", we use the following combine-d=
iff
> >> property/definition:
> >>
> >>     D(A,P1...Pn) =3D D(A,P1) ^ ... ^ D(A,Pn)      (w.r.t. paths)
> >>
> >> where
> >>
> >>     D(A,P1...Pn) is combined diff between commit A, and parents Pi
> >>
> >> and
> >>
> >>     D(A,Pi) is usual two-tree diff Pi..A
> >
> > and A ^ B means what???
>=20
> Silly me; obviously it is the "set intersection" operator.
>=20
> We probably could instead use the "current" set of paths as literal
> pathspec to compute subsequent paths, i.e.
>=20
> 	D(A,Pi,PS) is two tree diff P1..A limited to paths PS
>=20
> 	D(A,P1...Pn) =3D D(A,P1,[]) ^
>         	       D(A,P2,D(A,P1,[])) ^
>                        ...
>         	       D(A,Pn,D(A,P1...Pn-1))
>=20
> if we did not want to reinvent the whole tree walking thing, which
> would add risks for new bugs and burden to maintain this and the
> usual two-tree diff tree walking in sync.

Junio, I understand it is not good to duplicate code and increase
maintenance risks. On the other hand, I don't quite like the approach
with keeping current paths - it could work and be faster compared to
what we had, but to me it is still suboptimal, because if the first dif=
f
D(A,P1) is huge then oops. Also, to implement it rationally, without
delving into unneeded recursion, we would need to do the diffing withou=
t
recursion, intersect results, and then recurse into overlapping subtree=
s,
which means tree-walker rework anyway.


Instead I propose we switch to the new tree walker completely. With the
attached patch which draftly shows it (diff_tree is gone, the work is
done through diff_tree_combined_paths, and then the result is
"exported" to diff_filepairs) all the tests pass. Also, timings for

    git log --raw --no-abbrev --no-renames
   =20
    ( without -c - it would be the same - we are not touching that code=
, it
      would only add, irrelevant-to-the-change constant time )

are

    linux.git   v3.10..v3.11    became 0.1% _faster_
    navy.git                    became 1.4% slower


That means, that the new tree-walker is correct and should be ok
performance-wise (I had not optimized it at all, yet).

What would you say?

Thanks,
Kirill

P.S. Thanks for commenting on other patches. I'll try to correct them
tomorrow, as I have no more time today and need to run.


---- 8< ----
=46rom: Kirill Smelkov <kirr@mns.spb.ru>
Date: Tue, 4 Feb 2014 20:11:16 +0400
Subject: [PATCH] X Show new tree-walker could be used instead of the ol=
d one

All tests pass. Timings for git log --raw --no-abrev --no-renames

    linux.git   v3.10..v3.11    became 0.1% _faster_
    navy.git                    became 1.4% slower
---
 diff.h      |  2 ++
 line-log.c  | 12 +++++++--
 revision.c  | 16 ++++++-----
 tree-diff.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++------=
--------
 4 files changed, 90 insertions(+), 28 deletions(-)

diff --git a/diff.h b/diff.h
index 5496560..0a9845a 100644
--- a/diff.h
+++ b/diff.h
@@ -189,8 +189,10 @@ const char *diff_line_prefix(struct diff_options *=
);
=20
 extern const char mime_boundary_leader[];
=20
+#if 0
 extern int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
 		     const char *base, struct diff_options *opt);
+#endif
 extern int diff_tree_sha1(const unsigned char *old, const unsigned cha=
r *new,
 			  const char *base, struct diff_options *opt);
 extern int diff_root_tree_sha1(const unsigned char *new, const char *b=
ase,
diff --git a/line-log.c b/line-log.c
index 717638b..5739bbf 100644
--- a/line-log.c
+++ b/line-log.c
@@ -766,6 +766,7 @@ void line_log_init(struct rev_info *rev, const char=
 *prefix, struct string_list
 	}
 }
=20
+#if 0
 static void load_tree_desc(struct tree_desc *desc, void **tree,
 			   const unsigned char *sha1)
 {
@@ -775,6 +776,7 @@ static void load_tree_desc(struct tree_desc *desc, =
void **tree,
 		die("Unable to read tree (%s)", sha1_to_hex(sha1));
 	init_tree_desc(desc, *tree, size);
 }
+#endif
=20
 static int count_parents(struct commit *commit)
 {
@@ -843,17 +845,23 @@ static void queue_diffs(struct line_log_data *ran=
ge,
 			struct commit *commit, struct commit *parent)
 {
 	void *tree1 =3D NULL, *tree2 =3D NULL;
-	struct tree_desc desc1, desc2;
+//	struct tree_desc desc1, desc2;
=20
 	assert(commit);
+#if 0
 	load_tree_desc(&desc2, &tree2, commit->tree->object.sha1);
 	if (parent)
 		load_tree_desc(&desc1, &tree1, parent->tree->object.sha1);
 	else
 		init_tree_desc(&desc1, "", 0);
+#endif
=20
 	DIFF_QUEUE_CLEAR(&diff_queued_diff);
-	diff_tree(&desc1, &desc2, "", opt);
+//	diff_tree(&desc1, &desc2, "", opt);
+	diff_tree_sha1(parent ? parent->tree->object.sha1 : null_sha1,
+			commit->tree->object.sha1, "", opt);
+
+
 	if (opt->detect_rename) {
 		filter_diffs_for_paths(range, 1);
 		if (diff_might_be_rename())
diff --git a/revision.c b/revision.c
index 18ec339..ecc250b 100644
--- a/revision.c
+++ b/revision.c
@@ -496,24 +496,28 @@ static int rev_compare_tree(struct rev_info *revs=
,
 static int rev_same_tree_as_empty(struct rev_info *revs, struct commit=
 *commit)
 {
 	int retval;
-	void *tree;
-	unsigned long size;
-	struct tree_desc empty, real;
+//	void *tree;
+//	unsigned long size;
+//	struct tree_desc empty, real;
 	struct tree *t1 =3D commit->tree;
=20
 	if (!t1)
 		return 0;
=20
+#if 0
 	tree =3D read_object_with_reference(t1->object.sha1, tree_type, &size=
, NULL);
 	if (!tree)
-		return 0;
+		return 0;	// XXX ok?
 	init_tree_desc(&real, tree, size);
 	init_tree_desc(&empty, "", 0);
+#endif
=20
 	tree_difference =3D REV_TREE_SAME;
 	DIFF_OPT_CLR(&revs->pruning, HAS_CHANGES);
-	retval =3D diff_tree(&empty, &real, "", &revs->pruning);
-	free(tree);
+//	retval =3D diff_tree(&empty, &real, "", &revs->pruning);
+	retval =3D diff_tree_sha1(null_sha1, t1->object.sha1, "", &revs->prun=
ing);
+
+//	free(tree);
=20
 	return retval >=3D 0 && (tree_difference =3D=3D REV_TREE_SAME);
 }
diff --git a/tree-diff.c b/tree-diff.c
index 7f4f917..9f2a69b 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -6,6 +6,7 @@
 #include "diffcore.h"
 #include "tree.h"
=20
+#if 0
 static void show_entry(struct diff_options *opt, const char *prefix,
 		       struct tree_desc *desc, struct strbuf *base);
=20
@@ -106,6 +107,7 @@ static void show_entry(struct diff_options *opt, co=
nst char *prefix,
=20
 	strbuf_setlen(base, old_baselen);
 }
+#endif
=20
 static void skip_uninteresting(struct tree_desc *t, struct strbuf *bas=
e,
 			       struct diff_options *opt)
@@ -123,6 +125,7 @@ static void skip_uninteresting(struct tree_desc *t,=
 struct strbuf *base,
 	}
 }
=20
+#if 0
 int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
 	      const char *base_str, struct diff_options *opt)
 {
@@ -171,6 +174,7 @@ int diff_tree(struct tree_desc *t1, struct tree_des=
c *t2,
 	strbuf_release(&base);
 	return 0;
 }
+#endif
=20
=20
 /*
@@ -529,23 +533,25 @@ struct combine_diff_path *diff_tree_combined_path=
s(
 		case 0:
 			/* are either xk > xi or diff(a,xk) !=3D =C3=B8 ? */
 			alldifferent =3D 1;
-			entry_sha1 =3D tree_entry_extract(&t, &path, &mode);
-			for (i =3D 0; i < nparent; i++) {
-				const unsigned char *sha1_i;
-				const char *path_i;
-				unsigned mode_i;
-
-				/* x[i] > x[imin] */
-				if (xmin_pathcmpv[i])
-					continue;
-
-				/* diff(a,xk) !=3D =C3=B8 */
-				sha1_i =3D tree_entry_extract(&tp[i], &path_i, &mode_i);
-				if (hashcmp(entry_sha1, sha1_i) || (mode !=3D mode_i))
-					continue;
-
-				alldifferent =3D 0;
-				break;
+			if (!DIFF_OPT_TST(opt, FIND_COPIES_HARDER)) {
+				entry_sha1 =3D tree_entry_extract(&t, &path, &mode);
+				for (i =3D 0; i < nparent; i++) {
+					const unsigned char *sha1_i;
+					const char *path_i;
+					unsigned mode_i;
+
+					/* x[i] > x[imin] */
+					if (xmin_pathcmpv[i])
+						continue;
+
+					/* diff(a,xk) !=3D =C3=B8 */
+					sha1_i =3D tree_entry_extract(&tp[i], &path_i, &mode_i);
+					if (hashcmp(entry_sha1, sha1_i) || (mode !=3D mode_i))
+						continue;
+
+					alldifferent =3D 0;
+					break;
+				}
 			}
=20
 			/* D +=3D {=CE=B4(a,xk) if xk=3Dxi;  "+a" if xk > xi} */
@@ -594,7 +600,8 @@ static inline int diff_might_be_rename(void)
 		!DIFF_FILE_VALID(diff_queued_diff.queue[0]->one);
 }
=20
-static void try_to_follow_renames(struct tree_desc *t1, struct tree_de=
sc *t2, const char *base, struct diff_options *opt)
+//static void try_to_follow_renames(struct tree_desc *t1, struct tree_=
desc *t2, const char *base, struct diff_options *opt)
+static void try_to_follow_renames(const unsigned char *sha1_old, const=
 unsigned char *sha1_new, const char *base, struct diff_options *opt)
 {
 	struct diff_options diff_opts;
 	struct diff_queue_struct *q =3D &diff_queued_diff;
@@ -632,7 +639,8 @@ static void try_to_follow_renames(struct tree_desc =
*t1, struct tree_desc *t2, co
 	diff_opts.break_opt =3D opt->break_opt;
 	diff_opts.rename_score =3D opt->rename_score;
 	diff_setup_done(&diff_opts);
-	diff_tree(t1, t2, base, &diff_opts);
+//	diff_tree(t1, t2, base, &diff_opts);
+	diff_tree_sha1(sha1_old, sha1_new, base, &diff_opts);
 	diffcore_std(&diff_opts);
 	free_pathspec(&diff_opts.pathspec);
=20
@@ -693,11 +701,13 @@ static void try_to_follow_renames(struct tree_des=
c *t1, struct tree_desc *t2, co
=20
 int diff_tree_sha1(const unsigned char *old, const unsigned char *new,=
 const char *base, struct diff_options *opt)
 {
+#if 0
 	void *tree1, *tree2;
 	struct tree_desc t1, t2;
 	unsigned long size1, size2;
 	int retval;
=20
+	// TODO use xfill_tree_descriptor
 	tree1 =3D read_object_with_reference(old, tree_type, &size1, NULL);
 	if (!tree1)
 		die("unable to read source tree (%s)", sha1_to_hex(old));
@@ -707,23 +717,60 @@ int diff_tree_sha1(const unsigned char *old, cons=
t unsigned char *new, const cha
 	init_tree_desc(&t1, tree1, size1);
 	init_tree_desc(&t2, tree2, size2);
 	retval =3D diff_tree(&t1, &t2, base, opt);
+#endif
+	struct combine_diff_path phead, *p, *pprev;
+	phead.next =3D NULL;
+
+	struct strbuf basebuf;
+	strbuf_init(&basebuf, PATH_MAX);
+	strbuf_addstr(&basebuf, base);
+
+	const unsigned char *parents_sha1[1] =3D {new};
+
+	diff_tree_combined_paths(&phead, old, parents_sha1, 1, &basebuf, opt)=
;
+
+	strbuf_release(&basebuf);
+
+	// paths -> diff_q
+	for (p =3D phead.next; p;) {
+		struct combine_diff_parent *p0 =3D &p->parent[0];
+		opt->change(opt, p->mode, p0->mode, p->sha1, p0->sha1,
+			p->mode !=3D 0, p0->mode !=3D 0,
+			p->path, 0, 0);
+
+		pprev =3D p;
+		p =3D p->next;
+		free(pprev);
+	}
+
 	if (!*base && DIFF_OPT_TST(opt, FOLLOW_RENAMES) && diff_might_be_rena=
me()) {
+#if 0
 		init_tree_desc(&t1, tree1, size1);
 		init_tree_desc(&t2, tree2, size2);
 		try_to_follow_renames(&t1, &t2, base, opt);
+#endif
+		try_to_follow_renames(old, new, base, opt);
 	}
+#if 0
 	free(tree1);
 	free(tree2);
-	return retval;
+#endif
+//	return retval;
+	return 0;
 }
=20
 int diff_root_tree_sha1(const unsigned char *new, const char *base, st=
ruct diff_options *opt)
 {
+#if 0
 	int retval;
 	void *tree;
 	unsigned long size;
 	struct tree_desc empty, real;
+#endif
=20
+	return diff_tree_sha1(null_sha1, new, base, opt);
+
+#if 0
 	tree =3D read_object_with_reference(new, tree_type, &size, NULL);
 	if (!tree)
 		die("unable to read root tree (%s)", sha1_to_hex(new));
@@ -733,4 +780,5 @@ int diff_root_tree_sha1(const unsigned char *new, c=
onst char *base, struct diff_
 	retval =3D diff_tree(&empty, &real, base, opt);
 	free(tree);
 	return retval;
+#endif
 }
--=20
1.9.rc1.181.g641f458
