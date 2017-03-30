Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 485DC20958
	for <e@80x24.org>; Thu, 30 Mar 2017 06:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754931AbdC3GXn (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 02:23:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:53998 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754762AbdC3GXn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 02:23:43 -0400
Received: (qmail 11656 invoked by uid 109); 30 Mar 2017 06:23:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Mar 2017 06:23:40 +0000
Received: (qmail 29128 invoked by uid 111); 30 Mar 2017 06:23:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Mar 2017 02:23:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Mar 2017 02:23:37 -0400
Date:   Thu, 30 Mar 2017 02:23:37 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] update-index: fix xgetcwd() related memory leak
Message-ID: <20170330062337.rwd2u5k7s57zczuo@sigill.intra.peff.net>
References: <20170330062208.29018-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170330062208.29018-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 30, 2017 at 08:22:08AM +0200, Christian Couder wrote:

> As xgetcwd() returns an allocated buffer, we should free this
> buffer when we don't need it any more.
> 
> This was found by Coverity.
> 
> Reported-by: Jeff King <peff@peff.net>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/update-index.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index d74d72cc7f..ebfc09faa0 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -125,12 +125,16 @@ static int test_if_untracked_cache_is_supported(void)
>  	struct stat st;
>  	struct stat_data base;
>  	int fd, ret = 0;
> +	char *cwd;
>  
>  	strbuf_addstr(&mtime_dir, "mtime-test-XXXXXX");
>  	if (!mkdtemp(mtime_dir.buf))
>  		die_errno("Could not make temporary directory");
>  
> -	fprintf(stderr, _("Testing mtime in '%s' "), xgetcwd());
> +	cwd = xgetcwd();
> +	fprintf(stderr, _("Testing mtime in '%s' "), cwd);
> +	free(cwd);
> +

Yep, this solution looks obviously correct to me.

-Peff
