Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9264413D897
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 04:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730435912; cv=none; b=Mwwuurmnl/LyLA7jHTjDyedhp6zbDXkNkkiWQgZhhvpWdNR2xP8IMNUvET9eWA3/RhJyc/bDV1Gz3TlZ6wahG3OZTyDDGjLdNFjFDHphDDBAP8C/1466hRYwZf9XEW9OUmIm8a4YqQLUbb81M5fT84kAjq8bK1bK2PGjWydyojg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730435912; c=relaxed/simple;
	bh=pEciyEEsDohtjnUgRE2gEO68Qr80AMM/JXMgRaSKZCQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bZztrNenmSIf+QJMjqweCIV3EHDOL3W9L8AwDws7jK9jeAZXFkqE55h4urKOfG5BgWJOGfYr6Ft4Bn7R5FB6QOfAE3p0Qrkkfjy2sFfZbfyoB1Ww2SvgdQzVsYQMrfIwP2PWfi8biVZNaFyez0gHHQCODRedit8s+YyHEXj/PH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=GBcYNSjF; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="GBcYNSjF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1730435899; x=1730695099;
	bh=HrwVTzRYTl1NqnwwO6vej5JAeUBiagR13t+5AFv4jfQ=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=GBcYNSjF9bx0dQHqR4P6ezEBbWo3zhMBq31raLyluODnV8YElMHWTu9SFpw3EUtJ9
	 +gpxZJj0i3WXBkw99Cer8luxIMIZIXaK6q/7r5V4M+HGfP3tCyAnKK/lDKHHeUjSc+
	 2sZakUx4f7lXOlhRYeBy8G3dWKNtHNNeceIqOn9E6LFqlq/cHJQXGmjUIDfutf59nR
	 h28HEKGhBQsZEDakr2Up0EGSXt4hZiXMaRoFuM4f/sit322nF20V+unPCkTKKIEEap
	 ZAHCQOw1hAPm7HBoc3OTkH4dvgXyVF/MhzyzZ7mw4Klzh56+smH8QAXGM14siCANpr
	 iLddyba9VdRLQ==
Date: Fri, 01 Nov 2024 04:38:15 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Caleb White <cdwhite3@pm.me>
Subject: [PATCH v4 0/8] Allow relative worktree linking to be configured by the user
Message-ID: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: decd641a984502724c4ad8826a707ca0c909e27d
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This series introduces the `--[no-]relative-paths` CLI option for
`git worktree {add, move, repair}` commands, as well as the
`worktree.useRelativePaths` configuration setting. When enabled,
these options allow worktrees to be linked using relative paths,
enhancing portability across environments where absolute paths
may differ (e.g., containerized setups, shared network drives).
Git still creates absolute paths by default, but these options allow
users to opt-in to relative paths if desired.

Using the `--relative-paths` option with `worktree {move, repair}`
will convert absolute paths to relative ones, while `--no-relative-paths`
does the reverse. For cases where users want consistency in path handling,
the config option `worktree.useRelativePaths` provides a persistent setting=
.

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
Changes in v4:
- Fixed failing test in ci
- Link to v3: https://lore.kernel.org/r/20241031-wt_relative_options-v3-0-3=
e44ccdf64e6@pm.me
Changes in v3:
- Split patches into smaller edits.
- Moved tests into the patches with the relevant code changes.
- Removed global `use_relative_paths` and instead pass parameter to functio=
ns.
- Changed `infer_backlink` return type from `int` to `ssize_t`.
- Updated `worktree.useRelativePaths` and `--relative-paths` descriptions.
- Reordered patches
- Link to v2: https://lore.kernel.org/r/20241028-wt_relative_options-v2-0-3=
3a5021bd7bb@pm.me
Changes in v2:
- Fixed a bug where repositories with valid extensions would be downgraded
  to v0 during reinitialization, causing future operations to fail.
- Split patch [1/2] into three separate patches.
- Updated cover letter and commit messages.
- Updated documentation wording.
- Link to v1: https://lore.kernel.org/r/20241025-wt_relative_options-v1-0-c=
3005df76bf9@pm.me

---
Caleb White (8):
      setup: correctly reinitialize repository version
      worktree: add `relativeWorktrees` extension
      worktree: refactor infer_backlink return
      worktree: add `write_worktree_linking_files()` function
      worktree: add relative cli/config options to `add` command
      worktree: add relative cli/config options to `move` command
      worktree: add relative cli/config options to `repair` command
      worktree: refactor `repair_worktree_after_gitdir_move()`

 Documentation/config/extensions.txt |   6 ++
 Documentation/config/worktree.txt   |  10 +++
 Documentation/git-worktree.txt      |   7 ++
 builtin/worktree.c                  |  29 ++++---
 repository.c                        |   1 +
 repository.h                        |   1 +
 setup.c                             |  39 +++++++--
 setup.h                             |   1 +
 t/t0001-init.sh                     |  22 ++++-
 t/t2400-worktree-add.sh             |  54 ++++++++++++
 t/t2401-worktree-prune.sh           |   3 +-
 t/t2402-worktree-list.sh            |  22 +++++
 t/t2403-worktree-move.sh            |  22 +++++
 t/t2406-worktree-repair.sh          |  26 ++++++
 t/t2408-worktree-relative.sh        |  39 ---------
 t/t5504-fetch-receive-strict.sh     |   6 +-
 worktree.c                          | 163 ++++++++++++++++++++------------=
----
 worktree.h                          |  22 ++++-
 18 files changed, 331 insertions(+), 142 deletions(-)
---
base-commit: 6a11438f43469f3815f2f0fc997bd45792ff04c0
change-id: 20241025-wt_relative_options-afa41987bc32
prerequisite-change-id: 20241020-cleanup-extension-docs-f365868711bf:v1
prerequisite-patch-id: 60a443b24e92938b9b6f4a016a7bab87e13bf3ea

Best regards,
--=20
Caleb White <cdwhite3@pm.me>


