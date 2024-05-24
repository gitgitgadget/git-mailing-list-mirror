Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FE71BF3F
	for <git@vger.kernel.org>; Fri, 24 May 2024 19:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716580039; cv=none; b=rwsV92WNVPOaNQHpbxGDCaQFtf/+yaK7LCHPxVdS0cK97X9CNd9Z8PqAatNJnmJ0zmluiC/XP5rMwUQQlxrcQYPAiEs0RagDRLjH2aHpZ/cVtxEhcrnQTfD6WGGWSm4XzSHdYCDqNGbPLXki91Dg1F3mLy0fJMfS2G2b1YzkRkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716580039; c=relaxed/simple;
	bh=JPjmsfJ9smd/MJqxtFJwUYSSomYIH5RVhwl2KcaRXnQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=iZUg985DtFIIDAuAthXbNXzKIZgH2ZJx0sW9xVXKgHx6zgV1uFRi/IBlaasx8qPCZEo1fOsxEbhEoX2nHf+fXKvKtOJltDjze0O+LSmdJKmeQDd42hoavFbm4d7BmCBX3WVQTwh13d5Jxewy/FNPtLdNZtX/yybQmgZ0kXxdH9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JLW1xB0/; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JLW1xB0/"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 388E01BD1A;
	Fri, 24 May 2024 15:47:17 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-transfer-encoding;
	 s=sasl; bh=JPjmsfJ9smd/MJqxtFJwUYSSomYIH5RVhwl2KcaRXnQ=; b=JLW1
	xB0/NtnOolhi/VqiJhkl7g5v3/0TOy9CVAlgMvqGiTeZ1limdyYO1dwpjFmm1XB/
	Yfsa0MY2HFZzJpJwTl5Ye/zXS3kNtOr/s723U0HCvkRuPw/fpke7EKYeE4e+rBRk
	sE2kLd9RfjURLqbGr624wRqw9LY8rfszzEKN9PY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 30ADB1BD19;
	Fri, 24 May 2024 15:47:17 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8C8251BD18;
	Fri, 24 May 2024 15:47:16 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 00/12] Fix various overly aggressive protections in 2.45.1 and friends
Date: Fri, 24 May 2024 12:47:03 -0700
Message-ID: <20240524194715.695916-1-gitster@pobox.com>
X-Mailer: git-send-email 2.45.1-246-gb9cfe4845c
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 6C99C4D8-1A06-11EF-B83E-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

As people have seen, the latest "security fix" release turned out to
be a mixed bag of good vulnerability fixes with a bit over-eager
"layered defence" that broke real uses cases like git-lfs.  Let's
quickly get them in working order back first, with the vision that
we will then rebuild layered defence more carefully in the open on
top as necessary.

What we have here are the first "revert" part.

These patches are designed to apply to 2.39.4; the series may have
to grow as we discover more things to revert, but for now here are
the patches to

 - revert the over-eager "refusal to work" went into 2.39.4

 - adjust 2.39.4 codebase to cleanly build and test (at CI and
   locally) by backported fixes

It would have been better if we did not have to have the latter
class, but such is life.

Relative to the previous iteration, there are two differences, which
are:

 * Old [12/12] that reverted the repository ownership check for
   local case is gone.  A well known escape hatch is available that
   is easy to use when the repositories are trusted (most notably,
   in a hosting set-up, the repositories are trusted not to attack
   the 'nobody' user that is running 'git').

 * New [12/12] reverts a dubious checks for targets of symbolic
   links done in "git fsck" (and transfer).

Today's integration cycle is pretty much committed to have these in
'next' for the weekend, merge them down to 'master' by the end of
month, hoping that we can do 2.45.2 and friends sometime early next
month.


Jeff King (5):
  send-email: drop FakeTerm hack
  send-email: avoid creating more than one Term::ReadLine object
  ci: drop mention of BREW_INSTALL_PACKAGES variable
  ci: avoid bare "gcc" for osx-gcc job
  ci: stop installing "gcc-13" for osx-gcc

Johannes Schindelin (6):
  hook: plug a new memory leak
  init: use the correct path of the templates directory again
  Revert "core.hooksPath: add some protection while cloning"
  tests: verify that `clone -c core.hooksPath=3D/dev/null` works again
  clone: drop the protections where hooks aren't run
  Revert "Add a helper function to compare file contents"

Junio C Hamano (1):
  Revert "fsck: warn about symlink pointing inside a gitdir"

 .github/workflows/main.yml    |  3 +-
 Documentation/fsck-msgids.txt | 12 --------
 Makefile                      |  2 +-
 builtin/clone.c               | 12 +-------
 cache.h                       | 14 ---------
 ci/install-dependencies.sh    |  2 --
 config.c                      | 13 +-------
 copy.c                        | 58 -----------------------------------
 fsck.c                        | 56 ---------------------------------
 fsck.h                        | 12 --------
 git-send-email.perl           | 32 +++++++------------
 hook.c                        | 32 -------------------
 t/helper/test-path-utils.c    | 10 ------
 t/t0060-path-utils.sh         | 41 -------------------------
 t/t1350-config-hooks-path.sh  |  7 +++++
 t/t1450-fsck.sh               | 37 ----------------------
 t/t1800-hook.sh               | 15 ---------
 t/t5601-clone.sh              | 51 ------------------------------
 t/t9001-send-email.sh         |  5 +--
 19 files changed, 25 insertions(+), 389 deletions(-)

--=20
2.45.1-246-gb9cfe4845c

