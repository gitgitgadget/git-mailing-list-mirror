Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E73B81F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 14:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388818AbeGKPCQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 11:02:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:55322 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732602AbeGKPCQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 11:02:16 -0400
Received: (qmail 11686 invoked by uid 109); 11 Jul 2018 14:57:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 11 Jul 2018 14:57:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7703 invoked by uid 111); 11 Jul 2018 14:57:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 11 Jul 2018 10:57:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jul 2018 10:57:31 -0400
Date:   Wed, 11 Jul 2018 10:57:31 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] t/lib-httpd: avoid occasional failures when
 checking access.log
Message-ID: <20180711145730.GB15269@sigill.intra.peff.net>
References: <20180614123107.11608-1-szeder.dev@gmail.com>
 <20180711125647.16512-1-szeder.dev@gmail.com>
 <20180711125647.16512-4-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180711125647.16512-4-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 11, 2018 at 02:56:47PM +0200, SZEDER Gábor wrote:

> +# Requires one argument: the name of a file containing the expected stripped
> +# access log entries.
> +check_access_log() {
> +	sort "$1" >"$1".sorted &&
> +	strip_access_log >access.log.stripped &&
> +	sort access.log.stripped >access.log.sorted &&
> +	if ! test_cmp "$1".sorted access.log.sorted
> +	then
> +		test_cmp "$1" access.log.stripped
> +	fi
> +}

This will generate output showing both the unsorted and sorted
differences. Do we want to suppress the sorted ones (e.g., by just using
"cmp" directly)? I guess it doesn't matter unless there is an actual
test failure, but I just wonder if it would be confusing to see both.

> diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
> index 6cd986797d..a481e3989a 100755
> --- a/t/t5541-http-push-smart.sh
> +++ b/t/t5541-http-push-smart.sh
> @@ -43,15 +43,13 @@ test_expect_success 'no empty path components' '
>  	cd "$ROOT_PATH" &&
>  	git clone $HTTPD_URL/smart/test_repo.git/ test_repo_clone &&
>  
> -	strip_access_log >act &&
> +	check_access_log exp
> +'
>  
> +test_expect_success 'clear access log' '
>  	# Clear the log, so that it does not affect the "used receive-pack
>  	# service" test which reads the log too.
> -	#
> -	# We do this before the actual comparison to ensure the log is cleared.
> -	>"$HTTPD_ROOT_PATH"/access.log &&
> -
> -	test_cmp exp act
> +	>"$HTTPD_ROOT_PATH"/access.log
>  '

This took some head-scratching, mostly because of the original comment.
I thought the "before" here was referring to a timing issue (maybe
because we're talking about timing ;) ).

But it is really "make sure that a failed test here does not prevent us
from doing this cleanup". So the original really should have just
dropped that comment and added a test_when_finished. Bumping it into a
separate test as you have here accomplishes the same thing.

-Peff
