Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FCB21F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 03:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbeJKKpl (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 06:45:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:36670 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726247AbeJKKpl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 06:45:41 -0400
Received: (qmail 24516 invoked by uid 109); 11 Oct 2018 03:20:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 11 Oct 2018 03:20:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25628 invoked by uid 111); 11 Oct 2018 03:19:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 10 Oct 2018 23:19:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Oct 2018 23:20:28 -0400
Date:   Wed, 10 Oct 2018 23:20:28 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PoC -- do not apply 3/3] test-tree-bitmap: replace ewah with
 custom rle encoding
Message-ID: <20181011032027.GC25067@sigill.intra.peff.net>
References: <20181009231250.GA19342@sigill.intra.peff.net>
 <20181009231441.GC23730@sigill.intra.peff.net>
 <xmqqr2gyobw4.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr2gyobw4.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 10, 2018 at 09:58:51AM +0900, Junio C Hamano wrote:

> > +static void bitmap_to_rle(struct strbuf *out, struct bitmap *bitmap)
> > +{
> > +	int curval = 0; /* count zeroes, then ones, then zeroes, etc */
> > +	size_t run = 0;
> > +	size_t word;
> > +	size_t orig_len = out->len;
> > +
> > +	for (word = 0; word < bitmap->word_alloc; word++) {
> > +		int bit;
> > +
> > +		for (bit = 0; bit < BITS_IN_EWORD; bit++) {
> > +			int val = !!(bitmap->words[word] & (((eword_t)1) << bit));
> > +			if (val == curval)
> > +				run++;
> > +			else {
> > +				strbuf_add_varint(out, run);
> > +				curval = 1 - curval; /* flip 0/1 */
> > +				run = 1;
> > +			}
> > +		}
> 
> OK.  I find it a bit disturbing to see that the loop knows a bit too
> much about how "struct bitmap" is implemented, but that is a complaint
> against the bitmap API, not this new user of the API.

Heh, again, this is not really meant to be production code. I'm not at
all happy about inventing a new compressed bitmap format here, and I'd
want to investigate the state of the art a bit more. In particular, the
worst case here is quite bad, and I wonder if there are formats that can
select the best encoding when writing a bitmap (naive RLE when it's
good, something else other times).

I also suspect part of why this does better is that other formats are
optimized less for our case. We really don't care about setting or
looking at a few bits part way through a bitmap. Our bitmaps are small
enough that we don't mind streaming through a whole one. It's just that
we have so _many_ of them that we want to be meticulous about wasted
bytes.

Whatever format we choose, I think it would become part of the bitmap.c
file, and internal details would be OK to access there. I just put it
here to keep the patch simple.

> We do not try to handle the case where bitmap has bits that is not
> multiple of BITS_IN_EWORD and instead pretend that size of such a
> bitmap can be rounded up, because we ignore trailing 0-bit anyway,
> and we know the "struct bitmap" would pad with 0-bit at the tail?

Right. We do not know the "real" number of zero bits at all. It's just
assumed that there are infinite zeroes trailing off the end (and this is
how "struct bitmap" works, since it is the one that does not bother to
keep a separate size pointer).

> > +	/*
> > +	 * ugh, varint does not seem to have a way to prevent reading past
> > +	 * the end of the buffer. We'll do a length check after each one,
> > +	 * so the worst case is bounded.
> > +	 */
> 
> Sorry about that :-).

:) We may want to address that. I know we did some hardening about
reading off the end of .pack and .idx files. But it seems like any user
of decode_varint() may read up to 16 bytes past the end of a buffer.

We seem to only use them for the $GIT_DIR/index, though. Anybody with a
"struct hashfile" result at least has a 20-byte trailer we can
accidentally read from. But I wouldn't be surprised if there's a way to
trick it in practice.

-Peff
