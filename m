Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 573C11F45F
	for <e@80x24.org>; Tue,  7 May 2019 21:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfEGVXS (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 17:23:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:50898 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726582AbfEGVXS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 17:23:18 -0400
Received: (qmail 13223 invoked by uid 109); 7 May 2019 21:23:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 07 May 2019 21:23:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16838 invoked by uid 111); 7 May 2019 21:23:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 07 May 2019 17:23:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 May 2019 17:23:15 -0400
Date:   Tue, 7 May 2019 17:23:15 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 2/2] perf-lib.sh: remove GIT_TEST_INSTALLED from
 perf-lib.sh
Message-ID: <20190507212315.GA19955@sigill.intra.peff.net>
References: <20190506202451.GA19850@sigill.intra.peff.net>
 <20190506232309.28538-3-avarab@gmail.com>
 <20190507071630.GB28060@sigill.intra.peff.net>
 <871s1ais2s.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871s1ais2s.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 07, 2019 at 10:31:23AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > I'm not sure I get what's going on here. Why do we need the realpath in
> > aggregate.perl? We'd want to generate the same filename that "run"
> > decided to store things in, which we'd generate from the command-line
> > arguments (either passed on to us by "run", or direct from the user if
> > they're printing a previous run).
> 
> So this is part of the "has sucked since forever, future TODO" mentioned
> in 0/2.
> 
> I.e. if you pass "../.." as a path to "run" we'll try to discover a
> built/installed "git" in a "bindir" there, and then we need to do two
> things:
> 
>  1. Figure out a way to turn that into a filename sensible for the
>     *.times files.
>  2. Print some header showing that path in the aggregate output.
> 
> The "run" script will discover #1 for itself, that's what that "pwd &&
> tr -c ..." command is doing, but then we just pass "../.." again to
> aggregate.perl and have it figure it out again on its own, so it needs
> to duplicate the logic.
> 
> Just having both discover the absolute path all the time for #1 made
> things a lot simpler, e.g. if you do ../.. on v2.21.0 you'll get things
> like:
> 
>     _____.p0000-perf-lib-sanity.1.times
> 
> And with $PWD/../../ you'd get:
> 
>     _home_avar_g_git_t_perf______.p0000-perf-lib-sanity.1.times
> 
> Now this is all pretty & consistent. Any path to a "git" will always be
> turned into the absolute path, e.g.:
> 
>     _home_avar_g_git.p0000-perf-lib-sanity.1.times
> 
> And instead of "git" or ".." being printed in the aggregate header we
> print the path, e.g. "/home/avar/g/git".

OK. I sort of assumed we'd be sticking with the crappy "_____" for both
cases after your cleanup. But it really is changing behavior to name
things after the absolute path. I'd probably have split that out into
its own change, but I don't think it's worth revisiting at this point.

Thanks for explaining.

-Peff
