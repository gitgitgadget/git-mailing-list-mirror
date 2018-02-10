Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B7351F404
	for <e@80x24.org>; Sat, 10 Feb 2018 12:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751092AbeBJMVe (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Feb 2018 07:21:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:48084 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750835AbeBJMVd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Feb 2018 07:21:33 -0500
Received: (qmail 24953 invoked by uid 109); 10 Feb 2018 12:21:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 10 Feb 2018 12:21:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30757 invoked by uid 111); 10 Feb 2018 12:22:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 10 Feb 2018 07:22:17 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Feb 2018 07:21:31 -0500
Date:   Sat, 10 Feb 2018 07:21:31 -0500
From:   Jeff King <peff@peff.net>
To:     Leo Gaspard <leo@gaspard.io>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Joey Hess <id@joeyh.name>, git@vger.kernel.org,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Fetch-hooks
Message-ID: <20180210122131.GB21843@sigill.intra.peff.net>
References: <c8d1eb4d-c3d2-5834-a46b-931e825315aa@gaspard.io>
 <20180208153040.GA5180@kitenet.net>
 <871af155-a159-2a29-2e48-74e7a98b60d4@gaspard.io>
 <87bmgzmbsk.fsf@evledraar.gmail.com>
 <fa470be4-75fb-76ed-ed93-5c10fcfb8842@gaspard.io>
 <87po5dbz1a.fsf@evledraar.gmail.com>
 <20180209223011.GA24578@sigill.intra.peff.net>
 <87e7c3b8-3b3c-1cb0-9b11-e4bf3044e539@gaspard.io>
 <20180210001317.GA26856@sigill.intra.peff.net>
 <3de8dec0-12c9-56e2-5902-97755f78ab50@gaspard.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3de8dec0-12c9-56e2-5902-97755f78ab50@gaspard.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 10, 2018 at 01:37:20AM +0100, Leo Gaspard wrote:

> > Yeah, tag-following may be a little tricky, because it usually wants to
> > write to refs/tags/. One workaround would be to have your config look
> > like this:
> > 
> >   [remote "origin"]
> >   fetch = +refs/heads/*:refs/quarantine/origin/heads/*
> >   fetch = +refs/tags/*:refs/quarantine/origin/tags/*
> >   tagOpt = --no-tags
> > 
> > That's not exactly the same thing, because it would fetch all tags, not
> > just those that point to the history on the branches. But in most
> > repositories and workflows the distinction doesn't matter.
> 
> Hmm... apart from the implementation complexity (of which I have no
> idea), is there an argument against the idea of adding a
> remote.<name>.fetchTagsTo refmap similar to remote.<name>.fetch but used
> every time a tag is fetched? (well, maybe not exactly similar to
> remote.<name>.fetch because we know the source is going to be
> refs/tags/*; so just having the part of .fetch past the ':' would be
> more like what's needed I guess)

I don't think it would be too hard to implement, and is at least
logically consistent with the way we handle tags.

If we were designing from scratch, I do think this would all be helped
immensely by having more separation of refs fetched from remotes. There
was a proposal in the v1.8 era to fetch everything for a remote,
including tags, into "refs/remotes/origin/heads/",
"refs/remotes/origin/tags/", etc. And then we'd teach the lookup side to
look for tags in each of the remote-tag namespaces.

I still think that would be a good direction to go, but it would be a
big project (which is why the original stalled).

> The issue with your solution is that if the user runs 'git fetch
> --tags', he will get the (potentially compromised) tags directly in his
> refs/tags/.

True.

-Peff
