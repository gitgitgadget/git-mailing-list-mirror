Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ADE217F25
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 20:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729889848; cv=none; b=lzQA/xVa+IM1tm6ihhaOG1Rp+V59LTdPlsfbSZbyQzFIV8dE54ZAFn+1VTSNx3A1f0jR4LkAgUuxWKS4fqjaczoWwgpq7O3dOgT9UQIM0kCawkLwjS7ZOFyuVllu2zT8uiICQ8yS0obYouRnRz4xSzmKf2jWS03x2NWIlpmRd4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729889848; c=relaxed/simple;
	bh=Y608w2vZXuOQX15w3H90MW3mKIoyLPnkaiSEc9PzbII=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hghWSdIjtnVfvFO3bygW/IBhgGee28PYpi9jc85Ezog1A6Gj673iFIa0MsqVouHZisTSJVpCu+MglKMHwznDiPZ4/Cvt4bddZ6dNdJp7gMDJpEVQRny23KwYfIMCmF21W2toI4mVsHx4A+nphT5sKdj9n+MyNimkDu8/RuxUzB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=DdTGtOaq; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="DdTGtOaq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1729889844; x=1730149044;
	bh=yk79XXhPCxc7aus6mXID8jwO1tJdZum3eX90HHB2F+4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=DdTGtOaqB3tz+3FwS3ewyAgO3q16faMIYMEAWU39NcBRPEDsuMU8XLQg45z+inNXf
	 kbqLyLXuwzLK2E12cHEutNQwqXYlW+zaCCZMVq7P4ucftK3Gnj/aqZ9oPSI3YElqHa
	 utktbiE0rJRunXziAs1h2b47MSSRyPniF4o0o6Q8tyx1qG0z/QK8B2p+/tonRBItrX
	 sAr1ZC6PGo9fBdLCrb8g4utQ1nmxxqdA4kALGttnUQ8q/tZzFGy0cpQ2uv1Ygn9Ugx
	 p1Fc0+QfgntRfICmgsPMKqn1O+a8fvDGoCa+wJ2cxTvvU9oBOPu0pvg/hodUxTG0uF
	 9Znbp7tGn1h9w==
Date: Fri, 25 Oct 2024 20:57:17 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Phillip Wood <phillip.wood123@gmail.com>, shejialuo <shejialuo@gmail.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Caleb White <cdwhite3@pm.me>
Subject: [PATCH v3 0/5] Optionally link worktrees with relative paths
Message-ID: <20241025-wt_relative_paths-v3-0-8860a5321c01@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: ddb3e5152e7a992fa1a6a2e9c425149ba2b33fbf
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Git stores absolute paths when linking worktrees to the main repository.
However, this can cause problems when moving repositories and worktrees,
or when working in containerized environments where absolute paths
differ between systems. The worktree links break, and users are required
to manually execute `worktree repair` to repair them, leading to workflow
disruptions. Additionally, when repositories are mapped inside containers
with different absolute paths, they may become unusable. Repairing
worktrees in the container can then break them outside the container.

In some cases, relative paths can eliminate the need for `worktree repair`.
If both the repository and worktrees are moved together while preserving
their relative locations, the links remain intact. Common examples include
manually moving repositories and worktrees (or by tarballing) or mapping
both inside containers that use different absolute paths.

This patch series introduces the option to link worktrees with relative
paths via the `--relative-paths` argument or the `worktree.useRelativePaths=
`
config option. Relative paths improve the resilience of worktree links
across systems, especially when worktrees are self-contained in the main
repository (e.g., bare repositories). This enhances portability, improves
workflow efficiency, and reduces the need for manual repair.

Git now supports both absolute and relative paths ensuring backwards
compatibility and offering the flexibility of relative paths when desired.

Signed-off-by: Caleb White <cdwhite3@pm.me>
---
The base for this patch series is obtained by applying the following
patches onto v2.47.0 (777489f9e0):
- <20241021-cleanup-extension-docs-v1-1-ab02cece3132@pm.me> (doc:
  consolidate extensions in git-config documentation, 2024-10-22)
- es/worktree-repair-copied topic (worktree: repair copied repository
  and linked worktrees, 2024-09-23, <20240923075416.54289-1-ericsunshine@ch=
arter.net>)

Changes in v4:
- Added <20241021-cleanup-extension-docs-v1-1-ab02cece3132@pm.me> to base
- Updated title to better reflect added functionality.
- Added more test cases
- Added `--relative-paths` option to `git worktree {add,repair}`
- Added `worktree.useRelativePaths` config option.
- Added `relativeWorktrees` extension to prevent older git versions
  from operating on worktrees with relative paths.
- Split patch [2/3] into two patches for easier review: the first
  handles reading potentially relative paths from the files, and the
  second add the cli/config options and handles writing the relative
  paths to the linking files.
- Patch [1/3]: updated infer_backlink() to return -1 on error and
  strbuf.len on success, removed superfluous brackets, added docs,
  updated commit message.
- Improved cover letter and commit messages.
- Added instructions on how to construct the base in the cover letter.
- Link to v3: https://lore.kernel.org/git/20241007-wt_relative_paths-v3-0-6=
22cf18c45eb@pm.me
Changes in v3:
- Squashed patch [3/4] into patch [2/4] to streamline changes.
- Dropped patch [4/4] as it was no longer necessary.
- Rebased onto 20240923075416.54289-1-ericsunshine@charter.net
- Updated `infer_backlink()` to return 1 on success for consistency.
- Swapped the order of `infer_backlink()` arguments for clarity.
- Clear `inferred` if error occurs in `infer_backlink()`.
- Renamed `git_contents` to `dotgit_contents` for clearer semantics.
- Cleaned up `dotgit_contents` logic in `repair_worktree_at_path()`.
- Replaced multiple `xstrfmt/free` calls with a single `strbuf`.
- Added a test case covering a failure noted in a separate patch series.
- Improved commit messages.
- Link to v2: https://lore.kernel.org/r/20241006060017.171788-1-cdwhite3@pm=
.me
Changes in v2:
- No changes, just a resubmission
- Link to v1: https://lore.kernel.org/git/20241006045847.159937-1-cdwhite3@=
pm.me/

---
Caleb White (5):
      worktree: refactor infer_backlink() to use strbuf*
      worktree: support worktrees linked with relative paths
      worktree: optionally link worktrees with relative paths
      worktree: add test for path handling in linked worktrees
      worktree: add `relativeWorktrees` extension

 Documentation/config/extensions.txt |   6 +
 Documentation/config/worktree.txt   |   5 +
 Documentation/git-worktree.txt      |   9 ++
 builtin/worktree.c                  |  18 ++-
 repository.c                        |   1 +
 repository.h                        |   1 +
 setup.c                             |   9 +-
 setup.h                             |   1 +
 t/t0001-init.sh                     |  20 ++-
 t/t2400-worktree-add.sh             |  54 +++++++
 t/t2401-worktree-prune.sh           |  20 +++
 t/t2402-worktree-list.sh            |  22 +++
 t/t2403-worktree-move.sh            |  22 +++
 t/t2406-worktree-repair.sh          |  26 ++++
 worktree.c                          | 283 ++++++++++++++++++++++++++------=
----
 worktree.h                          |  24 +++
 16 files changed, 433 insertions(+), 88 deletions(-)
---
base-commit: 4ec4435df758668055cc904ef64c275bc8d1089b
change-id: 20241007-wt_relative_paths-88f9cf5a070c
prerequisite-change-id: 20241020-cleanup-extension-docs-f365868711bf:v1
prerequisite-patch-id: 60a443b24e92938b9b6f4a016a7bab87e13bf3ea
prerequisite-message-id: <20240923075416.54289-1-ericsunshine@charter.net>
prerequisite-patch-id: 78371f4dbb635e6edab8c51ee7857b903e60df8f

Best regards,
--=20
Caleb White <cdwhite3@pm.me>


