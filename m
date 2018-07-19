Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCD241F597
	for <e@80x24.org>; Thu, 19 Jul 2018 05:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbeGSGbS (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 02:31:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:52200 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726494AbeGSGbR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 02:31:17 -0400
Received: (qmail 9685 invoked by uid 109); 19 Jul 2018 05:49:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Jul 2018 05:49:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7482 invoked by uid 111); 19 Jul 2018 05:49:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 19 Jul 2018 01:49:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jul 2018 01:49:54 -0400
Date:   Thu, 19 Jul 2018 01:49:54 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: 2.18.0 Regression: packing performance and effectiveness
Message-ID: <20180719054953.GA24268@sigill.intra.peff.net>
References: <20180718225110.17639-1-newren@gmail.com>
 <CACsJy8Cc=h3ptDaW=oUGXqRZAvNU8-pUCe1cVFpRd0t8O1a0Gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8Cc=h3ptDaW=oUGXqRZAvNU8-pUCe1cVFpRd0t8O1a0Gw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 07:41:03AM +0200, Duy Nguyen wrote:

> On Thu, Jul 19, 2018 at 12:51 AM Elijah Newren <newren@gmail.com> wrote:
> >
> > I had a user report some poor behavior of 'git gc --aggressive' on a
> > certain repo (which I sadly cannot share).  Turns out that on this
> > repo, this operation takes about 60% longer and produces a pack
> > roughly twice the expected size.
> 
> The intention was to make life better for weaker machines but
> definitely should not slow down beefier ones, so yes this is
> definitely a regression.
> 
> Is it possible to share "verify-pack -v <pack file>" output of the
> pack produced by 2.17.0 and 2.18.0? The only sensitive info there is
> sha-1, which you can replace with just "SHA-1" if you want. I'm more
> interested in delta sizes and distribution.

Try this:

-- >8 --
#!/bin/sh

rm -rf repo

git init repo
cd repo

dd if=/dev/urandom of=one.rand bs=1M count=2
dd if=/dev/urandom of=two.rand bs=1M count=2
dd if=/dev/urandom of=big.rand bs=1M count=20

cat one.rand big.rand >file
git add file
git commit -m one

cat two.rand big.rand >file
git add file
git commit -m two

git repack -ad
git cat-file --batch-all-objects --batch-check='%(objectname) %(deltabase)'
-- 8< --

Using git 2.17 for the repack results in a single delta (which should be
about 2MB, because it will say "delete one.rand and add two.rand" or
vice versa).

Using git 2.18, I get no delta at all.

-Peff
