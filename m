Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915E969974
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 08:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710230729; cv=none; b=VBmJxiE1kyv8ZCggSRiLHoDbhZIeA+EYM1pR2VCWwev6yR7zAn9HHmVpgjQzinownmSspu4NTHGnTERCpLxIuRulgN90Mg64Ld1Fdg2aid2Bma1XYkKWSwBqxwRxPyhdGLTwiawkT8kUviDhIhRVHFZJBJm7eDzRz6ZTIq/PGzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710230729; c=relaxed/simple;
	bh=SOCRCn6kJKC/gpb9ixlCKaFradSVxqIW0pQhlhqFb1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPDbNcUFnOYpCz2Ax4EfxNHFIAnMu4ESIUw7qWaG3we0RRIahVX74a99IYzdSpc11r7KADY5PzfaTrkcnpLYmVvE92839yBlGnauwB5k8q/uMOTwkIDyqv76cNTp4vttw5q5po1QRnoOAyWBc7HiKi756v/sdRxJ6QhJQrF4DZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15070 invoked by uid 109); 12 Mar 2024 08:05:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Mar 2024 08:05:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27518 invoked by uid 111); 12 Mar 2024 08:05:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Mar 2024 04:05:30 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 12 Mar 2024 04:05:25 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH 11/15] find multi-byte comment chars in unterminated
 buffers
Message-ID: <20240312080525.GB47852@coredump.intra.peff.net>
References: <20240307091407.GA2072522@coredump.intra.peff.net>
 <20240307092638.GK2080210@coredump.intra.peff.net>
 <3f823e48-572c-4e19-ab76-e6d7cab9461f@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f823e48-572c-4e19-ab76-e6d7cab9461f@web.de>

On Thu, Mar 07, 2024 at 08:42:22PM +0100, René Scharfe wrote:

> > Arguably starts_with() and this new function should both be inlined,
> > like we do for skip_prefix(), but I think that's out of scope for this
> > series.
> 
> Inlining would allow the compiler to unroll the loop for string
> constants.  I doubt it would do that for variables, as in the code
> below.
> 
> Inlining the strlen()+memcmp() version above might allow the compiler
> to push the strlen() call out of a loop.
> 
> Would any of that improve performance noticeably?  For the call sites
> below I doubt it.  But it would probably increase the object text size.

Good point. With non-constant prefixes in these cases, it probably
wouldn't buy much. There are a lot of other cases with actual string
constants. A compiler in theory could turn starts_with(str, "foo") into
a few instructions. But it's not even clear that it's in very many hot
paths. It would definitely be something we'd have to measure.

> > And it's possible I was simply too dumb to figure out xstrncmpz() here.
> > I'm waiting for René to show up and tell me how to do it. ;)
> 
> Nah, it's not a good fit, as it requires the two strings to have the
> same length.

Thanks for confirming I wasn't missing anything. :)

> > @@ -2562,7 +2562,7 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
> >  	/* left-trim */
> >  	bol += strspn(bol, " \t");
> >
> > -	if (bol == eol || *bol == '\r' || *bol == comment_line_char) {
> > +	if (bol == eol || *bol == '\r' || starts_with_mem(bol, eol - bol, comment_line_str)) {
> 
> If the strspn() call is safe (which it is, as the caller expects the
> string to be NUL-terminated) then you could use starts_with() here and
> avoid the length calculation.  But that would also match
> comment_line_str values that contain LF, which the _mem version does not
> and that's better.

I try not to read too much into the use of string functions on what
otherwise appears to be an unterminated buffer. While in Git it is quite
often terminated at allocation time (coming from a strbuf, etc) I feel
like I've fixed a number of out-of-bounds reads simply due to sloppy
practices. And even if something is correct today, it is easy for it to
change, since the assumption is made far away from allocation.

So I dunno. Like you said, fewer computations is fewer opportunity to
mess things up. I don't like the idea of introducing a new hand-grenade
that might blow up later, but maybe if it's right next to a strspn()
call that's already a problem, it's not materially making anything
worse.

> > +int starts_with_mem(const char *str, size_t len, const char *prefix)
> > +{
> > +	const char *end = str + len;
> > +	for (; ; str++, prefix++) {
> > +		if (!*prefix)
> > +			return 1;
> > +		else if (str == end || *str != *prefix)
> > +			return 0;
> > +	}
> > +}
> 
> So this checks whether a length-limited string has a prefix given as a
> NUL-terminated string.  I'd have called it mem_starts_with() and have
> expected starts_with_mem() to check a NUL-terminated string for a
> length-limited prefix (think !strncmp(str, prefix, prefixlen)).

I was going for consistency with skip_prefix_mem() and strip_suffix_mem().
To be fair, I probably also named those ones, but I think it's pretty
established. We've never needed the length-limited prefix variant yet,
so I don't know that we're squatting on anything too valuable.

> > @@ -882,7 +882,7 @@ static size_t find_trailer_block_start(const char *buf, size_t len)
> >
> >  	/* The first paragraph is the title and cannot be trailers */
> >  	for (s = buf; s < buf + len; s = next_line(s)) {
> > -		if (s[0] == comment_line_char)
> > +		if (starts_with_mem(s, buf + len - s, comment_line_str))
> >  			continue;
> >  		if (is_blank_line(s))
> 
> Another case where starts_with() would be safe to use, as
> is_blank_line() expects (and gets) a NUL-terminated string, but it would
> allow matching comment_line_str values that contain LF.

Hmm. Yes, it is a NUL-terminated string always, but the caller has told
us not to look past end_of_log_message(). I suspect that if there is no
newline in comment_line_str() it's probably impossible to go past "len"
(just because the end of the log surely ends with either a NUL or a
newline). But it feels iffy to me. I dunno.

-Peff
