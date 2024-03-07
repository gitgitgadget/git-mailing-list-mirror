Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9B7823BF
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 09:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709802851; cv=none; b=UmVMx5PS/CJ3u/GiCuBSUPip42EuiG7NsPTIxcOESYSTyv4N4mukKzLRd/pJM5b7Xhgfi9HraefZoxBKpThOhIIXVY1rZ4F/q9UDEPvwiRKIp8dztTDT18YIqdl0p4ogEsRROXf/viiCIKtvyUOb0VtwqwfLBUtYcY8W2mE7Wto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709802851; c=relaxed/simple;
	bh=u7NV9Ob6dfuA0apJD20x0ixfchH9znpF7VITNLYLyXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxRcKBWBEyiUMnYetOy7CR8+dWxwUp1svTmWjJmThmB4HeB69KCrNgKya7GYj99mg/ICAgaJvBEFCdL0XKga6G4MGUX1+YNhMPv+uVUUqy8SoNmEpVxGkt5pjqBiUI1TWuuOMmyt6njs33jNFPuQgpcx2hrj4Qv2rHPKJtoNLF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 6799 invoked by uid 109); 7 Mar 2024 09:14:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Mar 2024 09:14:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12498 invoked by uid 111); 7 Mar 2024 09:14:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Mar 2024 04:14:13 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Mar 2024 04:14:07 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Manlio Perillo <manlio.perillo@gmail.com>
Subject: [PATCH 0/15] allow multi-byte core.commentChar
Message-ID: <20240307091407.GA2072522@coredump.intra.peff.net>
References: <CAAToxAEE-2B_8Wqrquk1peOnqTbOpV_8KZmsJ2dgk-mfCZXHiA@mail.gmail.com>
 <5e10f1e5-b87f-43cd-ac1e-d7c01b7dad21@app.fastmail.com>
 <xmqqsf1466eh.fsf@gitster.g>
 <52d6850914982ffaf15dda937d611ffb@manjaro.org>
 <xmqqmsrc4osm.fsf@gitster.g>
 <20240306080804.GB4099518@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240306080804.GB4099518@coredump.intra.peff.net>

On Wed, Mar 06, 2024 at 03:08:04AM -0500, Jeff King wrote:

> For a more readable series, I'd guess it would make sense to introduce
> comment_line_str as a separate variable (but continue to enforce the
> single-char rule), convert the easy cases en masse, the tricky cases one
> by one, and then finally drop comment_line_char entirely. At which point
> the config rules can be lifted to allow multi-byte strings.

I ended up cleaning this up. Like I said, this isn't something I'm
personally that interested in. But it just seemed like a wart that this
one spot could not handle multi-byte characters that all the cool kids
are using in their prompts etc these days.

Plus it was kind of an interesting puzzle for how to lay out the
refactoring to make each step self-consistent. At the very least, I
think the first couple of cleanups are worth it even if we do not see
the whole thing through. ;)

It obviously nullifies kh/doc-commentchar-is-a-byte, which is in 'next'.
Sadly "git merge" does not find a conflict with the documentation update
in patch 15, so we'll have to remember to pick up one topic or the
other.

I'm using U+00BB as my commentChar for now to see if any bugs show up,
but I expect I'll get sick of it after a few days.

  [01/15]: strbuf: simplify comment-handling in add_lines() helper
  [02/15]: strbuf: avoid static variables in strbuf_add_commented_lines()
  [03/15]: commit: refactor base-case of adjust_comment_line_char()
  [04/15]: strbuf: avoid shadowing global comment_line_char name

    These four are cleanups that could be taken independently.

  [05/15]: environment: store comment_line_char as a string

    This one preps us for incrementally moving code over to the new
    system.

  [06/15]: strbuf: accept a comment string for strbuf_stripspace()
  [07/15]: strbuf: accept a comment string for strbuf_commented_addf()
  [08/15]: strbuf: accept a comment string for strbuf_add_commented_lines()
  [09/15]: prefer comment_line_str to comment_line_char for printing
  [10/15]: find multi-byte comment chars in NUL-terminated strings
  [11/15]: find multi-byte comment chars in unterminated buffers
  [12/15]: sequencer: handle multi-byte comment characters when writing todo list
  [13/15]: wt-status: drop custom comment-char stringification

    These ones are the actual transition.

  [14/15]: environment: drop comment_line_char compatibility macro
  [15/15]: config: allow multi-byte core.commentChar

    And then we tie it off by dropping the now-unused bits and loosening
    the config logic.

 Documentation/config/core.txt |  4 ++-
 add-patch.c                   | 14 +++++-----
 builtin/branch.c              |  8 +++---
 builtin/commit.c              | 19 +++++++-------
 builtin/merge.c               | 12 ++++-----
 builtin/notes.c               | 10 ++++----
 builtin/rebase.c              |  2 +-
 builtin/stripspace.c          |  4 +--
 builtin/tag.c                 | 14 +++++-----
 commit.c                      |  3 ++-
 config.c                      |  6 ++---
 environment.c                 |  2 +-
 environment.h                 |  2 +-
 fmt-merge-msg.c               |  8 +++---
 rebase-interactive.c          | 10 ++++----
 sequencer.c                   | 48 ++++++++++++++++++-----------------
 strbuf.c                      | 47 ++++++++++++++++++----------------
 strbuf.h                      |  9 ++++---
 t/t0030-stripspace.sh         |  5 ++++
 t/t7507-commit-verbose.sh     | 10 ++++++++
 t/t7508-status.sh             |  4 ++-
 trailer.c                     |  6 ++---
 wt-status.c                   | 31 +++++++++-------------
 23 files changed, 149 insertions(+), 129 deletions(-)
