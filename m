Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D93851F404
	for <e@80x24.org>; Tue,  3 Apr 2018 20:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753071AbeDCUUd (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 16:20:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:52736 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752515AbeDCUUc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 16:20:32 -0400
Received: (qmail 17120 invoked by uid 109); 3 Apr 2018 20:20:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Apr 2018 20:20:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32025 invoked by uid 111); 3 Apr 2018 20:21:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 03 Apr 2018 16:21:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Apr 2018 16:20:30 -0400
Date:   Tue, 3 Apr 2018 16:20:30 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        avarab@gmail.com, sbeller@google.com, larsxschneider@gmail.com
Subject: Re: [PATCH 0/3] Lazy-load trees when reading commit-graph
Message-ID: <20180403202030.GA15157@sigill.intra.peff.net>
References: <20180403120057.173849-1-dstolee@microsoft.com>
 <20180403130615.GA18824@sigill.intra.peff.net>
 <007c630a-0df8-803c-b637-fb5ccefa7b7c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <007c630a-0df8-803c-b637-fb5ccefa7b7c@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 03, 2018 at 09:14:50AM -0400, Derrick Stolee wrote:

> > I'm not sure what the exact solution would be, but I imagine something
> > like variable-sized "struct commit"s with the parent pointers embedded,
> > with some kind of flag to indicate the number of parents (and probably
> > some fallback to break out to a linked list for extreme cases of more
> > than 2 parents).  It may end up pretty invasive, though, as there's a
> > lot of open-coded traversals of that parent list.
> > 
> > Anyway, not anything to do with this patch, but food for thought as you
> > micro-optimize these traversals.
> 
> One other thing that I've been thinking about is that 'struct commit' is so
> much bigger than the other structs in 'union any_object'. This means that
> the object cache, which I think creates blocks of 'union any_object' for
> memory-alignment reasons, is overly bloated. This would be especially true
> when walking many more trees than commits.
> 
> Perhaps there are other memory concerns in that case (such as cached
> buffers) that the 'union any_object' is not a concern, but it is worth
> thinking about as we brainstorm how to reduce the parent-list memory.

It definitely bloats any_object, but I don't think we typically allocate
too many of those. Those should only come from lookup_unknown_object(),
but typically we'll come across objects by traversing the graph, in
which case we have an expectation of the type (and use the appropriate
lookup_foo() function, which uses the type-specific block allocators).

-Peff
