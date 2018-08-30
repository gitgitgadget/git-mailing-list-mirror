Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25E201F404
	for <e@80x24.org>; Thu, 30 Aug 2018 18:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbeH3Wsc (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 18:48:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:34344 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725836AbeH3Wsc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 18:48:32 -0400
Received: (qmail 5846 invoked by uid 109); 30 Aug 2018 18:45:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Aug 2018 18:45:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29699 invoked by uid 111); 30 Aug 2018 18:45:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 30 Aug 2018 14:45:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Aug 2018 14:44:59 -0400
Date:   Thu, 30 Aug 2018 14:44:59 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jann Horn <jannh@google.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 2/5] t5303: test some corrupt deltas
Message-ID: <20180830184459.GC14273@sigill.intra.peff.net>
References: <20180830070548.GA15081@sigill.intra.peff.net>
 <20180830070932.GB15420@sigill.intra.peff.net>
 <xmqq8t4n69gy.fsf@gitster-ct.c.googlers.com>
 <20180830184201.GB14273@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180830184201.GB14273@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 30, 2018 at 02:42:01PM -0400, Jeff King wrote:

> > Would "echo base >base" give us 5-byte long base even on Windows?
> > Or the test does not care if it is either "base\n" or "base\r\n"?
> > 
> > Just double-checking.
> 
> Good question. On the first one, I don't know. On the second one, yes,
> it does matter. We'd feed "6" to patch_delta(), and it would complain
> about the mismatch before actually hitting the code we're trying to
> exercise. The test would still pass (the error result is the same either
> way), but would quietly not test what we wanted.
> 
> Maybe something like this to be on the safe side?

That could be squashed into patch 2. Patch 4 would need this one
additional case:

diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
index 0c537958e7..e91d6f5770 100755
--- a/t/t5303-pack-corruption-resilience.sh
+++ b/t/t5303-pack-corruption-resilience.sh
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

I can re-roll, or even prepare a patch on top (it's sufficiently subtle
that it may merit calling out explicitly in a commit).

-Peff
