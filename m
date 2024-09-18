Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45744178363
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 23:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726702111; cv=none; b=KKE+Axp5jdB7pELSjxsKOpb2WDuzDq4jX7J+qqnFi4zmoJ/e058DJERC+zFR6wCiejZnrNa77t8+afmCrTsFSt3qM0ByU5znl2+kXzV5iovJQd+imSgJ0p03kXlv3nXsHGkoyomBv9Ks8tzDsY4Wc5IFC3dfArKrTJwbfMCPWic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726702111; c=relaxed/simple;
	bh=RpGzS9fikF5EpJGCs0vE5KpN79L+CZULt9TkIZYaBUo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XK6KupUSrYjMopdtCCK/ZhAUSYbLxhdbmE0/EOAAVxO0rV76wcJvI2o4JHUL6kppzIODgHLhs44sdFyga5hG1LS4HfrhjP9F0aFq8aR093qpbhrWl22jxu72r1a9dVqeagB0gvAF6CAiYSzqrxkmCDbz9IO1yda6zHDhyLi0tt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=K7EciFoW; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="K7EciFoW"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D7D701B711;
	Wed, 18 Sep 2024 19:28:27 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-transfer-encoding;
	 s=sasl; bh=RpGzS9fikF5EpJGCs0vE5KpN79L+CZULt9TkIZYaBUo=; b=K7Ec
	iFoW6SgZ8ZD7PzjTa6CPmcCPZ3EBgXFbMLjkfKBzQzbm5QdYLwdXatkU6GCs0ZDf
	s2Z7bWv1yPsCy71v5CefZI7vfXOfjRja+eC/Z+DBXc3EASZ+JOsSf8HDfTfIfik2
	GEBmCkM5PiycZf571Zw1CpwJGxpZQ/F1/FqhZeM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CEAE11B710;
	Wed, 18 Sep 2024 19:28:27 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3C0381B70F;
	Wed, 18 Sep 2024 19:28:27 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 0/4] deprecating core.preferSymlinkRefs
Date: Wed, 18 Sep 2024 16:28:21 -0700
Message-ID: <20240918232825.2627999-1-gitster@pobox.com>
X-Mailer: git-send-email 2.46.1-742-g4240f61078
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 B4DDD4DA-7615-11EF-8ED5-9B0F950A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Removal of support for core.preferSymlinkRefs at Git 3.0 boundary,
so that we only write textual symrefs for things like HEAD and
refs/remotes/origin/HEAD, and still understand symbolic links used
as symrefs in existing repositories, is a serious proposal this
patch series makes.

But at the same time, this is an RFC.  I wrote it to serve as a
candidate for BCP, a guide to those who want to add an entry to the
breaking changes document.  I think anything that is described in
the breaking changes document has to become a patch series that
spans multi-year effort, and that must be done with care.

 - The proposal phase.  A breaking change is outlined, transition
   plan is given, and the first step of the transition (often,
   starting to give a warning and offering an alternative to the
   feature planned to be removed are involved) is presented.  The
   aim is that after N years, the user base will be aware of the
   upcoming removal and would already be prepared to be able to work
   with Git 3.0 that lacks the removed feature.

   In this series, [Patch 1/4] does this.

 - The Git 3.0 phase.  A breaking change is actually implemented.
   It optionally can offer help to those who procrastinated until
   the last-minute to break them, but the feature itself is gone.

   In this series, [PATCH 2/4] and [Patch 3/4] do this.

 - Clean-up phase.  If the previous phase added an additional
   transition help, after M years, such a help meant for transition
   would be removed.

   In this series, [PATCH 4/4] does this.

What I want people to think about is how to ensure quality of the
Git 3.0 phase.  We can iterate and polish the proposal phase with as
much time as we want to spend, just like any new feature.  But Git
3.0 phase is with a solid deadline, and before that time, we cannot
remove the feature for real.  Would we cook such steps in 'next'
forever until the actual Git 3.0?  To those users who are running
'next' based Git, it would mean that some of the changes the
breaking changes document listed would come a lot earlier to them.
On the other hand, unless we somehow have a way to expose willing
volunteers an early access to these "big changes", there is no way
for them to be as stable and tested.  We should not plan to scramble
and be able to perfect these changes between Git v3.0-rc0 and Git
v3.0 final.

Or perhaps use the "experimental.*" configuration stored in the
user's ~/.gitconfig to let users opt into Git 3.0 features (one of
which may be that textual symrefs are always used regardless of the
core.preferSymlinkRefs setting)?  That way, we can merge these big
changes early without worrying about accidentally affecting the
end-user population.

Junio C Hamano (4):
  refs: deprecate core.preferSymlinkRefs
  refs: mostly remove core.preferSymlinkRefs
  refs: remove NO_SYMLINK_HEAD
  refs: remove the last remnants of core.preferSymlinkRefs

 Documentation/BreakingChanges.txt   | 11 ++++++++
 Documentation/config/core.txt       |  6 -----
 Makefile                            |  6 -----
 config.c                            |  5 ----
 config.mak.uname                    |  3 ---
 configure.ac                        |  3 ---
 contrib/buildsystems/CMakeLists.txt |  2 +-
 environment.c                       |  1 -
 environment.h                       |  1 -
 refs/files-backend.c                | 26 -------------------
 t/t0600-reffiles-backend.sh         | 39 ++++++++++++++++-------------
 11 files changed, 34 insertions(+), 69 deletions(-)

--=20
2.46.1-742-g4240f61078

