Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 139EC2047F
	for <e@80x24.org>; Wed, 26 Jul 2017 16:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751502AbdGZQya (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 12:54:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:49634 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750970AbdGZQya (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 12:54:30 -0400
Received: (qmail 7084 invoked by uid 109); 26 Jul 2017 16:54:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 26 Jul 2017 16:54:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27799 invoked by uid 111); 26 Jul 2017 16:54:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 26 Jul 2017 12:54:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Jul 2017 12:54:28 -0400
Date:   Wed, 26 Jul 2017 12:54:28 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v1 0/4] Teach 'run' perf script to read config files
Message-ID: <20170726165427.xh6ykoxjdibfqasp@sigill.intra.peff.net>
References: <20170713065050.19215-1-chriscool@tuxfamily.org>
 <20170713165840.e5cdw7pa2m6haaen@sigill.intra.peff.net>
 <CAP8UFD3VnpMuMpcfRcTwL4nRpOF5URj6zsQqiEWYwo=1pi5Phw@mail.gmail.com>
 <20170713205535.otzi3gjd63ubb2dm@sigill.intra.peff.net>
 <CAP8UFD1FXPtzHF1J5ZfcsmMiHrfXQOd=qEghJQp3eFYsVd-nxQ@mail.gmail.com>
 <CAP8UFD2NNBN=6GHbQPjz19hQUb+k_43YZBKimaA=3M6m4RH7Tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD2NNBN=6GHbQPjz19hQUb+k_43YZBKimaA=3M6m4RH7Tw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 26, 2017 at 05:58:09PM +0200, Christian Couder wrote:

> Actually after taking another look at that, it looks like the following happens:
> 
> 1) the run script sources the original GIT-BUILD-OPTIONS file from
> ../.. relative to its location
> 2) a git version is built in "build/$rev" using GIT_PERF_MAKE_OPTS
> which generates a new GIT-BUILD-OPTIONS file in "build/$rev/"
> 3) when the actual perf scripts are run they source the original
> GIT-BUILD-OPTIONS file (through perf-lib.sh which sources test-lib.sh)

Right, the perf scripts are run in the context of the "outer"
repository, and get their options from that one. I think that's
intentional, and does the right thing for GIT_PERF_* options. It's
possibly confusing if the tests really do want to know about the build
options for a particular test-build (like asking if it was built with
NO_PERL, for example).

I think in practice it works out OK, because we tend to do test-builds
that are similar to what's in the outer repo (because we copy
config.mak, and don't tend to add a lot of command-line options). But if
you put exotic options into your GIT_PERF_MAKE_OPTS, they won't be
reflected in the config that the test scripts see.

> I wonder how useful 1) is, as the variables sourced from original
> GIT-BUILD-OPTIONS are not used inside the "run" script and not
> available to its child processes as they are not exported.
> Is it just so that if people add GIT_PERF_* variables to their
> config.mak before building they can then have those variables used by
> the run script?

Exactly. I put GIT_PERF_MAKE_OPTS in my config.mak, and they end up
respected for each run without me having to specify them manually.

> I also wonder if it would be better at step 3) to source the
> GIT-BUILD-OPTIONS file generated at step 2) instead of the original
> one, because they can be different as the options in
> $GIT_PERF_MAKE_OPTS will be baked into the new GIT-BUILD-OPTIONS file.
> (Of course if $GIT_PERF_MAKE_OPTS was added to config.mak before
> building, then they will be in the original one too. But
> $GIT_PERF_MAKE_OPTS should work without that.)

I think that would make some cases work (build options for the tested
build), but I fear that it would break others (perf variables that
probably should be coming from the "outer" layer). Remember that test
builds may not be current versions and may not be forwarding those
variables via GIT-BUILD-OPTIONS. I think it's important that the bundle
of t/perf scripts act as a single unit that is driven primarily by the
currently checked-out version (and it's up to those scripts to handle
inconsistencies in old versions; see the $MODERN_GIT stuff I added a few
months ago.

Right now I don't think it has been a big problem, because the build
config tends to be the same.  But if we introduce more "properties" that
the user can tweak for a certain test run, this distinction is probably
going to cause more bugs. I'd almost say that the perf scripts should be
a project outside of git.git entirely, to eliminate confusion.

-Peff
