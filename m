Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099A43AA4E1
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 06:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792390275; cv=pass; b=ZbnxckZDmOKZF07ijGhR/8tLDJzu0G66yxFmIS3BhniEI9rtQZ1ZQCjkXGvMnq/VZ7zjkptD21W7NVJ9PJJDf02XvYd9I70ZunWUYtXxki+m83IujBx8VwkQcWNAPcSjXd6+a8IoMJHnXOTxu4H4uQBXjkxHl8LL3rc4MmZUF6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792390275; c=relaxed/simple;
	bh=iYcev3S/mt1/t7y6w1GCXb7Ytf6Rk/ucUGyWnroopyg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WWDLrGTFBr1rGcrBDVV9DrJK2K2Bfxnd73Bo1pnV75YoSyQciSS08K2xYY8LkB6nM3YwMaJCci9ETh4IS+2dceq4Kcsys+he6Q7sv3H/Icmh9KtyJSyMMO1lJrgQsxLCCN+k7aYuJA3t7vCAEeAw69f1xW/ZGlu8iqpDG5Og9Yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=vmiklos@collabora.com header.b=gWaf+EW1; arc=pass smtp.client-ip=165.173.182.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=vmiklos@collabora.com header.b="gWaf+EW1"
ARC-Seal: i=1; a=rsa-sha256; t=1792390267; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gwLVQHC/oWqKHeDF4CKNMeT7xP/kyQ0jYabsQZM0dim4VLEzxEPzmOfnCYr2CvwEstg7cPjQGJM3E05HvMb2BBKUPtPouFGrm0ukxO8LzoF5rlLaU1DqomwxlczTSxtgmNjIonieXlo1SQx7yfA0RmehMPTr+BZKekBf+XQZ1bg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792390267; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4koM13tYYrrTZv2Iy5uuT+bjnvB90i7hfGSsFhl4N8c=; 
	b=GW18+7Db4Q7PgXzfOqVIxpgYDPbKs1E3Vbo7IFOptbVXkAr8swdyJwrV9zLU1Q5R5vSW2KpJecwUwuJbYMiDmbBmrl5fmBuecWHd9KOT3EhNMIC9bvByneLJ+KQxXCA79AgSgbCqVZ9fJtnPQg/JJHVBLIM1YcT9CwxZBuwKFRc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vmiklos@collabora.com;
	dmarc=pass header.from=<vmiklos@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792390266;
	s=zohomail; d=collabora.com; i=vmiklos@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=4koM13tYYrrTZv2Iy5uuT+bjnvB90i7hfGSsFhl4N8c=;
	b=gWaf+EW1X97kt8atptpiMdX/A0apN5rB47wJgv+/CsoG/RUeYckMkqh3av2R42ut
	2Wkg1HUuAjhPArA54ZTTm8750nfilexFwOrLBEUu6gLJIR7uoDZqez2/w+tH+bIQGwI
	up/0jMplUtJOAJnyL2mdi7DWYNrXFGp6rISUZVFY=
Received: by smtp.zohomail.com with SMTPS id 179239026469195.79810715464089;
	Sun, 18 Oct 2026 23:11:04 -0700 (PDT)
Date: Mon, 19 Oct 2026 08:10:58 +0200
From: Miklos Vajna <vmiklos@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: [PATCH v2] log: speed up --follow following renames for non-linear
 history
Message-ID: <atW0ctTe-lNq08A-@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq8q3yq4u4.fsf@gitster.g>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/292.376.41
X-ZohoMailClient: External

Test the performance of 'git log --stat --follow --
include/linux/rsc_table.h' on linux.git, it used to take about 28
seconds, and since commit 304812ed33 (log: improve --follow following
renames for non-linear history, 2026-06-22), it takes 6m43s.

What happens is that propagate_follow_pathspec_to_parent() diffs the
current commit against all of its parents with rename following, and
this slows down 'git log --follow'.

Fix the problem by removing propagate_follow_pathspec_to_parent() and
instead recording the path to follow for each parent in the parent loop
of log_tree_diff(), which already calls diff_tree_oid() with rename
following, so for non-merge commits the diff that we show is reused.
Merges are not diffed by default, so in that case run the same loop, but
only to find the paths to follow, without showing anything. With -c,
--cc or --remerge-diff, merges are diffed, but not in this loop, so run
the loop for them as well and only show their merge diff after that,
using the path of the merge itself. Also, do this in two passes: first
look for a parent without rename following, and if the path is
unchanged against a parent, then just follow that history in all
parents. Only do the expensive rename following against each parent if
the path changed relative to all parents. Given that this way a parent
may be asked to follow a path that it doesn't have, also adjust
remember_follow_pathspec(): if children disagree on what should be the
path for a commit, then prefer the path that exists in that commit.

Following the same path in all parents is not enough when the other side
renamed the path, though: if the merge kept F from one parent, but the
other parent renamed F to G and then modified G, then the commits
modifying G would be lost. Handle this by still doing the rename
following against a parent if that parent doesn't have the path, the
merge has it and a merge base of the two parents also has it, i.e. the
path was renamed or removed on that side. The merge base is only
computed in this rare case, and back-merges where the path was created
after the other side forked still skip the expensive rename detection.
Now the above use case takes 37s, somewhat close to the original cost.

Also add new testcases: the -c/--cc/--remerge-diff options and the
--no-ff merging case were working, but were untested, so the
optimization could have broken them. And cover following a rename on the
side the merge did not take as well.

Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Miklos Vajna <vmiklos@collabora.com>
---

Hi Junio,

On Thu, Oct 15, 2026 at 09:57:39AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> I am not sure if it may be cleaner to first rip out all the change
> introduced in 304812ed33 (log: improve --follow following renames
> for non-linear history, 2026-06-22) and then rethink the approach,
> instead of piling more code with additional patches.  I dunno.

Here is my attempt at the redo approach: instead of adding more diffing
on top of 304812ed33, I removed its
propagate_follow_pathspec_to_parent() and I do the path recording in the
existing parent loop of log_tree_diff().  For merges, there is no diff
to reuse by default, so the same loop runs for them without showing
anything.

Most of the performance benefit from v1 is still there.

I also found a few cases which had no test coverage, I added tests to
t4219-log-follow-merge.sh.

On Fri, Oct 16, 2026 at 01:37:28PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Hmph, so if you have two branches A and B that forked from a common
> ancestor that had file F,
> 
>  - A updates F in place
>  - B renames F to G in one commit
>  - B then updates the renamed G on in another commit
>  - A merges B but decides to keep the original name F and
>    original content, deleting G.
> 
> then because has_same would be the same, you do not call
> propagate_follow_pathspec_to_parent() to prepare the traversal into
> branch B's history when you cross the merge, even when we are not
> simplifying the history?
> 
> That somehow sounds broken to me.  Am I missing something?

I didn't consider that case. I've now added a follow_needs_renames() to
handle this.

This leads to a larger patch: should I extract the "rethink the
approach" and the new tests to separate patches or it doesn't matter?

To sum up, compared to v1, now I 1) redid the approach to avoid
propagate_follow_pathspec_to_parent() 2) added a few more tests and 3)
the above "following a rename on the side the merge did not take" case
now works as well.

Thanks,

Miklos

 log-tree.c                  | 201 +++++++++++++++++++++++++-----------
 t/t4219-log-follow-merge.sh | 112 ++++++++++++++++++++
 2 files changed, 255 insertions(+), 58 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 83a3c4bf9b..d5ce58d91d 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -31,6 +31,7 @@
 #include "range-diff.h"
 #include "strmap.h"
 #include "tree.h"
+#include "tree-walk.h"
 #include "wildmatch.h"
 #include "write-or-die.h"
 #include "pager.h"
@@ -1110,6 +1111,17 @@ static void set_pathspec_to_single_path(struct pathspec *ps, const char *path)
 		       PATHSPEC_LITERAL_PATH, "", paths);
 }
 
+static int commit_has_path(struct rev_info *opt, struct commit *c,
+			   const char *path)
+{
+	struct object_id oid;
+	unsigned short mode;
+
+	parse_commit_or_die(c);
+	return !get_tree_entry(opt->diffopt.repo, get_commit_tree_oid(c), path,
+			       &oid, &mode);
+}
+
 static void remember_follow_pathspec(struct rev_info *opt,
 				     struct commit *c, const char *path)
 {
@@ -1122,8 +1134,12 @@ static void remember_follow_pathspec(struct rev_info *opt,
 		init_follow_pathspec_slab(opt->follow_pathspec_slab);
 	}
 	slot = follow_pathspec_slab_at(opt->follow_pathspec_slab, c);
-	if (*slot && !strcmp(*slot, path))
-		return;
+	/* If children of 'c' disagree on the path, prefer the one 'c' has. */
+	if (*slot) {
+		if (!strcmp(*slot, path) || commit_has_path(opt, c, *slot) ||
+		    !commit_has_path(opt, c, path))
+			return;
+	}
 	free(*slot);
 	*slot = xstrdup(path);
 }
@@ -1153,31 +1169,47 @@ void release_follow_pathspec_slab(struct rev_info *opt)
 	FREE_AND_NULL(opt->follow_pathspec_slab);
 }
 
-/* Compute a path to follow in parent, if there is one */
-static void propagate_follow_pathspec_to_parent(struct rev_info *opt,
-						struct commit *commit,
-						struct commit *parent)
+/*
+ * When the path in a merge is the same as in 'same', does the path still need
+ * renames to be followed in 'parent'? Only if the merge has the path, 'parent'
+ * doesn't have it, but its fork point with 'same' had it, e.g. 'parent'
+ * renamed the path.
+ */
+static int follow_needs_renames(struct rev_info *opt, struct commit *parent,
+				struct commit *same, const char *path)
+{
+	struct commit_list *bases = NULL, *base;
+	int ret = 0;
+
+	if (commit_has_path(opt, parent, path) ||
+	    !commit_has_path(opt, same, path))
+		return 0;
+	if (repo_get_merge_bases(opt->diffopt.repo, parent, same, &bases) < 0)
+		exit(128);
+	for (base = bases; base && !ret; base = base->next)
+		ret = commit_has_path(opt, base->item, path);
+	commit_list_free(bases);
+	return ret;
+}
+
+/* Show the remerge or combined diff of a merge commit */
+static int log_tree_merge_diff(struct rev_info *opt, struct commit *commit,
+			       struct commit_list *parents,
+			       struct object_id *oid)
 {
-	struct diff_options diff_opts;
-	const char *path;
-
-	parse_commit_or_die(parent);
-	repo_diff_setup(opt->diffopt.repo, &diff_opts);
-	copy_pathspec(&diff_opts.pathspec, &opt->diffopt.pathspec);
-	diff_opts.flags.recursive = 1;
-	diff_opts.flags.follow_renames = 1;
-	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
-	diff_setup_done(&diff_opts);
-	diff_tree_oid(get_commit_tree_oid(parent),
-		      get_commit_tree_oid(commit),
-		      "", &diff_opts);
-
-	path = pathspec_single_path(&diff_opts.pathspec);
-	if (path)
-		remember_follow_pathspec(opt, parent, path);
-
-	diff_queue_clear(&diff_queued_diff);
-	diff_free(&diff_opts);
+	int octopus = (parents->next->next != NULL);
+
+	if (opt->remerge_diff) {
+		if (octopus) {
+			show_log(opt);
+			fprintf(opt->diffopt.file,
+				"diff: warning: Skipping remerge-diff "
+				"for octopus merges.\n");
+			return 1;
+		}
+		return do_remerge_diff(opt, parents, oid);
+	}
+	return do_diff_combined(opt, commit);
 }
 
 /*
@@ -1188,10 +1220,12 @@ static void propagate_follow_pathspec_to_parent(struct rev_info *opt,
 static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log_info *log)
 {
 	int showed_log;
-	struct commit_list *parents;
+	struct commit_list *parents, *all_parents, *rename_parents = NULL;
 	struct object_id *oid;
 	int is_merge;
 	int all_need_diff = opt->diff || opt->diffopt.flags.exit_with_status;
+	int follow_only = 0;
+	char *path = NULL;
 
 	if (!all_need_diff && !opt->merges_need_diff)
 		return 0;
@@ -1220,47 +1254,113 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 	}
 
 	if (is_merge) {
-		int octopus = (parents->next->next != NULL);
-
-		if (opt->remerge_diff) {
-			if (octopus) {
-				show_log(opt);
-				fprintf(opt->diffopt.file,
-					"diff: warning: Skipping remerge-diff "
-					"for octopus merges.\n");
-				return 1;
-			}
-			return do_remerge_diff(opt, parents, oid);
-		}
-		if (opt->combine_merges)
-			return do_diff_combined(opt, commit);
-		if (opt->separate_merges) {
+		int merge_diff = opt->remerge_diff || opt->combine_merges;
+
+		if (merge_diff && !opt->diffopt.flags.follow_renames)
+			return log_tree_merge_diff(opt, commit, parents, oid);
+		if (opt->separate_merges && !merge_diff) {
 			if (!opt->first_parent_merges) {
 				/* Show parent info for multiple diffs */
 				log->parent = parents->item;
 			}
+		} else if (opt->diffopt.flags.follow_renames) {
+			/* Diff only to find the path to follow in parents */
+			follow_only = 1;
 		} else
 			return 0;
 	}
 
+	if (opt->diffopt.flags.follow_renames)
+		path = xstrdup_or_null(
+			pathspec_single_path(&opt->diffopt.pathspec));
+
+	if (follow_only) {
+		/*
+		 * First look for a parent where the path is unchanged, without
+		 * the expensive rename detection.
+		 */
+		opt->diffopt.flags.follow_renames = 0;
+	}
+
 	showed_log = 0;
+	all_parents = parents;
 	for (;;) {
 		struct commit *parent = parents->item;
+		int changed = 1;
 
 		parse_commit_or_die(parent);
 		diff_tree_oid(get_commit_tree_oid(parent),
 			      oid, "", &opt->diffopt);
-		log_tree_diff_flush(opt);
+		if (follow_only) {
+			changed = diff_queued_diff.nr;
+			diff_queue_clear(&diff_queued_diff);
+			opt->diffopt.found_follow = 0;
+		} else
+			log_tree_diff_flush(opt);
 
 		showed_log |= !opt->loginfo;
 
+		if (!changed) {
+			/*
+			 * Same as in this parent, follow that history, but
+			 * still look for renames in parents that had the path
+			 * at the fork point.
+			 */
+			struct commit_list **tail = &rename_parents;
+
+			for (parents = all_parents; parents;
+			     parents = parents->next) {
+				if (parents->item != parent &&
+				    follow_needs_renames(opt, parents->item,
+							 parent, path))
+					tail = &commit_list_insert(parents->item,
+								   tail)->next;
+				else
+					remember_follow_pathspec(opt,
+								 parents->item,
+								 path);
+			}
+			if (!rename_parents)
+				break;
+			opt->diffopt.flags.follow_renames = 1;
+			parents = rename_parents;
+			continue;
+		}
+
+		/* The diff updated the pathspec in case of a rename */
+		if (path && opt->diffopt.flags.follow_renames)
+			remember_follow_pathspec(opt, parent,
+				pathspec_single_path(&opt->diffopt.pathspec));
+
 		/* Set up the log info for the next parent, if any.. */
 		parents = parents->next;
+		if (!parents && follow_only &&
+		    !opt->diffopt.flags.follow_renames) {
+			/* The path changed in all parents, look for renames. */
+			opt->diffopt.flags.follow_renames = 1;
+			parents = all_parents;
+		}
 		if (!parents || opt->first_parent_merges)
 			break;
+		if (path)
+			set_pathspec_to_single_path(&opt->diffopt.pathspec,
+						    path);
+		if (follow_only)
+			continue;
 		log->parent = parents->item;
 		opt->loginfo = log;
 	}
+	if (follow_only)
+		opt->diffopt.flags.follow_renames = 1;
+	if (follow_only && (opt->remerge_diff || opt->combine_merges)) {
+		/* Show the merge diff with the path of this commit */
+		if (path)
+			set_pathspec_to_single_path(&opt->diffopt.pathspec,
+						    path);
+		showed_log = log_tree_merge_diff(opt, commit, all_parents, oid);
+	}
+	commit_list_free(rename_parents);
+	free(path);
 	return showed_log;
 }
 
@@ -1298,21 +1398,6 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
 		fprintf(opt->diffopt.file, "\n%s\n", opt->break_bar);
 	if (shown)
 		show_diff_of_diff(opt);
-
-	/* Record what path each parent of this commit should use */
-	if (opt->diffopt.flags.follow_renames) {
-		struct commit_list *parents = get_saved_parents(opt, commit);
-		if (parents && parents->next) {
-			struct commit_list *p;
-			for (p = parents; p; p = p->next)
-				propagate_follow_pathspec_to_parent(opt, commit,
-								    p->item);
-		} else if (parents) {
-			remember_follow_pathspec(opt, parents->item,
-				pathspec_single_path(&opt->diffopt.pathspec));
-		}
-	}
-
 	opt->loginfo = NULL;
 	maybe_flush_or_die(opt->diffopt.file, "stdout");
 	opt->diffopt.no_free = no_free;
diff --git a/t/t4219-log-follow-merge.sh b/t/t4219-log-follow-merge.sh
index e370f82955..9616ac64ed 100755
--- a/t/t4219-log-follow-merge.sh
+++ b/t/t4219-log-follow-merge.sh
@@ -126,4 +126,116 @@ test_expect_success '--follow follows renames through a fork in a single history
 	test_cmp expect actual.sorted
 '
 
+for opt in -c --cc --remerge-diff
+do
+	test_expect_success "--follow follows renames through a fork with $opt" '
+		git -C diamond log --follow $opt --pretty=tformat:%s path >log &&
+		grep "^[A-Z]: " log | sort >actual &&
+		cat >expect <<-\EOF &&
+		A: add path0
+		B: modify path0 on upper
+		C: modify path0 on lower
+		M: merge with rename to path
+		X: rename path0 to path1
+		Y: rename path0 to path2
+		Z: modify path
+		EOF
+		test_cmp expect actual
+	'
+done
+
+# Build a merge that takes the renamed path from the second parent, while the
+# first parent only has the old path. $2 decides which side is committed first,
+# which decides the walk order.
+setup_rename_on_second_parent () {
+	git init $1 &&
+	printf "line 1\nline 2\nline 3\nline 4\nline 5\n" >$1/old &&
+	git -C $1 add old &&
+	test_tick &&
+	git -C $1 commit -m "A: add old" &&
+	printf "line 1\nline 2\nline 3 modified\nline 4\nline 5\n" >$1/old &&
+	test_tick &&
+	git -C $1 commit -am "B: modify old" &&
+	git -C $1 branch topic &&
+
+	if test "$2" = topic-first
+	then
+		git -C $1 checkout topic &&
+		git -C $1 mv old new &&
+		test_tick &&
+		git -C $1 commit -m "R: rename old to new" &&
+		git -C $1 checkout master
+	fi &&
+
+	echo other >$1/other &&
+	git -C $1 add other &&
+	test_tick &&
+	git -C $1 commit -m "M: unrelated change on master" &&
+
+	if test "$2" = master-first
+	then
+		git -C $1 checkout topic &&
+		git -C $1 mv old new &&
+		test_tick &&
+		git -C $1 commit -m "R: rename old to new" &&
+		git -C $1 checkout master
+	fi &&
+
+	test_tick &&
+	git -C $1 merge --no-ff -m "merge topic" topic
+}
+
+test_expect_success 'setup merge taking a rename from the second parent' '
+	setup_rename_on_second_parent rename-master-first master-first &&
+	setup_rename_on_second_parent rename-topic-first topic-first
+'
+
+for order in master-first topic-first
+do
+	test_expect_success "--follow follows a rename from the second parent ($order)" '
+		git -C rename-$order log --follow --pretty=tformat:%s new >actual &&
+		cat >expect <<-\EOF &&
+		R: rename old to new
+		B: modify old
+		A: add old
+		EOF
+		test_cmp expect actual
+	'
+done
+
+test_expect_success 'setup merge keeping the path, other side renamed it' '
+	git init keep &&
+	printf "line 1\nline 2\nline 3\nline 4\nline 5\n" >keep/F &&
+	git -C keep add F &&
+	test_tick &&
+	git -C keep commit -m "O: add F" &&
+	git -C keep branch B &&
+	printf "line 1\nline 2\nline 3 A\nline 4\nline 5\n" >keep/F &&
+	test_tick &&
+	git -C keep commit -am "A1: update F in place" &&
+
+	git -C keep checkout B &&
+	git -C keep mv F G &&
+	test_tick &&
+	git -C keep commit -m "B1: rename F to G" &&
+	printf "line 1\nline 2\nline 3\nline 4 B\nline 5\n" >keep/G &&
+	test_tick &&
+	git -C keep commit -am "B2: update G" &&
+
+	git -C keep checkout master &&
+	test_tick &&
+	git -C keep merge -s ours -m "M: merge B, keep F, drop G" B
+'
+
+test_expect_success '--follow follows a rename on the side the merge did not take' '
+	git -C keep log --follow --pretty=tformat:%s F >actual &&
+	cat >expect <<-\EOF &&
+	B2: update G
+	B1: rename F to G
+	A1: update F in place
+	O: add F
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.56.0

