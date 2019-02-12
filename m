Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9660D211B5
	for <e@80x24.org>; Tue, 12 Feb 2019 06:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfBLGhv (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 01:37:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:41376 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725930AbfBLGhv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 01:37:51 -0500
Received: (qmail 6606 invoked by uid 109); 12 Feb 2019 06:37:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 Feb 2019 06:37:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22853 invoked by uid 111); 12 Feb 2019 06:38:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 12 Feb 2019 01:38:01 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Feb 2019 01:37:49 -0500
Date:   Tue, 12 Feb 2019 01:37:49 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 04/31] pack-bitmap: replace sha1_to_hex
Message-ID: <20190212063749.GC21872@sigill.intra.peff.net>
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
 <20190212012256.1005924-5-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190212012256.1005924-5-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 12, 2019 at 01:22:29AM +0000, brian m. carlson wrote:

> Replace the uses of sha1_to_hex in the pack bitmap code with hash_to_hex
> to allow the use of SHA-256 as well.  Rename a few variables since they
> are no longer limited to SHA-1.

Sounds good, although...

> -static uint32_t find_object_pos(const unsigned char *sha1)
> +static uint32_t find_object_pos(const unsigned char *hash)

Isn't this really just a "struct object_id"? Why don't we want to use
that here?

I suspect it may be partially because our khash is storing raw sha1s.
But shouldn't we also be converted that to store object_ids?

In particular:

> @@ -181,7 +181,7 @@ static struct stored_bitmap *store_bitmap(struct bitmap_index *index,
>  	stored->root = root;
>  	stored->xor = xor_with;
>  	stored->flags = flags;
> -	oidread(&stored->oid, sha1);
> +	oidread(&stored->oid, hash);
>  
>  	hash_pos = kh_put_sha1(index->bitmaps, stored->oid.hash, &ret);

This last line (which is actually from the previous patch) is going to
always truncate the stored data to 20 bytes, isn't it?

I think we need to define a kh_oid. We have the "set" version already in
oidset.[ch]; I think we need to make that more public.

-Peff
