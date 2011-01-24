From: Shuang He <shuang.he@intel.com>
Subject: [PATCH] add config option core.bisectbadbranchfirst
Date: Mon, 24 Jan 2011 10:05:27 +0800
Message-ID: <1295834727-21765-1-git-send-email-shuang.he@intel.com>
References: <4D3CDDF9.6080405@intel.com>
Cc: Shuang He <shuang.he@intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 24 03:05:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhBnk-0006Gy-7J
	for gcvg-git-2@lo.gmane.org; Mon, 24 Jan 2011 03:05:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753459Ab1AXCEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jan 2011 21:04:42 -0500
Received: from mga14.intel.com ([143.182.124.37]:36906 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753450Ab1AXCEl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jan 2011 21:04:41 -0500
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga102.ch.intel.com with ESMTP; 23 Jan 2011 18:04:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.60,367,1291622400"; 
   d="scan'208";a="378851559"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.239.36.139])
  by azsmga001.ch.intel.com with ESMTP; 23 Jan 2011 18:04:39 -0800
X-Mailer: git-send-email 1.7.4.rc2.21.g7f7a8
In-Reply-To: <4D3CDDF9.6080405@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165434>

which enable recursive bad-branch-first algorithm for git-bisect.
With this algorithm, git-bisect will always try to select commits
that on the same branch current bad commit sits. And will fall back
to default git-bisect algorithm when bad-branch-first algorithm does
not apply

Signed-off-by: Shuang He <shuang.he@intel.com>
---
 Documentation/config.txt |    8 ++
 bisect.c                 |  244 +++++++++++++++++++++++++++++++++++++++++-----
 bisect.h                 |    2 +-
 builtin/rev-list.c       |    2 +-
 cache.h                  |    1 +
 config.c                 |    6 +
 environment.c            |    1 +
 7 files changed, 238 insertions(+), 26 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ff7c225..8502859 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -558,6 +558,14 @@ core.sparseCheckout::
 	Enable "sparse checkout" feature. See section "Sparse checkout" in
 	linkgit:git-read-tree[1] for more information.
 
+core.bisectbadbranchfirst::
+	With this algorithm, git-bisect will always try to select commits
+	that on the same branch current bad commit sits. And will fall back
+	to default git-bisect algorithm when bad-branch-first algorithm does
+	not apply
++
+This setting defaults to "false".
+
 add.ignore-errors::
 add.ignoreErrors::
 	Tells 'git add' to continue adding files when some files cannot be
diff --git a/bisect.c b/bisect.c
index 060c042..57c410d 100644
--- a/bisect.c
+++ b/bisect.c
@@ -189,6 +189,46 @@ static struct commit_list *best_bisection(struct commit_list *list, int nr)
 	return best;
 }
 
+static struct commit_list *best_bisection_first_parent(struct commit_list *list, struct commit_list *list2, int nr)
+{
+	struct commit_list *p, *best;
+	struct commit_list *p2;
+	int best_distance = -1;
+
+	best = NULL;
+	for (p2 = list2; p2; p2 = p2->next) {
+		int distance;
+		int on_branch;
+
+		on_branch = 0;
+		for (p = list; p; p = p->next) {
+			unsigned flags = p->item->object.flags;
+			if (flags & TREESAME)
+				continue;
+			if (!hashcmp(p->item->object.sha1, p2->item->object.sha1)) {
+				on_branch = 1;
+				break;
+			}
+		}
+
+		if (!on_branch)
+			continue;
+
+		weight_set(p2, weight(p));
+		distance = weight(p);
+		if (nr - distance < distance)
+			distance = nr - distance;
+		if (distance > best_distance) {
+			best = p;
+			best_distance = distance;
+		}
+
+	}
+
+	return list2;
+}
+
+
 struct commit_dist {
 	struct commit *commit;
 	int distance;
@@ -253,7 +293,7 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
  * unknown.  After running count_distance() first, they will get zero
  * or positive distance.
  */
-static struct commit_list *do_find_bisection(struct commit_list *list,
+static struct commit_list *do_find_bisection(struct commit_list *list, struct commit_list *list2,
 					     int nr, int *weights,
 					     int find_all)
 {
@@ -314,7 +354,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		clear_distance(list);
 
 		/* Does it happen to be at exactly half-way? */
-		if (!find_all && halfway(p, nr))
+		if (!list2 && !find_all && halfway(p, nr))
 			return p;
 		counted++;
 	}
@@ -352,20 +392,27 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 				weight_set(p, weight(q));
 
 			/* Does it happen to be at exactly half-way? */
-			if (!find_all && halfway(p, nr))
+			if (!list2 && !find_all && halfway(p, nr))
 				return p;
 		}
 	}
 
 	show_list("bisection 2 counted all", counted, nr, list);
 
+	if (list2) {
+		struct commit_list *t;
+		t = best_bisection_first_parent(list, list2, nr);
+		t = best_bisection_sorted(t, nr);
+		return t;
+	}
+
 	if (!find_all)
 		return best_bisection(list, nr);
 	else
 		return best_bisection_sorted(list, nr);
 }
 
-struct commit_list *find_bisection(struct commit_list *list,
+struct commit_list *find_bisection(struct commit_list *list, struct commit_list *list2,
 					  int *reaches, int *all,
 					  int find_all)
 {
@@ -400,7 +447,7 @@ struct commit_list *find_bisection(struct commit_list *list,
 	weights = xcalloc(on_list, sizeof(*weights));
 
 	/* Do the real work of finding bisection commit. */
-	best = do_find_bisection(list, nr, weights, find_all);
+	best = do_find_bisection(list, list2, nr, weights, find_all);
 	if (best) {
 		if (!find_all)
 			best->next = NULL;
@@ -683,6 +730,33 @@ static void bisect_rev_setup(struct rev_info *revs, const char *prefix,
 	setup_revisions(rev_argv.argv_nr, rev_argv.argv, revs, NULL);
 }
 
+static void bisect_rev_setup_first_parent(struct rev_info *revs, const char *prefix,
+			     const char *bad_format, const char *good_format,
+			     int read_paths)
+{
+	struct argv_array rev_argv = { NULL, 0, 0 };
+	int i;
+
+	init_revisions(revs, prefix);
+	revs->abbrev = 0;
+	revs->commit_format = CMIT_FMT_UNSPECIFIED;
+
+	/* rev_argv.argv[0] will be ignored by setup_revisions */
+	argv_array_push(&rev_argv, xstrdup("bisect_rev_setup_first_parent"));
+	argv_array_push_sha1(&rev_argv, current_bad_sha1, bad_format);
+	for (i = 0; i < good_revs.sha1_nr; i++)
+		argv_array_push_sha1(&rev_argv, good_revs.sha1[i],
+				     good_format);
+	argv_array_push(&rev_argv, xstrdup("--first-parent"));
+	argv_array_push(&rev_argv, xstrdup("--"));
+	if (read_paths)
+		read_bisect_paths(&rev_argv);
+	argv_array_push(&rev_argv, NULL);
+
+	setup_revisions(rev_argv.argv_nr, rev_argv.argv, revs, NULL);
+}
+
+
 static void bisect_common(struct rev_info *revs)
 {
 	if (prepare_revision_walk(revs))
@@ -944,6 +1018,24 @@ static void show_diff_tree(const char *prefix, struct commit *commit)
 	log_tree_commit(&opt, commit);
 }
 
+int is_merge_commit(struct commit_list *entry) {
+	int nr = 0;
+	struct commit *commit;
+	struct commit_list *p;
+
+	if (entry) {
+		p = entry->item->parents;
+
+		while (p) {
+			nr += 1;
+			p = p->next;
+		}
+	}
+
+	return nr - 1;
+}
+
+
 /*
  * We use the convention that exiting with an exit code 10 means that
  * the bisection process finished successfully.
@@ -952,41 +1044,145 @@ static void show_diff_tree(const char *prefix, struct commit *commit)
 int bisect_next_all(const char *prefix)
 {
 	struct rev_info revs;
+	struct rev_info first_parent_revs;
 	struct commit_list *tried;
 	int reaches = 0, all = 0, nr, steps;
+	struct object_array pending_copy;
+	struct object_array pending_copy2;
 	const unsigned char *bisect_rev;
+	int i;
 	char bisect_rev_hex[41];
+	int bad_branch_first_working = 1;
 
 	if (read_bisect_refs())
 		die("reading bisect refs failed");
 
 	check_good_are_ancestors_of_bad(prefix);
+	struct argv_array rev_argv = { NULL, 0, 0 };
+	
+	read_bisect_paths(&rev_argv);
+	if (rev_argv.argv_nr > 0)
+		core_bisect_bad_branch_first = 0;
+
+	if (core_bisect_bad_branch_first) {
+		bisect_rev_setup_first_parent(&first_parent_revs, prefix, "%s", "^%s", 1);
+		memset(&pending_copy, 0, sizeof(pending_copy));
+		for (i = 0; i < first_parent_revs.pending.nr; i++)
+			add_object_array(first_parent_revs.pending.objects[i].item,
+					 first_parent_revs.pending.objects[i].name,
+					 &pending_copy);
+
+		bisect_common(&first_parent_revs);
+
+		/* Clean up objects used, as they will be reused. */
+		for (i = 0; i < pending_copy.nr; i++) {
+			struct object *o = pending_copy.objects[i].item;
+			clear_commit_marks((struct commit *)o, ALL_REV_FLAGS);
+		}
+	}
 
-	bisect_rev_setup(&revs, prefix, "%s", "^%s", 1);
-	revs.limited = 1;
 
-	bisect_common(&revs);
 
-	revs.commits = find_bisection(revs.commits, &reaches, &all,
-				       !!skipped_revs.sha1_nr);
-	revs.commits = managed_skipped(revs.commits, &tried);
+	if (core_bisect_bad_branch_first) {
+		bisect_rev_setup(&revs, prefix, "%s", "^%s", 1);
+		memset(&pending_copy2, 0, sizeof(pending_copy2));
+		for (i = 0; i < revs.pending.nr; i++)
+			add_object_array(revs.pending.objects[i].item,
+					 revs.pending.objects[i].name,
+					 &pending_copy2);
+
+		revs.limited = 1;
+
+		bisect_common(&revs);
+
+		revs.commits = find_bisection(revs.commits, first_parent_revs.commits, &reaches, &all,
+					       !!skipped_revs.sha1_nr);
+		/* TODO: Check if this is a first bad commit on bad branch, and if it's a merge commit */
+		/* If this is a merge commit, we need to try all of its parents, until we found the merged bad branch */
+		/* If all parents are good, we just announce it as first bad commit */
+		if (!hashcmp(revs.commits->item->object.sha1, current_bad_sha1)) {
+			printf("%s is the first bad commit\n", sha1_to_hex(current_bad_sha1));
+
+			if (is_merge_commit(revs.commits)) {
+				int all_parents_good = 1;
+				struct commit_list *p;
+
+				printf("%s is a merge commit\n", sha1_to_hex(current_bad_sha1));
+				printf("need to try each merged branch\n", sha1_to_hex(current_bad_sha1));
+				p = revs.commits->item->parents;
+
+				while (p) {
+					if (!hashcmp(p->item->object.sha1, current_bad_sha1)) {
+						fprintf(stderr, "should not get here\n");
+						exit(1);
+					} else if (0 <= lookup_sha1_array(&good_revs, p->item->object.sha1)) {
+						fprintf(stderr, "good parent %s\n", sha1_to_hex(p->item->object.sha1));
+					} else if (0 <= lookup_sha1_array(&skipped_revs, p->item->object.sha1)) {
+						fprintf(stderr, "skipped parent %s\n", sha1_to_hex(p->item->object.sha1));
+						all_parents_good = 0;
+					} else {
+						printf("try merged branch %s\n", sha1_to_hex(p->item->object.sha1));
+						exit(bisect_checkout(sha1_to_hex(p->item->object.sha1)));
+					}
+					p = p->next;
+				}
+
+				if (all_parents_good) {
+					show_diff_tree(prefix, revs.commits->item);
+					exit(10);
+				}
+			}
+			else {
+				show_diff_tree(prefix, revs.commits->item);
+				exit(10);
+			}
+		}
+
+		revs.commits = managed_skipped(revs.commits, &tried);
 
-	if (!revs.commits) {
-		/*
-		 * We should exit here only if the "bad"
-		 * commit is also a "skip" commit.
-		 */
-		exit_if_skipped_commits(tried, NULL);
+		if (!revs.commits || !all) {
+			bad_branch_first_working = 0;
+			fprintf(stderr, "fall back to default git-bisect algorithm\n");
+		}
+		else
+			fprintf(stderr, "proceed with core_bisect_bad_branch_first algorithm\n");
 
-		printf("%s was both good and bad\n",
-		       sha1_to_hex(current_bad_sha1));
-		exit(1);
+		/* Clean up objects used, as they will be reused. */
+		for (i = 0; i < pending_copy2.nr; i++) {
+			struct object *o = pending_copy2.objects[i].item;
+			clear_commit_marks((struct commit *)o, ALL_REV_FLAGS);
+		}
 	}
 
-	if (!all) {
-		fprintf(stderr, "No testable commit found.\n"
-			"Maybe you started with bad path parameters?\n");
-		exit(4);
+
+	if (!core_bisect_bad_branch_first || !bad_branch_first_working) {
+		bisect_rev_setup(&revs, prefix, "%s", "^%s", 1);
+		revs.limited = 1;
+
+		bisect_common(&revs);
+		show_list("fall back", 0, 0, revs.commits);
+
+		revs.commits = find_bisection(revs.commits, NULL, &reaches, &all,
+					       !!skipped_revs.sha1_nr);
+		revs.commits = managed_skipped(revs.commits, &tried);
+
+		if (!revs.commits) {
+			/*
+			 * We should exit here only if the "bad"
+			 * commit is also a "skip" commit.
+			 */
+			exit_if_skipped_commits(tried, NULL);
+	
+			printf("%s was both good and bad\n",
+			       sha1_to_hex(current_bad_sha1));
+			exit(1);
+		}
+
+		if (!all) {
+			fprintf(stderr, "No testable commit found.\n"
+				"Maybe you started with bad path parameters?\n");
+			exit(4);
+		}
 	}
 
 	bisect_rev = revs.commits->item->object.sha1;
diff --git a/bisect.h b/bisect.h
index 0862ce5..fad4fbe 100644
--- a/bisect.h
+++ b/bisect.h
@@ -1,7 +1,7 @@
 #ifndef BISECT_H
 #define BISECT_H
 
-extern struct commit_list *find_bisection(struct commit_list *list,
+extern struct commit_list *find_bisection(struct commit_list *list, struct commit_list *list2,
 					  int *reaches, int *all,
 					  int find_all);
 
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ba27d39..ab56f6b 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -399,7 +399,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (bisect_list) {
 		int reaches = reaches, all = all;
 
-		revs.commits = find_bisection(revs.commits, &reaches, &all,
+		revs.commits = find_bisection(revs.commits, NULL, &reaches, &all,
 					      bisect_find_all);
 
 		if (bisect_show_vars)
diff --git a/cache.h b/cache.h
index d83d68c..bfd4448 100644
--- a/cache.h
+++ b/cache.h
@@ -559,6 +559,7 @@ extern int read_replace_refs;
 extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
+extern int core_bisect_bad_branch_first;
 
 enum safe_crlf {
 	SAFE_CRLF_FALSE = 0,
diff --git a/config.c b/config.c
index 625e051..b37a70c 100644
--- a/config.c
+++ b/config.c
@@ -660,6 +660,12 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.bisectbadbranchfirst")) {
+		core_bisect_bad_branch_first = git_config_bool(var, value);
+		return 0;
+	}
+
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 9564475..cf813af 100644
--- a/environment.c
+++ b/environment.c
@@ -55,6 +55,7 @@ enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
 char *notes_ref_name;
 int grafts_replace_parents = 1;
 int core_apply_sparse_checkout;
+int core_bisect_bad_branch_first = 0;
 struct startup_info *startup_info;
 
 /* Parallel index stat data preload? */
-- 
1.7.4.rc2.21.g7f7a8
