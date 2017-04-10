Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47A3B20960
	for <e@80x24.org>; Mon, 10 Apr 2017 18:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752944AbdDJSbX (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 14:31:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:59340 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752410AbdDJSbX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 14:31:23 -0400
Received: (qmail 16126 invoked by uid 109); 10 Apr 2017 18:31:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Apr 2017 18:31:22 +0000
Received: (qmail 27449 invoked by uid 111); 10 Apr 2017 18:31:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Apr 2017 14:31:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Apr 2017 14:31:20 -0400
Date:   Mon, 10 Apr 2017 14:31:20 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Haller <haller@ableton.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI/?= Bjarmason <avarab@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: Tools that do an automatic fetch defeat "git push
 --force-with-lease"
Message-ID: <20170410183120.oa5yqwvlrdzitqci@sigill.intra.peff.net>
References: <20170408221302.e7sv6cy4xayr2w7o@sigill.intra.peff.net>
 <1n47m37.1xocjxu1j1pyM%haller@ableton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1n47m37.1xocjxu1j1pyM%haller@ableton.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 09, 2017 at 10:38:42AM +0200, Stefan Haller wrote:

> Jeff King <peff@peff.net> wrote:
> 
> > > It might be possible to generate these lease tags prior to operations
> > > which modify history and then maybe having a way to list them so you
> > > can select which one you meant when you try to use force-with-lease..
> > 
> > So yeah, I think that is the more interesting direction. I hadn't
> > considered resolving the multiple-operation ambiguity at push time. But
> > I guess it would be something like "you did a rebase on sha1 X at time
> > T, and then one on Y at time T+N", and you pick which one you're
> > expecting.
> 
> I think it's wrong to think about these leases as something that you
> take before you start a rewindy operation. That's the wrong time to take
> the lease; by that time, the remote tracking branch may already contain
> new things that you haven't seen yet, so using that as a lease at that
> time will overwrite those things later. You have to take the lease at a
> time where you know that your local branch and the remote tracking
> branch are up to date with each other, which is after pull and push. And
> if you do that, there's no multiple-operation ambiguity to deal with at
> all.

OK. I was assuming that you'd have just integrated before starting such
a rebase, but I guess that doesn't have to be the case.

I agree that probably makes the multiple-operation stuff go away, which
is nice. It does raise the question of when the integration point
happens, and how we handle alternate paths through which commits may
land in a local branch (e.g., if both you and upstream do a ff-merge of
a particular branch). I think that would probably just end up with extra
failures though (so erring on the side of caution). As long as those
aren't too common (and this check would kick in only when you're doing
--force-with-lease in the first place, so presumably not often), I think
it'd be OK.

-Peff
