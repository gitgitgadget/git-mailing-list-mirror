Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52AA41F453
	for <e@80x24.org>; Thu, 20 Sep 2018 19:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388391AbeIUBGU (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 21:06:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:54194 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388103AbeIUBGU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 21:06:20 -0400
Received: (qmail 3049 invoked by uid 109); 20 Sep 2018 19:21:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Sep 2018 19:21:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28156 invoked by uid 111); 20 Sep 2018 19:21:14 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Sep 2018 15:21:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Sep 2018 15:21:18 -0400
Date:   Thu, 20 Sep 2018 15:21:18 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <ttaylorr@github.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] Filter alternate references
Message-ID: <20180920192117.GA29603@sigill.intra.peff.net>
References: <cover.1537466087.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1537466087.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 20, 2018 at 02:04:05PM -0400, Taylor Blau wrote:

> This is a series to customize Git's behavior when listing references
> from an alternate repository. It is motivated by the following example:
> 
> Consider an upstream repository, a fork of it, and a local copy of that
> fork. Ideally, running "git pull upstream" from the local copy followed
> by a "git push fork" should be a lightweight operation, ideally because
> the fork already "knows" about the new objects introduced upstream.
> 
> Today, we do this by means of the special ".have" references advertised
> by 'git receive-pack'. This special part of the advertisement is
> designed to tell the pusher about tips that it might want to know about,
> to avoid sending them again.

I think it's important to note that this is just one place where this
optimization is useful. A few others are:

  1. On fetching, the client similarly advertises the extra tips (not in
     a ref advertisement, but as part of the negotiation).

  2. We don't do it now, but we ought to use those for checking the
     connectivity of incoming objects. Otherwise we end up walking over
     history that we already know we have. Since this is purely local,
     it's not usually as big a deal, but it can matter a lot in large
     repositories, because it makes what should be O(nr_changes)
     fetches into O(size_of_repo). E.g., imagine making a fork of
     linux.git backed by the same shared-object alternate. The initial
     "fetch" should be a noop as we realize that we have everything
     already, but we spend 45s of CPU walking the whole graph.

     I have patches for this, but haven't sent them, since without the
     optimization you've done here, we'd never be able to turn it on at
     GitHub.

  3. Other scripts may want us to expose this. The patches I have for
     (2) actually implement "rev-list --alternate-refs" (since we
     implement the connectivity check there). I don't have other
     particular uses in mind, but it lets you ask questions like "which
     objects are reachable here versus in the alternate".

Your patches would affect all of those sites, I and I think that's a
good thing. It's giving a consistent view of "what can I assume is
reachable from the alternate?", which is OK to be a subset of the whole
(and already is, really, since we don't peek into the alternate's
reflogs).

> In a previous version of this series, I taught the configuration
> property to the alternate, as in "these are the references that _I_
> think _you_ will find interesting," rather than the other way around. I
> ultimately decided on what is attached here so that the fork does not
> have to trust the upstream to run arbitrary shell commands.

Right, we had a lot of discussion here (which I'm repeating not for you
but for the benefit of the list). It might seem conceptually simpler to
for the alternate itself to say "what are my important refs?". And that
nicely generalizes if you have multiple alternates. But in our use case,
"important" here is in the eye of the beholder. If a bunch of repos are
sharing object storage, and repo Y is derived from repo X, then refs
related to X are going to be most important when you're doing an
operation in Y. But in some repo Q derived from R, that wouldn't be the
case.

So I think you could make an argument either way there. But simplifying
the security boundary around core.alternateRefsCommand pushes it in
favor of having all of this decided by the repo doing the looking,
rather than the one it's looking at.

-Peff
