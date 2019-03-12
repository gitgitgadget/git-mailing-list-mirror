Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47AA320248
	for <e@80x24.org>; Tue, 12 Mar 2019 21:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfCLVG3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 17:06:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:47784 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726141AbfCLVG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 17:06:28 -0400
Received: (qmail 2834 invoked by uid 109); 12 Mar 2019 21:06:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 Mar 2019 21:06:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3761 invoked by uid 111); 12 Mar 2019 21:06:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 12 Mar 2019 17:06:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Mar 2019 17:06:27 -0400
Date:   Tue, 12 Mar 2019 17:06:26 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeffrey Walton <noloader@gmail.com>,
        Todd Zullinger <tmz@pobox.com>, Git List <git@vger.kernel.org>
Subject: [PATCH] Makefile: fix unaligned loads in sha1dc with UBSan
Message-ID: <20190312210626.GA5157@sigill.intra.peff.net>
References: <CAH8yC8k_Zyi89uxTWTrjN65UAAc1L+jLho+P7O7UyvE-LvZuzA@mail.gmail.com>
 <20190308174343.GX31362@zaya.teonanacatl.net>
 <CAH8yC8mg3vjPoof5SDemQ_YiL+7e1ak535U2nFnPbaWJ8xSWOA@mail.gmail.com>
 <CAH8yC8kn=EmEm_UPrnpwaofv97S42Se6FC+hWcm0EHCX-4rewQ@mail.gmail.com>
 <xmqq1s3emapy.fsf@gitster-ct.c.googlers.com>
 <20190311033755.GB7087@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190311033755.GB7087@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 10, 2019 at 11:37:55PM -0400, Jeff King wrote:

> Unfortunately, I don't think sha1dc currently supports #defines in that
> direction. The only logic is "if we are on intel, do unaligned loads"
> and "even if we are not on intel, do it anyway". There is no "even if we
> are on intel, do not do unaligned loads".
> 
> I think you'd need something like this:
> [...]

The sha1dc folks gave us a very nice and quick turnaround on this.
Thanks to them, and to Jeffrey for opening an issue there.

Here's a commit which updates Git to use the new feature. I've tested it
with both the in-tree and submodule builds like:

  make DC_SHA1_SUBMODULE=Yes SANITIZE=undefined && (cd t && ./t0001-*)
  make DC_SHA1_SUBMODULE=    SANITIZE=undefined && (cd t && ./t0001-*)

both of which fail without this patch and succeed without it.

-- >8 --
Subject: [PATCH] Makefile: fix unaligned loads in sha1dc with UBSan

The sha1dc library uses unaligned loads on platforms that support them.
This is normally what you'd want for performance, but it does cause
UBSan to complain when we compile with SANITIZE=undefined. Just like we
set -DNO_UNALIGNED_LOADS for our own code in that case, we should set
-DSHA1DC_FORCE_ALIGNED_ACCESS.

Of course that does nothing without pulling in the patches from sha1dc
to respect that define. So let's do that, too, updating both the
submodule link and our in-tree copy (from the same commit).

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile               | 1 +
 sha1collisiondetection | 2 +-
 sha1dc/sha1.c          | 5 +++--
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 537493822b..593c2c729a 100644
--- a/Makefile
+++ b/Makefile
@@ -1195,6 +1195,7 @@ BASIC_CFLAGS += -fsanitize=$(SANITIZE) -fno-sanitize-recover=$(SANITIZE)
 BASIC_CFLAGS += -fno-omit-frame-pointer
 ifneq ($(filter undefined,$(SANITIZERS)),)
 BASIC_CFLAGS += -DNO_UNALIGNED_LOADS
+BASIC_CFLAGS += -DSHA1DC_FORCE_ALIGNED_ACCESS
 endif
 ifneq ($(filter leak,$(SANITIZERS)),)
 BASIC_CFLAGS += -DSUPPRESS_ANNOTATED_LEAKS
diff --git a/sha1collisiondetection b/sha1collisiondetection
index 232357eb2e..16033998da 160000
--- a/sha1collisiondetection
+++ b/sha1collisiondetection
@@ -1 +1 @@
-Subproject commit 232357eb2ea0397388254a4b188333a227bf5b10
+Subproject commit 16033998da4b273aebd92c84b1e1b12e4aaf7009
diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index df0630bc6d..5931cf25d5 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -124,10 +124,11 @@
 #endif
 /*ENDIANNESS SELECTION*/
 
+#ifndef SHA1DC_FORCE_ALIGNED_ACCESS
 #if defined(SHA1DC_FORCE_UNALIGNED_ACCESS) || defined(SHA1DC_ON_INTEL_LIKE_PROCESSOR)
 #define SHA1DC_ALLOW_UNALIGNED_ACCESS
-#endif /*UNALIGNMENT DETECTION*/
-
+#endif /*UNALIGNED ACCESS DETECTION*/
+#endif /*FORCE ALIGNED ACCESS*/
 
 #define rotate_right(x,n) (((x)>>(n))|((x)<<(32-(n))))
 #define rotate_left(x,n)  (((x)<<(n))|((x)>>(32-(n))))
-- 
2.21.0.539.gcf54785f87

