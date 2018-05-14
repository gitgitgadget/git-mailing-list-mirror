Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8355A1F406
	for <e@80x24.org>; Mon, 14 May 2018 13:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932121AbeENNJK (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 09:09:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:39312 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753401AbeENNJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 09:09:09 -0400
Received: (qmail 13154 invoked by uid 109); 14 May 2018 13:09:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 14 May 2018 13:09:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29102 invoked by uid 111); 14 May 2018 13:09:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 14 May 2018 09:09:15 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 May 2018 09:09:07 -0400
Date:   Mon, 14 May 2018 09:09:07 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] mark_parents_uninteresting(): avoid most allocation
Message-ID: <20180514130907.GB9219@sigill.intra.peff.net>
References: <20180511180029.GA11290@sigill.intra.peff.net>
 <20180511180314.GD12543@sigill.intra.peff.net>
 <8447da69-d28a-433c-f324-a6380b6ca991@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8447da69-d28a-433c-f324-a6380b6ca991@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 14, 2018 at 08:47:33AM -0400, Derrick Stolee wrote:

> On 5/11/2018 2:03 PM, Jeff King wrote:
> > Commit 941ba8db57 (Eliminate recursion in setting/clearing
> > marks in commit list, 2012-01-14) used a clever double-loop
> > to avoid allocations for single-parent chains of history.
> > However, it did so only when following parents of parents
> > (which was an uncommon case), and _always_ incurred at least
> > one allocation to populate the list of pending parents in
> > the first place.
> > 
> > We can turn this into zero-allocation in the common case by
> > iterating directly over the initial parent list, and then
> > following up on any pending items we might have discovered.
> 
> This change appears to improve performance, but I was unable to measure any
> difference between this commit and the one ahead, even when merging
> ds/generation-numbers (which significantly reduces the other costs). I was
> testing 'git status' and 'git rev-list --boundary master...origin/master' in
> the Linux repo with my copy of master 70,000+ commits behind origin/master.

I think you'd want to go the other way: this is marking uninteresting
commits, so you'd want origin/master..master, which would make those 70k
commits uninteresting.

I still doubt it will create that much difference, though. It's
more or less saving a single malloc per commit we traverse. Certainly
without the .commits file that's a drop in the bucket compared to
inflating the object data, but I wouldn't be surprised if we end up with
a few mallocs even after your patches.

Anyway, thanks for poking at it. :)

-Peff
