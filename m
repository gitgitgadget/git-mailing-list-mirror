Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9594320133
	for <e@80x24.org>; Fri,  3 Mar 2017 20:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbdCCUFx (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 15:05:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:38267 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751593AbdCCUFw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 15:05:52 -0500
Received: (qmail 31693 invoked by uid 109); 3 Mar 2017 11:04:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 11:04:50 +0000
Received: (qmail 27086 invoked by uid 111); 3 Mar 2017 11:04:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 06:04:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Mar 2017 06:04:48 -0500
Date:   Fri, 3 Mar 2017 06:04:48 -0500
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
Message-ID: <20170303110448.se3bstlk5hr4hqv3@sigill.intra.peff.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <22704.19873.860148.22472@chiark.greenend.org.uk>
 <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com>
 <20170224233929.p2yckbc6ksyox5nu@sigill.intra.peff.net>
 <CA+55aFw6BLjPK-F0RGd9LT7X5xosKOXOxuhmKX65ZHn09r1xow@mail.gmail.com>
 <CA+55aFwXaSAMF41Dz3u3nS+2S24umdUFv0+k+s18UyPoj+v31g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFwXaSAMF41Dz3u3nS+2S24umdUFv0+k+s18UyPoj+v31g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 02, 2017 at 11:55:45AM -0800, Linus Torvalds wrote:

> Anyway, I do have a suggestion for what the "object version" would be,
> but I'm not even going to mention it, because I want people to first
> think about the _concept_ and not the implementation.
> 
> So: What do you think about the concept?

I think it very much depends on what's in the "object version". :)

IMHO, we are best to consider sha1 "broken" and not count on any of its
bytes for cryptographic integrity. I know that's not really the case,
but it just makes reasoning about the whole thing simpler. So at that
point, it's pretty obvious that the "object version" is really just "an
integrity hash".

And that takes us full circle to earlier proposals over the years to do
something like this in the commit header:

  parent ...some sha1...
  parent-sha256 ...some sha256...

and ditto in tag headers, and trees obviously need to be hackily
extended as you described to carry the extra hash. And then internally
we continue to happily use sha1s, except you can check the
sha256-validity of any reference if you feel like it.

This is functionally equivalent to "just start using sha-256, but keep a
mapping of old sha1s to sha-256s to handle old references". The
advantage is that it makes the code part of the transition simpler. The
disadvantage is that you're effectively carrying a piece of that
sha1->sha256 mapping around in _every_ object.

And that means the same bits of mapping data are repeated over and over.
Git's pretty good at de-duplicating on the surface. So yeah, every tree
entry is now 256 bits larger, but deltas mean that we usually only end
up storing each entry a handful of times. But we still pay the price to
walk over the bytes every time we apply a delta, zlib inflate, parse the
tree, etc. The runtime cost of the transition is carried forward
forever, even for repositories that are willing to rewrite history, or
are created after the flag day.

So I dunno. Maybe I am missing something really clever about your
proposal. Reading the rest of the thread, it sounds like you had a
thought that we could get by with a very tiny object version, but the
hash-adding thing nixed that. If I'm still missing the point, please try
to sketch it out a bit more concretely, and I'll come back with my
thinking cap on.

-Peff
