Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEE3311C2A
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 10:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784803590; cv=none; b=n+Yln6oGa7uLGe0+FZjXOF2QPhsioZe56M/oZCIoCwBLUjtvFTFXDYXQRS7FTJTGwqzdrEl+GKuAuGoR5oQE/k6lKCW5PPUNa5WEuC4+RsFsYhmhR+rc6pIJRDAmXyQ9TZrJ8qCQvZz2Tz5eTIIXyVRrgHPblZw8KTBUbfW1q+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784803590; c=relaxed/simple;
	bh=i3eDZlCKtywWjLiBsx2z0NiqfcLr4HLp8EsByP3U7WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0wVo3lyKfErSUxVy1PeKrslZERNjs1Ikn7wJ6fqIpOVUWbBvrwgK+SVb6jXIMnorqyTY/OPjDSVjaoBHZJEFfSLXORZZrH/JRBJOMCRlxqCebk17g7itzvPl+IDApe1nyG3a0xIN5OVHGxoWvnU4fykB5GyhrcwvCfo5Fia4rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ct+6dDJH; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ct+6dDJH"
Received: (qmail 24729 invoked by uid 106); 23 Jul 2026 10:46:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=i3eDZlCKtywWjLiBsx2z0NiqfcLr4HLp8EsByP3U7WQ=; b=ct+6dDJHRwvlFCDnu0JNaXJcEWMmAdnNSao3nJjqQiMIkhbuMO8+k+fTbaLjG+l+oK3URDjICdOeCA8fRv6lgnb8QAJ3zxDzkknX0YE0LaOVu4afL7jJKB5p6zI/nQ4NQXg64VcUPEtq/7WRsNYPB4w6pHfGEG9F3efBAi48drkDptNvvJW37cjebghmBjSNVBVBI7yEc7SCxjdxV5GoPYnF/mIlMWdZFkS1eNRG2azkTpdGwMpmlJYmF6uon4bxQPC4UzBWaytn4FCIbt620nbHfZe7DSt05vYS23HZ8rnkqCSCdow604Kd+bMwDdqdKyXO9Bg0vp4nsb3tfL5r/w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Jul 2026 10:46:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19990 invoked by uid 111); 23 Jul 2026 10:46:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Jul 2026 06:46:25 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 23 Jul 2026 06:46:25 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
	Wolfgang Kritzinger <wkritzinger@atlassian.com>,
	git@vger.kernel.org, jltobler@gmail.com
Subject: Re: Performance regression in connectivity check during receive-pack
 (git 2.54)
Message-ID: <20260723104625.GB604358@coredump.intra.peff.net>
References: <CAFXJcxvpKHoVDwE5mBOd=w-A5vPdUmehqr8SHLUD7qv1qB00rA@mail.gmail.com>
 <20260721035733.GA581473@coredump.intra.peff.net>
 <xmqqtsps76f1.fsf@gitster.g>
 <amCuLpT6vYzo1GF8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <amCuLpT6vYzo1GF8@pks.im>

On Wed, Jul 22, 2026 at 01:49:02PM +0200, Patrick Steinhardt wrote:

> Seeing that this is about the `tmp_objdir` case: one of the things that
> Justin and I wanted to work on anyway is that we want to stop modifying
> the list of sources during transactions in the first place. It always
> felt kind of gross that we're modifying the sources when creating a
> transaction, as the only reason that we do this for is so that the
> writes actually go to the temporary object directory instead of to the
> primary object source. And that doesn't make a lot of sense to begin
> with.
> 
> The alternative to this would be to instead have logic in functions like
> `odb_write()` that checks whether we have an active transaction or not.
> If so, the write would go into the transaction directly instead of going
> into the primary source, and consequently we wouldn't even have to
> modify the list of sources at all.

Yes, the swapping of the "regular" and "alternate" odbs for the
quarantine transaction is kind of hacky. But I don't think this is
something you can solve just via the odb API. The notion of which
sources to read/write from crosses process boundaries. In particular:

  1. We write using a separate index-pack process. It has to be told to
     write into the transaction area, not the regular odb.

  2. After receiving objects, we _do_ read them in order to do quality
     checks before admitting them to the repository. The connectivity
     check discussed here is one example. That happens in a separate
     rev-list process, though it in theory could be moved in-process.

     But we also run user-specified hooks, which may run arbitrary Git
     commands. Those hooks need to be given an environment where they
     can transparently read from both the quarantine area and the
     original odb.

So you'll have to communicate between processes both "write here, not
there" and "look at both here and there to read objects". And I suspect
the result is going to look a lot like the alternates juggling we are
doing today.

-Peff
