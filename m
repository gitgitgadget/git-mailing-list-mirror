Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC380C48BE6
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 07:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AB4A61352
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 07:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbhFNHqD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 03:46:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:54208 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232493AbhFNHqD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 03:46:03 -0400
Received: (qmail 546 invoked by uid 109); 14 Jun 2021 07:44:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 14 Jun 2021 07:44:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30770 invoked by uid 111); 14 Jun 2021 07:44:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 14 Jun 2021 03:44:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 14 Jun 2021 03:43:59 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] test: fix for TEST_OUTPUT_DIRECTORY
Message-ID: <YMcIv7q1ctyJ0EZn@coredump.intra.peff.net>
References: <20210609170520.67014-1-felipe.contreras@gmail.com>
 <YMWMuDbctae7tF6J@coredump.intra.peff.net>
 <60c627cac29b3_41f45208a7@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60c627cac29b3_41f45208a7@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 13, 2021 at 10:44:10AM -0500, Felipe Contreras wrote:

> > Unfortunately, this isn't a complete solution.
> 
> Software will never be perfect.
> 
> We don't need to wait for a perfect solution, all we need is something
> better than the current siuation.

Sure, but if you don't fully understand the situation (e.g., that --root
and TEST_OUTPUT_DIRECTORY are not equivalent), then you may end up
revisiting the incomplete fix later, or even making things worse (as
this patch did).

> > I think solving the whole issue would require a mechanism for passing
> > TEST_OUTPUT_DIRECTORY in a way that can't be overridden (whether in an
> > environment variable or the command-line).
> 
> Why do we even have TEST_OUTPUT_DIRECTORY in GIT-BUILD-OPTIONS? Looking
> for a reason there's 2d14e13c56 (test output: respect
> $TEST_OUTPUT_DIRECTORY, 2013-04-29), there it says it's for
> valgrind/analyze.sh.
> 
> I don't know who uses that script, or how. There's no documentaion,
> nothing on the mailing list, and nothing found on Google.

Perhaps 268fac6919 (Add a script to coalesce the valgrind outputs,
2009-02-04) is enlightening.

I don't know if anybody still uses it these days, though. I suspect it's
outlived its usefulness, in that we would typically not have any
valgrind errors at all (so coalescing them is not that interesting).

Possibly folks investigating leak-checking via valgrind could find it
useful, but even there I think LSan is a much better path forward.

> So maybe:
> 
> diff --git a/Makefile b/Makefile
> index c3565fc0f8..2e25489569 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2790,9 +2790,6 @@ GIT-BUILD-OPTIONS: FORCE
>         @echo PAGER_ENV=\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\' >>$@+
>         @echo DC_SHA1=\''$(subst ','\'',$(subst ','\'',$(DC_SHA1)))'\' >>$@+
>         @echo X=\'$(X)\' >>$@+
> -ifdef TEST_OUTPUT_DIRECTORY
> -       @echo TEST_OUTPUT_DIRECTORY=\''$(subst ','\'',$(subst ','\'',$(TEST_OUTPUT_DIRECTORY)))'\' >>$@+
> -endif

I don't personally have any problem with that. It does mean that "make
t1234-foo.sh" will behave differently than "./t1234-foo.sh", but that is
already true if you set GIT_TEST_OPTS.

-Peff
