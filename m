Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 049BC1F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 04:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfDWEVL (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 00:21:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:37710 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726167AbfDWEVL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 00:21:11 -0400
Received: (qmail 17710 invoked by uid 109); 23 Apr 2019 04:21:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 23 Apr 2019 04:21:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5770 invoked by uid 111); 23 Apr 2019 04:21:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 23 Apr 2019 00:21:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Apr 2019 00:21:09 -0400
Date:   Tue, 23 Apr 2019 00:21:09 -0400
From:   Jeff King <peff@peff.net>
To:     Martin Fick <mfick@codeaurora.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Resolving deltas dominates clone time
Message-ID: <20190423042109.GA19183@sigill.intra.peff.net>
References: <259296914.jpyqiltySj@mfick-lnx>
 <16052712.dFCfNLlQnN@mfick-lnx>
 <20190422205653.GA30286@sigill.intra.peff.net>
 <19221376.OlD5LWjr85@mfick-lnx>
 <20190423015538.GA16369@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190423015538.GA16369@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 22, 2019 at 09:55:38PM -0400, Jeff King wrote:

> Here are my p5302 numbers on linux.git, by the way.
> 
>   Test                                           jk/p5302-repeat-fix
>   ------------------------------------------------------------------
>   5302.2: index-pack 0 threads                   307.04(303.74+3.30)
>   5302.3: index-pack 1 thread                    309.74(306.13+3.56)
>   5302.4: index-pack 2 threads                   177.89(313.73+3.60)
>   5302.5: index-pack 4 threads                   117.14(344.07+4.29)
>   5302.6: index-pack 8 threads                   112.40(607.12+5.80)
>   5302.7: index-pack default number of threads   135.00(322.03+3.74)
> 
> which still imply that "4" is a win over "3" ("8" is slightly better
> still in wall-clock time, but the total CPU rises dramatically; that's
> probably because this is a quad-core with hyperthreading, so by that
> point we're just throttling down the CPUs).

And here's a similar test run on a 20-core Xeon w/ hyperthreading (I
tweaked the test to keep going after eight threads):

Test                            HEAD                
----------------------------------------------------
5302.2: index-pack 1 threads    376.88(364.50+11.52)
5302.3: index-pack 2 threads    228.13(371.21+17.86)
5302.4: index-pack 4 threads    151.41(387.06+21.12)
5302.5: index-pack 8 threads    113.68(413.40+25.80)
5302.6: index-pack 16 threads   100.60(511.85+37.53)
5302.7: index-pack 32 threads   94.43(623.82+45.70) 
5302.8: index-pack 40 threads   93.64(702.88+47.61) 

I don't think any of this is _particularly_ relevant to your case, but
it really seems to me that the default of capping at 3 threads is too
low.

-Peff
