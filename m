Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4152D1F462
	for <e@80x24.org>; Tue,  4 Jun 2019 20:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfFDUxu (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 16:53:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:46370 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726554AbfFDUxt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 16:53:49 -0400
Received: (qmail 24969 invoked by uid 109); 4 Jun 2019 20:53:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 04 Jun 2019 20:53:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18007 invoked by uid 111); 4 Jun 2019 20:54:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 04 Jun 2019 16:54:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Jun 2019 16:53:42 -0400
Date:   Tue, 4 Jun 2019 16:53:42 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Keegan Carruthers-Smith <keegan.csmith@gmail.com>,
        git@vger.kernel.org
Subject: Re: git archive generates tar with malformed pax extended attribute
Message-ID: <20190604205342.GA27861@sigill.intra.peff.net>
References: <20190524081337.GA9082@sigill.intra.peff.net>
 <b4aaff4b-eaf7-9eaf-063f-42c073078060@web.de>
 <20190528055805.GB7946@sigill.intra.peff.net>
 <5b312f6c-3375-66ba-efc7-931e4ddc4b11@web.de>
 <20190528190815.GA20499@sigill.intra.peff.net>
 <5f9ac691-4cb1-a15d-ca44-63fb64994d59@web.de>
 <20190529011744.GA22340@sigill.intra.peff.net>
 <24574d74-b6ca-6d36-759f-32cf26b36c3f@web.de>
 <20190530115554.GB31607@sigill.intra.peff.net>
 <c961d89d-db0b-597f-c183-81aa791c0987@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c961d89d-db0b-597f-c183-81aa791c0987@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 02, 2019 at 06:58:48PM +0200, René Scharfe wrote:

> > That sounds about right. It's basically every version of every tree that
> > has a symlink. Did it make a noticeable difference in timing? Indexing
> > the whole kernel history is already a horribly slow process. :)
> 
> Right, I didn't notice a difference -- no patience for watching that
> thing to the end.  But here are some numbers for v2.21.0 vs. master with
> the patch:
> 
> Benchmark #1: git fsck
>   Time (mean ± σ):     307.775 s ±  9.054 s    [User: 307.173 s, System: 0.448 s]
>   Range (min … max):   294.052 s … 322.931 s    10 runs
> 
> Benchmark #2: ~/src/git/git fsck
>   Time (mean ± σ):     319.754 s ±  2.255 s    [User: 318.927 s, System: 0.671 s]
>   Range (min … max):   316.376 s … 323.747 s    10 runs
> 
> Summary
>   'git fsck' ran
>     1.04 ± 0.03 times faster than '~/src/git/git fsck'

I guess that's about what I'd expect. The bulk of the time in most repos
will go to fscking the actual blobs, I'd think. But hitting each tree
twice really is noticeable.

> Seeing only a single CPU core being stressed for that long is a bit sad
> to see.  Checking individual objects should be relatively easy to
> parallelize, shouldn't it?

Yes. The fsck code is pretty old, and uses a very simple way of walking
over all of the packs. index-pack (which backs verify-pack these days)
is much smarter, and runs in parallel. It still takes a lock when doing
the actual fsck checks, but most of the time goes to the zlib inflation
and delta reconstruction.

There's some discussion in:

  https://public-inbox.org/git/20180816210657.GA9291@sigill.intra.peff.net/

and even some patches elsewhere in the thread here:

  https://public-inbox.org/git/20180902075528.GC18787@sigill.intra.peff.net/

and here:

  https://public-inbox.org/git/20180902085503.GA25391@sigill.intra.peff.net/

I think the big show-stopper there is how ugly it is to run the pack
verification in a separate process (and I suspect it is not just ugly
from a code point of view, but actively breaks index-pack because it
then relies on the set of objects seen during the first phase to do its
connectivity check).

So there would probably need to be some lib-ification work on index-pack
first, so that we could call it (at least in verification mode) multiple
times from inside fsck.

-Peff
