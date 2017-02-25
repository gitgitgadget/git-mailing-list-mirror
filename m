Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCDC2201B0
	for <e@80x24.org>; Sat, 25 Feb 2017 20:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbdBYUP0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 15:15:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:34132 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751885AbdBYUPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 15:15:25 -0500
Received: (qmail 3114 invoked by uid 109); 25 Feb 2017 20:15:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Feb 2017 20:15:25 +0000
Received: (qmail 2947 invoked by uid 111); 25 Feb 2017 20:15:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Feb 2017 15:15:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Feb 2017 15:15:22 -0500
Date:   Sat, 25 Feb 2017 15:15:22 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] commit: don't check for space twice when looking for
 header
Message-ID: <20170225201522.uan52fwey6zjosym@sigill.intra.peff.net>
References: <23989e76-24ba-90a4-91a9-9f66bfccb7c9@web.de>
 <b1d5c882-38b8-dd2d-2e5f-aafb8dfada81@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1d5c882-38b8-dd2d-2e5f-aafb8dfada81@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 25, 2017 at 08:27:40PM +0100, René Scharfe wrote:

> Both standard_header_field() and excluded_header_field() check if
> there's a space after the buffer that's handed to them.  We already
> check in the caller if that space is present.  Don't bother calling
> the functions if it's missing, as they are guaranteed to return 0 in
> that case, and remove the now redundant checks from them.

Makes sense, and I couldn't spot any errors in your logic or in the
code.

>  static inline int standard_header_field(const char *field, size_t len)
>  {
> -	return ((len == 4 && !memcmp(field, "tree ", 5)) ||
> -		(len == 6 && !memcmp(field, "parent ", 7)) ||
> -		(len == 6 && !memcmp(field, "author ", 7)) ||
> -		(len == 9 && !memcmp(field, "committer ", 10)) ||
> -		(len == 8 && !memcmp(field, "encoding ", 9)));
> +	return ((len == 4 && !memcmp(field, "tree", 4)) ||
> +		(len == 6 && !memcmp(field, "parent", 6)) ||
> +		(len == 6 && !memcmp(field, "author", 6)) ||
> +		(len == 9 && !memcmp(field, "committer", 9)) ||
> +		(len == 8 && !memcmp(field, "encoding", 8)));

Unrelated, but this could probably be spelled with a macro and strlen()
to avoid the magic numbers. It would probably be measurably slower for a
compiler which doesn't pre-compute strlen() on a string literal, though.

-Peff
