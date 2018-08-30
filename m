Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33F821F404
	for <e@80x24.org>; Thu, 30 Aug 2018 07:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbeH3LKQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 07:10:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:33532 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726169AbeH3LKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 07:10:16 -0400
Received: (qmail 11722 invoked by uid 109); 30 Aug 2018 07:09:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Aug 2018 07:09:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24251 invoked by uid 111); 30 Aug 2018 07:09:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 30 Aug 2018 03:09:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Aug 2018 03:09:32 -0400
Date:   Thu, 30 Aug 2018 03:09:32 -0400
From:   Jeff King <peff@peff.net>
To:     Jann Horn <jannh@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 2/5] t5303: test some corrupt deltas
Message-ID: <20180830070932.GB15420@sigill.intra.peff.net>
References: <20180830070548.GA15081@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180830070548.GA15081@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't have any tests that specifically check boundary
cases in patch_delta(). It obviously gets exercised by tests
which read from packfiles, but it's hard to create packfiles
with bogus deltas.

So let's cover some obvious boundary cases:

  1. commands that overflow the result buffer

     a. literal content from the delta

     b. copies from a base

  2. commands where the source isn't large enough

     a. literal content from a truncated delta

     b. copies that need more bytes than the base has

  3. copy commands who parameters are truncated

And indeed, we have problems with both 2a and 3. I've marked
these both as expect_failure, though note that because they
involve reading past the end of a buffer, they will
typically only be caught when run under valgrind or ASan.

There's one more test here, too, which just applies a basic
delta. Since all of the other tests expect failure and we
don't otherwise use "test-tool delta" in the test suite,
this gives a sanity check that the tool works at all.

These are based on an earlier patch by Jann Horn
<jannh@google.com>.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5303-pack-corruption-resilience.sh | 59 +++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
index 3634e258f8..912e659acf 100755
--- a/t/t5303-pack-corruption-resilience.sh
+++ b/t/t5303-pack-corruption-resilience.sh
@@ -311,4 +311,63 @@ test_expect_success \
      test_must_fail git cat-file blob $blob_2 > /dev/null &&
      test_must_fail git cat-file blob $blob_3 > /dev/null'
 
+# \0 - empty base
+# \1 - one byte in result
+# \1 - one literal byte (X)
+test_expect_success \
+    'apply good minimal delta' \
+    'printf "\0\1\1X" > minimal_delta &&
+     test-tool delta -p /dev/null minimal_delta /dev/null'
+
+# \0 - empty base
+# \1 - 1 byte in result
+# \2 - two literal bytes (one too many)
+test_expect_success \
+    'apply delta with too many literal bytes' \
+    'printf "\0\1\2XX" > too_big_literal &&
+     test_must_fail test-tool delta -p /dev/null too_big_literal /dev/null'
+
+# \5 - five bytes in base
+# \1 - one byte in result
+# \221 - copy, one byte offset, one byte size
+#   \0 - copy from offset 0
+#   \2 - copy two bytes (one too many)
+test_expect_success \
+    'apply delta with too many copied bytes' \
+    'printf "\5\1\221\0\2" > too_big_copy &&
+     echo base >base &&
+     test_must_fail test-tool delta -p base too_big_copy /dev/null'
+
+# \0 - empty base
+# \2 - two bytes in result
+# \2 - two literal bytes (we are short one)
+test_expect_failure \
+    'apply delta with too few literal bytes' \
+    'printf "\0\2\2X" > truncated_delta &&
+     test_must_fail test-tool delta -p /dev/null truncated_delta /dev/null'
+
+# \0 - empty base
+# \1 - one byte in result
+# \221 - copy, one byte offset, one byte size
+#   \0 - copy from offset 0
+#   \1 - copy one byte (we are short one)
+test_expect_success \
+    'apply delta with too few bytes in base' \
+    'printf "\0\1\221\0\1" > truncated_base &&
+     test_must_fail test-tool delta -p /dev/null truncated_base /dev/null'
+
+# \5 - five bytes in base
+# \5 - five bytes in result
+# \1 - one literal byte (X)
+# \221 - copy, one byte offset, one byte size
+#        (offset/size missing)
+#
+# Note that the literal byte is necessary to get past the uninteresting minimum
+# delta size check.
+test_expect_failure \
+    'apply delta with truncated copy parameters' \
+    'printf "\5\5\1X\221" > truncated_copy_delta &&
+     echo base >base &&
+     test_must_fail test-tool delta -p base truncated_copy_delta /dev/null'
+
 test_done
-- 
2.19.0.rc1.539.g3876d0831e

