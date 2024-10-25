Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA9517B4E2
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 22:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895375; cv=none; b=g0GVasgPZkKocmQwOoA2VSS/rNou0GhIg346QHUm63ThM+YWSc0FuWRCUwHTHNQG8FBtFkIUYUY+GiDPzc0CuBOP/3Vkb1JEn+jzbFv+MhXLEUFKwzmXvFr8tYLoXP9bqAxMW36sDmvCvaI3Dt9+jdRhfQeA5g5IN48Nq+57kcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895375; c=relaxed/simple;
	bh=i98utkEdyfHHi8awf3YKKttONmmAOBj94gnTuEuCwVo=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=b3ogwldrWpXdq57WrV6YQb35/97nL26Pf0R5I2mSiCS5CujsH4X6cDEWEwmE15A267jj6WmeqOB+jygsjUuYGexjpg9Gzn8wEYvLCOFoHVq2HNJCJGKXHrR6n96c7zOa0mGNxWoinTbgq1qZxFyycoEC+8D2oRyNOCtwTr/iPZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=FAKfP8DP; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="FAKfP8DP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1729895370; x=1730154570;
	bh=7gsLzd1pcOtTKNjd/AMLR368fOeeKzHlm4v0S2Z3+zw=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=FAKfP8DPCbv7eiVABm21lIRtgNvG4cqkl7rIiWK5Zct8ukpaHzQddYHhdsWB2v9ir
	 ANtdDO8G9q7G5H3PYPpUEBUIgI7JmCncCbLByM4lVsSFQyhv/dcKSjkaL0Al6mEwH/
	 zM90lr+nhAP/OwrdLQf57bzzQ3GVAXgS+ocj0e25gueuK/FWnbiuk5fLB4gY/n+7q2
	 lehbF1faWulPirkDvMyXkJJktmJA7Cmx3wBGmT8CDsEqF86ObljyYmUxd/biDRZdBd
	 RlQh4ivPAHWWeHu8hYW0hE5m6Tgh9PglzhfRGWZCYe3530gLT67zRPUUt/M5ecM4nY
	 NaY41KnXulchg==
Date: Fri, 25 Oct 2024 22:29:25 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Phillip Wood <phillip.wood123@gmail.com>, shejialuo <shejialuo@gmail.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Caleb White <cdwhite3@pm.me>
Subject: [PATCH 0/2] Allow relative worktree linking to be configured by the user
Message-ID: <20241025-wt_relative_options-v1-0-c3005df76bf9@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: aeda215576df823af2bb1c76145080eabba5a7e3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patch introduces the `--[no-]relative-paths` CLI option for
`git worktree {add, move, repair}` commands, as well as the
`worktree.useRelativePaths` configuration setting. When enabled,
these options allow worktrees to be linked using relative paths,
enhancing portability across environments where absolute paths
may differ (e.g., containerized setups, shared network drives).

Using the `--relative-paths` option with `worktree {move, repair}`
will convert absolute paths to relative ones, if possible, while
`--no-relative-paths` does the reverse. For cases where users want
consistency in path handling, the config option
`worktree.useRelativePaths` provides a persistent setting.

A new extension, `relativeWorktrees`, is added to indicate that at least
one worktree in the repository has been linked with relative paths. This
extension is automatically set when a worktree is created or repaired
using the `--relative-paths` option, or when the
`worktree.useRelativePaths` config is set to `true`.

The `relativeWorktrees` extension ensures older Git versions do not
attempt to automatically prune worktrees with relative paths, as they
would not not recognize the paths as being valid.

Signed-off-by: Caleb White <cdwhite3@pm.me>
---
The base for this patch series is obtained by applying the following
patch onto 6a11438f43:
- cw/config-extensions topic (doc: consolidate extensions in git-config
  documentation, 2024-10-22, <20241021-cleanup-extension-docs-v1-1-ab02cece=
3132@pm.me>)

Link to original patch series:
https://lore.kernel.org/git/20241007-wt_relative_paths-v3-0-622cf18c45eb@pm=
.me

---
Caleb White (2):
      worktree: add CLI/config options for relative path linking
      worktree: add `relativeWorktrees` extension

 Documentation/config/extensions.txt |   6 ++
 Documentation/config/worktree.txt   |   5 ++
 Documentation/git-worktree.txt      |   9 +++
 builtin/worktree.c                  |  20 ++---
 repository.c                        |   1 +
 repository.h                        |   1 +
 setup.c                             |   7 ++
 setup.h                             |   1 +
 t/t0001-init.sh                     |  17 ++++-
 t/t2400-worktree-add.sh             |  54 ++++++++++++++
 t/t2401-worktree-prune.sh           |   3 +-
 t/t2402-worktree-list.sh            |  22 ++++++
 t/t2403-worktree-move.sh            |  22 ++++++
 t/t2406-worktree-repair.sh          |  26 +++++++
 worktree.c                          | 143 ++++++++++++++++++++------------=
----
 worktree.h                          |  14 ++++
 16 files changed, 272 insertions(+), 79 deletions(-)
---
base-commit: 6a11438f43469f3815f2f0fc997bd45792ff04c0
change-id: 20241025-wt_relative_options-afa41987bc32
prerequisite-change-id: 20241020-cleanup-extension-docs-f365868711bf:v1
prerequisite-patch-id: 60a443b24e92938b9b6f4a016a7bab87e13bf3ea

Best regards,
--=20
Caleb White <cdwhite3@pm.me>


