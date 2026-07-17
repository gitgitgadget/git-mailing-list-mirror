Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB01636A35E
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 15:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303232; cv=none; b=ZCNxky/BcI2j2gC1oydeFcsHQOohBfncPsw23pIjZjIN1PIDQ/bGU0LVLCfWa3RkW8CspOHJb5XF+LBAKmadIUBU2QPoZsw47frz7U2M/RlBu9RrMwfwhBJwyLXmcRv51t/b5RTzC81KLsNkpt/LDyPt0ibFyuLIeNVqlzJVDCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303232; c=relaxed/simple;
	bh=b+bjbsnbc+AFaPj/7g+AbZmMv+taL59N50vW0Gq8ISE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GH6B1f5kVusK83I4APu0BF0kaNQVZ+wa7Iervq3XO4s0HNvcQbQAJ/0sfqqeYwK9J7h3EVtnJ80EbRJwWN1ejStTXn0DUSnqrPpbxwGQQmoXQIFEGH6yDI/VfLgWvYt1JwxEkCJLwmyYLWW5qk8+j2v4AW/Vy3jp0NByVKpTDZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=S15r+Luk; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="S15r+Luk"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1784303226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DT54apKhbjpeBaUZwx6GSdmrdT+PGbgpqcI6WEmfLhM=;
	b=S15r+Lukhn9P3jAtFfzUcEiSe1wofs/hpMFxLNSp+4FoEBIGMEr3lZ+ZzyjVuw41HHRTM0
	r7aqeytnM6pjO9gzE01FflkBzirvneMAbiML079Pw3Lg7uBKAkbl8YBFAYLKaDZNj2EvHT
	jxFnmq2ptzMb4pZKr4JMcke/aVY5/k8=
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH 0/4] last-modified: use the pathspec's Bloom key to
 pre-filter commits
Date: Fri, 17 Jul 2026 17:46:58 +0200
Message-Id: <20260717-toon-speed-up-last-modified-v1-0-410418f18614@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBA0auUWTuQiaWKVxEXaTPREU1CJi1C6
 d0bdfn+4q+gXIQVLt0KhRdRSbGBDh1MDxfvjOKbwRo7mBMNWFOKqJnZ45zx5bTiO3kJ0sJoenY
 ULJ2PBO2QCwf5/O7X2986j0+e6ncJ27YDwM9SYX8AAAA=
X-Change-ID: 20260716-toon-speed-up-last-modified-b04ea1f21831
To: git@vger.kernel.org
Cc: Gusted <gusted@codeberg.org>, Jeff King <peff@peff.net>, 
 Toon Claes <toon@iotcl.com>
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

 - Patch 1 moves a condition around so it becomes deduplicated and
   eventually can be reused by git-last-modified(1).
 - Patch 2 exposes a helper from revision.c publicly. The function is
   split out so the Bloom filter wouldn't be looked up twice from
   git-last-modified(1).
 - Patch 3 uses this new helper in git-last-modified(1).
 - Patch 4 is bonus change, which optimizes when working with wildcard
   pathspecs.

Below are benchmark on the ziglang/zig repository for the `doc/langref/`
directory (with commit-graphs writting using `--changed-paths`):

    Benchmark 1: master last-modified
      Time (mean ± σ):      52.6 ms ±   4.0 ms    [User: 49.2 ms, System: 3.0 ms]
      Range (min … max):    48.2 ms …  73.8 ms    62 runs

    Benchmark 2: HEAD last-modified
      Time (mean ± σ):      14.3 ms ±   1.8 ms    [User: 12.0 ms, System: 2.1 ms]
      Range (min … max):    10.5 ms …  18.9 ms    182 runs

    Benchmark 3: git log
      Time (mean ± σ):      17.4 ms ±   1.4 ms    [User: 13.5 ms, System: 3.7 ms]
      Range (min … max):    15.0 ms …  26.1 ms    185 runs

    Summary
      HEAD last-modified ran
        1.22 ± 0.18 times faster than git log
        3.66 ± 0.55 times faster than master last-modified

Similar timings are seen across a few other repositories (like GitLab's
monolith gitlab-org/gitlab)

[1]: https://lore.kernel.org/git/17f356ff-7bfb-47f5-b714-62a95cc8b821@codeberg.org/
[2]: https://codeberg.org/ziglang/zig

---
Toon Claes (4):
      revision: move bloom keyvec precondition into function
      revision: expose check for paths maybe changed in Bloom filter
      last-modified: check pathspec against Bloom filter first
      last-modified: keep per-path Bloom filters for wildcard pathspecs

 builtin/last-modified.c | 11 +++++++++++
 revision.c              | 32 +++++++++++++++++++++++---------
 revision.h              | 17 +++++++++++++++++
 3 files changed, 51 insertions(+), 9 deletions(-)



---
base-commit: 55526a18268bbc1ddaf8a6b7850c33d984eac9e9
change-id: 20260716-toon-speed-up-last-modified-b04ea1f21831

