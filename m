Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B51F220193
	for <e@80x24.org>; Sat,  3 Sep 2016 02:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753342AbcICCRm (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 22:17:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:37343 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753260AbcICCRj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 22:17:39 -0400
Received: (qmail 11807 invoked by uid 109); 3 Sep 2016 02:17:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 03 Sep 2016 02:17:38 +0000
Received: (qmail 30941 invoked by uid 111); 3 Sep 2016 02:17:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Sep 2016 22:17:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Sep 2016 22:17:35 -0400
Date:   Fri, 2 Sep 2016 22:17:35 -0400
From:   Jeff King <peff@peff.net>
To:     Shawn Pearce <spearce@spearce.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] connect: know that zero-ID is not a ref
Message-ID: <20160903021735.6powysozcgiuf6rg@sigill.intra.peff.net>
References: <cover.1472836026.git.jonathantanmy@google.com>
 <2bea354c6218a33db3972e42baa75676fdcbc598.1472836026.git.jonathantanmy@google.com>
 <20160902201321.35egsg5l6r2fvrtw@sigill.intra.peff.net>
 <CAJo=hJtg1h1Zvu-TjMtDYVjPB2n0pihA18q3sHBPQ_ZA4dWRKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJo=hJtg1h1Zvu-TjMtDYVjPB2n0pihA18q3sHBPQ_ZA4dWRKg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 02, 2016 at 07:03:30PM -0700, Shawn Pearce wrote:

> > Is it useful for upload-pack? If we have no refs, there's traditionally
> > been nothing to fetch. Perhaps that's something that could change,
> > though. For example, there could be a capability to allow fetching
> > arbitrary sha1s (we have allowTIPSH1InWant and allowReachableSHA1InWant,
> > which obviously both require some refs, but allowArbitrarySHA1 does not
> > seem outside the realm of possibility).
> 
> Its exactly these sort of extra capabilities. We run JGit in modes
> where "out of band" (e.g. URL or higher level protocol framing like an
> undocumented HTTP header) allows the fetch-pack client to say "do not
> send me advertisements, but I want to learn your capabilities". The
> fetch-pack client typically activates the allow-reachable-sha1-in-want
> feature and names specific SHA-1s it wants.

So it sounds like you _could_ enable this only in out-of-band mode,
without loss of functionality.

I don't particularly care either way (I do not run any JGit servers
myself), but if we do it in Git, I think that is the path we should go
for maximum compatibility (and then if we jump to protocol v2, we get to
shed all of the compatibility cruft).

> This allows the fetch-pack client to bypass a very large advertisement
> if it wants only a specific SHA-1 and doesn't care about the ref name
> its bound to, or reachable through.

Yep, definitely a useful thing.

> This is also perhaps a stepping stone towards "client speaks first".
> If we can later standardize an HTTP query parameter or extra HTTP
> header, the server may be able to avoid sending a lot of ref
> advertisements, but would still need to advertise capabilities.

Yes, but that is a big enough jump that we can design it to look like
whatever we want, not shoe-horning it into a pretend ref. Older clients
will be left behind either way, we will need a transition plan, etc.

-Peff
