Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8901120988
	for <e@80x24.org>; Sat, 15 Oct 2016 17:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753061AbcJORN2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Oct 2016 13:13:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:57887 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752343AbcJORN2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2016 13:13:28 -0400
Received: (qmail 1087 invoked by uid 109); 15 Oct 2016 17:13:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 15 Oct 2016 17:13:27 +0000
Received: (qmail 17794 invoked by uid 111); 15 Oct 2016 17:13:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 15 Oct 2016 13:13:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 15 Oct 2016 13:13:25 -0400
Date:   Sat, 15 Oct 2016 13:13:25 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] avoid pointer arithmetic involving NULL in FLEX_ALLOC_MEM
Message-ID: <20161015171325.k2jggjezfmhk3tz7@sigill.intra.peff.net>
References: <ccb15072-d949-fc84-ee45-45ba013f53c4@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ccb15072-d949-fc84-ee45-45ba013f53c4@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 15, 2016 at 06:23:11PM +0200, René Scharfe wrote:

> Calculating offsets involving a NULL pointer is undefined.  It works in
> practice (for now?), but we should not rely on it.  Allocate first and
> then simply refer to the flexible array member by its name instead of
> performing pointer arithmetic up front.  The resulting code is slightly
> shorter, easier to read and doesn't rely on undefined behaviour.

Yeah, this NULL computation is pretty nasty. I recall trying to get rid
of it, but I think it is impossible to do so portably while still using
the generic xalloc_flex() helper. I'm not sure why I didn't think of
just inlining it as you do here. It's not that many lines of code, and I
I agree the result is conceptually simpler.

>  #define FLEX_ALLOC_MEM(x, flexname, buf, len) do { \
> -	(x) = NULL; /* silence -Wuninitialized for offset calculation */ \
> -	(x) = xalloc_flex(sizeof(*(x)), (char *)(&((x)->flexname)) - (char *)(x), (buf), (len)); \
> +	size_t flex_array_len_ = (len); \
> +	(x) = xcalloc(1, st_add3(sizeof(*(x)), flex_array_len_, 1)); \
> +	memcpy((void *)(x)->flexname, (buf), flex_array_len_); \

This looks correct. I wondered at first why you bothered with
flex_array_len, but it is to avoid evaluating the "len" parameter
multiple times.

>  } while (0)
>  #define FLEXPTR_ALLOC_MEM(x, ptrname, buf, len) do { \
>  	(x) = xalloc_flex(sizeof(*(x)), sizeof(*(x)), (buf), (len)); \

Now that xalloc_flex() has only this one caller remaining, perhaps it
should just be inlined here, too, for simplicity.

-Peff
