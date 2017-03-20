Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A25220323
	for <e@80x24.org>; Mon, 20 Mar 2017 04:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751467AbdCTEbk (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 00:31:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:47385 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750972AbdCTEbk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 00:31:40 -0400
Received: (qmail 25702 invoked by uid 109); 20 Mar 2017 04:31:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 04:31:38 +0000
Received: (qmail 29465 invoked by uid 111); 20 Mar 2017 04:31:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 00:31:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Mar 2017 00:31:34 -0400
Date:   Mon, 20 Mar 2017 00:31:34 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCHv2 1/2] tests: create an interactive gdb session with the
 'debug' helper
Message-ID: <20170320043134.exaiz6adzcxp4zld@sigill.intra.peff.net>
References: <CAM0VKj=k8kygEPpfX+-n0ODd70A8PEYAviKosvc0D34jT02N5w@mail.gmail.com>
 <20170318161400.19753-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170318161400.19753-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 18, 2017 at 05:13:59PM +0100, SZEDER Gábor wrote:

> The 'debug' test helper is supposed to facilitate debugging by running
> a command of the test suite under gdb.  Unfortunately, its usefulness
> is severely limited, because that gdb session is not interactive,
> since the test's, and thus gdb's standard input is redirected from
> /dev/null (for a good reason, see 781f76b15 (test-lib: redirect stdin
> of tests, 2011-12-15)).
> 
> Redirect gdb's standard file descriptors from/to the test
> environment's stdin, stdout and stderr in the 'debug' helper, thus
> creating an interactive gdb session (even in non-verbose mode), which
> is much, much more useful.
>
> [...]
>
>  debug () {
> -	 GIT_TEST_GDB=1 "$@"
> +	 GIT_TEST_GDB=1 "$@" <&6 >&5 2>&7
>  }

Yep, this looks fine to me.

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 86d77c16d..23c29bce6 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -342,6 +342,7 @@ fi
>  
>  exec 5>&1
>  exec 6<&0
> +exec 7>&2

And this obviously is required to keep stdout/stderr separate.

-Peff
