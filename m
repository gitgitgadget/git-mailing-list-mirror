Received: from mta0.migadu.com (out-40.mta0.migadu.com [91.218.175.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E45E46AED1
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 15:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788189554; cv=none; b=dzTBt2QZ7OkMd/vfrl+lfWxMazubtpFhSQ+8hfb+ueqpMSHivRzQLKPF1G6QdCMcMu641uBAtBbtfXrX5BMa/1bWpOhs46xQlAMYpsVvC33oGeU2bLC4Ko3STREcTQ5niY4gM1zvI6+an3rZYjVpmp7CXEesr7amtYYIecEdeEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788189554; c=relaxed/simple;
	bh=kAC6OaduteTM5+T3hb11ExqYAQcYSQcViJUd/lbTUv4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=Ba3T4OJgf2/AvdhASI74XBuAJ3gclY4oCU5ZACXdo6ZFNNIIPKPqeWIVfqmSuNqSOKf5ZVHXTm7zYSydBmMBrjCS2nl/QaXOyN8xErjRdsZ7eHz7891VtlgMCgNaIiDnd41QaIKw9C38oMpPrVy0xGzB9SFPkG3Ay3Eea6PxvIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=wh6f3RAm; arc=none smtp.client-ip=91.218.175.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="wh6f3RAm"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=kAC6OaduteTM5+T3hb11ExqYAQcYSQcViJUd/lbTUv4=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788189550; v=1; x=1788794350;
 b=wh6f3RAm0LCsWpVt/TB+hFrc471gcO8NVTJPHHG2DbeygpuwCEWMtYpXbDnvgkY09O5DLt0x
 X9ZeqyEIl7op5pWhAurKwrIdYmvd9GZYsWPm/2B0b7W4ZAz7ArtitlcpgvpllD/1ifBPyeYoh7K
 tzY1xlwBuvhcsu7GbcHe+LnE=
X-Envelope-To: git@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 9792888d96d42bbb;
	Mon, 31 Aug 2026 15:19:00 +0000
X-Mizu-Trace-ID: 9792888d96d42bbb
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH v3 0/6] last-modified: use the pathspec's Bloom key to
 pre-filter commits
Date: Mon, 31 Aug 2026 17:18:40 +0200
Message-Id: <20260831-toon-speed-up-last-modified-v3-0-2bbb864acf93@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNQQ6CMBCF4auQrq3pFALVlfcwLiidyhighBaiI
 dzdgjG60uWbTL5/Zh4HQs+OycwGnMiT6+JIdwmr6rK7IicTN5NC5qKAnAfnOu57RMPHnjelD7x
 1hizFgxYZlmAlqBRYFPoBLd03/Xx5bT/qG1ZhJdePmnxww2PLT7D+vUvFz9IEXPAMRAbKgsohO
 5ELVbOvXMvW0iQ/lhJ/LBmtwqhCa4OlPehva1mWJ/247o8kAQAA
X-Change-ID: 20260716-toon-speed-up-last-modified-b04ea1f21831
In-Reply-To: <20260807-toon-speed-up-last-modified-v2-0-7d87bbdeaf9b@iotcl.com>
References: <20260807-toon-speed-up-last-modified-v2-0-7d87bbdeaf9b@iotcl.com>
To: git@vger.kernel.org
Cc: Gusted <gusted@codeberg.org>, Jeff King <peff@peff.net>, 
 Toon Claes <toon@iotcl.com>, Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.16-dev-9febb

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
Changes in v3:
- Add trace2 "bloom_queries" and use it in test to verify top-level
  wildcard behavior.
- Link to v2: https://patch.msgid.link/20260807-toon-speed-up-last-modified-v2-0-7d87bbdeaf9b@iotcl.com

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
 builtin/last-modified.c  | 28 ++++++++++++++++++++++++++
 revision.c               | 52 +++++++++++++++++++++++++++++++++++++-----------
 revision.h               | 20 +++++++++++++++++++
 t/t8020-last-modified.sh | 47 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 158 insertions(+), 12 deletions(-)

Range-diff versus v2:

1:  a98bbaad50 = 1:  ac58e4a3cd revision: move bloom keyvec precondition into function
2:  ebf4f65fab = 2:  43375b505e revision: expose check for paths maybe changed in Bloom filter
3:  7a3c14fe87 = 3:  41e3a19fde bloom: add helper to check if any key in a vector is present
4:  145c95a2fa = 4:  a648612927 revision: add Bloom check that includes parent directories
5:  9dc5a0be79 = 5:  0e8721fe75 last-modified: check pathspec against Bloom filter first
6:  83036c2fe4 ! 6:  e7997e0a9b last-modified: keep per-path Bloom filters for wildcard pathspecs
    @@ Commit message
         Restore `bloom_filter_settings` after prepare_revision_walk() so the
         per-path check keeps working for wildcard pathspecs.
     
    +    This change isn't having any effect on the output, but only has an
    +    impact on performance. Add a "bloom_queries" trace2 counter that records
    +    how often the per-path Bloom check runs, and a test that asserts the
    +    count increments as appropriate for a top-level wildcard pathspec.
    +
         Signed-off-by: Toon Claes <toon@iotcl.com>
     
      ## builtin/last-modified.c ##
    +@@
    + #include "quote.h"
    + #include "repository.h"
    + #include "revision.h"
    ++#include "trace2.h"
    + 
    + /* Remember to update object flag allocation in object.h */
    + #define PARENT1 (1u<<16) /* used instead of SEEN */
    +@@ builtin/last-modified.c: struct last_modified {
    + 
    + 	/* 'scratch' to avoid allocating a bitmap every process_parent() */
    + 	struct bitmap *scratch;
    ++
    ++	unsigned int count_bloom_filter_queries;
    + };
    + 
    + static struct bitmap *active_paths_for(struct last_modified *lm, struct commit *c)
    +@@ builtin/last-modified.c: static bool maybe_changed_path(struct last_modified *lm,
    + 	if (!filter)
    + 		return true;
    + 
    ++	lm->count_bloom_filter_queries++;
    ++
    + 	/*
    + 	 * With --show-trees we also track the tree entries containing the
    + 	 * paths, so a change to any of those parent directories matters too.
     @@ builtin/last-modified.c: static int last_modified_run(struct last_modified *lm)
      
      	prepare_revision_walk(&lm->rev);
    @@ builtin/last-modified.c: static int last_modified_run(struct last_modified *lm)
      	max_count = lm->rev.max_count;
      
      	init_active_paths_for_commit(&lm->active_paths);
    +@@ builtin/last-modified.c: static int last_modified_run(struct last_modified *lm)
    + 	if (hashmap_get_size(&lm->paths))
    + 		BUG("paths remaining beyond boundary in last-modified");
    + 
    ++	trace2_data_intmax("last-modified", lm->rev.repo, "bloom_queries",
    ++			   lm->count_bloom_filter_queries);
    ++
    + 	clear_prio_queue(&not_queue);
    + 	clear_prio_queue(&queue);
    + 	clear_active_paths_for_commit(&lm->active_paths);
    +
    + ## t/t8020-last-modified.sh ##
    +@@ t/t8020-last-modified.sh: test_expect_success 'last-modified with Bloom filters and --show-trees' '
    + 	)
    + '
    + 
    ++test_expect_success 'last-modified with Bloom filters and top-level wildcard' '
    ++	test_when_finished rm -rf wildcard &&
    ++	git init wildcard &&
    ++	(
    ++		cd wildcard &&
    ++		test_commit base-c a.c &&
    ++		test_commit base-h a.h &&
    ++		test_commit touch-c a.c &&
    ++		mkdir d &&
    ++		test_commit sub-c d/b.c &&
    ++
    ++		git commit-graph write --reachable --changed-paths &&
    ++		GIT_TRACE2_PERF="$(pwd)/off.perf" \
    ++			git -c core.commitGraph=false last-modified -r HEAD \
    ++			-- "*.c" >expect &&
    ++		test_grep "data .* bloom_queries:0$" off.perf &&
    ++
    ++		GIT_TRACE2_PERF="$(pwd)/on.perf" \
    ++			git -c core.commitGraph=true last-modified -r HEAD \
    ++			-- "*.c" >actual &&
    ++		test_grep "data .* bloom_queries:2$" on.perf &&
    ++
    ++		test_cmp expect actual
    ++	)
    ++'
    ++
    + test_expect_success 'cannot run last-modified on two commits' '
    + 	test_must_fail git last-modified HEAD HEAD~1 2>err &&
    + 	test_grep "last-modified can only operate on one commit at a time" err


---
base-commit: c73e85354c275c9d409b26445089bc16940fc527
change-id: 20260716-toon-speed-up-last-modified-b04ea1f21831

