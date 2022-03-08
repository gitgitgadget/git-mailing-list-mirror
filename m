Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C30DC433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 02:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244852AbiCHCXl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 21:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244874AbiCHCXk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 21:23:40 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBA4DF2E
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 18:22:43 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 982495A3BC;
        Tue,  8 Mar 2022 02:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1646706162;
        bh=kHgpDec4GFQkX1VlxZ++amaFOn9goURt9sF/oI+r2xA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=YaQ+wLF1PSECkD4wKW0U7HD5LNywHjPFHPPcj7KuvkujUp2B0Sq4o1sMFecsKcH3O
         tdKadB2YRL9pCb7nQCxtUL7gajIwhQ1nWh4w247nDqTAM+EZnDqEYuZPXUU5jLch/A
         j+qzEjo48DCitKMIhwX3p98AB8kShGo/TbpctgN4Wn79qZT6dkmmMly/qjLNR9sts9
         XLnFX0rB2+sChZ3wSD1lR9pSce4tv604QIdPUXO+RkV46ylywgpVQnFZ1AtT+SLx6R
         rfMwQA5Y4N2NB1i3L5b+ay/+SCGf7fSxdZCtIPMC50HyTkXkVaK3gx8xLeVsCehAdz
         1udvs78WbLVI/dW5wVLJYm6HpimIV4ykJcDeKmT1EWH0bK1ny+qssF9U7iV7ovn+aN
         26uA6CvXshCd+F2mTKoV+2Earjwl38Ecxo4QuzCg4jyQUgGFj8TgQG53je6tDNuh/0
         1VqmyASjYKrVRf4N1hj13WLss7PRNv85YZYBbQENsbyG3tV9u77
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2] block-sha1: remove use of assembly
Date:   Tue,  8 Mar 2022 02:22:40 +0000
Message-Id: <20220308022240.2809483-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed
In-Reply-To: <20220307232552.2799122-1-sandals@crustytoothpaste.net>
References: <20220307232552.2799122-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the block SHA-1 code, we have special assembly code for i386 and
amd64 to perform rotations with assembly.  This is supposed to help pick
the correct rotation operation depending on which rotation is smaller,
which can help some systems perform slightly better, since any circular
rotation can be specified as either a rotate left or a rotate right.
However, this isn't needed, so we should remove it.

First, SHA-1, like SHA-2, uses fixed constant rotates.  Thus, all
rotation amounts are known at compile time and are in fact baked into
the code.  Fortunately, peephole optimizers recognize rotations
specified in the normal way and automatically emit the correct code,
including a preference for choosing a rotate left versus a rotate right.
This has been the case for well over a decade, and is a standard example
of the utility of a peephole optimizer.

Moreover, all modern CPUs, with the exception of extremely limited
embedded CPUs such as some Cortex-M processors, provide a barrel
shifter, which lets the CPU perform rotates of any bit amount in
constant time.  This is valuable for many cryptographic algorithms to
improve performance, and is required to prevent timing attacks in
algorithms which use data-dependent rotations (which don't include the
hash algorithms we use).  As a result, even though the compiler does the
correct optimization, it isn't even needed here and either a left or a
right rotate is equally acceptable.

In fact, the SHA-256 code already takes this into account and just
writes the simple code using an inline function to let the compiler
optimize it for us.

The downside of using this code, however, is that it uses a GCC
extension, which makes the compiler complain when using -pedantic unless
it's prefixed with __extension__.  We could fix that, but since it's
not needed, let's just remove it.  We haven't noticed this because
almost everyone uses the SHA1DC code instead, but it still shows up for
some people.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
Changes from v1:
* Add sign-off.

 block-sha1/sha1.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index 1bb6e7c069..5974cd7dd3 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -11,27 +11,10 @@
 
 #include "sha1.h"
 
-#if defined(__GNUC__) && (defined(__i386__) || defined(__x86_64__))
-
-/*
- * Force usage of rol or ror by selecting the one with the smaller constant.
- * It _can_ generate slightly smaller code (a constant of 1 is special), but
- * perhaps more importantly it's possibly faster on any uarch that does a
- * rotate with a loop.
- */
-
-#define SHA_ASM(op, x, n) ({ unsigned int __res; __asm__(op " %1,%0":"=r" (__res):"i" (n), "0" (x)); __res; })
-#define SHA_ROL(x,n)	SHA_ASM("rol", x, n)
-#define SHA_ROR(x,n)	SHA_ASM("ror", x, n)
-
-#else
-
 #define SHA_ROT(X,l,r)	(((X) << (l)) | ((X) >> (r)))
 #define SHA_ROL(X,n)	SHA_ROT(X,n,32-(n))
 #define SHA_ROR(X,n)	SHA_ROT(X,32-(n),n)
 
-#endif
-
 /*
  * If you have 32 registers or more, the compiler can (and should)
  * try to change the array[] accesses into registers. However, on
