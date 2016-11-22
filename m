Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27D87208AD
	for <e@80x24.org>; Tue, 22 Nov 2016 17:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754975AbcKVRtu (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 12:49:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:46179 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754732AbcKVRtt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 12:49:49 -0500
Received: (qmail 7371 invoked by uid 109); 22 Nov 2016 17:49:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 22 Nov 2016 17:49:48 +0000
Received: (qmail 30688 invoked by uid 111); 22 Nov 2016 17:50:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 22 Nov 2016 12:50:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Nov 2016 12:49:46 -0500
Date:   Tue, 22 Nov 2016 12:49:46 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] merge-recursive.c: use QSORT macro
Message-ID: <20161122174946.jy5at4g7rifu3und@sigill.intra.peff.net>
References: <20161122123019.7169-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20161122123019.7169-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 22, 2016 at 07:30:19PM +0700, Nguyễn Thái Ngọc Duy wrote:

> This is the follow up of rs/qsort series, merged in b8688ad (Merge
> branch 'rs/qsort' - 2016-10-10), where coccinelle was used to do
> automatic transformation.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>   coccinelle missed this place, understandably, because it can't know
>   that
>   
>       sizeof(*entries->items)
>   
>   is the same as
>   
>       sizeof(*df_name_compare.items)
>   
>   without some semantic analysis.

That made me wonder why "entries" is used at all. Does it point to the
same struct? But no, df_name_compare is a string list we create with the
same list of strings.

Which is why...

> -	qsort(df_sorted_entries.items, entries->nr, sizeof(*entries->items),
> +	QSORT(df_sorted_entries.items, entries->nr,
>  	      string_list_df_name_compare);

...it's OK to use entries->nr here, and not df_sorted_entries.nr. It
still seems a bit odd, though. Maybe it's worth making this:

  QSORT(df_sorted_entries.items, df_sorted_entries.nr,
        string_list_df_name_compare);

while we're at it. Another possibility is:

  df_sorted_entries.cmp = string_list_df_name_compare;
  string_list_sort(&df_sorted_entries);

It's not any shorter, but maybe it's conceptually simpler.

-Peff
