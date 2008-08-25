From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] merge-recursive: introduce merge_options
Date: Mon, 25 Aug 2008 16:25:57 +0200
Message-ID: <1219674357-31000-1-git-send-email-vmiklos@frugalware.org>
References: <7v7ia5iq7l.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 16:32:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXd1i-0005YG-ES
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 16:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754071AbYHYOZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 10:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754039AbYHYOZb
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 10:25:31 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:58487 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754015AbYHYOZa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 10:25:30 -0400
Received: from vmobile.example.net (dhcp-116.st.wlan.bme.hu [152.66.147.116])
	by yugo.frugalware.org (Postfix) with ESMTP id 038AC1DDC5B;
	Mon, 25 Aug 2008 16:25:24 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id D2ED396F8; Mon, 25 Aug 2008 16:25:57 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc3.17.gc14c8.dirty
In-Reply-To: <7v7ia5iq7l.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93628>

This makes it possible to avoid passing the labels of branches as
arguments to merge_recursive(), merge_trees() and
merge_recursive_generic().

It also takes care of subtree merge, output buffering, verbosity, and
rename limits - these were global variables till now in
merge-recursive.c.

A new function, named init_merge_options(), is introduced as well, it
clears the struct merge_info, then initializes with default values,
finally updates the default values based on the config and environment
variables.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Sun, Aug 24, 2008 at 11:06:06PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Miklos Vajna <vmiklos@frugalware.org> writes:
>
> > 1) This applies on top of 1c868d4 (merge-recursive.c: Add more
> > generic
> > merge_recursive_generic()). I can rebase this (along with 1c868d4
> > and
> > 1c868d4^) on top of current master, if this is a problem.
>
> It probably is cleaner to treat this as a fresh topic from scratch on
> top
> of 'master', as we do not have anything outstanding in 'next' around
> this
> area.

I'm now confused about what should I do:

1) Nothing. (That's what I did for now.)

2) Rebase against master and resend.

3) Rebase, squash and resend.

> > 2) I know that this patch is huge, but we want to have the verbosity
> > flag in merge_options, so it has to be passed as an argument in many
> > places.
>
> Size of the patch that results purely from addition of the
> merge_options
> parameter from top to bottom does not bother me too much.  The look
> quite
> straightforward conversions, and getting rid of these many global
> variables is a major step in the right direction.
>
> It might however be a good idea to consistently have this at the same
> place (either the beginning or at the end) of the parameter list of
> functions that take one.

OK, I'll move them to the beginning, since that's what we have for the
public functions already.

> > @@ -1273,10 +1268,11 @@ int merge_recursive(struct commit *h1,
> >              * "conflicts" were already resolved.
> >              */
> >             discard_cache();
> > -           merge_recursive(merged_common_ancestors, iter->item,
> > -                           "Temporary merge branch 1",
> > -                           "Temporary merge branch 2",
> > -                           NULL,
> > +           memcpy(&opts, o, sizeof(struct merge_options));
> > +           opts.branch1 = "Temporary merge branch 1";
> > +           opts.branch2 = "Temporary merge branch 2";
> > +           merge_recursive(&opts, merged_common_ancestors,
> > +                           iter->item, NULL,
> >                             &merged_common_ancestors);
> >             call_depth--;
>
> After suggesting to keep label in merge_options, I was wondering how
> this
> part should be handled the best.  An alternative would be not to do
> copy
> the structure but stash away only branch1 and branch2 members before
> making the recursive call and restore them after it returns, like
> this:
>
>               const char *saved_b1, *saved_b2;
>               ...
>               saved_b1 = o->branch1;
>               saved_b2 = o->branch2;
>               o->branch1 = "Temporary merge branch 1";
>               o->branch2 = "Temporary merge branch 2";
>               merge_recursive(o, ...);
>               o->branch1 = saved_b1;
>               o->branch2 = saved_b2;
>               call_depth--;
>               ...
>
> This might be better in the longer run, as we may want to pass *back*
> status from merge_recursive() to the caller in fields of merge_options
> in
> the future.

True, changed.

Interdiff:

git fetch git://repo.or.cz/git/vmiklos.git
git diff 2ff6553..8faf3ac

 builtin-checkout.c        |   11 ++-
 builtin-merge-recursive.c |   43 ++++----
 merge-recursive.c         |  260 +++++++++++++++++++++++----------------------
 merge-recursive.h         |   42 +++++---
 4 files changed, 190 insertions(+), 166 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 411cc51..3627996 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -264,6 +264,7 @@ static int merge_working_tree(struct checkout_opts *opts,
 			 */
 			struct tree *result;
 			struct tree *work;
+			struct merge_options o;
 			if (!opts->merge)
 				return 1;
 			parse_commit(old->commit);
@@ -282,13 +283,17 @@ static int merge_working_tree(struct checkout_opts *opts,
 			 */
 
 			add_files_to_cache(NULL, NULL, 0);
-			work = write_tree_from_memory();
+			init_merge_options(&o);
+			o.verbosity = 0;
+			work = write_tree_from_memory(&o);
 
 			ret = reset_tree(new->commit->tree, opts, 1);
 			if (ret)
 				return ret;
-			merge_trees(new->commit->tree, work, old->commit->tree,
-				    new->name, "local", &result);
+			o.branch1 = new->name;
+			o.branch2 = "local";
+			merge_trees(&o, new->commit->tree, work,
+				old->commit->tree, &result);
 			ret = reset_tree(new->commit->tree, opts, 0);
 			if (ret)
 				return ret;
diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index 25f540b..6b534c1 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -17,32 +17,33 @@ static const char *better_branch_name(const char *branch)
 
 int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 {
-	const char *bases[21];
+	const unsigned char *bases[21];
 	unsigned bases_count = 0;
 	int i, failed;
-	const char *branch1, *branch2;
 	unsigned char h1[20], h2[20];
-	int subtree_merge = 0;
+	struct merge_options o;
+	struct commit *result;
 
+	init_merge_options(&o);
 	if (argv[0]) {
 		int namelen = strlen(argv[0]);
 		if (8 < namelen &&
 		    !strcmp(argv[0] + namelen - 8, "-subtree"))
-			subtree_merge = 1;
+			o.subtree_merge = 1;
 	}
 
-	git_config(merge_recursive_config, NULL);
-	merge_recursive_setup(subtree_merge);
 	if (argc < 4)
 		die("Usage: %s <base>... -- <head> <remote> ...\n", argv[0]);
 
 	for (i = 1; i < argc; ++i) {
-		if (!strcmp(argv[i], "--")) {
-			bases[bases_count] = NULL;
+		if (!strcmp(argv[i], "--"))
 			break;
+		if (bases_count < ARRAY_SIZE(bases)-1) {
+			unsigned char *sha = xmalloc(20);
+			if (get_sha1(argv[i], sha))
+				die("Could not parse object '%s'", argv[i]);
+			bases[bases_count++] = sha;
 		}
-		if (bases_count < ARRAY_SIZE(bases)-1)
-			bases[bases_count++] = argv[i];
 		else
 			warning("Cannot handle more than %zu bases. "
 				"Ignoring %s.", ARRAY_SIZE(bases)-1, argv[i]);
@@ -50,21 +51,21 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 	if (argc - i != 3) /* "--" "<head>" "<remote>" */
 		die("Not handling anything other than two heads merge.");
 
-	branch1 = argv[++i];
-	branch2 = argv[++i];
+	o.branch1 = argv[++i];
+	o.branch2 = argv[++i];
 
-	if (get_sha1(branch1, h1))
-		die("Could not resolve ref '%s'", branch1);
-	if (get_sha1(branch2, h2))
-		die("Could not resolve ref '%s'", branch2);
+	if (get_sha1(o.branch1, h1))
+		die("Could not resolve ref '%s'", o.branch1);
+	if (get_sha1(o.branch2, h2))
+		die("Could not resolve ref '%s'", o.branch2);
 
-	branch1 = better_branch_name(branch1);
-	branch2 = better_branch_name(branch2);
+	o.branch1 = better_branch_name(o.branch1);
+	o.branch2 = better_branch_name(o.branch2);
 
-	if (merge_recursive_verbosity >= 3)
-		printf("Merging %s with %s\n", branch1, branch2);
+	if (o.verbosity >= 3)
+		printf("Merging %s with %s\n", o.branch1, o.branch2);
 
-	failed = merge_recursive_generic(bases, h1, branch1, h2, branch2);
+	failed = merge_recursive_generic(&o, h1, h2, bases_count, bases, &result);
 	if (failed < 0)
 		return 128; /* die() error code */
 	return failed;
diff --git a/merge-recursive.c b/merge-recursive.c
index 74a9fdc..5fab301 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -83,16 +83,11 @@ static struct string_list current_file_set = {NULL, 0, 0, 1};
 static struct string_list current_directory_set = {NULL, 0, 0, 1};
 
 static int call_depth = 0;
-int merge_recursive_verbosity = 2;
-static int diff_rename_limit = -1;
-static int merge_rename_limit = -1;
-static int buffer_output = 1;
 static struct strbuf obuf = STRBUF_INIT;
 
-static int show(int v)
+static int show(struct merge_options *o, int v)
 {
-	return (!call_depth && merge_recursive_verbosity >= v) ||
-		merge_recursive_verbosity >= 5;
+	return (!call_depth && o->verbosity >= v) || o->verbosity >= 5;
 }
 
 static void flush_output(void)
@@ -103,12 +98,12 @@ static void flush_output(void)
 	}
 }
 
-static void output(int v, const char *fmt, ...)
+static void output(struct merge_options *o, int v, const char *fmt, ...)
 {
 	int len;
 	va_list ap;
 
-	if (!show(v))
+	if (!show(o, v))
 		return;
 
 	strbuf_grow(&obuf, call_depth * 2 + 2);
@@ -132,7 +127,7 @@ static void output(int v, const char *fmt, ...)
 	}
 	strbuf_setlen(&obuf, obuf.len + len);
 	strbuf_add(&obuf, "\n", 1);
-	if (!buffer_output)
+	if (!o->buffer_output)
 		flush_output();
 }
 
@@ -219,17 +214,17 @@ static int git_merge_trees(int index_only,
 	return rc;
 }
 
-struct tree *write_tree_from_memory(void)
+struct tree *write_tree_from_memory(struct merge_options *o)
 {
 	struct tree *result = NULL;
 
 	if (unmerged_cache()) {
 		int i;
-		output(0, "There are unmerged index entries:");
+		output(o, 0, "There are unmerged index entries:");
 		for (i = 0; i < active_nr; i++) {
 			struct cache_entry *ce = active_cache[i];
 			if (ce_stage(ce))
-				output(0, "%d %.*s", ce_stage(ce), ce_namelen(ce), ce->name);
+				output(o, 0, "%d %.*s", ce_stage(ce), ce_namelen(ce), ce->name);
 		}
 		return NULL;
 	}
@@ -341,11 +336,12 @@ struct rename
  * 'b_tree') to be able to associate the correct cache entries with
  * the rename information. 'tree' is always equal to either a_tree or b_tree.
  */
-static struct string_list *get_renames(struct tree *tree,
-					struct tree *o_tree,
-					struct tree *a_tree,
-					struct tree *b_tree,
-					struct string_list *entries)
+static struct string_list *get_renames(struct merge_options *o,
+				       struct tree *tree,
+				       struct tree *o_tree,
+				       struct tree *a_tree,
+				       struct tree *b_tree,
+				       struct string_list *entries)
 {
 	int i;
 	struct string_list *renames;
@@ -355,8 +351,8 @@ static struct string_list *get_renames(struct tree *tree,
 	diff_setup(&opts);
 	DIFF_OPT_SET(&opts, RECURSIVE);
 	opts.detect_rename = DIFF_DETECT_RENAME;
-	opts.rename_limit = merge_rename_limit >= 0 ? merge_rename_limit :
-			    diff_rename_limit >= 0 ? diff_rename_limit :
+	opts.rename_limit = o->merge_rename_limit >= 0 ? o->merge_rename_limit :
+			    o->diff_rename_limit >= 0 ? o->diff_rename_limit :
 			    500;
 	opts.warn_on_too_large_rename = 1;
 	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
@@ -717,7 +713,8 @@ static struct merge_file_info merge_file(struct diff_filespec *o,
 	return result;
 }
 
-static void conflict_rename_rename(struct rename *ren1,
+static void conflict_rename_rename(struct merge_options *o,
+				   struct rename *ren1,
 				   const char *branch1,
 				   struct rename *ren2,
 				   const char *branch2)
@@ -730,13 +727,13 @@ static void conflict_rename_rename(struct rename *ren1,
 	const char *dst_name2 = ren2_dst;
 	if (string_list_has_string(&current_directory_set, ren1_dst)) {
 		dst_name1 = del[delp++] = unique_path(ren1_dst, branch1);
-		output(1, "%s is a directory in %s added as %s instead",
+		output(o, 1, "%s is a directory in %s added as %s instead",
 		       ren1_dst, branch2, dst_name1);
 		remove_file(0, ren1_dst, 0);
 	}
 	if (string_list_has_string(&current_directory_set, ren2_dst)) {
 		dst_name2 = del[delp++] = unique_path(ren2_dst, branch2);
-		output(1, "%s is a directory in %s added as %s instead",
+		output(o, 1, "%s is a directory in %s added as %s instead",
 		       ren2_dst, branch1, dst_name2);
 		remove_file(0, ren2_dst, 0);
 	}
@@ -757,24 +754,26 @@ static void conflict_rename_rename(struct rename *ren1,
 		free(del[delp]);
 }
 
-static void conflict_rename_dir(struct rename *ren1,
+static void conflict_rename_dir(struct merge_options *o,
+				struct rename *ren1,
 				const char *branch1)
 {
 	char *new_path = unique_path(ren1->pair->two->path, branch1);
-	output(1, "Renamed %s to %s instead", ren1->pair->one->path, new_path);
+	output(o, 1, "Renamed %s to %s instead", ren1->pair->one->path, new_path);
 	remove_file(0, ren1->pair->two->path, 0);
 	update_file(0, ren1->pair->two->sha1, ren1->pair->two->mode, new_path);
 	free(new_path);
 }
 
-static void conflict_rename_rename_2(struct rename *ren1,
+static void conflict_rename_rename_2(struct merge_options *o,
+				     struct rename *ren1,
 				     const char *branch1,
 				     struct rename *ren2,
 				     const char *branch2)
 {
 	char *new_path1 = unique_path(ren1->pair->two->path, branch1);
 	char *new_path2 = unique_path(ren2->pair->two->path, branch2);
-	output(1, "Renamed %s to %s and %s to %s instead",
+	output(o, 1, "Renamed %s to %s and %s to %s instead",
 	       ren1->pair->one->path, new_path1,
 	       ren2->pair->one->path, new_path2);
 	remove_file(0, ren1->pair->two->path, 0);
@@ -784,10 +783,9 @@ static void conflict_rename_rename_2(struct rename *ren1,
 	free(new_path1);
 }
 
-static int process_renames(struct string_list *a_renames,
-			   struct string_list *b_renames,
-			   const char *a_branch,
-			   const char *b_branch)
+static int process_renames(struct merge_options *o,
+			   struct string_list *a_renames,
+			   struct string_list *b_renames)
 {
 	int clean_merge = 1, i, j;
 	struct string_list a_by_dst = {NULL, 0, 0, 0}, b_by_dst = {NULL, 0, 0, 0};
@@ -832,15 +830,15 @@ static int process_renames(struct string_list *a_renames,
 			renames1 = a_renames;
 			renames2 = b_renames;
 			renames2Dst = &b_by_dst;
-			branch1 = a_branch;
-			branch2 = b_branch;
+			branch1 = o->branch1;
+			branch2 = o->branch2;
 		} else {
 			struct rename *tmp;
 			renames1 = b_renames;
 			renames2 = a_renames;
 			renames2Dst = &a_by_dst;
-			branch1 = b_branch;
-			branch2 = a_branch;
+			branch1 = o->branch2;
+			branch2 = o->branch1;
 			tmp = ren2;
 			ren2 = ren1;
 			ren1 = tmp;
@@ -867,7 +865,7 @@ static int process_renames(struct string_list *a_renames,
 			ren2->processed = 1;
 			if (strcmp(ren1_dst, ren2_dst) != 0) {
 				clean_merge = 0;
-				output(1, "CONFLICT (rename/rename): "
+				output(o, 1, "CONFLICT (rename/rename): "
 				       "Rename \"%s\"->\"%s\" in branch \"%s\" "
 				       "rename \"%s\"->\"%s\" in \"%s\"%s",
 				       src, ren1_dst, branch1,
@@ -878,7 +876,7 @@ static int process_renames(struct string_list *a_renames,
 					update_file(0, ren1->pair->one->sha1,
 						    ren1->pair->one->mode, src);
 				}
-				conflict_rename_rename(ren1, branch1, ren2, branch2);
+				conflict_rename_rename(o, ren1, branch1, ren2, branch2);
 			} else {
 				struct merge_file_info mfi;
 				remove_file(1, ren1_src, 1);
@@ -888,13 +886,13 @@ static int process_renames(struct string_list *a_renames,
 						 branch1,
 						 branch2);
 				if (mfi.merge || !mfi.clean)
-					output(1, "Renamed %s->%s", src, ren1_dst);
+					output(o, 1, "Renamed %s->%s", src, ren1_dst);
 
 				if (mfi.merge)
-					output(2, "Auto-merged %s", ren1_dst);
+					output(o, 2, "Auto-merged %s", ren1_dst);
 
 				if (!mfi.clean) {
-					output(1, "CONFLICT (content): merge conflict in %s",
+					output(o, 1, "CONFLICT (content): merge conflict in %s",
 					       ren1_dst);
 					clean_merge = 0;
 
@@ -925,14 +923,14 @@ static int process_renames(struct string_list *a_renames,
 
 			if (string_list_has_string(&current_directory_set, ren1_dst)) {
 				clean_merge = 0;
-				output(1, "CONFLICT (rename/directory): Renamed %s->%s in %s "
+				output(o, 1, "CONFLICT (rename/directory): Renamed %s->%s in %s "
 				       " directory %s added in %s",
 				       ren1_src, ren1_dst, branch1,
 				       ren1_dst, branch2);
-				conflict_rename_dir(ren1, branch1);
+				conflict_rename_dir(o, ren1, branch1);
 			} else if (sha_eq(src_other.sha1, null_sha1)) {
 				clean_merge = 0;
-				output(1, "CONFLICT (rename/delete): Renamed %s->%s in %s "
+				output(o, 1, "CONFLICT (rename/delete): Renamed %s->%s in %s "
 				       "and deleted in %s",
 				       ren1_src, ren1_dst, branch1,
 				       branch2);
@@ -941,31 +939,31 @@ static int process_renames(struct string_list *a_renames,
 				const char *new_path;
 				clean_merge = 0;
 				try_merge = 1;
-				output(1, "CONFLICT (rename/add): Renamed %s->%s in %s. "
+				output(o, 1, "CONFLICT (rename/add): Renamed %s->%s in %s. "
 				       "%s added in %s",
 				       ren1_src, ren1_dst, branch1,
 				       ren1_dst, branch2);
 				new_path = unique_path(ren1_dst, branch2);
-				output(1, "Added as %s instead", new_path);
+				output(o, 1, "Added as %s instead", new_path);
 				update_file(0, dst_other.sha1, dst_other.mode, new_path);
 			} else if ((item = string_list_lookup(ren1_dst, renames2Dst))) {
 				ren2 = item->util;
 				clean_merge = 0;
 				ren2->processed = 1;
-				output(1, "CONFLICT (rename/rename): Renamed %s->%s in %s. "
+				output(o, 1, "CONFLICT (rename/rename): Renamed %s->%s in %s. "
 				       "Renamed %s->%s in %s",
 				       ren1_src, ren1_dst, branch1,
 				       ren2->pair->one->path, ren2->pair->two->path, branch2);
-				conflict_rename_rename_2(ren1, branch1, ren2, branch2);
+				conflict_rename_rename_2(o, ren1, branch1, ren2, branch2);
 			} else
 				try_merge = 1;
 
 			if (try_merge) {
-				struct diff_filespec *o, *a, *b;
+				struct diff_filespec *one, *a, *b;
 				struct merge_file_info mfi;
 				src_other.path = (char *)ren1_src;
 
-				o = ren1->pair->one;
+				one = ren1->pair->one;
 				if (a_renames == renames1) {
 					a = ren1->pair->two;
 					b = &src_other;
@@ -973,8 +971,8 @@ static int process_renames(struct string_list *a_renames,
 					b = ren1->pair->two;
 					a = &src_other;
 				}
-				mfi = merge_file(o, a, b,
-						a_branch, b_branch);
+				mfi = merge_file(one, a, b,
+						o->branch1, o->branch2);
 
 				if (mfi.clean &&
 				    sha_eq(mfi.sha, ren1->pair->two->sha1) &&
@@ -984,20 +982,20 @@ static int process_renames(struct string_list *a_renames,
 					 * t6022 test. If you change
 					 * it update the test too.
 					 */
-					output(3, "Skipped %s (merged same as existing)", ren1_dst);
+					output(o, 3, "Skipped %s (merged same as existing)", ren1_dst);
 				else {
 					if (mfi.merge || !mfi.clean)
-						output(1, "Renamed %s => %s", ren1_src, ren1_dst);
+						output(o, 1, "Renamed %s => %s", ren1_src, ren1_dst);
 					if (mfi.merge)
-						output(2, "Auto-merged %s", ren1_dst);
+						output(o, 2, "Auto-merged %s", ren1_dst);
 					if (!mfi.clean) {
-						output(1, "CONFLICT (rename/modify): Merge conflict in %s",
+						output(o, 1, "CONFLICT (rename/modify): Merge conflict in %s",
 						       ren1_dst);
 						clean_merge = 0;
 
 						if (!index_only)
 							update_stages(ren1_dst,
-								      o, a, b, 1);
+								      one, a, b, 1);
 					}
 					update_file(mfi.clean, mfi.sha, mfi.mode, ren1_dst);
 				}
@@ -1016,9 +1014,8 @@ static unsigned char *stage_sha(const unsigned char *sha, unsigned mode)
 }
 
 /* Per entry merge function */
-static int process_entry(const char *path, struct stage_data *entry,
-			 const char *branch1,
-			 const char *branch2)
+static int process_entry(struct merge_options *o,
+			 const char *path, struct stage_data *entry)
 {
 	/*
 	printf("processing entry, clean cache: %s\n", index_only ? "yes": "no");
@@ -1040,23 +1037,23 @@ static int process_entry(const char *path, struct stage_data *entry,
 			/* Deleted in both or deleted in one and
 			 * unchanged in the other */
 			if (a_sha)
-				output(2, "Removed %s", path);
+				output(o, 2, "Removed %s", path);
 			/* do not touch working file if it did not exist */
 			remove_file(1, path, !a_sha);
 		} else {
 			/* Deleted in one and changed in the other */
 			clean_merge = 0;
 			if (!a_sha) {
-				output(1, "CONFLICT (delete/modify): %s deleted in %s "
+				output(o, 1, "CONFLICT (delete/modify): %s deleted in %s "
 				       "and modified in %s. Version %s of %s left in tree.",
-				       path, branch1,
-				       branch2, branch2, path);
+				       path, o->branch1,
+				       o->branch2, o->branch2, path);
 				update_file(0, b_sha, b_mode, path);
 			} else {
-				output(1, "CONFLICT (delete/modify): %s deleted in %s "
+				output(o, 1, "CONFLICT (delete/modify): %s deleted in %s "
 				       "and modified in %s. Version %s of %s left in tree.",
-				       path, branch2,
-				       branch1, branch1, path);
+				       path, o->branch2,
+				       o->branch1, o->branch1, path);
 				update_file(0, a_sha, a_mode, path);
 			}
 		}
@@ -1071,14 +1068,14 @@ static int process_entry(const char *path, struct stage_data *entry,
 		const char *conf;
 
 		if (a_sha) {
-			add_branch = branch1;
-			other_branch = branch2;
+			add_branch = o->branch1;
+			other_branch = o->branch2;
 			mode = a_mode;
 			sha = a_sha;
 			conf = "file/directory";
 		} else {
-			add_branch = branch2;
-			other_branch = branch1;
+			add_branch = o->branch2;
+			other_branch = o->branch1;
 			mode = b_mode;
 			sha = b_sha;
 			conf = "directory/file";
@@ -1086,13 +1083,13 @@ static int process_entry(const char *path, struct stage_data *entry,
 		if (string_list_has_string(&current_directory_set, path)) {
 			const char *new_path = unique_path(path, add_branch);
 			clean_merge = 0;
-			output(1, "CONFLICT (%s): There is a directory with name %s in %s. "
+			output(o, 1, "CONFLICT (%s): There is a directory with name %s in %s. "
 			       "Added %s as %s",
 			       conf, path, other_branch, path, new_path);
 			remove_file(0, path, 0);
 			update_file(0, sha, mode, new_path);
 		} else {
-			output(2, "Added %s", path);
+			output(o, 2, "Added %s", path);
 			update_file(1, sha, mode, path);
 		}
 	} else if (a_sha && b_sha) {
@@ -1100,32 +1097,32 @@ static int process_entry(const char *path, struct stage_data *entry,
 		/* case D: Modified in both, but differently. */
 		const char *reason = "content";
 		struct merge_file_info mfi;
-		struct diff_filespec o, a, b;
+		struct diff_filespec one, a, b;
 
 		if (!o_sha) {
 			reason = "add/add";
 			o_sha = (unsigned char *)null_sha1;
 		}
-		output(2, "Auto-merged %s", path);
-		o.path = a.path = b.path = (char *)path;
-		hashcpy(o.sha1, o_sha);
-		o.mode = o_mode;
+		output(o, 2, "Auto-merged %s", path);
+		one.path = a.path = b.path = (char *)path;
+		hashcpy(one.sha1, o_sha);
+		one.mode = o_mode;
 		hashcpy(a.sha1, a_sha);
 		a.mode = a_mode;
 		hashcpy(b.sha1, b_sha);
 		b.mode = b_mode;
 
-		mfi = merge_file(&o, &a, &b,
-				 branch1, branch2);
+		mfi = merge_file(&one, &a, &b,
+				 o->branch1, o->branch2);
 
 		clean_merge = mfi.clean;
 		if (mfi.clean)
 			update_file(1, mfi.sha, mfi.mode, path);
 		else if (S_ISGITLINK(mfi.mode))
-			output(1, "CONFLICT (submodule): Merge conflict in %s "
+			output(o, 1, "CONFLICT (submodule): Merge conflict in %s "
 			       "- needs %s", path, sha1_to_hex(b.sha1));
 		else {
-			output(1, "CONFLICT (%s): Merge conflict in %s",
+			output(o, 1, "CONFLICT (%s): Merge conflict in %s",
 					reason, path);
 
 			if (index_only)
@@ -1146,11 +1143,10 @@ static int process_entry(const char *path, struct stage_data *entry,
 	return clean_merge;
 }
 
-int merge_trees(struct tree *head,
+int merge_trees(struct merge_options *o,
+		struct tree *head,
 		struct tree *merge,
 		struct tree *common,
-		const char *branch1,
-		const char *branch2,
 		struct tree **result)
 {
 	int code, clean;
@@ -1161,7 +1157,7 @@ int merge_trees(struct tree *head,
 	}
 
 	if (sha_eq(common->object.sha1, merge->object.sha1)) {
-		output(0, "Already uptodate!");
+		output(o, 0, "Already uptodate!");
 		*result = head;
 		return 1;
 	}
@@ -1182,15 +1178,14 @@ int merge_trees(struct tree *head,
 		get_files_dirs(merge);
 
 		entries = get_unmerged();
-		re_head  = get_renames(head, common, head, merge, entries);
-		re_merge = get_renames(merge, common, head, merge, entries);
-		clean = process_renames(re_head, re_merge,
-				branch1, branch2);
+		re_head  = get_renames(o, head, common, head, merge, entries);
+		re_merge = get_renames(o, merge, common, head, merge, entries);
+		clean = process_renames(o, re_head, re_merge);
 		for (i = 0; i < entries->nr; i++) {
 			const char *path = entries->items[i].string;
 			struct stage_data *e = entries->items[i].util;
 			if (!e->processed
-				&& !process_entry(path, e, branch1, branch2))
+				&& !process_entry(o, path, e))
 				clean = 0;
 		}
 
@@ -1203,7 +1198,7 @@ int merge_trees(struct tree *head,
 		clean = 1;
 
 	if (index_only)
-		*result = write_tree_from_memory();
+		*result = write_tree_from_memory(o);
 
 	return clean;
 }
@@ -1223,10 +1218,9 @@ static struct commit_list *reverse_commit_list(struct commit_list *list)
  * Merge the commits h1 and h2, return the resulting virtual
  * commit object and a flag indicating the cleanness of the merge.
  */
-int merge_recursive(struct commit *h1,
+int merge_recursive(struct merge_options *o,
+		    struct commit *h1,
 		    struct commit *h2,
-		    const char *branch1,
-		    const char *branch2,
 		    struct commit_list *ca,
 		    struct commit **result)
 {
@@ -1235,8 +1229,8 @@ int merge_recursive(struct commit *h1,
 	struct tree *mrtree = mrtree;
 	int clean;
 
-	if (show(4)) {
-		output(4, "Merging:");
+	if (show(o, 4)) {
+		output(o, 4, "Merging:");
 		output_commit_title(h1);
 		output_commit_title(h2);
 	}
@@ -1246,8 +1240,8 @@ int merge_recursive(struct commit *h1,
 		ca = reverse_commit_list(ca);
 	}
 
-	if (show(5)) {
-		output(5, "found %u common ancestor(s):", commit_list_count(ca));
+	if (show(o, 5)) {
+		output(o, 5, "found %u common ancestor(s):", commit_list_count(ca));
 		for (iter = ca; iter; iter = iter->next)
 			output_commit_title(iter->item);
 	}
@@ -1264,6 +1258,7 @@ int merge_recursive(struct commit *h1,
 	}
 
 	for (iter = ca; iter; iter = iter->next) {
+		const char *saved_b1, *saved_b2;
 		call_depth++;
 		/*
 		 * When the merge fails, the result contains files
@@ -1273,11 +1268,14 @@ int merge_recursive(struct commit *h1,
 		 * "conflicts" were already resolved.
 		 */
 		discard_cache();
-		merge_recursive(merged_common_ancestors, iter->item,
-				"Temporary merge branch 1",
-				"Temporary merge branch 2",
-				NULL,
-				&merged_common_ancestors);
+		saved_b1 = o->branch1;
+		saved_b2 = o->branch2;
+		o->branch1 = "Temporary merge branch 1";
+		o->branch2 = "Temporary merge branch 2";
+		merge_recursive(o, merged_common_ancestors, iter->item,
+				NULL, &merged_common_ancestors);
+		o->branch1 = saved_b1;
+		o->branch2 = saved_b2;
 		call_depth--;
 
 		if (!merged_common_ancestors)
@@ -1291,8 +1289,8 @@ int merge_recursive(struct commit *h1,
 	} else
 		index_only = 1;
 
-	clean = merge_trees(h1->tree, h2->tree, merged_common_ancestors->tree,
-			    branch1, branch2, &mrtree);
+	clean = merge_trees(o, h1->tree, h2->tree, merged_common_ancestors->tree,
+			    &mrtree);
 
 	if (index_only) {
 		*result = make_virtual_commit(mrtree, "merged tree");
@@ -1319,35 +1317,33 @@ static struct commit *get_ref(const unsigned char *sha1, const char *name)
 	return (struct commit *)object;
 }
 
-int merge_recursive_generic(const char **base_list,
-		const unsigned char *head_sha1, const char *head_name,
-		const unsigned char *next_sha1, const char *next_name)
+int merge_recursive_generic(struct merge_options *o,
+			    const unsigned char *head,
+			    const unsigned char *merge,
+			    int num_base_list,
+			    const unsigned char **base_list,
+			    struct commit **result)
 {
 	int clean, index_fd;
 	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
-	struct commit *result;
-	struct commit *head_commit = get_ref(head_sha1, head_name);
-	struct commit *next_commit = get_ref(next_sha1, next_name);
+	struct commit *head_commit = get_ref(head, o->branch1);
+	struct commit *next_commit = get_ref(merge, o->branch2);
 	struct commit_list *ca = NULL;
 
 	if (base_list) {
 		int i;
-		for (i = 0; base_list[i]; ++i) {
-			unsigned char sha[20];
+		for (i = 0; i < num_base_list; ++i) {
 			struct commit *base;
-			if (get_sha1(base_list[i], sha))
-				return error("Could not resolve ref '%s'",
-								base_list[i]);
-			if (!(base = get_ref(sha, base_list[i])))
+			if (!(base = get_ref(base_list[i], sha1_to_hex(base_list[i]))))
 				return error("Could not parse object '%s'",
-								base_list[i]);
+					sha1_to_hex(base_list[i]));
 			commit_list_insert(base, &ca);
 		}
 	}
 
 	index_fd = hold_locked_index(lock, 1);
-	clean = merge_recursive(head_commit, next_commit,
-				head_name, next_name, ca, &result);
+	clean = merge_recursive(o, head_commit, next_commit, ca,
+			result);
 	if (active_cache_changed &&
 			(write_cache(index_fd, active_cache, active_nr) ||
 			 commit_locked_index(lock)))
@@ -1356,29 +1352,35 @@ int merge_recursive_generic(const char **base_list,
 	return clean ? 0 : 1;
 }
 
-int merge_recursive_config(const char *var, const char *value, void *cb)
+static int merge_recursive_config(const char *var, const char *value, void *cb)
 {
+	struct merge_options *o = cb;
 	if (!strcasecmp(var, "merge.verbosity")) {
-		merge_recursive_verbosity = git_config_int(var, value);
+		o->verbosity = git_config_int(var, value);
 		return 0;
 	}
 	if (!strcasecmp(var, "diff.renamelimit")) {
-		diff_rename_limit = git_config_int(var, value);
+		o->diff_rename_limit = git_config_int(var, value);
 		return 0;
 	}
 	if (!strcasecmp(var, "merge.renamelimit")) {
-		merge_rename_limit = git_config_int(var, value);
+		o->merge_rename_limit = git_config_int(var, value);
 		return 0;
 	}
 	return git_default_config(var, value, cb);
 }
 
-void merge_recursive_setup(int is_subtree_merge)
+void init_merge_options(struct merge_options *o)
 {
+	memset(o, 0, sizeof(struct merge_options));
+	o->verbosity = 2;
+	o->buffer_output = 1;
+	o->diff_rename_limit = -1;
+	o->merge_rename_limit = -1;
+	git_config(merge_recursive_config, o);
 	if (getenv("GIT_MERGE_VERBOSITY"))
-		merge_recursive_verbosity =
+		o->verbosity =
 			strtol(getenv("GIT_MERGE_VERBOSITY"), NULL, 10);
-	if (merge_recursive_verbosity >= 5)
-		buffer_output = 0;
-	subtree_merge = is_subtree_merge;
+	if (o->verbosity >= 5)
+		o->buffer_output = 0;
 }
diff --git a/merge-recursive.h b/merge-recursive.h
index 4dd6476..72f0a28 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -1,26 +1,42 @@
 #ifndef MERGE_RECURSIVE_H
 #define MERGE_RECURSIVE_H
 
-int merge_recursive(struct commit *h1,
+struct merge_options {
+	const char *branch1;
+	const char *branch2;
+	unsigned subtree_merge : 1;
+	unsigned buffer_output : 1;
+	int verbosity;
+	int diff_rename_limit;
+	int merge_rename_limit;
+};
+
+/* merge_trees() but with recursive ancestor consolidation */
+int merge_recursive(struct merge_options *o,
+		    struct commit *h1,
 		    struct commit *h2,
-		    const char *branch1,
-		    const char *branch2,
 		    struct commit_list *ancestors,
 		    struct commit **result);
 
-int merge_trees(struct tree *head,
+/* rename-detecting three-way merge, no recursion */
+int merge_trees(struct merge_options *o,
+		struct tree *head,
 		struct tree *merge,
 		struct tree *common,
-		const char *branch1,
-		const char *branch2,
 		struct tree **result);
-extern int merge_recursive_generic(const char **base_list,
-		const unsigned char *head_sha1, const char *head_name,
-		const unsigned char *next_sha1, const char *next_name);
-int merge_recursive_config(const char *var, const char *value, void *cb);
-void merge_recursive_setup(int is_subtree_merge);
-struct tree *write_tree_from_memory(void);
 
-extern int merge_recursive_verbosity;
+/*
+ * "git-merge-recursive" can be fed trees; wrap them into
+ * virtual commits and call merge_recursive() proper.
+ */
+int merge_recursive_generic(struct merge_options *o,
+			    const unsigned char *head,
+			    const unsigned char *merge,
+			    int num_ca,
+			    const unsigned char **ca,
+			    struct commit **result);
+
+void init_merge_options(struct merge_options *o);
+struct tree *write_tree_from_memory(struct merge_options *o);
 
 #endif
-- 
1.6.0.rc3.17.gc14c8.dirty
