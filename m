Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F29DB644
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 00:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722904544; cv=none; b=sfjS4LS/tpdolI/KNAZ/RB3yuUfJ0tq2nMCJ5xP8HM8DTL2Q2iXTzMFC2l0jT2Oi0GhT7+W/bAg7nMpXhaDj+HLZUVAyJqBVnzXbZANwCdG8zKl0suQhsOd/bMe3ULdjPYDmTkgiY9h3BskhBTVszjaGD+VWDMpSI/gt0QlLxD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722904544; c=relaxed/simple;
	bh=9uwp0fH2wyZO4qhPIgkUL+Blgp1mIxRXvgMBFfs36wA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=iOPYycAh0BfyswCgr0F5YtbTvz5Sc+qMxumQugxi1e/fCypLruOjv0nXTzMVZ6/9ys0Skadwk6uAS5BkoXO1h7logsBCO36QfFO/3+IREbi9n2UCpd9NiilZYcc+x7/SrNarXXX2p0hTME27+1KP+47wZkrzou9zV1tuP/kjVik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bJyujf1Z; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bJyujf1Z"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5620F28343;
	Mon,  5 Aug 2024 20:35:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-transfer-encoding;
	 s=sasl; bh=9uwp0fH2wyZO4qhPIgkUL+Blgp1mIxRXvgMBFfs36wA=; b=bJyu
	jf1ZFfQo6PNnOMsLT/uDdwEwMsrPvsM/JxfRgpIcLCrOxgWlaJ+VM0ukqFe65BwL
	d7/vKTu8pTirPY/hVRtCIwj7EZ8lKRV6LI61HOqp1pQ636HhfevzPZT4NdGPTKiK
	nZLydNIM+dBj6mZgvjxo76JE2zy9v8fN1q3kZ2I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4DFB028342;
	Mon,  5 Aug 2024 20:35:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B1C0A28341;
	Mon,  5 Aug 2024 20:35:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v1 0/4] make "too many arguments" a bit more useful
Date: Mon,  5 Aug 2024 17:35:35 -0700
Message-ID: <20240806003539.3292562-1-gitster@pobox.com>
X-Mailer: git-send-email 2.46.0-235-g968ce1ce0e
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 CF6DFC0A-538B-11EF-8BF1-9B0F950A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Imagine seeing your command failing with "too many arguments" when
you run "git cmd foo bar baz".  Can you tell it will work if you
said "git cmd foo bar"?  Or is that trimming your command line too
much?  Too little?  You cannot quite tell.

If the command reported "unknown argument: 'bar'", you would know
that among the arguments you gave to "git", i.e. "cmd foo bar baz",
up to "cmd foo" were understood and "bar" and "baz" were not.

This was one of the things I noticed while reviewing a topic and
marked as leftoverbits to be cleaned up after the dust settled.  The
dust has settled and it is a good time to clean them up.

Junio C Hamano (4):
  refs: avoid "too many arguments"
  cat-file: avoid "too many arguments"
  notes: avoid "too many arguments"
  miscellaneous: avoid "too many arguments"

 builtin/cat-file.c      |  3 ++-
 builtin/notes.c         | 18 +++++++++---------
 builtin/prune-packed.c  |  6 +++---
 builtin/receive-pack.c  |  3 ++-
 builtin/refs.c          |  4 +++-
 builtin/tag.c           |  2 +-
 t/t1006-cat-file.sh     |  8 +++++---
 t/t1460-refs-migrate.sh |  7 ++++---
 t/t3301-notes.sh        |  2 +-
 9 files changed, 30 insertions(+), 23 deletions(-)

--=20
2.46.0-235-g968ce1ce0e

