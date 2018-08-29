Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D04C1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 22:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeH3C3v (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 22:29:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:33084 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727187AbeH3C3v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 22:29:51 -0400
Received: (qmail 23529 invoked by uid 109); 29 Aug 2018 22:30:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 29 Aug 2018 22:30:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19785 invoked by uid 111); 29 Aug 2018 22:30:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 29 Aug 2018 18:30:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Aug 2018 18:30:48 -0400
Date:   Wed, 29 Aug 2018 18:30:48 -0400
From:   Jeff King <peff@peff.net>
To:     Jann Horn <jannh@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/3] t5303: add tests for corrupted deltas
Message-ID: <20180829223048.GA12624@sigill.intra.peff.net>
References: <20180829205857.77340-1-jannh@google.com>
 <20180829205857.77340-3-jannh@google.com>
 <20180829220353.GF29880@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180829220353.GF29880@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 29, 2018 at 06:03:53PM -0400, Jeff King wrote:

> Without your second patch applied, this complains about mmap-ing
> /dev/null (or any zero-length file).
> 
> Also, \x escapes are sadly not portable (dash, for example, does not
> respect them). You have to use octal instead (which is not too onerous
> for these small numbers).
> 
> I needed the patch below to get it to behave as expected (I also
> annotated the deltas to make it more comprehensible to somebody who
> hasn't just been digging in the patch code ;) ).
> 
> I wonder if we should more fully test the 4 cases I outlined in my
> earlier mail, too.

So here's a version which checks each of those cases (plus your minimal
base-case and the trailing garbage case from your original).

I did it as a straight patch rather than on top of yours, since I think
that's easier to read (and I'd expect us to squash together whatever we
end up with anyway).

This doesn't cover out-of-bounds reads while parsing the offset/size.
It's dinner-time here, but I may take a look at that later tonight.

---
diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
index 3634e258f8..305922eeb3 100755
--- a/t/t5303-pack-corruption-resilience.sh
+++ b/t/t5303-pack-corruption-resilience.sh
@@ -311,4 +311,81 @@ test_expect_success \
      test_must_fail git cat-file blob $blob_2 > /dev/null &&
      test_must_fail git cat-file blob $blob_3 > /dev/null'
 
+# Base sanity check; this is the smallest possible delta.
+#
+# \5 - five bytes in base (though we do not use it)
+# \1 - one byte in result
+# \1 - copy one byte (X)
+test_expect_success \
+    'apply good minimal delta' \
+    'printf "\5\1\1X" > minimal_delta &&
+     echo base >base &&
+     test-tool delta -p base minimal_delta /dev/null
+     '
+
+# This delta has too many literal bytes to fit in destination.
+#
+# \5 - five bytes in base (though we do not use it)
+# \1 - 1 byte in result
+# \2 - copy two bytes (one too many)
+test_expect_success \
+    'apply truncated delta' \
+    'printf "\5\1\2XX" > too_big_literal &&
+     echo base >base &&
+     test_must_fail test-tool delta -p base too_big_literal /dev/null
+     '
+
+# This delta has too many copy bytes to fit in destination.
+#
+# \5 - five bytes in base
+# \1 - one byte in result
+# \221 - copy, one byte offset, one byte size
+#   \0 - copy from offset 0
+#   \2 - copy two bytes (one too many)
+test_expect_success \
+    'apply delta with trailing garbage command' \
+    'printf "\5\1\221\0\2" > too_big_copy &&
+     echo base >base &&
+     test_must_fail test-tool delta -p base too_big_copy /dev/null
+     '
+
+# This delta has too few bytes in the delta itself.
+#
+# \5 - five bytes in base (though we do not use it)
+# \2 - two bytes in result
+# \2 - copy two bytes (we are short one)
+test_expect_success \
+    'apply truncated delta' \
+    'printf "\5\2\2X" > truncated_delta &&
+     echo base >base &&
+     test_must_fail test-tool delta -p base truncated_delta /dev/null
+     '
+
+# This delta has too few bytes in the base.
+#
+# \5 - five bytes in base
+# \6 - six bytes in result
+# \221 - copy, one byte offset, one byte size
+#   \0 - copy from offset 0
+#   \6 - copy six bytes (one too many)
+test_expect_success \
+    'apply delta with trailing garbage command' \
+    'printf "\5\6\221\0\6" > truncated_base &&
+     echo base >base &&
+     test_must_fail test-tool delta -p base truncated_base /dev/null
+     '
+
+# Trailing garbage command.
+#
+# \5 - five bytes in base (though we do not use it)
+# \1 - one byte in result
+# \1 - copy one byte (X)
+# \1 - trailing garbage command
+test_expect_success \
+    'apply delta with trailing garbage command' \
+    'printf "\5\1\1X\1" > tail_garbage_delta &&
+     echo base >base &&
+     test_must_fail test-tool delta -p base tail_garbage_delta /dev/null
+     '
+
 test_done
