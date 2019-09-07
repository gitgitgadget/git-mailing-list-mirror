Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EE531F461
	for <e@80x24.org>; Sat,  7 Sep 2019 04:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394264AbfIGEqw (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 00:46:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:42678 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2392019AbfIGEqv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 00:46:51 -0400
Received: (qmail 27929 invoked by uid 109); 7 Sep 2019 04:46:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 07 Sep 2019 04:46:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9404 invoked by uid 111); 7 Sep 2019 04:48:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 07 Sep 2019 00:48:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 7 Sep 2019 00:46:50 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, avarab@gmail.com, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] fetch: add fetch.writeCommitGraph config setting
Message-ID: <20190907044650.GB24463@sigill.intra.peff.net>
References: <pull.328.git.gitgitgadget@gmail.com>
 <49f877c85ca2be5bb76d9082ee4aa26e26111a14.1567477320.git.gitgitgadget@gmail.com>
 <20190904030829.GB28836@sigill.intra.peff.net>
 <xmqqa7bipjil.fsf@gitster-ct.c.googlers.com>
 <a697c4de-e269-c330-ece2-8ac7007e6c55@gmail.com>
 <20190906175628.GH23181@sigill.intra.peff.net>
 <xmqq1rwtnv03.fsf@gitster-ct.c.googlers.com>
 <20190906191622.GA7096@sigill.intra.peff.net>
 <xmqqpnkdma0g.fsf@gitster-ct.c.googlers.com>
 <25ed1562-dc74-1ebc-46ff-d6cd643504a4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <25ed1562-dc74-1ebc-46ff-d6cd643504a4@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 06, 2019 at 05:04:17PM -0400, Derrick Stolee wrote:

> On 9/6/2019 4:42 PM, Junio C Hamano wrote:
> > Jeff King <peff@peff.net> writes:
> > 
> >> I suppose so. But I think the "stock git without any other job
> >> infrastructure" case would still benefit.
> > 
> > Oh, no question about it.
> > 
> > I did question if an automatic writing would benefit the side that
> > receives a push when you brought up the usual "fetch.* and receive.*
> > for separate configuration, transfer.* when want to rule them both"
> > convention, which is a good idea if only for consistency, but the
> > question was if it helps the receiving end of a push to the same
> > degree as it would help the repository that fetches.
> 
> I think the "stock git without any other job infrastructure" is
> a very important scenario. Putting the simplest version of
> "commit-graph writes in-line with every push" seems to be ripe
> for failure under load. I'd rather think deeply about what is
> best for this scenario.

If it's going to be a problem under load, that makes me worry about the
same thing for fetches. Whether you see a lot of either depends on your
workflow. But as long as neither option is enabled by default (or at
least if it becomes common knowledge to _disable_ them if you have a
high rate), it may be OK.

I do agree that the normal "busy" repos you and I have both seen in
enterprise settings (where people are literally pushing multiple times
per second at peak) would want some kind of throttling. But I think
there's a long tail of "push once a week" repos.

> Spit-balling: what if we used the same mechanism as running GC
> in the background to launch 'git commit-graph write' commands?
> And we could have the command give up (without failure) if the
> commit-graph.lock file is already created, so concurrent pushes
> would not fight each other.

I have mixed feelings. It's nice not to stand in the critical path of
the user, but background tasks have a way of finding funny corner cases
(e.g., packfiles moving around, or the issues we've had with deciding
when to shut down auto-gc for a grace period due to warnings/errors).

I think since this is generally additive (adding new commit-graph
files), it might be less finicky, though.

-Peff
