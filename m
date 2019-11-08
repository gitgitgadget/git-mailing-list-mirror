Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 742071F454
	for <e@80x24.org>; Fri,  8 Nov 2019 22:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfKHWTu (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 17:19:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:43332 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726095AbfKHWTu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 17:19:50 -0500
Received: (qmail 23286 invoked by uid 109); 8 Nov 2019 22:19:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Nov 2019 22:19:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15575 invoked by uid 111); 8 Nov 2019 22:23:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 08 Nov 2019 17:23:14 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 8 Nov 2019 17:19:49 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] convert: use skip_iprefix() in validate_encoding()
Message-ID: <20191108221949.GA18519@sigill.intra.peff.net>
References: <a61b60e4-77f4-10a9-65ff-f78348d4c4b7@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a61b60e4-77f4-10a9-65ff-f78348d4c4b7@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 08, 2019 at 09:27:34PM +0100, René Scharfe wrote:

> @@ -285,15 +289,10 @@ static int validate_encoding(const char *path, const char *enc,
>  			 */
>  			const char *advise_msg = _(
>  				"The file '%s' contains a byte order "
> -				"mark (BOM). Please use UTF-%s as "
> +				"mark (BOM). Please use UTF-%.*s as "
>  				"working-tree-encoding.");
> -			const char *stripped = NULL;
> -			char *upper = xstrdup_toupper(enc);
> -			upper[strlen(upper)-2] = '\0';
> -			if (skip_prefix(upper, "UTF", &stripped))
> -				skip_prefix(stripped, "-", &stripped);
> -			advise(advise_msg, path, stripped);
> -			free(upper);
> +			int stripped_len = strlen(stripped) - strlen("BE");
> +			advise(advise_msg, path, stripped_len, stripped);

I think we could drop xstrdup_toupper() after this.

Of course it _could_ come in handy in another spot, but in most cases
you can use xstrdup_tolower() interchangeably (e.g., that would have
worked here). And even the tolower() variant is seldom used.

-Peff
