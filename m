Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947BE1A6812
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 17:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773251152; cv=none; b=nTJDTIOgnIl/QL9O66XzFoI/ILgUisj7KLgKI0Duac+oIgkRJVrSyoDgToNmEjowP7c8wY8yjPrcifQXBZXlWyFYorOq+hVJaTYoTdNX/S+iwQDYj1g+EGdj1M1WLLyhxJqoeQLY8ngLzLUkeLEJp92PNHkaJYOz1Psccu8pLo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773251152; c=relaxed/simple;
	bh=uuK3IUnzkiTIGCIqHZPNsCtTYF7ARn228MWnKkhees8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVxS/rCmxHYbuYbxrx0Me+cxh+v0tbldunC0uwM4BO+wANjRBpLpslD/vF2i0cCfUp3f6bA/6v9MJ9H2M0a8z/hvRtsthJhSVep3ShEAVlb/sC4t6RvcrSVLJ2aCr95mb+Uu5LGidxycTM9P4uCPfFxyw+Sxs34RZhQsQAUGLBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WFj48wQX; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WFj48wQX"
Received: (qmail 78139 invoked by uid 106); 11 Mar 2026 17:45:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=uuK3IUnzkiTIGCIqHZPNsCtTYF7ARn228MWnKkhees8=; b=WFj48wQXySo3Sdy1JsKfzohm3md94dqnOd2rpa3eJHjbItwDKbgprOgH7VTaKvEl3/7ypMdn+1PstqU2m3Qyds5MeyYgxrfXBW/ZLzshY4DegAiJop37XksZfxNwpSzirDft43QnKVVWMGUbJ/1qC3ZY7hytFA1Qohc4W7LGq6sy2NarO9PnTTMSmR9bZqurMy+87RkGRCzfJBES50fpy7JcLoubEY4Ey4Jv6eaZ3MZ5sgZxYNlAaU1BdrZWRk6qZ1SP9HWSHwhnlzfGnJlLFcUPqgZnmtk7qFr1eSWGdpp01jDPkszKQzYa0miUZulDZEMaLXqz3Dmr1P+VymdH1g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Mar 2026 17:45:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 492725 invoked by uid 111); 11 Mar 2026 17:45:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Mar 2026 13:45:50 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 11 Mar 2026 13:45:48 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Deveshi Dwivedi <deveshigurgaon@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] list-objects-filter-options: avoid
 strbuf_split_str()
Message-ID: <20260311174548.GA1900488@coredump.intra.peff.net>
References: <20260311132041.12044-1-deveshigurgaon@gmail.com>
 <20260311132041.12044-3-deveshigurgaon@gmail.com>
 <xmqqo6kuqqje.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo6kuqqje.fsf@gitster.g>

On Wed, Mar 11, 2026 at 09:28:21AM -0700, Junio C Hamano wrote:

> > +	while (*p && !result) {
> > +		const char *end = strchrnul(p, '+');
> > +		char *sub = xmemdupz(p, end - p);
> > +
> > +		result = parse_combine_subfilter(filter_options, sub, errbuf);
> > +		free(sub);
> > +		if (!*end)
> > +			break;
> > +		p = end + 1;
> >  	}
> [...]
> It is curious what would happen when the input were "combine:foo++",
> though.  What happens is that the loop begins with p pointing at 'f'
> in the initial iteration, "end" points at the first '+', and a
> temporary copy of 'foo' is fed to parse_combine_subfilter(), and we
> move on to the second '+'.  Then the second iteration finds NUL
> after that '+' in "end", and we end up calling the helper function
> with a temporary copy of '+'; gently_parse_list_objects_fiter() will
> reject it as an invalid filter-spec.

I don't think this is quite right. After we skip the first "+" and "p"
points to the second one, then strchrnul() will find that second "+",
not NUL. And so we have a 0-length spec, and feed the empty string to
parse_combine_subfilter(), which complains.

It is the same behavior when we see "++" in the middle of the string.

> Logically, "foo+" would be a combination of "foo" and "" (an empty
> string) and we ignore the empty string, and "foo++" would be a
> combination of "foo", "" and "" (two empty strings), but we barf at
> the empty string if it appears in the middle.  And recall that "" we
> saw earlier at the beginning of this function was also triggered an
> error.
> 
> Admittedly the original wasn't much better.  It ignored an empty
> string in the middle (e.g., "foo++bar" would have fed 'foo', '', and
> 'bar' to parse_combine_subfilter() and an empty string would have
> become a no-op) but barfed at the trailing one "foo+".  This new
> implementation swaps where it barfs, complaining an empty string in
> the middle and ignoring an empty string at the end.
> 
> In any case, the error behaviour against an empty filter-spec feels
> a bit uneven.
> 
> Tightening to reject empty string in the middle may appear to
> existing users as a regression if they are using "combine:foo++bar"
> as they are forced to update it to lose the extra '+'.

But yeah, it is somewhat inconsistent that we complain about an empty
spec in the middle, but not at the end. If we were starting from
scratch, I'd probably forbid it everywhere. But since we allow it in
some cases now, it may be worth being more permissive.

It is easy to check in the loop, or even just teach the helper to make
empty specs a noop:

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 616c6c7faa..56e1c651f6 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -151,6 +151,9 @@ static int parse_combine_subfilter(
 	char *decoded;
 	int result;
 
+	if (!*subspec)
+		return 0;
+
 	ALLOC_GROW_BY(filter_options->sub, filter_options->sub_nr, 1,
 		      filter_options->sub_alloc);
 	list_objects_filter_init(&filter_options->sub[new_index]);

> By the way, instead of making a temporary copy and discarding it
> repeatedly in a loop, it might be cheaper to reuse an allocated
> temporary with the common pattern:
> 
> 	struct strbuf temp = STRBUF_INIT;
> 	while (... loop ...) {
> 		const char *end = ...;
> 		strbuf_reset(&temp);
> 		strbuf_add(&temp, p, end - p);
> 		... use temp.buf ...
> 	}
> 	strbuf_release(&temp);
> 
> because _reset() only resets the len member of the strbuf without
> releasing the resource, if the next piece of memory you need a
> temporary copy for is shorter than the pieces you have ever used the
> strbuf for, you can make the copy without a new allocation.

As a general strategy, I agree this is a good one. But I'd be quite
surprised if it ever made a measurable difference for this loop, which
we'd expect to trigger a handful of times (and which allocates in the
sub-function anyway).

-Peff
