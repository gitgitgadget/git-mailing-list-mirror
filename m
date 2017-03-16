Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84A9420953
	for <e@80x24.org>; Thu, 16 Mar 2017 22:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752684AbdCPWIP (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 18:08:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:45461 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752122AbdCPWIO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 18:08:14 -0400
Received: (qmail 2652 invoked by uid 109); 16 Mar 2017 22:08:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 22:08:13 +0000
Received: (qmail 4139 invoked by uid 111); 16 Mar 2017 22:08:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 18:08:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Mar 2017 18:08:10 -0400
Date:   Thu, 16 Mar 2017 18:08:10 -0400
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/5] sha1dc: adjust header includes for git
Message-ID: <20170316220810.orlbvop53fj4g5wg@sigill.intra.peff.net>
References: <20170316220456.m4yz2kbvzv6waokn@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170316220456.m4yz2kbvzv6waokn@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We can replace system includes with git-compat-util.h or
cache.h (and should make sure it is included first in all C
files).  And we can drop includes from headers entirely, as
every C file should include git-compat-util.h itself.

We will add in new include guards around the header files,
though (otherwise you get into trouble including both
sha1dc/sha1.h and cache.h).

And finally, we'll use the full "sha1dc/" path for including
related files. This isn't strictly necessary, but makes the
expected resolution more obvious.

Signed-off-by: Jeff King <peff@peff.net>
---
The cache.h thing is necessary if we want to use sha1_to_hex() later
(which I think we should).

 sha1dc/sha1.c      | 10 +++-------
 sha1dc/sha1.h      |  6 ++++--
 sha1dc/ubc_check.c |  4 ++--
 sha1dc/ubc_check.h |  2 --
 4 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index 8d12b832b..da516c14c 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -5,13 +5,9 @@
 * https://opensource.org/licenses/MIT
 ***/
 
-#include <string.h>
-#include <memory.h>
-#include <stdio.h>
-#include <stdlib.h>
-
-#include "sha1.h"
-#include "ubc_check.h"
+#include "cache.h"
+#include "sha1dc/sha1.h"
+#include "sha1dc/ubc_check.h"
 
 
 /* 
diff --git a/sha1dc/sha1.h b/sha1dc/sha1.h
index e867724c0..8a5bf0847 100644
--- a/sha1dc/sha1.h
+++ b/sha1dc/sha1.h
@@ -4,13 +4,13 @@
 * See accompanying file LICENSE.txt or copy at
 * https://opensource.org/licenses/MIT
 ***/
+#ifndef SHA1DC_SHA1_H
+#define SHA1DC_SHA1_H
 
 #if defined(__cplusplus)
 extern "C" {
 #endif
 
-#include <stdint.h>
-
 /* uses SHA-1 message expansion to expand the first 16 words of W[] to 80 words */
 /* void sha1_message_expansion(uint32_t W[80]); */
 
@@ -103,3 +103,5 @@ int  SHA1DCFinal(unsigned char[20], SHA1_CTX*);
 #if defined(__cplusplus)
 }
 #endif
+
+#endif /* SHA1DC_SHA1_H */
diff --git a/sha1dc/ubc_check.c b/sha1dc/ubc_check.c
index 27d0976da..089dd4743 100644
--- a/sha1dc/ubc_check.c
+++ b/sha1dc/ubc_check.c
@@ -24,8 +24,8 @@
 // ubc_check has been verified against ubc_check_verify using the 'ubc_check_test' program in the tools section
 */
 
-#include <stdint.h>
-#include "ubc_check.h"
+#include "git-compat-util.h"
+#include "sha1dc/ubc_check.h"
 
 static const uint32_t DV_I_43_0_bit 	= (uint32_t)(1) << 0;
 static const uint32_t DV_I_44_0_bit 	= (uint32_t)(1) << 1;
diff --git a/sha1dc/ubc_check.h b/sha1dc/ubc_check.h
index b349bed92..b64c306d7 100644
--- a/sha1dc/ubc_check.h
+++ b/sha1dc/ubc_check.h
@@ -27,8 +27,6 @@
 extern "C" {
 #endif
 
-#include <stdint.h>
-
 #define DVMASKSIZE 1
 typedef struct { int dvType; int dvK; int dvB; int testt; int maski; int maskb; uint32_t dm[80]; } dv_info_t;
 extern dv_info_t sha1_dvs[];
-- 
2.12.0.623.g86ec6c963

