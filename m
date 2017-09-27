Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBF552047F
	for <e@80x24.org>; Wed, 27 Sep 2017 22:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752101AbdI0WJ2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 18:09:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:52766 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752086AbdI0WJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 18:09:27 -0400
Received: (qmail 1458 invoked by uid 109); 27 Sep 2017 22:09:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 22:09:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20488 invoked by uid 111); 27 Sep 2017 22:10:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 18:10:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Sep 2017 18:09:25 -0400
Date:   Wed, 27 Sep 2017 18:09:25 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        torvalds@linux-foundation.org
Subject: Re: [PATCH] diff: correct newline in summary for renamed files
Message-ID: <20170927220925.u622metv2fcdtcfq@sigill.intra.peff.net>
References: <CAGZ79kbCgTNaunfneWHP3xkLeXwW72CZZWs7Sv8A7QL_UYE_HQ@mail.gmail.com>
 <20170927215852.20163-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170927215852.20163-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 27, 2017 at 02:58:52PM -0700, Stefan Beller wrote:

> From: Linus Torvalds <torvalds@linux-foundation.org>
> 
> In 146fdb0dfe (diff.c: emit_diff_symbol learns about DIFF_SYMBOL_SUMMARY,
> 2017-06-29), the conversion from direct printing to the symbol emission
> dropped the new line character for renamed, copied and rewritten files.
> 
> Add the emission of a newline, add a test for this case.
> 
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Stefan Beller <sbeller@google.com>

The overall substance looks good, but...

> diff --git a/t/t4016-diff-quote.sh b/t/t4016-diff-quote.sh
> index 9c48e5c2c9..514056dd10 100755
> --- a/t/t4016-diff-quote.sh
> +++ b/t/t4016-diff-quote.sh
> @@ -30,6 +30,7 @@ test_expect_success setup '
>  	git add . &&
>  	git commit -m initial &&
>  	git mv "$P0.0" "R$P0.0" &&
> +	chmod a+x "R$P0.0" &&
>  	git mv "$P0.1" "R$P1.0" &&
>  	git mv "$P0.2" "R$P2.0" &&
>  	git mv "$P0.3" "R$P3.0" &&

Won't this chmod be a problem for platforms without an executable bit?
I think you'd need to use "update-index --chmod=+x" here, or require the
FILEMODE prereq.

The whole script is marked as !MINGW, so that makes it less of a
problem, but it's still possible have !FILEMODE on a Linux system, if
you're on a funny filesystem. That also seems like a good reason to make
sure this is in a script which is run more widely, since Windows folks
would want to run this test, too.

-Peff
