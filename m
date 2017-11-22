Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC48E20A40
	for <e@80x24.org>; Wed, 22 Nov 2017 21:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751496AbdKVVhy (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 16:37:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:38018 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751477AbdKVVhy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 16:37:54 -0500
Received: (qmail 3488 invoked by uid 109); 22 Nov 2017 21:37:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Nov 2017 21:37:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4954 invoked by uid 111); 22 Nov 2017 21:38:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 22 Nov 2017 16:38:10 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Nov 2017 16:37:52 -0500
Date:   Wed, 22 Nov 2017 16:37:52 -0500
From:   Jeff King <peff@peff.net>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: Bisect marking new commits incorrectly
Message-ID: <20171122213751.GC2854@sigill>
References: <20171122143902.GO20681@dinwoodie.org>
 <CAP8UFD35-z9qA_m28EbpvN-X_HVcDvEirn69DJNESikJ=Txg7g@mail.gmail.com>
 <20171122170129.GS20681@dinwoodie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171122170129.GS20681@dinwoodie.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 22, 2017 at 05:01:29PM +0000, Adam Dinwoodie wrote:

> > So if you test a commit that git bisect asks you to test, and it
> > appears that this commit is "new", then you can just discard the
> > previous "new" commit because it will give you less information than
> > the new "new" one.
> > (The old "new" will not let you discard any commits that the new "new"
> > commit allows you to discard, because it is a descendant of the new
> > "new" commit.)
> > 
> > If you don't test the commit that git bisect asks you to test, then
> > git bisect assumes that you know better and discards the old "new".
> 
> Ah, that makes sense, thank you for the explanation.
> 
> In my case, I knew two commits were "new", but didn't know which would
> provide more information to the bisect algorithm; I'd assumed if I
> provided both, Git would work out the appropriate thing to do with the
> combined information without me needing to work it out.

Yeah, I really would have expected this to work, too. Should we be
taking the merge base of the set of "new" commits, and using that as the
true "new"?

I.e., with this graph:

  A--B--C--D
      \
       E--F

if I mark D and F as bad, can we assume that B, C, and E are "new", too,
and treat "B" as the new single "new"? That breaks down if the bug was
introduced independently on each branch, but I think bisect explicitly
doesn't handle such a case.

What might give it trouble is if there are multiple merge bases, like:


    G--H-----
   /      \  \
  A--B--C--D  \
      \        \
       E--------F

The flip to "new" could have been on the G-H branch, or in B.

So maybe that's not workable.

(I've never really dug into the bisect algorithm, and this is written
largely off the cuff, so I'm fine if the response is "nope, you have no
idea what you are talking about").

-Peff
