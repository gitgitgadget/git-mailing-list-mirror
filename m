Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1E5920133
	for <e@80x24.org>; Sun,  5 Mar 2017 11:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752577AbdCELqm (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Mar 2017 06:46:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:38815 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752362AbdCELqm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Mar 2017 06:46:42 -0500
Received: (qmail 4782 invoked by uid 109); 5 Mar 2017 11:46:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 05 Mar 2017 11:46:41 +0000
Received: (qmail 10901 invoked by uid 111); 5 Mar 2017 11:46:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 05 Mar 2017 06:46:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Mar 2017 06:46:38 -0500
Date:   Sun, 5 Mar 2017 06:46:38 -0500
From:   Jeff King <peff@peff.net>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        allan.x.xavier@oracle.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v1] Travis: also test on 32-bit Linux
Message-ID: <20170305114638.x7g767js2m3othga@sigill.intra.peff.net>
References: <xmqqinnrd098.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1703030315580.3767@virtualbox>
 <xmqqh93a9p5r.fsf@gitster.mtv.corp.google.com>
 <xmqq8tol7vs1.fsf@gitster.mtv.corp.google.com>
 <CAPc5daW=gtN18JZTQMqUje5fxL4oNdTucB0dXFbybPRJggPBUw@mail.gmail.com>
 <2205F1A7-A694-4F40-B994-D68C3947F2BB@gmail.com>
 <f5f5886a-aaec-7426-ea33-f5d65516348b@oracle.com>
 <af31ef46-bd0c-c3f2-5a1e-7d97da6ec9a0@oracle.com>
 <282895e1-d9eb-2368-a8e7-8085ad9b17ed@oracle.com>
 <20170305113618.ko2jymle4n5f2b5l@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170305113618.ko2jymle4n5f2b5l@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 05, 2017 at 06:36:19AM -0500, Jeff King wrote:

> I grepped for 'memcpy.*sizeof' and found one other case that's not a
> bug, but is questionable.

And here's the fix for that case. It can be applied separately from the
other patch if need be.

-- >8 --
Subject: [PATCH] ewah: fix eword_t/uint64_t confusion

The ewah subsystem typedefs eword_t to be uint64_t, but some
code uses a bare uint64_t. This isn't a bug now, but it's a
potential maintenance problem if the definition of eword_t
ever changes. Let's use the correct type.

Note that we can't use COPY_ARRAY() here because the source
and destination point to objects of different sizes. For
that reason we'll also skip the usual "sizeof(*dst)" and use
the real type, which should make it more clear that there's
something tricky going on.

Signed-off-by: Jeff King <peff@peff.net>
---
 ewah/ewah_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ewah/ewah_io.c b/ewah/ewah_io.c
index 61f6a4357..f73210973 100644
--- a/ewah/ewah_io.c
+++ b/ewah/ewah_io.c
@@ -142,8 +142,8 @@ int ewah_read_mmap(struct ewah_bitmap *self, const void *map, size_t len)
 	 * the endianness conversion in a separate pass to ensure
 	 * we're loading 8-byte aligned words.
 	 */
-	memcpy(self->buffer, ptr, self->buffer_size * sizeof(uint64_t));
-	ptr += self->buffer_size * sizeof(uint64_t);
+	memcpy(self->buffer, ptr, self->buffer_size * sizeof(eword_t));
+	ptr += self->buffer_size * sizeof(eword_t);
 
 	for (i = 0; i < self->buffer_size; ++i)
 		self->buffer[i] = ntohll(self->buffer[i]);
-- 
2.12.0.426.g9d5d0eeae

