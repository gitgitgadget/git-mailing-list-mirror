Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BF34219EA
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 18:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770403785; cv=none; b=bgxNrQyeF03QmibMaW6TY7SFPfaD9JUOfAqh5QAOW8t9+3XXUW2w+LxKGPydaJLwK0lQxSD9gy/iBuQjl2LjGyJNfot9jH8kGKpwAwouhVPWhWYoMPv8Wfyp3hj2oZ14oyECPxlHAPDjDvsFy2ZIcU5fyoPP/GMi4a05OqY5z04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770403785; c=relaxed/simple;
	bh=hb3auObIAsQDWMlcSemL7dRMsdUfZkaGP5TRtw3j7f0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=q4neBzk1mx3/g5VlMpzUwvE5rCARprwSpQxYpgSOd2HKYfSEr+SoVywOD2MQm/rMAnJCMQm88zOqhFHDZbf6HA7+phGjKw+qNQvFAHe+0hYx/Kz9nXHBWgPfn6qTLbIvZeGQhCR7T4sVxZXv9BK22bbd1vLb56P0DuqhWS8hZiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=krSsr9aS; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="krSsr9aS"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1770403781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OEdNQfOtnuV6217OO3P6sxanJvlmBOg3tEt4cA0PiVs=;
	b=krSsr9aS/IvFGw74aMX9kYcpLd6LkCYdSoRkeTnFWIkJjrnZAB5LBetGRxOKg7bcYViOzR
	oM1S5rbJj+QOtt9Kk554d78zCIqKWsFBQsKuAnPakqshCnuebAichYwtAqsp1f5H622q7C
	C+rhRUy4S9syjN77Whgt4I0P0qTC1Bk=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 06 Feb 2026 19:49:18 +0100
Subject: [PATCH RFC] graph: implement git-log(1) --untangle
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-toon-log-graph-no-merge-base-v1-1-a6f983991a1d@iotcl.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QrCMAyF4VcZuTYwi7Xgq4gX7Ra7iDYjmSKMv
 btRbw58cPhXMFImg1O3gtKLjaU59rsOhim3SsijG0Ifjr0PLiIN71Kxap4nbIIPUr+VbIQpxRA
 jlTEdMnhiVrry+5c/X/62Z7nRsHybsG0fG7Xtx4AAAAA=
X-Change-ID: 20260202-toon-log-graph-no-merge-base-775255ebd74a
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

The output of `git log --graph` can be cluttered when dealing with
long-living branches or octopus merges.

For example consider this graph:

    * left
    | *-.   octopus-merge
    |/|\ \
    | | | * 4
    | | * | 3
    | | |/
    | * / 2
    | |/
    * / 1
    |/
    * initial

The reason this looks messy, is because for each merged branch there is
a line back to the source branch. But in most cases, the user doesn't
care when merged branches are branched of.

To simplify the graph, implement option `--untangle`.

    * left
    | *-.   octopus-merge
    |/|\ \
    | | | * 4
    | | * 3
    | * 2
    * 1
    * initial

As you can see, this untangles the arms of the octopus.

To implement this feature, merge commits are treated a differently. For
each parent commit (except the first one) of a merge, the merge-base
with the first parent is found. That merge-base is saved in the column
for that branch and when the next commit for the column would be that
merge-base, no lines are drawn no more.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
I was at FOSDEM this weekend, and there someone spoke[1] about merge
strategies. Now you can argue whether merge commits are good or not, but
one argument is less likely to argue about: it can make
`git log --graph --oneline` look really cluttered. For example take this
fragment of the graph of 'master' in the git.git project:

    * | | | | | | | | | | | | | |   d627023d80 Merge branch 'ps/packfile-store-in-odb-source'
    |\ \ \ \ \ \ \ \ \ \ \ \ \ \ \
    | * | | | | | | | | | | | | | | a282a8f163 packfile: move MIDX into packfile store
    | * | | | | | | | | | | | | | | a593373b09 packfile: refactor `find_pack_entry()` to work on the packfile store
    | * | | | | | | | | | | | | | | 6acefa0d2c packfile: inline `find_kept_pack_entry()`
    | * | | | | | | | | | | | | | | 8384cbcb4c packfile: only prepare owning store in `packfile_store_prepare()`
    | * | | | | | | | | | | | | | | 7b330a11de packfile: only prepare owning store in `packfile_store_get_packs()`
    | * | | | | | | | | | | | | | | 84f0e60b28 packfile: move packfile store into object source
    | * | | | | | | | | | | | | | | eb9ec52d95 packfile: refactor misleading code when unusing pack windows
    | * | | | | | | | | | | | | | | 085de91b95 packfile: refactor kept-pack cache to work with packfile stores
    | * | | | | | | | | | | | | | | 0316c63ca4 packfile: pass source to `prepare_pack()`
    | * | | | | | | | | | | | | | | 480336a9ce packfile: create store via its owning source
    | * | | | | | | | | | | | | | |   f1ec43d4d2 Merge branch 'ps/odb-misc-fixes' into ps/packfile-store-in-odb-source
    | |\ \ \ \ \ \ \ \ \ \ \ \ \ \ \
    | * \ \ \ \ \ \ \ \ \ \ \ \ \ \ \   f1799202ea Merge branch 'ps/object-read-stream' into ps/packfile-store-in-odb-source
    | |\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \
    * | \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \   ab72d23880 Merge branch 'kt/http-backend-errors'
    |\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \
    | * | | | | | | | | | | | | | | | | | a8227ae8d5 http-backend: write newlines to stderr when responding with errors
    | | |_|_|_|_|_|_|_|/ / / / / / / / /
    | |/| | | | | | | | | | | | | | | |
    * | | | | | | | | | | | | | | | | |   e01178bb1a Merge branch 'ps/t1410-cleanup'

This graph can grow wide very quickly.

I would argue the problem here are not the merge commits, but it's the
way this is displayed.

So that got me thinking. `git log --graph` shows lines from child
commits to each of their parents. This is very useful for branches to
see which of the parent commits they include. But it's less useful for
merged branches. In most cases for a branch that was merged, nobody
cares from which commit that branch was branched of, because that merge
comit contains all changes from the history of all parents of that merge
commit.

That's why I've created this experiment. In this patch I'm adding a new
option `--untangle` to git-log(1). This option, as I like to call it,
"untangles the octopus".

There are still some bugs in this implementation. And a bunch of memory
leaks. Also am I not sold on the name `--untangle`. It sounds catchy,
but it's name isn't very meaningful for most users. I've been thinking
about `--ignore-merge-base` or `disconnect-merge-base`, but I'm open to
better suggestions. That's why I'm submitting this as a RFC. Before I
continue work on this, I'm curious if the project is open to such
contribution? And if so, which direction it should go?

[1]: https://fosdem.org/2026/schedule/event/3VNNBK-efficient-git-for-high-stakes/
---
 graph.c                      | 107 ++++++++++++++++++++++++++++++++++++++++---
 graph.h                      |   8 ++++
 revision.c                   |   6 +++
 t/t4214-log-graph-octopus.sh | 104 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 218 insertions(+), 7 deletions(-)

diff --git a/graph.c b/graph.c
index 26f6fbf000..2657990054 100644
--- a/graph.c
+++ b/graph.c
@@ -8,6 +8,7 @@
 #include "graph.h"
 #include "revision.h"
 #include "strvec.h"
+#include "commit-reach.h"
 
 /* Internal API */
 
@@ -51,6 +52,11 @@ static void graph_show_strbuf(struct git_graph *graph,
  */
 
 struct column {
+	/*
+	 * When only_first_merge_base is set this column might be ignoring it's
+         * merge-base, store it here.
+	 */
+	struct commit_list *ignored_merge_bases;
 	/*
 	 * The parent commit of this column.
 	 */
@@ -315,6 +321,14 @@ struct git_graph {
 	 * diff_output_prefix_callback().
 	 */
 	struct strbuf prefix_buf;
+
+	/*
+	 * For merge commits, determine the merge-base for the parent commits.
+	 * With only_first_merge_base set, only the first parent is connected
+	 * back to the merge-base. This simplifies the graph and makes the
+	 * merged branches appear like they originate from another root commit.
+	 */
+	bool only_first_merge_base;
 };
 
 static const char *diff_output_prefix_callback(struct diff_options *opt, void *data)
@@ -391,8 +405,8 @@ struct git_graph *graph_init(struct rev_info *opt)
 	 * We'll automatically grow columns later if we need more room.
 	 */
 	graph->column_capacity = 30;
-	ALLOC_ARRAY(graph->columns, graph->column_capacity);
-	ALLOC_ARRAY(graph->new_columns, graph->column_capacity);
+	CALLOC_ARRAY(graph->columns, graph->column_capacity);
+	CALLOC_ARRAY(graph->new_columns, graph->column_capacity);
 	ALLOC_ARRAY(graph->mapping, 2 * graph->column_capacity);
 	ALLOC_ARRAY(graph->old_mapping, 2 * graph->column_capacity);
 
@@ -404,6 +418,8 @@ struct git_graph *graph_init(struct rev_info *opt)
 	opt->diffopt.output_prefix = diff_output_prefix_callback;
 	opt->diffopt.output_prefix_data = graph;
 
+	graph->only_first_merge_base = false;
+
 	return graph;
 }
 
@@ -412,6 +428,13 @@ void graph_clear(struct git_graph *graph)
 	if (!graph)
 		return;
 
+	for (size_t i = 0; i < graph->num_columns; i++) {
+		free_commit_list(graph->columns[i].ignored_merge_bases);
+	}
+	for (size_t i = 0; i < graph->num_new_columns; i++) {
+		free_commit_list(graph->new_columns[i].ignored_merge_bases);
+	}
+
 	free(graph->columns);
 	free(graph->new_columns);
 	free(graph->mapping);
@@ -420,6 +443,12 @@ void graph_clear(struct git_graph *graph)
 	free(graph);
 }
 
+void graph_set_only_first_merge_base(struct git_graph *graph, bool skip)
+{
+	if (graph)
+		graph->only_first_merge_base = skip;
+}
+
 static void graph_update_state(struct git_graph *graph, enum graph_state s)
 {
 	graph->prev_state = graph->state;
@@ -550,7 +579,8 @@ static int graph_find_new_column_by_commit(struct git_graph *graph,
 
 static void graph_insert_into_new_columns(struct git_graph *graph,
 					  struct commit *commit,
-					  int idx)
+					  int idx,
+					  struct commit_list *merge_bases)
 {
 	int i = graph_find_new_column_by_commit(graph, commit);
 	int mapping_idx;
@@ -563,6 +593,9 @@ static void graph_insert_into_new_columns(struct git_graph *graph,
 		i = graph->num_new_columns++;
 		graph->new_columns[i].commit = commit;
 		graph->new_columns[i].color = graph_find_commit_color(graph, commit);
+
+		//free_commit_list(graph->new_columns[i].ignored_merge_bases);
+		graph->new_columns[i].ignored_merge_bases = merge_bases;
 	}
 
 	if (graph->num_parents > 1 && idx > -1 && graph->merge_layout == -1) {
@@ -605,7 +638,7 @@ static void graph_insert_into_new_columns(struct git_graph *graph,
 
 static void graph_update_columns(struct git_graph *graph)
 {
-	struct commit_list *parent;
+	struct commit_list *parent, *first_parent, *ignored_parent, *ignored_merge_bases;
 	int max_new_columns;
 	int i, seen_this, is_commit_in_columns;
 
@@ -667,11 +700,45 @@ static void graph_update_columns(struct git_graph *graph)
 
 		if (col_commit == graph->commit) {
 			seen_this = 1;
+			first_parent = NULL;
+			ignored_merge_bases = graph->columns[i].ignored_merge_bases;
 			graph->commit_index = i;
 			graph->merge_layout = -1;
+
+			/*
+			 * Find the parent that should be ignored, if any?
+			 */
+			ignored_parent = NULL;
+			for (parent = first_interesting_parent(graph);
+			     parent;
+			     parent = next_interesting_parent(graph, parent)) {
+				if (commit_list_contains(parent->item, ignored_merge_bases)) {
+					/*
+					 * Note: We only get in this codepath
+					 * when graph->only_first_merge_base is
+					 * set, because otherwise
+					 * ignored_merge_bases would be NULL.
+					 */
+					ignored_parent = parent;
+
+					/*
+					 * Whoops, fix miscalculated parent count.
+					 * TODO is this really needed?
+					 */
+					graph->num_parents -= 1;
+					break;
+				}
+			}
+
 			for (parent = first_interesting_parent(graph);
 			     parent;
 			     parent = next_interesting_parent(graph, parent)) {
+				/*
+				 * Skip the ignored parent
+				 */
+				if (ignored_parent && ignored_parent->item == parent->item)
+					continue;
+
 				/*
 				 * If this is a merge, or the start of a new
 				 * childless column, increment the current
@@ -681,7 +748,30 @@ static void graph_update_columns(struct git_graph *graph)
 				    !is_commit_in_columns) {
 					graph_increment_column_color(graph);
 				}
-				graph_insert_into_new_columns(graph, parent->item, i);
+
+				if (!first_parent) {
+					first_parent = parent;
+
+					if (ignored_parent) {
+						/*
+						 * One of the parents was ignored,
+						 * the new ignored merge-base can be found
+						 * against that parent.
+						 */
+						if (repo_get_merge_bases(graph->revs->repo, ignored_parent->item, parent->item, &ignored_merge_bases) < 0) {
+							free_commit_list(ignored_merge_bases);
+							ignored_merge_bases = NULL;
+						}
+					}
+				} else if (graph->only_first_merge_base) {
+					if (repo_get_merge_bases(graph->revs->repo, first_parent->item, parent->item, &ignored_merge_bases) < 0) {
+						free_commit_list(ignored_merge_bases);
+						ignored_merge_bases = NULL;
+					}
+				}
+
+				graph_insert_into_new_columns(graph, parent->item, i,
+							      ignored_merge_bases);
 			}
 			/*
 			 * We always need to increment graph->width by at
@@ -692,7 +782,7 @@ static void graph_update_columns(struct git_graph *graph)
 			if (graph->num_parents == 0)
 				graph->width += 2;
 		} else {
-			graph_insert_into_new_columns(graph, col_commit, -1);
+			graph_insert_into_new_columns(graph, col_commit, -1, graph->columns[i].ignored_merge_bases);
 		}
 	}
 
@@ -1112,6 +1202,9 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
 			seen_this = 1;
 
 			for (j = 0; j < graph->num_parents; j++) {
+				if (!parents)
+					break;
+
 				par_column = graph_find_new_column_by_commit(graph, parents->item);
 				assert(par_column >= 0);
 
@@ -1145,7 +1238,7 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
 			}
 		}
 
-		if (col_commit == first_parent->item)
+		if (first_parent && col_commit == first_parent->item)
 			parent_col = col;
 	}
 
diff --git a/graph.h b/graph.h
index 3fd1dcb2e9..e2568ae803 100644
--- a/graph.h
+++ b/graph.h
@@ -144,6 +144,14 @@ struct git_graph *graph_init(struct rev_info *opt);
  */
 void graph_clear(struct git_graph *graph);
 
+/*
+ * Enable skip-merge-base mode for the graph.
+ * When enabled, non-first-parent branches from merge commits will not
+ * show history beyond the merge-base, making the graph simpler by
+ * showing branches as if they have separate roots.
+ */
+void graph_set_only_first_merge_base(struct git_graph *graph, bool skip);
+
 /*
  * Update a git_graph with a new commit.
  * This will cause the graph to begin outputting lines for the new commit
diff --git a/revision.c b/revision.c
index 9b131670f7..71a2a4ed57 100644
--- a/revision.c
+++ b/revision.c
@@ -2602,6 +2602,12 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--no-graph")) {
 		graph_clear(revs->graph);
 		revs->graph = NULL;
+	} else if (!strcmp(arg, "--untangle")) {
+		if (!revs->graph)
+			revs->graph = graph_init(revs);
+		graph_set_only_first_merge_base(revs->graph, true);
+	} else if (!strcmp(arg, "--no-untangle")) {
+		graph_set_only_first_merge_base(revs->graph, 0);
 	} else if (!strcmp(arg, "--encode-email-headers")) {
 		revs->encode_email_headers = 1;
 	} else if (!strcmp(arg, "--no-encode-email-headers")) {
diff --git a/t/t4214-log-graph-octopus.sh b/t/t4214-log-graph-octopus.sh
index f70c46bbbf..181bce074b 100755
--- a/t/t4214-log-graph-octopus.sh
+++ b/t/t4214-log-graph-octopus.sh
@@ -347,4 +347,108 @@ test_expect_success 'log --graph with unrelated commit and octopus child with co
 	test_cmp_colored_graph after-initial after-merge
 '
 
+test_expect_success 'log --graph --untangle with tricky octopus merge, no color' '
+	test_cmp_graph --untangle left octopus-merge <<-\EOF
+	* left
+	| *-.   octopus-merge
+	|/|\ \
+	| | | * 4
+	| | * 3
+	| * 2
+	* 1
+	* initial
+	EOF
+'
+
+test_expect_success 'log --graph --untangle with branch from merged branch, no color' '
+	test_when_finished rm -rf repo &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		test_commit a &&
+		git checkout initial -b feat-1 &&
+		test_commit b &&
+		git checkout main &&
+		test_merge feat-1-merge feat-1 &&
+		test_commit c &&
+		git checkout b -b feat-2 &&
+		test_commit d &&
+		git checkout main &&
+		test_merge feat-2-merge feat-2 &&
+		test_cmp_graph main --untangle <<-\EOF
+		*   feat-2-merge
+		|\
+		| * d
+		* c
+		*   feat-1-merge
+		|\
+		| * b
+		* a
+		* initial
+		EOF
+	)
+'
+
+test_expect_success 'log --graph --untangle with intermediate merge of source branch, no color' '
+	test_when_finished rm -rf repo &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		test_commit a &&
+		test_commit b &&
+		git checkout initial -b feat-1 &&
+		test_commit c &&
+		test_merge merge-a a &&
+		test_commit d &&
+		git checkout main &&
+		test_merge feat-1-merge feat-1 &&
+		test_cmp_graph main --untangle <<-\EOF
+		*   feat-1-merge
+		|\
+		| * d
+		| * merge-a
+		| * c
+		* b
+		* a
+		* initial
+		EOF
+	)
+'
+
+test_expect_success 'log --graph with merging branch from other root commit, no color' '
+	test_when_finished rm -rf repo &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		test_commit a &&
+		test_commit b &&
+		git checkout --orphan orphan &&
+		test_commit I &&
+		test_commit II &&
+		git checkout main &&
+		test_merge merge-orphan --allow-unrelated-histories orphan &&
+		test_commit c &&
+		git checkout a -b feat &&
+		test_commit d &&
+		git checkout main &&
+		test_merge merge-feat feat &&
+		test_cmp_graph main --untangle <<-\EOF
+		*   merge-feat
+		|\
+		| * d
+		* c
+		*   merge-orphan
+		|\
+		| * II
+		| * I
+		* b
+		* a
+		* initial
+		EOF
+	)
+'
+
 test_done

---
base-commit: 22584464849815268419fd9d2eba307362360db1
change-id: 20260202-toon-log-graph-no-merge-base-775255ebd74a

