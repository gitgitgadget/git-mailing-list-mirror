Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 972291FBB0
	for <e@80x24.org>; Mon, 24 Oct 2016 13:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935393AbcJXNAT (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 09:00:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:33409 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934997AbcJXNAS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 09:00:18 -0400
Received: (qmail 4537 invoked by uid 109); 24 Oct 2016 13:00:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Oct 2016 13:00:17 +0000
Received: (qmail 23912 invoked by uid 111); 24 Oct 2016 13:00:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Oct 2016 09:00:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Oct 2016 09:00:15 -0400
Date:   Mon, 24 Oct 2016 09:00:15 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] hex: use unsigned index for ring buffer
Message-ID: <20161024130015.awlmgpfzixiy6wkb@sigill.intra.peff.net>
References: <ebf769d4-771f-499e-c7fc-f0377d8df18e@web.de>
 <20161023091146.p2kmqvgwxdf77dnn@sigill.intra.peff.net>
 <fb816dd5-8fb9-c6a6-2ec2-9ea4dddfdb26@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb816dd5-8fb9-c6a6-2ec2-9ea4dddfdb26@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 23, 2016 at 07:57:30PM +0200, René Scharfe wrote:

> > > Hard to trigger, but probably even harder to diagnose once someone
> > > somehow manages to do it on some uncommon architecture.
> > 
> > Indeed. If we are worried about overflow, we would also want to assume
> > that it wraps at a multiple of 4, but that is probably a sane
> > assumption.
> 
> Hmm, I can't think of a way to violate this assumption except with unsigned
> integers that are only a single bit wide.  That would be a weird machine.
> Are there other possibilities?

No, I don't think so. I don't recall offhand whether the C standard
allows integers that are not powers of 2. But if it does, and somebody
develops such a platform, I have very little sympathy.

My comment was mostly "this is the only other restriction I can think
of, and it is crazy".

> > You could also write the second line like:
> > 
> >   bufno %= ARRAY_SIZE(hexbuffer);
> > 
> > which is less magical (right now the set of buffers must be a power of
> > 2). I expect the compiler could turn that into a bitmask itself.
> 
> Expelling magic is a good idea.  And indeed, at least gcc, clang and icc on
> x86-64 are smart enough to use an AND instead of dividing
> (https://godbolt.org/g/rFPpzF).
> 
> But gcc also adds a sign extension (cltq/cdqe) if we store the truncated
> value, unlike the other two compilers.  I don't see why -- the bit mask
> operation enforces a value between 0 and 3 (inclusive) and the upper bits of
> eax are zeroed automatically, so the cltq is effectively a noop.
> 
> Using size_t gets us rid of the extra instruction and is the right type
> anyway.  It would suffice on its own, hmm..

Yeah, I had assumed you would also switch to some form of unsigned type
either way.

> > I'm fine with any of the options. I guess you'd want a similar patch for
> > find_unique_abbrev on top of jk/no-looking-at-dotgit-outside-repo.
> 
> Actually I'd want you to want to amend your series yourself. ;)  Maybe I can
> convince Coccinelle to handle that issue for us.

I thought that series was in "next" already, but I see it isn't yet. I'd
still wait until the sha1_to_hex() solution settles, and then copy it.

> And there's also path.c::get_pathname().  That's enough cases to justify
> adding a macro, I'd say:
> [...]
> +#define NEXT_RING_ITEM(array, index) \
> +	(array)[(index) = ((index) + 1) % ARRAY_SIZE(array)]
> +

I dunno. It hides a lot of magic without saving a lot of lines in the
caller, and the callers have to make sure "array" is an array and that
"index" is unsigned.

E.g., in this code:

> @@ -24,8 +24,8 @@ static struct strbuf *get_pathname(void)
>  	static struct strbuf pathname_array[4] = {
>  		STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
>  	};
> -	static int index;
> -	struct strbuf *sb = &pathname_array[3 & ++index];
> +	static size_t index;
> +	struct strbuf *sb = &NEXT_RING_ITEM(pathname_array, index);
>  	strbuf_reset(sb);
>  	return sb;
>  }

The truly ugly part is the repeated STRBUF_INIT. :)

I think it would be preferable to just fix it inline in each place.

-Peff
