Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACFE91F803
	for <e@80x24.org>; Thu, 10 Jan 2019 06:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfAJGtr (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 01:49:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:60418 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725536AbfAJGtr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 01:49:47 -0500
Received: (qmail 2772 invoked by uid 109); 10 Jan 2019 06:49:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Jan 2019 06:49:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29480 invoked by uid 111); 10 Jan 2019 06:49:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 10 Jan 2019 01:49:46 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Jan 2019 01:49:45 -0500
Date:   Thu, 10 Jan 2019 01:49:45 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] tree-walk: store object_id in a separate member
Message-ID: <20190110064944.GA6810@sigill.intra.peff.net>
References: <CAN0heSqLUWpwRdeUvYj2KnDX-QxSOnWOdKWz77RjHKJ3AFUGEQ@mail.gmail.com>
 <20190110042551.915769-1-sandals@crustytoothpaste.net>
 <20190110042551.915769-5-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190110042551.915769-5-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 10, 2019 at 04:25:50AM +0000, brian m. carlson wrote:

> diff --git a/tree-walk.c b/tree-walk.c
> index 1e040fc20e..b6daeab16d 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -48,7 +48,8 @@ static int decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned l
>  	/* Initialize the descriptor entry */
>  	desc->entry.path = path;
>  	desc->entry.mode = canon_mode(mode);
> -	desc->entry.oid  = (const struct object_id *)(path + len);
> +	desc->entry.pathlen = len - 1;
> +	memcpy(desc->entry.oid.hash, path + len, the_hash_algo->rawsz);
>  
>  	return 0;
>  }

This one really is a hashcpy() now, right, even after your final patch?
I guess using rawsz explicitly makes it match the computation here:

> @@ -107,7 +108,7 @@ static void entry_extract(struct tree_desc *t, struct name_entry *a)
>  static int update_tree_entry_internal(struct tree_desc *desc, struct strbuf *err)
>  {
>  	const void *buf = desc->buffer;
> -	const unsigned char *end = desc->entry.oid->hash + the_hash_algo->rawsz;
> +	const unsigned char *end = (const unsigned char *)desc->entry.path + desc->entry.pathlen + 1 + the_hash_algo->rawsz;
>  	unsigned long size = desc->size;
>  	unsigned long len = end - (const unsigned char *)buf;

So maybe it's better to be explicit as you have here. (Mostly just as I
was reading it, I was looking for a use of hashcpy and was surprised not
to find it ;) ).

> @@ -175,9 +176,11 @@ void setup_traverse_info(struct traverse_info *info, const char *base)
>  		pathlen--;
>  	info->pathlen = pathlen ? pathlen + 1 : 0;
>  	info->name.path = base;
> -	info->name.oid = (void *)(base + pathlen + 1);
> -	if (pathlen)
> +	info->name.pathlen = pathlen;
> +	if (pathlen) {
> +		memcpy(info->name.oid.hash, (base + pathlen + 1), the_hash_algo->rawsz);
>  		info->prev = &dummy;
> +	}
>  }
>  

Ditto here, I think.

-Peff
