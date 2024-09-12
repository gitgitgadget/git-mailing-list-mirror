Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C5715098A
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 20:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726174387; cv=none; b=EcuKUMy9wZjw0q3dt9laYu1TmiUaq+azks5ilaiSRVt1IlIfukFm9hlOdYPnToiWhOwGXhYx28gAwDiPd3TqjHxv2jUnckspmXbGdPDzZNQSTVTOCAa5vOd9S1UTkUOO2HPfGw8VxgRqso5FElLeLnWMEmcHtRFdWFwY3lY15YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726174387; c=relaxed/simple;
	bh=7/yRbpjkr7A8Ktrq3MRh2S+fWx2HEegqSZLNznxpWqI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CWLuwNI7h3NQ8K1Rps5DD9iHVBO6n0kZncuExJp2DOv2wDSeKQxlkzEmcZ3/F/TdF90n0Y8apvG93L4t8WotJWFLrfU2Pb8+AMlurUcTZImHnoz2lAu7nke5H9igrBkajYeVl/MMSGdsklq9nWj/Ls3F1xf3iP8o2D3GN7X1wrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=N3NjAalG; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="N3NjAalG"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DD05037746;
	Thu, 12 Sep 2024 16:53:04 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-transfer-encoding;
	 s=sasl; bh=7/yRbpjkr7A8Ktrq3MRh2S+fWx2HEegqSZLNznxpWqI=; b=N3Nj
	AalGpecraWD7aM25nCAzXD7vA1F+c7uXumWLgMi/OdigLwTldsY58cIeQQ3qBci0
	m+3rmnxi7ACmF8jJOBOWf1PA/iblj9/TGVBjXVZYXKdY2sQVr0UJQwobrOnxCUeO
	eVqsSS11efZ0wWgQwangblt6zRWfV5glipYS/S0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D25ED37745;
	Thu, 12 Sep 2024 16:53:04 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8064537744;
	Thu, 12 Sep 2024 16:53:03 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 0/2] Simplify "commented" API functions
Date: Thu, 12 Sep 2024 13:52:59 -0700
Message-ID: <20240912205301.1809355-1-gitster@pobox.com>
X-Mailer: git-send-email 2.46.0-738-g205d0d5e39
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 010700A6-7149-11EF-A4B5-9B0F950A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

We [earlier] noticed that a few helper functions that format strings
into a strbuf, prefixed with an arbitrary comment leading character,
are forcing their callers to always pass the same argument.  Instead
of keeping this excess flexibility nobody wants in practice, narrow
the API so that all callers of these functions will get the same
comment leading character.

Superficially it may appear that this goes against one of the recent
trend, "war on global variables", but I doubt it matters much in the
longer run.

These call sites all have already been relying on the global
"comment_line_str" anyway, and passing the variable from the top of
arbitrary deep call chain, which may not care specifically about
this single variable comment_line_str, would not scale as a
solution.  If we were to make it a convention to pass something from
the very top of the call chain everywhere, it should not be an
individual variable that is overly specific, like comment_line_str.
Rather, it has to be something that allows access to a bag of all
the global settings (possibly wider than "the_repository" struct).
We can also limit our reliance to the globals by allowing a single
global function call to obtaion such a bag of all global settings,
i.e. "get_the_environment()", and allow everybody, including
functions at the leaf level, to ask "what is the comment_line_str in
the environment I am working in?".  As part of the libification, we
can plug in an appropriate shim for get_the_environment().


[earlier] https://lore.kernel.org/git/xmqq7cn4g3nx.fsf@gitster.g/

Junio C Hamano (2):
  strbuf: retire strbuf_commented_addf()
  strbuf: retire strbuf_commented_lines()

 add-patch.c          |  8 ++++----
 builtin/branch.c     |  2 +-
 builtin/merge.c      |  8 ++++----
 builtin/notes.c      | 10 +++++-----
 builtin/stripspace.c |  2 +-
 builtin/tag.c        |  4 ++--
 fmt-merge-msg.c      | 17 +++++++----------
 rebase-interactive.c |  8 ++++----
 sequencer.c          | 16 +++++++---------
 strbuf.c             | 11 +++++------
 strbuf.h             | 13 +++++--------
 wt-status.c          |  6 +++---
 12 files changed, 48 insertions(+), 57 deletions(-)

--=20
2.46.0-717-g3841ff3f09

