Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A4FB1F404
	for <e@80x24.org>; Fri, 26 Jan 2018 20:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751940AbeAZUc5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 15:32:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:59374 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751613AbeAZUc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 15:32:56 -0500
Received: (qmail 22735 invoked by uid 109); 26 Jan 2018 20:32:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 26 Jan 2018 20:32:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19208 invoked by uid 111); 26 Jan 2018 20:33:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 26 Jan 2018 15:33:35 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Jan 2018 15:32:54 -0500
Date:   Fri, 26 Jan 2018 15:32:54 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/10] t: make 'test_i18ngrep' more informative on failure
Message-ID: <20180126203254.GA1767@sigill.intra.peff.net>
References: <20180126123708.21722-1-szeder.dev@gmail.com>
 <20180126123708.21722-11-szeder.dev@gmail.com>
 <20180126185007.GG27618@sigill.intra.peff.net>
 <CAM0VKj=Qsbkog+rj94bZOk=G-XBsXAqQnRUo4eCXQq2LKjre-w@mail.gmail.com>
 <20180126192532.GA29438@sigill.intra.peff.net>
 <CAM0VKjkXKcwjt1J+KwHYwcaTpb5COXX9ojBWJ4b4b+PRS=AsZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKjkXKcwjt1J+KwHYwcaTpb5COXX9ojBWJ4b4b+PRS=AsZQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 26, 2018 at 09:26:38PM +0100, SZEDER Gábor wrote:

> Yeah, I knew about TEST_SHELL_PATH, but still:
> 
>   $ make -j4 TEST_SHELL_PATH=/bin/bash
>   <...>
>   $ cd t/
>   $ for t in t[0-9][0-9][0-9][0-9]-*.sh ; do "./$t" -x ; done >/dev/null 2>&1
>   $ grep '^failed [^0]$' test-results/*.counts |wc -l
>   44
> 
> The worst offender is t0008-ignores with 208 tests failing with '-x'...
> I suspect a setup test fails for some reason, and (most of) the other
> failed tests are just fallout; haven't dared to look yet :)

You cannot run "./$t" and expect TEST_SHELL_PATH to kick in; that starts
the test with the #! header, which is always /bin/sh (we don't "build"
the test scripts like we do regular scripts).

You need to run either:

  - make TEST_SHELL_PATH=/bin/bash test

or

  - bash $t -x

There _is_ one exception where it sometimes works, which is if you use
--tee or --verbose-log, in which case the shell script has to re-exec
itself, in which case it always pulls the value from GIT-BUILD-OPTIONS
to re-exec.

-Peff
