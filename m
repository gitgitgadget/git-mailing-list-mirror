Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD9571F404
	for <e@80x24.org>; Wed, 29 Aug 2018 22:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbeH3CCu (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 22:02:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:33040 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727168AbeH3CCt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 22:02:49 -0400
Received: (qmail 22490 invoked by uid 109); 29 Aug 2018 22:03:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 29 Aug 2018 22:03:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19556 invoked by uid 111); 29 Aug 2018 22:04:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 29 Aug 2018 18:04:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Aug 2018 18:03:53 -0400
Date:   Wed, 29 Aug 2018 18:03:53 -0400
From:   Jeff King <peff@peff.net>
To:     Jann Horn <jannh@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 3/3] t5303: add tests for corrupted deltas
Message-ID: <20180829220353.GF29880@sigill.intra.peff.net>
References: <20180829205857.77340-1-jannh@google.com>
 <20180829205857.77340-3-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180829205857.77340-3-jannh@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 29, 2018 at 10:58:57PM +0200, Jann Horn wrote:

> This verifies the changes from commit "patch-delta: fix oob read".

A minor nit, but usually we'd either introduce tests along with the
fix, or introduce them beforehand as test_expect_failure and then flip
them to success along with the fix.

> diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
> index 3634e258f..7152376b6 100755
> --- a/t/t5303-pack-corruption-resilience.sh
> +++ b/t/t5303-pack-corruption-resilience.sh
> @@ -311,4 +311,22 @@ test_expect_success \
>       test_must_fail git cat-file blob $blob_2 > /dev/null &&
>       test_must_fail git cat-file blob $blob_3 > /dev/null'
>  
> +test_expect_success \
> +    'apply good minimal delta' \
> +    'printf "\x00\x01\x01X" > minimal_delta &&
> +     test-tool delta -p /dev/null minimal_delta /dev/null
> +     '

Without your second patch applied, this complains about mmap-ing
/dev/null (or any zero-length file).

Also, \x escapes are sadly not portable (dash, for example, does not
respect them). You have to use octal instead (which is not too onerous
for these small numbers).

I needed the patch below to get it to behave as expected (I also
annotated the deltas to make it more comprehensible to somebody who
hasn't just been digging in the patch code ;) ).

I wonder if we should more fully test the 4 cases I outlined in my
earlier mail, too.

-Peff

---
diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
index 7152376b67..df28cce68b 100755
--- a/t/t5303-pack-corruption-resilience.sh
+++ b/t/t5303-pack-corruption-resilience.sh
@@ -311,22 +311,35 @@ test_expect_success \
      test_must_fail git cat-file blob $blob_2 > /dev/null &&
      test_must_fail git cat-file blob $blob_3 > /dev/null'
 
+# \5 - five bytes in base (though we do not use it)
+# \1 - one byte in result
+# \1 - copy one byte (X)
 test_expect_success \
     'apply good minimal delta' \
-    'printf "\x00\x01\x01X" > minimal_delta &&
-     test-tool delta -p /dev/null minimal_delta /dev/null
+    'printf "\5\1\1X" > minimal_delta &&
+     echo base >base &&
+     test-tool delta -p base minimal_delta /dev/null
      '
 
+# \5 - five bytes in base (though we do not use it)
+# \2 - two bytes in result
+# \2 - copy two bytes (we are short one)
 test_expect_success \
     'apply truncated delta' \
-    'printf "\x00\x02\x02X" > truncated_delta &&
-     test_must_fail test-tool delta -p /dev/null truncated_delta /dev/null
+    'printf "\5\2\2X" > truncated_delta &&
+     echo base >base &&
+     test_must_fail test-tool delta -p base truncated_delta /dev/null
      '
 
+# \5 - five bytes in base (though we do not use it)
+# \1 - one byte in result
+# \1 - copy one byte (X)
+# \1 - trailing garbage command
 test_expect_success \
     'apply delta with trailing garbage command' \
-    'printf "\x00\x01\x01X\x01" > tail_garbage_delta &&
-     test_must_fail test-tool delta -p /dev/null tail_garbage_delta /dev/null
+    'printf "\5\1\1X\1" > tail_garbage_delta &&
+     echo base >base &&
+     test_must_fail test-tool delta -p base tail_garbage_delta /dev/null
      '
 
 test_done
