Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529A0C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 13:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F404A204EC
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 13:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbgKDNgz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 08:36:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:47190 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbgKDNgy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 08:36:54 -0500
Received: (qmail 9775 invoked by uid 109); 4 Nov 2020 13:36:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Nov 2020 13:36:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10277 invoked by uid 111); 4 Nov 2020 13:36:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Nov 2020 08:36:53 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 4 Nov 2020 08:36:53 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack-write: use hashwrite_be32() instead of
 double-buffering array
Message-ID: <20201104133653.GC3030480@coredump.intra.peff.net>
References: <aec69531-d621-ab26-efd4-96e1ae0ed3a4@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aec69531-d621-ab26-efd4-96e1ae0ed3a4@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 01, 2020 at 09:52:12AM +0100, René Scharfe wrote:

> hashwrite() already buffers writes, so pass the fanout table entries
> individually via hashwrite_be32(), which also does the endianess
> conversion for us.  This avoids a memory copy, shortens the code and
> reduces the number of magic numbers.

Yep, this seems trivially correct. The key observation is that we are
filling the array in order:

> @@ -101,20 +100,19 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
>  	for (i = 0; i < 256; i++) {
>  		struct pack_idx_entry **next = list;
>  		while (next < last) {
>  			struct pack_idx_entry *obj = *next;
>  			if (obj->oid.hash[0] != i)
>  				break;
>  			next++;
>  		}
> -		array[i] = htonl(next - sorted_by_sha);
> +		hashwrite_be32(f, next - sorted_by_sha);
>  		list = next;
>  	}
> -	hashwrite(f, array, 256 * 4);

Perhaps obvious, but I got bit trying to do another similar conversion
recently that was filling in the array out-of-order (not on the list,
but in some improvements in the bitmap code that haven't been sent in
yet).

-Peff
