Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4DC91F404
	for <e@80x24.org>; Thu, 30 Aug 2018 07:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbeH3LNh (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 07:13:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:33580 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727395AbeH3LNh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 07:13:37 -0400
Received: (qmail 11893 invoked by uid 109); 30 Aug 2018 07:12:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Aug 2018 07:12:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24325 invoked by uid 111); 30 Aug 2018 07:13:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 30 Aug 2018 03:13:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Aug 2018 03:12:52 -0400
Date:   Thu, 30 Aug 2018 03:12:52 -0400
From:   Jeff King <peff@peff.net>
To:     Jann Horn <jannh@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 5/5] patch-delta: handle truncated copy parameters
Message-ID: <20180830071252.GE15420@sigill.intra.peff.net>
References: <20180830070548.GA15081@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180830070548.GA15081@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we see a delta command instructing us to copy bytes
from the base, we have to read the offset and size from the
delta stream. We do this without checking whether we're at
the end of the stream, meaning we may read past the end of
the buffer.

In practice this isn't exploitable in any interesting way
because:

  1. Deltas are always in packfiles, so we have at least a
     20-byte trailer that we'll end up reading.

  2. The worst case is that we try to perform a nonsense
     copy from the base object into the result, based on
     whatever was in the pack stream next. In most cases
     this will simply fail due to our bounds-checks against
     the base or the result.

     But even if you carefully constructed a pack stream for
     which it succeeds, it wouldn't perform any delta
     operation that you couldn't have simply included in a
     non-broken form.

But obviously it's poor form to read past the end of the
buffer we've been given. Unfortunately there's no easy way
to do a single length check, since the number of bytes we
need depends on the number of bits set in the initial
command byte. So we'll just check each byte as we parse. We
can hide the complexity in a macro; it's ugly, but not as
ugly as writing out each individual conditional.

Signed-off-by: Jeff King <peff@peff.net>
---
 patch-delta.c                         | 21 ++++++++++++++-------
 t/t5303-pack-corruption-resilience.sh |  2 +-
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/patch-delta.c b/patch-delta.c
index 283fb4b759..b5c8594db6 100644
--- a/patch-delta.c
+++ b/patch-delta.c
@@ -40,13 +40,20 @@ void *patch_delta(const void *src_buf, unsigned long src_size,
 		cmd = *data++;
 		if (cmd & 0x80) {
 			unsigned long cp_off = 0, cp_size = 0;
-			if (cmd & 0x01) cp_off = *data++;
-			if (cmd & 0x02) cp_off |= (*data++ << 8);
-			if (cmd & 0x04) cp_off |= (*data++ << 16);
-			if (cmd & 0x08) cp_off |= ((unsigned) *data++ << 24);
-			if (cmd & 0x10) cp_size = *data++;
-			if (cmd & 0x20) cp_size |= (*data++ << 8);
-			if (cmd & 0x40) cp_size |= (*data++ << 16);
+#define PARSE_CP_PARAM(bit, var, shift) do { \
+			if (cmd & (bit)) { \
+				if (data >= top) \
+					goto bad_length; \
+				var |= ((unsigned) *data++ << (shift)); \
+			} } while (0)
+			PARSE_CP_PARAM(0x01, cp_off, 0);
+			PARSE_CP_PARAM(0x02, cp_off, 8);
+			PARSE_CP_PARAM(0x04, cp_off, 16);
+			PARSE_CP_PARAM(0x08, cp_off, 24);
+			PARSE_CP_PARAM(0x10, cp_size, 0);
+			PARSE_CP_PARAM(0x20, cp_size, 8);
+			PARSE_CP_PARAM(0x40, cp_size, 16);
+#undef PARSE_CP_PARAM
 			if (cp_size == 0) cp_size = 0x10000;
 			if (unsigned_add_overflows(cp_off, cp_size) ||
 			    cp_off + cp_size > src_size ||
diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
index 41dc947d3f..b68bbeedcc 100755
--- a/t/t5303-pack-corruption-resilience.sh
+++ b/t/t5303-pack-corruption-resilience.sh
@@ -364,7 +364,7 @@ test_expect_success \
 #
 # Note that the literal byte is necessary to get past the uninteresting minimum
 # delta size check.
-test_expect_failure \
+test_expect_success \
     'apply delta with truncated copy parameters' \
     'printf "\5\5\1X\221" > truncated_copy_delta &&
      echo base >base &&
-- 
2.19.0.rc1.539.g3876d0831e
