Received: from mta1.migadu.com (out-103.mta1.migadu.com [95.215.58.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED40476CC2
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 09:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788254974; cv=none; b=pwDoTH5L4geKMljozhRRcTQL7KIi927CTegYjWFIyqllzmP6KXYmUdDKzafFWD32OsqjXTW57n8/FaiT+souXA474e80gKmJo6jV7LtoZTIrVGf1LplNnb8kAMmofpxsa99iKl2lM84s2R34ZO6Dt1dAN82b07QpFM4NBoFaojc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788254974; c=relaxed/simple;
	bh=NEzdcAFdosHEj9j0q4RN19WhH1Od6VMVBGL1SgZycD4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=nVZJh/eKgII7GgpSOG05wzKZAbzWi8hE/JZgT0yOR1Wj8Y3a5xdL9GqFvJf58bsELqEIqtSVf3acsN9CUuTy1m5qvp/lDPqUcgn5Ix4XNlP900ZxhMxJjfHIp4rrdeudlJDnDYaDfMK3Tvk7woNx77XsLH9v3EiIOUdZOSOgxcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=cHsBuDYX; arc=none smtp.client-ip=95.215.58.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="cHsBuDYX"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NEzdcAFdosHEj9j0q4RN19WhH1Od6VMVBGL1SgZycD4=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788254967; v=1; x=1788859767;
 b=cHsBuDYX0mIe1ta10z1/VxLuB/sqLNaeh3XVjnLQU/urp/AI7FqJEuAGmGfTRtJiVYdEc91g
 YypjQpuC4acFv2rISIO4h9TgiOcMbEDbbxzZnRDy72Mhlp3QMijVUCzfOwvMPtmofGXSn0icSgw
 RQ2i7IB17+3M/qh3pF2f+xnw=
X-Envelope-To: git@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id b62ad75e9f65c7fb;
	Tue, 01 Sep 2026 09:29:27 +0000
X-Mizu-Trace-ID: b62ad75e9f65c7fb
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH v4 0/6] last-modified: use the pathspec's Bloom key to
 pre-filter commits
Date: Tue, 01 Sep 2026 11:10:20 +0200
Message-Id: <20260901-toon-speed-up-last-modified-v4-0-a09949800404@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNzarCMBCG4VuRrI1kktBGV96HnEV+JjqiTWliO
 QfpvZ9UEcWFLr9heN4ryzgQZrZZXNmAI2VKXR16uWD+YLs9cgp1MylkI1poeEmp47lHDPzS85P
 NhZ9ToEj14IRGC1GCUcCq0A8Y6fem737uO1/cEX2ZyfnjQLmk4e+WH2H+e5Taj6URuOAahAYTw
 TSgt5SKP618OrO5NMqnZcQXS1arDaZ1LqCNa/duqRdLwWdLVUs650yjrY9r9WpN0/QPjQ6bXnA
 BAAA=
X-Change-ID: 20260716-toon-speed-up-last-modified-b04ea1f21831
In-Reply-To: <20260831-toon-speed-up-last-modified-v3-0-2bbb864acf93@iotcl.com>
References: <20260831-toon-speed-up-last-modified-v3-0-2bbb864acf93@iotcl.com>
To: git@vger.kernel.org
Cc: Gusted <gusted@codeberg.org>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
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
Changes in v4:
- Override GIT_TEST_COMMIT_GRAPH when passing `-c core.commitGraph=` in
  t8020 tests.
- Link to v3: https://patch.msgid.link/20260831-toon-speed-up-last-modified-v3-0-2bbb864acf93@iotcl.com

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
 t/t8020-last-modified.sh | 49 +++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 160 insertions(+), 12 deletions(-)

Range-diff versus v3:

1:  645c5d1ddf = 1:  dbb1ad8e96 revision: move bloom keyvec precondition into function
2:  3fa70e300d = 2:  6f0d62fe6c revision: expose check for paths maybe changed in Bloom filter
3:  d30e3fea71 = 3:  1c09e9ecba bloom: add helper to check if any key in a vector is present
4:  7b5cc70022 = 4:  7c7792e057 revision: add Bloom check that includes parent directories
5:  5cb67a54b1 ! 5:  ac5a6bd427 last-modified: check pathspec against Bloom filter first
    @@ t/t8020-last-modified.sh: test_expect_success 'last-modified merge undoes change
     +		test_commit touch-b d/b &&
     +
     +		git commit-graph write --reachable --changed-paths &&
    -+		git -c core.commitGraph=false last-modified -t HEAD -- d/a \
    -+			>expect &&
    -+		git -c core.commitGraph=true last-modified -t HEAD -- d/a \
    -+			>actual &&
    ++		GIT_TEST_COMMIT_GRAPH=0 \
    ++			git -c core.commitGraph=false last-modified -t HEAD \
    ++			-- d/a >expect &&
    ++		GIT_TEST_COMMIT_GRAPH=1 \
    ++			git -c core.commitGraph=true last-modified -t HEAD \
    ++			-- d/a >actual &&
     +
     +		test_cmp expect actual
     +	)
6:  c94f744a0f ! 6:  3524a202e7 last-modified: keep per-path Bloom filters for wildcard pathspecs
    @@ t/t8020-last-modified.sh: test_expect_success 'last-modified with Bloom filters
     +		test_commit sub-c d/b.c &&
     +
     +		git commit-graph write --reachable --changed-paths &&
    -+		GIT_TRACE2_PERF="$(pwd)/off.perf" \
    ++		GIT_TEST_COMMIT_GRAPH=0 GIT_TRACE2_PERF="$(pwd)/off.perf" \
     +			git -c core.commitGraph=false last-modified -r HEAD \
     +			-- "*.c" >expect &&
     +		test_grep "data .* bloom_queries:0$" off.perf &&
     +
    -+		GIT_TRACE2_PERF="$(pwd)/on.perf" \
    ++		GIT_TEST_COMMIT_GRAPH=1 GIT_TRACE2_PERF="$(pwd)/on.perf" \
     +			git -c core.commitGraph=true last-modified -r HEAD \
     +			-- "*.c" >actual &&
     +		test_grep "data .* bloom_queries:2$" on.perf &&


---
base-commit: c73e85354c275c9d409b26445089bc16940fc527
change-id: 20260716-toon-speed-up-last-modified-b04ea1f21831

