Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5081D1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 07:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfAVHTY (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 02:19:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:43564 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726423AbfAVHTY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 02:19:24 -0500
Received: (qmail 6235 invoked by uid 109); 22 Jan 2019 07:19:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 22 Jan 2019 07:19:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3494 invoked by uid 111); 22 Jan 2019 07:19:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 22 Jan 2019 02:19:27 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Jan 2019 02:19:22 -0500
Date:   Tue, 22 Jan 2019 02:19:22 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?utf-8?Q?S=C3=A9rgio?= Peixoto <sergio.peixoto@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] attr: do not mark queried macros as unset
Message-ID: <20190122071921.GC28555@sigill.intra.peff.net>
References: <CAK3b1G+88a=xfO=6wfRi1SMy3xtca2NcFyxuBLKwSifb_L9xwA@mail.gmail.com>
 <20190117160752.GA29375@sigill.intra.peff.net>
 <CAK3b1GJPZ5X3uEP1a-NF9PZkE0tTKVLda5hM32jExVz_OD2E=g@mail.gmail.com>
 <20190118165800.GA9956@sigill.intra.peff.net>
 <20190118213458.GB28808@sigill.intra.peff.net>
 <20190118214626.GC28808@sigill.intra.peff.net>
 <CAGZ79kaPXQUY=FN3qusc2PNs=o1EiNarcBejOQKiozMSPvEOYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kaPXQUY=FN3qusc2PNs=o1EiNarcBejOQKiozMSPvEOYw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 18, 2019 at 02:19:55PM -0800, Stefan Beller wrote:

> > I dunno. This is why I submitted the initial patch as the simplest fix. ;)
> >
> 
> The first patch is
> Reviewed-by: Stefan Beller <sbeller@google.com>

Thanks!

> Diffing across both patches, this seems to be the relevant part:
> [...]
> 
> ---8<---
> @@ -1111,14 +1116,13 @@ static void collect_some_attrs(const struct
> index_state *istate,
> 
>         prepare_attr_stack(istate, path, dirlen, &check->stack);
>         all_attrs_init(&g_attr_hashmap, check);
> -       determine_macros(check->all_attrs, check->stack);
> 
>         if (check->nr) {
>                 rem = 0;
>                 for (i = 0; i < check->nr; i++) {
>                         int n = check->items[i].attr->attr_nr;
>                         struct all_attrs_item *item = &check->all_attrs[n];
> -                       if (item->macro) {
> +                       if (!item->attr->in_stack) {
>                                 item->value = ATTR__UNSET;
>                                 rem++;
>                         }
> @@ -1127,6 +1131,8 @@ static void collect_some_attrs(const struct
> index_state *istate,
>                         return;
>         }
> 
> +       determine_macros(check->all_attrs, check->stack);
> +
>         rem = check->all_attrs_nr;
>         fill(path, pathlen, basename_offset, check->stack,
> check->all_attrs, rem);
>  }
> ---8<---
> 
> which I think is correct.

Yes, that's the interesting part. I think I've convinced myself, too,
that it doesn't do the _wrong_ thing ever. But I think it misses the
point of the original, which is that you want common ones like "diff"
not to trigger in_stack if nobody has actually used them. And doing that
really does mean marking in_stack not just when a macro mentions it
(because clearly "binary" is going to mention it for every repo), but
waiting to see if anybody mentions that macro.

Which means we must call determine_macros(), and then propagate the
macro's in_stack to its expansion (if it's indeed called at all).

I don't think that would be _too_ hard to do. But I also wonder if
there's much point. We are trying to avoid fill(), but I think that
determine_macros() is of roughly the same complexity (look at all
matches of all stacks). I guess it does avoid path_matches(), which is a
bit more expensive. And in theory it could be cached for a particular
stack top, so the work is amortized across many path lookups (though I
think that gets even more tricky).

-Peff
