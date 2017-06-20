Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C91E20282
	for <e@80x24.org>; Tue, 20 Jun 2017 16:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750994AbdFTQUM (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 12:20:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:46462 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750927AbdFTQUL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 12:20:11 -0400
Received: (qmail 30854 invoked by uid 109); 20 Jun 2017 16:20:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 20 Jun 2017 16:20:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14413 invoked by uid 111); 20 Jun 2017 16:20:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 20 Jun 2017 12:20:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Jun 2017 12:20:10 -0400
Date:   Tue, 20 Jun 2017 12:20:10 -0400
From:   Jeff King <peff@peff.net>
To:     Paul Smith <paul@mad-scientist.net>
Cc:     Reda Lyazidi <reda.lyazidiprojet@gmail.com>, git@vger.kernel.org
Subject: Re: Git Strange behaviour with remote deleted branch
Message-ID: <20170620162010.mm4qi6lgwu7sdmhd@sigill.intra.peff.net>
References: <39331ce5-dbf9-170e-e550-784db10b966f@gmail.com>
 <1497908782.6463.8.camel@mad-scientist.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1497908782.6463.8.camel@mad-scientist.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 19, 2017 at 05:46:22PM -0400, Paul Smith wrote:

> On Mon, 2017-06-19 at 23:33 +0200, Reda Lyazidi wrote:
> > with git I noticed when I removed a remote branch with git push origin 
> > --delete <the branch>
> > in my clone when I used git branch -a I don't the deleted branch
> > but my colleagues still see it.
> > 
> > I tried with two clones in my PC, with the first one delete branch and 
> > the other still sees it
> > despite git pull .
> 
> Normally Git will not remove a remote's branch refs on a fetch (or
> pull) operation.  This is a safety measure, since you might still have
> a use for that branch (for example to run diff against or similar).
> 
> In order to remove branches that have been deleted in your remote, you
> must use the --prune (or -p) option to git fetch or git pull:
> 
>   git pull -p
> 
> will get rid of them.

This is exactly correct. One further question, though, is "why does
git-push remove the branch?".

It makes sense that in general it tries to update the tracking branches
to match what we know we just sent to the other side. It's just
anticipating the next "git fetch".  But it is a little funny that it
treats deletion differently than fetch would.

I don't recall that behavior being consciously decided. I could see an
argument for the current behavior: the danger is less because the branch
didn't just "go away" upstream, it was something the user in the local
repository did. But I could also see an argument for the other: the
point is to anticipate the next fetch, and it should behave exactly like
fetch.

I don't have a strong opinion either way.

I do hope that one day we would turn on "fetch --prune" by default, but
I'd prefer to see better safety for recovering deleted refs first (e.g.,
if we retained the reflog and you could access origin/deleted@{1}).

-Peff
