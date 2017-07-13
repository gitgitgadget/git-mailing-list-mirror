Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F3BF202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 16:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751216AbdGMQ6o (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 12:58:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:39318 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750881AbdGMQ6n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 12:58:43 -0400
Received: (qmail 29368 invoked by uid 109); 13 Jul 2017 16:58:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 16:58:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1251 invoked by uid 111); 13 Jul 2017 16:58:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 12:58:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jul 2017 12:58:41 -0400
Date:   Thu, 13 Jul 2017 12:58:41 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v1 0/4] Teach 'run' perf script to read config files
Message-ID: <20170713165840.e5cdw7pa2m6haaen@sigill.intra.peff.net>
References: <20170713065050.19215-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170713065050.19215-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2017 at 08:50:46AM +0200, Christian Couder wrote:

> Goal
> ~~~~
> 
> Using many long environment variables to give parameters to the 'run'
> script is error prone and tiring.
> 
> We want to make it possible to store the parameters to the 'run'
> script in a config file. This will make it easier to store, reuse,
> share and compare parameters.

Because perf-lib is built on test-lib, it already reads
GIT-BUILD-OPTIONS. And the Makefile copies several perf-related values
into it, including GIT_PERF_MAKE_OPTS and GIT_PERF_REPEAT_COUNT. So you
can already do:

  echo 'GIT_PERF_REPEAT_COUNT = 10' >>config.mak
  echo 'GIT_PERF_MAKE_OPTS = CFLAGS="-O2" DEVELOPER=1' >>config.mak
  make
  cd t/perf
  ./run <versions-and-scripts>

I suspect there are still a lot of things that could be made easier with
a config file, so I'm not against the concept. Your example here:

> [perf "with libpcre"]
>         makeOpts = DEVELOPER=1 CFLAGS='-g -O0' USE_LIBPCRE=YesPlease
> [perf "without libpcre"]
>         makeOpts = DEVELOPER=1 CFLAGS='-g -O0'

is a lot more compelling. But right now the perf suite is not useful at
all for comparing two builds of the same tree. For that, I think it
would be more useful if we could define a tuple of parameters for a run.
One of which could be the tree we're testing. Build opts are another.
Tested repository is another. And then we'd fill in a table of results
and let you slice up the table by any column (e.g., compare times for
runs against a single tree but with differing build options).

So then I think your config file primarily becomes about defining the
properties of each run. I'm not sure if it would look like what you're
starting on here or not.

-Peff
