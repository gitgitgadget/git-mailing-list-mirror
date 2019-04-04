Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8FB1202BB
	for <e@80x24.org>; Thu,  4 Apr 2019 01:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfDDBgJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 21:36:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:46236 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726167AbfDDBgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 21:36:09 -0400
Received: (qmail 18412 invoked by uid 109); 4 Apr 2019 01:36:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 04 Apr 2019 01:36:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13173 invoked by uid 111); 4 Apr 2019 01:36:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 03 Apr 2019 21:36:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Apr 2019 21:36:07 -0400
Date:   Wed, 3 Apr 2019 21:36:07 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?QmrDtnJu?= Pettersson A 
        <bjorn.a.pettersson@ericsson.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bad performance when using git log --parents (used by gitk)
Message-ID: <20190404013606.GB4409@sigill.intra.peff.net>
References: <HE1PR0702MB3788FCDAB764252D9CBB42E5B0560@HE1PR0702MB3788.eurprd07.prod.outlook.com>
 <20190402132756.GB13141@sigill.intra.peff.net>
 <HE1PR0702MB378867A3A8F81CB475882A28B0560@HE1PR0702MB3788.eurprd07.prod.outlook.com>
 <nycvar.QRO.7.76.6.1904022017510.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1904022017510.41@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 02, 2019 at 08:20:05PM +0200, Johannes Schindelin wrote:

> > Hitting some quadratic complexity algorithm explains why the "degradation"
> > is so huge. And if I understand it correctly we are more or less "unlucky"
> > to hit such access patterns more often in the new repo.
> >
> > Anyway, nice to see that you already have some ideas regarding how to
> > improve this.
> 
> In the meantime, maybe the commit graph feature can help you?
> 
> 	git config --global core.commitGraph true
> 	git config --global gc.writeCommitGraph true
> 	git commit-graph write --reachable
> 
> The idea being that the commit graph extracts a lot of information
> pre-emptively and makes the lookup of those bits faster than unpacking the
> commits all the time.

I'd definitely encourage Björn (or anybody with a biggish repo) to check
out the commit-graph work, because it's really cool. But it won't help
much here, because the quadratic loop is just on linked-list insertion.
We're literally spending all of our time chasing pointers in memory.

-Peff
