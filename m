Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EC414900F
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716321431; cv=none; b=gHIhR7TWX93C9qGgyKyqzB5eQtJqGOH4+vhUBSgSS/qoRHA4xnYeJ85+cwAm29trGmzXyiIvBlRMk9BVn5MV7l+I4qP1mWCSBj3cKC5rhrulkaUDWvcJgAQSn8paXUlQ4RMwJzJOVbtWzoDBrfUJjU1ahpGAkaNZFx+eCVdGP1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716321431; c=relaxed/simple;
	bh=xH6WGYE8er0GKW0qcUpqAHFVegR/pa/Fl9c9pZM0lmc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=e7MsJonBiCfZF+iLYeWEjkUVWyimxzv5Ur2G9spSPWpKTp/5IkbfnT3fc49y8gq0nECH9wmHevlahyvKa872x0Gi1yLXPA5OaY2mHZcD5CX4oxZdqF58vkID1pdTZM1Os6oVackbwK9v3w52rcPgnCyhWM77b6qTFXtqfV48ItE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=P/f19g57; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="P/f19g57"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 756B931233;
	Tue, 21 May 2024 15:57:04 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-transfer-encoding;
	 s=sasl; bh=xH6WGYE8er0GKW0qcUpqAHFVegR/pa/Fl9c9pZM0lmc=; b=P/f1
	9g57jEBBgP2jRk5NetKJmVwF4fNlvXCESI97v+djMHgugzKbv3FoYWZd5/blBdYy
	WNP8f5vKadCjGG/Y6r2CONrwzY81lbWpdp7qQYvkUs2QM8so3Y7afBIfLK30mXZo
	lieY4LcFBc3CralibUxVNj+k06uB1vgeOD43hUM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5680D31232;
	Tue, 21 May 2024 15:57:04 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D74433122F;
	Tue, 21 May 2024 15:57:00 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 00/12] Fix various overly aggressive protections in 2.45.1 and friends
Date: Tue, 21 May 2024 12:56:46 -0700
Message-ID: <20240521195659.870714-1-gitster@pobox.com>
X-Mailer: git-send-email 2.45.1-216-g4365c6fcf9
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 49A20EB0-17AC-11EF-86B5-A19503B9AAD1-77302942!pb-smtp21.pobox.com
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

I'll figure out a way to convey conflict resolutions as this topic
gets merged up to newer maintenance tracks on the list so that
people can assist with ensuring correctness of the result by
reviewing, and follow up. ("git show --remerge-diff" might turn out
to be such a way, but I do not know yet).


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
  Revert "fetch/clone: detect dubious ownership of local repositories"

 .github/workflows/main.yml    |  3 +-
 Makefile                      |  2 +-
 builtin/clone.c               | 12 +-------
 cache.h                       | 14 ---------
 ci/install-dependencies.sh    |  2 --
 config.c                      | 13 +-------
 copy.c                        | 58 -----------------------------------
 git-send-email.perl           | 32 +++++++------------
 hook.c                        | 32 -------------------
 path.c                        |  2 --
 t/helper/test-path-utils.c    | 10 ------
 t/t0060-path-utils.sh         | 41 -------------------------
 t/t0411-clone-from-partial.sh |  6 ++--
 t/t1350-config-hooks-path.sh  |  7 +++++
 t/t1800-hook.sh               | 15 ---------
 t/t5601-clone.sh              | 51 ------------------------------
 t/t9001-send-email.sh         |  5 +--
 17 files changed, 28 insertions(+), 277 deletions(-)

--=20
2.45.1-216-g4365c6fcf9

