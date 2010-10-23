From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH v7 1/3] Introduce bulk-move detection in diffcore.
Date: Sat, 23 Oct 2010 23:07:00 +0200
Message-ID: <1287868022-24872-2-git-send-email-ydirson@altern.org>
References: <1287868022-24872-1-git-send-email-ydirson@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yann Dirson <ydirson@altern.org>, Yann Dirson <ydirson@free.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 23 23:07:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9lJI-0007Au-2T
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 23:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756269Ab0JWVHX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Oct 2010 17:07:23 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:38778 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753007Ab0JWVHV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 17:07:21 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 1EFB8D48012;
	Sat, 23 Oct 2010 23:07:12 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1P9lJ0-00017A-Jx; Sat, 23 Oct 2010 23:07:10 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1287868022-24872-1-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159826>

This feature tries to group together files moving from and to
identical directories - the most common case being directory renames.

It is activated by the new --detect-bulk-moves diffcore
flag.

This is only the first step, adding the basic functionnality and
adding support to raw diff output (and it is not supported in
unified-diff output yet)

It is implemented as a new pass in diffcore-rename, occuring after the
file renames get detected, grouping those renames looking like a move
of a full directory into some other place.

The output of raw diff is displayed as "Rnnn a/* b/".  Those cannot be
confused with renames of files named "whatever/*" with a literal star
character, from the full-zero SHA1's.

Possible optimisations to this code include:
* avoid use of i_am_not_single by using a separate list
* use a more informative prefixcmp to avoid strcmp calls
  eg. in discard_if_outside()
* optimize for bulk insertions (avoid useless successive memmove's)

Other future developements to be made on top of this include:
* extension of unified-diff format to express this
* detect inexact bulk-moves (where some files were not moved, or were
  moved to a different place) - problem of computing a similarity score
* display as such the special case of directory move/rename
* application of such new diffs: issue a conflict, or just a warning ?
* teach git-svn (and others ?) to make use of that flag
* handle new conflict type "bulk-move/add"
* detect "directory splits" as well
* use inexact dir renames to bump score of below-threshold renames
  from/to same locations
* support other types of bluk-grouping, like prefixes (see eg. kernel
  5d1e859c), and maybe config-specified patterns
* add yours here

This patch has been improved by the following contributions:
- Jonathan Nieder: better implementation of copy_dirname()
- Jonathan Nieder: portable implementation of memrchr() in another patc=
h
- Junio C Hamano: split individual renames hiding under control of anot=
her flag
- Junio C Hamano: coding style issues
- =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason: Don't use C99 comments.
- Jonathan Nieder: just too many other helpful suggestions to list them=
 all

Thanks-to: Jonathan Nieder <jrnieder@gmail.com>
Thanks-to: Junio C Hamano <gitster@pobox.com>
Thanks-to: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Yann Dirson <ydirson@free.fr>
---
 Documentation/diff-options.txt |    4 +
 Documentation/gitdiffcore.txt  |   12 ++
 diff-lib.c                     |    6 +-
 diff.c                         |   14 ++-
 diff.h                         |    3 +
 diffcore-rename.c              |  354 ++++++++++++++++++++++++++++++++=
++++++--
 diffcore.h                     |    1 +
 tree-diff.c                    |    4 +-
 8 files changed, 383 insertions(+), 15 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
index e954af0..2d99511 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -243,6 +243,10 @@ endif::git-log[]
 	delete/add pair to be a rename if more than 90% of the file
 	hasn't changed.
=20
+--detect-bulk-moves::
+	Detect bulk move of all files of a directory into a
+	different one.
+
 -C[<n>]::
 	Detect copies as well as renames.  See also `--find-copies-harder`.
 	If `n` is specified, it has the same meaning as for `-M<n>`.
diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.=
txt
index 6af29a4..edeb159 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -175,6 +175,18 @@ the expense of making it slower.  Without `\--find=
-copies-harder`,
 'git diff-{asterisk}' commands can detect copies only if the file that=
 was
 copied happened to have been modified in the same changeset.
=20
+Bulk move of all files of a directory into a different one can get
+detected using the `\--detect-bulk-moves` option.  This adds an
+additional pass on top of the results of per-file rename detection.
+They are reported with NULL SHA1 id, in addition to the file renames:
+
+------------------------------------------------
+:040000 040000 0000000... 0000000... R100	a/*	b/
+:100644 100644 0123456... 1234567... R90	a/file0	b/file3
+:100644 100644 0123456... 1234567... R100	a/file1	b/file1
+:100644 100644 0123456... 1234567... R100	a/file2	b/file2
+------------------------------------------------
+
=20
 diffcore-merge-broken: For Putting "Complete Rewrites" Back Together
 --------------------------------------------------------------------
diff --git a/diff-lib.c b/diff-lib.c
index 392ce2b..5ec3ddc 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -208,7 +208,8 @@ int run_diff_files(struct rev_info *revs, unsigned =
int option)
 						    ce_option, &dirty_submodule);
 		if (!changed && !dirty_submodule) {
 			ce_mark_uptodate(ce);
-			if (!DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER))
+			if (!DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER) &&
+			    !DIFF_OPT_TST(&revs->diffopt, DETECT_BULK_MOVES))
 				continue;
 		}
 		oldmode =3D ce->ce_mode;
@@ -338,7 +339,8 @@ static int show_modified(struct rev_info *revs,
=20
 	oldmode =3D old->ce_mode;
 	if (mode =3D=3D oldmode && !hashcmp(sha1, old->sha1) && !dirty_submod=
ule &&
-	    !DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER))
+	    !DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER) &&
+	    !DIFF_OPT_TST(&revs->diffopt, DETECT_BULK_MOVES))
 		return 0;
=20
 	diff_change(&revs->diffopt, oldmode, mode,
diff --git a/diff.c b/diff.c
index 71efa8e..1d88281 100644
--- a/diff.c
+++ b/diff.c
@@ -3188,6 +3188,11 @@ int diff_opt_parse(struct diff_options *options,=
 const char **av, int ac)
 		DIFF_OPT_SET(options, REVERSE_DIFF);
 	else if (!strcmp(arg, "--find-copies-harder"))
 		DIFF_OPT_SET(options, FIND_COPIES_HARDER);
+	else if (!strcmp(arg, "--detect-bulk-moves")) {
+		DIFF_OPT_SET(options, DETECT_BULK_MOVES);
+		if (!options->detect_rename)
+			options->detect_rename =3D DIFF_DETECT_RENAME;
+	}
 	else if (!strcmp(arg, "--follow"))
 		DIFF_OPT_SET(options, FOLLOW_RENAMES);
 	else if (!strcmp(arg, "--color"))
@@ -3466,7 +3471,14 @@ static void diff_flush_raw(struct diff_filepair =
*p, struct diff_options *opt)
 	if (p->status =3D=3D DIFF_STATUS_COPIED ||
 	    p->status =3D=3D DIFF_STATUS_RENAMED) {
 		const char *name_a, *name_b;
-		name_a =3D p->one->path;
+		if (p->is_bulkmove) {
+			/* append "*" to the first dirname */
+			char buf[PATH_MAX];
+			char *next =3D memccpy(buf, p->one->path, '\0', PATH_MAX);
+			next[-1] =3D '*'; *next =3D '\0';
+			name_a =3D buf;
+		} else
+			name_a =3D p->one->path;
 		name_b =3D p->two->path;
 		strip_prefix(opt->prefix_length, &name_a, &name_b);
 		write_name_quoted(name_a, opt->file, inter_name_termination);
diff --git a/diff.h b/diff.h
index 1fd44f5..b0d6fa6 100644
--- a/diff.h
+++ b/diff.h
@@ -78,6 +78,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct dif=
f_options *opt, void *data)
 #define DIFF_OPT_IGNORE_UNTRACKED_IN_SUBMODULES (1 << 25)
 #define DIFF_OPT_IGNORE_DIRTY_SUBMODULES (1 << 26)
 #define DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG (1 << 27)
+#define DIFF_OPT_DETECT_BULK_MOVES  (1 << 28)
=20
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |=3D DIFF_OPT_##fla=
g)
@@ -265,6 +266,8 @@ extern void diffcore_fix_diff_index(struct diff_opt=
ions *);
 "  -C            detect copies.\n" \
 "  --find-copies-harder\n" \
 "                try unchanged files as candidate for copy detection.\=
n" \
+"  --detect-bulk-moves\n" \
+"                detect wholesale directory renames.\n" \
 "  -l<n>         limit rename attempts up to <n> paths.\n" \
 "  -O<file>      reorder diffs according to the <file>.\n" \
 "  -S<string>    find filepair whose only one side contains the string=
=2E\n" \
diff --git a/diffcore-rename.c b/diffcore-rename.c
index df41be5..fa2ba7c 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -11,9 +11,13 @@
 static struct diff_rename_dst {
 	struct diff_filespec *two;
 	struct diff_filepair *pair;
+	unsigned i_am_not_single:1; /* does not look for a match, only here t=
o be looked at */
 } *rename_dst;
 static int rename_dst_nr, rename_dst_alloc;
=20
+/*
+ * Do a binary search of "two" in "rename_dst", inserting it if not fo=
und.
+ */
 static struct diff_rename_dst *locate_rename_dst(struct diff_filespec =
*two,
 						 int insert_ok)
 {
@@ -49,9 +53,36 @@ static struct diff_rename_dst *locate_rename_dst(str=
uct diff_filespec *two,
 	rename_dst[first].two =3D alloc_filespec(two->path);
 	fill_filespec(rename_dst[first].two, two->sha1, two->mode);
 	rename_dst[first].pair =3D NULL;
+	rename_dst[first].i_am_not_single =3D 0;
 	return &(rename_dst[first]);
 }
=20
+/*
+ * Do a binary search in "rename_dst" of any entry under "dirname".
+ */
+static struct diff_rename_dst *locate_rename_dst_dir(const char *dirna=
me)
+{
+	int first, last;
+	int prefixlength =3D strlen(dirname);
+
+	first =3D 0;
+	last =3D rename_dst_nr;
+	while (last > first) {
+		int next =3D (last + first) >> 1;
+		struct diff_rename_dst *dst =3D &(rename_dst[next]);
+		int cmp =3D strncmp(dirname, dst->two->path, prefixlength);
+		if (!cmp)
+			return dst;
+		if (cmp < 0) {
+			last =3D next;
+			continue;
+		}
+		first =3D next+1;
+	}
+	/* not found */
+	return NULL;
+}
+
 /* Table of rename/copy src files */
 static struct diff_rename_src {
 	struct diff_filespec *one;
@@ -386,8 +417,11 @@ static int find_exact_renames(void)
 	for (i =3D 0; i < rename_src_nr; i++)
 		insert_file_table(&file_table, -1, i, rename_src[i].one);
=20
-	for (i =3D 0; i < rename_dst_nr; i++)
+	for (i =3D 0; i < rename_dst_nr; i++) {
+		if (rename_dst[i].i_am_not_single)
+			continue;
 		insert_file_table(&file_table, 1, i, rename_dst[i].two);
+	}
=20
 	/* Find the renames */
 	i =3D for_each_hash(&file_table, find_same_files);
@@ -414,6 +448,270 @@ static void record_if_better(struct diff_score m[=
], struct diff_score *o)
 		m[worst] =3D *o;
 }
=20
+static struct diff_bulk_rename {
+	struct diff_filespec *one;
+	struct diff_filespec *two;
+	int discarded;
+} *bulkmove_candidates;
+static int bulkmove_candidates_nr, bulkmove_candidates_alloc;
+
+/*
+ * Do a binary search of "one" in "bulkmove_candidate", inserting it i=
f not
+ * found.
+ * A good part was copy-pasted from locate_rename_dst().
+ */
+static struct diff_bulk_rename *locate_bulkmove_candidate(const char *=
one_path,
+							  const char *two_path)
+{
+	int first, last;
+
+	first =3D 0;
+	last =3D bulkmove_candidates_nr;
+	while (last > first) {
+		int next =3D (last + first) >> 1;
+		struct diff_bulk_rename *candidate =3D &(bulkmove_candidates[next]);
+		/* primary sort key on one_path, secondary on two_path */
+		int cmp =3D strcmp(one_path, candidate->one->path);
+		if (!cmp)
+			cmp =3D strcmp(two_path, candidate->two->path);
+		if (!cmp)
+			return candidate;
+		if (cmp < 0) {
+			last =3D next;
+			continue;
+		}
+		first =3D next+1;
+	}
+	/* not found */
+	/* insert to make it at "first" */
+	if (bulkmove_candidates_alloc <=3D bulkmove_candidates_nr) {
+		bulkmove_candidates_alloc =3D alloc_nr(bulkmove_candidates_alloc);
+		bulkmove_candidates =3D xrealloc(bulkmove_candidates,
+				      bulkmove_candidates_alloc * sizeof(*bulkmove_candidates));
+	}
+	bulkmove_candidates_nr++;
+	if (first < bulkmove_candidates_nr)
+		memmove(bulkmove_candidates + first + 1, bulkmove_candidates + first=
,
+			(bulkmove_candidates_nr - first - 1) * sizeof(*bulkmove_candidates)=
);
+
+	bulkmove_candidates[first].one =3D alloc_filespec(one_path);
+	fill_filespec(bulkmove_candidates[first].one, null_sha1, S_IFDIR);
+	bulkmove_candidates[first].two =3D alloc_filespec(two_path);
+	fill_filespec(bulkmove_candidates[first].two, null_sha1, S_IFDIR);
+	bulkmove_candidates[first].discarded =3D 0;
+	return &(bulkmove_candidates[first]);
+}
+
+/*
+ * Copy dirname of src into dst, suitable to append a filename without
+ * an additional "/".
+ * Only handles relative paths since there is no absolute path in a gi=
t repo.
+ * Writes "" when there is no "/" in src.
+ * May overwrite more chars than really needed, if src ends with a "/"=
=2E
+ * Supports in-place modification of src by passing dst =3D=3D src.
+ */
+static const char *copy_dirname(char *dst, const char *src)
+{
+	size_t len =3D strlen(src);
+	const char *slash;
+	char *end;
+
+	if (len > 0 && src[len - 1] =3D=3D '/')
+		/* Trailing slash.  Ignore it. */
+		len--;
+
+	slash =3D memrchr(src, '/', len);
+	if (!slash) {
+		*dst =3D '\0';
+		return dst;
+	}
+
+	end =3D mempcpy(dst, src, slash - src + 1);
+	*end =3D '\0';
+	return dst;
+}
+
+// FIXME: leaks like hell.
+/* See if the fact that one_leftover exists under one_parent_path in
+ * dst tree should disqualify one_parent_path from bulkmove eligibilit=
y.
+ * Return 1 if it disqualifies, 0 if it is OK.
+ */
+static int dispatched_to_different_dirs(const char *one_parent_path)
+{
+	/* this might be a dir split, or files added
+	 * after the bulk move, or just an isolated
+	 * rename */
+	int two_idx, j, onep_len, maybe_dir_rename;
+	struct diff_rename_dst *one_leftover =3D
+		one_leftover =3D locate_rename_dst_dir(one_parent_path);
+
+	if (!one_leftover)
+		return 0;
+
+	/* try to see if it is a file added after the bulk move */
+	two_idx =3D one_leftover - rename_dst;
+	onep_len =3D strlen(one_parent_path);
+	maybe_dir_rename =3D 1;
+
+	/* check no leftover file was already here before */
+	for (j =3D two_idx; j < rename_dst_nr; j++) {
+		if (strncmp(rename_dst[j].two->path,
+			    one_parent_path, onep_len))
+			break; /* exhausted directory in this direction */
+		fprintf(stderr, "[DBG] leftover file %s in %s\n",
+			rename_dst[j].two->path, one_parent_path);
+		if (rename_dst[j].i_am_not_single || /* those were already here */
+		    (rename_dst[j].pair &&
+		     !strncmp(rename_dst[j].pair->one->path,
+			      one_parent_path, onep_len) && /* renamed from here */
+		     strncmp(rename_dst[j].two->path,
+			     one_parent_path, onep_len))) { /* not to a subdir */
+			maybe_dir_rename =3D 0;
+			fprintf(stderr, "[DBG] ... tells not a bulk move\n");
+			break;
+		}
+		fprintf(stderr, "[DBG] ... not believed to prevent bulk move\n");
+	}
+	if (!maybe_dir_rename)
+		return 1;
+	/* try the other direction (dup code) */
+	for (j =3D two_idx-1; j >=3D 0; j--) {
+		if (strncmp(rename_dst[j].two->path,
+			    one_parent_path, onep_len))
+			break; /* exhausted directory in this direction */
+		fprintf(stderr, "[DBG] leftover file %s in '%s'\n",
+			rename_dst[j].two->path, one_parent_path);
+		if (rename_dst[j].i_am_not_single || /* those were already here */
+		    (rename_dst[j].pair &&
+		     !strncmp(rename_dst[j].pair->one->path,
+			      one_parent_path, onep_len) && /* renamed from here */
+		     strncmp(rename_dst[j].two->path,
+			     one_parent_path, onep_len))) { /* not to a subdir */
+			maybe_dir_rename =3D 0;
+			fprintf(stderr, "[DBG] ... tells not a bulk move\n");
+			break;
+		}
+		fprintf(stderr, "[DBG] ... not believed to prevent bulk move\n");
+	}
+	if (!maybe_dir_rename)
+		return 1;
+
+	/* Here we are in the case where a directory
+	 * content was completely moved, but files
+	 * were added to it afterwards.  Proceed as
+	 * for a simple bulk move. */
+	return 0;
+}
+
+/*
+ * Assumes candidate->one is a subdir of seen->one, mark 'seen' as
+ * discarded if candidate->two is outside seen->two.  Also mark
+ * 'candidate' itself as discarded if the conflict implies so.
+ *
+ * Return 1 if 'seen' was discarded
+ */
+static int discard_if_outside(struct diff_bulk_rename *candidate,
+			 struct diff_bulk_rename *seen) {
+	if (!prefixcmp(candidate->two->path, seen->two->path)) {
+		fprintf(stderr, "[DBG]  'dstpair' conforts 'seen'\n");
+		return 0;
+	} else {
+		fprintf(stderr, "[DBG] discarding %s -> %s from bulk moves (split in=
to %s and %s)\n",
+			seen->one->path, seen->two->path,
+			candidate->two->path, seen->two->path);
+		seen->discarded =3D 1;
+		/* Need to discard dstpair as well, unless moving from
+		 * a strict subdir of seen->one or to a strict subdir
+		 * of seen->two */
+		if (!strcmp(seen->one->path, candidate->one->path) &&
+		    prefixcmp(seen->two->path, candidate->two->path)) {
+			fprintf(stderr, "[DBG] ... and not adding self\n");
+			candidate->discarded =3D 1;
+		}
+		return 1;
+	}
+}
+
+/*
+ * Check if the rename specified by "dstpair" could cause a
+ * bulk move to be detected, record it in bulkmove_candidates if yes.
+ */
+static void check_one_bulk_move(struct diff_filepair *dstpair)
+{
+	char one_parent_path[PATH_MAX], two_parent_path[PATH_MAX];
+
+	/* genuine new files (or believed to be so) */
+	if (!dstpair)
+		return;
+	/* dummy renames used by copy detection */
+	if (!strcmp(dstpair->one->path, dstpair->two->path))
+		return;
+
+	copy_dirname(one_parent_path, dstpair->one->path);
+	copy_dirname(two_parent_path, dstpair->two->path);
+
+	/* simple rename with no directory change */
+	if (!strcmp(one_parent_path, two_parent_path))
+		return;
+
+	fprintf(stderr, "[] %s -> %s ?\n", dstpair->one->path, dstpair->two->=
path);
+
+	/* loop up one_parent_path over successive parents */
+	// FIXME: also loop over two_parent_path prefixes
+	do {
+		struct diff_bulk_rename *seen;
+		int old_nr =3D bulkmove_candidates_nr;
+		struct diff_bulk_rename *candidate =3D
+			locate_bulkmove_candidate(one_parent_path, two_parent_path);
+		fprintf(stderr, "[[]] %s ...\n", one_parent_path);
+		if (old_nr =3D=3D bulkmove_candidates_nr) {
+			fprintf(stderr, "[DBG]  already seen\n");
+			return;
+		}
+
+		/* After this commit, are there any files still under one_parent_pat=
h ?
+		 * Any file left would disqualifies this dir for bulk move.
+		 */
+		if (dispatched_to_different_dirs(one_parent_path)) {
+			// FIXME: check overlap with discard_if_outside()
+			candidate->discarded =3D 1;
+			return;
+		}
+
+		/* walk up for one_parent_path prefixes */
+		for (seen =3D candidate-1; (seen >=3D bulkmove_candidates) &&
+			     !prefixcmp(one_parent_path, seen->one->path); seen--) {
+			fprintf(stderr, "[DBG]  ? %s -> %s\n", seen->one->path, seen->two->=
path);
+			/* subdir of "seen" dest dir ? */
+			if (discard_if_outside(candidate, seen))
+				continue;
+		}
+		/* look down for other moves from one_parent_path */
+		seen =3D candidate + 1;
+		if (seen !=3D bulkmove_candidates + bulkmove_candidates_nr &&
+		    !strcmp(one_parent_path, seen->one->path)) {
+			fprintf(stderr, "[DBG]  ? %s -> %s (2)\n", seen->one->path, seen->t=
wo->path);
+			/* subdir of "seen" dest dir ? */
+			if (discard_if_outside(candidate, seen))
+				continue;
+		}
+
+		/* next parent if any */
+		copy_dirname(one_parent_path, one_parent_path);
+	} while (*one_parent_path);
+}
+
+/*
+ * Take all file renames recorded so far and check if they could cause
+ * a bulk move to be detected.
+ */
+static void diffcore_bulk_moves(void)
+{
+	int i;
+	for (i =3D 0; i < rename_dst_nr; i++)
+		check_one_bulk_move(rename_dst[i].pair);
+}
+
 void diffcore_rename(struct diff_options *options)
 {
 	int detect_rename =3D options->detect_rename;
@@ -424,6 +722,7 @@ void diffcore_rename(struct diff_options *options)
 	struct diff_score *mx;
 	int i, j, rename_count;
 	int num_create, num_src, dst_cnt;
+	struct diff_bulk_rename *candidate;
=20
 	if (!minimum_score)
 		minimum_score =3D DEFAULT_RENAME_SCORE;
@@ -438,8 +737,7 @@ void diffcore_rename(struct diff_options *options)
 				continue; /* not interested */
 			else
 				locate_rename_dst(p->two, 1);
-		}
-		else if (!DIFF_FILE_VALID(p->two)) {
+		} else if (!DIFF_FILE_VALID(p->two)) {
 			/*
 			 * If the source is a broken "delete", and
 			 * they did not really want to get broken,
@@ -450,14 +748,23 @@ void diffcore_rename(struct diff_options *options=
)
 			if (p->broken_pair && !p->score)
 				p->one->rename_used++;
 			register_rename_src(p->one, p->score);
-		}
-		else if (detect_rename =3D=3D DIFF_DETECT_COPY) {
-			/*
-			 * Increment the "rename_used" score by
-			 * one, to indicate ourselves as a user.
-			 */
-			p->one->rename_used++;
-			register_rename_src(p->one, p->score);
+		} else {
+			if (detect_rename =3D=3D DIFF_DETECT_COPY) {
+				/*
+				 * Increment the "rename_used" score by
+				 * one, to indicate ourselves as a user.
+				 */
+				p->one->rename_used++;
+				register_rename_src(p->one, p->score);
+			}
+			if (DIFF_OPT_TST(options, DETECT_BULK_MOVES)) {
+				/* similarly, bulk move detection needs to
+				 * see all files from second tree, but we don't
+				 * want them to be matched against single sources.
+				 */
+				// FIXME: check interaction with --find-copies-harder
+				locate_rename_dst(p->two, 1)->i_am_not_single =3D 1;
+			}
 		}
 	}
 	if (rename_dst_nr =3D=3D 0 || rename_src_nr =3D=3D 0)
@@ -509,6 +816,8 @@ void diffcore_rename(struct diff_options *options)
=20
 		if (rename_dst[i].pair)
 			continue; /* dealt with exact match already. */
+		if (rename_dst[i].i_am_not_single)
+			continue; /* not looking for a match. */
=20
 		m =3D &mx[dst_cnt * NUM_CANDIDATE_PER_DST];
 		for (j =3D 0; j < NUM_CANDIDATE_PER_DST; j++)
@@ -569,7 +878,30 @@ void diffcore_rename(struct diff_options *options)
 	/* At this point, we have found some renames and copies and they
 	 * are recorded in rename_dst.  The original list is still in *q.
 	 */
+
+	/* Now possibly factorize those renames and copies. */
+	if (DIFF_OPT_TST(options, DETECT_BULK_MOVES))
+		diffcore_bulk_moves();
+
 	DIFF_QUEUE_CLEAR(&outq);
+
+	/* Now turn non-discarded bulkmove_candidates into real renames */
+	for (candidate =3D bulkmove_candidates;
+	     candidate < bulkmove_candidates + bulkmove_candidates_nr; candid=
ate++) {
+		struct diff_filepair* pair;
+		if (candidate->discarded)
+			continue;
+		/* visualize toplevel dir if needed */
+		if (!*candidate->one->path)
+			candidate->one->path =3D "./";
+		if (!*candidate->two->path)
+			candidate->two->path =3D "./";
+		pair =3D diff_queue(&outq, candidate->one, candidate->two);
+		pair->score =3D MAX_SCORE;
+		pair->renamed_pair =3D 1;
+		pair->is_bulkmove =3D 1;
+	}
+
 	for (i =3D 0; i < q->nr; i++) {
 		struct diff_filepair *p =3D q->queue[i];
 		struct diff_filepair *pair_to_free =3D NULL;
diff --git a/diffcore.h b/diffcore.h
index b8f1fde..6dab95b 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -69,6 +69,7 @@ struct diff_filepair {
 	unsigned broken_pair : 1;
 	unsigned renamed_pair : 1;
 	unsigned is_unmerged : 1;
+	unsigned is_bulkmove : 1;
 };
 #define DIFF_PAIR_UNMERGED(p) ((p)->is_unmerged)
=20
diff --git a/tree-diff.c b/tree-diff.c
index cd659c6..5d9f123 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -49,7 +49,9 @@ static int compare_tree_entry(struct tree_desc *t1, s=
truct tree_desc *t2, const
 		show_entry(opt, "+", t2, base, baselen);
 		return 1;
 	}
-	if (!DIFF_OPT_TST(opt, FIND_COPIES_HARDER) && !hashcmp(sha1, sha2) &&=
 mode1 =3D=3D mode2)
+	if (!DIFF_OPT_TST(opt, FIND_COPIES_HARDER) &&
+	    !DIFF_OPT_TST(opt, DETECT_BULK_MOVES) &&
+	    !hashcmp(sha1, sha2) && mode1 =3D=3D mode2)
 		return 0;
=20
 	/*
--=20
1.7.2.3
