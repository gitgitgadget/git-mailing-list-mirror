Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E1A31F453
	for <e@80x24.org>; Thu, 24 Jan 2019 19:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbfAXTL1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 14:11:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:47748 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725909AbfAXTL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 14:11:26 -0500
Received: (qmail 9921 invoked by uid 109); 24 Jan 2019 19:11:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Jan 2019 19:11:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31325 invoked by uid 111); 24 Jan 2019 19:11:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 24 Jan 2019 14:11:31 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2019 14:11:24 -0500
Date:   Thu, 24 Jan 2019 14:11:24 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, David Turner <novalis@novalis.org>
Subject: Re: [PATCH 2/6] diff: clear emitted_symbols flag after use
Message-ID: <20190124191124.GB29828@sigill.intra.peff.net>
References: <20190124122603.GA10415@sigill.intra.peff.net>
 <20190124123240.GB11354@sigill.intra.peff.net>
 <CAGZ79kbHLvN252v-gNbcpsyGg8pZ9GPBtyZquX50HwhtYep5oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbHLvN252v-gNbcpsyGg8pZ9GPBtyZquX50HwhtYep5oA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 24, 2019 at 10:55:10AM -0800, Stefan Beller wrote:

> >      But where does that output go? Normally it goes directly to stdout,
> >      but because o->emitted_symbols is set, we queue it. As a result, we
> >      don't actually print the diffstat for the merge commit (yet),
> 
> Thanks for your analysis. As always a pleasant read.
> I understand and agree with what is written up to here remembering
> the code vaguely.
> 
> > which
> >      is wrong.
> 
> I disagree with this sentiment. If we remember to flush the queued output
> this is merely an inefficiency due to implementation details, but not wrong.
> 
> We could argue that it is wrong to have o->emitted_symbols set, as
> we know we don't need it for producing a diffstat only.

It's wrong in the sense that we finish printing that merge commit
without having shown its diff. If it were the final commit, we would not
ever print it at all!

So if you are arguing that it would be OK to queue it as long as we
flushed it before deciding we were done with the diff, then I agree. But
doing that correctly would actually be non-trivial, because the
combined-diff code does not use the emitted_symbols queue for its diff
(so the stat and the patch would appear out of order).

I also wondered why diffstats go to o->emitted_symbols at all. We do not
do any analysis of them with --color-moved, I don't think. But I can
also see that having emitted_symbols hold everything makes sense from a
maintainability standpoint; future features may want to see more of what
we're emitting.

> >   3. Next we compute the diff for C. We're actually showing a patch
> >      again, so we end up in diff_flush_patch_all_file_pairs(), but this
> >      time we have the queued stat from step 2 waiting in our struct.
> 
> Right, that is how the queueing can produce errors. I wonder if the
> test that is included in this patch would work on top of
> e6e045f803 ("diff.c: buffer all output if asked to", 2017-06-29)
> as that commit specifically wanted to make sure these errors
> would be caught.

I suspect that would not work with "--cc", because combine-diff outputs
directly stdout. That's something that we might want to improve in the
long run (since obviously it cannot use --color-moved at this point).

> > To fix it, we can simply restore o->emitted_symbols to NULL after
> > flushing it, so that it does not affect anything outside of
> > diff_flush_patch_all_file_pairs(). This intuitively makes sense, since
> > nobody outside of that function is going to bother flushing it, so we
> > would not want them to write to it either.
> 
> This would also cause the inefficiency I mentioned after (2) to disappear,
> as the merge commits diffstat would be just printed to stdout?

Yes, it avoids the overhead of even storing them in the emitted struct
at all.

> Reviewed-by: Stefan Beller <sbeller@google.com>

Thanks!

I did quite a bit of head-scratching figuring out this bug, but at the
end of it I now understand the flow of the color-moved code quite a bit
better. :)

-Peff
