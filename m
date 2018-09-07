Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 770851F404
	for <e@80x24.org>; Fri,  7 Sep 2018 23:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbeIHEid (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 00:38:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:43378 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725731AbeIHEid (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 00:38:33 -0400
Received: (qmail 13594 invoked by uid 109); 7 Sep 2018 23:55:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Sep 2018 23:55:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24699 invoked by uid 111); 7 Sep 2018 23:55:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 07 Sep 2018 19:55:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Sep 2018 19:55:09 -0400
Date:   Fri, 7 Sep 2018 19:55:09 -0400
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] t5551-http-fetch-smart.sh: sort cookies before comparing
Message-ID: <20180907235508.GB32065@sigill.intra.peff.net>
References: <20180907232205.31328-1-tmz@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180907232205.31328-1-tmz@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 07, 2018 at 07:22:05PM -0400, Todd Zullinger wrote:

> With curl-7.61.1 cookies are sorted by creation-time¹.  Sort the output
> used in the 'cookies stored in http.cookiefile when http.savecookies
> set' test before comparing it to the expected cookies.
> 
> ¹ https://github.com/curl/curl/commit/e2ef8d6fa ("cookies: support
>   creation-time attribute for cookies", 2018-08-28)

According to that commit message, the creation-time sort is only for
cookies of the same length. But it's not clear to me if that just means
on-the-wire, and curl always stores by creation-time in the cookie file.

Either way, though, I guess it wouldn't matter for us as long as we
choose some arbitrary re-ordering for what curl produces (i.e., the
output of `sort`) and then make sure our "expect" output is in the same
order. Which is basically what your patch does. One question, though:

> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> index 771f36f9ff..538656bfef 100755
> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -215,7 +215,7 @@ test_expect_success 'cookies stored in http.cookiefile when http.savecookies set
>  	git config http.cookiefile cookies.txt &&
>  	git config http.savecookies true &&
>  	git ls-remote $HTTPD_URL/smart_cookies/repo.git master &&
> -	tail -3 cookies.txt >cookies_tail.txt &&
> +	tail -3 cookies.txt | sort >cookies_tail.txt &&
>  	test_cmp expect_cookies.txt cookies_tail.txt
>  '

We pick the bottom 3 before sorting. How do we know those are the three
we want to see?

...Ah, OK. The lines we are skipping are not actually cookies at all,
but just header cruft. I wonder if:

  grep "^[^#]" cookies.txt

would be a better way of doing that, but that is certainly not something
new.

So this fix looks fine. It might be worth a comment above the creation
of expect_cookies.txt to mention it must be in sorted order (of course
anybody modifying it would see a test failure).

> The in-development version of Fedora updated to the recently
> released curl-7.61.1 in the past few days.  This isn't
> breakage from the 2.19.0 cycle, but if the fix looks good to
> everyone it would be nice to include it.  That way other
> distributions and users who update git and curl to the most
> recent releases won't run into this test failure.
> 
> I tested this against Fedora 30 (curl-7.61.1) as well as
> previous releases from RHEL/CentOS 6/7 (7.19.7/7.29.0) and
> Fedora 27/28/29 (7.55.1/7.59.0/7.61.0).

You're pretty late in the 2.19 cycle, since the release is tentatively
scheduled for Sunday. Though since this is just touching the test
script, and since it looks Obviously Correct, I'm not opposed.

-Peff
