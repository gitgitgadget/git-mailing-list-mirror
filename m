Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 502A21F597
	for <e@80x24.org>; Thu,  2 Aug 2018 16:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbeHBSWC (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 14:22:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:40454 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726725AbeHBSWC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 14:22:02 -0400
Received: (qmail 16381 invoked by uid 109); 2 Aug 2018 16:30:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 02 Aug 2018 16:30:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25297 invoked by uid 111); 2 Aug 2018 16:30:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 02 Aug 2018 12:30:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Aug 2018 12:30:08 -0400
Date:   Thu, 2 Aug 2018 12:30:08 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com
Subject: Re: [PATCH] transport: report refs only if transport does
Message-ID: <20180802163007.GA15984@sigill.intra.peff.net>
References: <20180731192415.GC3372@sigill.intra.peff.net>
 <20180731232343.184463-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180731232343.184463-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 31, 2018 at 04:23:43PM -0700, Jonathan Tan wrote:

> > > Because transport_fetch_refs() filters the refs sent to the transport,
> > > it cannot just report the transport's result directly, but first needs
> > > to readd the excluded refs, pretending that they are fetched. However,
> > > this results in a wrong result if the transport did not report the refs
> > > that they have fetched in "fetched_refs" - the excluded refs would be
> > > added and reported, presenting an incomplete picture to the caller.
> > 
> > This part leaves me confused. If we are not fetching them, then why do
> > we need to pretend that they are fetched?
> 
> The short answer is that we need:
>  (1) the complete list of refs that was passed to
>      transport_fetch_refs(),
>  (2) with shallow information (REF_STATUS_REJECT_SHALLOW set if
>      relevant), and
>  (3) with updated OIDs if ref-in-want was used.
> 
> The fetched_refs out param already fulfils (2) and (3), and this patch
> makes it fulfil (1). As for calling them fetched_refs, perhaps that is a
> misnomer, but they do appear in FETCH_HEAD even though they are not
> truly fetched.

Thanks for this explanation. It does make more sense to me now, and I
agree that a lot of my confusion was from calling it "fetched_refs" (and
the comment saying "reported as fetched, but not actually fetched").

> Which raises the question...if completeness is so important, why not
> reuse the input list of refs and document that transport_fetch_refs()
> can mutate the input list? You ask the same question below, so I'll put
> the answer after quoting your paragraph.
> [...]

Thanks, the answer here was enlightening as well.

I see you posted a patch to go back to mutating the list, and that seems
reasonable to me. I'm fine with a separate "out" list, too. Its purpose
and expectations just need to be reflected in the name (and possibly in
a comment).

-Peff
