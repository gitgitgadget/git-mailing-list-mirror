Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFDD54279
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 22:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732918954; cv=none; b=nd9GNBcIw4vcw44zdh2GTsQVwoaOq1YlpU6cgQ+Yj37nWbFYpsQLNyOEBgF/vw7mn7In9A0IKklVDXHSNwvZ6QpJeBPYCccZARir9Yj6s8dwgADL5upzvD30DhvI9V/U7+4hkALnKX9rC+MaESfOTQ6qg391doHD6EwfWyhk8ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732918954; c=relaxed/simple;
	bh=LAiuftf0JdjNwIrxOB2HxyQJO9qZ2YURveFau3cx47M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A0PPz1wvJVUj4QmRsXlG2ceXyBeU+0MSTBC6w5xUZi2xWZ8zug9SdbbB1pB3cFPPnpSODAnS6Jod6UgFLPFIHjS6kFOZ3yFxPvk+juBt2djtmr/qozBSrJ3jyIJjxunOMEpHEujkyTdfzkRjvc1xrWB5QkV7IoIKHzsn/nzi30w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=jzv+6lfY; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="jzv+6lfY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732918943; x=1733178143;
	bh=r8vjS3huxWrv7S+9E3ENipXwlq8AWs1dQlXAsFoop6E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=jzv+6lfY2ft/uNnWpnaotpl7ueFxbV4zSiQZdUu1bmtjncz+8BTf7Tp1kBBg8bSP3
	 f0CEtrnIZ3ifOTgO3pIZ5fwGVnCVezY0xtkd3c/njpzSAhwa1Q+xMl0854TXduBrv0
	 mmMKp/QkBcNh8tv1w/inJK79SX3xhfcegnySMCWzMufZ78KALSqYIYliN36QOZ1+c1
	 45NU5m8ZT0EXo0nMNUB6GGCHqLYJHeumfqGOZS2Sh5vIvv4vvIyZg2E0iaL8miVHIz
	 XOTS/tImNkCOoAMVK6SQx3CE+vJWCvtgXwL0j98Oqc7Yx50kU7yFbgWF6lw3pUUUup
	 qYD0V4cqJfDXQ==
Date: Fri, 29 Nov 2024 22:22:19 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Caleb White <cdwhite3@pm.me>
Subject: [PATCH v6 0/8] Allow relative worktree linking to be configured by the user
Message-ID: <20241129-wt_relative_options-v6-0-44e4e0bec8c3@pm.me>
In-Reply-To: <20241125-wt_relative_options-v5-0-356d122ff3db@pm.me>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me> <20241125-wt_relative_options-v5-0-356d122ff3db@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 0567198d53d574f69edb5213225b4ec0be2d3517
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
The base for this patch series is 090d24e9af.

Link to original patch series:
https://lore.kernel.org/git/20241007-wt_relative_paths-v3-0-622cf18c45eb@pm=
.me

---
Changes in v6:
- Re-add test for extensions.relativeworktrees config setting
- Link to v5: https://lore.kernel.org/r/20241125-wt_relative_options-v5-0-3=
56d122ff3db@pm.me
Changes in v5:
- Added docs to `--relative-paths` option.
- Added test coverage for `repair_worktrees()` and relative paths.
- Move `strbuf_reset` call in `infer_backlink()`.
- Cleaned up tests.
- Slight stylistic changes.
- Tweaked commit messages.
- Updated base to 090d24e9af.
- Link to v4: https://lore.kernel.org/r/20241031-wt_relative_options-v4-0-0=
7a3dc0f02a3@pm.me
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
 Documentation/git-worktree.txt      |   8 ++
 builtin/worktree.c                  |  29 ++++---
 repository.c                        |   1 +
 repository.h                        |   1 +
 setup.c                             |  39 ++++++---
 setup.h                             |   1 +
 t/t0001-init.sh                     |  22 ++++-
 t/t2400-worktree-add.sh             |  46 +++++++++++
 t/t2401-worktree-prune.sh           |   3 +-
 t/t2402-worktree-list.sh            |  22 +++++
 t/t2403-worktree-move.sh            |  25 ++++++
 t/t2406-worktree-repair.sh          |  39 +++++++++
 t/t2408-worktree-relative.sh        |  39 ---------
 t/t5504-fetch-receive-strict.sh     |   6 +-
 worktree.c                          | 157 ++++++++++++++++++++------------=
----
 worktree.h                          |  22 ++++-
 18 files changed, 334 insertions(+), 142 deletions(-)
---
base-commit: 090d24e9af6e9f59c3f7bee97c42bb1ae3c7f559
change-id: 20241025-wt_relative_options-afa41987bc32

Best regards,
--=20
Caleb White <cdwhite3@pm.me>


