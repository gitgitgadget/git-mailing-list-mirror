Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE47C38145
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 05:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiIHFRS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 01:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiIHFRR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 01:17:17 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6592610E
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 22:17:16 -0700 (PDT)
Received: (qmail 24669 invoked by uid 109); 8 Sep 2022 05:17:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Sep 2022 05:17:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18043 invoked by uid 111); 8 Sep 2022 05:17:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Sep 2022 01:17:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Sep 2022 01:17:15 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH] test-lib: ignore uninteresting LSan output
Message-ID: <Yxl62zODF4oy1QL9@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I run the tests in leak-checking mode the same way our CI job does,
like:

  make SANITIZE=leak \
       GIT_TEST_PASSING_SANITIZE_LEAK=true \
       GIT_TEST_SANITIZE_LEAK_LOG=true \
       test

then LSan can racily produce useless entries in the log files that look
like this:

  ==git==3034393==Unable to get registers from thread 3034307.

I think they're mostly harmless based on the source here:

  https://github.com/llvm/llvm-project/blob/7e0a52e8e9ef6394bb62e0b56e17fa23e7262411/compiler-rt/lib/lsan/lsan_common.cpp#L414

which reads:

    PtraceRegistersStatus have_registers =
        suspended_threads.GetRegistersAndSP(i, &registers, &sp);
    if (have_registers != REGISTERS_AVAILABLE) {
      Report("Unable to get registers from thread %llu.\n", os_id);
      // If unable to get SP, consider the entire stack to be reachable unless
      // GetRegistersAndSP failed with ESRCH.
      if (have_registers == REGISTERS_UNAVAILABLE_FATAL)
        continue;
      sp = stack_begin;
    }

The program itself still runs fine and LSan doesn't cause us to abort.
But test-lib.sh looks for any non-empty LSan logs and marks the test as
a failure anyway, under the assumption that we simply missed the failing
exit code somehow.

I don't think I've ever seen this happen in the CI job, but running
locally using clang-14 on an 8-core machine, I can't seem to make it
through a full run of the test suite without having at least one
failure. And it's a different one every time (though they do seem to
often be related to packing tests, which makes sense, since that is one
of our biggest users of threaded code).

We can hack around this by only counting LSan log files that contain a
line that doesn't match our known-uninteresting pattern.

Signed-off-by: Jeff King <peff@peff.net>
---
This feels awfully hacky, and maybe we should just throw it away unless
the CI job starts having problems. But I literally couldn't get through
a run without false positives, so at the very least I wanted to make
people aware of the problem and get that string into the list archive. ;)

 t/test-lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 377cc1c120..3951214cd5 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -324,6 +324,7 @@ nr_san_dir_leaks_ () {
 	find "$TEST_RESULTS_SAN_DIR" \
 		-type f \
 		-name "$TEST_RESULTS_SAN_FILE_PFX.*" 2>/dev/null |
+	xargs grep -lv "Unable to get registers from thread" |
 	wc -l
 }
 
-- 
2.37.3.1139.g47294c03c7


