Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C5661F404
	for <e@80x24.org>; Fri, 30 Mar 2018 20:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752571AbeC3UsP (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 16:48:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:49412 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752106AbeC3UsO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 16:48:14 -0400
Received: (qmail 31152 invoked by uid 109); 30 Mar 2018 20:48:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 30 Mar 2018 20:48:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 466 invoked by uid 111); 30 Mar 2018 20:49:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 30 Mar 2018 16:49:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2018 16:48:12 -0400
Date:   Fri, 30 Mar 2018 16:48:12 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH v7 06/13] pack-objects: move in_pack out of struct
 object_entry
Message-ID: <20180330204812.GE14782@sigill.intra.peff.net>
References: <20180318142526.9378-1-pclouds@gmail.com>
 <20180324063353.24722-1-pclouds@gmail.com>
 <20180324063353.24722-7-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180324063353.24722-7-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 24, 2018 at 07:33:46AM +0100, Nguyễn Thái Ngọc Duy wrote:

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index e1244918a5..b41610569e 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -29,6 +29,8 @@
>  #include "list.h"
>  #include "packfile.h"
>  
> +#define IN_PACK(obj) oe_in_pack(&to_pack, obj)

How come this one gets a macro, but the earlier conversions don't?

I guess the problem is that oe_in_pack() is defined in the generic
pack-objects.h, but &to_pack is only in builtin/pack-objects.c?

I wonder if it would be that bad to just say oe_in_pack(&to_pack, obj)
everywhere. It's longer, but it makes the code slightly less magical to
read.

> @@ -1074,7 +1076,7 @@ static void create_object_entry(const struct object_id *oid,
>  	else
>  		nr_result++;
>  	if (found_pack) {
> -		entry->in_pack = found_pack;
> +		oe_set_in_pack(&to_pack, entry, found_pack);
>  		entry->in_pack_offset = found_offset;
>  	}

it's funny to see in_pack as an external thing, but in_pack_offset still
in the struct. I guess there's nothing to be gained there, since the
offset really does need to be individual (and large).

> diff --git a/cache.h b/cache.h
> index 862bdff83a..b90feb3802 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1635,6 +1635,7 @@ extern struct packed_git {
>  	int index_version;
>  	time_t mtime;
>  	int pack_fd;
> +	int index;		/* for builtin/pack-objects.c */
>  	unsigned pack_local:1,
>  		 pack_keep:1,
>  		 freshened:1,

It's pretty gross to infect this global struct. But I'm not sure there's
an easier way to do it with constant-time lookups. You'd have to build
the packed_git index preemptively in pack-objects, and then always just
pass around the index numbers.  And even that is kind of dicey, since
the packed_git list can grow while we're running.

The alternative is a hash table mapping packed_git pointers into numeric
indices. Yuck.

> +static void prepare_in_pack_by_idx(struct packing_data *pdata)
> +{
> +	struct packed_git **mapping, *p;
> +	int cnt = 0, nr = 1 << OE_IN_PACK_BITS;
> +
> +	if (getenv("GIT_TEST_FULL_IN_PACK_ARRAY")) {
> +		/*
> +		 * leave in_pack_by_idx NULL to force in_pack[] to be
> +		 * used instead
> +		 */
> +		return;
> +	}
> +
> +	ALLOC_ARRAY(mapping, nr);
> +	mapping[cnt++] = NULL; /* zero index must be mapped to NULL */

Why? I guess because index==0 is a sentinel for "we're using the small
index numbers?"

> +	prepare_packed_git();
> +	for (p = packed_git; p; p = p->next, cnt++) {
> +		if (cnt == nr) {
> +			free(mapping);
> +			return;
> +		}
> +		p->index = cnt;
> +		mapping[cnt] = p;
> +	}
> +	pdata->in_pack_by_idx = mapping;
> +}

What happens if we later have to reprepare_packed_git() and end up with
more packs? We only call this for the first pack.

It may well be handled, but I'm having trouble following the code to see
if it is. And I doubt that case is covered by our test suite (since it
inherently involves a race).

>  /*
> + * The size of struct nearly determines pack-objects's memory
> + * consumption. This struct is packed tight for that reason. When you
> + * add or reorder something in this struct, think a bit about this.
> + *

It's funny to see this warning come in the middle. Should it be part of
the final struct reordering at the end?

-Peff
