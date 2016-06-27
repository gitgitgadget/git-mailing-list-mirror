Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3B092018A
	for <e@80x24.org>; Mon, 27 Jun 2016 19:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbcF0Tir (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 15:38:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:33646 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751639AbcF0Tip (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 15:38:45 -0400
Received: (qmail 4428 invoked by uid 102); 27 Jun 2016 19:38:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Jun 2016 15:38:45 -0400
Received: (qmail 12729 invoked by uid 107); 27 Jun 2016 19:39:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Jun 2016 15:39:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Jun 2016 15:38:42 -0400
Date:	Mon, 27 Jun 2016 15:38:42 -0400
From:	Jeff King <peff@peff.net>
To:	Eric Wong <e@80x24.org>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] gc: fix off-by-one error with gc.autoPackLimit
Message-ID: <20160627193842.GD10877@sigill.intra.peff.net>
References: <20160625011450.GA14293@dcvr.yhbt.net>
 <20160625020620.GA31290@sigill.intra.peff.net>
 <20160625025300.GA29053@dcvr.yhbt.net>
 <xmqqa8i9eqwn.fsf@gitster.mtv.corp.google.com>
 <20160625064647.GA20659@dcvr.yhbt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160625064647.GA20659@dcvr.yhbt.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jun 25, 2016 at 06:46:47AM +0000, Eric Wong wrote:

> This matches the documentation and allows gc.autoPackLimit=1
> to maintain a single pack without attempting a repack on every
> "git gc --auto" invocation.
> 
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  builtin/gc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/builtin/gc.c b/builtin/gc.c
> index c583aad..332bcf7 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -177,7 +177,7 @@ static int too_many_packs(void)
>  		 */
>  		cnt++;
>  	}
> -	return gc_auto_pack_limit <= cnt;
> +	return gc_auto_pack_limit < cnt;
>  }

Looks good, and I cannot think of any real downside. "0" is special for
"do not use this limit", so you now have no way of asking to gc every
time. But why would you want to? Asking for 1 pack is effectively "gc if
something happened, otherwise do nothing".

-Peff
