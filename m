Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E423D1F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 13:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754123AbdARNBG (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 08:01:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:40837 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754091AbdARNBG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 08:01:06 -0500
Received: (qmail 21027 invoked by uid 109); 18 Jan 2017 12:54:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Jan 2017 12:54:24 +0000
Received: (qmail 26997 invoked by uid 111); 18 Jan 2017 12:55:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Jan 2017 07:55:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jan 2017 07:54:22 -0500
Date:   Wed, 18 Jan 2017 07:54:22 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Andrew Arnott <Andrew.Arnott@microsoft.com>
Subject: Re: [PATCH 2/2] Be more careful when determining whether a remote
 was configured
Message-ID: <20170118125422.gi3ppqiqhyykk7iy@sigill.intra.peff.net>
References: <cover.1484687919.git.johannes.schindelin@gmx.de>
 <41c347f22c80e96c54db34baa739b6e37e268b61.1484687919.git.johannes.schindelin@gmx.de>
 <20170117214723.p5rni6wwggei366j@sigill.intra.peff.net>
 <alpine.DEB.2.20.1701181334040.3469@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1701181334040.3469@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2017 at 01:34:28PM +0100, Johannes Schindelin wrote:

> > > Let's fix this by telling Git that a remote is not configured unless any
> > > fetch/push URL or refspect is configured explicitly.
> > 
> > Hmm. Old versions of GitHub for Windows used to set fetch refspecs in
> > the system gitconfig, for a similar purpose to what you want to do with
> > remote.origin.prune.
> > 
> > I notice here that setting a refspec _does_ define a remote. Is there a
> > reason you drew the line there, and not at, say, whether it has a URL?
> 
> I want to err on the side of caution. That's why.

I guess I just don't see why changing the behavior with respect to
"prune" or "proxy" is any less conservative than changing the one for
"refspec". Both can make some real-world cases work, and both can cause
breakage in some possible real-world cases. If we are going to change
anything, it seems like we should at least aim for a simple and
consistent rule (since users have to know which keys can be put in
~/.gitconfig and which cannot).

I can think of one alternative approach that might be easier for users
to understand, and that we already use elsewhere (e.g., with "http.*"
config): have a set of "default" remote keys (e.g., just "remote.key")
that git falls back to when the remote.*.key isn't set. Then your use
case becomes something like:

  [remote]
  prune = true

That's not _exactly_ the same, as it applies to all remotes, not just
"origin" (other remotes can override it, but would need to do so
explicitly). But I have a suspicion that may actually be what users
want.

-Peff
