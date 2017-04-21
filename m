Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3DB0207BC
	for <e@80x24.org>; Fri, 21 Apr 2017 20:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161465AbdDUUPd (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 16:15:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:37942 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161454AbdDUUPc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 16:15:32 -0400
Received: (qmail 19333 invoked by uid 109); 21 Apr 2017 20:15:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Apr 2017 20:15:30 +0000
Received: (qmail 19933 invoked by uid 111); 21 Apr 2017 20:15:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Apr 2017 16:15:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Apr 2017 16:15:28 -0400
Date:   Fri, 21 Apr 2017 16:15:28 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>,
        David Turner <dturner@twosigma.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: abort when can't remove trash directory
Message-ID: <20170421201527.wdtxhox3p4g35gex@sigill.intra.peff.net>
References: <CAM0VKjm1m4v9vTpwFEejBuD3NuGm+kAdEV-_rzCXCz2G4m5NGw@mail.gmail.com>
 <20170420165230.5951-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170420165230.5951-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2017 at 06:52:30PM +0200, SZEDER Gábor wrote:

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 13b569682..e9e6f677d 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -761,9 +761,12 @@ test_done () {
>  			say "1..$test_count$skip_all"
>  		fi
>  
> -		test -d "$remove_trash" &&
> +		test -d "$remove_trash" ||
> +		error "Tests passed but trash directory already removed before test cleanup; aborting"

I think I found out why this "test -d" was here in the first place:

  $ ./t0000-basic.sh --debug
  [...]
  # passed all 77 test(s)
  1..77
  error: Tests passed but trash directory already removed before test cleanup; aborting

When --debug is in use, we do not set $remove_trash. The original was
relying on 'test -d ""' to return false.

I think this whole removal block should probably be moved inside a
conditional like:

  if test -n "$remove_trash"
  then
     ...
  fi

I also wonder if we should come up with a better name than
$remove_trash. A script which unknowingly overwrites that variable would
be disastrous.

Perhaps we should drop it entirely and just do:

  if test -z "$debug"
  then
     test -d "$TRASH_DIRECTORY" ||
     error "Tests passed but..."
  [and so forth...]
  fi

-Peff
