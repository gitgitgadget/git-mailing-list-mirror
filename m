Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E4BC7113B
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 20:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243583AbjHXUzc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Aug 2023 16:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243604AbjHXUy7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 16:54:59 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D481993
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 13:54:57 -0700 (PDT)
Received: (qmail 16385 invoked by uid 109); 24 Aug 2023 20:54:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Aug 2023 20:54:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22427 invoked by uid 111); 24 Aug 2023 20:54:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Aug 2023 16:54:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Aug 2023 16:54:56 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Teng Long <dyroneteng@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 0/3] leak tests: mark remaining tests leak-free as such
Message-ID: <20230824205456.GA2309362@coredump.intra.peff.net>
References: <cover.1692902414.git.me@ttaylorr.com>
 <20230824205009.GA1516@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230824205009.GA1516@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 24, 2023 at 04:50:10PM -0400, Jeff King wrote:

> If I run a few by hand, I _do_ see leaks in them, but the exit codes are
> hidden from the test suite (they are sub-programs of scripts, etc). I
> guess you also have:
> 
>   GIT_TEST_SANITIZE_LEAK_LOG=true
> 
> set, which should find those (and which you mention in your first
> commit). Turning that on eliminates some of them, but I'm left with:
> 
>   t5614 t5317 t5503
> 
> not in your list. Which is super weird, because t5614 is marked with
> TEST_PASSES_SANITIZE_LEAK. Hrm. And if I run it again, I get a
> _different_ set (t5614 again, along with your 4, but also t5303, t7701,
> and t4050). I wonder if we have a race in the leak-log code or
> something (I'm running under prove with -j32, naturally).

Argh. It is this again:

  https://lore.kernel.org/git/Yxl62zODF4oy1QL9@coredump.intra.peff.net/

Can we revisit that patch? Included again below for reference.

-- >8 --
Subject: [PATCH] test-lib: ignore uninteresting LSan output

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
 t/test-lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 293caf0f20..5ea5d1d62a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -334,6 +334,7 @@ nr_san_dir_leaks_ () {
 	find "$TEST_RESULTS_SAN_DIR" \
 		-type f \
 		-name "$TEST_RESULTS_SAN_FILE_PFX.*" 2>/dev/null |
+	xargs grep -lv "Unable to get registers from thread" |
 	wc -l
 }
 
-- 
2.42.0.448.g0caf9a9e14

