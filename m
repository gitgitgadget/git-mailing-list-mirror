From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] diff: do not use null sha1 as a sentinel value
Date: Sat, 28 Jul 2012 11:03:01 -0400
Message-ID: <20120728150301.GA25269@sigill.intra.peff.net>
References: <20120728150132.GA25042@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 28 17:03:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv8Xy-0000wf-Ha
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 17:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643Ab2G1PDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 11:03:08 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40017 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752401Ab2G1PDH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 11:03:07 -0400
Received: (qmail 31298 invoked by uid 107); 28 Jul 2012 15:03:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 28 Jul 2012 11:03:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Jul 2012 11:03:01 -0400
Content-Disposition: inline
In-Reply-To: <20120728150132.GA25042@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202441>

The diff code represents paths using the diff_filespec
struct. This struct has a sha1 to represent the sha1 of the
content at that path, as well as a sha1_valid member which
indicates whether its sha1 field is actually useful. If
sha1_valid is not true, then the filespec represents a
working tree file (e.g., for the no-index case, or for when
the index is not up-to-date).

The diff_filespec is only used internally, though. At the
interfaces to the diff subsystem, callers feed the sha1
directly, and we create a diff_filespec from it. It's at
that point that we look at the sha1 and decide whether it is
valid or not; callers may pass the null sha1 as a sentinel
value to indicate that it is not.

We should not typically see the null sha1 coming from any
other source (e.g., in the index itself, or from a tree).
However, a corrupt tree might have a null sha1, which would
cause "diff --patch" to accidentally diff the working tree
version of a file instead of treating it as a blob.

This patch extends the edges of the diff interface to accept
a "sha1_valid" flag whenever we accept a sha1, and to use
that flag when creating a filespec. In some cases, this
means passing the flag through several layers, making the
code change larger than would be desirable.

One alternative would be to simply die() upon seeing
corrupted trees with null sha1s. However, this fix more
directly addresses the problem (while bogus sha1s in a tree
are probably a bad thing, it is really the sentinel
confusion sending us down the wrong code path that is what
makes it devastating). And it means that git is more capable
of examining and debugging these corrupted trees. For
example, you can still "diff --raw" such a tree to find out
when the bogus entry was introduced; you just cannot do a
"--patch" diff (just as you could not with any other
corrupted tree, as we do not have any content to diff).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin.h                  |  2 +-
 builtin/blame.c            |  9 ++---
 builtin/cat-file.c         |  2 +-
 builtin/diff.c             |  8 +++--
 combine-diff.c             |  4 +--
 diff-lib.c                 | 20 ++++++-----
 diff-no-index.c            |  2 +-
 diff.c                     | 16 +++++----
 diff.h                     |  5 +++
 diffcore-rename.c          |  2 +-
 diffcore.h                 |  2 +-
 revision.c                 |  2 ++
 t/t4054-diff-bogus-tree.sh | 83 ++++++++++++++++++++++++++++++++++++++++++++++
 tree-diff.c                |  8 ++---
 14 files changed, 134 insertions(+), 31 deletions(-)
 create mode 100755 t/t4054-diff-bogus-tree.sh

diff --git a/builtin.h b/builtin.h
index ba6626b..8e37752 100644
--- a/builtin.h
+++ b/builtin.h
@@ -43,7 +43,7 @@ extern int check_pager_config(const char *cmd);
 struct diff_options;
 extern void setup_diff_pager(struct diff_options *);
 
-extern int textconv_object(const char *path, unsigned mode, const unsigned char *sha1, char **buf, unsigned long *buf_size);
+extern int textconv_object(const char *path, unsigned mode, const unsigned char *sha1, int sha1_valid, char **buf, unsigned long *buf_size);
 
 extern int cmd_add(int argc, const char **argv, const char *prefix);
 extern int cmd_annotate(int argc, const char **argv, const char *prefix);
diff --git a/builtin/blame.c b/builtin/blame.c
index 0d50273..f2c48ef 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -110,6 +110,7 @@ static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b, long ctxlen,
 int textconv_object(const char *path,
 		    unsigned mode,
 		    const unsigned char *sha1,
+		    int sha1_valid,
 		    char **buf,
 		    unsigned long *buf_size)
 {
@@ -117,7 +118,7 @@ int textconv_object(const char *path,
 	struct userdiff_driver *textconv;
 
 	df = alloc_filespec(path);
-	fill_filespec(df, sha1, mode);
+	fill_filespec(df, sha1, sha1_valid, mode);
 	textconv = get_textconv(df);
 	if (!textconv) {
 		free_filespec(df);
@@ -142,7 +143,7 @@ static void fill_origin_blob(struct diff_options *opt,
 
 		num_read_blob++;
 		if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV) &&
-		    textconv_object(o->path, o->mode, o->blob_sha1, &file->ptr, &file_size))
+		    textconv_object(o->path, o->mode, o->blob_sha1, 1, &file->ptr, &file_size))
 			;
 		else
 			file->ptr = read_sha1_file(o->blob_sha1, &type, &file_size);
@@ -2123,7 +2124,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 		switch (st.st_mode & S_IFMT) {
 		case S_IFREG:
 			if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV) &&
-			    textconv_object(read_from, mode, null_sha1, &buf_ptr, &buf_len))
+			    textconv_object(read_from, mode, null_sha1, 0, &buf_ptr, &buf_len))
 				strbuf_attach(&buf, buf_ptr, buf_len, buf_len + 1);
 			else if (strbuf_read_file(&buf, read_from, st.st_size) != st.st_size)
 				die_errno("cannot open or read '%s'", read_from);
@@ -2516,7 +2517,7 @@ parse_done:
 			die("no such path %s in %s", path, final_commit_name);
 
 		if (DIFF_OPT_TST(&sb.revs->diffopt, ALLOW_TEXTCONV) &&
-		    textconv_object(path, o->mode, o->blob_sha1, (char **) &sb.final_buf,
+		    textconv_object(path, o->mode, o->blob_sha1, 1, (char **) &sb.final_buf,
 				    &sb.final_buf_size))
 			;
 		else
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index af74e77..0eca2d7 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -146,7 +146,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 			die("git cat-file --textconv %s: <object> must be <sha1:path>",
 			    obj_name);
 
-		if (!textconv_object(obj_context.path, obj_context.mode, sha1, &buf, &size))
+		if (!textconv_object(obj_context.path, obj_context.mode, sha1, 1, &buf, &size))
 			die("git cat-file --textconv: unable to run textconv on %s",
 			    obj_name);
 		break;
diff --git a/builtin/diff.c b/builtin/diff.c
index da8f6aa..bf72298 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -29,6 +29,8 @@ static void stuff_change(struct diff_options *opt,
 			 unsigned old_mode, unsigned new_mode,
 			 const unsigned char *old_sha1,
 			 const unsigned char *new_sha1,
+			 int old_sha1_valid,
+			 int new_sha1_valid,
 			 const char *old_name,
 			 const char *new_name)
 {
@@ -54,8 +56,8 @@ static void stuff_change(struct diff_options *opt,
 
 	one = alloc_filespec(old_name);
 	two = alloc_filespec(new_name);
-	fill_filespec(one, old_sha1, old_mode);
-	fill_filespec(two, new_sha1, new_mode);
+	fill_filespec(one, old_sha1, old_sha1_valid, old_mode);
+	fill_filespec(two, new_sha1, new_sha1_valid, new_mode);
 
 	diff_queue(&diff_queued_diff, one, two);
 }
@@ -84,6 +86,7 @@ static int builtin_diff_b_f(struct rev_info *revs,
 	stuff_change(&revs->diffopt,
 		     blob[0].mode, canon_mode(st.st_mode),
 		     blob[0].sha1, null_sha1,
+		     1, 0,
 		     path, path);
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
@@ -108,6 +111,7 @@ static int builtin_diff_blobs(struct rev_info *revs,
 	stuff_change(&revs->diffopt,
 		     blob[0].mode, blob[1].mode,
 		     blob[0].sha1, blob[1].sha1,
+		     1, 1,
 		     blob[0].name, blob[1].name);
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
diff --git a/combine-diff.c b/combine-diff.c
index 9786680..bb1cc96 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -111,7 +111,7 @@ static char *grab_blob(const unsigned char *sha1, unsigned int mode,
 		return xcalloc(1, 1);
 	} else if (textconv) {
 		struct diff_filespec *df = alloc_filespec(path);
-		fill_filespec(df, sha1, mode);
+		fill_filespec(df, sha1, 1, mode);
 		*size = fill_textconv(textconv, df, &blob);
 		free_filespec(df);
 	} else {
@@ -823,7 +823,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 						   &result_size, NULL, NULL);
 		} else if (textconv) {
 			struct diff_filespec *df = alloc_filespec(elem->path);
-			fill_filespec(df, null_sha1, st.st_mode);
+			fill_filespec(df, null_sha1, 0, st.st_mode);
 			result_size = fill_textconv(textconv, df, &result);
 			free_filespec(df);
 		} else if (0 <= (fd = open(elem->path, O_RDONLY))) {
diff --git a/diff-lib.c b/diff-lib.c
index fc0dff3..f35de0f 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -206,7 +206,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			if (silent_on_removed)
 				continue;
 			diff_addremove(&revs->diffopt, '-', ce->ce_mode,
-				       ce->sha1, ce->name, 0);
+				       ce->sha1, !is_null_sha1(ce->sha1),
+				       ce->name, 0);
 			continue;
 		}
 		changed = match_stat_with_submodule(&revs->diffopt, ce, &st,
@@ -220,6 +221,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		newmode = ce_mode_from_stat(ce, st.st_mode);
 		diff_change(&revs->diffopt, oldmode, newmode,
 			    ce->sha1, (changed ? null_sha1 : ce->sha1),
+			    !is_null_sha1(ce->sha1), (changed ? 0 : !is_null_sha1(ce->sha1)),
 			    ce->name, 0, dirty_submodule);
 
 	}
@@ -236,11 +238,12 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 static void diff_index_show_file(struct rev_info *revs,
 				 const char *prefix,
 				 struct cache_entry *ce,
-				 const unsigned char *sha1, unsigned int mode,
+				 const unsigned char *sha1, int sha1_valid,
+				 unsigned int mode,
 				 unsigned dirty_submodule)
 {
 	diff_addremove(&revs->diffopt, prefix[0], mode,
-		       sha1, ce->name, dirty_submodule);
+		       sha1, sha1_valid, ce->name, dirty_submodule);
 }
 
 static int get_stat_data(struct cache_entry *ce,
@@ -295,7 +298,7 @@ static void show_new_file(struct rev_info *revs,
 	    &dirty_submodule, &revs->diffopt) < 0)
 		return;
 
-	diff_index_show_file(revs, "+", new, sha1, mode, dirty_submodule);
+	diff_index_show_file(revs, "+", new, sha1, !is_null_sha1(sha1), mode, dirty_submodule);
 }
 
 static int show_modified(struct rev_info *revs,
@@ -312,7 +315,7 @@ static int show_modified(struct rev_info *revs,
 			  &dirty_submodule, &revs->diffopt) < 0) {
 		if (report_missing)
 			diff_index_show_file(revs, "-", old,
-					     old->sha1, old->ce_mode, 0);
+					     old->sha1, 1, old->ce_mode, 0);
 		return -1;
 	}
 
@@ -347,7 +350,8 @@ static int show_modified(struct rev_info *revs,
 		return 0;
 
 	diff_change(&revs->diffopt, oldmode, mode,
-		    old->sha1, sha1, old->name, 0, dirty_submodule);
+		    old->sha1, sha1, 1, !is_null_sha1(sha1),
+		    old->name, 0, dirty_submodule);
 	return 0;
 }
 
@@ -380,7 +384,7 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 		struct diff_filepair *pair;
 		pair = diff_unmerge(&revs->diffopt, idx->name);
 		if (tree)
-			fill_filespec(pair->one, tree->sha1, tree->ce_mode);
+			fill_filespec(pair->one, tree->sha1, 1, tree->ce_mode);
 		return;
 	}
 
@@ -396,7 +400,7 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 	 * Something removed from the tree?
 	 */
 	if (!idx) {
-		diff_index_show_file(revs, "-", tree, tree->sha1, tree->ce_mode, 0);
+		diff_index_show_file(revs, "-", tree, tree->sha1, 1, tree->ce_mode, 0);
 		return;
 	}
 
diff --git a/diff-no-index.c b/diff-no-index.c
index 7d805a0..0b46a0f 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -82,7 +82,7 @@ static struct diff_filespec *noindex_filespec(const char *name, int mode)
 	if (!name)
 		name = "/dev/null";
 	s = alloc_filespec(name);
-	fill_filespec(s, null_sha1, mode);
+	fill_filespec(s, null_sha1, 0, mode);
 	if (name == file_from_standard_input)
 		populate_from_stdin(s);
 	return s;
diff --git a/diff.c b/diff.c
index 62cbe14..15125e8 100644
--- a/diff.c
+++ b/diff.c
@@ -2541,12 +2541,12 @@ void free_filespec(struct diff_filespec *spec)
 }
 
 void fill_filespec(struct diff_filespec *spec, const unsigned char *sha1,
-		   unsigned short mode)
+		   int sha1_valid, unsigned short mode)
 {
 	if (mode) {
 		spec->mode = canon_mode(mode);
 		hashcpy(spec->sha1, sha1);
-		spec->sha1_valid = !is_null_sha1(sha1);
+		spec->sha1_valid = sha1_valid;
 	}
 }
 
@@ -4693,6 +4693,7 @@ static int is_submodule_ignored(const char *path, struct diff_options *options)
 void diff_addremove(struct diff_options *options,
 		    int addremove, unsigned mode,
 		    const unsigned char *sha1,
+		    int sha1_valid,
 		    const char *concatpath, unsigned dirty_submodule)
 {
 	struct diff_filespec *one, *two;
@@ -4724,9 +4725,9 @@ void diff_addremove(struct diff_options *options,
 	two = alloc_filespec(concatpath);
 
 	if (addremove != '+')
-		fill_filespec(one, sha1, mode);
+		fill_filespec(one, sha1, sha1_valid, mode);
 	if (addremove != '-') {
-		fill_filespec(two, sha1, mode);
+		fill_filespec(two, sha1, sha1_valid, mode);
 		two->dirty_submodule = dirty_submodule;
 	}
 
@@ -4739,6 +4740,7 @@ void diff_change(struct diff_options *options,
 		 unsigned old_mode, unsigned new_mode,
 		 const unsigned char *old_sha1,
 		 const unsigned char *new_sha1,
+		 int old_sha1_valid, int new_sha1_valid,
 		 const char *concatpath,
 		 unsigned old_dirty_submodule, unsigned new_dirty_submodule)
 {
@@ -4753,6 +4755,8 @@ void diff_change(struct diff_options *options,
 		const unsigned char *tmp_c;
 		tmp = old_mode; old_mode = new_mode; new_mode = tmp;
 		tmp_c = old_sha1; old_sha1 = new_sha1; new_sha1 = tmp_c;
+		tmp = old_sha1_valid; old_sha1_valid = new_sha1_valid;
+			new_sha1_valid = tmp;
 		tmp = old_dirty_submodule; old_dirty_submodule = new_dirty_submodule;
 			new_dirty_submodule = tmp;
 	}
@@ -4763,8 +4767,8 @@ void diff_change(struct diff_options *options,
 
 	one = alloc_filespec(concatpath);
 	two = alloc_filespec(concatpath);
-	fill_filespec(one, old_sha1, old_mode);
-	fill_filespec(two, new_sha1, new_mode);
+	fill_filespec(one, old_sha1, old_sha1_valid, old_mode);
+	fill_filespec(two, new_sha1, new_sha1_valid, new_mode);
 	one->dirty_submodule = old_dirty_submodule;
 	two->dirty_submodule = new_dirty_submodule;
 
diff --git a/diff.h b/diff.h
index e027650..815dd7a 100644
--- a/diff.h
+++ b/diff.h
@@ -19,12 +19,14 @@ typedef void (*change_fn_t)(struct diff_options *options,
 		 unsigned old_mode, unsigned new_mode,
 		 const unsigned char *old_sha1,
 		 const unsigned char *new_sha1,
+		 int old_sha1_valid, int new_sha1_valid,
 		 const char *fullpath,
 		 unsigned old_dirty_submodule, unsigned new_dirty_submodule);
 
 typedef void (*add_remove_fn_t)(struct diff_options *options,
 		    int addremove, unsigned mode,
 		    const unsigned char *sha1,
+		    int sha1_valid,
 		    const char *fullpath, unsigned dirty_submodule);
 
 typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
@@ -214,12 +216,15 @@ extern void diff_addremove(struct diff_options *,
 			   int addremove,
 			   unsigned mode,
 			   const unsigned char *sha1,
+			   int sha1_valid,
 			   const char *fullpath, unsigned dirty_submodule);
 
 extern void diff_change(struct diff_options *,
 			unsigned mode1, unsigned mode2,
 			const unsigned char *sha1,
 			const unsigned char *sha2,
+			int sha1_valid,
+			int sha2_valid,
 			const char *fullpath,
 			unsigned dirty_submodule1, unsigned dirty_submodule2);
 
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 216a7a4..512d0ac 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -48,7 +48,7 @@ static struct diff_rename_dst *locate_rename_dst(struct diff_filespec *two,
 		memmove(rename_dst + first + 1, rename_dst + first,
 			(rename_dst_nr - first - 1) * sizeof(*rename_dst));
 	rename_dst[first].two = alloc_filespec(two->path);
-	fill_filespec(rename_dst[first].two, two->sha1, two->mode);
+	fill_filespec(rename_dst[first].two, two->sha1, two->sha1_valid, two->mode);
 	rename_dst[first].pair = NULL;
 	return &(rename_dst[first]);
 }
diff --git a/diffcore.h b/diffcore.h
index be0739c..1c16c85 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -55,7 +55,7 @@ struct diff_filespec {
 extern struct diff_filespec *alloc_filespec(const char *);
 extern void free_filespec(struct diff_filespec *);
 extern void fill_filespec(struct diff_filespec *, const unsigned char *,
-			  unsigned short);
+			  int, unsigned short);
 
 extern int diff_populate_filespec(struct diff_filespec *, int);
 extern void diff_free_filespec_data(struct diff_filespec *);
diff --git a/revision.c b/revision.c
index 9e8f47a..04c7de8 100644
--- a/revision.c
+++ b/revision.c
@@ -345,6 +345,7 @@ static int tree_difference = REV_TREE_SAME;
 static void file_add_remove(struct diff_options *options,
 		    int addremove, unsigned mode,
 		    const unsigned char *sha1,
+		    int sha1_valid,
 		    const char *fullpath, unsigned dirty_submodule)
 {
 	int diff = addremove == '+' ? REV_TREE_NEW : REV_TREE_OLD;
@@ -358,6 +359,7 @@ static void file_change(struct diff_options *options,
 		 unsigned old_mode, unsigned new_mode,
 		 const unsigned char *old_sha1,
 		 const unsigned char *new_sha1,
+		 int old_sha1_valid, int new_sha1_valid,
 		 const char *fullpath,
 		 unsigned old_dirty_submodule, unsigned new_dirty_submodule)
 {
diff --git a/t/t4054-diff-bogus-tree.sh b/t/t4054-diff-bogus-tree.sh
new file mode 100755
index 0000000..0843c87
--- /dev/null
+++ b/t/t4054-diff-bogus-tree.sh
@@ -0,0 +1,83 @@
+#!/bin/sh
+
+test_description='test diff with a bogus tree containing the null sha1'
+. ./test-lib.sh
+
+empty_tree=4b825dc642cb6eb9a060e54bf8d69288fbee4904
+
+test_expect_success 'create bogus tree' '
+	bogus_tree=$(
+		printf "100644 fooQQQQQQQQQQQQQQQQQQQQQ" |
+		q_to_nul |
+		git hash-object -w --stdin -t tree
+	)
+'
+
+test_expect_success 'create tree with matching file' '
+	echo bar >foo &&
+	git add foo &&
+	good_tree=$(git write-tree)
+	blob=$(git rev-parse :foo)
+'
+
+test_expect_success 'raw diff shows null sha1 (addition)' '
+	echo ":000000 100644 $_z40 $_z40 A	foo" >expect &&
+	git diff-tree $empty_tree $bogus_tree >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'raw diff shows null sha1 (removal)' '
+	echo ":100644 000000 $_z40 $_z40 D	foo" >expect &&
+	git diff-tree $bogus_tree $empty_tree >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'raw diff shows null sha1 (modification)' '
+	echo ":100644 100644 $blob $_z40 M	foo" >expect &&
+	git diff-tree $good_tree $bogus_tree >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'raw diff shows null sha1 (other direction)' '
+	echo ":100644 100644 $_z40 $blob M	foo" >expect &&
+	git diff-tree $bogus_tree $good_tree >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'raw diff shows null sha1 (reverse)' '
+	echo ":100644 100644 $_z40 $blob M	foo" >expect &&
+	git diff-tree -R $good_tree $bogus_tree >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'raw diff shows null sha1 (index)' '
+	echo ":100644 100644 $_z40 $blob M	foo" >expect &&
+	git diff-index $bogus_tree >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'patch fails due to bogus sha1 (addition)' '
+	test_must_fail git diff-tree -p $empty_tree $bogus_tree
+'
+
+test_expect_success 'patch fails due to bogus sha1 (removal)' '
+	test_must_fail git diff-tree -p $bogus_tree $empty_tree
+'
+
+test_expect_success 'patch fails due to bogus sha1 (modification)' '
+	test_must_fail git diff-tree -p $good_tree $bogus_tree
+'
+
+test_expect_success 'patch fails due to bogus sha1 (other direction)' '
+	test_must_fail git diff-tree -p $bogus_tree $good_tree
+'
+
+test_expect_success 'patch fails due to bogus sha1 (reverse)' '
+	test_must_fail git diff-tree -R -p $good_tree $bogus_tree
+'
+
+test_expect_success 'patch fails due to bogus sha1 (index)' '
+	test_must_fail git diff-index -p $bogus_tree
+'
+
+test_done
diff --git a/tree-diff.c b/tree-diff.c
index 28ad6db..7e54833 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -49,12 +49,12 @@ static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2,
 	if (DIFF_OPT_TST(opt, RECURSIVE) && S_ISDIR(mode1)) {
 		if (DIFF_OPT_TST(opt, TREE_IN_RECURSIVE)) {
 			opt->change(opt, mode1, mode2,
-				    sha1, sha2, base->buf, 0, 0);
+				    sha1, sha2, 1, 1, base->buf, 0, 0);
 		}
 		strbuf_addch(base, '/');
 		diff_tree_sha1(sha1, sha2, base->buf, opt);
 	} else {
-		opt->change(opt, mode1, mode2, sha1, sha2, base->buf, 0, 0);
+		opt->change(opt, mode1, mode2, sha1, sha2, 1, 1, base->buf, 0, 0);
 	}
 	strbuf_setlen(base, old_baselen);
 	return 0;
@@ -100,7 +100,7 @@ static void show_entry(struct diff_options *opt, const char *prefix,
 			die("corrupt tree sha %s", sha1_to_hex(sha1));
 
 		if (DIFF_OPT_TST(opt, TREE_IN_RECURSIVE))
-			opt->add_remove(opt, *prefix, mode, sha1, base->buf, 0);
+			opt->add_remove(opt, *prefix, mode, sha1, 1, base->buf, 0);
 
 		strbuf_addch(base, '/');
 
@@ -108,7 +108,7 @@ static void show_entry(struct diff_options *opt, const char *prefix,
 		show_tree(opt, prefix, &inner, base);
 		free(tree);
 	} else
-		opt->add_remove(opt, prefix[0], mode, sha1, base->buf, 0);
+		opt->add_remove(opt, prefix[0], mode, sha1, 1, base->buf, 0);
 
 	strbuf_setlen(base, old_baselen);
 }
-- 
1.7.11.3.42.g90758bf
