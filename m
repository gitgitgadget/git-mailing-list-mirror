Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EDBD208CD
	for <e@80x24.org>; Tue, 15 Aug 2017 21:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751848AbdHOV7u (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 17:59:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:40170 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751119AbdHOV7t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 17:59:49 -0400
Received: (qmail 10703 invoked by uid 109); 15 Aug 2017 21:59:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 15 Aug 2017 21:59:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14678 invoked by uid 111); 15 Aug 2017 22:00:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 15 Aug 2017 18:00:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Aug 2017 17:59:47 -0400
Date:   Tue, 15 Aug 2017 17:59:47 -0400
From:   Jeff King <peff@peff.net>
To:     Jason Karns <jason.karns@gmail.com>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>, git@vger.kernel.org
Subject: Re: Bug: `git remote show <remote>` reports different HEAD branch
 than refs/remotes/<remote>/HEAD
Message-ID: <20170815215947.hbddixjjwzlgsfuq@sigill.intra.peff.net>
References: <CAKNmmv3_K4gB6FbcmAjXyviMbU2Ts7Rh7txkOof+-36rF_1+Gw@mail.gmail.com>
 <bad7dafc-247c-bf5e-8cfd-5445badeef1c@gmail.com>
 <CAKNmmv3_rFNDDFVEeShAb3mEMOBL4z=oZXP8Df72D44stB_7BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKNmmv3_rFNDDFVEeShAb3mEMOBL4z=oZXP8Df72D44stB_7BA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2017 at 01:58:38PM -0400, Jason Karns wrote:

> > On the other hand, what "git remote show" outputs for HEAD is a name
> > of actually checked-out branch inside that remote repository - it`s
> > what`s stored inside HEAD file of the remote repository root.
> >
> > So it is something set on the _remote_ end, you can`t influence it
> > from your local repository.
> 
> So _this_ is not what I expected. Thanks for clarifying.
> 
> Considering that a fresh clone replicates the remote's default branch
> as the local default for that remote, I wager (in the majority of
> cases) that these two are the same. It would seem that what I would
> like in this case is a feature change to git-remote-show to show both
> the locally-configured and remote-configured defaults for the given
> remote (similar in spirit to how git-remote-show already shows local
> vs remote information: branches and their configurations for
> push/pull).

Yes, I'd agree. This seems like exactly the kind of information that
"remote show" was intended to display.

It should be a pretty straight-forward patch for anybody wanting to get
their feet wet in git development. The trickier half of showing both is
getting the remote information, but we're already doing that. So I think
any patch would want to:

  1. Teach builtin/remote.c:show() to say "Remote HEAD branch" instead
     of just "HEAD branch".

  2. Add a "Local HEAD branch" that shows the local symref. That symref
     is always refs/remotes/<remotename>/HEAD, which can be constructed
     with a strbuf. And then resolve_refdup() can be used to get the
     pointed-to ref (check the returned flags for REF_ISSYMREF, and
     the string return value is the refname).

-Peff
