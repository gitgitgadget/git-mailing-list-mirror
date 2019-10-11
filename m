Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 115F31F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 06:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfJKGep (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 02:34:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:45424 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726481AbfJKGep (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 02:34:45 -0400
Received: (qmail 13395 invoked by uid 109); 11 Oct 2019 06:34:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 Oct 2019 06:34:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30810 invoked by uid 111); 11 Oct 2019 06:37:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Oct 2019 02:37:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Oct 2019 02:34:43 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Git in Outreachy December 2019?
Message-ID: <20191011063443.GB25741@sigill.intra.peff.net>
References: <nycvar.QRO.7.76.6.1909171158090.15067@tvgsbejvaqbjf.bet>
 <20190917120230.GA27531@szeder.dev>
 <nycvar.QRO.7.76.6.1909231444590.15067@tvgsbejvaqbjf.bet>
 <20190923165828.GA27068@szeder.dev>
 <nycvar.QRO.7.76.6.1909261257160.15067@tvgsbejvaqbjf.bet>
 <20190926132852.GF2637@szeder.dev>
 <nycvar.QRO.7.76.6.1909262138450.15067@tvgsbejvaqbjf.bet>
 <20190926214448.GI2637@szeder.dev>
 <20190927221857.GB31237@sigill.intra.peff.net>
 <20191009172551.GI29845@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191009172551.GI29845@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 09, 2019 at 07:25:51PM +0200, SZEDER Gábor wrote:

> > Probably they'd be easy enough to fix (and they're out of tree anyway),
> > so I'm not really arguing against the escape hatch exactly. Mostly I'm
> > just surprised that if I introduced 3 cases (out of probably a dozen
> > scripts), I'm surprised that more contributors aren't accidentally doing
> > so upstream.
> 
> I see it a bit differently.  Over a decade we gathered about
> twenty-something such tests cases: that's about two cases per year.
> You added three such cases in about a year and a half: that's two
> cases per year.  The numbers add up perfectly, you singlehandedly took
> care of everything ;)

Those cases are actually much older than that. I just didn't bother to
clean them up until recently. So my rate is even lower :)

>   - Some shells do include file descriptor redirections in the trace
>     output, and it varies between implementations to which fd the
>     trace of the redirection goes.
>     
>       - 'ksh/ksh93' and NetBSD's /bin/sh send the trace of
>         redirections to the "wrong" fd, in the sense that e.g. the
>         trace of commands invoked in 'test_must_fail' goes to the
>         function's standard error, and checking its stderr with
>         'test_cmp' would then fail.
>  
>         (But 'ksh/ksh93' doesn't really matter, because they don't
>         support the 'local' keyword, so they fail a bunch of tests
>         even without '-x' anyway.)
> 
>         I don't think we can do anything about these shells.

Yeah, unless somebody is complaining, I don't know that it's worth
worrying about too much. The test suite is certainly useful without
being able to use "-x" on every single test run (you can still run it
without "-x" obviously, or selectively use "-x" to debug a single test
or script). So if it is only unreliable on a few tests on a few obscure
shells, we can probably live with it until somebody demonstrates a
real-world problem (e.g., that they're running automated CI on an
obscure platform that is stuck with an old shell, and really want "-x
--verbose-log" to get more verbose failures).

>   - We do call 'test_have_prereq' from within test cases as well,
>     notably from the 'test_i18ngrep', 'test_i18ncmp' and
>     'test_ln_s_add' helper functions.  In those cases all trace output
>     from 'test_have_prereq' is included in the test case's trace
>     output, which means that during the first invocation:
> 
>       - there is lots of distracting and confusing trace output, as
>         the script evaluating the prereq is passed around to a bunch
>         of functions.

Yeah, I think this is probably an issue even with bash.

>     As far as 'test_i18ngrep' is concerned, which accounts for the
>     majority of 'test_have_prereq' invocations within test cases, I
>     don't understand why it uses 'test_have_prereq' in the first place
>     instead of checking the GIT_TEST_GETTEXT_POISON environment
>     variable; and 6cdccfce1e (i18n: make GETTEXT_POISON a runtime
>     option, 2018-11-08) doesn't give me any insight.

I think it's just that checking the environment variable is non-trivial:
we invoke env--helper to handle bool interpretation. So we'd prefer to
cache the result (and not to run it at all if a test script doesn't use
i18ngrep, though it's perhaps ubiquitous enough that we should just run
it up front for every script).

>     I recall that some months ago we discussed the idea of how to
>     disable trace output from within test helper functions; that would
>     help with this 'test_have_prereq' issue as well, at least in case
>     of the more "common" shells.

That might be worth doing, though IIRC it got kind of hairy. :)

-Peff
