Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6FAE211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 05:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbeLEFu0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 00:50:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:59392 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726082AbeLEFu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 00:50:26 -0500
Received: (qmail 638 invoked by uid 109); 5 Dec 2018 05:50:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Dec 2018 05:50:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28191 invoked by uid 111); 5 Dec 2018 05:49:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 05 Dec 2018 00:49:54 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Dec 2018 00:50:24 -0500
Date:   Wed, 5 Dec 2018 00:50:24 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] test-lib: add the '--stress' option to run a
 test repeatedly under load
Message-ID: <20181205055024.GG12284@sigill.intra.peff.net>
References: <20181204163457.15717-1-szeder.dev@gmail.com>
 <20181204163457.15717-4-szeder.dev@gmail.com>
 <87muplyxfn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87muplyxfn.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 04, 2018 at 07:11:08PM +0100, Ævar Arnfjörð Bjarmason wrote:

> It's a frequent annoyance of mine in the test suite that I'm
> e.g. running t*.sh with some parallel "prove" in one screen, and then I
> run tABCD*.sh manually, and get unlucky because they use the same trash
> dir, and both tests go boom.
> 
> You can fix that with --root, which is much of what this patch does. My
> one-liner for doing --stress has been something like:
> 
>     perl -E 'say ++$_ while 1' | parallel --jobs=100% --halt-on-error soon,fail=1 './t0000-basic.sh --root=trash-{} -v'
> 
> But it would be great if I didn't have to worry about that and could
> just run two concurrent:
> 
>     ./t0000-basic.sh
> 
> So I think we could just set some env variable where instead of having
> the predictable trash directory we have a $TRASHDIR.$N as this patch
> does, except we pick $N by locking some test-runs/tABCD.Nth file with
> flock() during the run.

That actually sounds kind of annoying when doing a single run, since now
you have this extra ".N". I guess it would at least be predictable, and
I tend to tab-complete the trash dirs anyway.

I accomplish the same thing by doing my "big" runs using --root
specified in config.mak (which points to a RAM disk -- if you're not
using one to run the tests, you really should look into it, as it's way
faster). And then for one-offs, investigating failures, etc, I do "cd t
&& ./t0000-basic.sh -v -i", which naturally runs in the local directory.

-Peff
