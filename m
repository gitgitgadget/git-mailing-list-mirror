Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B86D223DFC
	for <git@vger.kernel.org>; Fri, 23 May 2025 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747992865; cv=none; b=ppwWHMDT/7WYr2ASagC6t8Kx9ODPaR5lfYw6bafxs3DYU4MFMtquHoAGPvrYd6AAPNVNrvV32DqD5B76Q7XI2Al/5EttaAskt7MY1oEFVYJs1DiiQHuiT0C/M1Dsz1o3pvZOWvnJE0ef42AjQiJZHJZdZza7bKEFNzj+wTaTPmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747992865; c=relaxed/simple;
	bh=O//SVCG7W1qSV1AQsfMfi5x35JQcHfc1YPMSD/pGERQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=diTWX/5xuNVD+zYUXHN5dhcGBykW93xFysq07vU4w65Xm1LnCvaBdZPTFQYIfyYWMMWP1bcZmX5TPnlr+QdMpuzB4PoZ22EtsL1cn1xnounGCkapat4mG0pkWPPMgeHfXG3b3tb6drEwA5w2CTXyEJ56RS1uZnQ6vUlFKsYXfGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=JtftzYTJ; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="JtftzYTJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1747992860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jh021RkITlAcPmlgHT+CDQOVsRjw8xaeBW3b2yxvvlQ=;
	b=JtftzYTJehb+bx31pAEQVUfcn3gbYzujQ+1nXqKVZMWBznFAPaBOD3t4fLgsSTRNQ9VW5U
	Dx0D+cucvdjCkyeg/EEFD/Zgj7hvulYdM7iCyM/NYs66kVj5P+IIGExpEsRJk8X0mZPxMw
	KBhgH3ZrpaZ4BnpbCp+r2DkumxITql8=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 23 May 2025 11:33:51 +0200
Subject: [PATCH RFC v2 4/5] last-modified: implement faster algorithm
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250523-toon-new-blame-tree-v2-4-101e4ca4c1c9@iotcl.com>
References: <20250523-toon-new-blame-tree-v2-0-101e4ca4c1c9@iotcl.com>
In-Reply-To: <20250523-toon-new-blame-tree-v2-0-101e4ca4c1c9@iotcl.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, 
 Derrick Stolee <stolee@gmail.com>, Toon Claes <toon@iotcl.com>, 
 =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>, 
 Derrick Stolee <stolee@gmail.com>
X-Migadu-Flow: FLOW_OUT

The current implementation of 'git last-modified' works by doing a
revision walk, and inspecting the diff at each level of that walk to
annotate the to-be-found entries to a path. In other words, if the diff
at some level touches a path which has not yet been associated with a
commit, then that commit becomes associated with the path.

While a perfectly reasonable implementation, it can perform poorly in
either one of two scenarios:

  1. There are many entries of interest, in which case there is simply
     more work to do.

  2. Or, there are (even a few) entries which have not been updated in a
     long time, and so we must walk through a lot of history in order to
     find a commit that touches that path.

This patch rewrites the last-modified implementation that addresses (2).
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
 last-modified.c | 270 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 last-modified.h |   3 +
 2 files changed, 256 insertions(+), 17 deletions(-)

diff --git a/last-modified.c b/last-modified.c
index f628434929..0a0818cdf1 100644
--- a/last-modified.c
+++ b/last-modified.c
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
 
 struct last_modified_entry {
 	struct hashmap_entry hashent;
 	struct object_id oid;
 	struct commit *commit;
+	int diff_idx;
 	struct bloom_key key;
 	const char path[FLEX_ARRAY];
 };
@@ -86,6 +88,9 @@ void last_modified_init(struct last_modified *lm,
 		     const char *prefix,
 		     int argc, const char **argv)
 {
+	struct hashmap_iter iter;
+	struct last_modified_entry *ent;
+
 	memset(lm, 0, sizeof(*lm));
 	hashmap_init(&lm->paths, last_modified_entry_hashcmp, NULL, 0);
 
@@ -104,6 +109,13 @@ void last_modified_init(struct last_modified *lm,
 
 	if (add_from_revs(lm) < 0)
 		die(_("unable to setup last-modified"));
+
+	lm->all_paths = xcalloc(hashmap_get_size(&lm->paths), sizeof(const char *));
+	lm->all_paths_nr = 0;
+	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent) {
+		ent->diff_idx = lm->all_paths_nr++;
+		lm->all_paths[ent->diff_idx] = ent->path;
+	}
 }
 
 void last_modified_release(struct last_modified *lm)
@@ -116,6 +128,20 @@ void last_modified_release(struct last_modified *lm)
 	}
 	hashmap_clear_and_free(&lm->paths, struct last_modified_entry, hashent);
 	release_revisions(&lm->rev);
+	free(lm->all_paths);
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
 
 struct last_modified_callback_data {
@@ -130,6 +156,7 @@ static void mark_path(const char *path, const struct object_id *oid,
 		      struct last_modified_callback_data *data)
 {
 	struct last_modified_entry *ent;
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
@@ -197,7 +230,32 @@ static void last_modified_diff(struct diff_queue_struct *q,
 	}
 }
 
-static int maybe_changed_path(struct last_modified *lm, struct commit *origin)
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
+static int diff2idx(struct last_modified *lm, char *path)
+{
+	struct last_modified_entry *ent;
+	ent = hashmap_get_entry_from_hash(&lm->paths, strhash(path), path,
+					  struct last_modified_entry, hashent);
+	return ent ? ent->diff_idx : -1;
+}
+
+static int maybe_changed_path(struct last_modified *lm,
+			      struct commit *origin,
+			      struct commit_active_paths *active)
 {
 	struct bloom_filter *filter;
 	struct last_modified_entry *ent;
@@ -214,6 +272,8 @@ static int maybe_changed_path(struct last_modified *lm, struct commit *origin)
 		return 1;
 
 	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent) {
+		if (active && !active->active[ent->diff_idx])
+			continue;
 		if (bloom_filter_contains(filter, &ent->key,
 					  lm->rev.bloom_filter_settings))
 			return 1;
@@ -221,8 +281,88 @@ static int maybe_changed_path(struct last_modified *lm, struct commit *origin)
 	return 0;
 }
 
+static int process_parent(struct last_modified *lm, struct prio_queue *queue,
+			  struct commit *c,
+			  struct commit_active_paths *active_c,
+			  struct commit *parent, int parent_i)
+{
+	int i, ret = 0; // TODO type & for loop var
+	struct commit_active_paths *active_p;
+
+	repo_parse_commit(lm->rev.repo, parent);
+
+	active_p = active_paths_at(&active_paths, parent);
+	if (!active_p->active) {
+		active_p->active = xcalloc(sizeof(char), lm->all_paths_nr);
+		active_p->nr = 0;
+	}
+
+	/*
+	 * Before calling 'diff_tree_oid()' on our first parent, see if Bloom
+	 * filters will tell us the diff is conclusively uninteresting.
+	 */
+	if (parent_i || maybe_changed_path(lm, c, active_c)) {
+		diff_tree_oid(&parent->object.oid,
+			      &c->object.oid, "", &lm->rev.diffopt);
+		diffcore_std(&lm->rev.diffopt);
+	}
+
+	if (!diff_queued_diff.nr) {
+		/*
+		 * No diff entries means we are TREESAME on the base path, and
+		 * so all active paths get passed onto this parent.
+		 */
+		for (i = 0; i < lm->all_paths_nr; i++) {
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
+		int k = diff2idx(lm, fp->two->path);
+		if (0 <= k && active_c->active[k])
+			scratch[k] = 1;
+		diff_free_filepair(fp);
+	}
+	diff_queued_diff.nr = 0;
+	for (i = 0; i < lm->all_paths_nr; i++) {
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
+	memset(scratch, 0, lm->all_paths_nr);
+
+	return ret;
+}
+
 int last_modified_run(struct last_modified *lm, last_modified_callback cb, void *cbdata)
 {
+	int max_count, queue_popped = 0;
+	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
+	struct prio_queue not_queue = { compare_commits_by_gen_then_commit_date };
 	struct last_modified_callback_data data;
 
 	data.paths = &lm->paths;
@@ -233,25 +373,121 @@ int last_modified_run(struct last_modified *lm, last_modified_callback cb, void
 	lm->rev.diffopt.format_callback = last_modified_diff;
 	lm->rev.diffopt.format_callback_data = &data;
 
-	prepare_revision_walk(&lm->rev);
+	max_count = lm->rev.max_count;
 
-	while (hashmap_get_size(&lm->paths)) {
-		data.commit = get_revision(&lm->rev);
-		if (!data.commit)
-			break;
+	init_active_paths(&active_paths);
+	scratch = xcalloc(lm->all_paths_nr, sizeof(char));
 
-		if (!maybe_changed_path(lm, data.commit))
-			continue;
+	/*
+	 * lm->rev.pending holds the set of boundary commits for our walk.
+	 *
+	 * Loop through each such commit, and place it in the appropriate queue.
+	 */
+	for (size_t i = 0; i < lm->rev.pending.nr; i++) {
+		struct commit *c = lookup_commit(lm->rev.repo,
+						 &lm->rev.pending.objects[i].item->oid);
+		repo_parse_commit(lm->rev.repo, c);
 
-		if (data.commit->object.flags & BOUNDARY) {
-			diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
-				       &data.commit->object.oid,
-				       "", &lm->rev.diffopt);
-			diff_flush(&lm->rev.diffopt);
-		} else {
-			log_tree_commit(&lm->rev, data.commit);
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
+			active->active = xcalloc(sizeof(char), lm->all_paths_nr);
+			memset(active->active, 1, lm->all_paths_nr);
+			active->nr = lm->all_paths_nr;
 		}
 	}
 
+	/*
+	 * Now that we have processed the pending commits, allow the revision
+	 * machinery to flush them by calling prepare_revision_walk().
+	 */
+	prepare_revision_walk(&lm->rev);
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
+			diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
+				      &c->object.oid,
+				      "", &lm->rev.diffopt);
+			diff_flush(&lm->rev.diffopt);
+			goto cleanup;
+		}
+
+		/*
+		 * Otherwise, keep going, but make sure that 'c' isn't reachable
+		 * from anything in the '--not' queue.
+		 */
+		repo_parse_commit(lm->rev.repo, c);
+
+		while (not_queue.nr) {
+			struct commit_list *np;
+			struct commit *n = prio_queue_get(&not_queue);
+
+			repo_parse_commit(lm->rev.repo, n);
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
+			if (process_parent(lm, &queue,
+					   c, active_c,
+					   p->item, parent_i) > 0 )
+				break;
+		}
+
+		if (active_c->nr)  {
+			/* Any paths that remain active were changed by 'c'. */
+			data.commit = c;
+			for (int i = 0; i < lm->all_paths_nr; i++) {
+				if (active_c->active[i])
+					mark_path(lm->all_paths[i], NULL, &data);
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
diff --git a/last-modified.h b/last-modified.h
index 42a819d979..8b2d896aaa 100644
--- a/last-modified.h
+++ b/last-modified.h
@@ -8,6 +8,9 @@
 struct last_modified {
 	struct hashmap paths;
 	struct rev_info rev;
+
+	const char **all_paths;
+	int all_paths_nr;
 };
 
 void last_modified_init(struct last_modified *lm,

-- 
2.49.0

