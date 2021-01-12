Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6526C433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 09:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA5CC22E00
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 09:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390854AbhALJXI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 04:23:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:53126 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390337AbhALJXH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 04:23:07 -0500
Received: (qmail 6995 invoked by uid 109); 12 Jan 2021 09:22:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Jan 2021 09:22:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11177 invoked by uid 111); 12 Jan 2021 09:22:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Jan 2021 04:22:29 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Jan 2021 04:22:26 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 14/20] unpack_entry(): convert to new revindex API
Message-ID: <X/1qUphaPD1Pvk+X@coredump.intra.peff.net>
References: <cover.1610129796.git.me@ttaylorr.com>
 <13c49ed40ca72b7ab50939244616f0a90b5bf7f6.1610129796.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <13c49ed40ca72b7ab50939244616f0a90b5bf7f6.1610129796.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 08, 2021 at 01:17:39PM -0500, Taylor Blau wrote:

> diff --git a/packfile.c b/packfile.c
> index 469c8d4f57..34467ea4a3 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -1692,11 +1692,19 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
>  		}
>  
>  		if (do_check_packed_object_crc && p->index_version > 1) {
> -			struct revindex_entry *revidx = find_pack_revindex(p, obj_offset);
> -			off_t len = revidx[1].offset - obj_offset;
> -			if (check_pack_crc(p, &w_curs, obj_offset, len, revidx->nr)) {
> +			uint32_t pos, nr;

We have "pos" and "nr". What's the difference? :)

I think pack_pos and index_pos might be harder to get confused.

> +			off_t len;
> +
> +			if (offset_to_pack_pos(p, obj_offset, &pos) < 0) {
> +				data = NULL;
> +				goto out;
> +			}

Nice to see the error check here. As with the previous commit, we
probably want to error(), just as we would for errors below.

Do we also need to call mark_bad_packed_object()? I guess we can't,
because we only have the offset, and not the oid (the code below uses
nth_packed_object_id(), but it is relying on the revindex, which we know
just failed to work).

I'm just wondering if an error here is going to put us into an infinite
loop of retrying the lookup in the same pack over and over. Let's
see...our caller is ultimately packed_object_info(), but it too does not
have the oid. It returns an error up to do_oid_object_info_extended().
Which yes, does mark_bad_packed_object() itself. Good. So I think we are
fine, and arguably these lower-level calls to mark_bad_packed_object()
are not necessary. But they do not hurt either.

-Peff
