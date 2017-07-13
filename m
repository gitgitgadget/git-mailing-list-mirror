Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DFAA20365
	for <e@80x24.org>; Thu, 13 Jul 2017 20:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753136AbdGMUzj (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 16:55:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:39994 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752961AbdGMUzi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 16:55:38 -0400
Received: (qmail 6369 invoked by uid 109); 13 Jul 2017 20:55:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 20:55:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5206 invoked by uid 111); 13 Jul 2017 20:55:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 16:55:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jul 2017 16:55:36 -0400
Date:   Thu, 13 Jul 2017 16:55:36 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v1 0/4] Teach 'run' perf script to read config files
Message-ID: <20170713205535.otzi3gjd63ubb2dm@sigill.intra.peff.net>
References: <20170713065050.19215-1-chriscool@tuxfamily.org>
 <20170713165840.e5cdw7pa2m6haaen@sigill.intra.peff.net>
 <CAP8UFD3VnpMuMpcfRcTwL4nRpOF5URj6zsQqiEWYwo=1pi5Phw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD3VnpMuMpcfRcTwL4nRpOF5URj6zsQqiEWYwo=1pi5Phw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2017 at 08:57:01PM +0200, Christian Couder wrote:

> >> We want to make it possible to store the parameters to the 'run'
> >> script in a config file. This will make it easier to store, reuse,
> >> share and compare parameters.
> >
> > Because perf-lib is built on test-lib, it already reads
> > GIT-BUILD-OPTIONS.
> 
> Actually the 'run' script also sources GIT-BUILD-OPTIONS, so maybe
> this is not necessary.

Ah, right. The one that comes via perf-lib gets the variables into the
test scripts themselves. But anything "run" would need itself would come
from the source it does itself. And that's where GIT_PERF_MAKE_OPTS has
an effect.

> Also are the variables in GIT-BUILD-OPTIONS exported already?

No, I don't think so. But because both "run" and the scripts themselves
source them, they're available more or less everywhere, except for
sub-processes inside the scripts.

> > And the Makefile copies several perf-related values
> > into it, including GIT_PERF_MAKE_OPTS and GIT_PERF_REPEAT_COUNT. So you
> > can already do:
> >
> >   echo 'GIT_PERF_REPEAT_COUNT = 10' >>config.mak
> >   echo 'GIT_PERF_MAKE_OPTS = CFLAGS="-O2" DEVELOPER=1' >>config.mak
> >   make
> 
> The "make" here might not even be needed as in the 'run' script
> "config.mak" is copied into the "build/$rev" directory where "make" is
> run to build the $rev version.

You need it to bake the config into GIT-BUILD-OPTIONS, which is the only
thing that gets read by "run" and the perf scripts. If you are
just setting MAKE_OPTS to things that your config.mak already sets, then
yes, you can skip that one.

-Peff
