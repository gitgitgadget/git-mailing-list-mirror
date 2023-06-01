Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA95CC77B7A
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 18:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjFASKp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 14:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjFASKn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 14:10:43 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864EF13D
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 11:10:41 -0700 (PDT)
Received: (qmail 6356 invoked by uid 109); 1 Jun 2023 18:10:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Jun 2023 18:10:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25577 invoked by uid 111); 1 Jun 2023 18:10:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Jun 2023 14:10:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Jun 2023 14:10:40 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Teng Long <dyroneteng@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] ci: drop linux-clang job
Message-ID: <20230601181040.GC4167886@coredump.intra.peff.net>
References: <20230601180220.GA4167745@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230601180220.GA4167745@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the linux-asan-ubsan job runs using clang under Linux, there is
not much point in running a separate clang job. Any errors that a normal
clang compile-and-test cycle would find are likely to be a subset of
what the sanitizer job will find. Since this job takes ~14 minutes to
run in CI, this shaves off some of our CPU load (though it does not
affect end-to-end runtime, since it's typically run in parallel and is
not the longest job).

Technically this provides us with slightly less signal for a given run,
since you won't immediately know if a failure in the sanitizer job is
from using clang or from the sanitizers themselves. But it's generally
obvious from the logs, and anyway your next step would be to fix the
probvlem and re-run CI, since we expect all of these jobs to pass
normally.

Signed-off-by: Jeff King <peff@peff.net>
---
Obviously not necessary, but just seemed like another easy way to trim
our resource usage. Really, the same logic could apply before my series
to the linux-gcc job, which is similarly redundant.

 .github/workflows/main.yml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 2114303b7d..079645b776 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -246,9 +246,6 @@ jobs:
       fail-fast: false
       matrix:
         vector:
-          - jobname: linux-clang
-            cc: clang
-            pool: ubuntu-latest
           - jobname: linux-sha256
             cc: clang
             pool: ubuntu-latest
-- 
2.41.0.346.g8d12207a4f
