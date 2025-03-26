Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491B0185955
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 20:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743020367; cv=none; b=GGBfyNUIlZ0zm8Pgno/71SCq/lQSp1z+O03TrliKsxU/809NVDePiP7sPjnvgSrtyqCp75huLh26UmrAUNHgmedrXzhPSHG9A9ktSbZ4g1X/CRc+5hyPXXWp8s2a4FccCs1XU6GW9p7UusGNpKouDrYRg0XDrlosvU5qGfepJWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743020367; c=relaxed/simple;
	bh=1neEB5aiJGUpaQsER0k7TSAG47NSVlEPjkVFZu7Dkqk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iCKg/63L1be4eBlxii6lGj45nWSsuib/FhlZ8l1i0pmSQ3EguBHdBWxvkWF1P+uuTH62C8Pj8LjC3v2I91dSdYZ9+c6qTuaDJbB2z4/313/aZ7ixfz8wtfcGaMLXD2EjO+bNmA43Ya+w2jFSFw3K+V/8BjVodLkFQTKvmMhm48Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=Wg3Qn5z1; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="Wg3Qn5z1"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1743020359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=70gOf1FMtKRmNac8cg+2uTPvr7WkbzRoj2NU0AzNKq4=;
	b=Wg3Qn5z1mHjveE4gOpfKAcc94+ddEI3MDAzayVcSVL5dNnVjC6W6S8o+w3kNrebznSeTOs
	PsyT23S5sPKlh+9ImP+/hegRswqCAdJs/lDxacV0CT72UI/R+ffKgW43/aRUzhkrIuz38M
	10fk3w7CeiPfZka3ypM4OP1ZTPjLaQc=
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH 0/8] Introduce git-blame-tree(1) command
Date: Wed, 26 Mar 2025 21:18:24 +0100
Message-Id: <20250326-toon-blame-tree-v1-0-4173133f3786@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABBh5GcC/x3MTQqAIBBA4avErBuw6UfoKtHCbKqB0tCIQLp70
 vJbvJcgchCO0BcJAt8SxbuMqizAbsatjDJnAylqVU0dXt47nHZzMF6BGcka3cxaV2Qs5OoMvMj
 zH4fxfT/g9kE/YQAAAA==
X-Change-ID: 20250326-toon-blame-tree-2ca74d7712ac
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>, 
 =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

This is yet another attempt to upstream the builtin command
`git-blame-tree(1)`. This command is similar to git-blame(1) and shows
the most recent modification to paths in a tree..

The last attempt (I'm aware of) was made by Ævar in 2023[1]. That
series was based of patches by Peff written in 2011[2].

In contrary to Ævar's attempt, my series implements the
`git-blame-tree(1)` standalone command. Ævar suggested to only implement
the blame-tree subsystem, and test it through test-tool. But since the
command line options of that test-tool subcommand were very similar to
the standalone command we want to land, I decided transfer the test-tool
subcommand into a real Git builtin. Also, nowadays if we want to test
the blame-tree subsystem independently, we should use clar unit tests
instead of test-tool.

This series brings back the --max-depth changes. I know Ævar removed
them because there was controversy, but I think they are relevant to
include. And I want to open up the conversation again.

Also extra patches from Peff are included to implement pathspec tries.
I've taken them from Peff's fork on GitHub[3], but they also have been
posted to this mailing list[4].

Other improvements I've made:

* Rebase onto current master.

* Remove the use of USE_THE_REPOSITORY_VARIABLE.

* Fix various memory leaks.

* Moved code from blame-tree.c to pathspec.c, as suggested in Peff's
  last patch on GitHub.

* Updated the benchmark results in the last commit message, although the
  numbers were roughly the same.

I don't expect this code to be deemed ready to merge, but I mainly want
to gather as much feedback as possible and use it to iterate toward
actually getting it merged.

There are some things I know that are missing, for example
`--porcelain`, but those can be added in a follow-up. At the moment
there's one test marked `test_expect_failure`, but I was not able yet
identify that bug.

So, let me know what you think?

--
Toon

[1]: https://lore.kernel.org/git/patch-1.1-0ea849d900b-20230205T204104Z-avarab@gmail.com/
[2]: https://lore.kernel.org/git/20110302164031.GA18233@sigill.intra.peff.net/
[3]: https://github.com/peff/git/tree/jk/faster-blame-tree-wip
[4]: https://lore.kernel.org/git/YN4zKVK7gvuIZ0vK@coredump.intra.peff.net/

---
Jeff King (7):
      combine-diff: zero memory used for callback filepairs
      within_depth: fix return for empty path
      diff: teach tree-diff a max-depth parameter
      pathspec: add optional trie index
      pathspec: turn on tries when appropriate
      tree-diff: use pathspec tries
      blame-tree: narrow pathspec as we traverse

Toon Claes (1):
      blame-tree: introduce new subcommand to blame files

 .gitignore                      |   1 +
 Documentation/diff-options.adoc |  26 +++++
 Makefile                        |   3 +
 blame-tree.c                    | 216 ++++++++++++++++++++++++++++++++++++++++
 blame-tree.h                    |  43 ++++++++
 builtin.h                       |   1 +
 builtin/blame-tree.c            |  67 +++++++++++++
 combine-diff.c                  |   2 +-
 diff-lib.c                      |   5 +
 diff.c                          |  18 ++++
 diff.h                          |   9 ++
 dir.c                           |   2 +-
 git.c                           |   1 +
 meson.build                     |   2 +
 pathspec.c                      | 216 ++++++++++++++++++++++++++++++++++++++++
 pathspec.h                      |  27 +++++
 t/helper/meson.build            |   1 +
 t/helper/test-pathspec.c        |  96 ++++++++++++++++++
 t/helper/test-tool.c            |   1 +
 t/helper/test-tool.h            |   2 +
 t/meson.build                   |   3 +
 t/perf/p4003-diff-pathspec.sh   |  26 +++++
 t/t4071-diff-max-depth.sh       | 109 ++++++++++++++++++++
 t/t6137-pathspec-trie.sh        |  57 +++++++++++
 t/t8020-blame-tree.sh           | 142 ++++++++++++++++++++++++++
 tree-diff.c                     | 176 +++++++++++++++++++++++++++++---
 26 files changed, 1235 insertions(+), 17 deletions(-)
---



---

base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
change-id: 20250326-toon-blame-tree-2ca74d7712ac

Thanks
--
Toon

