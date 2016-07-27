Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9BCB203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 18:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757512AbcG0SLx (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 14:11:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:49969 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757439AbcG0SLw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 14:11:52 -0400
Received: (qmail 955 invoked by uid 102); 27 Jul 2016 18:11:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jul 2016 14:11:51 -0400
Received: (qmail 19028 invoked by uid 107); 27 Jul 2016 18:12:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jul 2016 14:12:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jul 2016 14:11:48 -0400
Date:	Wed, 27 Jul 2016 14:11:48 -0400
From:	Jeff King <peff@peff.net>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>, gitster@pobox.com,
	jnareb@gmail.com, tboegi@web.de, mlbright@gmail.com,
	remi.galan-alfonso@ensimag.grenoble-inp.fr, pclouds@gmail.com,
	e@80x24.org, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v2 5/5] convert: add filter.<driver>.process option
Message-ID: <20160727181148.GC32219@sigill.intra.peff.net>
References: <20160722154900.19477-1-larsxschneider@gmail.com>
 <20160727000605.49982-1-larsxschneider@gmail.com>
 <20160727000605.49982-6-larsxschneider@gmail.com>
 <20160727013251.GA12159@sigill.intra.peff.net>
 <5FE50D2C-5D97-4523-9BE2-88745B3F83EA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5FE50D2C-5D97-4523-9BE2-88745B3F83EA@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 27, 2016 at 07:31:26PM +0200, Lars Schneider wrote:

> >> +	strbuf_grow(sb, size + 1);	// we need one extra byte for the packet flush
> > 
> > What happens if size is the maximum for size_t here (i.e., 4GB-1 on a
> > 32-bit system)?
> 
> Would that be an acceptable solution?
> 
> if (size + 1 > SIZE_MAX)
> 	return die("unrepresentable length for filter buffer");

No, because by definition "size" will wrap to 0. :)

You have to do:

  if (size > SIZE_MAX - 1)
	die("whoops");

> Can you point me to an example in the Git source how this kind of thing should
> be handled?

The strbuf code itself checks for overflows. So you could do:

  strbuf_grow(sb, size);
  ... fill up with size bytes ...
  strbuf_addch(sb, ...); /* extra byte for whatever */

That does mean _possibly_ making a second allocation just to add the
extra byte, but in practice it's not likely (unless the input exactly
matches the strbuf's growth pattern).

If you want to do it yourself, I think:

  strbuf_grow(sb, st_add(size, 1));

would work.

> >> +	while (
> >> +		bytes_read > 0 && 					// the last packet was no flush
> >> +		sb->len - total_bytes_read - 1 > 0 	// we still have space left in the buffer
> >> +	);
> > 
> > And I'm not sure if you need to distinguish between "0" and "-1" when
> > checking byte_read here.
> 
> We want to finish reading in both cases, no?

If we get "-1", that's from an unexpected EOF during the packet_read(),
because you set GENTLE_ON_EOF. So there's nothing left to read, and we
should break and return an error.

I guess "0" would come from a flush packet? Why would the filter send
back a flush packet (unless you were using them to signal end-of-input,
but then why does the filter have to send back the number of bytes ahead
of time?).

> > Why 8K? The pkt-line format naturally restricts us to just under 64K, so
> > why not take advantage of that and minimize the framing overhead for
> > large data?
> 
> I took inspiration from here for 8K MAX_IO_SIZE:
> https://github.com/git/git/blob/master/copy.c#L6
> 
> Is this read limit correct? Should I read 8 times to fill a pkt-line?

MAX_IO_SIZE is generally 8 _megabytes_, not 8K. The loop in copy.c just
haad to pick an arbitrary size for doing its read/write proxying.  I
think in practice you are not likely to get much benefit from going
beyond 8K or so there, just because operating systems tend to do things
in page-sizes anyway, which are usually 4K.

But since you are formatting the result into a form that has framing
overhead, anything up to LARGE_PACKET_MAX will see benefits (though
admittedly even 4 bytes per 8K is not much).

I don't think it's worth the complexity of reading 8 times, but just
using a buffer size of LARGE_PACKET_MAX-4 would be the most efficient.

I doubt it matters _that much_ in practice, but any time I see a magic
number I have to wonder at the "why". At least basing it on
LARGE_PACKET_MAX has some basis, whereas 8K is largely just made-up. :)

> > We do sometimes do "ret |= something()" but that is in cases where
> > "ret" is zero for success, and non-zero (usually -1) otherwise. Perhaps
> > your function's error-reporting is inverted from our usual style?
> 
> I thought it makes the code easier to read and the filter doesn't care
> at what point the error happens anyways. The filter either succeeds
> or fails. What style would you suggest?

I think that's orthogonal. I just mean that using zero for success puts
you in our usual style, and then accumulating errors can be done with
"|=".

I didn't look carefully at whether the accumulating style you're using
makes sense or not. But something like:

> >> +		ret &= write_in_full(out, &header, sizeof(header)) == sizeof(header);
> >> +		ret &= write_in_full(out, src, bytes_to_write) == bytes_to_write;

does mean that we call the second write() even if the first one failed.
That's a waste of time (albeit a minor one), but it also means you could
potentially cover up the value of "errno" from the first one (though in
practice I'd expect the second one to fail for the same reason).

-Peff
