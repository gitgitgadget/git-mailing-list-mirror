Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8D6D207DF
	for <e@80x24.org>; Thu, 15 Sep 2016 06:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933799AbcIOG2v (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 02:28:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:43550 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756182AbcIOG2v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 02:28:51 -0400
Received: (qmail 12945 invoked by uid 109); 15 Sep 2016 06:28:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Sep 2016 06:28:49 +0000
Received: (qmail 7006 invoked by uid 111); 15 Sep 2016 06:29:00 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Sep 2016 02:29:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Sep 2016 23:28:46 -0700
Date:   Wed, 14 Sep 2016 23:28:46 -0700
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] use zstd zlib wrapper
Message-ID: <20160915062845.sfackmnezb7oy3j5@sigill.intra.peff.net>
References: <20160914235547.h3n2otje2hec6u7k@sigill.intra.peff.net>
 <20160914235843.nacr54ekvl6rjipk@sigill.intra.peff.net>
 <CAGZ79kYcB-x40_w1fcWL3NSp8JU9SPrTAEiru-6Jpb7fDM1Y0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYcB-x40_w1fcWL3NSp8JU9SPrTAEiru-6Jpb7fDM1Y0w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 14, 2016 at 06:22:17PM -0700, Stefan Beller wrote:

> > Disappointingly, the answer seems to be "no".
> 
> After having looked at the data, I disagree with the conclusion.
> And for that I think we need to reason about the frequency
> of the operations happening.

I definitely agree that reads outnumber writes, and it's OK to have an
asymmetric tradeoff between the two. zstd5 isn't _too_ bad in that
respect. I guess I was just disappointed that the pack size was still
bigger, as I was really hoping to see some speed tradeoff without
getting a worse pack.

The other thing to weigh against is "if we were designing it today"
versus "is it worth the compatibility headaches now". A 6% improvement
in "rev-list --objects" is not that amazing for a data format change.
Bitmaps were an _easier_ data format change and are more like a 99%
speedup.

They do not apply to every operations, but we may be able to do similar
space/time tradeoffs that are easier to handle in terms of backwards
compatibility, and which yield bigger results.

-Peff
