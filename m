Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A755820705
	for <e@80x24.org>; Tue,  6 Sep 2016 04:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750889AbcIFEHn (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 00:07:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:38583 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750726AbcIFEHn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 00:07:43 -0400
Received: (qmail 31441 invoked by uid 109); 6 Sep 2016 04:07:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Sep 2016 04:07:42 +0000
Received: (qmail 23739 invoked by uid 111); 6 Sep 2016 04:07:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Sep 2016 00:07:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Sep 2016 00:07:39 -0400
Date:   Tue, 6 Sep 2016 00:07:39 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
Cc:     git@vger.kernel.org, leho@conversionready.com
Subject: Re: 2.10.0: multiple versionsort.prereleasesuffix buggy?
Message-ID: <20160906040739.37otpk3l2wt7qfbb@sigill.intra.peff.net>
References: <20160905232145.fr46rgfb66eeymwp@sigill.intra.peff.net>
 <20160906010759.14883-1-szeder@ira.uka.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160906010759.14883-1-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 06, 2016 at 03:07:59AM +0200, SZEDER Gábor wrote:

> > So that seems wrong. Even weirder, if I set _only_ "-beta", I get:
> > 
> >   $ git tag -l --sort=version:refname | grep -v ^2.6.0
> >   2.6.0-beta-2
> >   2.6.0-beta-3
> >   2.6.0-beta-4
> >   2.6.0
> >   2.6.0-RC1
> >   2.6.0-RC2
> >   2.6.0-beta-1
> > 
> > Umm...what? beta-1 is sorted away from its companions? That's weird.
> > 
> > I wondered if the presence of "-" after the suffix ("beta-1" rather than
> > "beta1") would matter. It looks like that shouldn't matter, though; it's
> > purely doing a prefix match on "do these names differ at a prerelease
> > suffix".
> > 
> > But something certainly seems wrong.
> 
> Some of the weirdness is caused by the '-' at the _beginning_ of the
> suffixes, because versioncmp() gets confused by suffixes starting with
> the same character(s).

Oh, right, that makes sense. So it's effectively not finding _any_
suffix between X-RC1 and X-beta-1, because we only start looking after
"X-", and none of them match.

I am still confused why "2.6.0-beta-1" doesn't get sorted with its
peers. I'd guess that the comparison function doesn't actually provide a
strict ordering, so the results depend on the actual sort algorithm, and
which pairs it ends up comparing.

-Peff
