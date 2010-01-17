From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] Performance optimization for detection of modified submodules
Date: Sun, 17 Jan 2010 20:01:43 +0100
Message-ID: <4B535E97.1020809@web.de>
References: <4B4BA096.5000909@web.de> <7vtyusb6rv.fsf@alter.siamese.dyndns.org> <4B4CA13F.6020505@web.de> <7vbpgyqy4a.fsf@alter.siamese.dyndns.org> <4B4E1817.1070202@web.de> <7v6375lkpj.fsf@alter.siamese.dyndns.org> <4B4F8EF1.3080709@web.de> <7v3a288em2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Lars Hjemli <hjemli@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 17 20:09:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWaVM-0008Lo-Iw
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 20:09:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754442Ab0AQTJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 14:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754371Ab0AQTJk
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 14:09:40 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:35406 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754300Ab0AQTJj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 14:09:39 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 55CE813C3CD61;
	Sun, 17 Jan 2010 20:09:37 +0100 (CET)
Received: from [80.128.115.167] (helo=[192.168.178.26])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NWaNf-00031v-00; Sun, 17 Jan 2010 20:01:47 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <7v3a288em2.fsf@alter.siamese.dyndns.org>
X-Provags-ID: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137309>

In the worst case is_submodule_modified() got called three times for
each submodule. The information we got from scanning the whole
submodule tree the first time should not be thrown away.

A new parameter has been added to diff_change() and diff_addremove(),
the information is stored in a new member of struct diff_filespec. Its
value is then reused instead of calling is_submodule_modified() again.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---


Am 15.01.2010 00:13, schrieb Junio C Hamano:
> The existing code is a bit unfortunate; by the time we come to the output
> routine, the information we found from is_submodule_modified() is lost;
> that is why my "would look like this" patch calls is_submodule_modified().
>
> We may want to add one parameter to diff_change() and diff_addremove(), to
> tell them if the work-tree side (if we are comparing something with the
> work tree) is a modified submodule, and add one bit to the diff_filespec
> structure to record that in diff_change() and diff_addremove() (obviously
> only when adding).  That way, my "would looks like this" patch needs to
> check the result of is_submodule_modified() the front-ends left in the
> filespec, instead of running it again.

So here is my first attempt of implementing your proposal. The test suite
runs fine, but a few more eyeballs would really be appreciated as i am not
very familiar with the code and its corner cases (See diff_change(), is it
sufficient to only set "two->dirty_submodule", even if the REVERSE_DIFF
option is set? Apart from that i am not so sure about the four changes to
tree-diff.c).

I think we could skip the call to is_submodule_modified() in
run_diff_files() and get_stat_data() when the changed flag is already
set and only short output (without calling diff_populate_gitlink(), e.g.
"git status -s" or "git diff-files") is requested. What do you think
about doing that in a seperate patch?



 diff-lib.c  |   42 +++++++++++++++++++++++++++---------------
 diff.c      |   11 +++++++----
 diff.h      |    8 ++++----
 diffcore.h  |    1 +
 revision.c  |    4 ++--
 tree-diff.c |    8 ++++----
 6 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 29c5915..5b18d86 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -73,6 +73,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		unsigned int oldmode, newmode;
 		struct cache_entry *ce = active_cache[i];
 		int changed;
+		int dirty_submodule = 0;

 		if (DIFF_OPT_TST(&revs->diffopt, QUICK) &&
 			DIFF_OPT_TST(&revs->diffopt, HAS_CHANGES))
@@ -173,12 +174,14 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
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
+		if (S_ISGITLINK(ce->ce_mode) && is_submodule_modified(ce->name)) {
+			changed = 1;
+			dirty_submodule = 1;
+		}
 		if (!changed) {
 			ce_mark_uptodate(ce);
 			if (!DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER))
@@ -188,7 +191,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		newmode = ce_mode_from_stat(ce, st.st_mode);
 		diff_change(&revs->diffopt, oldmode, newmode,
 			    ce->sha1, (changed ? null_sha1 : ce->sha1),
-			    ce->name);
+			    ce->name, dirty_submodule);

 	}
 	diffcore_std(&revs->diffopt);
@@ -204,16 +207,18 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 static void diff_index_show_file(struct rev_info *revs,
 				 const char *prefix,
 				 struct cache_entry *ce,
-				 const unsigned char *sha1, unsigned int mode)
+				 const unsigned char *sha1, unsigned int mode,
+				 int dirty_submodule)
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
+			 int *dirty_submodule)
 {
 	const unsigned char *sha1 = ce->sha1;
 	unsigned int mode = ce->ce_mode;
@@ -233,8 +238,11 @@ static int get_stat_data(struct cache_entry *ce,
 			return -1;
 		}
 		changed = ce_match_stat(ce, &st, 0);
-		if (changed
-		    || (S_ISGITLINK(ce->ce_mode) && is_submodule_modified(ce->name))) {
+		if (S_ISGITLINK(ce->ce_mode) && is_submodule_modified(ce->name)) {
+			changed = 1;
+			*dirty_submodule = 1;
+		}
+		if (changed) {
 			mode = ce_mode_from_stat(ce, st.st_mode);
 			sha1 = null_sha1;
 		}
@@ -251,15 +259,17 @@ static void show_new_file(struct rev_info *revs,
 {
 	const unsigned char *sha1;
 	unsigned int mode;
+	int dirty_submodule = 0;

 	/*
 	 * New file in the index: it might actually be different in
 	 * the working copy.
 	 */
-	if (get_stat_data(new, &sha1, &mode, cached, match_missing) < 0)
+	if (get_stat_data(new, &sha1, &mode, cached, match_missing,
+	    &dirty_submodule) < 0)
 		return;

-	diff_index_show_file(revs, "+", new, sha1, mode);
+	diff_index_show_file(revs, "+", new, sha1, mode, dirty_submodule);
 }

 static int show_modified(struct rev_info *revs,
@@ -270,11 +280,13 @@ static int show_modified(struct rev_info *revs,
 {
 	unsigned int mode, oldmode;
 	const unsigned char *sha1;
+	int dirty_submodule = 0;

-	if (get_stat_data(new, &sha1, &mode, cached, match_missing) < 0) {
+	if (get_stat_data(new, &sha1, &mode, cached, match_missing,
+			  &dirty_submodule) < 0) {
 		if (report_missing)
 			diff_index_show_file(revs, "-", old,
-					     old->sha1, old->ce_mode);
+					     old->sha1, old->ce_mode, 0);
 		return -1;
 	}

@@ -309,7 +321,7 @@ static int show_modified(struct rev_info *revs,
 		return 0;

 	diff_change(&revs->diffopt, oldmode, mode,
-		    old->sha1, sha1, old->name);
+		    old->sha1, sha1, old->name, dirty_submodule);
 	return 0;
 }

@@ -356,7 +368,7 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 	 * Something removed from the tree?
 	 */
 	if (!idx) {
-		diff_index_show_file(revs, "-", tree, tree->sha1, tree->ce_mode);
+		diff_index_show_file(revs, "-", tree, tree->sha1, tree->ce_mode, 0);
 		return;
 	}

diff --git a/diff.c b/diff.c
index 012b3d3..490a7ec 100644
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
+		    const char *concatpath, int dirty_submodule)
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
@@ -3780,7 +3782,7 @@ void diff_change(struct diff_options *options,
 		 unsigned old_mode, unsigned new_mode,
 		 const unsigned char *old_sha1,
 		 const unsigned char *new_sha1,
-		 const char *concatpath)
+		 const char *concatpath, int dirty_submodule)
 {
 	struct diff_filespec *one, *two;

@@ -3803,6 +3805,7 @@ void diff_change(struct diff_options *options,
 	two = alloc_filespec(concatpath);
 	fill_filespec(one, old_sha1, old_mode);
 	fill_filespec(two, new_sha1, new_mode);
+	two->dirty_submodule = dirty_submodule;

 	diff_queue(&diff_queued_diff, one, two);
 	if (!DIFF_OPT_TST(options, DIFF_FROM_CONTENTS))
diff --git a/diff.h b/diff.h
index 06a9a88..13596c2 100644
--- a/diff.h
+++ b/diff.h
@@ -14,12 +14,12 @@ typedef void (*change_fn_t)(struct diff_options *options,
 		 unsigned old_mode, unsigned new_mode,
 		 const unsigned char *old_sha1,
 		 const unsigned char *new_sha1,
-		 const char *fullpath);
+		 const char *fullpath, int dirty_submodule);

 typedef void (*add_remove_fn_t)(struct diff_options *options,
 		    int addremove, unsigned mode,
 		    const unsigned char *sha1,
-		    const char *fullpath);
+		    const char *fullpath, int dirty_submodule);

 typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 		struct diff_options *options, void *data);
@@ -177,13 +177,13 @@ extern void diff_addremove(struct diff_options *,
 			   int addremove,
 			   unsigned mode,
 			   const unsigned char *sha1,
-			   const char *fullpath);
+			   const char *fullpath, int dirty_submodule);

 extern void diff_change(struct diff_options *,
 			unsigned mode1, unsigned mode2,
 			const unsigned char *sha1,
 			const unsigned char *sha2,
-			const char *fullpath);
+			const char *fullpath, int dirty_submodule);

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
index 25fa14d..e95cc41 100644
--- a/revision.c
+++ b/revision.c
@@ -268,7 +268,7 @@ static int tree_difference = REV_TREE_SAME;
 static void file_add_remove(struct diff_options *options,
 		    int addremove, unsigned mode,
 		    const unsigned char *sha1,
-		    const char *fullpath)
+		    const char *fullpath, int dirty_submodule)
 {
 	int diff = addremove == '+' ? REV_TREE_NEW : REV_TREE_OLD;

@@ -281,7 +281,7 @@ static void file_change(struct diff_options *options,
 		 unsigned old_mode, unsigned new_mode,
 		 const unsigned char *old_sha1,
 		 const unsigned char *new_sha1,
-		 const char *fullpath)
+		 const char *fullpath, int dirty_submodule)
 {
 	tree_difference = REV_TREE_DIFFERENT;
 	DIFF_OPT_SET(options, HAS_CHANGES);
diff --git a/tree-diff.c b/tree-diff.c
index 7d745b4..2ef0c77 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -68,7 +68,7 @@ static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2, const
 		if (DIFF_OPT_TST(opt, TREE_IN_RECURSIVE)) {
 			newbase[baselen + pathlen1] = 0;
 			opt->change(opt, mode1, mode2,
-				    sha1, sha2, newbase);
+				    sha1, sha2, newbase, 0);
 			newbase[baselen + pathlen1] = '/';
 		}
 		retval = diff_tree_sha1(sha1, sha2, newbase, opt);
@@ -77,7 +77,7 @@ static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2, const
 	}

 	fullname = malloc_fullname(base, baselen, path1, pathlen1);
-	opt->change(opt, mode1, mode2, sha1, sha2, fullname);
+	opt->change(opt, mode1, mode2, sha1, sha2, fullname, 0);
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
1.6.6.327.g4c0c1.dirty
