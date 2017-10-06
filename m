Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A1E21FC43
	for <e@80x24.org>; Fri,  6 Oct 2017 14:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752002AbdJFOLb (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 10:11:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:35272 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751942AbdJFOLa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 10:11:30 -0400
Received: (qmail 5910 invoked by uid 109); 6 Oct 2017 14:11:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Oct 2017 14:11:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6500 invoked by uid 111); 6 Oct 2017 14:11:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Oct 2017 10:11:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Oct 2017 10:11:28 -0400
Date:   Fri, 6 Oct 2017 10:11:28 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        git@jeffhostetler.com
Subject: Re: [PATCH v2 1/5] test-list-objects: List a subset of object ids
Message-ID: <20171006141128.rkuhd4m7hp2f7vvx@sigill.intra.peff.net>
References: <20170925095452.66833-1-dstolee@microsoft.com>
 <20170925095452.66833-2-dstolee@microsoft.com>
 <20171005084249.sdkimglkxqh2vi4i@sigill.intra.peff.net>
 <xmqqvaju6i3p.fsf@gitster.mtv.corp.google.com>
 <20171005100001.do5m4zhexcsltvw7@sigill.intra.peff.net>
 <6222f65a-c518-74a4-9df4-89bf997425cb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6222f65a-c518-74a4-9df4-89bf997425cb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 05, 2017 at 08:39:42AM -0400, Derrick Stolee wrote:

> > Actually, I'd just as soon see timings for "git log --format=%h" or "git
> > log --raw", as opposed to patches 1 and 2.
> > 
> > You won't see a 90% speedup there, but you will see the actual
> > improvement that real-world users are going to experience, which is way
> > more important, IMHO.
> > 
> Thanks for thinking hard about this.
> 
> For some real-user context: Some engineers using Git for the Windows repo
> were seeing extremely slow commands, such as 'fetch' or 'commit', and when
> we took a trace we saw most of the time spinning in this abbreviation code.

That's surprising to me. I'd expect fetch to generate up to two
abbreviations per fetched ref (for the status table). And for commit to
generate only one for the summary. But maybe it was just so painfully
slow on your repo that it was noticeable.

If there's a case where we're generating a bunch of abbreviated oids,
that might be worth looking into. Do you happen to have a stack trace of
one of the slow cases showing who is calling into the function?

> Our workaround so far has been to set core.abbrev=40.

I actually wondered about this. With the new auto-scaling, we'd
typically jump straight to 12 or 13 hex-chars on a large repo, and that
would be sufficient. So we'd really only need one iteration of the loop.

> I'll run some perf numbers for these commands you recommend, and also see if
> I can replicate some of the pain points that triggered this change using the
> Linux repo.

Thanks!

-Peff
