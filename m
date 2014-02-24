From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH v2 18/19] tree-diff: rework diff_tree() to generate diffs for multiparent cases as well
Date: Mon, 24 Feb 2014 20:21:50 +0400
Message-ID: <7b307610fe214f47643a46b3e815487558db244e.1393257006.git.kirr@mns.spb.ru>
References: <cover.1393257006.git.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 17:22:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHyIc-0004bE-OP
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 17:22:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbaBXQWT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Feb 2014 11:22:19 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:34303 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752532AbaBXQWP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 11:22:15 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WHyIH-00041H-LY; Mon, 24 Feb 2014 20:22:13 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WHyJw-0007AK-R3; Mon, 24 Feb 2014 20:23:56 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
In-Reply-To: <cover.1393257006.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1393257006.git.kirr@mns.spb.ru>
References: <cover.1393257006.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242609>

Previously diff_tree(), which is now named __diff_tree_sha1(), was
generating diff_filepair(s) for two trees t1 and t2, and that was
usually used for a commit as t1=3DHEAD~, and t2=3DHEAD - i.e. to see ch=
anges
a commit introduces.

In Git, however, we have fundamentally built flexibility in that a
commit can have many parents - 1 for a plain commit, 2 for a simple mer=
ge,
but also more than 2 for merging several heads at once.

=46or merges there is a so called combine-diff, which shows diff, a mer=
ge
introduces by itself, omitting changes done by any parent. That works
through first finding paths, that are different to all parents, and the=
n
showing generalized diff, with separate columns for +/- for each parent=
=2E
The code lives in combine-diff.c .

There is an impedance mismatch, however, in that a commit could
generally have any number of parents, and that while diffing trees, we
divide cases for 2-tree diffs and more-than-2-tree diffs. I mean there
is no special casing for multiple parents commits in e.g.
revision-walker .

That impedance mismatch *hurts* *performance* *badly* for generating
combined diffs - in "combine-diff: optimize combine_diff_path
sets intersection" I've already removed some slowness from it, but from
the timings provided there, it could be seen, that combined diffs still
cost more than an order of magnitude more cpu time, compared to diff fo=
r
usual commits, and that would only be an optimistic estimate, if we tak=
e
into account that for e.g. linux.git there is only one merge for severa=
l
dozens of plain commits.

That slowness comes from the fact that currently, while generating
combined diff, a lot of time is spent computing diff(commit,commit^2)
just to only then intersect that huge diff to almost small set of files
from diff(commit,commit^1).

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

D(A,X1...Xn) =3D D(A,X1) ^ ... ^ D(A,Xn)       (regarding resulting pat=
hs set)

     D(A,Xj)         - diff between A..Xj
     D(A,X1...Xn)    - combined diff from A to parents X1,...,Xn

We start from all trees, which are sorted, and compare their entries in
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

Schematic deduction of what every case means, and what to do, follows:

1)  a < xi  ->  =E2=88=80j a =E2=88=89 Xj  ->  "+a" =E2=88=88 D(A,Xj)  =
->  D +=3D "+a";  a=E2=86=93

2)  a > xi

    2.1) =E2=88=83j: xj > xi  ->  "-xi" =E2=88=89 D(A,Xj)  ->  D +=3D =C3=
=B8;  =E2=88=80 xk=3Dxi  xk=E2=86=93
    2.2) =E2=88=80j  xj =3D xi  ->  xj =E2=88=89 A  ->  "-xj" =E2=88=88=
 D(A,Xj)  ->  D +=3D "-xi";  =E2=88=80j xj=E2=86=93

3)  a =3D xi

    3.1) =E2=88=83j: xj > xi  ->  "+a" =E2=88=88 D(A,Xj)  ->  only xk=3D=
xi remains to investigate
    3.2) xj =3D xi  ->  investigate =CE=B4(a,xj)
     |
     |
     v

    3.1+3.2) looking at =CE=B4(a,xk) =E2=88=80k: xk=3Dxi - if all !=3D =
=C3=B8  ->

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
   |a|   |b|    a < b   ->  a =E2=88=89 B   ->   D(A,B) +=3D  +a    a=E2=
=86=93
   |-|   |-|    a > b   ->  b =E2=88=89 A   ->   D(A,B) +=3D  -b    b=E2=
=86=93
   | |   | |    a =3D b   ->  investigate =CE=B4(a,b)            a=E2=86=
=93 b=E2=86=93
   |-|   |-|
   |.|   |.|
    .     .
    .     .

~~~~~~~~

This patch generalizes diff tree-walker to work with arbitrary number o=
f
parents as described above - i.e. now there is a resulting tree t, and
some parents trees tp[i] i=3D[0..nparent). The generalization builds on
the fact that usual diff

D(A,B)

is by definition the same as combined diff

D(A,[B]),

so if we could rework the code for common case and make it be not slowe=
r
for nparent=3D1 case, usual diff(t1,t2) generation will not be slower, =
and
multiparent diff tree-walker would greatly benefit generating
combine-diff.

What we do is as follows:

1) diff tree-walker __diff_tree_sha1() is internally reworked to be
   a paths generator (new name diff_tree_paths()), with each generated =
path
   being `struct combine_diff_path` with info for path, new sha1,mode a=
nd for
   every parent which sha1,mode it was in it.

2) From that info, we can still generate usual diff queue with
   struct diff_filepairs, via "exporting" generated
   combine_diff_path, if we know we run for nparent=3D1 case.
   (see emit_diff() which is now named emit_diff_first_parent_only())

3) In order for diff_can_quit_early(), which checks

       DIFF_OPT_TST(opt, HAS_CHANGES))

   to work, that exporting have to be happening not in bulk, but
   incrementally, one diff path at a time.

   For such consumers, there is a new callback in diff_options
   introduced:

       ->pathchange(opt, struct combine_diff_path *)

   which, if set to !NULL, is called for every generated path.

   (see new compat __diff_tree_sha1() wrapper around new paths
    generator for setup)

4) The paths generation itself, is reworked from previous
   __diff_tree_sha1() code according to "D(A,X1...Xn) calculation
   scheme" provided above:

   On the start we allocate [nparent] arrays in place what was
   earlier just for one parent tree.

   then we just generalize loops, and comparison according to the
   algorithm.

Some notes(*):

1) alloca(), for small arrays, is used for "runs not slower for
   nparent=3D1 case than before" goal - if we change it to xmalloc()/fr=
ee()
   the timings get ~1% worse. For alloca() we use just-introduced
   xalloca/xalloca_free compatibility wrappers, so it should not be a
   portability problem.

2) For every parent tree, we need to keep a tag, whether entry from tha=
t
   parent equals to entry from minimal parent. For performance reasons =
I'm
   keeping that tag in entry's mode field in unused bit - see S_IFXMIN_=
NEQ.
   Not doing so, we'd need to alloca another [nparent] array, which hur=
ts
   performance.

3) For emitted paths, memory could be reused, if we know the path was
   processed via callback and will not be needed later. We use efficien=
t
   hand-made realloc-style __path_appendnew(), that saves us from ~1-1.=
5%
   of potential additional slowdown.

4) goto(s) are used in several places, as the code executes a little bi=
t
   faster with lowered register pressure.

Also

- we should now check for FIND_COPIES_HARDER not only when two entries
  names are the same, and their hashes are equal, but also for a case,
  when a path was removed from some of all parents having it.

  The reason is, if we don't, that path won't be emitted at all (see
  "a > xi" case), and we'll just skip it, and FIND_COPIES_HARDER wants
  all paths - with diff or without - to be emitted, to be later analyze=
d
  for being copies sources.

  The new check is only necessary for nparent >1, as for nparent=3D1 ca=
se
  xmin_eqtotal always =3D1 =3Dnparent, and a path is always added to di=
ff as
  removal.

~~~~~~~~

Timings for

    # without -c, i.e. testing only nparent=3D1 case
    `git log --raw --no-abbrev --no-renames`

before and after the patch are as follows:

                navy.git        linux.git v3.10..v3.11

    before      0.611s          1.889s
    after       0.619s          1.907s
    slowdown    1.3%            0.9%

This timings show we did no harm to usual diff(tree1,tree2) generation.
=46rom the table we can see that we actually did ~1% slowdown, but I th=
ink
I've "earned" that 1% in the previous patch ("tree-diff: reuse base
str(buf) memory on sub-tree recursion", HEAD~~) so for nparent=3D1 case=
,
net timings stays approximately the same.

The output also stayed the same.

(*) If we revert 1)-4) to more usual techniques, for nparent=3D1 case,
    we'll get ~2-2.5% of additional slowdown, which I've tried to avoid=
, as
   "do no harm for nparent=3D1 case" rule.

=46or linux.git, combined diff will run an order of magnitude faster an=
d
appropriate timings will be provided in the next commit, as we'll be
taking advantage of the new diff tree-walker for combined-diff
generation there.

P.S. and combined diff is not some exotic/for-play-only stuff - for
example for a program I write to represent Git archives as readonly
filesystem, there is initial scan with

    `git log --reverse --raw --no-abbrev --no-renames -c`

to extract log of what was created/changed when, as a result building a
map

    {}  sha1    ->  in which commit (and date) a content was added

that `-c` means also show combined diff for merges, and without them, i=
f
a merge is non-trivial (merges changes from two parents with both havin=
g
separate changes to a file), or an evil one, the map will not be full,
i.e. some valid sha1 would be absent from it.

That case was my initial motivation for combined diffs speedup.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---

Changes since v1:

- fixed last-minute thinko/bug last time introduced on my side (sorry) =
with
  opt->pathchange manipulation in __diff_tree_sha1() - we were forgetti=
ng to
  restore opt->pathchange, which led to incorrect log -c (merges _and_ =
plain
  diff-tree) output;

  This time, I've verified several times, log output stays really the s=
ame.

- direct use of alloca() changed to portability wrappers xalloca/xalloc=
a_free
  which gracefully degrade to xmalloc/free on systems, where alloca is =
not
  available (see new patch 17).

- "i =3D 0; do { ... } while (++i < nparent)" is back to usual looping
  "for (i =3D 0; i < nparent; ++)", as I've re-measured timings and the
  difference is negligible.

  ( Initially, when I was fighting for every cycle it made sense, but r=
eal
    no-slowdown turned out to be related to avoiding mallocs, load tree=
s in correct
    order and reducing register pressure. )

- S_IFXMIN_NEQ definition moved out to cache.h, to have all modes regis=
try in one place;


- p0 -> first_parent; corrected comments about how emit_diff_first_pare=
nt_only
  behaves;


not changed:

- low-level helpers are still named with "__" prefix as, imho, that is =
the best
  convention to name such helpers, without sacrificing signal/noise rat=
io. All
  of them are now static though.

 cache.h     |  15 ++
 diff.c      |   1 +
 diff.h      |  10 ++
 tree-diff.c | 508 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
--------
 4 files changed, 471 insertions(+), 63 deletions(-)

diff --git a/cache.h b/cache.h
index dc040fb..e7f5a0c 100644
--- a/cache.h
+++ b/cache.h
@@ -75,6 +75,21 @@ unsigned long git_deflate_bound(git_zstream *, unsig=
ned long);
 #define S_ISGITLINK(m)	(((m) & S_IFMT) =3D=3D S_IFGITLINK)
=20
 /*
+ * Some mode bits are also used internally for computations.
+ *
+ * They *must* not overlap with any valid modes, and they *must* not b=
e emitted
+ * to outside world - i.e. appear on disk or network. In other words, =
it's just
+ * temporary fields, which we internally use, but they have to stay in=
-house.
+ *
+ * ( such approach is valid, as standard S_IF* fits into 16 bits, and =
in Git
+ *   codebase mode is `unsigned int` which is assumed to be at least 3=
2 bits )
+ */
+
+/* used internally in tree-diff */
+#define S_DIFFTREE_IFXMIN_NEQ	0x80000000
+
+
+/*
  * Intensive research over the course of many years has shown that
  * port 9418 is totally unused by anything else. Or
  *
diff --git a/diff.c b/diff.c
index 8e4a6a9..cda4aa8 100644
--- a/diff.c
+++ b/diff.c
@@ -3216,6 +3216,7 @@ void diff_setup(struct diff_options *options)
 	options->context =3D diff_context_default;
 	DIFF_OPT_SET(options, RENAME_EMPTY);
=20
+	/* pathchange left =3DNULL by default */
 	options->change =3D diff_change;
 	options->add_remove =3D diff_addremove;
 	options->use_color =3D diff_use_color_default;
diff --git a/diff.h b/diff.h
index 5d7b9f7..732dca7 100644
--- a/diff.h
+++ b/diff.h
@@ -15,6 +15,10 @@ struct diff_filespec;
 struct userdiff_driver;
 struct sha1_array;
 struct commit;
+struct combine_diff_path;
+
+typedef int (*pathchange_fn_t)(struct diff_options *options,
+		 struct combine_diff_path *path);
=20
 typedef void (*change_fn_t)(struct diff_options *options,
 		 unsigned old_mode, unsigned new_mode,
@@ -157,6 +161,7 @@ struct diff_options {
 	int close_file;
=20
 	struct pathspec pathspec;
+	pathchange_fn_t pathchange;
 	change_fn_t change;
 	add_remove_fn_t add_remove;
 	diff_format_fn_t format_callback;
@@ -189,6 +194,11 @@ const char *diff_line_prefix(struct diff_options *=
);
=20
 extern const char mime_boundary_leader[];
=20
+extern
+struct combine_diff_path *diff_tree_paths(
+	struct combine_diff_path *p, const unsigned char *sha1,
+	const unsigned char **parent_sha1, int nparent,
+	struct strbuf *base, struct diff_options *opt);
 extern int diff_tree_sha1(const unsigned char *old, const unsigned cha=
r *new,
 			  const char *base, struct diff_options *opt);
 extern int diff_root_tree_sha1(const unsigned char *new, const char *b=
ase,
diff --git a/tree-diff.c b/tree-diff.c
index c76821d..b682d77 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -7,6 +7,22 @@
 #include "tree.h"
=20
 /*
+ * internal mode marker, saying a tree entry !=3D entry of tp[imin]
+ * (see __diff_tree_paths for what it means there)
+ *
+ * we will update/use/emit entry for diff only with it unset.
+ */
+#define S_IFXMIN_NEQ	S_DIFFTREE_IFXMIN_NEQ
+
+
+static struct combine_diff_path *__diff_tree_paths(
+	struct combine_diff_path *p, const unsigned char *sha1,
+	const unsigned char **parents_sha1, int nparent,
+	struct strbuf *base, struct diff_options *opt);
+static int __diff_tree_sha1(const unsigned char *old, const unsigned c=
har *new,
+			    struct strbuf *base, struct diff_options *opt);
+
+/*
  * Compare two tree entries, taking into account only path/S_ISDIR(mod=
e),
  * but not their sha1's.
  *
@@ -33,72 +49,153 @@ static int tree_entry_pathcmp(struct tree_desc *t1=
, struct tree_desc *t2)
 }
=20
=20
-/* convert path, t1/t2 -> opt->diff_*() callbacks */
-static void emit_diff(struct diff_options *opt, struct strbuf *path,
-		      struct tree_desc *t1, struct tree_desc *t2)
+/*
+ * convert path -> opt->diff_*() callbacks
+ *
+ * emits diff to first parent only, and tells diff tree-walker that we=
 are done
+ * with p and it can be freed.
+ */
+static int emit_diff_first_parent_only(struct diff_options *opt, struc=
t combine_diff_path *p)
 {
-	unsigned int mode1 =3D t1 ? t1->entry.mode : 0;
-	unsigned int mode2 =3D t2 ? t2->entry.mode : 0;
-
-	if (mode1 && mode2) {
-		opt->change(opt, mode1, mode2, t1->entry.sha1, t2->entry.sha1,
-			1, 1, path->buf, 0, 0);
+	struct combine_diff_parent *p0 =3D &p->parent[0];
+	if (p->mode && p0->mode) {
+		opt->change(opt, p0->mode, p->mode, p0->sha1, p->sha1,
+			1, 1, p->path, 0, 0);
 	}
 	else {
 		const unsigned char *sha1;
 		unsigned int mode;
 		int addremove;
=20
-		if (mode2) {
+		if (p->mode) {
 			addremove =3D '+';
-			sha1 =3D t2->entry.sha1;
-			mode =3D mode2;
+			sha1 =3D p->sha1;
+			mode =3D p->mode;
 		}
 		else {
 			addremove =3D '-';
-			sha1 =3D t1->entry.sha1;
-			mode =3D mode1;
+			sha1 =3D p0->sha1;
+			mode =3D p0->mode;
 		}
=20
-		opt->add_remove(opt, addremove, mode, sha1, 1, path->buf, 0);
+		opt->add_remove(opt, addremove, mode, sha1, 1, p->path, 0);
 	}
+
+	return 0;	/* we are done with p */
 }
=20
=20
-/* new path should be added to diff
+/*
+ * Make a new combine_diff_path from path/mode/sha1
+ * and append it to paths list tail.
+ *
+ * Memory for created elements could be reused:
+ *
+ *	- if last->next =3D=3D NULL, the memory is allocated;
+ *
+ *	- if last->next !=3D NULL, it is assumed that p=3Dlast->next was re=
turned
+ *	  earlier by this function, and p->next was *not* modified.
+ *	  The memory is then reused from p.
+ *
+ * so for clients,
+ *
+ * - if you do need to keep the element
+ *
+ *	p =3D __path_appendnew(p, ...);
+ *	process(p);
+ *	p->next =3D NULL;
+ *
+ * - if you don't need to keep the element after processing
+ *
+ *	pprev =3D p;
+ *	p =3D __path_appendnew(p, ...);
+ *	process(p);
+ *	p =3D pprev;
+ *	; don't forget to free tail->next in the end
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
+	int alloclen =3D combine_diff_path_size(nparent, len);
+
+	/* if last->next is !NULL - it is a pre-allocated memory, we can reus=
e */
+	p =3D last->next;
+	if (p && (alloclen > (intptr_t)p->next)) {
+		free(p);
+		p =3D NULL;
+	}
+
+	if (!p) {
+		p =3D xmalloc(alloclen);
+
+		/*
+		 * until we go to it next round, .next holds how many bytes we
+		 * allocated (for faster realloc - we don't need copying old data).
+		 */
+		p->next =3D (struct combine_diff_path *)(intptr_t)alloclen;
+	}
+
+	last->next =3D p;
+
+	p->path =3D (char *)&(p->parent[nparent]);
+	memcpy(p->path, base->buf, base->len);
+	memcpy(p->path + base->len, path, pathlen);
+	p->path[len] =3D 0;
+	p->mode =3D mode;
+	hashcpy(p->sha1, sha1 ? sha1 : null_sha1);
+
+	return p;
+}
+
+/*
+ * new path should be added to combine diff
  *
  * 3 cases on how/when it should be called and behaves:
  *
- *	!t1,  t2	-> path added, parent lacks it
- *	 t1, !t2	-> path removed from parent
- *	 t1,  t2	-> path modified
+ *	 t, !tp		-> path added, all parents lack it
+ *	!t,  tp		-> path removed from all parents
+ *	 t,  tp		-> path modified/added
+ *			   (M for tp[i]=3Dtp[imin], A otherwise)
  */
-static void show_path(struct strbuf *base, struct diff_options *opt,
-		      struct tree_desc *t1, struct tree_desc *t2)
+static struct combine_diff_path *emit_path(struct combine_diff_path *p=
,
+	struct strbuf *base, struct diff_options *opt, int nparent,
+	struct tree_desc *t, struct tree_desc *tp,
+	int imin)
 {
 	unsigned mode;
 	const char *path;
+	const unsigned char *sha1;
 	int pathlen;
 	int old_baselen =3D base->len;
-	int isdir, recurse =3D 0, emitthis =3D 1;
+	int i, isdir, recurse =3D 0, emitthis =3D 1;
=20
 	/* at least something has to be valid */
-	assert(t1 || t2);
+	assert(t || tp);
=20
-	if (t2) {
+	if (t) {
 		/* path present in resulting tree */
-		tree_entry_extract(t2, &path, &mode);
-		pathlen =3D tree_entry_len(&t2->entry);
+		sha1 =3D tree_entry_extract(t, &path, &mode);
+		pathlen =3D tree_entry_len(&t->entry);
 		isdir =3D S_ISDIR(mode);
 	}
 	else {
-		/* a path was removed - take path from parent. Also take
-		 * mode from parent, to decide on recursion.
+		/*
+		 * a path was removed - take path from imin parent. Also take
+		 * mode from that parent, to decide on recursion(1).
+		 *
+		 * 1) all modes for tp[k]=3Dtp[imin] should be the same wrt
+		 *    S_ISDIR, thanks to base_name_compare().
 		 */
-		tree_entry_extract(t1, &path, &mode);
-		pathlen =3D tree_entry_len(&t1->entry);
+		tree_entry_extract(&tp[imin], &path, &mode);
+		pathlen =3D tree_entry_len(&tp[imin].entry);
=20
 		isdir =3D S_ISDIR(mode);
+		sha1 =3D NULL;
 		mode =3D 0;
 	}
=20
@@ -107,18 +204,81 @@ static void show_path(struct strbuf *base, struct=
 diff_options *opt,
 		emitthis =3D DIFF_OPT_TST(opt, TREE_IN_RECURSIVE);
 	}
=20
-	strbuf_add(base, path, pathlen);
+	if (emitthis) {
+		int keep;
+		struct combine_diff_path *pprev =3D p;
+		p =3D __path_appendnew(p, nparent, base, path, pathlen, mode, sha1);
=20
-	if (emitthis)
-		emit_diff(opt, base, t1, t2);
+		for (i =3D 0; i < nparent; ++i) {
+			/*
+			 * tp[i] is valid, if present and if tp[i]=3D=3Dtp[imin] -
+			 * otherwise, we should ignore it.
+			 */
+			int tpi_valid =3D tp && !(tp[i].entry.mode & S_IFXMIN_NEQ);
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
+				mode_i =3D tp[i].entry.mode;
+			}
+			else {
+				sha1_i =3D NULL;
+				mode_i =3D 0;
+			}
+
+			p->parent[i].mode =3D mode_i;
+			hashcpy(p->parent[i].sha1, sha1_i ? sha1_i : null_sha1);
+		}
+
+		keep =3D 1;
+		if (opt->pathchange)
+			keep =3D opt->pathchange(opt, p);
+
+		/*
+		 * If a path was filtered or consumed - we don't need to add it
+		 * to the list and can reuse its memory, leaving it as
+		 * pre-allocated element on the tail.
+		 *
+		 * On the other hand, if path needs to be kept, we need to
+		 * correct its .next to NULL, as it was pre-initialized to how
+		 * much memory was allocated.
+		 *
+		 * see __path_appendnew() for details.
+		 */
+		if (!keep)
+			p =3D pprev;
+		else
+			p->next =3D NULL;
+	}
=20
 	if (recurse) {
+		const unsigned char **parents_sha1;
+
+		parents_sha1 =3D xalloca(nparent * sizeof(parents_sha1[0]));
+		for (i =3D 0; i < nparent; ++i) {
+			/* same rule as in emitthis */
+			int tpi_valid =3D tp && !(tp[i].entry.mode & S_IFXMIN_NEQ);
+
+			parents_sha1[i] =3D tpi_valid ? tp[i].entry.sha1
+						    : NULL;
+		}
+
+		strbuf_add(base, path, pathlen);
 		strbuf_addch(base, '/');
-		__diff_tree_sha1(t1 ? t1->entry.sha1 : NULL,
-				 t2 ? t2->entry.sha1 : NULL, base, opt);
+		p =3D __diff_tree_paths(p, sha1, parents_sha1, nparent, base, opt);
+		xalloca_free(parents_sha1);
 	}
=20
 	strbuf_setlen(base, old_baselen);
+	return p;
 }
=20
 static void skip_uninteresting(struct tree_desc *t, struct strbuf *bas=
e,
@@ -137,59 +297,260 @@ static void skip_uninteresting(struct tree_desc =
*t, struct strbuf *base,
 	}
 }
=20
-static int __diff_tree_sha1(const unsigned char *old, const unsigned c=
har *new,
-			    struct strbuf *base, struct diff_options *opt)
+
+/*
+ * generate paths for combined diff D(sha1,parents_sha1[])
+ *
+ * Resulting paths are appended to combine_diff_path linked list, and =
also, are
+ * emitted on the go via opt->pathchange() callback, so it is possible=
 to
+ * process the result as batch or incrementally.
+ *
+ * The paths are generated scanning new tree and all parents trees
+ * simultaneously, similarly to what diff_tree() was doing for 2 trees=
=2E
+ * The theory behind such scan is as follows:
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
+ *
+ *
+ * ~~~~~~~~
+ *
+ * NOTE
+ *
+ *	Usual diff D(A,B) is by definition the same as combined diff D(A,[B=
]),
+ *	so this diff paths generator can, and is used, for plain diffs
+ *	generation too.
+ *
+ *	Please keep attention to the common D(A,[B]) case when working on t=
he
+ *	code, in order not to slow it down.
+ *
+ * NOTE
+ *	nparent must be > 0.
+ */
+
+
+/* =E2=88=80 xk=3Dxi  xk=E2=86=93 */
+static inline void update_tp_entries(struct tree_desc *tp, int nparent=
)
 {
-	struct tree_desc t1, t2;
-	void *t1tree, *t2tree;
+	int i;
+	for (i =3D 0; i < nparent; ++i)
+		if (!(tp[i].entry.mode & S_IFXMIN_NEQ))
+			update_tree_entry(&tp[i]);
+}
+
+static struct combine_diff_path *__diff_tree_paths(
+	struct combine_diff_path *p, const unsigned char *sha1,
+	const unsigned char **parents_sha1, int nparent,
+	struct strbuf *base, struct diff_options *opt)
+{
+	struct tree_desc t, *tp;
+	void *ttree, **tptree;
+	int i;
+
+	tp     =3D xalloca(nparent * sizeof(tp[0]));
+	tptree =3D xalloca(nparent * sizeof(tptree[0]));
=20
-	t1tree =3D fill_tree_descriptor(&t1, old);
-	t2tree =3D fill_tree_descriptor(&t2, new);
+	/*
+	 * load parents first, as they are probably already cached.
+	 *
+	 * ( log_tree_diff() parses commit->parent before calling here via
+	 *   diff_tree_sha1(parent, commit) )
+	 */
+	for (i =3D 0; i < nparent; ++i)
+		tptree[i] =3D fill_tree_descriptor(&tp[i], parents_sha1[i]);
+	ttree =3D fill_tree_descriptor(&t, sha1);
=20
 	/* Enable recursion indefinitely */
 	opt->pathspec.recursive =3D DIFF_OPT_TST(opt, RECURSIVE);
=20
 	for (;;) {
-		int cmp;
+		int imin, cmp;
=20
 		if (diff_can_quit_early(opt))
 			break;
+
 		if (opt->pathspec.nr) {
-			skip_uninteresting(&t1, base, opt);
-			skip_uninteresting(&t2, base, opt);
+			skip_uninteresting(&t, base, opt);
+			for (i =3D 0; i < nparent; i++)
+				skip_uninteresting(&tp[i], base, opt);
 		}
-		if (!t1.size && !t2.size)
-			break;
=20
-		cmp =3D tree_entry_pathcmp(&t1, &t2);
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
+		/*
+		 * lookup imin =3D argmin(x1...xn),
+		 * mark entries whether they =3Dtp[imin] along the way
+		 */
+		imin =3D 0;
+		tp[0].entry.mode &=3D ~S_IFXMIN_NEQ;
+
+		for (i =3D 1; i < nparent; ++i) {
+			cmp =3D tree_entry_pathcmp(&tp[i], &tp[imin]);
+			if (cmp < 0) {
+				imin =3D i;
+				tp[i].entry.mode &=3D ~S_IFXMIN_NEQ;
+			}
+			else if (cmp =3D=3D 0) {
+				tp[i].entry.mode &=3D ~S_IFXMIN_NEQ;
+			}
+			else {
+				tp[i].entry.mode |=3D S_IFXMIN_NEQ;
+			}
+		}
+
+		/* fixup markings for entries before imin */
+		for (i =3D 0; i < imin; ++i)
+			tp[i].entry.mode |=3D S_IFXMIN_NEQ;	/* x[i] > x[imin] */
+
+
+
+		/* compare a vs x[imin] */
+		cmp =3D tree_entry_pathcmp(&t, &tp[imin]);
=20
-		/* t1 =3D t2 */
+		/* a =3D xi */
 		if (cmp =3D=3D 0) {
-			if (DIFF_OPT_TST(opt, FIND_COPIES_HARDER) ||
-			    hashcmp(t1.entry.sha1, t2.entry.sha1) ||
-			    (t1.entry.mode !=3D t2.entry.mode))
-				show_path(base, opt, &t1, &t2);
+			/* are either xk > xi or diff(a,xk) !=3D =C3=B8 ? */
+			if (!DIFF_OPT_TST(opt, FIND_COPIES_HARDER)) {
+				for (i =3D 0; i < nparent; ++i) {
+					/* x[i] > x[imin] */
+					if (tp[i].entry.mode & S_IFXMIN_NEQ)
+						continue;
=20
-			update_tree_entry(&t1);
-			update_tree_entry(&t2);
+					/* diff(a,xk) !=3D =C3=B8 */
+					if (hashcmp(t.entry.sha1, tp[i].entry.sha1) ||
+					    (t.entry.mode !=3D tp[i].entry.mode))
+						continue;
+
+					goto skip_emit_t_tp;
+				}
+			}
+
+			/* D +=3D {=CE=B4(a,xk) if xk=3Dxi;  "+a" if xk > xi} */
+			p =3D emit_path(p, base, opt, nparent,
+					&t, tp, imin);
+
+		skip_emit_t_tp:
+			/* a=E2=86=93,  =E2=88=80 xk=3Dximin  xk=E2=86=93 */
+			update_tree_entry(&t);
+			update_tp_entries(tp, nparent);
 		}
=20
-		/* t1 < t2 */
+		/* a < xi */
 		else if (cmp < 0) {
-			show_path(base, opt, &t1, /*t2=3D*/NULL);
-			update_tree_entry(&t1);
+			/* D +=3D "+a" */
+			p =3D emit_path(p, base, opt, nparent,
+					&t, /*tp=3D*/NULL, -1);
+
+			/* a=E2=86=93 */
+			update_tree_entry(&t);
 		}
=20
-		/* t1 > t2 */
+		/* a > xi */
 		else {
-			show_path(base, opt, /*t1=3D*/NULL, &t2);
-			update_tree_entry(&t2);
+			/* =E2=88=80j xj=3Dximin -> D +=3D "-xi" */
+			if (!DIFF_OPT_TST(opt, FIND_COPIES_HARDER)) {
+				for (i =3D 0; i < nparent; ++i)
+					if (tp[i].entry.mode & S_IFXMIN_NEQ)
+						goto skip_emit_tp;
+			}
+
+			p =3D emit_path(p, base, opt, nparent,
+					/*t=3D*/NULL, tp, imin);
+
+		skip_emit_tp:
+			/* =E2=88=80 xk=3Dximin  xk=E2=86=93 */
+			update_tp_entries(tp, nparent);
 		}
 	}
=20
-	free(t2tree);
-	free(t1tree);
-	return 0;
+	free(ttree);
+	for (i =3D nparent-1; i >=3D 0; i--)
+		free(tptree[i]);
+	xalloca_free(tptree);
+	xalloca_free(tp);
+
+	return p;
+}
+
+struct combine_diff_path *diff_tree_paths(
+	struct combine_diff_path *p, const unsigned char *sha1,
+	const unsigned char **parents_sha1, int nparent,
+	struct strbuf *base, struct diff_options *opt)
+{
+	p =3D __diff_tree_paths(p, sha1, parents_sha1, nparent, base, opt);
+
+	/*
+	 * free pre-allocated last element, if any
+	 * (see __path_appendnew() for details about why)
+	 */
+	if (p->next) {
+		free(p->next);
+		p->next =3D NULL;
+	}
+
+	return p;
 }
=20
 /*
@@ -300,6 +661,27 @@ static void try_to_follow_renames(const unsigned c=
har *old, const unsigned char
 	q->nr =3D 1;
 }
=20
+static int __diff_tree_sha1(const unsigned char *old, const unsigned c=
har *new,
+			    struct strbuf *base, struct diff_options *opt)
+{
+	struct combine_diff_path phead, *p;
+	const unsigned char *parents_sha1[1] =3D {old};
+	pathchange_fn_t pathchange_old =3D opt->pathchange;
+
+	phead.next =3D NULL;
+	opt->pathchange =3D emit_diff_first_parent_only;
+	diff_tree_paths(&phead, new, parents_sha1, 1, base, opt);
+
+	for (p =3D phead.next; p;) {
+		struct combine_diff_path *pprev =3D p;
+		p =3D p->next;
+		free(pprev);
+	}
+
+	opt->pathchange =3D pathchange_old;
+	return 0;
+}
+
 int diff_tree_sha1(const unsigned char *old, const unsigned char *new,=
 const char *base_str, struct diff_options *opt)
 {
 	struct strbuf base;
--=20
1.9.rc1.181.g641f458
