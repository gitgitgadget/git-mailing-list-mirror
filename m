Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63FC21F597
	for <e@80x24.org>; Mon, 23 Jul 2018 21:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388145AbeGWWlC (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 18:41:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:56690 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388088AbeGWWlC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 18:41:02 -0400
Received: (qmail 12988 invoked by uid 109); 23 Jul 2018 21:37:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 23 Jul 2018 21:37:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21592 invoked by uid 111); 23 Jul 2018 21:37:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 23 Jul 2018 17:37:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jul 2018 17:37:52 -0400
Date:   Mon, 23 Jul 2018 17:37:52 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] pack-objects: fix performance issues on packing large
 deltas
Message-ID: <20180723213752.GB7870@sigill.intra.peff.net>
References: <20180718225110.17639-1-newren@gmail.com>
 <20180720153943.575-1-pclouds@gmail.com>
 <20180720174004.GA22486@sigill.intra.peff.net>
 <CACsJy8AcDqNtV1VfHB+ZD=wvOxRyhobacreaNpjSm3NcLCMKWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8AcDqNtV1VfHB+ZD=wvOxRyhobacreaNpjSm3NcLCMKWA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 21, 2018 at 06:23:32AM +0200, Duy Nguyen wrote:

> > I'm not sure I completely agree with this. While 4GB deltas should be
> > pretty rare, the nice thing about 64-bit is that you never have to even
> > think about whether the variable is large enough. I think the 2^32
> > limitations on Windows are something we should be fixing in the long
> > term (though there it is even worse because it is not just deltas, but
> > entire objects).
> 
> I guess that means we stick to uint64_t then? It does increase more
> memory on 32-bit architecture (and probably processing cost as well
> because 64-bit uses up 2 registers).

Yes, but if we switch away from an array to a hash, then we get the best
of both worlds: we are using 64-bits to store the size, but we only need
an entry for deltas that are actually big.

Then the common small-delta case remains efficient in both CPU and
memory, and we pay the costs only in proportion to the number of large
deltas (though the hash is a slightly higher cost for those large deltas
than an array).

> > This is new in this iteration. I guess this is to cover the case where
> > we are built with pthread support, but --threads=1?
> 
> If you mean the "lock_initialized" variable, not really. the other
> _lock() macros in builtin/ call pthread_mutex_lock() unconditionally,
> which is fine. But I feel a bit uncomfortable doing the same in
> pack-objects.h which technically is library code (but yes practically
> is a long arm of builtin/pack-objects.c), so lock_initialized is there
> to make sure we don't touch uninitialized locks if somebody forgets to
> init them first.

I think the ones in builtin/ check threads_active to avoid actually
locking. And that's set in init_thread(), which we do not call if we are
using a single thread. So I think this is basically doing the same
thing, but with a separate flag (since the library code does not know
about threads_active).

> > Your original patch had to copy the oe_* helpers into the file to handle
> > that. But I think we're essentially just locking the whole functions:
> 
> I'll try to avoid this lock when deltas are small and see if it helps
> the linux.git case on Elijah's machine. So we may end up locking just
> a part of these functions.

Yeah, I think my suggestion doesn't work once we start doing more
complex locking logic. Let's just forget it. I think the
"lock_initialized" thing is probably the right approach.

It might be worth getting rid of builtin/pack-objects.c's local
threads_active variable, and just using to_pack.threads_active. The two
flag would always want to match.

-Peff
