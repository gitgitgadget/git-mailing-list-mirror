Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D73EF1FC44
	for <e@80x24.org>; Tue,  9 May 2017 03:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751537AbdEID6K (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 23:58:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:47895 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750990AbdEID6K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 23:58:10 -0400
Received: (qmail 15622 invoked by uid 109); 9 May 2017 03:58:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 May 2017 03:58:10 +0000
Received: (qmail 19860 invoked by uid 111); 9 May 2017 03:58:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 May 2017 23:58:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 May 2017 23:58:07 -0400
Date:   Mon, 8 May 2017 23:58:07 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am: check return value of resolve_refdup before using
 hash
Message-ID: <20170509035807.2q7bzhu7cs4fcqkb@sigill.intra.peff.net>
References: <f0ca65bf-aaf9-2cd6-1deb-c55c9e7a8fa3@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0ca65bf-aaf9-2cd6-1deb-c55c9e7a8fa3@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 06, 2017 at 07:13:56PM +0200, René Scharfe wrote:

> If resolve_refdup() fails it returns NULL and possibly leaves its hash
> output parameter untouched.  Make sure to use it only if the function
> succeeded, in order to avoid accessing uninitialized memory.
> 
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  builtin/am.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/builtin/am.c b/builtin/am.c
> index a95dd8b4e6..2c52c820aa 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -2156,7 +2156,7 @@ static void am_abort(struct am_state *state)
>  	am_rerere_clear();
>  
>  	curr_branch = resolve_refdup("HEAD", 0, curr_head.hash, NULL);
> -	has_curr_head = !is_null_oid(&curr_head);
> +	has_curr_head = curr_branch && !is_null_oid(&curr_head);
>  	if (!has_curr_head)
>  		hashcpy(curr_head.hash, EMPTY_TREE_SHA1_BIN);

This one looks good to me (and no interesting ripple effects from
handling the error correctly :) ).

-Peff
