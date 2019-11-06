Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 730521F4C0
	for <e@80x24.org>; Wed,  6 Nov 2019 04:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731228AbfKFEQp (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 23:16:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:40144 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725768AbfKFEQp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 23:16:45 -0500
Received: (qmail 17763 invoked by uid 109); 6 Nov 2019 04:16:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Nov 2019 04:16:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19464 invoked by uid 111); 6 Nov 2019 04:20:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Nov 2019 23:20:04 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 5 Nov 2019 23:16:44 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] remote-curl: unbreak http.extraHeader with custom
 allocators
Message-ID: <20191106041644.GE4307@sigill.intra.peff.net>
References: <pull.453.git.1572991158.gitgitgadget@gmail.com>
 <d47a2aa5949a5dd3a10b89d9a77ebb89af6ba57e.1572991158.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d47a2aa5949a5dd3a10b89d9a77ebb89af6ba57e.1572991158.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 05, 2019 at 09:59:18PM +0000, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> In 93b980e58f5 (http: use xmalloc with cURL, 2019-08-15), we started to
> ask cURL to use `xmalloc()`, and if compiled with nedmalloc, that means
> implicitly a different allocator than the system one.
> 
> Which means that all of cURL's allocations and releases now _need_ to
> use that allocator.
> 
> However, the `http_options()` function used `slist_append()` to add any
> configured extra HTTP header(s) _before_ asking cURL to use `xmalloc()`,
> and `http_cleanup()` would release them _afterwards_, i.e. in the
> presence of custom allocators, cURL would attempt to use the wrong
> allocator to release the memory.
> 
> Let's fix this by moving the initialization _before_ the
> `http_options()` function is called.

Nicely explained.

Another option would be to separate our config mechanism from curl
entirely by putting the list of headers into a string_list, and then
transforming it later into a curl_slist. I don't think that really buys
us much, though. This is all inside http.c, so it's fairly contained.
It's not like other random parts of Git are using curl's slist before
calling http_init().

I did briefly grep around for other slist users, but they're all what
you'd expect: code in http-push.c and remote-curl.c creating header
lists while working with an active http request (so well after
http_init() has been called).

> ---
>  http.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

The patch itself looks good.

-Peff
