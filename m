Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A01EC1F954
	for <e@80x24.org>; Wed, 22 Aug 2018 15:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbeHVS41 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 14:56:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:51682 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729035AbeHVS41 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 14:56:27 -0400
Received: (qmail 18949 invoked by uid 109); 22 Aug 2018 15:31:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Aug 2018 15:31:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 503 invoked by uid 111); 22 Aug 2018 15:31:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 22 Aug 2018 11:31:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Aug 2018 11:31:04 -0400
Date:   Wed, 22 Aug 2018 11:31:04 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/6] t/perf: add infrastructure for measuring sizes
Message-ID: <20180822153104.GE32630@sigill.intra.peff.net>
References: <20180821184140.GA24165@sigill.intra.peff.net>
 <20180821190654.GC30764@sigill.intra.peff.net>
 <b071f6a2-2403-0bbb-72a5-695f8c4e724d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b071f6a2-2403-0bbb-72a5-695f8c4e724d@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 22, 2018 at 09:40:55AM -0400, Derrick Stolee wrote:

> On 8/21/2018 3:06 PM, Jeff King wrote:
> > The main objective of scripts in the perf framework is to
> > run "test_perf", which measures the time it takes to run
> > some operation. However, it can also be interesting to see
> > the change in the output size of certain operations.
> > 
> > This patch introduces test_size, which records a single
> > numeric output from the test and shows it in the aggregated
> > output (with pretty printing and relative size comparison).
> 
> I'm interested in exploring this test_size mechanism. The other area that
> could benefit from size testing is 'git repack', but I don't have any plans
> to change our compression or delta strategies. If we _did_ look into that,
> then using test_size would be a natural fit.

Yeah, I agree it would be a good tool for showing off improvements
there.

It may also be useful for catching regressions in topics that are trying
to speed things up, but _don't_ intend to change the size. We could even
do that proactively now. I.e., something like:

  test_perf 'repack' 'git repack -adf'
  test_size 'pack size' 'wc -c <.git/objects/pack/*.pack'

just to see if it ever changes.  But I suspect its usefulness may depend
on how you are packing (e.g., is "-f" more likely to catch issues than
without?).

The new tests I added in this series cover packs created for fetches.
There's no guarantee that will overlap with the behavior of an on-disk
repack, but at least we have some generic coverage of pack-objects
output sizes now. Absent any suspicion of a regression for a particular
case, that's probably an acceptable canary in the coal mine.

-Peff
