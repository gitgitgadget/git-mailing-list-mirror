Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C535F1F803
	for <e@80x24.org>; Thu, 10 Jan 2019 06:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfAJGpW (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 01:45:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:60406 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725536AbfAJGpW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 01:45:22 -0500
Received: (qmail 2490 invoked by uid 109); 10 Jan 2019 06:45:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Jan 2019 06:45:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29441 invoked by uid 111); 10 Jan 2019 06:45:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 10 Jan 2019 01:45:22 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Jan 2019 01:45:20 -0500
Date:   Thu, 10 Jan 2019 01:45:20 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] match-trees: use hashcpy to splice trees
Message-ID: <20190110064520.GC20497@sigill.intra.peff.net>
References: <CAN0heSqLUWpwRdeUvYj2KnDX-QxSOnWOdKWz77RjHKJ3AFUGEQ@mail.gmail.com>
 <20190110042551.915769-1-sandals@crustytoothpaste.net>
 <20190110042551.915769-4-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190110042551.915769-4-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 10, 2019 at 04:25:49AM +0000, brian m. carlson wrote:

> When we're splicing trees, we're writing directly from one location into
> a buffer that is exactly the same size as a tree object. If the current
> hash algorithm is SHA-1, we may not have a full 32 (GIT_MAX_RAWSZ) bytes
> available to write, nor would we want to write that many bytes even if
> we did. In a future commit, we'll split out hashcpy to respect
> the_hash_algo while oidcpy uses GIT_MAX_RAWSZ, so convert the oidcpy to
> a hashcpy so we copy the right number of bytes.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  match-trees.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/match-trees.c b/match-trees.c
> index feca48a5fd..b1fbd022d1 100644
> --- a/match-trees.c
> +++ b/match-trees.c
> @@ -224,7 +224,7 @@ static int splice_tree(const struct object_id *oid1, const char *prefix,
>  	} else {
>  		rewrite_with = oid2;
>  	}
> -	oidcpy(rewrite_here, rewrite_with);
> +	hashcpy(rewrite_here->hash, rewrite_with->hash);

Hrm. Our coccinelle patches will want to convert this back to oidcpy(),
though I see you drop them in the final patch.

However, I wonder if it points to another mismatch. Isn't the point that
we _don't_ actually have "struct object_id"s here? I.e., rewrite_here
and rewrite_with should actually be "const unsigned char *" that we
happen to know are the_hash_algo->raw_sz?

I think the only reason they are "struct object_id" is because that's
what tree_entry_extract() returns. Should we be providing another
function to allow more byte-oriented access?

-Peff
