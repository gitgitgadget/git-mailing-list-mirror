Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABD821F461
	for <e@80x24.org>; Thu, 22 Aug 2019 17:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389060AbfHVRKU (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 13:10:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:52654 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726524AbfHVRKU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 13:10:20 -0400
Received: (qmail 32676 invoked by uid 109); 22 Aug 2019 17:10:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Aug 2019 17:10:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22736 invoked by uid 111); 22 Aug 2019 17:11:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 Aug 2019 13:11:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 22 Aug 2019 13:10:18 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH] diff: skip GITLINK when lazy fetching missing objs
Message-ID: <20190822171018.GB26163@sigill.intra.peff.net>
References: <20190822041529.GA4347@sigill.intra.peff.net>
 <20190822162534.17365-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190822162534.17365-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 22, 2019 at 09:25:34AM -0700, Jonathan Tan wrote:

> > The batch fetch is purely an optimization, because we'd eventually fetch
> > the individual objects on demand. If the batch one fails, should we
> > continue with the operation? That leaves any error-handling for the
> > overall operation to the "real" code. And it would also mean that this
> > bug became an annoying error message,
> 
> On the one hand, if the batch fetch fails, then the individual
> prefetching would likely fail as well. But on the other hand, as you
> said below, we sometimes extraneously fetch objects, so making the batch
> fetch non-fatal might be a good idea too.

Yeah, I'd expect it to fail again on the individual fetch[1]. But then
we are leaving that code to handle the error as it sees fit, which might
not be to die(). Though TBH, the diff code is pretty eager to die() on
missing objects anyway.

Of course the die() we see in this case is not really in your new code
at all, but somewhere deep in the fetch stack. So there's probably a
fair bit of work in making a failed fetch a recoverable error in the
first place.

[1] You'd incur two attempts to fetch, which are expensive, but if
    we care about that it would be easy enough to keep an in-memory list
    of "I tried to fetch this once already and could not", and just
    quickly return failure on the second attempt.

-Peff
