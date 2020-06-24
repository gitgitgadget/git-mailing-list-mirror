Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D6DC433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 19:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B39292077D
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 19:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391334AbgFXTjd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 15:39:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:42252 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391239AbgFXTjd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 15:39:33 -0400
Received: (qmail 22689 invoked by uid 109); 24 Jun 2020 19:39:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Jun 2020 19:39:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1294 invoked by uid 111); 24 Jun 2020 19:39:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 Jun 2020 15:39:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 24 Jun 2020 15:39:31 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] revision: reallocate TOPO_WALK object flags
Message-ID: <20200624193931.GA3336639@coredump.intra.peff.net>
References: <29f8b1fc-fac7-12c6-4bfe-28aed7e709c3@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29f8b1fc-fac7-12c6-4bfe-28aed7e709c3@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 24, 2020 at 03:05:38PM +0200, René Scharfe wrote:

> The bit fields in struct object have an unfortunate layout.  Here's what
> pahole reports on x86_64 GNU/Linux:
> 
> struct object {
> 	unsigned int               parsed:1;             /*     0: 0  4 */
> 	unsigned int               type:3;               /*     0: 1  4 */
> 
> 	/* XXX 28 bits hole, try to pack */
> 
> 	/* Force alignment to the next boundary: */
> 	unsigned int               :0;
> 
> 	unsigned int               flags:29;             /*     4: 0  4 */
> 
> 	/* XXX 3 bits hole, try to pack */
> 
> 	struct object_id           oid;                  /*     8    32 */
> 
> 	/* size: 40, cachelines: 1, members: 4 */
> 	/* sum members: 32 */
> 	/* sum bitfield members: 33 bits, bit holes: 2, sum bit holes: 31 bits */
> 	/* last cacheline: 40 bytes */
> };
> 
> Notice the 1+3+29=33 bits in bit fields and 28+3=31 bits in holes.

Good catch. The original FLAG_BITS was intended to pack with parsed and
type, and we should have caught this in review when it got bumped in
b45424181e (revision.c: generation-based topo-order algorithm,
2018-11-01).

The patch looks correct to me.

> There are holes inside the flags bit field as well -- while some object
> flags are used for more than one purpose, 22, 23 and 24 are still free.
> Use  23 and 24 instead of 27 and 28 for TOPO_WALK_EXPLORED and
> TOPO_WALK_INDEGREE.  This allows us to reduce FLAG_BITS by one so that
> all bitfields combined fit into a single 32-bit slot:
> 
> struct object {
> 	unsigned int               parsed:1;             /*     0: 0  4 */
> 	unsigned int               type:3;               /*     0: 1  4 */
> 	unsigned int               flags:28;             /*     0: 4  4 */
> 	struct object_id           oid;                  /*     4    32 */
> 
> 	/* size: 36, cachelines: 1, members: 4 */
> 	/* last cacheline: 36 bytes */
> };

With 20-byte hashes, this put us at 24 bytes, which is 8-byte aligned. I
had always assumed once we moved to 32-byte hashes that we'd be stuck
with a 40-byte "struct object" to keep 8-byte alignment on 64-bit
systems. But it seems that at least on x86_64 Linux, we're happy with
4-byte alignment. That's useful to know (I had wondered if we might be
able to put those extra bytes to a good use, but I guess not).

>  /*
>   * object flag allocation:
> - * revision.h:               0---------10         15                   25----28
> + * revision.h:               0---------10         15             23------26
>   * fetch-pack.c:             01
>   * negotiator/default.c:       2--5
>   * walker.c:                 0-2

Definitely not a new problem, but I think we should consider "rotating"
this table. The point of it is for two branches that get merged to cause
a conflict if they allocate the same bit to two uses. And we _might_ get
see such a conflict if the allocations are on adjacent lines, but we
wouldn't if they're far away. E.g., imagine one side does:

  -* revision.h    0---------10
  +* revision.h    0----------11
   * fetch-pack.c  01
   * foo.c           2
   * bar.c            3

and the other does:

   * revision.h    0---------10
   * fetch-pack.c  01
   * foo.c           2
   * bar.c            3
  +* uh-oh.c                  11

Now we have two possibly conflicting uses of bit 11 (a semantic
conflict), but no matching textual conflict.

Whereas if we wrote:

  * bit 0: revision.h, fetch-pack.c
  * bit 1: revision.h
  * bit 2: revision.h, foo.c
  * bit 3: revision.h, bar.c
  [etc...]

then we'd get a conflict on the "bit 11" line. It does mean that
unrelated modules get written on the same line, but that's the point.
They're only allowed to be on the same line after somebody determines
that they're mutually exclusive and won't stomp on each other.

-Peff
