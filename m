Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CDDC35673
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 03:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8486520658
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 03:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgBXDBn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 22:01:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:52234 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727156AbgBXDBn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 22:01:43 -0500
Received: (qmail 4894 invoked by uid 109); 24 Feb 2020 03:01:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Feb 2020 03:01:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6477 invoked by uid 111); 24 Feb 2020 03:10:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 23 Feb 2020 22:10:48 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 23 Feb 2020 22:01:42 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
Subject: Re: [PATCH v2 01/24] builtin/pack-objects: make hash agnostic
Message-ID: <20200224030142.GA618173@coredump.intra.peff.net>
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
 <20200222201749.937983-2-sandals@crustytoothpaste.net>
 <20200223215759.GC564691@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200223215759.GC564691@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 23, 2020 at 04:57:59PM -0500, Jeff King wrote:

> It would be nice to get rid of [nth_packed_object_sha1] entirely. In most cases,
> it's either free to do so (we end up copying the result into an oid
> anyway) or we pay for one extra hashcpy (out of the mmap into a local
> struct). But the one in pack-check.c:verify_packfile() is tricky; we
> store a pointer per object into the index mmap, and we'd have to switch
> to storing an oid per object. Given that the code isn't commonly run
> (and other operations like _generating_ the index in the first place are
> clearly OK with the extra memory hit), I think I'd be OK with that in
> the name of cleanliness.
> 
> All of that is sort of orthogonal to your goals, I think, so I don't
> mind at all calling it out of scope for your series. As long as we use
> the_hash_algo->rawsz, these bare pointer accesses aren't wrong (it's
> just that it's easy to accidentally get it wrong, as this code shows).

I looked into this a bit further. It turns out that the current code in
verify_packfile() was explicitly trying to avoid that extra memory. But
the good news is that I think we can improve it further, cleaning up the
existing type-punning and using even less memory than now.

I'll prepare a separate series to do that. I had thought the cleanup
might also make this whole 20 / the_hash_algo->rawsz thing go away, but
it doesn't (the name hashwrite() made me think we ought to be using an
oidwrite(), but of course that's silly; the "hash" here is a "file with
a hash checksum" and not "an object id hash"). So the two topics really
are independent.

-Peff
