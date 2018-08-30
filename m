Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AFFA1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 19:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeH3XRU (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 19:17:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:34406 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725836AbeH3XRU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 19:17:20 -0400
Received: (qmail 6913 invoked by uid 109); 30 Aug 2018 19:13:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Aug 2018 19:13:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30459 invoked by uid 111); 30 Aug 2018 19:13:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 30 Aug 2018 15:13:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Aug 2018 15:13:39 -0400
Date:   Thu, 30 Aug 2018 15:13:39 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jann Horn <jannh@google.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 2/5] t5303: test some corrupt deltas
Message-ID: <20180830191339.GA19238@sigill.intra.peff.net>
References: <20180830070548.GA15081@sigill.intra.peff.net>
 <20180830070932.GB15420@sigill.intra.peff.net>
 <xmqq8t4n69gy.fsf@gitster-ct.c.googlers.com>
 <20180830184201.GB14273@sigill.intra.peff.net>
 <20180830184459.GC14273@sigill.intra.peff.net>
 <xmqqzhx34rjj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzhx34rjj.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 30, 2018 at 11:50:56AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I can re-roll, or even prepare a patch on top (it's sufficiently subtle
> > that it may merit calling out explicitly in a commit).
> 
> Yeah, I tend to agree with your reasoning to do it on top as a
> separate patch.

Here it is, then.

-- >8 --
Subject: [PATCH 6/5] t5303: use printf to generate delta bases

The exact byte count of the delta base file is important.
The test-delta helper will feed it to patch_delta(), which
will barf if it doesn't match the size byte given in the
delta. Using "echo" may end up with unexpected line endings
on some platforms (e.g,. "\r\n" instead of just "\n").

This actually wouldn't cause the test to fail (since we
already expect test-delta to complain about these bogus
deltas), but would mean that we're not exercising the code
we think we are.

Let's use printf instead (which we already trust to give us
byte-perfect output when we generate the deltas).

While we're here, let's tighten the 5-byte result size used
in the "truncated copy parameters" test. This just needs to
have enough room to attempt to parse the bogus copy command,
meaning 2 is sufficient. Using 5 was arbitrary and just
copied from the base size; since those no longer match, it's
simply confusing. Let's use a more meaningful number.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5303-pack-corruption-resilience.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
index b68bbeedcc..41e6dc4dcf 100755
--- a/t/t5303-pack-corruption-resilience.sh
+++ b/t/t5303-pack-corruption-resilience.sh
@@ -327,15 +327,15 @@ test_expect_success \
     'printf "\0\1\2XX" > too_big_literal &&
      test_must_fail test-tool delta -p /dev/null too_big_literal /dev/null'
 
-# \5 - five bytes in base
+# \4 - four bytes in base
 # \1 - one byte in result
 # \221 - copy, one byte offset, one byte size
 #   \0 - copy from offset 0
 #   \2 - copy two bytes (one too many)
 test_expect_success \
     'apply delta with too many copied bytes' \
-    'printf "\5\1\221\0\2" > too_big_copy &&
-     echo base >base &&
+    'printf "\4\1\221\0\2" > too_big_copy &&
+     printf base >base &&
      test_must_fail test-tool delta -p base too_big_copy /dev/null'
 
 # \0 - empty base
@@ -356,8 +356,8 @@ test_expect_success \
     'printf "\0\1\221\0\1" > truncated_base &&
      test_must_fail test-tool delta -p /dev/null truncated_base /dev/null'
 
-# \5 - five bytes in base
-# \5 - five bytes in result
+# \4 - four bytes in base
+# \2 - two bytes in result
 # \1 - one literal byte (X)
 # \221 - copy, one byte offset, one byte size
 #        (offset/size missing)
@@ -366,8 +366,8 @@ test_expect_success \
 # delta size check.
 test_expect_success \
     'apply delta with truncated copy parameters' \
-    'printf "\5\5\1X\221" > truncated_copy_delta &&
-     echo base >base &&
+    'printf "\4\2\1X\221" > truncated_copy_delta &&
+     printf base >base &&
      test_must_fail test-tool delta -p base truncated_copy_delta /dev/null'
 
 # \0 - empty base
@@ -379,7 +379,7 @@ test_expect_success \
     'printf "\0\1\1X\1" > tail_garbage_literal &&
      test_must_fail test-tool delta -p /dev/null tail_garbage_literal /dev/null'
 
-# \5 - five bytes in base
+# \4 - four bytes in base
 # \1 - one byte in result
 # \1 - one literal byte (X)
 # \221 - copy, one byte offset, one byte size
@@ -387,8 +387,8 @@ test_expect_success \
 #   \1 - copy 1 byte
 test_expect_success \
     'apply delta with trailing garbage copy' \
-    'printf "\5\1\1X\221\0\1" > tail_garbage_copy &&
-     echo base >base &&
+    'printf "\4\1\1X\221\0\1" > tail_garbage_copy &&
+     printf base >base &&
      test_must_fail test-tool delta -p /dev/null tail_garbage_copy /dev/null'
 
 # \0 - empty base
-- 
2.19.0.rc1.546.g3fcb3c0d7c

