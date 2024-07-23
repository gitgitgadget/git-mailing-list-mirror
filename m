Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C2B14287
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 02:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721701145; cv=none; b=QEA3STLL7QcjKlfN2KI9SYanVsuxCxLZeSz4EaIzPCcQPJXMBHPPQ4OCOGGDHHe9HVUKmsv5+vcpcRr3B0bxWDKnWZiYRLnJIKV7xeqmAtgY6415/cRaeONtS0OI5d1eTVF16iHB7a8qOngnrxvnYwjtdp177K+8LXW6enbflfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721701145; c=relaxed/simple;
	bh=F8V5jTt+SHoXVxEV6lqe5vyFjjresIYjlmMuXIomNk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMSfdhP+SGjtL0Tnx7JxY6jalcXghXLkYl8VUMv0TQ9jzX7g/FLZlvica7O0fqOKgZIniqlF1Ur4COkKmRc3O7vXTWciaRRGCef1xc808ifzmReE+A+cY/jmaA8K2fk23o0Uuo1D4BQK5iPNoMggP0PAmohTlHg9C/pTCWCbBWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GDpSHMX1; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GDpSHMX1"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9DEB32585D;
	Mon, 22 Jul 2024 22:19:02 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=F8V5jTt+SHoXVxEV6lqe5vyFj
	jresIYjlmMuXIomNk4=; b=GDpSHMX1N6vnWUg+T6f1soIHCysjq+Hh1u3ypQFUq
	xagaEuyRUHFTSS4JWewSGFm/WsZHjqVoSlsRly7bRrm7gzhpLdOLVIQl7FX/0Lin
	yxME/RU2DMKmGmRVKMd7CZYuIZeJb3Kgx3+DbymTqfrZBPWM/9toHJNOJPIdTJNh
	uM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8EC422585C;
	Mon, 22 Jul 2024 22:19:02 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F22DD2585B;
	Mon, 22 Jul 2024 22:19:01 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 0/3] safe.directory clean-up
Date: Mon, 22 Jul 2024 19:18:57 -0700
Message-ID: <20240723021900.388020-1-gitster@pobox.com>
X-Mailer: git-send-email 2.46.0-rc1-52-gda884b23f2
In-Reply-To: <20240720220915.2933266-1-gitster@pobox.com>
References: <20240720220915.2933266-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 ED4AF5E0-4899-11EF-A3EA-34EEED2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Changes since v1:

 - two "extra" patches for optimization that are unnecessary have
   been dropped.
 - a patch to add test for safe.directory=3D"." use case has been
   added.=20

Recently we discussed what we should do when either the path
configured in the safe.directory configuration or coming from
the caller of ensure_valid_ownership() function as a result of
repository discovery is not normalized and textual equality check is
not sufficient.  See the thread the contains

  https://lore.kernel.org/git/6d5b75a6-639d-429b-bd37-232fc6f475af@gmail.=
com/

Here are three patches that implement the comparison between
normalized path and configuration value.

Imagine that you have a repository at /mnt/disk4/repos/frotz
directory but in order to make it simpler to manage and use, you
have your users use /projects/frotz to access the repository.  A
symlink /projects/frotz pointing at /mnt/disk4/repos/frotz directory
allows you to do so.

 - The first patch normalizes the path to the directory that we
   suspect is a usable repository, before comparing it with the
   safe.directory configuration variable.  The safe.directory may
   say /mnt/disk4/repos/frotz or /mnt/disk4/repos/*, but the path to
   the repository for the users may be /mnt/disk4/repos/frotz or
   /projects/frotz, depending on where they come from and what their
   $PWD makes getcwd() to say.

 - The second patch normalizes the value of the safe.directory
   variable.  This allows safe.directory to say /projects/frotz
   or /projects/* and have them match /mnt/disk4/repos/frotz (which
   is how the first patch normalizes the repository path to).

 - The third patch only adds a test to illustrate what happens when
   the safe.directory configuration is set to ".", which was a
   plausible setting for those who run "git daemon".  The
   normalization done by the first two patches is sufficient to make
   this just work.

Junio C Hamano (3):
  safe.directory: normalize the checked path
  safe.directory: normalize the configured path
  safe.directory: setting safe.directory=3D"." allows the "current"
    directory

 setup.c                   |  28 ++++++--
 t/t0033-safe-directory.sh | 146 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 170 insertions(+), 4 deletions(-)

Range-diff against v1:
1:  20e1160946 ! 1:  86d5c83ee7 safe.directory: normalize the checked pat=
h
    @@ t/t0033-safe-directory.sh: test_expect_success 'local clone of uno=
wned repo acce
     +		sane_unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
     +		git config --global safe.directory "$(pwd)/repository"
     +	) &&
    -+	git -C repository/ for-each-ref >/dev/null &&
    -+	git -C repo/ for-each-ref
    ++	git -C repository for-each-ref &&
    ++	git -C repository/ for-each-ref &&
    ++	git -C repo for-each-ref &&
    ++	git -C repo/ for-each-ref &&
    ++	test_must_fail git -C repository/.git for-each-ref &&
    ++	test_must_fail git -C repository/.git/ for-each-ref &&
    ++	test_must_fail git -C repo/.git for-each-ref &&
    ++	test_must_fail git -C repo/.git/ for-each-ref
     +'
     +
     +test_expect_success SYMLINKS 'checked leading paths are normalized'=
 '
    @@ t/t0033-safe-directory.sh: test_expect_success 'local clone of uno=
wned repo acce
     +		sane_unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
     +		git config --global safe.directory "$(pwd)/repository/*"
     +	) &&
    -+	git -C repository/s for-each-ref >/dev/null &&
    -+	git -C repo/s for-each-ref
    ++	git -C repository/s for-each-ref &&
    ++	git -C repository/s/ for-each-ref &&
    ++	git -C repo/s for-each-ref &&
    ++	git -C repo/s/ for-each-ref &&
    ++	git -C repository/s/.git for-each-ref &&
    ++	git -C repository/s/.git/ for-each-ref &&
    ++	git -C repo/s/.git for-each-ref &&
    ++	git -C repo/s/.git/ for-each-ref
     +'
     +
      test_done
2:  06de9038b7 ! 2:  c4998076da safe.directory: normalize the configured =
path
    @@ setup.c: static int safe_directory_cb(const char *key, const char =
*value,
    =20
      ## t/t0033-safe-directory.sh ##
     @@ t/t0033-safe-directory.sh: test_expect_success SYMLINKS 'checked =
leading paths are normalized' '
    - 	git -C repo/s for-each-ref
    + 	git -C repo/s/.git/ for-each-ref
      '
     =20
     +test_expect_success SYMLINKS 'configured paths are normalized' '
    @@ t/t0033-safe-directory.sh: test_expect_success SYMLINKS 'checked l=
eading paths a
     +		sane_unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
     +		git config --global safe.directory "$(pwd)/repo"
     +	) &&
    -+	git -C repository/ for-each-ref >/dev/null &&
    -+	git -C repo/ for-each-ref
    ++	git -C repository for-each-ref &&
    ++	git -C repository/ for-each-ref &&
    ++	git -C repo for-each-ref &&
    ++	git -C repo/ for-each-ref &&
    ++	test_must_fail git -C repository/.git for-each-ref &&
    ++	test_must_fail git -C repository/.git/ for-each-ref &&
    ++	test_must_fail git -C repo/.git for-each-ref &&
    ++	test_must_fail git -C repo/.git/ for-each-ref
     +'
     +
     +test_expect_success SYMLINKS 'configured leading paths are normaliz=
ed' '
    @@ t/t0033-safe-directory.sh: test_expect_success SYMLINKS 'checked l=
eading paths a
     +	git init repository/s &&
     +	ln -s repository repo &&
     +	(
    -+		cd repository &&
    ++		cd repository/s &&
     +		sane_unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
     +		test_commit sample
     +	) &&
    @@ t/t0033-safe-directory.sh: test_expect_success SYMLINKS 'checked l=
eading paths a
     +		sane_unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
     +		git config --global safe.directory "$(pwd)/repo/*"
     +	) &&
    -+	git -C repository/s for-each-ref >/dev/null &&
    -+	git -C repo/s for-each-ref
    ++	git -C repository/s for-each-ref &&
    ++	git -C repository/s/ for-each-ref &&
    ++	git -C repository/s/.git for-each-ref &&
    ++	git -C repository/s/.git/ for-each-ref &&
    ++	git -C repo/s for-each-ref &&
    ++	git -C repo/s/ for-each-ref &&
    ++	git -C repo/s/.git for-each-ref &&
    ++	git -C repo/s/.git/ for-each-ref
     +'
     +
      test_done
-:  ---------- > 3:  ffc3f7364e safe.directory: setting safe.directory=3D=
"." allows the "current" directory
--=20
2.46.0-rc1-52-gda884b23f2

