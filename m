Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D19A1F454
	for <e@80x24.org>; Wed,  6 Nov 2019 11:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbfKFL3C (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 06:29:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:40514 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725890AbfKFL3C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 06:29:02 -0500
Received: (qmail 21095 invoked by uid 109); 6 Nov 2019 11:29:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Nov 2019 11:29:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23015 invoked by uid 111); 6 Nov 2019 11:32:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Nov 2019 06:32:21 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 6 Nov 2019 06:29:01 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] remote-curl: unbreak http.extraHeader with custom
 allocators
Message-ID: <20191106112901.GA25966@sigill.intra.peff.net>
References: <pull.453.git.1572991158.gitgitgadget@gmail.com>
 <pull.453.v2.git.1573034695.gitgitgadget@gmail.com>
 <3168ba2c9eadcf0cd7e4f2533c9306b5d2c627d0.1573034695.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3168ba2c9eadcf0cd7e4f2533c9306b5d2c627d0.1573034695.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 06, 2019 at 10:04:55AM +0000, Johannes Schindelin via GitGitGadget wrote:

> A naïve attempt at fixing this would move the call to
> `curl_global_init()` _before_ the config is parsed (i.e. before that
> call to `slist_append()`).
> 
> However, that does work, as we _also_ parse the config setting
> `http.sslbackend` and if found, call `curl_global_sslset()` which *must*
> be called before `curl_global_init()`, for details see:
> https://curl.haxx.se/libcurl/c/curl_global_sslset.html

Yikes, good catch. It didn't even occur to me that there might be curl
things we had to do _before_ calling curl_global_init().

> So let's instead make the config parsing entirely independent from
> cURL's data structures. Incidentally, this deletes two more lines than
> it introduces, which is nice.

Yes, I actually find the resulting code easier to read. I had feared
having to add an extra step to initialize the slist, but it's all
handled quite neatly in http_copy_default_headers().

>  http.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)

The patch itself looks good to me.

-Peff
