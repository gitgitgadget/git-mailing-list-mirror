Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1893AC432C3
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 16:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C3F2073F
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 16:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbfKZQJg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 11:09:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:32976 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728118AbfKZQJf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 11:09:35 -0500
Received: (qmail 2596 invoked by uid 109); 26 Nov 2019 16:09:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Nov 2019 16:09:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3169 invoked by uid 111); 26 Nov 2019 16:13:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 26 Nov 2019 11:13:38 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 26 Nov 2019 11:09:34 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch: use skip_prefix() instead of starts_with()
Message-ID: <20191126160934.GD25729@sigill.intra.peff.net>
References: <f6ed729b-3cd3-a91a-d69d-4960e4a0524f@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6ed729b-3cd3-a91a-d69d-4960e4a0524f@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 26, 2019 at 12:18:26PM +0100, René Scharfe wrote:

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 863c858fde..02e8619618 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -954,18 +954,12 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>  				kind = "";
>  				what = "";
>  			}
> -			else if (starts_with(rm->name, "refs/heads/")) {
> +			else if (skip_prefix(rm->name, "refs/heads/", &what))
>  				kind = "branch";
> -				what = rm->name + 11;
> -			}
> -			else if (starts_with(rm->name, "refs/tags/")) {
> +			else if (skip_prefix(rm->name, "refs/tags/", &what))
>  				kind = "tag";
> -				what = rm->name + 10;
> -			}
> -			else if (starts_with(rm->name, "refs/remotes/")) {
> +			else if (skip_prefix(rm->name, "refs/remotes/", &what))
>  				kind = "remote-tracking branch";
> -				what = rm->name + 13;
> -			}
>  			else {

Yep, this one looks obviously correct. We were already mutating "what",
so this just does it inside skip_prefix(). Much nicer.

-Peff
