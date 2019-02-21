Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0B8E1F453
	for <e@80x24.org>; Thu, 21 Feb 2019 15:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbfBUPKM (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 10:10:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:52750 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725858AbfBUPKM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 10:10:12 -0500
Received: (qmail 21127 invoked by uid 109); 21 Feb 2019 15:10:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Feb 2019 15:10:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13443 invoked by uid 111); 21 Feb 2019 15:10:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 21 Feb 2019 10:10:25 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Feb 2019 10:10:10 -0500
Date:   Thu, 21 Feb 2019 10:10:10 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG: 2.11-era rebase regression when @{upstream} is implicitly
 used
Message-ID: <20190221151009.GA24309@sigill.intra.peff.net>
References: <877ee2jyh3.fsf@evledraar.gmail.com>
 <20190221141042.GA21737@sigill.intra.peff.net>
 <87bm355h6p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bm355h6p.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 21, 2019 at 03:50:38PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > Those aren't using "--fork-point", so they're going to behave
> > differently. The default with no arguments is basically "--fork-point
> > @{u}".
> 
> Yeah, that's what it *should* do, but it's not equivalent to using
> --fork-point manually:
> 
>     # my series on top of origin/master
>     $ git rev-parse HEAD
>     2a67977d3f70fa7fc4bce89db24a1218dc9ab2aa
>     
>     # Junio's origin/master upstream
>     $ git rev-parse @{u}
>     35ee755a8c43bcb3c2786522d423f006c23d32df
>     
>     # Where my fork point is
>     $ git merge-base --fork-point @{u}
>     35ee755a8c43bcb3c2786522d423f006c23d32df
>     
>     # OK
>     $ git rebase 35ee755a8c43bcb3c2786522d423f006c23d32df
>     Current branch master is up to date.
>     
>     # OK
>     $ git rebase $(git merge-base --fork-point @{u})
>     Current branch master is up to date.
>     
>     # ???
>     $ git rebase
>     First, rewinding head to replay your work on top of it...
>     [...]

Have you tried with "git rebase --fork-point"? It does more than just
pass --fork-point to merge-base. It seems to also skip some of the "is
up to date", I think due to 1e0dacdbdb (rebase: omit patch-identical
commits with --fork-point, 2014-07-16).

I'm still not clear on whether my 4f21454b55 actually changed something
menaingful here, or if it's simply that you're getting the fork-point
behavior more consistently.

-Peff
