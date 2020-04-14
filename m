Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4F9C352BE
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 20:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76522206E9
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 20:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632923AbgDNUQ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:16:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:53678 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2632760AbgDNUQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Apr 2020 16:16:09 -0400
Received: (qmail 7484 invoked by uid 109); 14 Apr 2020 20:16:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Apr 2020 20:16:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1448 invoked by uid 111); 14 Apr 2020 20:26:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Apr 2020 16:26:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Apr 2020 16:16:06 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/2] date.c: allow fractional second part of ISO-8601
Message-ID: <20200414201606.GA1879688@coredump.intra.peff.net>
References: <20200414000324.GA2751707@camp.crustytoothpaste.net>
 <cover.1586856398.git.congdanhqx@gmail.com>
 <45676f4a7d001dbd25bbae531cc2ae5fc53936bb.1586856398.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45676f4a7d001dbd25bbae531cc2ae5fc53936bb.1586856398.git.congdanhqx@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 14, 2020 at 04:31:54PM +0700, Đoàn Trần Công Danh wrote:

> git-commit(1) says ISO-8601 is one of our supported date format.
> However, we only support RFC-3339 date format.
> 
> We can either:
> - Update documentation from ISO-8601 to RFC-3339
> - Add full support for ISO-8601
> 
> This series will try to add full support for ISO-8601.

That seems more like a cover letter for the full series. The important
thing in this patch is more like:

  ISO-8601 allows timestamps to have a fractional number of seconds. We
  represent time only in terms of whole seconds, so we never bothered
  parsing fractional seconds. However, it's better for us to parse and
  throw away the fractional part than to refuse to parse the timestamp
  at all.

> diff --git a/date.c b/date.c
> index b0d9a8421d..2f37397beb 100644
> --- a/date.c
> +++ b/date.c
> @@ -556,6 +556,8 @@ static int match_multi_number(timestamp_t num, char c, const char *date,
>  	case ':':
>  		if (num3 < 0)
>  			num3 = 0;
> +		else if (*end == '.' && isdigit(end[1]))
> +			strtol(end + 1, &end, 10);

I was a bit worried about this change hurting other cases where people
might use dots to separate numbers (but not mean a fraction). But the
two common ones I can think of should be OK:

  - 5.seconds.ago would never match because you look for a digit after
    the dot

  - a date like 2019.10.12 wouldn't match, because we're only looking
    after a ":", which heavily implies a time.

It might be worth covering those cases in tests if we're not already
doing so elsewhere.

-Peff
