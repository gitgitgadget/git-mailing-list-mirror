Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72B6E1F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 14:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753129AbeGCOeT (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 10:34:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:57726 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752745AbeGCOeS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 10:34:18 -0400
Received: (qmail 20786 invoked by uid 109); 3 Jul 2018 14:34:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Jul 2018 14:34:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2205 invoked by uid 111); 3 Jul 2018 14:34:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 03 Jul 2018 10:34:18 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jul 2018 10:34:16 -0400
Date:   Tue, 3 Jul 2018 10:34:16 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jason@zx2c4.com,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] fsck: check skiplist for object in fsck_blob()
Message-ID: <20180703143416.GA23556@sigill.intra.peff.net>
References: <2fc2d53f-e193-2a2a-9f8f-b3e1d256d940@ramsayjones.plus.com>
 <20180628114912.GA12901@sigill.intra.peff.net>
 <0a18acbd-0124-1c92-0046-05b8b035dd28@ramsayjones.plus.com>
 <20180628174501.GC31766@sigill.intra.peff.net>
 <db7683ab-1025-d7bb-d0ce-fc4ee28681e1@ramsayjones.plus.com>
 <20180628220332.GA5128@sigill.intra.peff.net>
 <9162ed69-d245-8b2f-0dcc-3b345264b029@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9162ed69-d245-8b2f-0dcc-3b345264b029@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 29, 2018 at 02:10:59AM +0100, Ramsay Jones wrote:

> On 28/06/18 23:03, Jeff King wrote:
> > On Thu, Jun 28, 2018 at 07:53:27PM +0100, Ramsay Jones wrote:
> [snip]
> > Yes, it can go in quickly. But I'd prefer not to keep it in the long
> > term if it's literally doing nothing.
> 
> Hmm, I don't think you can say its doing nothing!
> 
>     "Yeah, this solution seems sensible. Given that we would
>      never report any error for that blob, there is no point
>      in even looking at it."
> 
> ... is no less true, with or without additional patches! ;-)

True that we don't even bother doing the parsing with your patch. But I
think I talked myself out of that part being a significant savings
elsewhere.

I guess it would be OK to leave it in. It just feels like it would be
vestigial after the rest of the patches.

> > I have some patches which I think solve your problem. They apply on
> > v2.18.0, but not on v2.17.1 (because they rely on Dscho's increased
> > passing of config_options in v2.18). Is that good enough?
> 
> Heh, I was also writing patches to address this tonight (but
> I was also watching the football, so I was somewhat behind you).
> My patches were not too dissimilar to yours, except I was aiming
> to allow even do_config_from_file() etc., to suppress errors.

I think this should work via do_config_from_file(). The thing it really
misses is that git_config_with_options() will not respect it, but the
handling of options there is already a bug (well, I don't think there's
anything triggerable either before or after my patches, but it feels
like a bug waiting to happen).

> Your patches were cleaner and more focused than mine. (Instead of
> turning die_on_error into an enum, I added an additional 'quiet'
> flag. When pushing the stack (eg. for include files), I had to
> copy the quiet flag from the parent struct, etc, ... ;-) ).

Yes, I think that's what you have to do pre-v2.18, where we don't pass
the options struct around.

> > Yes, it would include any syntax error. I also have a slight worry about
> > that, but nobody seems to have screamed _yet_. :)
> 
> Hmm, I don't think we can ignore this. :(

I'm not sure. This has been running on every push to GitHub for the past
6 weeks, and this is the first report. It's hard to say what that means,
and technically speaking of course this _is_ a regression.

There's a nearby thread of interest, too, which I cc'd you on:

  https://public-inbox.org/git/20180703070650.b3drk5a6kb4k4tnp@glandium.org/

> > Here are the patches I came up with.
> 
> Yes, I applied these locally and tested them. All OK here.
> 
> So, FWIW, Ack!
> 
> [I still think my original patch, with the 'to_be_skipped'
> function name changed to 'object_on_skiplist', should be
> the first patch of the series!]

Thanks. If we're going to do any loosening, I think we may want to
address that _first_, so it can go directly on top of the patches in
v2.17.1 (because it's a bigger issue than the stray message, IMHO).

-Peff
