Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AEE11F597
	for <e@80x24.org>; Tue, 24 Jul 2018 21:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388495AbeGXWXS (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 18:23:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:58316 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388466AbeGXWXS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 18:23:18 -0400
Received: (qmail 1341 invoked by uid 109); 24 Jul 2018 21:14:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Jul 2018 21:14:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1247 invoked by uid 111); 24 Jul 2018 21:14:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 24 Jul 2018 17:14:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jul 2018 17:14:56 -0400
Date:   Tue, 24 Jul 2018 17:14:56 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH 0/5] Add delta islands support
Message-ID: <20180724211455.GA17803@sigill.intra.peff.net>
References: <20180722054836.28935-1-chriscool@tuxfamily.org>
 <20180724101627.GC3578@sigill.intra.peff.net>
 <xmqqa7qgzh6c.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa7qgzh6c.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 24, 2018 at 10:18:03AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >    I think this is inherent in the scheme (we're losing some delta
> >    opportunities). But I think it's also made worse because the delta
> >    window gets clogged with candidates that are forbidden by the island
> >    config.
> 
> Hmph, and the reason why objects that do not even belong to the same
> island to be usable as a base are in the object list in the first
> place is...?

Because we are doing a "git repack -ad" here. So we are considering
_all_ of the objects, but avoiding making deltas between some of them.

During an actual fetch, the islands are not used at all (but the delta
relationships left on disk are important for letting us reuse those
deltas as-is).

> >    Repacking with a big --window helps (and doesn't take as long
> >    as it otherwise might because we can reject some object pairs based
> >    on islands before doing any computation on the content).
> 
> Ah, then yes, a large window with early culling based on the delta
> island criteria definitely sounds like the right solution to that
> problem.

I try to account for this somewhat by looking at islands in the sort we
do of the delta candidates.  But to be honest, I am not sure how much
sense that makes (but I did verify experimentally that it helps). Again,
this is one of the reasons I had not sent this previously: I am not at
all confident that it is doing the right thing in all places.

-Peff
