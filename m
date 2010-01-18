From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2] Performance optimization for detection of modified submodules
Date: Mon, 18 Jan 2010 21:26:18 +0100
Message-ID: <4B54C3EA.9090200@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 18 21:26:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWyBY-0006Up-OH
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 21:26:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754158Ab0ARU0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 15:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754169Ab0ARU0Y
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 15:26:24 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:37679 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754158Ab0ARU0V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 15:26:21 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 9353014535549;
	Mon, 18 Jan 2010 21:26:19 +0100 (CET)
Received: from [80.128.74.224] (helo=[192.168.178.26])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NWyB1-0003pm-00; Mon, 18 Jan 2010 21:26:19 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18E9ZulFywRo+DmS5kbzSv+ngeUtr1WJCa/sL9b
	Z4ZSbwNj8dgAT7xuIPU6Q3lMQDl7VJsmVt29isXFuumwxdQBp2
	aO8UdKtFTgYNiTrdjgOA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137399>

In the worst case is_submodule_modified() got called three times for
each submodule. The information we got from scanning the whole
submodule tree the first time should not be thrown away.

New parameters have been added to diff_change() and diff_addremove(),
the information is stored in a new member of struct diff_filespec. Its
value is then reused instead of calling is_submodule_modified() again.

When no explicit "-dirty" is needed in the output the call to
is_submodule_modified() is not necessary when the submodules HEAD
already disagrees with the ref of the superproject, as this alone
marks it as modified. To achieve that, get_stat_data() got an extra
argument.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---


Changed since the first version:

- diff_change() now has two dirty_submodule arguments, one for
  each side.

- If the submodules HEAD does not match the ref it is compared
  against, is_submodule_modified() is only called when the
  patch formatted output is requested.

- Changed the type of the new dirty_submodule flags to unsigned.

- Updated the commit message


 diff-lib.c  |   46 +++++++++++++++++++++++++++++++---------------
 diff.c      |   15 +++++++++++----
 diff.h      |   10 ++++++----
 diffcore.h  |    1 +
 revision.c  |    5 +++--
 tree-diff.c |    8 ++++----
 6 files changed, 56 insertions(+), 29 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 29c5915..ec2e2ac 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -73,6 +73,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		unsigned int oldmode, newmode;
 		struct cache_entry *ce = active_cache[i];
 		int changed;
+		unsigned dirty_submodule = 0;

 		if (DIFF_OPT_TST(&revs->diffopt, QUICK) &&
 			DIFF_OPT_TST(&revs->diffopt, HAS_CHANGES))
@@ -173,12 +174,16 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			if (silent_on_removed)
 				continue;
 			diff_addremove(&revs->diffopt, '-', ce->ce_mode,
-				       ce->sha1, ce->name);
+				       ce->sha1, ce->name, 0);
 			continue;
 		}
 		changed = ce_match_stat(ce, &st, ce_option);
-		if (S_ISGITLINK(ce->ce_mode) && !changed)
-			changed = is_submodule_modified(ce->name);
+		if (S_ISGITLINK(ce->ce_mode)
+		    && (!changed || (revs->diffopt.output_format & DIFF_FORMAT_PATCH))
+		    && is_submodule_modified(ce->name)) {
+			changed = 1;
+			dirty_submodule = 1;
+		}
 		if (!changed) {
 			ce_mark_uptodate(ce);
 			if (!DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER))
@@ -188,7 +193,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		newmode = ce_mode_from_stat(ce, st.st_mode);
 		diff_change(&revs->diffopt, oldmode, newmode,
 			    ce->sha1, (changed ? null_sha1 : ce->sha1),
-			    ce->name);
+			    ce->name, 0, dirty_submodule);

 	}
 	diffcore_std(&revs->diffopt);
@@ -204,16 +209,18 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 static void diff_index_show_file(struct rev_info *revs,
 				 const char *prefix,
 				 struct cache_entry *ce,
-				 const unsigned char *sha1, unsigned int mode)
+				 const unsigned char *sha1, unsigned int mode,
+				 unsigned dirty_submodule)
 {
 	diff_addremove(&revs->diffopt, prefix[0], mode,
-		       sha1, ce->name);
+		       sha1, ce->name, dirty_submodule);
 }

 static int get_stat_data(struct cache_entry *ce,
 			 const unsigned char **sha1p,
 			 unsigned int *modep,
-			 int cached, int match_missing)
+			 int cached, int match_missing,
+			 unsigned *dirty_submodule, int output_format)
 {
 	const unsigned char *sha1 = ce->sha1;
 	unsigned int mode = ce->ce_mode;
@@ -233,8 +240,13 @@ static int get_stat_data(struct cache_entry *ce,
 			return -1;
 		}
 		changed = ce_match_stat(ce, &st, 0);
-		if (changed
-		    || (S_ISGITLINK(ce->ce_mode) && is_submodule_modified(ce->name))) {
+		if (S_ISGITLINK(ce->ce_mode)
+		    && (!changed || (output_format & DIFF_FORMAT_PATCH))
+		    && is_submodule_modified(ce->name)) {
+			changed = 1;
+			*dirty_submodule = 1;
+		}
+		if (changed) {
 			mode = ce_mode_from_stat(ce, st.st_mode);
 			sha1 = null_sha1;
 		}
@@ -251,15 +263,17 @@ static void show_new_file(struct rev_info *revs,
 {
 	const unsigned char *sha1;
 	unsigned int mode;
+	unsigned dirty_submodule = 0;

 	/*
 	 * New file in the index: it might actually be different in
 	 * the working copy.
 	 */
-	if (get_stat_data(new, &sha1, &mode, cached, match_missing) < 0)
+	if (get_stat_data(new, &sha1, &mode, cached, match_missing,
+	    &dirty_submodule, revs->diffopt.output_format) < 0)
 		return;

-	diff_index_show_file(revs, "+", new, sha1, mode);
+	diff_index_show_file(revs, "+", new, sha1, mode, dirty_submodule);
 }

 static int show_modified(struct rev_info *revs,
@@ -270,11 +284,13 @@ static int show_modified(struct rev_info *revs,
 {
 	unsigned int mode, oldmode;
 	const unsigned char *sha1;
+	unsigned dirty_submodule = 0;

-	if (get_stat_data(new, &sha1, &mode, cached, match_missing) < 0) {
+	if (get_stat_data(new, &sha1, &mode, cached, match_missing,
+			  &dirty_submodule, revs->diffopt.output_format) < 0) {
 		if (report_missing)
 			diff_index_show_file(revs, "-", old,
-					     old->sha1, old->ce_mode);
+					     old->sha1, old->ce_mode, 0);
 		return -1;
 	}

@@ -309,7 +325,7 @@ static int show_modified(struct rev_info *revs,
 		return 0;

 	diff_change(&revs->diffopt, oldmode, mode,
-		    old->sha1, sha1, old->name);
+		    old->sha1, sha1, old->name, 0, dirty_submodule);
 	return 0;
 }

@@ -356,7 +372,7 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 	 * Something removed from the tree?
 	 */
 	if (!idx) {
-		diff_index_show_file(revs, "-", tree, tree->sha1, tree->ce_mode);
+		diff_index_show_file(revs, "-", tree, tree->sha1, tree->ce_mode, 0);
 		return;
 	}

diff --git a/diff.c b/diff.c
index 012b3d3..f130a36 100644
--- a/diff.c
+++ b/diff.c
@@ -2032,7 +2032,7 @@ static int diff_populate_gitlink(struct diff_filespec *s, int size_only)
 	char *data = xmalloc(100), *dirty = "";

 	/* Are we looking at the work tree? */
-	if (!s->sha1_valid && is_submodule_modified(s->path))
+	if (!s->sha1_valid && s->dirty_submodule)
 		dirty = "-dirty";

 	len = snprintf(data, 100,
@@ -3736,7 +3736,7 @@ int diff_result_code(struct diff_options *opt, int status)
 void diff_addremove(struct diff_options *options,
 		    int addremove, unsigned mode,
 		    const unsigned char *sha1,
-		    const char *concatpath)
+		    const char *concatpath, unsigned dirty_submodule)
 {
 	struct diff_filespec *one, *two;

@@ -3768,8 +3768,10 @@ void diff_addremove(struct diff_options *options,

 	if (addremove != '+')
 		fill_filespec(one, sha1, mode);
-	if (addremove != '-')
+	if (addremove != '-') {
 		fill_filespec(two, sha1, mode);
+		two->dirty_submodule = dirty_submodule;
+	}

 	diff_queue(&diff_queued_diff, one, two);
 	if (!DIFF_OPT_TST(options, DIFF_FROM_CONTENTS))
@@ -3780,7 +3782,8 @@ void diff_change(struct diff_options *options,
 		 unsigned old_mode, unsigned new_mode,
 		 const unsigned char *old_sha1,
 		 const unsigned char *new_sha1,
-		 const char *concatpath)
+		 const char *concatpath,
+		 unsigned old_dirty_submodule, unsigned new_dirty_submodule)
 {
 	struct diff_filespec *one, *two;

@@ -3793,6 +3796,8 @@ void diff_change(struct diff_options *options,
 		const unsigned char *tmp_c;
 		tmp = old_mode; old_mode = new_mode; new_mode = tmp;
 		tmp_c = old_sha1; old_sha1 = new_sha1; new_sha1 = tmp_c;
+		tmp = old_dirty_submodule; old_dirty_submodule = new_dirty_submodule;
+			new_dirty_submodule = tmp;
 	}

 	if (options->prefix &&
@@ -3803,6 +3808,8 @@ void diff_change(struct diff_options *options,
 	two = alloc_filespec(concatpath);
 	fill_filespec(one, old_sha1, old_mode);
 	fill_filespec(two, new_sha1, new_mode);
+	one->dirty_submodule = old_dirty_submodule;
+	two->dirty_submodule = new_dirty_submodule;

 	diff_queue(&diff_queued_diff, one, two);
 	if (!DIFF_OPT_TST(options, DIFF_FROM_CONTENTS))
diff --git a/diff.h b/diff.h
index 06a9a88..2ef3341 100644
--- a/diff.h
+++ b/diff.h
@@ -14,12 +14,13 @@ typedef void (*change_fn_t)(struct diff_options *options,
 		 unsigned old_mode, unsigned new_mode,
 		 const unsigned char *old_sha1,
 		 const unsigned char *new_sha1,
-		 const char *fullpath);
+		 const char *fullpath,
+		 unsigned old_dirty_submodule, unsigned new_dirty_submodule);

 typedef void (*add_remove_fn_t)(struct diff_options *options,
 		    int addremove, unsigned mode,
 		    const unsigned char *sha1,
-		    const char *fullpath);
+		    const char *fullpath, unsigned dirty_submodule);

 typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 		struct diff_options *options, void *data);
@@ -177,13 +178,14 @@ extern void diff_addremove(struct diff_options *,
 			   int addremove,
 			   unsigned mode,
 			   const unsigned char *sha1,
-			   const char *fullpath);
+			   const char *fullpath, unsigned dirty_submodule);

 extern void diff_change(struct diff_options *,
 			unsigned mode1, unsigned mode2,
 			const unsigned char *sha1,
 			const unsigned char *sha2,
-			const char *fullpath);
+			const char *fullpath,
+			unsigned dirty_submodule1, unsigned dirty_submodule2);

 extern void diff_unmerge(struct diff_options *,
 			 const char *path,
diff --git a/diffcore.h b/diffcore.h
index 5b63458..66687c3 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -42,6 +42,7 @@ struct diff_filespec {
 #define DIFF_FILE_VALID(spec) (((spec)->mode) != 0)
 	unsigned should_free : 1; /* data should be free()'ed */
 	unsigned should_munmap : 1; /* data should be munmap()'ed */
+	unsigned dirty_submodule : 1;  /* For submodules: its work tree is dirty */

 	struct userdiff_driver *driver;
 	/* data should be considered "binary"; -1 means "don't know yet" */
diff --git a/revision.c b/revision.c
index 25fa14d..769cfd4 100644
--- a/revision.c
+++ b/revision.c
@@ -268,7 +268,7 @@ static int tree_difference = REV_TREE_SAME;
 static void file_add_remove(struct diff_options *options,
 		    int addremove, unsigned mode,
 		    const unsigned char *sha1,
-		    const char *fullpath)
+		    const char *fullpath, unsigned dirty_submodule)
 {
 	int diff = addremove == '+' ? REV_TREE_NEW : REV_TREE_OLD;

@@ -281,7 +281,8 @@ static void file_change(struct diff_options *options,
 		 unsigned old_mode, unsigned new_mode,
 		 const unsigned char *old_sha1,
 		 const unsigned char *new_sha1,
-		 const char *fullpath)
+		 const char *fullpath,
+		 unsigned old_dirty_submodule, unsigned new_dirty_submodule)
 {
 	tree_difference = REV_TREE_DIFFERENT;
 	DIFF_OPT_SET(options, HAS_CHANGES);
diff --git a/tree-diff.c b/tree-diff.c
index 7d745b4..fe9f52c 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -68,7 +68,7 @@ static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2, const
 		if (DIFF_OPT_TST(opt, TREE_IN_RECURSIVE)) {
 			newbase[baselen + pathlen1] = 0;
 			opt->change(opt, mode1, mode2,
-				    sha1, sha2, newbase);
+				    sha1, sha2, newbase, 0, 0);
 			newbase[baselen + pathlen1] = '/';
 		}
 		retval = diff_tree_sha1(sha1, sha2, newbase, opt);
@@ -77,7 +77,7 @@ static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2, const
 	}

 	fullname = malloc_fullname(base, baselen, path1, pathlen1);
-	opt->change(opt, mode1, mode2, sha1, sha2, fullname);
+	opt->change(opt, mode1, mode2, sha1, sha2, fullname, 0, 0);
 	free(fullname);
 	return 0;
 }
@@ -241,7 +241,7 @@ static void show_entry(struct diff_options *opt, const char *prefix, struct tree

 		if (DIFF_OPT_TST(opt, TREE_IN_RECURSIVE)) {
 			newbase[baselen + pathlen] = 0;
-			opt->add_remove(opt, *prefix, mode, sha1, newbase);
+			opt->add_remove(opt, *prefix, mode, sha1, newbase, 0);
 			newbase[baselen + pathlen] = '/';
 		}

@@ -252,7 +252,7 @@ static void show_entry(struct diff_options *opt, const char *prefix, struct tree
 		free(newbase);
 	} else {
 		char *fullname = malloc_fullname(base, baselen, path, pathlen);
-		opt->add_remove(opt, prefix[0], mode, sha1, fullname);
+		opt->add_remove(opt, prefix[0], mode, sha1, fullname, 0);
 		free(fullname);
 	}
 }
-- 
1.6.6.444.g4e34e.dirty
