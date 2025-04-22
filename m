Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFBE296D1C
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 17:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745344028; cv=none; b=tOx83sh03U1oNBU2L3pbHx13/G0BscJhvAJKdFSWtQ6VJTKmDZcwBnCOoiC4YLd6WXl/5S6g/T85v687bsee8dkoBcaX54udICvrQn3PlMbSZtU1p91HqtRUKPYdL2x4kXF2Q33/vfA3cyKjbS9jFD7DYiR+wC/aVoSKWBRtC2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745344028; c=relaxed/simple;
	bh=KEefE/7hbqmN7LhVK7ZtJlmfgRAMHS846YdT/ddzQ+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tKFjqPon79QTDgJrPY/o/Co5QONE1ibjHi66U8qwZQ6MPhyB+urtVsjrF1ajN/pETdx07ZQpk3YTI2DJ+MdCPvCUhub5vApSUpxEuhT4X2Hzk+HKS/w1UgO+YP6xPppyacC6jgoGuXwg8VUYaFp4iMRGWh1sbVa6GkkW49UN+IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=jIgxntqO; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="jIgxntqO"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1745344022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G/NkLv4LH35f1Nkdz2EyyEM4d5ZqYT/jsKH5xWsTElY=;
	b=jIgxntqOWGKsgj8Z4AP9nOz7AGWfNEKdaC3TO//WoJ+ilBRYQcQ6wGV8u/9CilGQU4ChlE
	m3sR1CzNnemLBL+wIGiIjacU7ddAaekNwGUWUztkEyCsX7AsAV4LfuMbm/MC1H6OuYowVk
	GVtgDwrHG6fCK344wqnOLX3ypMMD7vk=
From: Toon Claes <toon@iotcl.com>
Date: Tue, 22 Apr 2025 19:46:27 +0200
Subject: [PATCH RFC 4/5] blame-tree: implement faster algorithm
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-toon-new-blame-tree-v1-4-fdb51b8a394a@iotcl.com>
References: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
In-Reply-To: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, 
 Derrick Stolee <stolee@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Derrick Stolee <stolee@gmail.com>
X-Migadu-Flow: FLOW_OUT

From: Taylor Blau <me@ttaylorr.com>

The current implementation of 'git blame-tree' works by doing a revision
walk, and inspecting the diff at each level of that walk to annotate the
yet-unblamed entries to a path. In other words, if the diff at some
level touches a path which has not yet been associated with a commit,
then that commit becomes associated with the path.

While a perfectly reasonable implementation, it can perform poorly in
either one of two scenarios:

  1. There are many entries of interest, in which case there is simply
     more work to do.

  2. Or, there are (even a few) entries which have not been updated in a
     long time, and so we must walk through a lot of history in order to
     find a commit that touches that path.

This patch rewrites the blame-tree implementation that addresses (2).
The idea behind the algorithm is to propagate a set of 'active' paths (a
path is 'active' if it does not yet belong to a commit) up to parents
and do a truncated revision walk.

The walk is truncated because it does not produce a revision for every
change in the original pathspec, but rather only for active paths.

More specifically, consider a priority queue of commits sorted by
generation number. First, enqueue the set of boundary commits with all
paths in the original spec marked as interesting.

Then, while the queue is not empty, do the following:

  1. Pop an element, say, 'c', off of the queue, making sure that 'c'
     isn't reachable by anything in the '--not' set.

  2. For each parent 'p' (with index 'parent_i') of 'c', do the
     following:

     a. Compute the diff between 'c' and 'p'.
     b. Pass any active paths that are TREESAME from 'c' to 'p'.
     c. If 'p' has any active paths, push it onto the queue.

  3. Associate any remaining paths with 'c', and mark them as inactive.

This ends up being equivalent to doing something like 'git log -1 --
$path' for each path simultaneously. But, it allows us to go much faster
than the original implementation by limiting the number of diffs we
compute, since we can avoid parts of history that would have been
considered by the revision walk in the original implementation, but are
known to be uninteresting to us because we have already marked all paths
in that area to be inactive.

One other trick we can do on top is to avoid computing many first-parent
diffs when all paths active in 'c' are DEFINITELY_NOT in c's Bloom
filter. Since the commit-graph only stores first-parent diffs in the
Bloom filters, we can only apply this trick to first-parent diffs.

Now, some performance numbers. On github/git, our numbers look like the
following (all wall-clock times best-of-five, and with '--max-depth=0'
on the root):

                 github		ttaylorr/blame-tree-fast
   with filters: 0.754s		0.271s (2.78x faster, 6.18x overall)
without filters: 1.676s		1.056s (1.58x faster)

and on torvalds/linux:

                 github		ttaylorr/blame-tree-fast
   with filters: 0.608		0.062 (9.81x faster, ~52x overall)
without filters: 3.251		0.676 (4.81x faster)

In short, the existing implementation is comparably fast *with* filters
as the new implementation is *without* filters. So, most repositories
should get a dramatic speed-up by just deploying this (even without
computing Bloom filters), and all repositories should get faster still
when computing Bloom filters.

Co-authored-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Toon Claes <toon@iotcl.com>
---
 blame-tree.c | 270 +++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 blame-tree.h |   3 +
 2 files changed, 256 insertions(+), 17 deletions(-)

diff --git a/blame-tree.c b/blame-tree.c
index 47354557a7..2cb7a5045c 100644
--- a/blame-tree.c
+++ b/blame-tree.c
@@ -3,18 +3,20 @@
 #include "commit.h"
 #include "diffcore.h"
 #include "diff.h"
-#include "object.h"
 #include "revision.h"
 #include "repository.h"
 #include "log-tree.h"
 #include "dir.h"
 #include "commit-graph.h"
 #include "bloom.h"
+#include "prio-queue.h"
+#include "commit-slab.h"
 
 struct blame_tree_entry {
 	struct hashmap_entry hashent;
 	struct object_id oid;
 	struct commit *commit;
+	int diff_idx;
 	struct bloom_key key;
 	const char path[FLEX_ARRAY];
 };
@@ -86,6 +88,9 @@ void blame_tree_init(struct blame_tree *bt,
 		     const char *prefix,
 		     int argc, const char **argv)
 {
+	struct hashmap_iter iter;
+	struct blame_tree_entry *e;
+
 	memset(bt, 0, sizeof(*bt));
 	hashmap_init(&bt->paths, blame_tree_entry_hashcmp, NULL, 0);
 
@@ -104,6 +109,13 @@ void blame_tree_init(struct blame_tree *bt,
 
 	if (add_from_revs(bt) < 0)
 		die(_("unable to setup blame-tree"));
+
+	bt->all_paths = xcalloc(hashmap_get_size(&bt->paths), sizeof(const char *));
+	bt->all_paths_nr = 0;
+	hashmap_for_each_entry(&bt->paths, &iter, e, hashent) {
+		e->diff_idx = bt->all_paths_nr++;
+		bt->all_paths[e->diff_idx] = e->path;
+	}
 }
 
 void blame_tree_release(struct blame_tree *bt)
@@ -116,6 +128,20 @@ void blame_tree_release(struct blame_tree *bt)
 	}
 	hashmap_clear_and_free(&bt->paths, struct blame_tree_entry, hashent);
 	release_revisions(&bt->rev);
+	free(bt->all_paths);
+}
+
+struct commit_active_paths {
+	char *active;
+	int nr;
+};
+
+define_commit_slab(active_paths, struct commit_active_paths);
+static struct active_paths active_paths;
+
+static void free_one_active_path(struct commit_active_paths *active)
+{
+	free(active->active);
 }
 
 struct blame_tree_callback_data {
@@ -130,6 +156,7 @@ static void mark_path(const char *path, const struct object_id *oid,
 		      struct blame_tree_callback_data *data)
 {
 	struct blame_tree_entry *ent;
+	struct commit_active_paths *active;
 
 	/* Is it even a path that we are interested in? */
 	ent = hashmap_get_entry_from_hash(data->paths, strhash(path), path,
@@ -141,11 +168,17 @@ static void mark_path(const char *path, const struct object_id *oid,
 	if (ent->commit)
 		return;
 
+	/* Are we inactive on the current commit? */
+	active = active_paths_at(&active_paths, data->commit);
+	if (active && active->active &&
+	    !active->active[ent->diff_idx])
+		return;
+
 	/*
 	 * Is it arriving at a version of interest, or is it from a side branch
 	 * which did not contribute to the final state?
 	 */
-	if (!oideq(oid, &ent->oid))
+	if (oid && !oideq(oid, &ent->oid))
 		return;
 
 	ent->commit = data->commit;
@@ -197,7 +230,32 @@ static void blame_diff(struct diff_queue_struct *q,
 	}
 }
 
-static int maybe_changed_path(struct blame_tree *bt, struct commit *origin)
+static char *scratch;
+
+static void pass_to_parent(struct commit_active_paths *c,
+			   struct commit_active_paths *p,
+			   int i)
+{
+	c->active[i] = 0;
+	c->nr--;
+	p->active[i] = 1;
+	p->nr++;
+}
+
+#define PARENT1 (1u<<16) /* used instead of SEEN */
+#define PARENT2 (1u<<17) /* used instead of BOTTOM, BOUNDARY */
+
+static int diff2idx(struct blame_tree *bt, char *path)
+{
+	struct blame_tree_entry *ent;
+	ent = hashmap_get_entry_from_hash(&bt->paths, strhash(path), path,
+					  struct blame_tree_entry, hashent);
+	return ent ? ent->diff_idx : -1;
+}
+
+static int maybe_changed_path(struct blame_tree *bt,
+			      struct commit *origin,
+			      struct commit_active_paths *active)
 {
 	struct bloom_filter *filter;
 	struct blame_tree_entry *e;
@@ -214,6 +272,8 @@ static int maybe_changed_path(struct blame_tree *bt, struct commit *origin)
 		return 1;
 
 	hashmap_for_each_entry(&bt->paths, &iter, e, hashent) {
+		if (active && !active->active[e->diff_idx])
+			continue;
 		if (bloom_filter_contains(filter, &e->key,
 					  bt->rev.bloom_filter_settings))
 			return 1;
@@ -221,8 +281,88 @@ static int maybe_changed_path(struct blame_tree *bt, struct commit *origin)
 	return 0;
 }
 
+static int process_parent(struct blame_tree *bt,
+			   struct prio_queue *queue,
+			   struct commit *c, struct commit_active_paths *active_c,
+			   struct commit *parent, int parent_i)
+{
+	int i, ret = 0; // TODO type & for loop var
+	struct commit_active_paths *active_p;
+
+	repo_parse_commit(bt->rev.repo, parent);
+
+	active_p = active_paths_at(&active_paths, parent);
+	if (!active_p->active) {
+		active_p->active = xcalloc(sizeof(char), bt->all_paths_nr);
+		active_p->nr = 0;
+	}
+
+	/*
+	 * Before calling 'diff_tree_oid()' on our first parent, see if Bloom
+	 * filters will tell us the diff is conclusively uninteresting.
+	 */
+	if (parent_i || maybe_changed_path(bt, c, active_c)) {
+		diff_tree_oid(&parent->object.oid,
+			      &c->object.oid, "", &bt->rev.diffopt);
+		diffcore_std(&bt->rev.diffopt);
+	}
+
+	if (!diff_queued_diff.nr) {
+		/*
+		 * No diff entries means we are TREESAME on the base path, and
+		 * so all active paths get passed onto this parent.
+		 */
+		for (i = 0; i < bt->all_paths_nr; i++) {
+			if (active_c->active[i])
+				pass_to_parent(active_c, active_p, i);
+		}
+
+		if (!(parent->object.flags & PARENT1)) {
+			parent->object.flags |= PARENT1;
+			prio_queue_put(queue, parent);
+		}
+		ret = 1;
+		goto cleanup;
+	}
+
+	/*
+	 * Otherwise, test each path for TREESAME-ness against the parent, and
+	 * pass those along.
+	 *
+	 * First, set each position in 'scratch' to be zero for TREESAME paths,
+	 * and one otherwise. Then, pass active and TREESAME paths to the
+	 * parent.
+	 */
+	for (i = 0; i < diff_queued_diff.nr; i++) {
+		struct diff_filepair *fp = diff_queued_diff.queue[i];
+		int k = diff2idx(bt, fp->two->path);
+		if (0 <= k && active_c->active[k])
+			scratch[k] = 1;
+		diff_free_filepair(fp);
+	}
+	diff_queued_diff.nr = 0;
+	for (i = 0; i < bt->all_paths_nr; i++) {
+		if (active_c->active[i] && !scratch[i])
+			pass_to_parent(active_c, active_p, i);
+	}
+
+	if (active_p->nr && !(parent->object.flags & PARENT1)) {
+		parent->object.flags |= PARENT1;
+		prio_queue_put(queue, parent);
+	}
+
+cleanup:
+	diff_queue_clear(&diff_queued_diff);
+	memset(scratch, 0, bt->all_paths_nr);
+
+	return ret;
+}
+
 int blame_tree_run(struct blame_tree *bt, blame_tree_callback cb, void *cbdata)
 {
+	int max_count, queue_popped = 0;
+	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
+	struct prio_queue not_queue = { compare_commits_by_gen_then_commit_date };
 	struct blame_tree_callback_data data;
 
 	data.paths = &bt->paths;
@@ -233,25 +373,121 @@ int blame_tree_run(struct blame_tree *bt, blame_tree_callback cb, void *cbdata)
 	bt->rev.diffopt.format_callback = blame_diff;
 	bt->rev.diffopt.format_callback_data = &data;
 
-	prepare_revision_walk(&bt->rev);
+	max_count = bt->rev.max_count;
 
-	while (hashmap_get_size(&bt->paths)) {
-		data.commit = get_revision(&bt->rev);
-		if (!data.commit)
-			break;
+	init_active_paths(&active_paths);
+	scratch = xcalloc(bt->all_paths_nr, sizeof(char));
 
-		if (!maybe_changed_path(bt, data.commit))
-			continue;
+	/*
+	 * bt->rev.pending holds the set of boundary commits for our walk.
+	 *
+	 * Loop through each such commit, and place it in the appropriate queue.
+	 */
+	for (size_t i = 0; i < bt->rev.pending.nr; i++) {
+		struct commit *c = lookup_commit(bt->rev.repo,
+						 &bt->rev.pending.objects[i].item->oid);
+		repo_parse_commit(bt->rev.repo, c);
 
-		if (data.commit->object.flags & BOUNDARY) {
-			diff_tree_oid(bt->rev.repo->hash_algo->empty_tree,
-				       &data.commit->object.oid,
-				       "", &bt->rev.diffopt);
-			diff_flush(&bt->rev.diffopt);
-		} else {
-			log_tree_commit(&bt->rev, data.commit);
+		if (c->object.flags & BOTTOM) {
+			prio_queue_put(&not_queue, c);
+			c->object.flags |= PARENT2;
+		} else if (!(c->object.flags & PARENT1)) {
+			/*
+			 * If the commit is a starting point (and hasn't been
+			 * seen yet), then initialize the set of interesting
+			 * paths, too.
+			 */
+			struct commit_active_paths *active;
+
+			prio_queue_put(&queue, c);
+			c->object.flags |= PARENT1;
+
+			active = active_paths_at(&active_paths, c);
+			active->active = xcalloc(sizeof(char), bt->all_paths_nr);
+			memset(active->active, 1, bt->all_paths_nr);
+			active->nr = bt->all_paths_nr;
 		}
 	}
 
+	/*
+	 * Now that we have processed the pending commits, allow the revision
+	 * machinery to flush them by calling prepare_revision_walk().
+	 */
+	prepare_revision_walk(&bt->rev);
+
+	while (queue.nr) {
+		int parent_i;
+		struct commit_list *p;
+		struct commit *c = prio_queue_get(&queue);
+		struct commit_active_paths *active_c = active_paths_at(&active_paths, c);
+
+		if ((0 <= max_count && max_count < ++queue_popped) ||
+		    (c->object.flags & PARENT2)) {
+			/*
+			 * Either a boundary commit, or we have already seen too
+			 * many others. Either way, stop here.
+			 */
+			c->object.flags |= PARENT2 | BOUNDARY;
+			data.commit = c;
+			diff_tree_oid(bt->rev.repo->hash_algo->empty_tree,
+				      &c->object.oid,
+				      "", &bt->rev.diffopt);
+			diff_flush(&bt->rev.diffopt);
+			goto cleanup;
+		}
+
+		/*
+		 * Otherwise, keep going, but make sure that 'c' isn't reachable
+		 * from anything in the '--not' queue.
+		 */
+		repo_parse_commit(bt->rev.repo, c);
+
+		while (not_queue.nr) {
+			struct commit_list *np;
+			struct commit *n = prio_queue_get(&not_queue);
+
+			repo_parse_commit(bt->rev.repo, n);
+
+			for (np = n->parents; np; np = np->next) {
+				if (!(np->item->object.flags & PARENT2)) {
+					prio_queue_put(&not_queue, np->item);
+					np->item->object.flags |= PARENT2;
+				}
+			}
+
+			if (commit_graph_generation(n) < commit_graph_generation(c))
+				break;
+		}
+
+		/*
+		 * Look at each remaining interesting path, and pass it onto
+		 * parents in order if TREESAME.
+		 */
+		for (p = c->parents, parent_i = 0; p; p = p->next, parent_i++) {
+			if (process_parent(bt, &queue,
+					   c, active_c,
+					   p->item, parent_i) > 0 )
+				break;
+		}
+
+		if (active_c->nr)  {
+			/* Any paths that remain active were changed by 'c'. */
+			data.commit = c;
+			for (int i = 0; i < bt->all_paths_nr; i++) {
+				if (active_c->active[i])
+					mark_path(bt->all_paths[i], NULL, &data);
+			}
+		}
+
+cleanup:
+		FREE_AND_NULL(active_c->active);
+		active_c->nr = 0;
+	}
+
+	clear_prio_queue(&not_queue);
+	clear_prio_queue(&queue);
+	deep_clear_active_paths(&active_paths, free_one_active_path);
+	free(scratch);
+
 	return 0;
 }
diff --git a/blame-tree.h b/blame-tree.h
index abb467cf1b..0e6a6929f6 100644
--- a/blame-tree.h
+++ b/blame-tree.h
@@ -8,6 +8,9 @@
 struct blame_tree {
 	struct hashmap paths;
 	struct rev_info rev;
+
+	const char **all_paths;
+	int all_paths_nr;
 };
 
 void blame_tree_init(struct blame_tree *bt,

-- 
2.49.0.rc2

