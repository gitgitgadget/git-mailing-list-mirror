Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3871A77117
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 22:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721513365; cv=none; b=pvLrb1Ajc1domHmAdyicfGfi4EyV6yeVfy46805I671dZpyFbGInno1H2g1mQejB6vXzBlgubHqYMBiDtbZCLwYpWa3DXBXpu42gnunoC2YNveJc4a/9mf3ipcTFY+ZZTmnqj949kBCR0mtBCod58aDakiojKsFUkHyBzBai1Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721513365; c=relaxed/simple;
	bh=L2alUfBOWuxSVhAQrfZsrcWC4vh6P5a1XlhG3c+8/98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fonkuInvO+zRm8ngLwsG9UiHNhLCcx6dic325AfpNQPL+/SnFohJyJlZ/gxQoh6F2kr3vGkoe6oJxoYcSumq5YO3XiHcmkU8t72AlpL4xE36F92Uxz/RpYb2CLV2f9twqMHSCf8sscutEqd1jFCpJtdz/iQuHoF6V/xCrvtO/NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WqSQOY8A; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WqSQOY8A"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 33ECB1E860;
	Sat, 20 Jul 2024 18:09:17 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-transfer-encoding;
	 s=sasl; bh=L2alUfBOWuxSVhAQrfZsrcWC4vh6P5a1XlhG3c+8/98=; b=WqSQ
	OY8AmIVVqtHGjuDUE+4a+2HZ3bbsWitvIPQhrPXOhY2ltl1GdNDNVg++yVcDx8AA
	7Aure+HXnyYNfp72zQGFGkwMnUbX53yf67wapkoQl5parmGQpceZ3lV8RerFHOKm
	9+Ya9sM3XJz+Quhds9T4i12t4o7BfKd/WEJWLgE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A7701E85F;
	Sat, 20 Jul 2024 18:09:17 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 868A21E85E;
	Sat, 20 Jul 2024 18:09:16 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 0/2] safe.directory clean-up
Date: Sat, 20 Jul 2024 15:09:11 -0700
Message-ID: <20240720220915.2933266-1-gitster@pobox.com>
X-Mailer: git-send-email 2.46.0-rc1-48-g0900f1888e
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 B472E9E6-46E4-11EF-9599-BAC1940A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Recently we discussed what we should do when either the path
configured in the safe.directory configuration or coming from
the caller of ensure_valid_ownership() function as a result of
repository discovery is not normalized and textual equality check is
not sufficient.  See the thread the contains

  https://lore.kernel.org/git/6d5b75a6-639d-429b-bd37-232fc6f475af@gmail.=
com/

Here are two patches (yes, two) that implements the comparison
between normalized path and configuration value.

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

 - The third patch is a preliminary clean-up that would be needed if
   we wanted to use the fourth patch.

 - The fourth patch would become relevant if we were to call
   ensure_valid_ownership() on many directories in a single process.
   We grab safe.directory values and normalize them just once before
   using in ensure_valid_ownership() to optimize away repeated
   normalization.

It turns out that nobody calls ensure_valid_ownership() on many
different directories even in the repository discovery loop, which
means the fourth patch is not needed, which in turn means the third
patch that is a preliminary clean-up is also not necessary.

Junio C Hamano (4):
  safe.directory: normalize the checked path
  safe.directory: normalize the configured path
  setup: allow centralized clean-up when leaving setup_git_directory_gent=
ly_1()
  setup: cache normalized safe.directory configuration

 setup.c                   | 141 +++++++++++++++++++++++++++++++-------
 t/t0033-safe-directory.sh |  90 ++++++++++++++++++++++++
 2 files changed, 205 insertions(+), 26 deletions(-)

--=20
2.46.0-rc1-48-g0900f1888e

