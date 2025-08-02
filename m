Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0692EB10
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 18:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754160439; cv=none; b=Jd3hAkd+o/cjf6b0GQpW7naQ5yIz7TAmVWnOn3+iWTwJFRRQI9Zru61tCr/69dirn5m5L9MvBrJmhfUZ3WVbAb1UxPEHRuAk+YqVvvakGUsDCVflRRy3RWFqYpujlvOBTN9n3gbGfML0gBMWXXystAdLyvnFU1lQbn61F37LbUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754160439; c=relaxed/simple;
	bh=si9zMUubK7b7iq8aqA+tjMZYUoGl5Tcwf9IR27/66a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9Tugj0LFR2xIFgHTIbAFxPflhzmX5+7lLQpFufSIzuS9dB3//FY8+Qkzj4EFKNW5Z4c5PmlcsPabH7Qr3mLw+7TYd5ompq/GtD8bugSolKeSM0OaNy16mF8+KmFF2Z6uvUwKl53Vd6NyExmT8RPlRmKxj5+6+q96aiM0fwnsa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=B8DCudPC; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="B8DCudPC"
Received: (qmail 13708 invoked by uid 109); 2 Aug 2025 18:47:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=si9zMUubK7b7iq8aqA+tjMZYUoGl5Tcwf9IR27/66a8=; b=B8DCudPCRUxa3B/M6soJA48AhZzjOB53yk000wzFZ0vij/P8jig/wvC+q0FtxRvuH/kpUMexTjKVl6xk5dTsxu44S+zvd0S6vjWWldImIB5EJqmd7Sb+ppSCQmMxEHz/tt6cyq0augSmrZy9Kc9WOa7IztWBCaSyuIo4PzKXN+JuS4dEV5jOPxbIf9rX8+SXRKkrXyRRuFnhmlRum2rID6urfJQpLf2UxrJL79QzMpyluAipV/iOzmjxhe/zpji6fhbv6lMw8XUYF0txFaeQVApXCRsYY8VVviEk2q7jXHFOX3/F4nN9bfKpPyCZC143/yz2/FDKqpjfn/T+MajMqg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 02 Aug 2025 18:47:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19324 invoked by uid 111); 2 Aug 2025 18:47:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 02 Aug 2025 14:47:17 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 2 Aug 2025 14:47:15 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 00/11] do not overuse strbuf_split*()
Message-ID: <20250802184715.GD1773585@coredump.intra.peff.net>
References: <20250731074154.2835370-1-gitster@pobox.com>
 <20250731225433.4028872-1-gitster@pobox.com>
 <20250802090825.GE3711639@coredump.intra.peff.net>
 <xmqq4iupira0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4iupira0.fsf@gitster.g>

On Sat, Aug 02, 2025 at 10:09:59AM -0700, Junio C Hamano wrote:

> >   2. Is the handling of repeated delimiters the same? E.g., if I split
> >      on "/" and we see "foo//bar", do both split implementations yield
> >      the same output. I could see either of ("foo", "", "bar") and
> >      ("foo", "bar") being produced.
> 
> Same between?  strbuf_split*() seems to be happy to produce an empty
> piece in the result (and there is no "omit empty ones" feature).
> You can choose with STRING_LIST_SPLIT_NOEMPTY both results, but for
> a straight conversion, the vanilla one without that flag would do
> what we want, I think.

Yeah, I meant same between strbuf_split and string_list_split. I didn't
actually peek into the behavior of either. It was more of a "did you
check this it?" question. It sounds like you did. Good.

> > Some of these sites do strbuf_rtrim() on the split pieces. But
> > STRING_LIST_SPLIT_TRIM does both left and right. Is this OK? I think so
> > because in both cases we are already splitting on space, so we wouldn't
> > expect left-hand spaces (of course you could have a stray tab or
> > something, but I suspect the new code matches the intent more closely).
> 
> I did wonder about these "rtrim-only" callsites strbuf_split(), but
> I did not think they needed ltrim, since they were splitting at SP
> and rejected when the element were empty (remember, strbuf_split()
> happily creates an empty element in the result).
> 
> Their use of rtrim() is primarily when they split at SP they want to
> remove that SP (remember, another misdesign of strbuf_split() is
> that it leaves the delimiter itself at the end of each split piece).
> Both 05/11 step for merge-tree and 06/11 step for notes are good
> examples.

Makes sense. I did not even realize all of the horrible gotchas of
strbuf_split(). :)

> So in short, yes, the new code is being a bit more lenient (the
> original parsers were more strict and insisted on non-trimming
> behaviour).  We might consider tightening them by removing the
> STRING_LIST_SPLIT_TRIM bit to be more faithful to the original, but
> as you may have noticed, doing so would make it more strict at the
> right end.  The original that split at SP and then rtrimmed allowed
> trailing HT after the data to be removed, but I do not think it was
> part of the designed behaviour of the original anyway.  So I am
> inclined to say we should probably drop STRING_LIST_SPLIT_TRIM;
> nobody would scream.

Hmm, yeah, I see what you mean. The documentation for merge-tree is
quite vague about whether it is a single space or if multiple spaces are
allowed. I'd be inclined to leave it on the lenient side, since I don't
think there is any ambiguity.

The git-notes one does specifically say "SP", so anybody who would be
broken by losing the extra trim is already violating the docs. But
again, I'd be tempted to just err on the friendly side.

I doubt either case matters too much either way, though.

-Peff
