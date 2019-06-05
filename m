Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 502241F462
	for <e@80x24.org>; Wed,  5 Jun 2019 11:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfFEL1Q (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jun 2019 07:27:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:46704 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726280AbfFEL1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jun 2019 07:27:16 -0400
Received: (qmail 30416 invoked by uid 109); 5 Jun 2019 11:27:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Jun 2019 11:27:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21670 invoked by uid 111); 5 Jun 2019 11:28:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 05 Jun 2019 07:28:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Jun 2019 07:27:14 -0400
Date:   Wed, 5 Jun 2019 07:27:14 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/5] Fix fetch regression with transport helpers
Message-ID: <20190605112713.GA14027@sigill.intra.peff.net>
References: <20190604021330.16130-1-felipe.contreras@gmail.com>
 <nycvar.QRO.7.76.6.1906051005060.1775@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1906051005060.1775@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 05, 2019 at 10:12:12AM +0200, Johannes Schindelin wrote:

> This fails on macOS, in t5601, both in our osx-clang and osx-gcc jobs, as
> well as in the StaticAnalysis job. For details, see
> https://dev.azure.com/gitgitgadget/git/_build/results?buildId=10206

Hmm. I'm having a hard time seeing why (and I can't seem to reproduce it
locally on a case-insensitive HFS+ filesystem under Linux).

In particular, if the problem is here:

> expecting success:
> 	grep X icasefs/warning &&
> 	grep x icasefs/warning &&
> 	test_i18ngrep "the following paths have collided" icasefs/warning
> 
> ++ grep X icasefs/warning
> error: last command exited with $?=1
> not ok 99 - colliding file detection

then that implies it has to do with the checkout phase, which Felipe's
patch doesn't touch. Later in the log we see the actual file contents
(I'm confused as to how this gets here; it looks like debugging bits
that were added after the main script?):

  2019-06-05T07:58:37.7961890Z Cloning into 'bogus'...
  2019-06-05T07:58:37.7962430Z done.
  2019-06-05T07:58:37.7963360Z warning: the following paths have collided (e.g. case-sensitive paths
  2019-06-05T07:58:37.7964300Z on a case-insensitive filesystem) and only one from the same
  2019-06-05T07:58:37.7964880Z colliding group is in the working tree:
  2019-06-05T07:58:37.7965290Z 
  2019-06-05T07:58:37.7966250Z   'x'

whereas a succeeding test expects us to mention both 'x' and 'X'.

So we _did_ find the collision, but somehow 'X' was not reported.
Looking at the code, I'm not even sure how that could happen. Given that
this process does involve looking at stat data, it makes me wonder if
there could be some raciness involved. But again, I'm scratching my head
as to how exactly, and I couldn't reproduce it under load or with some
carefully inserted sleep() calls.

And it looks like it did reproduce twice on Azure.

Can somebody who has osx locally reproduce this? Or is there a way to
interactively access the Azure environment to dig further?

> My guess is that your changes remove something that was expected before,
> and is still expected, and that this was only tested on Linux, and only on
> a file system with case-sensitive file names.

It sounds like you're suggesting that changes to the test script subtly
affected the later state. Which is indeed a common culprit. But the
changes in Felipe's series were all to t5801, not the failing t5601. Am
I misunderstanding what you mean?

-Peff
