Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 105A81F597
	for <e@80x24.org>; Wed, 18 Jul 2018 17:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731531AbeGRSIJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 14:08:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:51258 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731525AbeGRSIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 14:08:09 -0400
Received: (qmail 9087 invoked by uid 109); 18 Jul 2018 17:29:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 18 Jul 2018 17:29:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 654 invoked by uid 111); 18 Jul 2018 17:29:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 18 Jul 2018 13:29:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jul 2018 13:29:13 -0400
Date:   Wed, 18 Jul 2018 13:29:13 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Andrii Dehtiarov <adehtiarov@google.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] gc: do not warn about too many loose objects
Message-ID: <20180718172913.GB2677@sigill.intra.peff.net>
References: <20180716214003.GH11513@aiede.svl.corp.google.com>
 <20180716214539.GL25189@sigill.intra.peff.net>
 <20180716220306.GI11513@aiede.svl.corp.google.com>
 <20180716224337.GB12482@sigill.intra.peff.net>
 <20180716225639.GK11513@aiede.svl.corp.google.com>
 <20180716232603.GB13570@sigill.intra.peff.net>
 <20180717015339.GL11513@aiede.svl.corp.google.com>
 <87d0vmck55.fsf@evledraar.gmail.com>
 <20180717202700.GE26218@sigill.intra.peff.net>
 <874lgwd6yd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874lgwd6yd.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 18, 2018 at 03:11:38PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Yeah, I agree that deferring repeated gc's based on time is going to run
> > into pathological corner cases. OTOH, what we've found at GitHub is that
> > "gc --auto" is quite insufficient for scheduling maintenance anyway
> > (e.g., if a machine gets pushes to 100 separate repositories in quick
> > succession, you probably want to queue and throttle any associated gc).
> 
> I'm sure you have better solutions for this at GitHub, but as an aside
> it might be interesting to add some sort of gc flock + retry setting for
> this use-case, i.e. even if you had 100 concurrent gc's due to
> too_many_*(), they'd wait + retry until they could get the flock on a
> given file.
> 
> Then again this is probably too specific, and could be done with a
> pre-auto-gc hook too..

Yeah, I think any multi-repo solution is getting way too specific for
Git, and the best thing we can do is provide a hook. I agree you could
probably do this today with a pre-auto-gc hook (if it skips gc it would
just queue itself and return non-zero). Or even just make a mark in a
database that says "there was some activity here".

Since we have so much other infrastructure sitting between the user and
Git anyway, we do that marking at a separate layer which is already
talking to a database. ;)

Anyway, I do agree with your general notion that this isn't the right
approach for many situations, and auto-gc is a better solution for many
cases.

-Peff
