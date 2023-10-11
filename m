Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACA3CDB465
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 23:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbjJKXSp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 19:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbjJKXSo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 19:18:44 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C729D
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 16:18:42 -0700 (PDT)
Received: (qmail 20598 invoked by uid 109); 11 Oct 2023 23:18:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Oct 2023 23:18:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11277 invoked by uid 111); 11 Oct 2023 23:18:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Oct 2023 19:18:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Oct 2023 19:18:40 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 10/20] midx: bounds-check large offset chunk
Message-ID: <20231011231840.GK518221@coredump.intra.peff.net>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
 <20231009210530.GJ3282181@coredump.intra.peff.net>
 <ZSbrj3hmm8H7ce2l@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZSbrj3hmm8H7ce2l@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 11, 2023 at 02:38:07PM -0400, Taylor Blau wrote:

> >  		offset32 ^= MIDX_LARGE_OFFSET_NEEDED;
> > -		return get_be64(m->chunk_large_offsets +
> > -				st_mult(sizeof(uint64_t), offset32));
> > +		if (offset32 >= m->chunk_large_offsets_len / sizeof(uint64_t))
> > +			die(_("multi-pack-index large offset out of bounds"));
> > +		return get_be64(m->chunk_large_offsets + sizeof(uint64_t) * offset32);
> 
> Makes sense, and this seems very reasonable. I had a couple of thoughts
> on this hunk, one nitpick, and one non-nitpick ;-).
> 
> The nitpick is the easy one, which is that I typically think of scaling
> some index to produce an offset into some chunk, instead of dividing and
> going the other way.
> 
> So I probably would have written something like:
> 
>     if (st_mult(offset32, sizeof(uint64_t)) >= m->chunk_large_offsets_len)
>         die(_("multi-pack-index large offset out of bounds"));

Yeah, I admit that my inclination is to think of it that way, too, and
the division is a bit of an inversion. But I guess I am hard-wired to do
bounds checks with division, because I know it avoids overflow issues.
And the behavior is actually different, since st_mult() dies (with a
somewhat vague message) rather than returning with an error.

I was actually tempted to write a small inline helper to do
bounds-checks (since this pattern appears a few times in this series).
But of course it suffers from the same issues (it dies with a vague
message, or it returns a result code and then is awkward to call/use
because you have to stick the output in an out-parameter).

> But that is definitely a subjective/minor point, and I would not at all
> be sad if you felt differently about it. That said, I do wish for a
> little more information in the die() message, perhaps:
> 
>     if (st_mult(offset32, sizeof(uint64_t)) >= m->chunk_large_offsets_len)
>         die(_("multi-pack-index large offset for %s out of bounds "
>               "(%"PRIuMAX" is beyond %"PRIuMAX")"),
>             (uintmax_t)(offset32 * sizeof(uint64_t)), /* checked earlier */
>             (uintmax_t)m->chunk_large_offsets_len);
> 
> I can imagine that for debugging corrupt MIDXs in the future, having
> some extra information like the above would give us a better starting
> point than popping into a debugger to get the same information.

As you'll see when you get to the BDAT/BIDX messages, I put in a load of
detail. That's because I did those ones first, and then after seeing the
terse "eh, it's the wrong size" messages in the rest of the commit-graph
and midx code, I just followed suit.

We can circle back and improve the detail in the messages. One slightly
annoying thing is dealing with it in the tests. We'd have to do one of:

  - make the tests more brittle by hard-coding positions and offsets we
    don't necessarily care about

  - loosen the tests by just matching with "grep", which can sometimes
    miss other unexpected output

  - do some post-processing on the output to massage out the details we
    don't care about; this in theory is the best of both worlds, but
    reliably post-processing is non-trivial.

So of the three I'd probably just loosen to use "grep" in most spots.

-Peff
