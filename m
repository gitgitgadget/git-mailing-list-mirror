Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B78732B127
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 05:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784006924; cv=none; b=bxUkg5M5nbzKRNRI/Ge8Q8iZG9LXnnQhp57HmhRp5ssteTReC6w0YtTK/lxQ0IHHtE/RctsTNto9CxmVOB27R/VvH+FoAOX9DsZGF3uyi9S54z0LIsYgkdg9868fm9m9HPcYcc1ak6a2WbVK0ieRpxG68MltjSTlhFqabV0UggU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784006924; c=relaxed/simple;
	bh=Z4MgvCiG/BXA0YEP2UUv7Ha2sY2uD33EzsqyIP2nv4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qijy5i2W2vFKl4Mj7pavszcM7vxuxBwpvEsAyZMZHRuw0DhB7bt6TCi67KEcYV9UD4Bdliz0Hx1e4DHzdhiL38Ef+CqjGXur9LfaocJzO12gmioxG/UnbotnZD4hDVGchpDIWkOGYFgTVqNdqlw4RodFgV0ClRpzvun1g0FT5Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=I6FK0xb4; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="I6FK0xb4"
Received: (qmail 20995 invoked by uid 106); 14 Jul 2026 05:28:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Z4MgvCiG/BXA0YEP2UUv7Ha2sY2uD33EzsqyIP2nv4E=; b=I6FK0xb4zYNuy5w1o8VIH9LwvYi5GuY0raXNjXtyOBJNXvByRA8tx6asWMFxQMOR3Yj9t+cSTAjOhBzhYyI6DiPZ5eprUqpmg7IscPzPsv1tAWHMbM27nY8enl2Muapnh8baI3PUoLYG5yRhTgf3Prl9W2X7H57TtH9+9c0ljkAcy6B1UBcGQyRIlAwrQt4OwoIC0dv89DnqkFxWuvOCARokZ5wzZaJugMXA0alGQUl46H1+2fLOYXS/dffJAjiP2gC6MHYb0sBqJYrCIKLq4/hnUaxxpZvae6YH41DuiqSBAAZySEk3e57mthf9/FqXeQFDyWrLbewcaG2kJZgFLA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Jul 2026 05:28:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 41786 invoked by uid 111); 14 Jul 2026 05:28:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Jul 2026 01:28:37 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 14 Jul 2026 01:28:33 -0400
From: Jeff King <peff@peff.net>
To: Ted Nyman <tnyman@openai.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/2] http: use unique tempfiles for packfile URI downloads
Message-ID: <20260714052833.GA2516582@coredump.intra.peff.net>
References: <cover.1783982021.git.tnyman@openai.com>
 <alVn-QmK3K91_tkH@com-76773>
 <xmqqse5mv10a.fsf@gitster.g>
 <alWXwAGWgXSXoRJv@com-76773>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alWXwAGWgXSXoRJv@com-76773>

On Mon, Jul 13, 2026 at 06:58:24PM -0700, Ted Nyman wrote:

> > Are there better ways for these processes to coordinate with each
> > other? Instead of appending to the file, what if the second process
> > uses a predictable temporary name (which we already use) to open a
> > new file with O_CREAT | O_EXCL to avoid this redundant work?
> 
> Using the existing pack-<hash>.pack.temp name with O_CREAT | O_EXCL
> would prevent concurrent writes, but EEXIST alone would not
> distinguish an in-progress download from one left by an earlier
> failed or interrupted invocation. The existing .pack.temp name is not
> covered by the tmp_* pruning path, so simply waiting for it to
> disappear could leave a fetch stuck after a crash.

A few thoughts:

  - Using O_EXCL makes this essentially a lockfile. So we could apply
    the logic used elsewhere for lockfiles, like auto-removing files
    with ancient mtimes. Or we could even go all-in with a pid check for
    liveness; most of Git's lockfiles don't do that, but at least one
    does (the background auto-gc lock).

  - If we're not already using a name which is auto-cleaned during
    maintenance, we probably ought to be. Leaving aside concurrency
    issues, nobody would ever clean up the on-disk cruft.

    But of course the original code here is intentionally _not_ using a
    name we'd clean up, because it wants to be able to resume an
    interrupted transfer.  And you're explicitly breaking that for the
    packfile URI case.

    Is that a cost we're OK with paying? Fixing it opens up that same
    coordination can of worms. You have to tell the difference a
    concurrent writer and a previous dead one (whose work you can
    resume).

    It does feel weird that we'd do one thing for dumb-http and another
    for packfile URIs. Wouldn't they suffer from the same concurrency
    and resumption problems?

> The unique tempfile preserves the existing "download, index, then
> install" behavior for each invocation and fixes both the
> concurrent-append and EOF-resume failures. Avoiding the duplicate
> transfer would be useful for large packs, but I would prefer to keep
> that as a follow-up unless you think it is necessary for this
> correctness fix.

If we're OK with killing the ability to resume, then yeah, I think it
would make sense to start simple and un-break things. And then put a
coordination layer on top later (or never if nobody cares enough).

-Peff
