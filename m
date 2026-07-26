Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA811DE4EF
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 07:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785051664; cv=none; b=lhdX+5MnQ7Ml6vMc2WXLFl7tq6QRaCCnyP+kvpa3cdMEo//qDarUrOtur00zD78M0kb8MhFHuQ2sZX9vSqBAHBj8etyzefipu1eJgQ1RV+Rp3+1rKvFVuH08gb9bDR7vpr77baurFzOE/QoOe1jBgKmdUqi+zNIwHuNjEG3EJM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785051664; c=relaxed/simple;
	bh=JX8DJTC0N/qXS96i3PAQZ3rC+GlXWQ/nvQhctfNhvzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLtMCHnCC5UhlKFTdbT8aspcYiEuh2+b3o1UjykypaOUqTNp5vQKDOG5uC7JAR6nRlJaBFmz26TdRaVkrt1zE9kan7ckNfcf8koUDn7gswVk3lOEQCwpcKZBUhbop9zXtAlCt8Kkk1J5qqRExA9vngj0w54CB7jJfJYVVJEpkes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WX8c+Oy3; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WX8c+Oy3"
Received: (qmail 56553 invoked by uid 106); 26 Jul 2026 07:41:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=JX8DJTC0N/qXS96i3PAQZ3rC+GlXWQ/nvQhctfNhvzw=; b=WX8c+Oy38bCmqhMyV5owc1g2QKURbG9j+Gaf8d1RG/fahUBL/NpQC2QfYdT3OuEkkeUZ69xj0qSTnxxitcuZP83O1z0a5scrssabR+Z+73pKv9yjFyHk/kEiRHSjTlckdpBzLI7ZeMYIQPyM5q+vedKUXUUnExTvZxVDgB/fmg3kLU43Skg8wuUNBOVR+7LOYqxt7puYxWMJsaIaBOwNX2xtJ7TTl7mIb4yeVBd6BiLkRyqpUeIGSaopliyyC+fKaQIuRz8+USPQuX9toMTWwHUspyaDl1gNEpgCTtw5g22Ln1qNk2KrWItYtD/wRjcEIRZ3+EgKrZjQDy7UM+ipCQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 26 Jul 2026 07:41:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 57341 invoked by uid 111); 26 Jul 2026 07:41:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 26 Jul 2026 03:41:05 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 26 Jul 2026 03:41:00 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: tnyman@openai.com, git@vger.kernel.org, haraldnordgren@gmail.com
Subject: Re: [PATCH] branch: avoid slow strvec Coccinelle matching
Message-ID: <20260726074100.GA2366012@coredump.intra.peff.net>
References: <20260724091152.27794-2-tnyman@openai.com>
 <20260724114948.GA825505@coredump.intra.peff.net>
 <xmqqpl0c8jml.fsf@gitster.g>
 <xmqqbjbw8icj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbjbw8icj.fsf@gitster.g>

On Fri, Jul 24, 2026 at 09:26:04AM -0700, Junio C Hamano wrote:

> > Ah, very good eyes.  It is a disease to try appeasing -Wsign-compare
> > without thinking, instead of questioning the value of the warning
> > first, and in this case there is no reason to try forcing the use of
> > size_t, even with the unnecessary casting.
> 
> Having said that, another fix might be to standardize the way we
> count the number of things in an array and update 'ref-filter.h' to
> use size_t in 'struct ref_array' as well.

Yes, I had the same thought.

I am generally in favor of using size_t for anything that counts
allocations. I'd also be fine with (and maybe even prefer) a type that
is a signed integer of the same magnitude as size_t, because loops, etc,
are often easier to reason about when "0 - 1" is actually less than 0,
and doesn't wrap. But we would need to define our own custom type for
that, since ssize_t isn't portable enough.

> It is not as though 2 billion refs are too few to satisfy our
> needs, and in general, the platform-natural int should be used to
> count things unless there is a compelling reason to deviate from
> that norm.  However, "somehow we ended up counting many things in
> size_t, so it is better to count everything using the same type"
> could serve as "the compelling reason" to make such a change.

Yeah, I think that consistency is nice.

My personal reason (and this is mostly re-hashing previous discussions)
is avoiding integer overflow attacks by making it impractical to
allocate sufficient memory.

If you had a repository with 3 billion refs, then I think right now "git
for-each-ref" would wrap and start using negative values. I _suspect_ it
would be caught when ALLOC_GROW() converts that negative into to a
size_t (yielding an impractical allocation), but I don't think it's
practical to try. I started feeding 2^31 refs into "update-ref --stdin"
and it was around 64GB of heap after only 160 million or so.

But in general, if the counters are all size_t or similar magnitude,
then any geometric growth pattern is going to require allocating some
significant portion of the whole address space before we hit the integer
overflow condition (and presumably such an allocation would fail).

-Peff
