Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA1172036B
	for <e@80x24.org>; Thu,  5 Oct 2017 10:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751400AbdJEKAE (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 06:00:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:33350 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751331AbdJEKAE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 06:00:04 -0400
Received: (qmail 16428 invoked by uid 109); 5 Oct 2017 10:00:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Oct 2017 10:00:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25935 invoked by uid 111); 5 Oct 2017 10:00:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Oct 2017 06:00:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Oct 2017 06:00:02 -0400
Date:   Thu, 5 Oct 2017 06:00:02 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        stolee@gmail.com, git@jeffhostetler.com
Subject: Re: [PATCH v2 1/5] test-list-objects: List a subset of object ids
Message-ID: <20171005100001.do5m4zhexcsltvw7@sigill.intra.peff.net>
References: <20170925095452.66833-1-dstolee@microsoft.com>
 <20170925095452.66833-2-dstolee@microsoft.com>
 <20171005084249.sdkimglkxqh2vi4i@sigill.intra.peff.net>
 <xmqqvaju6i3p.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqvaju6i3p.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 05, 2017 at 06:48:10PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This is weirdly specific. Can we accomplish the same thing with existing
> > tools?
> >
> > E.g., could:
> >
> >   git cat-file --batch-all-objects --batch-check='%(objectname)' |
> >   shuffle |
> >   head -n 100
> >
> > do the same thing?
> >
> > I know that "shuffle" isn't available everywhere, but I'd much rather
> > see us fill in portability gaps in a general way, rather than
> > introducing one-shot C code that needs to be maintained (and you
> > wouldn't _think_ that t/helper programs need much maintenance, but try
> > perusing "git log t/helper" output; they have to adapt to the same
> > tree-wide changes as the rest of the code).
> 
> I was thinking about this a bit more, and came to the conclusion
> that "sort -R" and "shuf" are wrong tools to use.  We would want to
> measure with something close to real world workload.  for example,
> letting
> 
> 	git rev-list --all --objects
> 
> produce the listof objects in traversal order (i.e. this is very
> similar to the order in which "git log -p" needs to access the
> objects) and chomping at the number of sample objects you need in
> your test would give you such a list.

Actually, I'd just as soon see timings for "git log --format=%h" or "git
log --raw", as opposed to patches 1 and 2.

You won't see a 90% speedup there, but you will see the actual
improvement that real-world users are going to experience, which is way
more important, IMHO.

-Peff
