Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A63051F461
	for <e@80x24.org>; Fri,  6 Sep 2019 17:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391796AbfIFR43 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 13:56:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:42330 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387514AbfIFR43 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 13:56:29 -0400
Received: (qmail 21626 invoked by uid 109); 6 Sep 2019 17:56:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Sep 2019 17:56:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5924 invoked by uid 111); 6 Sep 2019 17:58:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Sep 2019 13:58:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 6 Sep 2019 13:56:28 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, avarab@gmail.com, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] fetch: add fetch.writeCommitGraph config setting
Message-ID: <20190906175628.GH23181@sigill.intra.peff.net>
References: <pull.328.git.gitgitgadget@gmail.com>
 <49f877c85ca2be5bb76d9082ee4aa26e26111a14.1567477320.git.gitgitgadget@gmail.com>
 <20190904030829.GB28836@sigill.intra.peff.net>
 <xmqqa7bipjil.fsf@gitster-ct.c.googlers.com>
 <a697c4de-e269-c330-ece2-8ac7007e6c55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a697c4de-e269-c330-ece2-8ac7007e6c55@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 06, 2019 at 01:00:40PM -0400, Derrick Stolee wrote:

> On 9/5/2019 4:37 PM, Junio C Hamano wrote:
> > Jeff King <peff@peff.net> writes:
> > 
> >> Do we want to to have fetch.writeCommitGraph, receive.writeCommitGraph,
> >> and then a master transfer.writeCommitGraph?
> > 
> > If anything, it may be good for consistency.
> > 
> > I am not sure if it is a good idea to trigger writing the commit
> > graph when accepting a push, though.  It tends to be a lot finer
> > grained than fetching, right?
> 
> And I expect a push to include many fewer commits than a fetch.
> In a server environment, I would expect to have a separate
> maintenance task responsible for updating the commit-graph after
> receiving new data, but not in an in-line fashion with the push.

That's probably how we'll end up doing it at GitHub, because we run a
big server farm that has a job-queueing system for periodic maintenance,
etc.

But keep in mind the "little guy" who is hosting a few repositories for
themselves or their company. They'd presumably want the benefits here,
too, right? We already have options to trigger auto-gc and
update-server-info for them, so why not this maintenance, too?

> Think about the situation of many pushes that happen in a short
> burst: one write after all of the pushes would have close to the
> same performance benefits as writing with every push, but does
> a lot less work.

Sure, but wouldn't that similarly apply to fetching? What is it that
makes bursts of pushes more likely than bursts of fetches?

-Peff
