Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74298C433E0
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 00:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 408B764DEB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 00:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhA2A1v (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 19:27:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:42664 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229596AbhA2A1v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 19:27:51 -0500
Received: (qmail 20347 invoked by uid 109); 29 Jan 2021 00:27:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Jan 2021 00:27:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4075 invoked by uid 111); 29 Jan 2021 00:27:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Jan 2021 19:27:11 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Jan 2021 19:27:09 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v3 01/10] packfile: prepare for the existence of '*.rev'
 files
Message-ID: <YBNWXU8xzw0087DC@coredump.intra.peff.net>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1611617819.git.me@ttaylorr.com>
 <6f8b70ab276c0579c957c315743fdab63462a605.1611617820.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6f8b70ab276c0579c957c315743fdab63462a605.1611617820.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 25, 2021 at 06:37:14PM -0500, Taylor Blau wrote:

> +struct revindex_header {
> +	uint32_t signature;
> +	uint32_t version;
> +	uint32_t hash_id;
> +};
> [...]
> +	struct revindex_header *hdr;
> [...]
> +	data = xmmap(NULL, revindex_size, PROT_READ, MAP_PRIVATE, fd, 0);
> +	hdr = data;
> +
> +	if (ntohl(hdr->signature) != RIDX_SIGNATURE) {

I guess this technique was pulled from the .idx code paths, but IMHO we
should avoid this kind of struct-casting. It relies on the compiler's
struct packing, and I'm not 100% sure it doesn't violate some weird
pointer-aliasing rules.

OTOH, as long as we do not ever care about sizeof(revindex_header), this
is likely to work in practice, since every field is at least 4-byte
aligned (but there is probably an extra 4 bytes of padding at the end).

The "right" way is probably something like:

  const char *header = data;
  if (get_be32(header) != RIDX_SIGNATURE)
          error...;
  header += 4;
  if (get_be32(header) != 1)
          error...;
  header += 4;
  ...etc...

I thought we had helpers to read and advance the pointer, but it looks
like those are specific to the bitmap code (e.g., read_be32(), though it
uses a separate offset variable).

I dunno. Maybe I am being overly picky. The .idx code already does it
like this, and I believe the index (as in .git/index) does, too. We have
run into problems (as in b5007211b6 (pack-bitmap: do not use gcc packed
attribute, 2014-11-27)), but that was due to a more odd-sized struct, as
well as using sizeof().

The rest of the patch looks good to me.

-Peff
