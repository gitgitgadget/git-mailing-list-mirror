Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C842D837B
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 22:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758321235; cv=none; b=rwb+o6W3Pg3ACQKrLANIL+z2irwOYi02HQDMzb35e19tB5cNBAWZthlYm+7dySZXHkGXWUejocgJWAYsN669WRYTMoPkDQNh6tA6aaziV7hvCdwg5uCKeOJYlsHBympLxTRP0BR7woGGdILEZviTmQI+9QWfPL1h/a0U7a39MOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758321235; c=relaxed/simple;
	bh=pwihqFodZ+w2apegVWRc9SJJemxkMWoL6GrFWnHdKjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvWTqO2EXdiFtK9O/2E0c0tvb/Aw2a/Ct+rUdG1gHnROgmHSaTqEOgtgfw0mVUEuamZBKyGWQq9mkM/eSjT9iKxwO3pBM9ksAWIGqfVjMdaYgsdkhZlWJ9cEsdURbT/OwDcd+KvgiUZmd7jj8gp9iImzeJpMZ6qZeYC/qVpcbP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Tms17G6i; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Tms17G6i"
Received: (qmail 134685 invoked by uid 109); 19 Sep 2025 22:33:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=pwihqFodZ+w2apegVWRc9SJJemxkMWoL6GrFWnHdKjg=; b=Tms17G6iSN4c5XIeZz/X3Ra2A4tKRRCkDhM2Tkven75tTZHC70/0p+kBAaA3MaFMBloA2QWmS7azeYjOg79aa4fafu9HKBEomFrBvM7Zb7SZyZH5ZwYJBCwTu3xAgxUpan6YLoJvt5LqiL1hGnmY96Y9MY0E9fqM972I9qUx9jIaW355ICQAPRzH7ctxUWkkqX7BlhSl4aJylaIeIVdMrmUAfScSfWooMpRR9y4pIwztbce8hcj+g7Y0hDUOWQ6axLj0Yaxv7l9JVWnjJrIxfmMJXRuKS4Ps0JIhiEx9oTj+qDM6rQBaI7E8n8vk8eKFb4jaadTi5ak5nRT8I/vuhg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Sep 2025 22:33:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 211235 invoked by uid 111); 19 Sep 2025 22:33:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Sep 2025 18:33:51 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 19 Sep 2025 18:33:51 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Lauri Niskanen <ape@ape3000.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/6] fixing double-frees and leaks via setup_revisions()
Message-ID: <20250919223351.GA3906184@coredump.intra.peff.net>
References: <CAMCKZdV+ASXAhYXaTdtB=7YZprCxFUjwEsqQP7i_ccOwx8Lo6Q@mail.gmail.com>
 <1321ff39-6f09-426a-aa75-939ef4e1ad93@app.fastmail.com>
 <xmqq4isy77qr.fsf@gitster.g>
 <xmqqldma5qha.fsf@gitster.g>
 <20250919172007.GA59895@coredump.intra.peff.net>
 <xmqqbjn65mxa.fsf@gitster.g>
 <20250919195626.GA2750626@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250919195626.GA2750626@coredump.intra.peff.net>

On Fri, Sep 19, 2025 at 03:56:26PM -0400, Jeff King wrote:

> > > But really, I do not know that we need to NULL the whole thing. We have
> > > given the caller the reduced argc. The only argv invariant we are
> > > violating is that argv[argc] should be NULL (or in this case,
> > > argv[left]). Anything after argv+left should be considered
> > > uninitialized. So just:
> > >
> > >   argv[left] = NULL;
> > >
> > > would be enough, I'd think.
> > 
> > Even when strvec was passed and more than one element was eaten
> > after parsing?  strvec_clear() goes by .nr not stopping at the first
> > NULL IIRC.
> 
> Yes, there is a big can of worms here. ;) It turns out that many spots
> with strvecs were relying on leaving these entries untouched, and so
> setting any of them to NULL causes leaks.
> 
> I think I've got it mostly worked out, but that's why I haven't sent
> patches yet. Stay tuned.

OK, here's what I've come up with. It passes the regular test suite, as
well as with LSan, ASan, and UBSan. There were definitely some ugly
gotchas in there.

It _almost_ makes me think that setup_revisions() should never munge
argv at all, and should just produce a separate strvec of unknown
options. That keeps the concerns separate, and the extra allocation cast
is trivial. But we'd have to modify every caller to handle the new world
order.

So anyway, here it is:

  [1/6]: stash: tell setup_revisions() to free our allocated strings

    This fixes a real (albeit tiny) leak.

  [2/6]: revision: manage memory ownership of argv in setup_revisions()

    This fixes the double-free that started us off, but also addresses
    the related leak issues that our earlier discussion had.

  [3/6]: revision: add wrapper to setup_revisions() from a strvec
  [4/6]: treewide: use setup_revisions_from_strvec() when we have a strvec
  [5/6]: treewide: pass strvecs around for setup_revisions_from_strvec()

    The rest of this is optional. These three introduce a convenience
    wrapper, which I do think makes the code a little shorter and
    eliminates a possible footgun. But AFAIK it's not actually fixing
    any bugs.

  [6/6]: revision: retain argv NULL invariant in setup_revisions()

    This one does the NULL thing we discussed earlier for all callers.
    It turned up some interesting gotchas! One is that without the
    wrapper from patches 3-5, it introduces leaks for strvec users which
    assume (correctly) that setup_revisions() will never munge their
    argv or need to free anything. And two, lots of callers pass a NULL
    argv to setup_revisions. Yikes.

 bisect.c                    |  5 +---
 builtin/describe.c          |  3 ++-
 builtin/pack-objects.c      |  6 ++---
 builtin/rebase.c            |  3 +--
 builtin/stash.c             |  4 +--
 builtin/submodule--helper.c | 10 ++------
 http-push.c                 |  2 +-
 remote.c                    |  5 +---
 revision.c                  | 49 ++++++++++++++++++++++++++++++++++---
 revision.h                  |  2 ++
 sequencer.c                 |  7 +++---
 sequencer.h                 |  4 +--
 shallow.c                   |  4 +--
 shallow.h                   |  4 +--
 submodule.c                 |  2 +-
 t/t3903-stash.sh            | 11 +++++++++
 upload-pack.c               |  7 +++---
 17 files changed, 86 insertions(+), 42 deletions(-)

-Peff
