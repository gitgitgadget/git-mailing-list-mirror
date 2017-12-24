Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48D901F424
	for <e@80x24.org>; Sun, 24 Dec 2017 14:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752523AbdLXOdV (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Dec 2017 09:33:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:46482 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751029AbdLXOdU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Dec 2017 09:33:20 -0500
Received: (qmail 11802 invoked by uid 109); 24 Dec 2017 14:33:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 24 Dec 2017 14:33:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3501 invoked by uid 111); 24 Dec 2017 14:33:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Sun, 24 Dec 2017 09:33:47 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Dec 2017 09:33:18 -0500
Date:   Sun, 24 Dec 2017 09:33:18 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 1/5] core.aheadbehind: add new config setting
Message-ID: <20171224143318.GC23648@sigill.intra.peff.net>
References: <20171221190909.62995-1-git@jeffhostetler.com>
 <20171221190909.62995-2-git@jeffhostetler.com>
 <20171221204356.GA58971@aiede.mtv.corp.google.com>
 <xmqq3742tyho.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq3742tyho.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 22, 2017 at 10:21:23AM -0800, Junio C Hamano wrote:

> >> +core.aheadbehind::
> >> +	If true, tells commands like status and branch to print ahead and
> >> +	behind counts for the branch relative to its upstream branch.
> >> +	This computation may be very expensive when there is a great
> >> +	distance between the two branches.  If false, these commands
> >> +	only print that the two branches refer to different commits.
> >> +	Defaults to true.
> >
> > This doesn't seem like a particularly core feature to me.  Should it be
> > e.g. status.aheadbehind (even though it also affects "git branch") or
> > even something like diff.aheadbehind?  I'm not sure.
> 
> FWIW, I do not think it is core at all, either; sorry for not
> anticipating that a wrong name will be picked without a proper
> guidance when I saw the "not limited to status" mentioned in the
> discussion, but I was sick and offline for a few days, so...

I, too, had a funny feeling about calling this "core". But I didn't have
a better name, as I'm not sure what other place we have for config
options that cross many command boundaries. "diff" and "status" don't
seem quite right to me. While you can argue they are subsystems, it
seems too easy for users to confuse them with the commands of the same
names.

Maybe there should be a "ui.*" config hierarchy for these kinds of
cross-command interface options?

> > I also wonder if there's a way to achieve the same benefit without
> > having it be configurable.  E.g. if a branch is way behind, couldn't
> > we terminate the walk early to get the same bounded cost per branch
> > without requiring configuration?
> 
> Hmm, that is an interesting thought.

Yes, it is. Two thoughts:

  - It probably doesn't let us punt on the config naming, because we'd
    probably still want a knob for "how much work".

  - I wondered if we could give a better answer than "these two are
    different" based on a partial walk. But certainly not in the general
    case. E.g., imagine:

      ... -- master -- A -- B -- ... -- Y -- Z -- origin/master

    If we walk back from origin/master and give up somewhere in the
    middle, we can't say anything intelligent about the relationship.

-Peff
