Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 711681F453
	for <e@80x24.org>; Thu,  7 Feb 2019 20:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfBGUtM (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 15:49:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:36602 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726691AbfBGUtM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 15:49:12 -0500
Received: (qmail 13678 invoked by uid 109); 7 Feb 2019 20:49:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Feb 2019 20:49:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19056 invoked by uid 111); 7 Feb 2019 20:49:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 07 Feb 2019 15:49:20 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Feb 2019 15:49:10 -0500
Date:   Thu, 7 Feb 2019 15:49:10 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] doc-diff: don't `cd_to_toplevel`
Message-ID: <20190207204910.GB28893@sigill.intra.peff.net>
References: <20190203230152.GA25608@sigill.intra.peff.net>
 <20190204205037.32143-1-martin.agren@gmail.com>
 <20190204233444.GC2366@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1902051050090.41@tvgsbejvaqbjf.bet>
 <xmqqimxyrs4w.fsf@gitster-ct.c.googlers.com>
 <20190206185520.GD10231@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1902071632280.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1902071632280.41@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 07, 2019 at 04:41:57PM +0100, Johannes Schindelin wrote:

> > I think this can be limited to the tests that failed, which makes things
> > much faster. I.e., we run the tests at the tip of topic X and see that
> > t1234 fails. We then go back to the fork point and we just need to run
> > t1234 again. If it succeeds, then we blame X for the failure. If it
> > fails, then we consider it a false positive.
> 
> If you mean merge bases by fork points, I wrote an Azure Pipeline to do
> that (so that I could use the cloud as kind of a fast computer), but that
> was still too slow.
> 
> Even when there are even only as much as 12 merge bases to test (which is
> the current number of merge bases between `next` and `pu`), a build takes
> roughly 6 minutes on Windows, and many tests take 1 minute or more to run
> (offenders like t7003 and t7610 take over 400 seconds, i.e. roughly 6
> minutes), we are talking about roughly 1.5h *just* to test the merge
> bases.

I was assuming you're testing individual topics from gitster/git here
(which admittedly is more CPU in total than just the integration
branches, but it at least parallelizes well).

So with that assumption, I was thinking that you'd just look for the
merge-base of HEAD and master, which should give you a single point for
most topics. For inter-twined topics there may be more merge bases, but
I actually think for our purposes here, just testing the most recent one
is probably OK. I.e., we're just trying to have a vague sense of whether
the test failure is due to new commits or old.

I think Junio's suggestion to just pick some common release points would
work OK in practice, too. It's possible that some other topic made it to
master with a breakage, but in most cases, I think these sorts of
failures are often more coarsely-grained (especially if Junio pays
attention to the CI results before merging).

-Peff
