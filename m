Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6633C14A4CC
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 19:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773082882; cv=none; b=UkJNhFT8hGhDuUpgL2P1OAQ/3I6u5o9MLHRW9BtQbzVUsIFlGmRnDa9f7nb+D96BCNN1A/MUFz0ouOLo1+Qynk/yy5DYDI6oROT0q189lpFzJdk5Ka2DDuX+5gZH88FC6Y+fxXaA05n+/MrEUj94epAJQQ9W26zYdjR3hMit+gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773082882; c=relaxed/simple;
	bh=feWJtIYBthcWlOyEoQGZ+xI5XSufMPJ4okowmaen3gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQ83OpOVLMsHc7p6QPQQltK1nVh3NWWJ3QDSEzixf4srVQ4Gx4nlqnjjCyLV2Qi1qgRD/kET9cOm9+Kr1Ea7wnHIwv9uhBQuwttj9qSXq0CcGOihzBfxbfG5AAsSpxjH6GKGBdpOAvSTNApr9TvxUPqBiPqfJVGwGb3Na2Uvy9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ap4hFJ1L; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ap4hFJ1L"
Received: (qmail 49635 invoked by uid 106); 9 Mar 2026 19:01:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=feWJtIYBthcWlOyEoQGZ+xI5XSufMPJ4okowmaen3gk=; b=Ap4hFJ1Lf2kJ6r0rbLC9IrFfGh2KzNMrjnTrSKsMiTISZ7UQywK/WzHqZxGC5b7j8MqMwxwNVV5pbDMb8fiktVEFfv/iQkZb3ZLkYY9E4RRzqKfWi3pLpnWyBGSPukidqnj0mwARXRGPsFTi8i7k3RTuAkYcYgrS8Jkkmlcm9UTnZz69aOYqIMap8ALSKEye0JSGIn6oa0tSVQIApyRiWKGch4nFb60WkMKm6B0Jh0Kiwe0D7ZE9sRsWPAhGlbPDprUME4a3sFUITDbWNh1G2d8o+x4rZ3DqIibz09indkzO9YjhB4R4L3ccTz3kVOiRzuq9WIwkQ8SAUG6MjJQL5A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Mar 2026 19:01:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 458023 invoked by uid 111); 9 Mar 2026 19:01:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Mar 2026 15:01:14 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 9 Mar 2026 15:01:12 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Deveshi Dwivedi <deveshigurgaon@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v1 2/2] list-objects-filter-options: avoid
 strbuf_split_str()
Message-ID: <20260309190112.GA309867@coredump.intra.peff.net>
References: <20260308180359.31188-1-deveshigurgaon@gmail.com>
 <20260308180359.31188-3-deveshigurgaon@gmail.com>
 <xmqqjyvl57yv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjyvl57yv.fsf@gitster.g>

On Mon, Mar 09, 2026 at 08:38:16AM -0700, Junio C Hamano wrote:

> > +	while (*p && !result) {
> > +		const char *sep = strchr(p, '+');
> > +		size_t len = sep ? (size_t)(sep - p + 1) : strlen(p);
> > +		char *sub = xmemdupz(p, len);
> > +
> > +		/* strip '+' separator, but only when more sub-specs follow */
> > +		if (sep && *(sep + 1))
> > +			sub[len - 1] = '\0';
> > +
> > +		result = parse_combine_subfilter(filter_options, sub, errbuf);
> > +		free(sub);
> > +		if (!sep)
> > +			break;
> > +		p = sep + 1;
> >  	}
> 
> Hmph, would this loop handle a trailing '+' the same way as before,
> e.g., "combine:tree:2+"?  The original would have split the string
> into ["tree:2+", ""] and the last call to parse_combine_subfilter()
> would have been made with an empty string.  The new code does not
> make that last call with an empty string.  Perhaps the differences
> do not matter?  I dunno.

I think the original was wrong in its parsing. The first entry should be
"tree:2", without the trailing "+". And that would almost always result
in rejecting the string, because the "+" doesn't make any sense for most
filters. The exception is:

  blob=$(echo foo | git hash-object -w --stdin)
  git tag foo+ $blob
  git rev-list --filter=combine:sparse:oid=foo+

which happens to work. But it is wrong according to the documentation,
which says that "+" needs to be escaped if you want it passed along to
the sub-filter.

So flagging a trailing "+" as an error would probably be OK, and match
what happens now. But quietly ignoring it is perhaps friendlier (or less
friendly, if you think it might let a typo'd input go unnoticed).

-Peff
