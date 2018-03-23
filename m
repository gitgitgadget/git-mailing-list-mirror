Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C76511F404
	for <e@80x24.org>; Fri, 23 Mar 2018 02:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751784AbeCWCqM (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 22:46:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:39564 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751732AbeCWCqM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 22:46:12 -0400
Received: (qmail 21508 invoked by uid 109); 23 Mar 2018 02:46:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 23 Mar 2018 02:46:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24375 invoked by uid 111); 23 Mar 2018 02:47:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 22 Mar 2018 22:47:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Mar 2018 22:46:10 -0400
Date:   Thu, 22 Mar 2018 22:46:10 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 00/11] nd/pack-objects-pack-struct updates
Message-ID: <20180323024609.GA12229@sigill.intra.peff.net>
References: <20180317141033.21545-1-pclouds@gmail.com>
 <20180318142526.9378-1-pclouds@gmail.com>
 <20180321082441.GB25537@sigill.intra.peff.net>
 <CACsJy8DkF3TpTGKp5MdS1ApC8Yj6FOL5uAg5U__PjBAQY1vdNw@mail.gmail.com>
 <20180322093212.GB28907@sigill.intra.peff.net>
 <7a49135b-faad-9856-b757-e3ed4886720d@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7a49135b-faad-9856-b757-e3ed4886720d@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 23, 2018 at 01:28:12AM +0000, Ramsay Jones wrote:

> > Of the used heap after your patches:
> > 
> >  - ~40% of that is from packlist_alloc()
> >  - ~17% goes to "struct object"
> >  - ~10% for the object.c hash table to store all the "struct object"
> >  - ~7% goes to the delta cache
> >  - ~7% goes to the pack revindex (actually, there's a duplicate 7%
> >        there, too; I think our peak is when we're sorting the revindex
> >        and have to keep two copies in memory at once)
> 
> which begs the question, how much slower would it be if we
> replaced the radix-sort with an in-place sort (e.g. heapsort).
> 
> I hacked up the patch below, just for fun. I don't have any
> large repos (or enough disk space) to do any meaningful perf
> tests, but I did at least compile it and it passes the test-suite.
> (That is no guarantee that I haven't introduced bugs, of course!)

It might have been easier to just revert 8b8dfd5132 (pack-revindex:
radix-sort the revindex, 2013-07-11). It even includes some performance
numbers. :)

In short, no, I don't think we want to go back to a comparison-sort. The
radix sort back then was around 4 times faster for linux.git. And that
was when there were half as many objects in the repository, so the radix
sort should continue to improve as the repo size grows.

The absolute time savings aren't huge for something as bulky as a
repack, so it's less exciting in this context. But it's also not that
much memory (7% of the peak here, but as I showed elsewhere, if we can
stop holding all of the "struct object" memory once we're done with it,
then this revindex stuff doesn't even factor into the peak).

-Peff
