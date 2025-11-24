Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F522F747D
	for <git@vger.kernel.org>; Mon, 24 Nov 2025 22:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764023433; cv=none; b=HsNaR5KGhfHjO8aSSVnKWbhE2b7Dx78aR1oPvcm8ZcqQWONr7+q4AsZQq4haYxcl3ukW/zj7bJ1LXbKaM6KihZQ+yG+XS4gkw8mEk5QNtncxNIe3ZDRg9tZ7af3HE8RoGk9pGWYtYiF1SsshzcMbRgOljVR55HnelpyhvtP7Ja8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764023433; c=relaxed/simple;
	bh=Wm7o296pXVEfAJtvJh67X5COKx7rvdu/cR6sHuoQFFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDGGIdfrFv4EJzQHbYinHRZvTkR2quiyYW1qDO9HeaCPCtYTbloWWCjJeo4Ip1D1dIU3F77r0paCcLjHgHLLBkTPbwfJCO5uNB5D0jVOPSR2AuEhBQb7clmmO/1M5FQgjJX3NodK1kQoMFKUptT1C9TycD9UAI6++h/giiP6gkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TIj0ZPq8; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TIj0ZPq8"
Received: (qmail 91954 invoked by uid 109); 24 Nov 2025 22:30:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Wm7o296pXVEfAJtvJh67X5COKx7rvdu/cR6sHuoQFFA=; b=TIj0ZPq8zaDG+XN/1m1MAWibfMU+6A4qgzG9EcO985dPN8nETcU1iwp0xj6GGoDfXs9yYe+QwAdz7cb+DprGjbUnDdGdeYyd6qDzeWrCBKv6rTJnogTaFNwIgo+rYzaQBnmtAFQXbNOfSRoPOAtnQVtiQvi4/ibm0HHrJ0DTmgb6UNYbA0Zje9OOBWCbGKdnlvEyPKUw6dGHp/bOba1WKPBQf0U/sxHrvI9kYMuzn//JuUNWK+AcVLX89lveo8wIV/aIo29gnEyM0sa6fni2gvcuG7G5fUqRL9c0E3+RN9uCCUKVZnS9mszdJKoTWb88l59pnuMKTk1lg7UzHA98SA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Nov 2025 22:30:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 155875 invoked by uid 111); 24 Nov 2025 22:30:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Nov 2025 17:30:25 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 24 Nov 2025 17:30:23 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>, correctmost <cmlists@sent.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 4/9] cache-tree: avoid strtol() on non-string buffer
Message-ID: <20251124223023.GA2051672@coredump.intra.peff.net>
References: <20251118091127.GA4175601@coredump.intra.peff.net>
 <20251118091218.GD529192@coredump.intra.peff.net>
 <ca6d99cc-d05c-49fb-ab3c-d7668077d32b@gmail.com>
 <xmqqtsylz2xh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtsylz2xh.fsf@gitster.g>

On Sat, Nov 22, 2025 at 10:19:22PM -0800, Junio C Hamano wrote:

> We could try to be more careful, but it quickly became messy when I
> tried.  Here is an unfinished attempt of mine.

So yeah, I was hoping to avoid jumping into this rabbit hole of
messiness and just do the bare minimum to give us memory safety. But it
seems nobody is quite happy with the result. :(

Looking over what you wrote below, it seems pretty reasonable to me.
What do you consider unfinished in it? I'm wondering if we should swap
it into what my patch is doing (or do it on top if you prefer).

Another option is to scrap this approach entirely, and copy up until the
trailing newline into a separate buffer, NUL-terminate it, and parse
from that buffer. That feels a little dirty to me, but I suspect it is
pretty performant in practice, and it pushes all of the complexity back
onto strtol().

Another variant of that is: parse up to the trailing newline, making
sure it's there, and then leave the rest of the code as-is. We know that
strtol() will do the right thing in that case, but it does mean we
cannot use ASan's strict_string_checks (it would still yield a false
positive, because it does not know we've checked for the newline).

-Peff
