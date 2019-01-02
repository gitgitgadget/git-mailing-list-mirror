Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 730001F775
	for <e@80x24.org>; Wed,  2 Jan 2019 00:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfABAUv (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Jan 2019 19:20:51 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:45627 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727189AbfABAUv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jan 2019 19:20:51 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 43TsCN0F85z5tl9;
        Wed,  2 Jan 2019 01:20:47 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 51852134;
        Wed,  2 Jan 2019 01:20:47 +0100 (CET)
Subject: Re: [PATCH] test-lib: check Bash version for '-x' without using shell
 arrays
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
        Carlo Arenas <carenas@gmail.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
References: <20190101231949.8184-1-szeder.dev@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <a82251fa-38e1-233e-50d3-3ed4850b4e11@kdbg.org>
Date:   Wed, 2 Jan 2019 01:20:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190101231949.8184-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.01.19 um 00:19 schrieb SZEDER Gábor:
> Alas, it has been reported that NetBSD's /bin/sh does complain about
> them:
> 
>    ./test-lib.sh: 327: Syntax error: Bad substitution
> 
> where line 327 contains the first ${BASH_VERSINFO[0]} array access.

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 0f1faa24b2..f47a191e3b 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -324,9 +324,12 @@ do
>   		# isn't executed with a suitable Bash version.
>   		if test -z "$test_untraceable" || {
>   		     test -n "$BASH_VERSION" && {
> -		       test ${BASH_VERSINFO[0]} -gt 4 || {
> -			 test ${BASH_VERSINFO[0]} -eq 4 &&
> -			 test ${BASH_VERSINFO[1]} -ge 1
> +		       bash_major=${BASH_VERSION%%.*}
> +		       bash_minor=${BASH_VERSION#*.}
> +		       bash_minor=${bash_minor%%.*}
> +		       test $bash_major -gt 4 || {
> +			 test $bash_major -eq 4 &&
> +			 test $bash_minor -ge 1
>   		       }
>   		     }
>   		   }
> 

Would it perhaps be simpler to just hide the syntax behind eval? Like

  		if test -z "$test_untraceable" || {
  		     test -n "$BASH_VERSION" && eval '
		       test ${BASH_VERSINFO[0]} -gt 4 || {
			 test ${BASH_VERSINFO[0]} -eq 4 &&
			 test ${BASH_VERSINFO[1]} -ge 1
		       }
  		     '

-- Hannes
