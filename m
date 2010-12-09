From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/6] Introduce bulk-move detection in diffcore.
Date: Thu,  9 Dec 2010 22:38:03 +0100
Message-ID: <1291930687-8990-3-git-send-email-ydirson@altern.org>
References: <1291930687-8990-1-git-send-email-ydirson@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yann Dirson <ydirson@altern.org>, Yann Dirson <ydirson@free.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 09 22:38:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQoCQ-0005wX-3r
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 22:38:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757380Ab0LIVif convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Dec 2010 16:38:35 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:39904 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757373Ab0LIVid (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 16:38:33 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 8AE62D480B1;
	Thu,  9 Dec 2010 22:38:25 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PQoBq-0002Se-Gb; Thu, 09 Dec 2010 22:38:14 +0100
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1291930687-8990-1-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163329>

This feature tries to group together files moving from and to
identical directories - a common case being directory renames.

This only adds the detection logic.  The output of raw diff is displaye=
d
as "Rnnn a/ b/", and unified diff does not display them at all.  Output
formats will be refined later in the series.

It is implemented as a new pass in diffcore-rename, occuring after the
file renames get detected, grouping those renames looking like a move
of a full directory into some other place. It is activated by the new
--detect-bulk-moves diffcore flag.

Possible optimisations to this code include:
* avoid use of i_am_not_single by using a separate list
* use a more informative prefixcmp to avoid strcmp calls
  eg. in discard_if_outside()
* optimize for bulk insertions (avoid useless successive memmove's)

Other future developements to be made on top of this include:
* detect bulk removals (well, that one is rather a subset than a layer =
above),
  and possibly bulk additions
* detect bulk copies
* detect inexact bulk-moves/copies (where some files were not moved, or=
 were
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
- Junio C Hamano: better examples
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
 diff.c                         |    5 +
 diff.h                         |    3 +
 diffcore-rename.c              |  322 ++++++++++++++++++++++++++++++++=
++++++--
 diffcore.h                     |    1 +
 tree-diff.c                    |    4 +-
 8 files changed, 340 insertions(+), 17 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
index f3e9538..186cd6f 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -245,6 +245,10 @@ endif::git-log[]
 	delete/add pair to be a rename if more than 90% of the file
 	hasn't changed.
=20
+--detect-bulk-moves::
+	Detect bulk move of all files of a directory into a
+	different one.
+
 -C[<n>]::
 --detect-copies[=3D<n>]::
 	Detect copies as well as renames.  See also `--find-copies-harder`.
diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.=
txt
index 6af29a4..93111ac 100644
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
+:040000 040000 0000000... 0000000... R100 foo/ bar/
+:100644 100644 0123456... 1234567... R090 foo/file0 bar/file3
+:100644 100644 2345678... 2345678... R100 foo/file1 bar/file1
+:100644 100644 3456789... 3456789... R100 foo/file2 bar/file2
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
index db5e844..d64ae44 100644
--- a/diff.c
+++ b/diff.c
@@ -3200,6 +3200,11 @@ int diff_opt_parse(struct diff_options *options,=
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
diff --git a/diff.h b/diff.h
index 0083d92..1e2506c 100644
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
+"                detect moves of all files of a single directory.\n" \
 "  -l<n>         limit rename attempts up to <n> paths.\n" \
 "  -O<file>      reorder diffs according to the <file>.\n" \
 "  -S<string>    find filepair whose only one side contains the string=
=2E\n" \
diff --git a/diffcore-rename.c b/diffcore-rename.c
index e16fdeb..44df490 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -28,6 +28,7 @@ void __debug_bulkmove(const char *fmt, ...)
 struct diff_rename_dst {
 	struct diff_filespec *two;
 	struct diff_filepair *pair;
+	unsigned i_am_not_single:1; /* does not look for a match, only here t=
o be looked at */
 };
=20
 static int rename_dst_cmp(struct diff_filespec *ref_spec, struct diff_=
rename_dst *elem)
@@ -39,14 +40,23 @@ static void rename_dst_init(struct diff_rename_dst =
*elem, struct diff_filespec *
 	elem->two =3D alloc_filespec(ref_spec->path);
 	fill_filespec(elem->two, ref_spec->sha1, ref_spec->mode);
 	elem->pair =3D NULL;
+	elem->i_am_not_single =3D 0;
 }
 declare_sorted_array(static, struct diff_rename_dst, rename_dst);
 declare_sorted_array_search_elem(static, struct diff_rename_dst, locat=
e_rename_dst,
 				 struct diff_filespec *,
 				 rename_dst, rename_dst_cmp);
-declare_sorted_array_insert_checkbool(static, struct diff_rename_dst, =
register_rename_dst,
-				      struct diff_filespec *, _gen_locate_rename_dst,
-				      rename_dst, rename_dst_cmp, rename_dst_init);
+declare_sorted_array_insert_elem(static, struct diff_rename_dst, regis=
ter_rename_dst,
+				 struct diff_filespec *, _gen_locate_rename_dst,
+				 rename_dst, rename_dst_cmp, rename_dst_init);
+
+static int rename_dst_dircmp(const char *ref_dirname, struct diff_rena=
me_dst *elem)
+{
+	// FIXME: calls strlen many times - but maybe the compiler optimizes =
?
+	return strncmp(ref_dirname, elem->two->path, strlen(ref_dirname));
+}
+declare_sorted_array_search_elem(static, struct diff_rename_dst, locat=
e_rename_dst_dir,
+				 const char *, rename_dst, rename_dst_dircmp);
=20
 /* Table of rename/copy src files */
=20
@@ -361,8 +371,11 @@ static int find_exact_renames(void)
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
@@ -389,6 +402,253 @@ static void record_if_better(struct diff_score m[=
], struct diff_score *o)
 		m[worst] =3D *o;
 }
=20
+struct diff_bulk_rename {
+	struct diff_filespec *one;
+	struct diff_filespec *two;
+	int discarded;
+};
+
+struct diff_bulk_rename_candidate {
+	char one_path[PATH_MAX];
+	char two_path[PATH_MAX];
+};
+static int bulkmove_candidates_cmp(struct diff_bulk_rename_candidate *=
ref_candidate,
+				   struct diff_bulk_rename *elem)
+{
+	int cmp =3D strcmp(ref_candidate->one_path, elem->one->path);
+	if (!cmp)
+		cmp =3D strcmp(ref_candidate->two_path, elem->two->path);
+	return cmp;
+}
+static void bulkmove_candidates_init(struct diff_bulk_rename *elem,
+				     struct diff_bulk_rename_candidate *ref_candidate)
+{
+	elem->one =3D alloc_filespec(ref_candidate->one_path);
+	fill_filespec(elem->one, null_sha1, S_IFDIR);
+	elem->two =3D alloc_filespec(ref_candidate->two_path);
+	fill_filespec(elem->two, null_sha1, S_IFDIR);
+	elem->discarded =3D 0;
+}
+declare_sorted_array(static, struct diff_bulk_rename, bulkmove_candida=
tes);
+declare_sorted_array_insertonly_elem(static, struct diff_bulk_rename, =
register_bulkmove_candidate,
+				     struct diff_bulk_rename_candidate *, bulkmove_candidates,
+				     bulkmove_candidates_cmp, bulkmove_candidates_init);
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
+	if (dst =3D=3D src)
+		dst[slash - src + 1] =3D '\0';
+	else {
+		end =3D mempcpy(dst, src, slash - src + 1);
+		*end =3D '\0';
+	}
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
+		debug_bulkmove(("leftover file %s in %s\n",
+				rename_dst[j].two->path, one_parent_path));
+		if (rename_dst[j].i_am_not_single || /* those were already here */
+		    (rename_dst[j].pair &&
+		     !strncmp(rename_dst[j].pair->one->path,
+			      one_parent_path, onep_len) && /* renamed from here */
+		     strncmp(rename_dst[j].two->path,
+			     one_parent_path, onep_len))) { /* not to a subdir */
+			maybe_dir_rename =3D 0;
+			debug_bulkmove(("... tells not a bulk move\n"));
+			break;
+		}
+		debug_bulkmove(("... not believed to prevent bulk move\n"));
+	}
+	if (!maybe_dir_rename)
+		return 1;
+	/* try the other direction (dup code) */
+	for (j =3D two_idx-1; j >=3D 0; j--) {
+		if (strncmp(rename_dst[j].two->path,
+			    one_parent_path, onep_len))
+			break; /* exhausted directory in this direction */
+		debug_bulkmove(("leftover file %s in '%s'\n",
+				rename_dst[j].two->path, one_parent_path));
+		if (rename_dst[j].i_am_not_single || /* those were already here */
+		    (rename_dst[j].pair &&
+		     !strncmp(rename_dst[j].pair->one->path,
+			      one_parent_path, onep_len) && /* renamed from here */
+		     strncmp(rename_dst[j].two->path,
+			     one_parent_path, onep_len))) { /* not to a subdir */
+			maybe_dir_rename =3D 0;
+			debug_bulkmove(("... tells not a bulk move\n"));
+			break;
+		}
+		debug_bulkmove(("... not believed to prevent bulk move\n"));
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
+			      struct diff_bulk_rename *seen)
+{
+	if (!prefixcmp(candidate->two->path, seen->two->path)) {
+		debug_bulkmove((" 'dstpair' conforts 'seen'\n"));
+		return 0;
+	}
+
+	debug_bulkmove(("discarding %s -> %s from bulk moves (split into %s a=
nd %s)\n",
+			seen->one->path, seen->two->path,
+			candidate->two->path, seen->two->path));
+	seen->discarded =3D 1;
+	/* Need to discard dstpair as well, unless moving from
+	 * a strict subdir of seen->one or to a strict subdir
+	 * of seen->two */
+	if (!strcmp(seen->one->path, candidate->one->path) &&
+	    prefixcmp(seen->two->path, candidate->two->path)) {
+		debug_bulkmove(("... and not adding self\n"));
+		candidate->discarded =3D 1;
+	}
+	return 1;
+}
+
+/*
+ * Check if the rename specified by "dstpair" could cause a
+ * bulk move to be detected, record it in bulkmove_candidates if yes.
+ */
+static void check_one_bulk_move(struct diff_filepair *dstpair)
+{
+	struct diff_bulk_rename_candidate rawcandidate;
+
+	/* genuine new files (or believed to be so) */
+	if (!dstpair)
+		return;
+	/* dummy renames used by copy detection */
+	if (!strcmp(dstpair->one->path, dstpair->two->path))
+		return;
+
+	copy_dirname(rawcandidate.one_path, dstpair->one->path);
+	copy_dirname(rawcandidate.two_path, dstpair->two->path);
+
+	/* simple rename with no directory change */
+	if (!strcmp(rawcandidate.one_path, rawcandidate.two_path))
+		return;
+
+	debug_bulkmove(("[] %s -> %s ?\n", dstpair->one->path, dstpair->two->=
path));
+
+	/* loop up rawcandidate.one_path over successive parents */
+	// FIXME: also loop over rawcandidate.two_path prefixes
+	do {
+		struct diff_bulk_rename *seen;
+		int old_nr =3D bulkmove_candidates_nr;
+		struct diff_bulk_rename *candidate =3D
+			register_bulkmove_candidate(&rawcandidate);
+		debug_bulkmove(("[[]] %s ...\n", rawcandidate.one_path));
+		if (old_nr =3D=3D bulkmove_candidates_nr) {
+			debug_bulkmove((" already seen\n"));
+			return;
+		}
+
+		/* After this commit, are there any files still under rawcandidate.o=
ne_path ?
+		 * Any file left would disqualifies this dir for bulk move.
+		 */
+		if (dispatched_to_different_dirs(rawcandidate.one_path)) {
+			// FIXME: check overlap with discard_if_outside()
+			candidate->discarded =3D 1;
+			return;
+		}
+
+		/* walk up for rawcandidate.one_path prefixes */
+		for (seen =3D candidate-1; (seen >=3D bulkmove_candidates) &&
+			     !prefixcmp(rawcandidate.one_path, seen->one->path); seen--) {
+			debug_bulkmove((" ? %s -> %s\n", seen->one->path, seen->two->path))=
;
+			/* subdir of "seen" dest dir ? */
+			if (discard_if_outside(candidate, seen))
+				continue;
+		}
+		/* look down for other moves from rawcandidate.one_path */
+		seen =3D candidate + 1;
+		if (seen !=3D bulkmove_candidates + bulkmove_candidates_nr &&
+		    !strcmp(rawcandidate.one_path, seen->one->path)) {
+			debug_bulkmove((" ? %s -> %s (2)\n", seen->one->path, seen->two->pa=
th));
+			/* subdir of "seen" dest dir ? */
+			if (discard_if_outside(candidate, seen))
+				continue;
+		}
+
+		/* next parent if any */
+		copy_dirname(rawcandidate.one_path, rawcandidate.one_path);
+	} while (*rawcandidate.one_path);
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
@@ -399,6 +659,7 @@ void diffcore_rename(struct diff_options *options)
 	struct diff_score *mx;
 	int i, j, rename_count;
 	int num_create, num_src, dst_cnt;
+	struct diff_bulk_rename *candidate;
=20
 	if (!minimum_score)
 		minimum_score =3D DEFAULT_RENAME_SCORE;
@@ -413,8 +674,7 @@ void diffcore_rename(struct diff_options *options)
 				continue; /* not interested */
 			else
 				register_rename_dst(p->two);
-		}
-		else if (!DIFF_FILE_VALID(p->two)) {
+		} else if (!DIFF_FILE_VALID(p->two)) {
 			/*
 			 * If the source is a broken "delete", and
 			 * they did not really want to get broken,
@@ -425,14 +685,23 @@ void diffcore_rename(struct diff_options *options=
)
 			if (p->broken_pair && !p->score)
 				p->one->rename_used++;
 			register_rename_src(p);
-		}
-		else if (detect_rename =3D=3D DIFF_DETECT_COPY) {
-			/*
-			 * Increment the "rename_used" score by
-			 * one, to indicate ourselves as a user.
-			 */
-			p->one->rename_used++;
-			register_rename_src(p);
+		} else {
+			if (detect_rename =3D=3D DIFF_DETECT_COPY) {
+				/*
+				 * Increment the "rename_used" score by
+				 * one, to indicate ourselves as a user.
+				 */
+				p->one->rename_used++;
+				register_rename_src(p);
+			}
+			if (DIFF_OPT_TST(options, DETECT_BULK_MOVES)) {
+				/* similarly, bulk move detection needs to
+				 * see all files from second tree, but we don't
+				 * want them to be matched against single sources.
+				 */
+				// FIXME: check interaction with --find-copies-harder
+				register_rename_dst(p->two)->i_am_not_single =3D 1;
+			}
 		}
 	}
 	if (rename_dst_nr =3D=3D 0 || rename_src_nr =3D=3D 0)
@@ -484,6 +753,8 @@ void diffcore_rename(struct diff_options *options)
=20
 		if (rename_dst[i].pair)
 			continue; /* dealt with exact match already. */
+		if (rename_dst[i].i_am_not_single)
+			continue; /* not looking for a match. */
=20
 		m =3D &mx[dst_cnt * NUM_CANDIDATE_PER_DST];
 		for (j =3D 0; j < NUM_CANDIDATE_PER_DST; j++)
@@ -544,7 +815,30 @@ void diffcore_rename(struct diff_options *options)
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
index 12c9a88..89cedd4 100644
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
