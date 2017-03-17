Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F1FB20951
	for <e@80x24.org>; Fri, 17 Mar 2017 16:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbdCQQmq (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 12:42:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:45979 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751010AbdCQQmb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 12:42:31 -0400
Received: (qmail 3574 invoked by uid 109); 17 Mar 2017 14:55:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Mar 2017 14:55:08 +0000
Received: (qmail 3455 invoked by uid 111); 17 Mar 2017 14:55:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Mar 2017 10:55:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Mar 2017 10:55:05 -0400
Date:   Fri, 17 Mar 2017 10:55:05 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] tests: create an interactive gdb session with the
 'debug' helper
Message-ID: <20170317145504.utysxd4qqaqetm7t@sigill.intra.peff.net>
References: <20170317144646.9349-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170317144646.9349-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 17, 2017 at 03:46:46PM +0100, SZEDER Gábor wrote:

> The 'debug' test helper is supposed to facilitate debugging by running
> a command of the test suite under gdb.  Unfortunately, its usefulness
> is severely limited, because that gdb session is not interactive,
> since the test's, and thus gdb's standard input is attached to
> /dev/null (for a good reason, see 781f76b15 (test-lib: redirect stdin
> of tests, 2011-12-15)).
> 
> Re-attach the original standard input in the debug helper, thus
> creating an interactive gdb session, which is much much more useful.

Yeah, I think I've had to do a similar hack manually. This is an obvious
improvement. Though...

> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index bd357704c..9567dc986 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -154,7 +154,7 @@ test_pause () {
>  #
>  # Example: "debug git checkout master".
>  debug () {
> -	 GIT_TEST_GDB=1 "$@"
> +	 GIT_TEST_GDB=1 "$@" <&6
>  }

Your stderr and stdout may be redirected, too. That's usually not a big
problem because you'll be using "-v", but perhaps this should add:

  >&3 2>&4

to be on the safe side. That covers running without "-v", as well as
cases where the test script is redirecting output (I _actually_ wish gdb
behaved like perl's debugger and unconditionally used the terminal,
retaining existing redirections, but I AFAIK there's no easy way to get
it to do that).

-Peff
