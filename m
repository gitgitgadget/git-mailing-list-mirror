Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0743FC433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4B422075E
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388685AbhALIur (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 03:50:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:53038 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728344AbhALIuq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 03:50:46 -0500
Received: (qmail 6035 invoked by uid 109); 12 Jan 2021 08:50:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Jan 2021 08:50:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10796 invoked by uid 111); 12 Jan 2021 08:50:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Jan 2021 03:50:08 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Jan 2021 03:50:05 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 03/20] write_reused_pack_one(): convert to new revindex
 API
Message-ID: <X/1ivewkRCD5BpcZ@coredump.intra.peff.net>
References: <cover.1610129796.git.me@ttaylorr.com>
 <81ab11e18c0b00030019f9f521216f3469fdd744.1610129796.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <81ab11e18c0b00030019f9f521216f3469fdd744.1610129796.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 08, 2021 at 01:16:53PM -0500, Taylor Blau wrote:

> -	offset = reuse_packfile->revindex[pos].offset;
> -	next = reuse_packfile->revindex[pos + 1].offset;
> +	offset = pack_pos_to_offset(reuse_packfile, pos);
> +	next = pack_pos_to_offset(reuse_packfile, pos + 1);

Makes sense.

> @@ -887,11 +887,15 @@ static void write_reused_pack_one(size_t pos, struct hashfile *out,
>  
>  		/* Convert to REF_DELTA if we must... */
>  		if (!allow_ofs_delta) {
> -			int base_pos = find_revindex_position(reuse_packfile, base_offset);
> +			uint32_t base_pos;
>  			struct object_id base_oid;
>  
> +			if (offset_to_pack_pos(reuse_packfile, base_offset, &base_pos) < 0)
> +				die(_("expected object at offset %"PRIuMAX),
> +				    (uintmax_t)base_offset);

This error does mention the offset, which is good. But not the pack name
(nor the object name, but we don't have it!).

-Peff
