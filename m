Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0661C63797
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 11:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E18BB61181
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 11:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240175AbhGUKqL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 06:46:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:53080 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238871AbhGUJ5L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 05:57:11 -0400
Received: (qmail 2097 invoked by uid 109); 21 Jul 2021 10:37:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Jul 2021 10:37:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3302 invoked by uid 111); 21 Jul 2021 10:37:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Jul 2021 06:37:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 21 Jul 2021 06:37:41 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 11/24] pack-bitmap.c: introduce
 'nth_bitmap_object_oid()'
Message-ID: <YPf49fd7EDncfdl/@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <ac1f46aa1f0dbc7fba45229555b11b390fe104a0.1624314293.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ac1f46aa1f0dbc7fba45229555b11b390fe104a0.1624314293.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 21, 2021 at 06:25:26PM -0400, Taylor Blau wrote:

> A subsequent patch to support reading MIDX bitmaps will be less noisy
> after extracting a generic function to fetch the nth OID contained in
> the bitmap.

Makes sense, but...

> +static void nth_bitmap_object_oid(struct bitmap_index *index,
> +				  struct object_id *oid,
> +				  uint32_t n)
> +{
> +	nth_packed_object_id(oid, index->pack, n);
> +}
> +
>  static int load_bitmap_entries_v1(struct bitmap_index *index)
>  {
>  	uint32_t i;
> @@ -242,9 +249,7 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
>  		xor_offset = read_u8(index->map, &index->map_pos);
>  		flags = read_u8(index->map, &index->map_pos);
>  
> -		if (nth_packed_object_id(&oid, index->pack, commit_idx_pos) < 0)
> -			return error("corrupt ewah bitmap: commit index %u out of range",
> -				     (unsigned)commit_idx_pos);
> +		nth_bitmap_object_oid(index, &oid, commit_idx_pos);

What happened to our error check here?

Should nth_bitmap_object_oid() be returning the value from
nth_packed_object_id()?

-Peff
