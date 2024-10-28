Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAAC1DF740
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 19:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730142579; cv=none; b=eUb8dt62le21ggeArrFg1kOuOZI3/R0USapS6+/Tx9nIC4ls294/7VEG2QiglvyTpbK/K1FWG1U0qybxe64DX+1TtZrwHupewEgxiMXYwMcYP1OHpsDpfuG+64BeDaYELZVLZL5RmjDmOKOodm7xTXEqlzynWRx+4g93THB/xwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730142579; c=relaxed/simple;
	bh=e90YOLGrz8S9nw9HC4YvtUAz6WJaouI2Lon8vV83neQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=uI5nZlaLSZKe8k0wX4URWKAKnA9BFlgcbR2zcOKcYUFiar/lHaMeHg1+v2xJVpMUeWdNlfl4Q3dHjg+rxyEjlOkSY48YuR+WTfh3xdk12gxZ7ge3drmeT6fYC6doERxqY4CILGDn9v+6ZYsENT6dXQfqoxbJORLaP+a2pD7dw3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=AFraDS7z; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="AFraDS7z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1730142575; x=1730401775;
	bh=b+HSGulMlf+v/cLzfxX0fKHONu5g6bAuITGurNRdPoY=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=AFraDS7zF5SJkXRYawOede3Rf/jLCQ42gvR8hzJge8pH1sgyM5sZFlWFkBUlVNV/v
	 8cHWTcdLTnS6kmRp0xpISxcaHdq1TAAvy6aiGLIgxMzOYkEpONWTdvwm1hz7G5zPk7
	 MKQSqbYv7amv1PsLeJqU0i/RIqUK2QDNSlZFcAIB43W+upjPPyhzLOQV5JnWRSOBKg
	 yB80k0k6vzTKi9aPPN1ZK2uzdt2StesE+v2h0InrNg64JUOADYAX5QYaM8r1qYqqkH
	 STtP7XrHsrZJ5uWEWnO67SujdclXi1rPP4QupioUwhk8WiPRsIaVeaQFCAe5XU0JOP
	 D5k2Rl4NWf9+Q==
Date: Mon, 28 Oct 2024 19:09:30 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Caleb White <cdwhite3@pm.me>
Subject: [PATCH v2 0/5] Allow relative worktree linking to be configured by the user
Message-ID: <20241028-wt_relative_options-v2-0-33a5021bd7bb@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 59a983a21c3e4f5e342a3c42499d0c93d4f6c107
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
Changes in v2:
- Fixed a bug where repositories with valid extensions would be downgraded
  to v0 during reinitialization, causing future operations to fail.
- Split patch [1/2] into three separate patches.
- Updated cover letter and commit messages.
- Updated documentation wording.
- Link to v1: https://lore.kernel.org/r/20241025-wt_relative_options-v1-0-c=
3005df76bf9@pm.me

---
Caleb White (5):
      worktree: add CLI/config options for relative path linking
      worktree: add `write_worktree_linking_files` function
      worktree: add tests for worktrees with relative paths
      setup: correctly reinitialize repository version
      worktree: add `relativeWorktrees` extension

 Documentation/config/extensions.txt |   6 ++
 Documentation/config/worktree.txt   |   5 ++
 Documentation/git-worktree.txt      |  12 +++
 builtin/worktree.c                  |  20 ++---
 repository.c                        |   1 +
 repository.h                        |   1 +
 setup.c                             |  39 +++++++---
 setup.h                             |   1 +
 t/t0001-init.sh                     |  17 ++++-
 t/t2400-worktree-add.sh             |  54 ++++++++++++++
 t/t2401-worktree-prune.sh           |   3 +-
 t/t2402-worktree-list.sh            |  22 ++++++
 t/t2403-worktree-move.sh            |  22 ++++++
 t/t2406-worktree-repair.sh          |  26 +++++++
 t/t2408-worktree-relative.sh        |  39 ----------
 worktree.c                          | 143 ++++++++++++++++++++------------=
----
 worktree.h                          |  14 ++++
 17 files changed, 298 insertions(+), 127 deletions(-)
---
base-commit: 6a11438f43469f3815f2f0fc997bd45792ff04c0
change-id: 20241025-wt_relative_options-afa41987bc32
prerequisite-change-id: 20241020-cleanup-extension-docs-f365868711bf:v1
prerequisite-patch-id: 60a443b24e92938b9b6f4a016a7bab87e13bf3ea

Best regards,
--=20
Caleb White <cdwhite3@pm.me>


