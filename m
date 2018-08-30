Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9073F1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 07:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeH3LLK (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 07:11:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:33566 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726169AbeH3LLK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 07:11:10 -0400
Received: (qmail 11798 invoked by uid 109); 30 Aug 2018 07:10:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Aug 2018 07:10:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24293 invoked by uid 111); 30 Aug 2018 07:10:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 30 Aug 2018 03:10:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Aug 2018 03:10:26 -0400
Date:   Thu, 30 Aug 2018 03:10:26 -0400
From:   Jeff King <peff@peff.net>
To:     Jann Horn <jannh@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 4/5] patch-delta: consistently report corruption
Message-ID: <20180830071026.GD15420@sigill.intra.peff.net>
References: <20180830070548.GA15081@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180830070548.GA15081@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jann Horn <jannh@google.com>

When applying a delta, if we see an opcode that cannot be
fulfilled (e.g., asking to write more bytes than the
destination has left), we break out of our parsing loop but
don't signal an explicit error. We rely on the sanity check
after the loop to see if we have leftover delta bytes or
didn't fill our result buffer.

This can silently ignore corruption when the delta buffer
ends with a bogus command and the destination buffer is
already full. Instead, let's jump into the error handler
directly when we see this case.

Note that the tests also cover the "bad opcode" case, which
already handles this correctly.

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 patch-delta.c                         |  5 +++--
 t/t5303-pack-corruption-resilience.sh | 30 +++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/patch-delta.c b/patch-delta.c
index b937afd2c9..283fb4b759 100644
--- a/patch-delta.c
+++ b/patch-delta.c
@@ -51,13 +51,13 @@ void *patch_delta(const void *src_buf, unsigned long src_size,
 			if (unsigned_add_overflows(cp_off, cp_size) ||
 			    cp_off + cp_size > src_size ||
 			    cp_size > size)
-				break;
+				goto bad_length;
 			memcpy(out, (char *) src_buf + cp_off, cp_size);
 			out += cp_size;
 			size -= cp_size;
 		} else if (cmd) {
 			if (cmd > size || cmd > top - data)
-				break;
+				goto bad_length;
 			memcpy(out, data, cmd);
 			out += cmd;
 			data += cmd;
@@ -75,6 +75,7 @@ void *patch_delta(const void *src_buf, unsigned long src_size,
 
 	/* sanity check */
 	if (data != top || size != 0) {
+		bad_length:
 		error("delta replay has gone wild");
 		bad:
 		free(dst_buf);
diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
index 7114c31ade..41dc947d3f 100755
--- a/t/t5303-pack-corruption-resilience.sh
+++ b/t/t5303-pack-corruption-resilience.sh
@@ -370,4 +370,34 @@ test_expect_failure \
      echo base >base &&
      test_must_fail test-tool delta -p base truncated_copy_delta /dev/null'
 
+# \0 - empty base
+# \1 - one byte in result
+# \1 - one literal byte (X)
+# \1 - trailing garbage command
+test_expect_success \
+    'apply delta with trailing garbage literal' \
+    'printf "\0\1\1X\1" > tail_garbage_literal &&
+     test_must_fail test-tool delta -p /dev/null tail_garbage_literal /dev/null'
+
+# \5 - five bytes in base
+# \1 - one byte in result
+# \1 - one literal byte (X)
+# \221 - copy, one byte offset, one byte size
+#   \0 - copy from offset 0
+#   \1 - copy 1 byte
+test_expect_success \
+    'apply delta with trailing garbage copy' \
+    'printf "\5\1\1X\221\0\1" > tail_garbage_copy &&
+     echo base >base &&
+     test_must_fail test-tool delta -p /dev/null tail_garbage_copy /dev/null'
+
+# \0 - empty base
+# \1 - one byte in result
+# \1 - one literal byte (X)
+# \0 - bogus opcode
+test_expect_success \
+    'apply delta with trailing garbage opcode' \
+    'printf "\0\1\1X\0" > tail_garbage_opcode &&
+     test_must_fail test-tool delta -p /dev/null tail_garbage_opcode /dev/null'
+
 test_done
-- 
2.19.0.rc1.539.g3876d0831e

