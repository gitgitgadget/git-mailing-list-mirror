Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9218C1F954
	for <e@80x24.org>; Wed, 22 Aug 2018 03:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbeHVG7w (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 02:59:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:51234 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726186AbeHVG7w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 02:59:52 -0400
Received: (qmail 25571 invoked by uid 109); 22 Aug 2018 03:36:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Aug 2018 03:36:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29091 invoked by uid 111); 22 Aug 2018 03:37:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 21 Aug 2018 23:37:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Aug 2018 23:36:54 -0400
Date:   Tue, 21 Aug 2018 23:36:54 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
Message-ID: <20180822033654.GA30196@sigill.intra.peff.net>
References: <xmqqwoskadpe.fsf@gitster-ct.c.googlers.com>
 <1b20b754-987c-a712-2594-235b845bc5d0@gmail.com>
 <20180821212923.GB24431@sigill.intra.peff.net>
 <20180822004815.GA535143@genre.crustytoothpaste.net>
 <20180822030344.GA14684@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180822030344.GA14684@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 21, 2018 at 11:03:44PM -0400, Jeff King wrote:

> with the obvious "oideq()" implementation added, that seems to get me to
> 2-3%. Not _quite_ as good as the original branching version I showed.
> And we had to touch all the callsites (although arguably that kind of
> "eq" function is a better interface anyway, since it obviously allows
> for more optimization.
> 
> So maybe the branching thing is actually not so insane. It makes new
> hash_algo's Just Work; they just won't be optimized. And the change is
> very localized.

Hmph. So I went back to double-check my measurements on that branching
version, and I couldn't replicate it!

It turns out what I showed (and measured) before has a bug. Can you see
it?

diff --git a/cache.h b/cache.h
index b1fd3d58ab..9c004a26c9 100644
--- a/cache.h
+++ b/cache.h
@@ -1023,7 +1023,10 @@ extern const struct object_id null_oid;
 
 static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
 {
-	return memcmp(sha1, sha2, the_hash_algo->rawsz);
+	if (the_hash_algo->rawsz == 20)
+		return memcmp(sha1, sha2, 20);
+	else
+		return memcmp(sha1, sha1, the_hash_algo->rawsz);
 }
 
 static inline int oidcmp(const struct object_id *oid1, const struct object_id *oid2)


The problem is the fallback code compares "sha1" to "sha1". The compiler
realizes that's a noop and is able to treat it like a constant. Thus
essentially leaving only the first branch, which it then expands into a
few instructions.

If we fix that bug, then we really do memcmp on either side of the
conditional. And the compiler is smart enough to realize that hey,
that's the same as just calling memcmp with the_hash_algo->rawsz on
either side. And we end up with roughly the same code that we started
with.

So the assert() version really is the fastest. I didn't test, but I
suspect we could "trick" the compiler by having the fallback call an
opaque wrapper around memcmp(). That would prevent it from combining the
two paths, and presumably it would still optimize the constant-20 side.
Or maybe it would eventually decide our inline function is getting too
big and scrap it. Which probably crosses a line of craziness (if I
didn't already cross it two emails ago).

-Peff
