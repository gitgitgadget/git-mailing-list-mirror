Return-Path: <SRS0=MMY4=4L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4066C35671
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 21:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B28BD206E2
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 21:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgBWV6B (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 16:58:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:52142 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726302AbgBWV6B (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 16:58:01 -0500
Received: (qmail 3692 invoked by uid 109); 23 Feb 2020 21:58:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 23 Feb 2020 21:58:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5066 invoked by uid 111); 23 Feb 2020 22:07:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 23 Feb 2020 17:07:05 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 23 Feb 2020 16:57:59 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
Subject: Re: [PATCH v2 01/24] builtin/pack-objects: make hash agnostic
Message-ID: <20200223215759.GC564691@coredump.intra.peff.net>
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
 <20200222201749.937983-2-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200222201749.937983-2-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 22, 2020 at 08:17:26PM +0000, brian m. carlson wrote:

> Avoid hard-coding a hash size, instead preferring to use the_hash_algo.
> [...]
> -			hashwrite(out, base_sha1, 20);
> +			hashwrite(out, base_sha1, the_hash_algo->rawsz);

Yeah, looks obviously correct (and I think this is new from the
pack-reuse patches of mine that Christian sent recently).

The name "base_sha1" is clearly not great either. It could be changed
trivially, but the real sin is that it comes from
nth_packed_object_sha1(). It could be replaced with
nth_packed_object_oid() at the cost of an extra hash copy, which isn't
too bad.

It would be nice to get rid of that function entirely. In most cases,
it's either free to do so (we end up copying the result into an oid
anyway) or we pay for one extra hashcpy (out of the mmap into a local
struct). But the one in pack-check.c:verify_packfile() is tricky; we
store a pointer per object into the index mmap, and we'd have to switch
to storing an oid per object. Given that the code isn't commonly run
(and other operations like _generating_ the index in the first place are
clearly OK with the extra memory hit), I think I'd be OK with that in
the name of cleanliness.

All of that is sort of orthogonal to your goals, I think, so I don't
mind at all calling it out of scope for your series. As long as we use
the_hash_algo->rawsz, these bare pointer accesses aren't wrong (it's
just that it's easy to accidentally get it wrong, as this code shows).

I think it would also be correct to cast the mmap'd bytes to a "struct
object_id" given that the struct contains the hash bytes as the first
member. I worry a little that we'd get no compiler warning of the
breakage if that assumption changes, but it also seems unlikely to do
so.

-Peff
