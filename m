Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DB92C18C
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 22:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732919867; cv=none; b=LjnuMcEKDA2dxC078VUY3IBQLqFd6ePwO956DlZOZ6pJ5xa2DJQ4pAbf+7k/lrvainKFMI73WdQdIo7/mPj/on8UOuNcri1dpe5YAAhauOXbREfT+AO6MuQ4o8+JiTl+0ZDdN4xs+cyA4OSJ7BD8/wyZ3tuTJsP48h4bZelbPDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732919867; c=relaxed/simple;
	bh=T9GzMj0i+tZ9Fnw7e3mSXf+H+E14eNu/9CpcSboZfpw=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=CFX0fmkp0YjPo/5PMu680Cj5tb/9M8ONeWxdAUC+BLOioaun+tQ616K/nUKoG0pn3xhcls4UGkMA6mVWyf6FKuKLJaAHQvwfGsEbauwG+rddTy6njX3n0YdVaecPTBlkVqRDbZhat+ljwByb7rtmnxBuScxddnuSUP9Z3D8e64w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Of2LWrbf; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Of2LWrbf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732919857; x=1733179057;
	bh=R6vdmjYtBezKOXhBGevaJFGTc9qKaTn8F96T7AxilJw=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=Of2LWrbfX3++/xqFvwiIbqDwSTjOR0LDRLWTmEhTixMwCMubNAOtjelGVU17hPtyv
	 kRzFYVDTTOUQAVp90w9vm0e5C6TBbGh6LhuZqGcdN3qZCWfOpOanMLBOEZ4a9tzn0s
	 EeGZmuWGkVWrbGWO1B4U5wtQnQcfTDE7OwL08K4Zh2kOAilTdgcsYxe4WrR/AGv7Rr
	 AxP4z2CCENm1eiQ41vb+53p4wHpuBJG0DraJP4YUvkC8i9oRClByjut8OA+jMCo1ku
	 HeA4HzdV0MolLDMc1pkDJgxL1d6gA5BDCxxmAp2nQ99Ibi3jPbYjYXM5o32DLpVMo3
	 4Ob8q1ret4r7Q==
Date: Fri, 29 Nov 2024 22:37:34 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: shejialuo <shejialuo@gmail.com>, Junio C Hamano <gitster@pobox.com>, Caleb White <cdwhite3@pm.me>
Subject: [PATCH v2 0/3] Ensure unique worktree ids across repositories
Message-ID: <20241129-wt_unique_ids-v2-0-ff444e9e625a@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 87d912fb5bb9e5034ec8395d00cb0473d00e7fef
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The `es/worktree-repair-copied` topic added support for repairing a
worktree from a copy scenario. I noted[1,2] that the topic added the
ability for a repository to "take over" a worktree from another
repository if the worktree_id matched a worktree inside the current
repository which can happen if two repositories use the same worktree name.

This series teaches Git to create worktrees with a unique suffix so
that the worktree_id is unique across all repositories even if they have
the same name. For example creating a worktree `develop` would look like:

    foo/
    =E2=94=9C=E2=94=80=E2=94=80 .git/worktrees/develop-5445874156/
    =E2=94=94=E2=94=80=E2=94=80 develop/
    bar/
    =E2=94=9C=E2=94=80=E2=94=80 .git/worktrees/develop-1549518426/
    =E2=94=94=E2=94=80=E2=94=80 develop/

The actual worktree directory name is still `develop`, but the
worktree_id is unique and prevents the "take over" scenario. The suffix
is given by the `git_rand()` function which should be sufficient to
ensure that the suffix is effectively unique (the likelihood of
a collision with the same name and suffix is extremely low).

During a `worktree move` the worktree directory is moved/renamed but the
repository under `worktrees/<id>` is not updated. For example, moving
`develop` to `master` results in

    foo/
    =E2=94=9C=E2=94=80=E2=94=80 .git/worktrees/develop-5445874156/
    =E2=94=94=E2=94=80=E2=94=80 master/

This works because the linking files still point to the correct
repository, but this is a little weird. This series teaches Git to also
move/rename the repository / worktree id during a `move` so that the
structure now looks like:

    foo/
    =E2=94=9C=E2=94=80=E2=94=80 .git/worktrees/master-1565465986/
    =E2=94=94=E2=94=80=E2=94=80 master/

Note that a new unique suffix is assigned to reduce the complexity of
trying to parse and reuse the existing suffix.

Additionally, this series teaches `worktree list` to output the worktree
id in the verbose and porcelain modes, which allows users and scripts to
more easily obtain the id for a given worktree.

[1]: https://lore.kernel.org/git/20241008153035.71178-1-cdwhite3@pm.me/
[2]: https://lore.kernel.org/git/r4zmcET41Skr_FMop47AKd7cms9E8bKPSvHuAUpnYa=
vzKEY6JybJta0_7GfuYB0q-gD-XNcvh5VDTfiT3qthGKjqhS1sbT4M2lUABynOz2Q=3D@pm.me/

Signed-off-by: Caleb White <cdwhite3@pm.me>
---
The base for this series is obtained by merging the `cw/worktree-extension`
topic (2024-11-26, 20241125-wt_relative_options-v5-0-356d122ff3db@pm.me)
onto 090d24e9af.

Changes in v2:
- Add the worktree id to `worktree list` output
- Updated cover letter
- Link to v1: https://lore.kernel.org/r/20241128-wt_unique_ids-v1-0-30345d0=
10e43@pm.me

---
Caleb White (3):
      worktree: add worktree with unique suffix
      worktree: rename worktree id during worktree move
      worktree: add id to `worktree list` output

 Documentation/git-worktree.txt     | 17 +++++--
 builtin/worktree.c                 | 35 ++++++++++++++
 t/t0035-safe-bare-repository.sh    |  4 +-
 t/t0600-reffiles-backend.sh        | 10 ++--
 t/t0601-reffiles-pack-refs.sh      |  4 +-
 t/t0610-reftable-basics.sh         | 54 +++++++++++-----------
 t/t1407-worktree-ref-store.sh      |  4 +-
 t/t1410-reflog.sh                  | 10 ++--
 t/t1415-worktree-refs.sh           | 26 +++++------
 t/t1450-fsck.sh                    | 14 +++---
 t/t1500-rev-parse.sh               |  6 +--
 t/t2400-worktree-add.sh            | 51 +++++++++++----------
 t/t2401-worktree-prune.sh          | 20 ++++----
 t/t2402-worktree-list.sh           | 16 ++++---
 t/t2403-worktree-move.sh           | 38 ++++++++--------
 t/t2405-worktree-submodule.sh      | 10 ++--
 t/t2406-worktree-repair.sh         | 93 ++++++++++++++++++++++++----------=
----
 t/t2407-worktree-heads.sh          | 27 +++++------
 t/t3200-branch.sh                  | 10 ++--
 t/t5304-prune.sh                   |  2 +-
 t/t7412-submodule-absorbgitdirs.sh |  4 +-
 21 files changed, 265 insertions(+), 190 deletions(-)
---
base-commit: 090d24e9af6e9f59c3f7bee97c42bb1ae3c7f559
change-id: 20241127-wt_unique_ids-1ffd7ea0bb19
prerequisite-change-id: 20241025-wt_relative_options-afa41987bc32:v6
prerequisite-patch-id: 179410e257e8eedf100f4f9faa9467cbbba4d61b
prerequisite-patch-id: 56ffe0afeadd511c9eef5f548a371659b040acab
prerequisite-patch-id: 809c1314e5dfa966f4f3d73b52f286f8aa89370f
prerequisite-patch-id: cf5f9491c8f8e58d1e0e103a5f8c64c55f2896e3
prerequisite-patch-id: 9884b33822bf4c7c3b89a9a6b49d4ab44c2670e7
prerequisite-patch-id: 62a09496d98d78a6bd1f9150ba887ee72359c7ee
prerequisite-patch-id: 5527e4b745963dd4fa08029491fcbfe3d91d5104
prerequisite-patch-id: bf433443e90939a493fa586de30938f78cb77020

Best regards,
--=20
Caleb White <cdwhite3@pm.me>


