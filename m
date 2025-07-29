Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266981F4CB6
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 18:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753815493; cv=none; b=iqgyIx7fPmpuXqXVj+YcHV/bFm1MXYB5XVatJhVldQ56rRpRvqovB+uCYueF5jHhAazHHELmpiPS+2W/JUvGrq8RUqlWkgqUETDK+b0g4cHY0tQw9xbgYuWUtN1QCca57r8Rk5W/zkmKy1Nb1GNnM7Om//ytdXvYsL/1bC8lGxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753815493; c=relaxed/simple;
	bh=wk1+paiZ34fzvvM7SWbsQtbfS/7VLOgMjF0T4M9PnQA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=on3J5I90U9XwkZTZyePs1/IkMFUrgbSQ7ArSYRnLwBR84aN75PF3afodXyprKifaPjErrYUwE2BlRJmMdz43sBXXE5Mp3kPVWrulSQrd+Y06FjDiIEDeeJzoObSqLF7jZOEQo4rPosXsC25HGPzONlXE0EExOHn2jB+Sv5m7kgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=keMLnwEi; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="keMLnwEi"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1753815484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JlHj61ghDYzmx+E7ZrbMspOpQTH0tj6cd9gzVJ6AtYI=;
	b=keMLnwEiA7H5qtf9zeoS9fBgUDLpbZLeoSqS0O5W3It1mV4yqFMckjba2WLoJcTBPy/UTW
	NbW1ei9jYTRhq8gBjIjYTnIROpCQXXYIB7fswUCX5XlSgcP34UNaRd8GL5iVf9GW9IhCJA
	30GBVM2QBawyLBJB9P8yiWBAD/h3wKk=
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH 0/3] Teach git-diff-tree(1) option --max-depth
Date: Tue, 29 Jul 2025 20:57:41 +0200
Message-Id: <20250729-toon-max-depth-v1-0-c177e39c40fb@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKUZiWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcyMT3ZL8/Dzd3MQK3ZTUgpIMXSPTFONkQ8tUIzMDcyWgpoKi1LTMCrC
 B0bG1tQB56ozIYAAAAA==
X-Change-ID: 20250724-toon-max-depth-25d3c19e2607
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Justin Tobler <jltobler@gmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

Please consider these patches authored by Peff. They add option
`--max-depth` to the diff machinery.

During the process to upstream the git-blame-tree(1), later named
git-last-modified(1), various times[1][2][3] the topic was raised to add
option `--max-depth` to the diff machinery. In this patch series this
change is added as a separate patch series.

The patches were originally written by Peff[4] and I'm crediting him as
the author. I've taken the patches almost verbatim from his fork on
GitHub, with some minor tweaks in the commit messages. Because only tiny
changes were made, I've kept his Signed-off-by trailers, but I can
remove if disagreed on.

The goal of the option `--max-depth` is to stop recursively traversing
the tree if the given depth is reached from the pathspec.

These patches add `max_depth` and `max_depth_valid` to `struct
diff_options`. This is different from what git-grep(1) does, which uses
`max_depth` on `struct pathspec` instead. At the moment I'm on the fence
whether this is an issue: while it probably makes sense to consolidate
them into the same structs, it does not really make sense to reuse these
the struct fields if they are used in two separate code paths.

[1]: https://lore.kernel.org/git/20130318121243.GC14789@sigill.intra.peff.net/
[2]: https://lore.kernel.org/git/20160831054201.ldlwptlmcndjmfwu@sigill.intra.peff.net/
[3]: https://lore.kernel.org/git/Y+%2FmnnJUz75yfWCN@coredump.intra.peff.net/
[4]: https://github.com/peff/git/tree/jk/diff-max-depth

---
Jeff King (3):
      combine-diff: zero memory used for callback filepairs
      within_depth: fix return for empty path
      diff: teach tree-diff a max-depth parameter

 Documentation/diff-options.adoc |  28 +++++++++++
 combine-diff.c                  |   2 +-
 diff-lib.c                      |   5 ++
 diff.c                          |  19 +++++++
 diff.h                          |   9 ++++
 dir.c                           |   2 +-
 t/meson.build                   |   1 +
 t/t4072-diff-max-depth.sh       | 109 ++++++++++++++++++++++++++++++++++++++++
 tree-diff.c                     |  78 ++++++++++++++++++++++++++--
 9 files changed, 248 insertions(+), 5 deletions(-)
---



---

base-commit: e813a0200a7121b97fec535f0d0b460b0a33356c
change-id: 20250724-toon-max-depth-25d3c19e2607

Thanks
--
Toon

