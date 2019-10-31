Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90AB61F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 18:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbfJaSLR (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 14:11:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:35206 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729027AbfJaSLR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 14:11:17 -0400
Received: (qmail 18741 invoked by uid 109); 31 Oct 2019 18:11:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 31 Oct 2019 18:11:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4086 invoked by uid 111); 31 Oct 2019 18:14:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Oct 2019 14:14:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Oct 2019 14:11:16 -0400
From:   Jeff King <peff@peff.net>
To:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] configure.ac: define ICONV_OMITS_BOM if necessary
Message-ID: <20191031181116.GC2133@sigill.intra.peff.net>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
 <20191031092618.29073-3-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191031092618.29073-3-congdanhqx@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 31, 2019 at 04:26:17PM +0700, Doan Tran Cong Danh wrote:

> From commit 79444c9294, ("utf8: handle systems that don't write BOM for
> UTF-16", 2019-02-12), we're supporting those systems with iconv that
> omits BOM with:
> 
>     make ICONV_OMITS_BOM=Yes
> 
> However, typing the flag all the time is cumbersome and error-prone.
> 
> Add a checking into configure script to detect this flag automatically.

I think it's worth adding this to the configure script, but note that
you can also do:

  echo ICONV_OMITS_BOM=Yes >config.mak

and then "make" by itself will do what you want (it's still annoying and
error-prone to realize you have to specify the flag in the first place).

> diff --git a/configure.ac b/configure.ac
> index a43b476402..790b53bbdc 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -690,6 +690,28 @@ fi
>  
>  fi
>  
> +#
> +# Define ICONV_OMITS_BOM if you are on a system which
> +# iconv omits bom for utf-{16,32}
> +if test -z "$NO_ICONV"; then
> +AC_CACHE_CHECK([whether iconv omits bom for utf-16 and utf-32],
> + [ac_cv_iconv_omits_bom],
> +[
> +if test "x$cross_compiling" = xyes; then
> +	AC_MSG_FAILURE([please provide ac_cv_iconv_omits_bom])
> +elif test `printf a | iconv -f utf-8 -t utf-16 | wc -c` = 2; then

The ICONV_OMITS_BOM flag is about the libc iconv that Git will be linked
against. But this is checking the iconv tool. For a system that is using
musl across the board, that would work. But it might not always be the
case (in particular, I don't know if people statically link some
binaries against musl; certainly I've seen people do it with dietlibc).

I think we should be test-compiling a small program, similar to the way
OLD_ICONV works (though I guess we may even need to run the result to
see what happens).

-Peff
