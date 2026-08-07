Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448BE1A238F
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 18:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786127240; cv=none; b=BVCPkS7H5/adnnILylCFuVFHGzIo9soQwOBiGyMkGntc8SN5rXyzWwmibpfCSs9YVrwb+AQCYm4cGP53pjUxgc1JucjozsYIEAmpDdM42p9pXpQpb25ciFBP/SG0zxOLZQJfD8QptLCmAAtNTgRAhfOnRspfs3z4BuQ7gNAmQKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786127240; c=relaxed/simple;
	bh=26mhz4hnVxNTgE1myJ7J78OJ3ta/DBURZKmGQ9DoZiY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=ez9NV+u94tRjJeVi/TsfkLBaIRMRmtvNFLels8TvwrimyaLYsfXFQJ15qFWhPNDR0mGa+1CVmIt1qAqotRW8QZ6NWjamOgatl/HFubTFDyX4Xu2tcvIxeB+zh3x4xmhfbKOPRml6EzDEL/gnb+90dnzw/RH1s3nlfQdaHKI47J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=oz6eanvz; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="oz6eanvz"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1786127233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L07MlHrUFvNsjZnfyrIv2eo/9tymXUQ8xZ6Ha8EfKz4=;
	b=oz6eanvz/QF/I3Z7WAwA7wbmotzhCA9L9Wkp3xfhsn8FH5S7pJkv5Gg+qZl/pl+XujorVS
	+JzqNvwXMSiv52AwCN7RGdTPm3E9SaC6s/znFmem6COKoQ3q+YpARQpEiglTTHR6AG1GU0
	06ZC93CGCyWiNWokb2JbdkANm898vws=
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 0/6] last-modified: use the pathspec's Bloom key to
 pre-filter commits
Date: Fri, 07 Aug 2026 20:26:46 +0200
Message-Id: <20260807-toon-speed-up-last-modified-v2-0-7d87bbdeaf9b@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0K6dkynNkBceQ/DAspUxgAlbSEaw
 t0tGLcu38/Pe6sI5JmCuGar8LRwYDcmUKdMmK4eHwTcJhZKqlwWmEN0boQwEbUwT9DXIcLgWra
 chkZqqtEqLC8okmHyZPl12O/Vl8PcPMnEXbk/Og7R+feRX3D//UrF39KCIEGj1FhaLHPUN3bR9
 GfjBlFt2/YBE6FlaNgAAAA=
X-Change-ID: 20260716-toon-speed-up-last-modified-b04ea1f21831
In-Reply-To: <20260717-toon-speed-up-last-modified-v1-0-410418f18614@iotcl.com>
References: <20260717-toon-speed-up-last-modified-v1-0-410418f18614@iotcl.com>
To: git@vger.kernel.org
Cc: Gusted <gusted@codeberg.org>, Jeff King <peff@peff.net>, 
 Toon Claes <toon@iotcl.com>, Taylor Blau <me@ttaylorr.com>
X-Migadu-Flow: FLOW_OUT

We have received a report[1] git-last-modified(1) is slow compared to
git-log(1) if you want to find the last commit for all entries in a
directory. For example running the following command on ziglang/zig[2]:

   $ git last-modified -t --max-depth=0 $OID -- doc/langref/

Turns out to find results about 2.5 times slower than:

   $ git log --name-status -c --format=commit%x00%H %P%x00" \
       --parents --no-renames -t -z $OID -- :(literal)doc/langref

Now the latter needs some post-processing to come to the same results,
the total solution still is faster than integrating
git-last-modified(1).

After some research we've discovered the Bloom filters aren't used
optimally. But it turns out the code powering git-log(1) can fairly easy
be reused. We do this in a few steps:

 - Patch 1 & 2 prepare revision.[ch] to expose the helper to check if
   revs maybe changes in Bloom filter.
 - Patch 3 & 4 prepare a similar helper, but this one is needed when
   git-last-modified(1) is called with `--show-trees`.
 - Patch 5 uses these helpers in git-last-modified(1).
 - Patch 6 is a bonus change, which optimizes when working with wildcard
   pathspecs.

Below are benchmarks on the ziglang/zig repository for the
`doc/langref/` directory (with commit-graphs written using
`--changed-paths`):

    Benchmark 1: master: last-modified -z -t
      Time (mean ± σ):      61.9 ms ±   1.8 ms    [User: 57.1 ms, System: 4.0 ms]
      Range (min … max):    58.5 ms …  68.9 ms    150 runs

    Benchmark 2: HEAD: last-modified -z -t
      Time (mean ± σ):      31.8 ms ±   1.3 ms    [User: 27.1 ms, System: 4.2 ms]
      Range (min … max):    29.7 ms …  35.6 ms    150 runs

    Benchmark 3: git log -t
      Time (mean ± σ):      22.1 ms ±   1.2 ms    [User: 16.7 ms, System: 5.0 ms]
      Range (min … max):    20.1 ms …  26.6 ms    150 runs

    Summary
      git log -t ran
        1.44 ± 0.10 times faster than HEAD: last-modified -z -t
        2.80 ± 0.18 times faster than master: last-modified -z -t

Comparing HEAD to master, there is about 1.95x speedup on running `git
last-modified -z -t. `git log -t` is still slightly faster though.

But without `-t` the speedup is even bigger:

    Benchmark 1: master: last-modified -z
      Time (mean ± σ):      60.7 ms ±   4.5 ms    [User: 56.5 ms, System: 3.8 ms]
      Range (min … max):    57.5 ms …  96.2 ms    150 runs

    Benchmark 2: HEAD: last-modified -z
      Time (mean ± σ):      16.2 ms ±   1.4 ms    [User: 13.3 ms, System: 2.7 ms]
      Range (min … max):    13.9 ms …  20.4 ms    212 runs

    Benchmark 3: git log (no -t)
      Time (mean ± σ):      22.0 ms ±   3.7 ms    [User: 16.8 ms, System: 4.9 ms]
      Range (min … max):    18.7 ms …  37.6 ms    150 runs

    Summary
      HEAD: last-modified -z ran
        1.35 ± 0.25 times faster than git log (no -t)
        3.74 ± 0.42 times faster than master: last-modified -z

This makes sense because without `-t` we can use the Bloom filter more
optimally.

Similar timings are seen across a few other repositories (like GitLab's
monolith gitlab-org/gitlab).

[1]: https://lore.kernel.org/git/17f356ff-7bfb-47f5-b714-62a95cc8b821@codeberg.org/
[2]: https://codeberg.org/ziglang/zig

---
Changes in v2:
- Make the public helper revs_maybe_changed_in_bloom() return a bool
  instead of a tristate.
- Keep the bloom_keyvecs_nr precondition before get_bloom_filter() and
  return early from the key vector loop.
- Add commits 3 & 4 to add helper used with `--show-trees`.
- Use Bloom filter correctly with `--show-trees` and add test to prove.
- Rerun benchmarks to compare results with and without `--show-trees`.
- Link to v1: https://patch.msgid.link/20260717-toon-speed-up-last-modified-v1-0-410418f18614@iotcl.com

---
Toon Claes (6):
      revision: move bloom keyvec precondition into function
      revision: expose check for paths maybe changed in Bloom filter
      bloom: add helper to check if any key in a vector is present
      revision: add Bloom check that includes parent directories
      last-modified: check pathspec against Bloom filter first
      last-modified: keep per-path Bloom filters for wildcard pathspecs

 bloom.c                  | 12 +++++++++++
 bloom.h                  | 11 ++++++++++
 builtin/last-modified.c  | 20 +++++++++++++++++++
 revision.c               | 52 +++++++++++++++++++++++++++++++++++++-----------
 revision.h               | 20 +++++++++++++++++++
 t/t8020-last-modified.sh | 21 +++++++++++++++++++
 6 files changed, 124 insertions(+), 12 deletions(-)

Range-diff versus v1:

1:  dd152b3fd5 = 1:  961bf0c547 revision: move bloom keyvec precondition into function
2:  0e80ca2500 ! 2:  8d8eaea04f revision: expose check for paths maybe changed in Bloom filter
    @@ Commit message
         Expose the new function via revision.h so other builtins can reuse the
         exact same filtering that `git log <pathspec>` performs.
     
    +    The existing function check_maybe_different_in_bloom_filter() returns a
    +    tristate value. This returns either:
    +
    +     * `-1` : No Bloom filter was used.
    +     *  `0` : The commit definitely did not change any of the paths.
    +     *  `1` : The commit maybe changed one of the paths.
    +
    +    These return values are used to keep count of false-positives. But
    +    because the new function revs_maybe_changed_in_bloom() is not involved
    +    in counting statistics, it returns a boolean value telling whether the
    +    commit definitely did not change any of the paths, or maybe changed some
    +    of them.
    +
         Signed-off-by: Toon Claes <toon@iotcl.com>
     
      ## revision.c ##
    @@ revision.c: static int check_maybe_different_in_bloom_filter(struct rev_info *re
      {
      	struct bloom_filter *filter;
     -	int result = 0;
    --
    --	if (!revs->bloom_keyvecs_nr)
    --		return -1;
    -+	int result;
      
    - 	if (commit_graph_generation(commit) == GENERATION_NUMBER_INFINITY)
    + 	if (!revs->bloom_keyvecs_nr)
      		return -1;
    - 
    - 	filter = get_bloom_filter(revs->repo, commit);
    --
    - 	if (!filter) {
    - 		count_bloom_filter_not_present++;
    +@@ revision.c: static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
      		return -1;
      	}
      
    @@ revision.c: static int check_maybe_different_in_bloom_filter(struct rev_info *re
     -		result = bloom_filter_contains_vec(filter,
     -						   revs->bloom_keyvecs[nr],
     -						   revs->bloom_filter_settings);
    --	}
    -+	result = revs_maybe_changed_in_bloom(revs, filter);
    -+	if (result < 0)
    -+		return result;
    - 
    - 	if (result)
    - 		count_bloom_filter_maybe++;
    -@@ revision.c: static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
    - 	return result;
    - }
    ++	if (revs_maybe_changed_in_bloom(revs, filter)) {
    ++		count_bloom_filter_maybe++;
    ++		return 1;
    + 	}
      
    -+int revs_maybe_changed_in_bloom(struct rev_info *revs,
    -+				struct bloom_filter *filter)
    -+{
    -+	int result = 0;
    -+
    -+	if (!revs->bloom_keyvecs_nr)
    -+		return -1;
    -+
    -+	for (size_t nr = 0; !result && nr < revs->bloom_keyvecs_nr; nr++) {
    -+		result = bloom_filter_contains_vec(filter,
    -+						   revs->bloom_keyvecs[nr],
    -+						   revs->bloom_filter_settings);
    -+	}
    +-	if (result)
    +-		count_bloom_filter_maybe++;
    +-	else
    +-		count_bloom_filter_definitely_not++;
    ++	count_bloom_filter_definitely_not++;
     +
    -+	return result;
    ++	return 0;
     +}
     +
    ++bool revs_maybe_changed_in_bloom(struct rev_info *revs,
    ++				 struct bloom_filter *filter)
    ++{
    ++	if (!revs->bloom_keyvecs_nr || !filter)
    ++		return true;
    ++
    ++	for (size_t nr = 0; nr < revs->bloom_keyvecs_nr; nr++)
    ++		if (bloom_filter_contains_vec(filter,
    ++					      revs->bloom_keyvecs[nr],
    ++					      revs->bloom_filter_settings))
    ++			return true;
    + 
    +-	return result;
    ++	return false;
    + }
    + 
      static int rev_compare_tree(struct rev_info *revs,
    - 			    struct commit *parent, struct commit *commit, int nth_parent)
    - {
     
      ## revision.h ##
     @@ revision.h: struct string_list;
    @@ revision.h: void reset_revision_walk(void);
      int prepare_revision_walk(struct rev_info *revs);
      
     +/**
    -+ * Take in a changed-path Bloom filter that belongs to a commit, and consult it
    -+ * to see if it might have modified any of the paths in the `revs`.
    -+ * The caller should look up `filter`, probably with get_bloom_filter().
    ++ * Consult a changed-path Bloom filter to determine if the commit to which the
    ++ * filter belongs might have changed any of the paths in the `revs`.
     + * prepare_revision_walk() needs to be called in advance to ensure
     + * pathspec key vectors are set up.
     + *
    -+ * Returns -1 if no sensible answer could be given because of missing
    -+ * preconditions (no pathspec key vectors).
    -+ * Returns 0 if the commit definitely did not change any of the paths and 1 if
    -+ * the commit maybe has changed one of them, although that might be a
    -+ * false-positive.
    ++ * Returns false iff the commit definitely did not change any of the paths.
     + */
    -+int revs_maybe_changed_in_bloom(struct rev_info *revs,
    -+				struct bloom_filter *filter);
    ++bool revs_maybe_changed_in_bloom(struct rev_info *revs,
    ++				 struct bloom_filter *filter);
     +
      /* Drain the commits linked list into the priority queue. */
      void rev_info_commit_list_to_queue(struct rev_info *revs);
-:  ---------- > 3:  a2d2c47cd5 bloom: add helper to check if any key in a vector is present
-:  ---------- > 4:  b33ef3dfd1 revision: add Bloom check that includes parent directories
3:  378403d38d ! 5:  f1f194d66d last-modified: check pathspec against Bloom filter first
    @@ Commit message
         pre-filter, paths are still checked one-by-one to only find those which
         don't have a "last commit" yet.
     
    +    With `--show-trees` the list holds more than the paths matching the
    +    pathspec. It also holds each parent tree entry, up to the root. Each of
    +    those can resolve to a different commit. Thus for the pathspec "a/b/c",
    +    the list will also hold "a" and "a/b".
    +
    +    When a commit touches "a/other", that commit could be the last commit
    +    for "a", but revs_maybe_changed_in_bloom() would discard it, because it
    +    doesn't match the full pathspec.
    +
    +    Instead, when `--show-trees` is given, use
    +    revs_maybe_changed_in_bloom_with_parents(), which indicates the commit
    +    maybe changed any of the paths leading up to the path in the pathspec.
    +
         Signed-off-by: Toon Claes <toon@iotcl.com>
     
      ## builtin/last-modified.c ##
    @@ builtin/last-modified.c: static bool maybe_changed_path(struct last_modified *lm
      	if (!filter)
      		return true;
      
    -+	if (revs_maybe_changed_in_bloom(&lm->rev, filter) == 0)
    -+		return false;
    ++	/*
    ++	 * With --show-trees we also track the tree entries containing the
    ++	 * paths, so a change to any of those parent directories matters too.
    ++	 */
    ++	if (lm->show_trees) {
    ++		if (!revs_maybe_changed_in_bloom_with_parents(&lm->rev, filter))
    ++			return false;
    ++	} else {
    ++		if (!revs_maybe_changed_in_bloom(&lm->rev, filter))
    ++			return false;
    ++	}
     +
      	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent) {
      		if (active && !bitmap_get(active, ent->diff_idx))
      			continue;
    +
    + ## t/t8020-last-modified.sh ##
    +@@ t/t8020-last-modified.sh: test_expect_success 'last-modified merge undoes changes' '
    + 	EOF
    + '
    + 
    ++test_expect_success 'last-modified with Bloom filters and --show-trees' '
    ++	test_when_finished rm -rf bloom &&
    ++	git init bloom &&
    ++	(
    ++		cd bloom &&
    ++		mkdir d &&
    ++		test_commit base-a d/a &&
    ++		test_commit base-b d/b &&
    ++		test_commit touch-a d/a &&
    ++		test_commit touch-b d/b &&
    ++
    ++		git commit-graph write --reachable --changed-paths &&
    ++		git -c core.commitGraph=false last-modified -t HEAD -- d/a \
    ++			>expect &&
    ++		git -c core.commitGraph=true last-modified -t HEAD -- d/a \
    ++			>actual &&
    ++
    ++		test_cmp expect actual
    ++	)
    ++'
    ++
    + test_expect_success 'cannot run last-modified on two commits' '
    + 	test_must_fail git last-modified HEAD HEAD~1 2>err &&
    + 	test_grep "last-modified can only operate on one commit at a time" err
4:  24884916d4 = 6:  f313142134 last-modified: keep per-path Bloom filters for wildcard pathspecs


---
base-commit: 2c78326f810173a4f3aefd8021f1e07575412481
change-id: 20260716-toon-speed-up-last-modified-b04ea1f21831

