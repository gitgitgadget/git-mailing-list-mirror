Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B11891F405
	for <e@80x24.org>; Thu,  9 Aug 2018 21:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbeHJA0D (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 20:26:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:49230 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727324AbeHJA0D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 20:26:03 -0400
Received: (qmail 6324 invoked by uid 109); 9 Aug 2018 21:59:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 Aug 2018 21:59:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14248 invoked by uid 111); 9 Aug 2018 21:59:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 09 Aug 2018 17:59:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Aug 2018 17:59:13 -0400
Date:   Thu, 9 Aug 2018 17:59:13 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        pawelparuzel95@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2] clone: report duplicate entries on case-insensitive
 filesystems
Message-ID: <20180809215913.GB12441@sigill.intra.peff.net>
References: <20180807190110.16216-1-pclouds@gmail.com>
 <xmqq7el2km82.fsf@gitster-ct.c.googlers.com>
 <fc56d572-e333-2e05-2130-71b53e251a13@jeffhostetler.com>
 <20180808223139.GA3902@sigill.intra.peff.net>
 <xmqqbmace5i1.fsf@gitster-ct.c.googlers.com>
 <20180809142333.GB1439@sigill.intra.peff.net>
 <34b22185-a0bc-f712-b5e5-fc5e2697dcc2@jeffhostetler.com>
 <CABPp-BHiB_gR-dQbpJtSBYPJ5Om4Mv0ymnZFNocyTfbUotyBgw@mail.gmail.com>
 <20180809214430.GE11342@sigill.intra.peff.net>
 <CABPp-BEAybfJ8sojRwDbDjhcwk4VyQ26F1LnKyNLsg1fYS1fNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BEAybfJ8sojRwDbDjhcwk4VyQ26F1LnKyNLsg1fYS1fNA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 09, 2018 at 02:53:42PM -0700, Elijah Newren wrote:

> On Thu, Aug 9, 2018 at 2:44 PM Jeff King <peff@peff.net> wrote:
> > > The error message isn't quite as good, but does the user really need
> > > all the names of the file?  If so, we gave them enough information to
> > > figure it out, and this is a really unusual case anyway, right?
> > > Besides, now we're back to linear performance....
> >
> > Well, it's still quadratic when they run O(n) iterations of "git
> > ls-files -s | grep $colliding_oid". You've just pushed the second linear
> > search onto the user. ;)
> 
> Wouldn't that be their own fault for not running
>   git ls-files -s | grep -e $colliding_oid_1 ... -e $colliding_oid_n | sort -k 2
> ?   ;-)

Man, this thread is the gift that keeps on giving. :)

That's still quadratic, isn't it? You've just hidden the second
dimension in the single grep call.

Now since these are all going to be constant strings, in theory an
intelligent grep could stick them all in a search trie, and match each
line with complexity k, the length of the matched strings. And since
k=40, that's technically still linear overall.

-Peff
