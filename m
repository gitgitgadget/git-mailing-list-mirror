Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0846C433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A184E22D58
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405667AbhALIsg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 03:48:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:52978 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405620AbhALIse (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 03:48:34 -0500
Received: (qmail 5956 invoked by uid 109); 12 Jan 2021 08:47:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Jan 2021 08:47:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10613 invoked by uid 111); 12 Jan 2021 08:47:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Jan 2021 03:47:50 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Jan 2021 03:47:47 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 02/20] write_reuse_object(): convert to new revindex API
Message-ID: <X/1iM0p5d8Zj8ucS@coredump.intra.peff.net>
References: <cover.1610129796.git.me@ttaylorr.com>
 <00668523e1cd860f6de08dd7c5a2a54edc08b7b6.1610129796.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00668523e1cd860f6de08dd7c5a2a54edc08b7b6.1610129796.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 08, 2021 at 01:16:48PM -0500, Taylor Blau wrote:

> First replace 'find_pack_revindex()' with its replacement
> 'offset_to_pack_pos()'. This prevents any bogus OFS_DELTA that may make
> its way through until 'write_reuse_object()' from causing a bad memory
> read (if 'revidx' is 'NULL')

Nice. Better abstraction, and we're catching more errors.

> @@ -436,10 +436,13 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
>  					      type, entry_size);
>  
>  	offset = entry->in_pack_offset;
> -	revidx = find_pack_revindex(p, offset);
> -	datalen = revidx[1].offset - offset;
> +	if (offset_to_pack_pos(p, offset, &pos) < 0)
> +		die(_("write_reuse_object: could not locate %s"),
> +		    oid_to_hex(&entry->idx.oid));

If we believe the offset is bogus, should we print that in the error
message, too? Something like:

  die("could not locate %s, expected at offset %"PRIuMAX" in pack %s",
      oid_to_hex(&entry->idx.oid), (uintmax_t)offset, p->pack_name);

> +	datalen = pack_pos_to_offset(p, pos + 1) - offset;

This "pos + 1" means we may be looking one past the end of the array.
That's OK (at least for now), because our revindex always puts in an
extra dummy value exactly for computing these kinds of byte-distances.
That might be worth documenting in the API header.

-Peff
