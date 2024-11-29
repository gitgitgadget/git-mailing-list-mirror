Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B6E79CD
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 02:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732848282; cv=none; b=BHE9Wu7S8Kp25Ws0k3jR5U+XTl1zPmNteRWtPT9jE9dbbThhYHZkK7A9fGCSXoKXZLetOD5hHeMaOEyerz16noBUYlb3vuvaWS1b/A6pgjHSPzB+UB193kRYTmSvSqZtuM6cauOd3eNfr/bE2TLkAKNRZGMGIv2/N02catiuTFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732848282; c=relaxed/simple;
	bh=DU7YmCRjnN6ozxJvAuVnW1kwyGKaU1P8cvyRHoeM5T8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=cTLHqjJj2cznxH5MTa2LaoeeJqgjUEvU5/w/vN/Km1E3R+kvxsAqOsaS5pSFUwOJSm5iiHatFMHHIXKKeyzEBLKIYitok2ZX0KihZI5y0KxJWjkfJO7AHE0GyOfcgsuUayHRLn1WC+Q5oAnKH4zasKyMFnnVY0e+wS5fSP38F6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=J8R7XeTs; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="J8R7XeTs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732848268; x=1733107468;
	bh=h1mueGL75nBUiwR3bndAe/Y+ZM03ubIFw3rGnLqtSHw=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=J8R7XeTsQXATR4I7+CGV/VYLiBatm5XQa+w6Iol6Q+y84lcJKa6MGA2CqyX2z+J4Z
	 /5e8GcuyaKYFyo+IHVN8zXeC5ubWgjHsZVVkdclOofy/7kt+IbkNn41QRIG1nCTX6i
	 0i7o3c9SynTpQWFJ81SbXzrCzHmZe3HHATn5xYi94Ds0nE8gp1MnHTIin/E+y9ZlCn
	 EVgrF9lRlm18B+W/3ipSEH+iBPsam9/qraCVL2XQy+GzLDMirpC8Dhv3TaH1bfWtCP
	 hRwco9gzN5zLyuV/huFRPEpLV+eF9OfhGGEnV9bsQidZcpLW3QmTEjkycWVjnzAdcx
	 tAkngbYyKv9Fw==
Date: Fri, 29 Nov 2024 02:44:24 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Caleb White <cdwhite3@pm.me>
Subject: [PATCH 0/2] Ensure unique worktree ids across repositories
Message-ID: <20241128-wt_unique_ids-v1-0-30345d010e43@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: f5b5d8fc0162e2c216c98535c06c77f5c7fb2016
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
is given by the `git_rand()` function, but I'm open to suggestions if
there's a better random or hashing function to use.

[1]: https://lore.kernel.org/git/20241008153035.71178-1-cdwhite3@pm.me/
[2]: https://lore.kernel.org/git/r4zmcET41Skr_FMop47AKd7cms9E8bKPSvHuAUpnYa=
vzKEY6JybJta0_7GfuYB0q-gD-XNcvh5VDTfiT3qthGKjqhS1sbT4M2lUABynOz2Q=3D@pm.me/

Signed-off-by: Caleb White <cdwhite3@pm.me>
---
Caleb White (2):
      worktree: add worktree with unique suffix
      worktree: rename worktree id during worktree move

 Documentation/git-worktree.txt     |  5 +-
 builtin/worktree.c                 | 30 ++++++++++++
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
 t/t2403-worktree-move.sh           | 38 ++++++++--------
 t/t2405-worktree-submodule.sh      | 10 ++--
 t/t2406-worktree-repair.sh         | 93 ++++++++++++++++++++++++----------=
----
 t/t2407-worktree-heads.sh          | 27 +++++------
 t/t3200-branch.sh                  | 10 ++--
 t/t5304-prune.sh                   |  2 +-
 t/t7412-submodule-absorbgitdirs.sh |  4 +-
 20 files changed, 239 insertions(+), 183 deletions(-)
---
base-commit: 090d24e9af6e9f59c3f7bee97c42bb1ae3c7f559
change-id: 20241127-wt_unique_ids-1ffd7ea0bb19
prerequisite-change-id: 20241025-wt_relative_options-afa41987bc32:v5
prerequisite-patch-id: 179410e257e8eedf100f4f9faa9467cbbba4d61b
prerequisite-patch-id: 56ffe0afeadd511c9eef5f548a371659b040acab
prerequisite-patch-id: 809c1314e5dfa966f4f3d73b52f286f8aa89370f
prerequisite-patch-id: cf5f9491c8f8e58d1e0e103a5f8c64c55f2896e3
prerequisite-patch-id: 3d3bb3cc81d3030b1d27c39fdb4cf0e383937f89
prerequisite-patch-id: 62a09496d98d78a6bd1f9150ba887ee72359c7ee
prerequisite-patch-id: 5527e4b745963dd4fa08029491fcbfe3d91d5104
prerequisite-patch-id: bf433443e90939a493fa586de30938f78cb77020

Best regards,
--=20
Caleb White <cdwhite3@pm.me>


