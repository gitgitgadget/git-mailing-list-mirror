Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2696510E3
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 01:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722301811; cv=none; b=RAlXyCEhd87oYzliOt9HAEJfTavmyG1w8Fb3XDObVt0ankUxcoKxeaYFwWil5RJZIJx2pDO1kmLOe66cFMdV//yXXQwJBIF22WqKWFgJZC+qVkJGrq6s/7yNC0+PYjL0XeI9goLxBZy7H/V59Vrr+DbCVI46eEyzx8H5/Yg+2c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722301811; c=relaxed/simple;
	bh=Gi9FGCakKL7Ygg6jHrT4f36oiaEXD+U/M+Y66+rZTbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDoHyNwfuxVjdNNWRHX5zamn9H/D7V5AdzsFA+9bS8K2e0apxcYQTLOe4ke4hLbgxPcT2zQRjpjBKgodoYUdLAErlFXrFHEJ0yoipbRfy7xiWjF84Zs0KTBTjfOqOoeiqui/TVJzJEf3P3dHTuvR8CrRRB2oDHPpAG8vA1Nxmss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pkKlEDC8; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pkKlEDC8"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 81777309C4;
	Mon, 29 Jul 2024 21:10:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=Gi9FGCakKL7Ygg6jHrT4f36oi
	aEXD+U/M+Y66+rZTbM=; b=pkKlEDC8WANhxRx/AvdsYkrf6hOhZVdQOthNJqTfL
	yh0qOYp6AjnPQJmZvrRDCzYkm6D4PsBi07mvu96qH4O8GhcLyQ2kLvDwKdrqaPY6
	KASyAzMYMUd1Fbn7N/UBYHkkNq5Z3G84ScgCZIKKDP1mF619VmTbX+QeenkpM10m
	kI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7A388309C3;
	Mon, 29 Jul 2024 21:10:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ECBEC309BF;
	Mon, 29 Jul 2024 21:10:05 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 0/3] safe.directory clean-up
Date: Mon, 29 Jul 2024 18:10:01 -0700
Message-ID: <20240730011004.4030246-1-gitster@pobox.com>
X-Mailer: git-send-email 2.46.0-71-g1aa693ace8
In-Reply-To: <20240723021900.388020-1-gitster@pobox.com>
References: <20240723021900.388020-1-gitster@pobox.com> <20240720220915.2933266-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 74EC49B0-4E10-11EF-8075-92D9AF168FA5-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Changes since v2:

 - It is no longer an error if a path listed on the safe.directory
   configuration variable does not exist, as suggested by Peff
   (cf. <20240726050253.GC642208@coredump.intra.peff.net>).

 - A path listed on the safe.directory that is not an absolute path is
   ignored, as it makes little sense, as suggested by Phillip
   (cf. <5332f244-7476-492a-a797-2ef7ba73f490@gmail.com>), except for
   ".", which was once advertised as a valid workaround on the list.
   (cf. <834862fd-b579-438a-b9b3-5246bf27ce8a@gmail.com>).

Recently we discussed what we should do when either the path
configured in the safe.directory configuration variable or coming
from the caller of ensure_valid_ownership() function as a result of
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
   variable.  This allows safe.directory to say /projects/frotz or
   /projects/* and have them match /mnt/disk4/repos/frotz (which is
   how the first patch normalizes the repository path to).  Note
   that non-absolute paths in safe.directory are ignored, as they
   make little sense, except for ".".

 - The third patch only adds a test to illustrate what happens when
   the safe.directory configuration is set to ".", which was
   advertised as a viable workaround for those who run "git daemon".

Junio C Hamano (3):
  safe.directory: normalize the checked path
  safe.directory: normalize the configured path
  safe.directory: setting safe.directory=3D"." allows the "current"
    directory

 setup.c                   |  53 ++++++++++--
 t/t0033-safe-directory.sh | 178 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 223 insertions(+), 8 deletions(-)

Range-diff against v2:
1:  86d5c83ee7 =3D 1:  0e298f20ae safe.directory: normalize the checked p=
ath
2:  c4998076da ! 2:  68ada68936 safe.directory: normalize the configured =
path
    @@ Commit message
         safe.directory configuration variable before comparing them with=
 the
         path being checked.
    =20
    +    Two and a half things to note, compared to the previous step to
    +    normalize the actual path of the suspected repository, are:
    +
    +     - A configured safe.directory may be coming from .gitignore in =
the
    +       home directory that may be shared across machines.  The path
    +       meant to match with an entry may not necessarily exist on all=
 of
    +       such machines, so not being able to convert them to real path=
 on
    +       this machine is *not* a condition that is worthy of warning.
    +       Hence, we ignore a path that cannot be converted to a real pa=
th.
    +
    +     - A configured safe.directory is essentially a random string th=
at
    +       user throws at us, written completely unrelated to the direct=
ory
    +       the current process happens to be in.  Hence it makes little
    +       sense to give a non-absolute path.  Hence we ignore any
    +       non-absolute paths, except for ".".
    +
    +     - The safe.directory set to "." was once advertised on the list=
 as
    +       a valid workaround for the regression caused by the overly ti=
ght
    +       safe.directory check introduced in 2.45.1; we treat it to mea=
n
    +       "if we are at the top level of a repository, it is OK".
    +       (cf. <834862fd-b579-438a-b9b3-5246bf27ce8a@gmail.com>).
    +
         Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
    +    Helped-by: Jeff King <peff@peff.net>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    =20
      ## setup.c ##
    @@ setup.c: static int safe_directory_cb(const char *key, const char =
*value,
     =20
      		if (!git_config_pathname(&allowed, key, value)) {
      			const char *check =3D allowed ? allowed : value;
    -+			char *to_free =3D real_pathdup(check, 0);
    +-			if (ends_with(check, "/*")) {
    +-				size_t len =3D strlen(check);
    +-				if (!fspathncmp(check, data->path, len - 1))
    ++			char *to_free =3D NULL;
     +
    -+			if (!to_free) {
    -+				warning(_("safe.directory '%s' cannot be normalized"),
    ++			/*
    ++			 * Setting safe.directory to a non-absolute path
    ++			 * makes little sense---it won't be relative to
    ++			 * the configuration file the item is defined in.
    ++			 * Except for ".", which means "if we are at the top
    ++			 * level of a repository, then it is OK", which is
    ++			 * slightly tighter than "*" that allows discovery.
    ++			 */
    ++			if (!is_absolute_path(check) && strcmp(check, ".")) {
    ++				warning(_("safe.directory '%s' not absolute"),
     +					check);
     +				goto next;
    -+			} else {
    -+				check =3D to_free;
     +			}
     +
    - 			if (ends_with(check, "/*")) {
    - 				size_t len =3D strlen(check);
    - 				if (!fspathncmp(check, data->path, len - 1))
    -@@ setup.c: static int safe_directory_cb(const char *key, const char=
 *value,
    - 			} else if (!fspathcmp(data->path, check)) {
    ++			/*
    ++			 * A .gitconfig in $HOME may be shared across
    ++			 * different machines and safe.directory entries
    ++			 * may or may not exist as paths on all of these
    ++			 * machines.  In other words, it is not a warning
    ++			 * worthy event when there is no such path on this
    ++			 * machine---the entry may be useful elsewhere.
    ++			 */
    ++			to_free =3D real_pathdup(check, 0);
    ++			if (!to_free)
    ++				goto next;
    ++			if (ends_with(to_free, "/*")) {
    ++				size_t len =3D strlen(to_free);
    ++				if (!fspathncmp(to_free, data->path, len - 1))
    + 					data->is_safe =3D 1;
    +-			} else if (!fspathcmp(data->path, check)) {
    ++			} else if (!fspathcmp(data->path, to_free)) {
      				data->is_safe =3D 1;
      			}
     +			free(to_free);
3:  ffc3f7364e ! 3:  9d26940ba4 safe.directory: setting safe.directory=3D=
"." allows the "current" directory
    @@ Commit message
         same owner as the process.
    =20
         Make sure this access will be allowed by setting safe.directory =
to
    -    ".".
    +    ".", as that was once advertised on the list as a valid workarou=
nd
    +    to the overly tight safe.directory settings introduced by 2.45.1
    +    (cf. <834862fd-b579-438a-b9b3-5246bf27ce8a@gmail.com>).
    +
    +    Also add simlar test to show what happens in the same setting if=
 the
    +    safe.directory is set to "*" instead of "."; in short, "." is a =
bit
    +    tighter (as it is custom designed for git-daemon situation) than
    +    "anything goes" settings given by "*".
    =20
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    =20
    @@ t/t0033-safe-directory.sh: test_expect_success SYMLINKS 'configure=
d leading path
     +	git -C repository/.git for-each-ref &&
     +	git -C repository/.git/ for-each-ref &&
     +
    -+	# what is allowed is repository/subdir but the repository
    ++	# What is allowed is repository/subdir but the repository
     +	# path is repository.
     +	test_must_fail git -C repository/subdir for-each-ref &&
     +
    -+	# likewise, repository .git/refs is allowed with "." but
    ++	# Likewise, repository .git/refs is allowed with "." but
     +	# repository/.git that is accessed is not allowed.
     +	test_must_fail git -C repository/.git/refs for-each-ref
     +'
    ++
    ++test_expect_success 'safe.directory set to asterisk' '
    ++	test_when_finished "rm -rf repository" &&
    ++	(
    ++		sane_unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
    ++		git config --global --unset-all safe.directory
    ++	) &&
    ++	mkdir -p repository/subdir &&
    ++	git init repository &&
    ++	(
    ++		cd repository &&
    ++		sane_unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
    ++		test_commit sample
    ++	) &&
    ++
    ++	(
    ++		sane_unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
    ++		git config --global safe.directory "*"
    ++	) &&
    ++	# these are trivial
    ++	git -C repository for-each-ref &&
    ++	git -C repository/ for-each-ref &&
    ++	git -C repository/.git for-each-ref &&
    ++	git -C repository/.git/ for-each-ref &&
    ++
    ++	# With "*", everything is allowed, and the repository is
    ++	# discovered, which is different behaviour from "." above.
    ++	git -C repository/subdir for-each-ref &&
    ++
    ++	# Likewise.
    ++	git -C repository/.git/refs for-each-ref
    ++'
     +
      test_done
--=20
2.46.0-71-g1aa693ace8

