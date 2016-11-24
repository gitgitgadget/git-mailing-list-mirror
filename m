Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BC1D1FF76
	for <e@80x24.org>; Thu, 24 Nov 2016 20:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941167AbcKXUwp (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Nov 2016 15:52:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:46944 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933643AbcKXUwp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2016 15:52:45 -0500
Received: (qmail 15169 invoked by uid 109); 24 Nov 2016 20:52:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Nov 2016 20:52:44 +0000
Received: (qmail 13489 invoked by uid 111); 24 Nov 2016 20:53:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Nov 2016 15:53:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Nov 2016 15:52:42 -0500
Date:   Thu, 24 Nov 2016 15:52:42 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] merge-recursive.c: use string_list_sort instead of
 qsort
Message-ID: <20161124205242.ts4qhvfz2hvxez36@sigill.intra.peff.net>
References: <20161122123019.7169-1-pclouds@gmail.com>
 <20161124114536.22249-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20161124114536.22249-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 24, 2016 at 06:45:36PM +0700, Nguyễn Thái Ngọc Duy wrote:

> This started out to as a hunt for remaining qsort() calls after rs/qsort
> series because qsort() API is a bit easy to get wrong (*). However,
> since we have string_list_sort(), it's conceptually a better way to sort
> here.
> 
> (*) In this particular case, it's even more confusing when you sort one
> variable but you use the number of items and item size from an unrelated
> variable (from a first glance)

Makes sense, though I think I probably would have explained it in
reverse order:

  Merge-recursive sorts a string list using a raw qsort(), where it
  feeds the "items" from one struct but the "nr" and size fields from
  another struct. This isn't a bug because one list is a copy of the
  other, but it's unnecessarily confusing (and also caused our recent
  QSORT() cleanups via coccinelle to miss this call site).

  Let's use string_list_sort() instead, which is more concise and harder
  to get wrong. Note that we need to adjust our comparison function,
  which gets fed only the strings now, not the string_list_items. That's
  OK because we don't use the "util" field as part of our sort.

Feel free to use or ignore my description as you see fit. :)

> -static int string_list_df_name_compare(const void *a, const void *b)
> +static int string_list_df_name_compare(const char *one, const char *two)
>  {
> -	const struct string_list_item *one = a;
> -	const struct string_list_item *two = b;
> -	int onelen = strlen(one->string);
> -	int twolen = strlen(two->string);
> +	int onelen = strlen(one);
> +	int twolen = strlen(two);

I guess I haven't used string_list_sort() in a while, but I was
surprised to find that it just feeds the strings to the comparator. That
makes sense for using a raw strcmp() as the comparator, but I wonder if
any callers would ever want to take the util field into account (e.g.,
to break ties).

We don't seem to care here, though (which can be verified by reading the
code, but also because any mention of one->util would be a compilation
error after your patch). So I guess we can punt on it until the day that
some caller does need it.

-Peff
