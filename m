Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 884821F404
	for <e@80x24.org>; Thu, 30 Aug 2018 18:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbeH3Wpe (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 18:45:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:34324 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726889AbeH3Wpd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 18:45:33 -0400
Received: (qmail 5723 invoked by uid 109); 30 Aug 2018 18:42:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Aug 2018 18:42:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29623 invoked by uid 111); 30 Aug 2018 18:42:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 30 Aug 2018 14:42:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Aug 2018 14:42:01 -0400
Date:   Thu, 30 Aug 2018 14:42:01 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jann Horn <jannh@google.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 2/5] t5303: test some corrupt deltas
Message-ID: <20180830184201.GB14273@sigill.intra.peff.net>
References: <20180830070548.GA15081@sigill.intra.peff.net>
 <20180830070932.GB15420@sigill.intra.peff.net>
 <xmqq8t4n69gy.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8t4n69gy.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 30, 2018 at 10:38:21AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +test_expect_success \
> > +    'apply delta with too many copied bytes' \
> > +    'printf "\5\1\221\0\2" > too_big_copy &&
> > +     echo base >base &&
> > +     test_must_fail test-tool delta -p base too_big_copy /dev/null'
> 
> Would "echo base >base" give us 5-byte long base even on Windows?
> Or the test does not care if it is either "base\n" or "base\r\n"?
> 
> Just double-checking.

Good question. On the first one, I don't know. On the second one, yes,
it does matter. We'd feed "6" to patch_delta(), and it would complain
about the mismatch before actually hitting the code we're trying to
exercise. The test would still pass (the error result is the same either
way), but would quietly not test what we wanted.

Maybe something like this to be on the safe side?

(note that we can leave the \5 in the result size of the "truncated copy
parameters" test; it really just needs to be larger than 1).

---
diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
index 912e659acf..e80934a18e 100755
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
@@ -356,7 +356,7 @@ test_expect_success \
     'printf "\0\1\221\0\1" > truncated_base &&
      test_must_fail test-tool delta -p /dev/null truncated_base /dev/null'
 
-# \5 - five bytes in base
+# \4 - four bytes in base
 # \5 - five bytes in result
 # \1 - one literal byte (X)
 # \221 - copy, one byte offset, one byte size
@@ -366,8 +366,8 @@ test_expect_success \
 # delta size check.
 test_expect_failure \
     'apply delta with truncated copy parameters' \
-    'printf "\5\5\1X\221" > truncated_copy_delta &&
-     echo base >base &&
+    'printf "\4\5\1X\221" > truncated_copy_delta &&
+     printf base >base &&
      test_must_fail test-tool delta -p base truncated_copy_delta /dev/null'
 
 test_done
