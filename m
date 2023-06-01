Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD0EC77B7E
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 18:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjFASD5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 14:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjFASDy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 14:03:54 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDB58E
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 11:03:53 -0700 (PDT)
Received: (qmail 6232 invoked by uid 109); 1 Jun 2023 18:03:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Jun 2023 18:03:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25510 invoked by uid 111); 1 Jun 2023 18:03:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Jun 2023 14:03:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Jun 2023 14:03:51 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Teng Long <dyroneteng@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] ci: use clang for ASan/UBSan checks
Message-ID: <20230601180351.GA4167886@coredump.intra.peff.net>
References: <20230601180220.GA4167745@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230601180220.GA4167745@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Both gcc and clang support the "address" and "undefined" sanitizers.
However, they may produce different results. We've seen at least two
real world cases where gcc missed a UBSan problem but clang found it:

  1. Clang's UBSan (using clang 14.0.6) found a string index that was
     subtracted to "-1", causing an out-of-bounds read (curiously this
     didn't trigger ASan, but that may be because the string was in the
     argv memory, not stack or heap). Using gcc (version 12.2.0) didn't
     find the same problem.

     Original thread:
     https://lore.kernel.org/git/20230519005447.GA2955320@coredump.intra.peff.net/

  2. Clang's UBSan (using clang 4.0.1) complained about pointer
     arithmetic with NULL, but gcc at the time did not. This was in
     2017, and modern gcc does seem to find the issue, though.

     Original thread:
     https://lore.kernel.org/git/32a8b949-638a-1784-7fba-948ae32206fc@web.de/

Since we don't otherwise have a particular preference for one compiler
over the other for this test, let's switch to the one that we think may
be more thorough.

Note that it's entirely possible that the two are simply _different_,
and we are trading off problems that gcc would find that clang wouldn't.
However, my subjective and anecdotal experience has been that clang's
sanitizer support is a bit more mature (e.g., I recall other oddities
around leak-checking where clang performed more sensibly).

Obviously running both and cross-checking the results would give us the
best coverage, but that's very expensive to run (and these are already
some of our most expensive CI jobs). So let's use clang as our best
guess, and we can re-evaluate if we get more data points.

Signed-off-by: Jeff King <peff@peff.net>
---
You can see that this catches the recent problem when merged with
'next':

  https://github.com/peff/git/actions/runs/5102807385/jobs/9172605638

 .github/workflows/main.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 30492eacdd..487ad31e66 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -274,10 +274,10 @@ jobs:
             cc: gcc
             pool: ubuntu-latest
           - jobname: linux-asan
-            cc: gcc
+            cc: clang
             pool: ubuntu-latest
           - jobname: linux-ubsan
-            cc: gcc
+            cc: clang
             pool: ubuntu-latest
     env:
       CC: ${{matrix.vector.cc}}
-- 
2.41.0.346.g8d12207a4f

