Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C17901F954
	for <e@80x24.org>; Tue, 21 Aug 2018 20:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbeHUXVq (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 19:21:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:50910 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726628AbeHUXVq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 19:21:46 -0400
Received: (qmail 9007 invoked by uid 109); 21 Aug 2018 20:00:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 21 Aug 2018 20:00:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26636 invoked by uid 111); 21 Aug 2018 20:00:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 21 Aug 2018 16:00:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Aug 2018 16:00:11 -0400
Date:   Tue, 21 Aug 2018 16:00:11 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/6] pack-objects: reuse on-disk deltas for thin "have"
 objects
Message-ID: <20180821200011.GD859@sigill.intra.peff.net>
References: <20180821184140.GA24165@sigill.intra.peff.net>
 <20180821190705.GF30764@sigill.intra.peff.net>
 <xmqqin438pze.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqin438pze.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 21, 2018 at 12:43:49PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > When we serve a fetch, we pass the "wants" and "haves" from
> > ...
> > This lets us limit the change primarily to the oe_delta()
> > and oe_set_delta_ext() functions. And as a bonus, most of
> > the rest of the code does not consider these dummy entries
> > at all, saving both runtime CPU and code complexity.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> 
> Sorry for commenting on something completely off-topic, but when
> applied with "git am -s", I get a resulting commit with 3 S-o-b (the
> above two, plus the one added by "-s"), with a blank line in between
> them.  I can understand the first blank line (the one between your
> two S-o-b), as the first S-o-b does not even appear to be part of
> the trailer block, but cannot explain why I get an extra one before
> the one added by "-s".  Puzzled...

Hmm. This case is most curious.

I don't normally have a S-o-b in my commits themselves, but in this case
I had done quite a bit of editing in my MUA while sending out the
patches, so I picked up the result for my local branch with a "git
reset --hard origin && git am ~/what-i-sent".

Then for sending v2, I did my usual "format-patch -s". For the first 5
patches, it worked fine, but for this one, it created the funny
duplicate, which should have been suppressed. So something about this
commit message seems to confuse our trailer-parsing code. And indeed,
running:

  git show -s --format='%(trailers)'

shows nothing, which explains the other behavior (we don't think there's
a trailer block, so we make a new one). I wonder if it gets confused by
the big block of perf results (which all start with "^%[0-9.]:").

-Peff
