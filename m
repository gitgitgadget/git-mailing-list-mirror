Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E51DD1FF34
	for <e@80x24.org>; Thu, 11 May 2017 09:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755418AbdEKJ7f (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 05:59:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:49423 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755402AbdEKJ73 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 05:59:29 -0400
Received: (qmail 4895 invoked by uid 109); 11 May 2017 09:59:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 09:59:27 +0000
Received: (qmail 12236 invoked by uid 111); 11 May 2017 09:59:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 05:59:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 May 2017 05:59:25 -0400
Date:   Thu, 11 May 2017 05:59:25 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Shawn Pearce <spearce@spearce.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] fetch-pack: always allow fetching of literal SHA1s
Message-ID: <20170511095925.grmyagv4hesxqprj@sigill.intra.peff.net>
References: <20170509182042.28389-1-jonathantanmy@google.com>
 <20170509221629.3z35qcz36oiix3kh@sigill.intra.peff.net>
 <CAJo=hJvAg2WqpiuykpbHcB5vgQiHJ74CZ8Y4qudkYqZrmd30zg@mail.gmail.com>
 <20170510043343.mgb7heqzu2etcgvf@sigill.intra.peff.net>
 <20170510170044.GX28740@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170510170044.GX28740@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 10, 2017 at 10:00:44AM -0700, Jonathan Nieder wrote:

> > Right, makes sense.  I wondered if GitHub should be turning on
> > allowTipSHA1InWant, but it really doesn't make sense to. We _do_ hide
> > some internal refs[1], and they're things that users wouldn't want to
> > fetch. The problem for your case really is just on the client side, and
> > this patch fixes it.
> [...]
> > [1] The reachability checks from upload-pack don't actually do much on
> >     GitHub, because you can generally access the objects via the API or
> >     the web site anyway. So I'm not really opposed to turning on
> >     allowTipSHA1InWant if it would be useful for users, but after
> >     Jonathan's patch I don't see how it would be.
> 
> Given that, what would make me really happy is if github enables
> uploadpack.allowAnySHA1InWant.  That would be useful for me, at least.

One of my hesitations is that we've actually considered moving in the
opposite direction. The object storage for all of the repositories in a
network is shared, so I can fork git.git, push up malicious crap, and
then point people to:

  https://github.com/git/git/commit/$sha1

and it resolves. Obviously there's a social-engineering component to any
such attack, but it's not great. And even without security in mind, it's
potentially confusing. So we've looked at enforcing reachability from
the refs of git/git for a case like that. There's some collateral
damage, though (e.g., people might actually want to look at unreferenced
objects after a force-push). And there are complications around things
like refs/pull (which could still come from another fork, but which you
might reasonably want to reference as part of a PR in the context of
git/git).

Turning on allowAnySHA1InWant brings that confusion to "git fetch", too.
To some degree it's already there for refs/pull, but with the current
client you at least know that you're fetching PR refs (and they're not
even fetched by default). Whereas after Jonathan Tan's patch, you can
social-engineer somebody into:

  git fetch https://github.com/git/git $sha1

if you open a PR that points to some malicious $sha1. I don't think
that's a reason not to take his patch, though.

Arguably refs/pull/ is an abomination that mixes up ownership and should
be destroyed. There really isn't a great alternative, though, short of
representing it as a completely separate repository (which would mean
anybody fetching those refs would have to make a separate fetch
request).

But even leaving all the refs/pull stuff aside, allowAnySHA1InWant does
seem to increase that confusion, and I don't see a way around it short
of never sharing objects between repositories at all. So I think at most
we'd do allowReachableSHA1InWant.

-Peff
