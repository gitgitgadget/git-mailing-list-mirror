Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F10C20836
	for <e@80x24.org>; Sun, 16 Jul 2017 14:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753552AbdGPOQn (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jul 2017 10:16:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:42120 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753481AbdGPOQj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2017 10:16:39 -0400
Received: (qmail 4414 invoked by uid 109); 16 Jul 2017 14:16:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 16 Jul 2017 14:16:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26011 invoked by uid 111); 16 Jul 2017 14:16:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 16 Jul 2017 10:16:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Jul 2017 10:16:37 -0400
Date:   Sun, 16 Jul 2017 10:16:37 -0400
From:   Jeff King <peff@peff.net>
To:     Jan Danielsson <jan.m.danielsson@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Keeping a non-1:1 mirror in sync and keeping private branches
Message-ID: <20170716141637.bsdkj4i5rncd7h5m@sigill.intra.peff.net>
References: <699d0274-285f-3d30-654d-d9ca59fe4dce@gmail.com>
 <20170716101045.aslfct7g5vqfqnhi@sigill.intra.peff.net>
 <eb5e02da-662e-5561-7548-e50efba13dca@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eb5e02da-662e-5561-7548-e50efba13dca@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 16, 2017 at 03:42:09PM +0200, Jan Danielsson wrote:

> >   1. Drop the pruning (in which case deleted branches from the sync may
> >      accumulate, but depending on the patterns that may or may not be a
> >      problem).
> 
>    I don't think that's a problem.  Or rather, I'd be willing to try it
> and see if it becomes a problem.
> 
>    That said; does "drop the pruning" mean simply removing "--prune"
> from the remove update?  I did that, but it still deletes my test-branch
> on push.  Is there an implicit pruning happening due to some
> configuration option or the specific commands I'm using?

No, that prune is fetching from your upstream into the bridge repo. So
it is dropping refs from the bridge that went away upstream. My
assumption is that your "private" branches are not in the bridge, but
just in the $DOWNSTREAMURL.

The issue is in the "git push" after that.  Your "git remote add
--mirror=push" set up config like this:

  [remote "origin"]
  url = ...
  mirror = true

and the "mirror" there implies the prune. Instead, you'd want to do:

  git config remote.origin.url $DOWNSTREAMURL
  git config remote.origin.push "+refs/*:refs/*"

Note that the "+" means a force-push. If you do have personal branches
in the downstream, their contents may be overwritten by the sync from
upstream. You can drop the "+", but then if upstream ever rewinds a
branch, your sync would fail.

> >   2. Use two different namespaces for the synced branches and the
> >      private ones (e.g., refs/mirror/* in addition to your branches in
> >      refs/heads/*). The obvious downside is that anybody cloning your
> >      downstream mirror doesn't pick up refs/mirror unless they configure
> >      that refspec explicitly.
>    This sounds very useful.  How would one go about setting up this
> configuration?

I'm not 100% clear on where your private branches are. Are they in the
bridge repo, too, or only in the eventual downstream? I'll assume
they're only in the downstream, and that the bridge is purely a tool for
syncing.

In that case, you might do:

  git clone --mirror -o upstream $UPSTREAM bridge.git
  cd bridge.git
  git config remote.downstream.url $DOWNSTREAM
  git config remote.downstream.push "+refs/*:refs/mirror/*"
  git config remote.downstream.prune true

Though I'm not 100% sure that the "prune" config is respected for
pushes. You might have to skip that last config and just issue:

  git push --prune downstream

If you're scripting it, I'd actually consider doing the whole thing
without config at all:

  # do this once
  git init bridge.git
  cd bridge.git

  # and put this in your sync script
  git fetch --prune $UPSTREAM +refs/*:refs/*
  git push --prune $DOWNSTREAM +refs/*:refs/mirror/*

-Peff
