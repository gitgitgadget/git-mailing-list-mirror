Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB172DCC05
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 07:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761205859; cv=none; b=fGpYXeYy1Kyxe6HGSt6Tsc9VbRI/pwMnQOn2990wR9f8RB46vOKJo9vy2I1sT0GLrVxGzChLsme1PDwf8VQydT+1KZ1dKWUQ6AlMCkdRTjdoQv4dJbMI9pVgPqjRR7wmA3/dFmTO7o28Vh/4WXvG376xSpRvvAG3+2Tv3XcHwKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761205859; c=relaxed/simple;
	bh=h64uZmGBedOurkk7axoSMt/X/WZZU2S1T/s4FaRjSJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=hbw3Whf1bGE75Md3rGrGbKMsJRfz82DGw7CgyJMRzmMfCBymnkpOGwBDUA7KFcUv9bfwAfarW3AdyGlyq9jYGTMaGKumGrfxwVyn43o6PXGDAFqmyF9JbwZQh2742RJFJDQZK/PA37i1Ywe7Rv2sH2lY4tMYLUgkyUdVFMC30yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=qtcSb75k; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="qtcSb75k"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1761205851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dz+ExzMKxOvb71pSb+l13ODPuciyohTqeZ/8ighLh/A=;
	b=qtcSb75kTbegFJ6XccwTcmS1wlnLsdgBXUt3TzwePFGpbSmn7Elnzuj80OUxHfV9ora3F6
	Rf4N2RrzhLeC0NOfs9mPp8iUXyV8I2mWM6AWArs7/Bu9OW1Cyibma4NP4y0OTGyVNpgYsX
	KiWUtjHuCVr5KqvWPnmYSNERdXenxcg=
From: Toon Claes <toon@iotcl.com>
Date: Thu, 23 Oct 2025 09:50:14 +0200
Subject: [PATCH v3] last-modified: implement faster algorithm
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251023-b4-toon-last-modified-faster-v3-1-40a4ddbbadec@iotcl.com>
X-B4-Tracking: v=1; b=H4sIADXe+WgC/4XNsQ7CIBSF4VcxzF5TsJDWyfcwDvQC9iZtMUCIp
 um7SxsHXXT8z/CdmUUbyEZ22s0s2EyR/FTiuN8x7PV0s0CmNBOVkLyqWuhqSN5PMOiYYPSGHFk
 DrpQNUGPTSqVbKRRnhbgH6+ix8Zdr6Z5i8uG5vWW+rm+Yq99w5sChkQZ1o0VrJZ7JJxwO6Ee2w
 ll8YIL/wUTBnDLYoVAOv7FlWV5vzqCcFQEAAA==
X-Change-ID: 20251009-b4-toon-last-modified-faster-4c8956a95261
In-Reply-To: <20251021-b4-toon-last-modified-faster-v2-1-f6dcbc26fc5c@iotcl.com>
References: <20251021-b4-toon-last-modified-faster-v2-1-f6dcbc26fc5c@iotcl.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 "D. Ben Knoble" <ben.knoble@gmail.com>, Derrick Stolee <stolee@gmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

The current implementation of git-last-modified(1) works by doing a
revision walk, and inspecting the diff at each level of that walk to
annotate entries remaining in the hashmap of paths. In other words, if
the diff at some level touches a path which has not yet been associated
with a commit, then that commit becomes associated with the path.

While a perfectly reasonable implementation, it can perform poorly in
either one of two scenarios:

  1. There are many entries of interest, in which case there is simply
     a lot of work to do.

  2. Or, there are (even a few) entries which have not been updated in a
     long time, and so we must walk through a lot of history in order to
     find a commit that touches that path.

This patch rewrites the last-modified implementation that addresses the
second point. The idea behind the algorithm is to propagate a set of
'active' paths (a path is 'active' if it does not yet belong to a
commit) up to parents and do a truncated revision walk.

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

  3. Any path that remains active on 'c' is associated to that commit.

This ends up being equivalent to doing something like 'git log -1 --
$path' for each path simultaneously. But, it allows us to go much faster
than the original implementation by limiting the number of diffs we
compute, since we can avoid parts of history that would have been
considered by the revision walk in the original implementation, but are
known to be uninteresting to us because we have already marked all paths
in that area to be inactive.

To avoid computing many first-parent diffs, add another trick on top of
this and check if all paths active in 'c' are DEFINITELY NOT in c's
Bloom filter. Since the commit-graph only stores first-parent diffs in
the Bloom filters, we can only apply this trick to first-parent diffs.

Comparing the performance of this new algorithm shows about a 2.5x
improvement on git.git:

    Benchmark 1: master   no bloom
      Time (mean ± σ):      2.868 s ±  0.023 s    [User: 2.811 s, System: 0.051 s]
      Range (min … max):    2.847 s …  2.926 s    10 runs

    Benchmark 2: master with bloom
      Time (mean ± σ):     949.9 ms ±  15.2 ms    [User: 907.6 ms, System: 39.5 ms]
      Range (min … max):   933.3 ms … 971.2 ms    10 runs

    Benchmark 3: HEAD     no bloom
      Time (mean ± σ):     782.0 ms ±   6.3 ms    [User: 740.7 ms, System: 39.2 ms]
      Range (min … max):   776.4 ms … 798.2 ms    10 runs

    Benchmark 4: HEAD   with bloom
      Time (mean ± σ):     307.1 ms ±   1.7 ms    [User: 276.4 ms, System: 29.9 ms]
      Range (min … max):   303.7 ms … 309.5 ms    10 runs

    Summary
      HEAD   with bloom ran
        2.55 ± 0.02 times faster than HEAD     no bloom
        3.09 ± 0.05 times faster than master with bloom
        9.34 ± 0.09 times faster than master   no bloom

In short, the existing implementation is comparably fast *with* Bloom
filters as the new implementation is *without* Bloom filters. So, most
repositories should get a dramatic speed-up by just deploying this (even
without computing Bloom filters), and all repositories should get faster
still when computing Bloom filters.

When comparing a more extreme example of
`git last-modified -- COPYING t`, the difference is even 5 times better:

    Benchmark 1: master
      Time (mean ± σ):      4.372 s ±  0.057 s    [User: 4.286 s, System: 0.062 s]
      Range (min … max):    4.308 s …  4.509 s    10 runs

    Benchmark 2: HEAD
      Time (mean ± σ):     826.3 ms ±  22.3 ms    [User: 784.1 ms, System: 39.2 ms]
      Range (min … max):   810.6 ms … 881.2 ms    10 runs

    Summary
      HEAD ran
        5.29 ± 0.16 times faster than master

As an added benefit, results are more consistent now. For example
implementation in 'master' gives:

    $ git log --max-count=1 --format=%H -- pkt-line.h
    15df15fe07ef66b51302bb77e393f3c5502629de

    $ git last-modified -- pkt-line.h
    15df15fe07ef66b51302bb77e393f3c5502629de	pkt-line.h

    $ git last-modified | grep pkt-line.h
    5b49c1af03e600c286f63d9d9c9fb01403230b9f	pkt-line.h

With the changes in this patch the results of git-last-modified(1)
always match those of `git log --max-count=1`.

One thing to note though, the results might be outputted in a different
order than before. This is not considerd to be an issue because nowhere
is documented the order is guaranteed.

Based-on-patches-by: Derrick Stolee <stolee@gmail.com>
Based-on-patches-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Toon Claes <toon@iotcl.com>
---
The subcommand git-last-modified(1) was based on the patches shared by
Taylor and the folks at GitHub[1]. That version used an alternative
implementation to make it "go faster". When I was working on upstreaming
those patches, I dropped the patches[2] for this implementation, because
I didn't see significant improvements.

This series revives those changes. I did more thorough deep dive through
the code and the algorithm and got the code working a lot faster. The
benchmark results can be found in the commit message.

Some changes compared to GitHub's version include:

 * Use of `struct bitmap` from "ewah/ewok.h", instead of self-defined
   `struct commit_active_paths`.

 * Removed shortcut code that handled the case when commit and parent
   are fully treesame, and instead always checked 'active_c' whether the
   next parent is worth looking at.

 * Modified comments and commit message to make the algorithm more
   clear (at least to me).

 * Mentioned the use of PARENT1 and PARENT2 in object.h.

 * Removed the use of any global variables.

 * Less conditions are checked in mark_path() because the hashmap of
   'paths' is considered the single-source of truth.

 * pass_to_parent() doesn't pass on when the path isn't in the 'paths'
   hashmap no more.

[1]: https://lore.kernel.org/git/Z+XJ+1L3PnC9Dyba@nand.local/
[2]: https://lore.kernel.org/git/20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com/
---
Changes in v3:
- Make code cleanly compile with -Wsign-compare
- Remove path_idx() and instead inline the code in the loop. This fixes
  the sign comparison issue and the function was only used in one place
  anyway.
- Make all the memory leaks go away.
- Small tweaks in naming and code comments.
- Link to v2: https://lore.kernel.org/r/20251021-b4-toon-last-modified-faster-v2-1-f6dcbc26fc5c@iotcl.com

Changes in v2:
- Add benchmark results comparing repositories with and without Bloom
  filters in commit message.
- Add Stolee and Taylor in the commit message trailers.
- Fix segfault by checking if 'oid' is set in mark_path().
- Remove hashmap lookup in pass_to_parent().
- Remove manually calling diff_free_filepair().
- Rename commit slab bitmap to "active_paths_bitmap".
- Link to v1: https://lore.kernel.org/r/20251016-b4-toon-last-modified-faster-v1-1-85dca8a29e5c@iotcl.com

Range-diff against v2:

1:  e131d0df85 ! 1:  8b1a5cc055 last-modified: implement faster algorithm
    @@ builtin/last-modified.c: static int last_modified_entry_hashcmp(const void *unus
      }

     +/*
    -+ * Hold a bitmap for each commit we're working with. Each bit represents a path
    -+ * in `lm->all_paths`. Active bit means the path still needs to be dealt with.
    ++ * Hold a bitmap for each commit we're working with. In the bitmap, each bit
    ++ * represents a path in `lm->all_paths`. An active bit indicates the path still
    ++ * needs to be associated to a commit.
     + */
    -+define_commit_slab(commit_bitmaps, struct bitmap *);
    ++define_commit_slab(active_paths_for_commit, struct bitmap *);
     +
      struct last_modified {
      	struct hashmap paths;
    @@ builtin/last-modified.c: static int last_modified_entry_hashcmp(const void *unus
     +
     +	const char **all_paths;
     +	size_t all_paths_nr;
    -+	struct commit_bitmaps active_paths_bitmap;
    ++	struct active_paths_for_commit active_paths;
     +
    -+	/* 'scratch' bitmap to avoid allocating every proccess_parent() */
    ++	/* 'scratch' to avoid allocating a bitmap every process_parent() */
     +	struct bitmap *scratch;
      };

    -+static struct bitmap *get_bitmap(struct last_modified *lm, struct commit *c)
    ++static struct bitmap *active_paths_for(struct last_modified *lm, struct commit *c)
     +{
    -+	struct bitmap **bitmap = commit_bitmaps_at(&lm->active_paths_bitmap, c);
    ++	struct bitmap **bitmap = active_paths_for_commit_at(&lm->active_paths, c);
     +	if (!*bitmap)
    -+		*bitmap = bitmap_word_alloc(lm->all_paths_nr / BITS_IN_EWORD);
    ++		*bitmap = bitmap_word_alloc(lm->all_paths_nr / BITS_IN_EWORD + 1);
     +
     +	return *bitmap;
     +}
    ++
    ++static void active_paths_free(struct last_modified *lm, struct commit *c)
    ++{
    ++	struct bitmap **bitmap = active_paths_for_commit_at(&lm->active_paths, c);
    ++	if (*bitmap) {
    ++		bitmap_free(*bitmap);
    ++		*bitmap = NULL;
    ++	}
    ++}
     +
      static void last_modified_release(struct last_modified *lm)
      {
    @@ builtin/last-modified.c: static void last_modified_diff(struct diff_queue_struct
      }

     -static bool maybe_changed_path(struct last_modified *lm, struct commit *origin)
    -+static size_t path_idx(struct last_modified *lm, char *path)
    -+{
    -+	struct last_modified_entry *ent;
    -+	ent = hashmap_get_entry_from_hash(&lm->paths, strhash(path), path,
    -+					  struct last_modified_entry, hashent);
    -+
    -+	return ent ? ent->diff_idx : -1;
    -+}
    -+
    -+static void pass_to_parent(struct last_modified *lm,
    -+			   struct bitmap *c,
    ++static void pass_to_parent(struct bitmap *c,
     +			   struct bitmap *p,
     +			   size_t pos)
     +{
    @@ builtin/last-modified.c: static bool maybe_changed_path(struct last_modified *lm
     +			   struct commit *c, struct bitmap *active_c,
     +			   struct commit *parent, int parent_i)
     +{
    -+	size_t i;
     +	struct bitmap *active_p;
     +
     +	repo_parse_commit(lm->rev.repo, parent);
    -+	active_p = get_bitmap(lm, parent);
    ++	active_p = active_paths_for(lm, parent);
     +
     +	/*
     +	 * The first time entering this function for this commit (i.e. first parent)
    @@ builtin/last-modified.c: static bool maybe_changed_path(struct last_modified *lm
     +	 * First, collect all paths that are *not* TREESAME in 'scratch'.
     +	 * Then, pass paths that *are* TREESAME and active to the parent.
     +	 */
    -+	for (i = 0; i < diff_queued_diff.nr; i++) {
    ++	for (int i = 0; i < diff_queued_diff.nr; i++) {
     +		struct diff_filepair *fp = diff_queued_diff.queue[i];
    -+		size_t k = path_idx(lm, fp->two->path);
    -+		if (0 <= k && bitmap_get(active_c, k))
    -+			bitmap_set(lm->scratch, k);
    ++		const char *path = fp->two->path;
    ++		struct last_modified_entry *ent =
    ++			hashmap_get_entry_from_hash(&lm->paths, strhash(path), path,
    ++						    struct last_modified_entry, hashent);
    ++		if (ent) {
    ++			size_t k = ent->diff_idx;
    ++			if (bitmap_get(active_c, k))
    ++				bitmap_set(lm->scratch, k);
    ++		}
     +	}
    -+	for (i = 0; i < lm->all_paths_nr; i++) {
    ++	for (size_t i = 0; i < lm->all_paths_nr; i++) {
     +		if (bitmap_get(active_c, i) && !bitmap_get(lm->scratch, i))
    -+			pass_to_parent(lm, active_c, active_p, i);
    ++			pass_to_parent(active_c, active_p, i);
     +	}
     +
     +	/*
    @@ builtin/last-modified.c: static bool maybe_changed_path(struct last_modified *lm
     +		parent->object.flags |= PARENT1;
     +		prio_queue_put(queue, parent);
     +	}
    ++	if (!(parent->object.flags & PARENT1))
    ++		active_paths_free(lm, parent);
     +
     +	memset(lm->scratch->words, 0x0, lm->scratch->word_alloc);
     +	diff_queue_clear(&diff_queued_diff);
    @@ builtin/last-modified.c: static bool maybe_changed_path(struct last_modified *lm
     -			BUG("paths remaining beyond boundary in last-modified");
     +	max_count = lm->rev.max_count;
     +
    -+	init_commit_bitmaps(&lm->active_paths_bitmap);
    ++	init_active_paths_for_commit(&lm->active_paths);
     +	lm->scratch = bitmap_word_alloc(lm->all_paths_nr);
     +
     +	/*
    @@ builtin/last-modified.c: static bool maybe_changed_path(struct last_modified *lm
     +			prio_queue_put(&queue, c);
     +			c->object.flags |= PARENT1;
     +
    -+			active = get_bitmap(lm, c);
    ++			active = active_paths_for(lm, c);
     +			for (size_t i = 0; i < lm->all_paths_nr; i++)
     +				bitmap_set(active, i);
     +		}
    @@ builtin/last-modified.c: static bool maybe_changed_path(struct last_modified *lm
     +		int parent_i;
     +		struct commit_list *p;
     +		struct commit *c = prio_queue_get(&queue);
    -+		struct bitmap *active_c = get_bitmap(lm, c);
    ++		struct bitmap *active_c = active_paths_for(lm, c);
     +
     +		if ((0 <= max_count && max_count < ++queue_popped) ||
     +		    (c->object.flags & PARENT2)) {
    @@ builtin/last-modified.c: static bool maybe_changed_path(struct last_modified *lm

     -		log_tree_commit(&lm->rev, data.commit);
     +cleanup:
    -+		bitmap_free(active_c);
    ++		active_paths_free(lm, c);
      	}

     +	if (hashmap_get_size(&lm->paths))
    @@ builtin/last-modified.c: static bool maybe_changed_path(struct last_modified *lm
     +
     +	clear_prio_queue(&not_queue);
     +	clear_prio_queue(&queue);
    -+	clear_commit_bitmaps(&lm->active_paths_bitmap);
    ++	clear_active_paths_for_commit(&lm->active_paths);
     +	bitmap_free(lm->scratch);
     +
      	return 0;
---
 builtin/last-modified.c  | 250 ++++++++++++++++++++++++++++++++++++++++++++---
 object.h                 |   1 +
 t/t8020-last-modified.sh |   2 +-
 3 files changed, 237 insertions(+), 16 deletions(-)

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index ae8b36a2c3..c271d9585b 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -2,26 +2,32 @@
 #include "bloom.h"
 #include "builtin.h"
 #include "commit-graph.h"
+#include "commit-slab.h"
 #include "commit.h"
 #include "config.h"
-#include "environment.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "environment.h"
+#include "ewah/ewok.h"
 #include "hashmap.h"
 #include "hex.h"
-#include "log-tree.h"
 #include "object-name.h"
 #include "object.h"
 #include "parse-options.h"
+#include "prio-queue.h"
 #include "quote.h"
 #include "repository.h"
 #include "revision.h"
 
+/* Remember to update object flag allocation in object.h */
+#define PARENT1 (1u<<16) /* used instead of SEEN */
+#define PARENT2 (1u<<17) /* used instead of BOTTOM, BOUNDARY */
+
 struct last_modified_entry {
 	struct hashmap_entry hashent;
 	struct object_id oid;
 	struct bloom_key key;
+	size_t diff_idx;
 	const char path[FLEX_ARRAY];
 };
 
@@ -37,13 +43,45 @@ static int last_modified_entry_hashcmp(const void *unused UNUSED,
 	return strcmp(ent1->path, path ? path : ent2->path);
 }
 
+/*
+ * Hold a bitmap for each commit we're working with. In the bitmap, each bit
+ * represents a path in `lm->all_paths`. An active bit indicates the path still
+ * needs to be associated to a commit.
+ */
+define_commit_slab(active_paths_for_commit, struct bitmap *);
+
 struct last_modified {
 	struct hashmap paths;
 	struct rev_info rev;
 	bool recursive;
 	bool show_trees;
+
+	const char **all_paths;
+	size_t all_paths_nr;
+	struct active_paths_for_commit active_paths;
+
+	/* 'scratch' to avoid allocating a bitmap every process_parent() */
+	struct bitmap *scratch;
 };
 
+static struct bitmap *active_paths_for(struct last_modified *lm, struct commit *c)
+{
+	struct bitmap **bitmap = active_paths_for_commit_at(&lm->active_paths, c);
+	if (!*bitmap)
+		*bitmap = bitmap_word_alloc(lm->all_paths_nr / BITS_IN_EWORD + 1);
+
+	return *bitmap;
+}
+
+static void active_paths_free(struct last_modified *lm, struct commit *c)
+{
+	struct bitmap **bitmap = active_paths_for_commit_at(&lm->active_paths, c);
+	if (*bitmap) {
+		bitmap_free(*bitmap);
+		*bitmap = NULL;
+	}
+}
+
 static void last_modified_release(struct last_modified *lm)
 {
 	struct hashmap_iter iter;
@@ -54,6 +92,8 @@ static void last_modified_release(struct last_modified *lm)
 
 	hashmap_clear_and_free(&lm->paths, struct last_modified_entry, hashent);
 	release_revisions(&lm->rev);
+
+	free(lm->all_paths);
 }
 
 struct last_modified_callback_data {
@@ -146,7 +186,7 @@ static void mark_path(const char *path, const struct object_id *oid,
 	 * Is it arriving at a version of interest, or is it from a side branch
 	 * which did not contribute to the final state?
 	 */
-	if (!oideq(oid, &ent->oid))
+	if (oid && !oideq(oid, &ent->oid))
 		return;
 
 	last_modified_emit(data->lm, path, data->commit);
@@ -196,7 +236,17 @@ static void last_modified_diff(struct diff_queue_struct *q,
 	}
 }
 
-static bool maybe_changed_path(struct last_modified *lm, struct commit *origin)
+static void pass_to_parent(struct bitmap *c,
+			   struct bitmap *p,
+			   size_t pos)
+{
+	bitmap_unset(c, pos);
+	bitmap_set(p, pos);
+}
+
+static bool maybe_changed_path(struct last_modified *lm,
+			       struct commit *origin,
+			       struct bitmap *active)
 {
 	struct bloom_filter *filter;
 	struct last_modified_entry *ent;
@@ -213,6 +263,9 @@ static bool maybe_changed_path(struct last_modified *lm, struct commit *origin)
 		return true;
 
 	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent) {
+		if (active && !bitmap_get(active, ent->diff_idx))
+			continue;
+
 		if (bloom_filter_contains(filter, &ent->key,
 					  lm->rev.bloom_filter_settings))
 			return true;
@@ -220,42 +273,202 @@ static bool maybe_changed_path(struct last_modified *lm, struct commit *origin)
 	return false;
 }
 
+static void process_parent(struct last_modified *lm,
+			   struct prio_queue *queue,
+			   struct commit *c, struct bitmap *active_c,
+			   struct commit *parent, int parent_i)
+{
+	struct bitmap *active_p;
+
+	repo_parse_commit(lm->rev.repo, parent);
+	active_p = active_paths_for(lm, parent);
+
+	/*
+	 * The first time entering this function for this commit (i.e. first parent)
+	 * see if Bloom filters will tell us it's worth to do the diff.
+	 */
+	if (parent_i || maybe_changed_path(lm, c, active_c)) {
+		diff_tree_oid(&parent->object.oid,
+			      &c->object.oid, "", &lm->rev.diffopt);
+		diffcore_std(&lm->rev.diffopt);
+	}
+
+	/*
+	 * Test each path for TREESAME-ness against the parent. If a path is
+	 * TREESAME, pass it on to this parent.
+	 *
+	 * First, collect all paths that are *not* TREESAME in 'scratch'.
+	 * Then, pass paths that *are* TREESAME and active to the parent.
+	 */
+	for (int i = 0; i < diff_queued_diff.nr; i++) {
+		struct diff_filepair *fp = diff_queued_diff.queue[i];
+		const char *path = fp->two->path;
+		struct last_modified_entry *ent =
+			hashmap_get_entry_from_hash(&lm->paths, strhash(path), path,
+						    struct last_modified_entry, hashent);
+		if (ent) {
+			size_t k = ent->diff_idx;
+			if (bitmap_get(active_c, k))
+				bitmap_set(lm->scratch, k);
+		}
+	}
+	for (size_t i = 0; i < lm->all_paths_nr; i++) {
+		if (bitmap_get(active_c, i) && !bitmap_get(lm->scratch, i))
+			pass_to_parent(active_c, active_p, i);
+	}
+
+	/*
+	 * If parent has any active paths, put it on the queue (if not already).
+	 */
+	if (!bitmap_is_empty(active_p) && !(parent->object.flags & PARENT1)) {
+		parent->object.flags |= PARENT1;
+		prio_queue_put(queue, parent);
+	}
+	if (!(parent->object.flags & PARENT1))
+		active_paths_free(lm, parent);
+
+	memset(lm->scratch->words, 0x0, lm->scratch->word_alloc);
+	diff_queue_clear(&diff_queued_diff);
+}
+
 static int last_modified_run(struct last_modified *lm)
 {
+	int max_count, queue_popped = 0;
+	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
+	struct prio_queue not_queue = { compare_commits_by_gen_then_commit_date };
+	struct commit_list *list;
 	struct last_modified_callback_data data = { .lm = lm };
 
 	lm->rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
 	lm->rev.diffopt.format_callback = last_modified_diff;
 	lm->rev.diffopt.format_callback_data = &data;
+	lm->rev.no_walk = 1;
 
 	prepare_revision_walk(&lm->rev);
 
-	while (hashmap_get_size(&lm->paths)) {
-		data.commit = get_revision(&lm->rev);
-		if (!data.commit)
-			BUG("paths remaining beyond boundary in last-modified");
+	max_count = lm->rev.max_count;
+
+	init_active_paths_for_commit(&lm->active_paths);
+	lm->scratch = bitmap_word_alloc(lm->all_paths_nr);
+
+	/*
+	 * lm->rev.commits holds the set of boundary commits for our walk.
+	 *
+	 * Loop through each such commit, and place it in the appropriate queue.
+	 */
+	for (list = lm->rev.commits; list; list = list->next) {
+		struct commit *c = list->item;
+
+		if (c->object.flags & BOTTOM) {
+			prio_queue_put(&not_queue, c);
+			c->object.flags |= PARENT2;
+		} else if (!(c->object.flags & PARENT1)) {
+			/*
+			 * If the commit is a starting point (and hasn't been
+			 * seen yet), then initialize the set of interesting
+			 * paths, too.
+			 */
+			struct bitmap *active;
+
+			prio_queue_put(&queue, c);
+			c->object.flags |= PARENT1;
+
+			active = active_paths_for(lm, c);
+			for (size_t i = 0; i < lm->all_paths_nr; i++)
+				bitmap_set(active, i);
+		}
+	}
 
-		if (data.commit->object.flags & BOUNDARY) {
+	while (queue.nr) {
+		int parent_i;
+		struct commit_list *p;
+		struct commit *c = prio_queue_get(&queue);
+		struct bitmap *active_c = active_paths_for(lm, c);
+
+		if ((0 <= max_count && max_count < ++queue_popped) ||
+		    (c->object.flags & PARENT2)) {
+			/*
+			 * Either a boundary commit, or we have already seen too
+			 * many others. Either way, stop here.
+			 */
+			c->object.flags |= PARENT2 | BOUNDARY;
+			data.commit = c;
 			diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
-				      &data.commit->object.oid, "",
-				      &lm->rev.diffopt);
+				      &c->object.oid,
+				      "", &lm->rev.diffopt);
 			diff_flush(&lm->rev.diffopt);
+			goto cleanup;
+		}
 
-			break;
+		/*
+		 * Otherwise, make sure that 'c' isn't reachable from anything
+		 * in the '--not' queue.
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
 		}
 
-		if (!maybe_changed_path(lm, data.commit))
-			continue;
+		/*
+		 * Look at each parent and pass on each path that's TREESAME
+		 * with that parent. Stop early when no active paths remain.
+		 */
+		for (p = c->parents, parent_i = 0; p; p = p->next, parent_i++) {
+			process_parent(lm, &queue,
+				       c, active_c,
+				       p->item, parent_i);
+
+			if (bitmap_is_empty(active_c))
+				break;
+		}
+
+		/*
+		 * Paths that remain active, or not TREESAME with any parent,
+		 * were changed by 'c'.
+		 */
+		if (!bitmap_is_empty(active_c))  {
+			data.commit = c;
+			for (size_t i = 0; i < lm->all_paths_nr; i++) {
+				if (bitmap_get(active_c, i))
+					mark_path(lm->all_paths[i], NULL, &data);
+			}
+		}
 
-		log_tree_commit(&lm->rev, data.commit);
+cleanup:
+		active_paths_free(lm, c);
 	}
 
+	if (hashmap_get_size(&lm->paths))
+		BUG("paths remaining beyond boundary in last-modified");
+
+	clear_prio_queue(&not_queue);
+	clear_prio_queue(&queue);
+	clear_active_paths_for_commit(&lm->active_paths);
+	bitmap_free(lm->scratch);
+
 	return 0;
 }
 
 static int last_modified_init(struct last_modified *lm, struct repository *r,
 			      const char *prefix, int argc, const char **argv)
 {
+	struct hashmap_iter iter;
+	struct last_modified_entry *ent;
+
 	hashmap_init(&lm->paths, last_modified_entry_hashcmp, NULL, 0);
 
 	repo_init_revisions(r, &lm->rev, prefix);
@@ -280,6 +493,13 @@ static int last_modified_init(struct last_modified *lm, struct repository *r,
 	if (populate_paths_from_revs(lm) < 0)
 		return error(_("unable to setup last-modified"));
 
+	lm->all_paths = xcalloc(hashmap_get_size(&lm->paths), sizeof(const char *));
+	lm->all_paths_nr = 0;
+	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent) {
+		ent->diff_idx = lm->all_paths_nr++;
+		lm->all_paths[ent->diff_idx] = ent->path;
+	}
+
 	return 0;
 }
 
diff --git a/object.h b/object.h
index 8c3c1c46e1..fa504a09c0 100644
--- a/object.h
+++ b/object.h
@@ -75,6 +75,7 @@ void object_array_init(struct object_array *array);
  * http-push.c:                          11-----14
  * commit-graph.c:                                15
  * commit-reach.c:                                  16-----19
+ * builtin/last-modified.c:                         1617
  * sha1-name.c:                                              20
  * list-objects-filter.c:                                      21
  * bloom.c:                                                    2122
diff --git a/t/t8020-last-modified.sh b/t/t8020-last-modified.sh
index 61f00bc15c..a4c1114ee2 100755
--- a/t/t8020-last-modified.sh
+++ b/t/t8020-last-modified.sh
@@ -57,9 +57,9 @@ test_expect_success 'last-modified recursive' '
 
 test_expect_success 'last-modified recursive with show-trees' '
 	check_last_modified -r -t <<-\EOF
-	3 a
 	3 a/b
 	3 a/b/file
+	3 a
 	2 a/file
 	1 file
 	EOF

---
base-commit: 133d151831d32bdcc02422599a3f26cef44f929b
change-id: 20251009-b4-toon-last-modified-faster-4c8956a95261

