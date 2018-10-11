Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D86E61F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 13:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbeJKVLR (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 17:11:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:37142 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727316AbeJKVLR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 17:11:17 -0400
Received: (qmail 18464 invoked by uid 109); 11 Oct 2018 13:44:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 11 Oct 2018 13:44:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29672 invoked by uid 111); 11 Oct 2018 13:43:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 11 Oct 2018 09:43:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Oct 2018 09:43:59 -0400
Date:   Thu, 11 Oct 2018 09:43:59 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: Bloom Filters
Message-ID: <20181011134359.GA26956@sigill.intra.peff.net>
References: <a66afe22-0523-c785-91e6-bf545683c67d@gmail.com>
 <20181008181015.GA23446@szeder.dev>
 <9ad5f166-f7c5-de79-0f86-f1f952cd33d2@gmail.com>
 <20181009030803.GA6250@sigill.intra.peff.net>
 <f877020c-3098-e4c4-ad64-cca57f764b91@gmail.com>
 <20181009184647.GA7014@sigill.intra.peff.net>
 <ec3ca377-0434-322e-4ab9-49e27f96f4af@gmail.com>
 <20181009211449.GB9563@sigill.intra.peff.net>
 <20181009231250.GA19342@sigill.intra.peff.net>
 <bcf5586e-d0b0-e5e2-0dff-fb4606ff91c4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bcf5586e-d0b0-e5e2-0dff-fb4606ff91c4@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 11, 2018 at 08:33:58AM -0400, Derrick Stolee wrote:

> > I don't know if this is a fruitful path at all or not. I was mostly just
> > satisfying my own curiosity on the bitmap encoding question. But I'll
> > post the patches, just to show my work. The first one is the same
> > initial proof of concept I showed earlier.
> > 
> >    [1/3]: initial tree-bitmap proof of concept
> >    [2/3]: test-tree-bitmap: add "dump" mode
> >    [3/3]: test-tree-bitmap: replace ewah with custom rle encoding
> > 
> >   Makefile                    |   1 +
> >   t/helper/test-tree-bitmap.c | 344 ++++++++++++++++++++++++++++++++++++
> >   2 files changed, 345 insertions(+)
> >   create mode 100644 t/helper/test-tree-bitmap.c
> I'm trying to test this out myself, and am having trouble reverse
> engineering how I'm supposed to test it.
> 
> Looks like running "t/helper/test-tree-bitmap gen" will output a lot of
> binary data. Where should I store that? Does any file work?

Yeah, you can do:

  # optionally run with GIT_TRACE=1 to see some per-bitmap stats
  test-tree-bitmap gen >out

  # this should be roughly the same as:
  #  git rev-list --all |
  #  git diff-tree --stdin -t --name-only
  test-tree-bitmap dump <out

> Is this series just for the storage costs, assuming that we would replace
> all TREESAME checks with a query into this database? Or do you have a way to
> test how much this would improve a "git log -- <path>" query?

Right, I was just looking at storage cost here. It's not integrated with
the diff code at all. I left some hypothetical numbers elsewhere in the
thread.

-Peff
