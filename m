Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA8E720248
	for <e@80x24.org>; Thu, 14 Mar 2019 00:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfCNA0R (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 20:26:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:50024 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726218AbfCNA0R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 20:26:17 -0400
Received: (qmail 31113 invoked by uid 109); 14 Mar 2019 00:26:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Mar 2019 00:26:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17719 invoked by uid 111); 14 Mar 2019 00:25:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 13 Mar 2019 20:25:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Mar 2019 20:25:00 -0400
Date:   Wed, 13 Mar 2019 20:25:00 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: BUG: Race condition due to reflog expiry in "gc"
Message-ID: <20190314002459.GE31968@sigill.intra.peff.net>
References: <87tvg7brlm.fsf@evledraar.gmail.com>
 <xmqq1s3bh7ky.fsf@gitster-ct.c.googlers.com>
 <87sgvrax0o.fsf@evledraar.gmail.com>
 <20190313160204.GD24101@sigill.intra.peff.net>
 <87imwmbv7l.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87imwmbv7l.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 13, 2019 at 05:22:22PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > That's what the retry-with-timeout is supposed to address, so maybe it
> > works. But I wouldn't be surprised if it's insufficient in practice,
> > since the reflog code may walk big parts of the graph under lock,
> > checking reachability.
> 
> I suppose this can happen if the reflog for a given branch is so big
> that it takes us more than 100ms to parse it, but e.g. O(n) refs
> shouldn't matter, since we only hold the lock on one ref at a time.

I think it's more than parsing, though.

It's been a while since I've dug into the reflog expiration code, but my
recollection is that it can actually walk parts of the graph (looking
for what's reachable) while processing the reflog. That can be tens of
seconds in decent-sized repositories.

-Peff
