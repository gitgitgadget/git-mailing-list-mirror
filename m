Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD231ACED5
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 17:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745344013; cv=none; b=akVrNZBSqhSOg/27F5Ui8qre4X8kZBddUoXYYtPqQq7Eb0K9dLwltTig7682t42UwYJWyo5xnr4hoDsgdzw3xTGNH0tlqpUTZnPd/UTUQAUlrzTPH30AXR7sqOZ2EZn8mc6hj7N74NfMRxZePM+bh7BbuJfLmrTw7uRwqwllGZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745344013; c=relaxed/simple;
	bh=5Ixm8kCPrF6IVbasvQFdlzr0LxHvFuPJcbj5Du0fOtI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nvQH9zPqZCYdpgjPvWLzugGqKT0c2SxtUA+LtxQy0CpYzhO2G9buEoGXWEQnQXKeACCmP5jTIuNNXeolUQnwjWMBWS7QeCsetnb2mRaKMrwJRZEOzsh5sFcTST2Q1r8f8aa0pakPSjmqUlpy7jvWafnV8MJhUSmKnTVFvUnyEiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=mp10v7Bt; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="mp10v7Bt"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1745344006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dNeWD1/4kWdp+Vrbx9efF5MlewNClon5LAztbYGcJoA=;
	b=mp10v7BtfYMLrfCrXC1v7wBaJhJiDsor2n/W5bTu+1kFzfDk7VVE2zCyyLwNmEyxwwSHII
	kw70q+l3r29AIYtyNo1DtZMzbwxFvUrFZtgFlFIeJpl4UiSldNGFbwPQ8fGazAccj4WZyT
	NkYUykfDvzWqDzPp8xOb/WkoyPkVtJI=
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH RFC 0/5] Introduce git-blame-tree(1) command
Date: Tue, 22 Apr 2025 19:46:23 +0200
Message-Id: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPDVB2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDE0MD3ZL8/DzdvNRy3aScxNxU3ZKi1FTdpOSUpCRzi2TDZIM0JaDOgqL
 UtMwKsKnRSkFuzkqxtbUAHSFlSWoAAAA=
X-Change-ID: 20250410-toon-new-blame-tree-bcdbb78c1c0f
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, 
 Derrick Stolee <stolee@gmail.com>, Toon Claes <toon@iotcl.com>, 
 =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>, 
 Derrick Stolee <stolee@gmail.com>
X-Migadu-Flow: FLOW_OUT

This is another attempt to upstream the git-blame-tree(1) subcommand.
After the previous attempt[1] the people of GitHub shared their version
of the subcommand, and this version integrates those changes.

What is different from the series shared by GitHub:

* Patches for --max-depth are excluded. I think it's a separate topic to
  discuss and I'm not sure it needs to be part of blame-tree anyway. The
  main patch was submitted in the previous attempt[2] and if people
  consider it valuable, I'm happy to discuss that in a separate patch
  series.

* The patches in 'tb/blame-tree' at Taylor's fork[3] implements a
  caching layer. This feature reads/writes cached blame-tree results in
  `.git/blame-tree/<hash>.btc`. To keep this series to a reviewable
  size, that feature is excluded from this series. I think it's better
  to submit this as a separate series.

* Squashed various commits together. Like they introduced a flag
  `--go-faster`, which later became the default and only implementation.
  That story was wrapped up in a single commit.

* The blame-tree command isn't recursive by default. If you want recurse
  into subtrees, you need to pass `-r`.

* Fixed all memory leaks, and removed the use of
  USE_THE_REPOSITORY_VARIABLE.

I've attempted to reuse commit messages as good as possible, but feel
free to correct me where you think I didn't give proper credit or messed
up. Although I have no idea what to do with the Signed-off-by trailers.

I didn't modify the benchmark results in the commit messages, simply
because I didn't get comparable results. In my benchmarks the difference
between two implementations was negligible, and even in some scenarios
the performance was worse in the "improved" implementation. As far as I
can tell, I didn't break anything in my refactoring, because the version
in these patches acts similar to Taylor's branch. To be honest, I cannot
explain why...?

With this version I'd like to gather feedback as much as possible for a
next version. I realize this feature is far from done, so that's why I'm
submitting it as an RFC.

Again thanks to Taylor and the people at GitHub for sharing these
patches. I hope we can work together to get this upstreamed.

[1]: https://lore.kernel.org/git/20250326-toon-blame-tree-v1-0-4173133f3786@iotcl.com/
[2]: https://lore.kernel.org/git/20250326-toon-blame-tree-v1-3-4173133f3786@iotcl.com/
[3]: git@github.com:ttaylorr/git.git

--
Toon

Signed-off-by: Toon Claes <toon@iotcl.com>
---
Jeff King (1):
      t/perf: add blame-tree perf script

Taylor Blau (2):
      blame-tree: use Bloom filters when available
      blame-tree: implement faster algorithm

Toon Claes (2):
      blame-tree: introduce new subcommand to blame files
      blame-tree.c: initialize revision machinery without walk

 .gitignore                 |   1 +
 Makefile                   |   2 +
 blame-tree.c               | 496 +++++++++++++++++++++++++++++++++++++++++++++
 blame-tree.h               |  30 +++
 builtin.h                  |   1 +
 builtin/blame-tree.c       |  43 ++++
 git.c                      |   1 +
 meson.build                |   2 +
 t/helper/test-tool.h       |   1 +
 t/meson.build              |   1 +
 t/perf/p8020-blame-tree.sh |  21 ++
 t/t8020-blame-tree.sh      | 148 ++++++++++++++
 12 files changed, 747 insertions(+)
---



---

base-commit: 4bbb303af69990ccd05fe3a2eb58a1ce036f8220
change-id: 20250410-toon-new-blame-tree-bcdbb78c1c0f

Thanks
--
Toon

