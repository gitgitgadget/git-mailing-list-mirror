Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D720C4363D
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 19:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC85020878
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 19:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbgIXTVM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 15:21:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:39928 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbgIXTVM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 15:21:12 -0400
Received: (qmail 6954 invoked by uid 109); 24 Sep 2020 19:21:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Sep 2020 19:21:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10386 invoked by uid 111); 24 Sep 2020 19:21:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Sep 2020 15:21:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Sep 2020 15:21:11 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Han-Wen Nienhuys <hanwen@google.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: [PATCH 1/2] bswap.h: drop unaligned loads
Message-ID: <20200924192111.GA2528225@coredump.intra.peff.net>
References: <20200924191638.GA2528003@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200924191638.GA2528003@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our put_be32() routine and its variants (get_be32(), put_be64(), etc)
has two implementations: on some platforms we cast memory in place and
use nothl()/htonl(), which can cause unaligned memory access. And on
others, we pick out the individual bytes using bitshifts.

This introduces extra complexity, and sometimes causes compilers to
generate warnings about type-punning. And it's not clear there's any
performance advantage.

This split goes back to 660231aa97 (block-sha1: support for
architectures with memory alignment restrictions, 2009-08-12). The
unaligned versions were part of the original block-sha1 code in
d7c208a92e (Add new optimized C 'block-sha1' routines, 2009-08-05),
which says it is:

   Based on the mozilla SHA1 routine, but doing the input data accesses a
   word at a time and with 'htonl()' instead of loading bytes and shifting.

Back then, Linus provided timings versus the mozilla code which showed a
27% improvement:

  https://lore.kernel.org/git/alpine.LFD.2.01.0908051545000.3390@localhost.localdomain/

However, the unaligned loads were either not the useful part of that
speedup, or perhaps compilers and processors have changed since then.
Here are times for computing the sha1 of 4GB of random data, with and
without -DNO_UNALIGNED_LOADS (and BLK_SHA1=1, of course). This is with
gcc 10, -O2, and the processor is a Core i9-9880H.

  [stock]
  Benchmark #1: t/helper/test-tool sha1 <foo.rand
    Time (mean ± σ):      6.638 s ±  0.081 s    [User: 6.269 s, System: 0.368 s]
    Range (min … max):    6.550 s …  6.841 s    10 runs

  [-DNO_UNALIGNED_LOADS]
  Benchmark #1: t/helper/test-tool sha1 <foo.rand
    Time (mean ± σ):      6.418 s ±  0.015 s    [User: 6.058 s, System: 0.360 s]
    Range (min … max):    6.394 s …  6.447 s    10 runs

And here's the same test run on an AMD A8-7600, using gcc 8.

  [stock]
  Benchmark #1: t/helper/test-tool sha1 <foo.rand
    Time (mean ± σ):     11.721 s ±  0.113 s    [User: 10.761 s, System: 0.951 s]
    Range (min … max):   11.509 s … 11.861 s    10 runs

  [-DNO_UNALIGNED_LOADS]
  Benchmark #1: t/helper/test-tool sha1 <foo.rand
    Time (mean ± σ):     11.744 s ±  0.066 s    [User: 10.807 s, System: 0.928 s]
    Range (min … max):   11.637 s … 11.863 s    10 runs

So the unaligned loads don't seem to help much, and actually make things
worse. It's possible there are platforms where they provide more
benefit, but:

  - the non-x86 platforms for which we use this code are old and obscure
    (powerpc and s390).

  - the main caller that cares about performance is block-sha1. But
    these days it is rarely used anyway, in favor of sha1dc (which is
    already much slower, and nobody seems to have cared that much).

Let's just drop unaligned versions entirely in the name of simplicity.

Signed-off-by: Jeff King <peff@peff.net>
---
+cc Linus for any thoughts or performance wisdom, and in particular if
    there might be other platforms worth benchmarking (though unless
    the improvement is dramatic on some system, avoiding the complexity
    and pointer aliasing seems worthwhile to me).

+cc René because I know he is going to feed the two of them into
    godbolt; I could do that, too, but he will provide much better analysis
    on top ;)

 Makefile       |  1 -
 compat/bswap.h | 24 ------------------------
 2 files changed, 25 deletions(-)

diff --git a/Makefile b/Makefile
index 92d188fd37..d46765aa9e 100644
--- a/Makefile
+++ b/Makefile
@@ -1218,7 +1218,6 @@ SANITIZERS := $(foreach flag,$(subst $(comma),$(space),$(SANITIZE)),$(flag))
 BASIC_CFLAGS += -fsanitize=$(SANITIZE) -fno-sanitize-recover=$(SANITIZE)
 BASIC_CFLAGS += -fno-omit-frame-pointer
 ifneq ($(filter undefined,$(SANITIZERS)),)
-BASIC_CFLAGS += -DNO_UNALIGNED_LOADS
 BASIC_CFLAGS += -DSHA1DC_FORCE_ALIGNED_ACCESS
 endif
 ifneq ($(filter leak,$(SANITIZERS)),)
diff --git a/compat/bswap.h b/compat/bswap.h
index e4e25735ce..c0bb744adc 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -145,28 +145,6 @@ static inline uint64_t git_bswap64(uint64_t x)
 
 #endif
 
-/*
- * Performance might be improved if the CPU architecture is OK with
- * unaligned 32-bit loads and a fast ntohl() is available.
- * Otherwise fall back to byte loads and shifts which is portable,
- * and is faster on architectures with memory alignment issues.
- */
-
-#if !defined(NO_UNALIGNED_LOADS) && ( \
-    defined(__i386__) || defined(__x86_64__) || \
-    defined(_M_IX86) || defined(_M_X64) || \
-    defined(__ppc__) || defined(__ppc64__) || \
-    defined(__powerpc__) || defined(__powerpc64__) || \
-    defined(__s390__) || defined(__s390x__))
-
-#define get_be16(p)	ntohs(*(unsigned short *)(p))
-#define get_be32(p)	ntohl(*(unsigned int *)(p))
-#define get_be64(p)	ntohll(*(uint64_t *)(p))
-#define put_be32(p, v)	do { *(unsigned int *)(p) = htonl(v); } while (0)
-#define put_be64(p, v)	do { *(uint64_t *)(p) = htonll(v); } while (0)
-
-#else
-
 static inline uint16_t get_be16(const void *ptr)
 {
 	const unsigned char *p = ptr;
@@ -212,6 +190,4 @@ static inline void put_be64(void *ptr, uint64_t value)
 	p[7] = value >>  0;
 }
 
-#endif
-
 #endif /* COMPAT_BSWAP_H */
-- 
2.28.0.1082.g195fe9fe3f

