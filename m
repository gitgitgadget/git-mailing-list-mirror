Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A96211F404
	for <e@80x24.org>; Sat, 25 Aug 2018 08:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbeHYLny (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Aug 2018 07:43:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:55688 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726412AbeHYLny (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Aug 2018 07:43:54 -0400
Received: (qmail 4778 invoked by uid 109); 25 Aug 2018 08:05:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 25 Aug 2018 08:05:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2326 invoked by uid 111); 25 Aug 2018 08:05:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 25 Aug 2018 04:05:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Aug 2018 04:05:44 -0400
Date:   Sat, 25 Aug 2018 04:05:44 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH 2/9] introduce hasheq() and oideq()
Message-ID: <20180825080543.GB737@sigill.intra.peff.net>
References: <20180825080031.GA32139@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180825080031.GA32139@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The main comparison functions we provide for comparing
object ids are hashcmp() and oidcmp(). These are more
flexible than a strict equality check, since they also
express ordering. That makes them them useful for sorting
and binary searching. However, it also makes them
potentially slower than a strict equality check. Consider
this C code, which is traditionally what our hashcmp has
looked like:

  #include <string.h>
  int hashcmp(const unsigned char *a, const unsigned char *b)
  {
          return memcmp(a, b, 20);
  }

Compiling with "gcc -O2 -S -fverbose-asm", the generated
assembly shows that we actually call memcmp(). But if we
change this to a strict equality check:

          return !memcmp(a, b, 20);

we get a faster inline version:

          movq    (%rdi), %rax    # MEM[(void *)a_4(D)], MEM[(void *)a_4(D)]
          movq    8(%rdi), %rdx   # MEM[(void *)a_4(D)], tmp101
          xorq    (%rsi), %rax    # MEM[(void *)b_5(D)], tmp94
          xorq    8(%rsi), %rdx   # MEM[(void *)b_5(D)], tmp93
          orq     %rax, %rdx      # tmp94, tmp93
          jne     .L2     #,
          movl    16(%rsi), %eax  # MEM[(void *)b_5(D)], tmp104
          cmpl    %eax, 16(%rdi)  # tmp104, MEM[(void *)a_4(D)]
          je      .L5     #,

Obviously our hashcmp() doesn't include the "!". But because
it's an inline function, optimizing compilers are able to
see "!hashcmp(a,b)" in calling code and take advantage of
this case. So there has been no value thus far in
introducing a more restricted interface for doing strict
equality checks.

But as Git learns about more values for the_hash_algo, our
hashcmp() will grow more complicated and may even delegate
at runtime to functions optimized specifically for that hash
size. That breaks the inline connection we have, and the
compiler will have to assume that the caller really cares
about the sign and magnitude of the memcmp() result, even
though the vast majority don't.

We can solve that by introducing a hasheq() function (and
matching oideq() wrapper), which callers can use to make
clear that they only care about equality. For now, the
implementation will literally be "!hashcmp()", but it frees
us up later to introduce code optimized specifically for the
equality check.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/cache.h b/cache.h
index 4d014541ab..f6d227fac7 100644
--- a/cache.h
+++ b/cache.h
@@ -1041,6 +1041,16 @@ static inline int oidcmp(const struct object_id *oid1, const struct object_id *o
 	return hashcmp(oid1->hash, oid2->hash);
 }
 
+static inline int hasheq(const unsigned char *sha1, const unsigned char *sha2)
+{
+	return !hashcmp(sha1, sha2);
+}
+
+static inline int oideq(const struct object_id *oid1, const struct object_id *oid2)
+{
+	return hasheq(oid1->hash, oid2->hash);
+}
+
 static inline int is_null_sha1(const unsigned char *sha1)
 {
 	return !hashcmp(sha1, null_sha1);
-- 
2.19.0.rc0.412.g7005db4e88

