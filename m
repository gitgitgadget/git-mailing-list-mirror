Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36222201A0
	for <e@80x24.org>; Thu, 11 May 2017 21:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756998AbdEKVEY (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 17:04:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:49897 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750803AbdEKVEW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 17:04:22 -0400
Received: (qmail 18039 invoked by uid 109); 11 May 2017 21:04:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 21:04:21 +0000
Received: (qmail 18796 invoked by uid 111); 11 May 2017 21:04:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 17:04:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 May 2017 17:04:18 -0400
Date:   Thu, 11 May 2017 17:04:18 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Shawn Pearce <spearce@spearce.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] fetch-pack: always allow fetching of literal SHA1s
Message-ID: <20170511210418.crsv2lolwoofdv3i@sigill.intra.peff.net>
References: <20170509182042.28389-1-jonathantanmy@google.com>
 <20170509221629.3z35qcz36oiix3kh@sigill.intra.peff.net>
 <CAJo=hJvAg2WqpiuykpbHcB5vgQiHJ74CZ8Y4qudkYqZrmd30zg@mail.gmail.com>
 <20170510043343.mgb7heqzu2etcgvf@sigill.intra.peff.net>
 <20170510170044.GX28740@aiede.svl.corp.google.com>
 <20170511095925.grmyagv4hesxqprj@sigill.intra.peff.net>
 <20170511190354.GA12516@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170511190354.GA12516@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 12:03:54PM -0700, Jonathan Nieder wrote:

> > But even leaving all the refs/pull stuff aside, allowAnySHA1InWant does
> > seem to increase that confusion, and I don't see a way around it short
> > of never sharing objects between repositories at all. So I think at most
> > we'd do allowReachableSHA1InWant.
> 
> I had guessed you didn't want to do allowReachableSHA1InWant for
> performance reasons.  (I haven't checked to what extent we are already
> taking advantage of bitmaps to avoid a slow reachability check.)  If I
> was wrong and allowReachableSHA1InWant is on the table then it is of
> course even better. :)

Performance is definitely a consideration for resolving sha1's via the
website, because those can be any object, and you have to look in all
the trees. Traversing all the commits in linux.git is ~5s of CPU. Doing
the same for the whole object graph is more like ~45s.

Our experiments did involve bitmaps, but there are some corner cases
where we might not have good bitmap coverage of certain refs (I think
this is something that could be improved; the commit selection in the
current bitmap writer is fairly naive).

But I think upload-pack's reachability check only handles commits
anyway. Adding 5s of CPU to a request isn't great, but it's pretty easy
to convince Git to use 5s of CPU already. And this would only kick in
when the client asked for a non-tip ref anyway, and in general I'd
expect requested sha1's to be near the ref tips.

I'll open a discussion internally about enabling it and measuring the
performance.

-Peff
