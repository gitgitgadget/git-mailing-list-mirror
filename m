Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3AE51F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 17:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbfJaRlT (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 13:41:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:35164 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728561AbfJaRlT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 13:41:19 -0400
Received: (qmail 18536 invoked by uid 109); 31 Oct 2019 17:41:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 31 Oct 2019 17:41:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3318 invoked by uid 111); 31 Oct 2019 17:44:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Oct 2019 13:44:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Oct 2019 13:41:18 -0400
From:   Jeff King <peff@peff.net>
To:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] t0028: eliminate non-standard usage of printf
Message-ID: <20191031174118.GA2133@sigill.intra.peff.net>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
 <20191031092618.29073-2-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191031092618.29073-2-congdanhqx@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 31, 2019 at 04:26:16PM +0700, Doan Tran Cong Danh wrote:

> man 1p printf:
>    In addition to the escape sequences shown in the Base Definitions
>    volume of POSIX.1‐2008, Chapter 5, File Format Notation ('\\',
>    '\a', '\b', '\f', '\n', '\r', '\t', '\v'), "\ddd", where ddd is a
>    one, two, or three-digit octal number, shall be written as a byte
>    with the numeric value specified by the octal number.
> 
> printf '\xfe\xff' in an extension of some libc.

I don't think it's libc here at all, but rather the shell.

And as you note, dash does not handle this:

> With dash:
> $ printf '\xfe\xff' | xxd
> 00000000: 5c78 6665 5c78 6666                      \xfe\xff

Which makes me wonder how these tests worked at all for people on say,
Debian systems.

I think the answer is that they don't trigger this prereq:

>  write_utf16 () {
>  	if test_have_prereq NO_UTF16_BOM
>  	then
> -		printf '\xfe\xff'
> +		printf '\376\377'
>  	fi &&
>  	iconv -f UTF-8 -t UTF-16
>  }

which comes from:

  test_lazy_prereq NO_UTF16_BOM '
          test $(printf abc | iconv -f UTF-8 -t UTF-16 | wc -c) = 6
  '

Presumably on your system iconv is using musl's internal iconv, which
behaves differently than the glibc one.

So I think your patch is the right thing to do (hex escapes in shell
printf are definitely not portable), but we might want to note something
like:

  This wasn't caught by most people running the tests, even though
  common shells like dash don't handle hex escapes, because their
  systems don't trigger the NO_UTF16_BOM prereq. But systems with musl
  libc do; when combined with dash, the test fails.

-Peff
