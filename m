Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4ADC020248
	for <e@80x24.org>; Fri, 19 Apr 2019 19:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfDSTnb (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Apr 2019 15:43:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:35426 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726054AbfDSTnb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Apr 2019 15:43:31 -0400
Received: (qmail 5834 invoked by uid 109); 19 Apr 2019 19:43:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 19 Apr 2019 19:43:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12681 invoked by uid 111); 19 Apr 2019 19:44:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 19 Apr 2019 15:44:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Apr 2019 15:43:29 -0400
Date:   Fri, 19 Apr 2019 15:43:29 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 4/3] untracked-cache: use FLEX_ALLOC to create internal
 structs
Message-ID: <20190419194329.GA28277@sigill.intra.peff.net>
References: <pull.178.git.gitgitgadget@gmail.com>
 <a7f75cefb682546862be4dd8b48f91c4034c5d5a.1554901006.git.gitgitgadget@gmail.com>
 <20190410162029.GA30818@sigill.intra.peff.net>
 <xmqq7ec00z9t.fsf@gitster-ct.c.googlers.com>
 <20190418211408.GA18011@sigill.intra.peff.net>
 <20190418212405.GA18623@sigill.intra.peff.net>
 <CACsJy8BHwM5dUqa-FOjr3smxJT6kW4z7vLUJvsHuhjxwUjvkBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8BHwM5dUqa-FOjr3smxJT6kW4z7vLUJvsHuhjxwUjvkBw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 19, 2019 at 04:18:25PM +0700, Duy Nguyen wrote:

> > I also wondered if we could just accept the cost of calloc() here and
> > use FLEX_ALLOC to simplify things. That resulted in the patch below, but
> > I didn't include it with the initial 3, because I think it's too
> > subtle/gross for my tastes.
> 
> It's probably ok. If I remember correctly, reading UNTR extension (on
> a huge repo) took the longest time after Ben added support for reading
> the index with multiple threads. So performance is a concern, but I
> don't think calloc() would be the problem. malloc() itself without the
> memory pool could probably slow down more when we have lots and lots
> of directories.

I think if we do the FLEX_ALLOC_COPY() thing I mentioned that it would
probably _not_ use calloc() there, since we'd know we were copying in
the content from elsewhere. So that concern would go away either way. :)

(But I'm still skeptical that FLEX_ALLOC_COPY() is worth it unless we
can find at least one other caller).

-Peff
