Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0180AC4361B
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 19:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFBED22CB3
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 19:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388075AbgLDTxV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 14:53:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:51970 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387771AbgLDTxT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 14:53:19 -0500
Received: (qmail 32408 invoked by uid 109); 4 Dec 2020 19:52:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 04 Dec 2020 19:52:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14820 invoked by uid 111); 4 Dec 2020 19:52:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 04 Dec 2020 14:52:38 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 4 Dec 2020 14:52:38 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 6/9] oid-array: provide a for-loop iterator
Message-ID: <X8qThjY9GTf5QZ8k@coredump.intra.peff.net>
References: <X8qEg/KiAQDugPC0@coredump.intra.peff.net>
 <X8qFo+GJJTbaPV58@coredump.intra.peff.net>
 <X8qIaOe3aT1qr+es@nand.local>
 <X8qJ9yKVcGSw0bWx@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X8qJ9yKVcGSw0bWx@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 04, 2020 at 02:11:51PM -0500, Taylor Blau wrote:

> > Yeah, I think that a full-blown iterator type is overkill for this
> > purpose. Another possible approach could be a macro:
> >
> >   #define for_each_oid_array_unique(arr, i) \
> >     for (i = 0; (i) < (array)->nr; i = oid_array_for_each_unique((arr), i))
> >
> > but I don't think that's making anything more clear than
> > 'oid_array_for_each_unique' already is. So, I like the approach that you
> > took here.
> 
> Hmm. I take part of that back; it would simplify the caller in the eighth
> patch, which first wants to sort the list before iterating it (which is
> necessary, because we look at 'i = 0' before calling
> oid_array_for_each_unique()).
> 
> So this could look instead like:
> 
> #define for_each_oid_array_unique(arr, i) \
>     for (oid_array_sort(), i = 0; (i) < (array)->nr; i = oid_array_for_each_unique((arr), i))
> 
> Maybe a little too magical, who knows.

That was one of the many variants I wrote on the way here. But yeah, I
think it is better to avoid magic macros unless they are getting us a
lot. In the case of hashmap, there is a lot of magic needed to convert
the hashmap_entry field back into the parent struct pointer. But here,
we can get away with a pretty natural looking for-loop, so I think it's
worth keeping it simple.

-Peff
