Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D895A1F453
	for <e@80x24.org>; Tue, 23 Oct 2018 22:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbeJXGZj (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 02:25:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:51874 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725948AbeJXGZi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 02:25:38 -0400
Received: (qmail 11281 invoked by uid 109); 23 Oct 2018 22:00:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 23 Oct 2018 22:00:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27625 invoked by uid 111); 23 Oct 2018 21:59:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 23 Oct 2018 17:59:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Oct 2018 18:00:19 -0400
Date:   Tue, 23 Oct 2018 18:00:19 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com, chriscool@tuxfamily.org,
        l.s.r@web.de
Subject: Re: [PATCH v2 1/2] commit-slabs: move MAYBE_UNUSED out
Message-ID: <20181023220019.GA31613@sigill.intra.peff.net>
References: <CACsJy8AXjhbY9WWjYtMk128TZHLBCf4Ye4fe-ryXhoP9j2jtdw@mail.gmail.com>
 <20181023215020.18550-1-carenas@gmail.com>
 <20181023215020.18550-2-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181023215020.18550-2-carenas@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 23, 2018 at 02:50:19PM -0700, Carlo Marcelo Arenas Belón wrote:

> after 36da893114 ("config.mak.dev: enable -Wunused-function", 2018-10-18)
> it is expected to be used to prevent -Wunused-function warnings for code
> that was macro generated

Makes sense.

> diff --git a/commit-slab-impl.h b/commit-slab-impl.h
> index ac1e6d409a..5c0eb91a5d 100644
> --- a/commit-slab-impl.h
> +++ b/commit-slab-impl.h
> @@ -1,10 +1,10 @@
>  #ifndef COMMIT_SLAB_IMPL_H
>  #define COMMIT_SLAB_IMPL_H
>  
> -#define MAYBE_UNUSED __attribute__((__unused__))
> +#include "git-compat-util.h"

We shouldn't need to include git-compat-util.h, as the C files would
already do so, via this rule in CodingGuidelines:

   - The first #include in C files, except in platform specific compat/
   implementations, must be either "git-compat-util.h", "cache.h" or
   "builtin.h".  You do not have to include more than one of these.

(and if there is a case that does not, we should fix that).

>  #define implement_static_commit_slab(slabname, elemtype) \
> -	implement_commit_slab(slabname, elemtype, static MAYBE_UNUSED)
> +	implement_commit_slab(slabname, elemtype, MAYBE_UNUSED static)

Is this hunk necessary?

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 9a64998b24..e4d3967a23 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -408,6 +408,8 @@ static inline char *git_find_last_dir_sep(const char *path)
>  #define LAST_ARG_MUST_BE_NULL
>  #endif
>  
> +#define MAYBE_UNUSED __attribute__((__unused__))
> +
>  #include "compat/bswap.h"

Looks good.

-Peff
