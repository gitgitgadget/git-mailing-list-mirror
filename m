Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF77CC83F15
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 18:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbjH1SiS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 14:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbjH1Sht (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 14:37:49 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A4EC6
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 11:37:36 -0700 (PDT)
Received: (qmail 31250 invoked by uid 109); 28 Aug 2023 18:37:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 28 Aug 2023 18:37:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2334 invoked by uid 111); 28 Aug 2023 18:37:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Aug 2023 14:37:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Aug 2023 14:37:35 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Teng Long <dyroneteng@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH] test-lib: ignore uninteresting LSan output
Message-ID: <20230828183735.GA3015072@coredump.intra.peff.net>
References: <cover.1692902414.git.me@ttaylorr.com>
 <b1711c4c817f95011bc477a9485c115b4926c7da.1692902414.git.me@ttaylorr.com>
 <20230824210238.GA940724@coredump.intra.peff.net>
 <ZOj7XqRSmIFxaI3P@nand.local>
 <20230825203819.GC2382334@coredump.intra.peff.net>
 <xmqqttsjgh3h.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqttsjgh3h.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 28, 2023 at 11:24:50AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I do think we should apply the racy-thread log fix, though. I thought we
> > had discussed it at the time, but there doesn't seem to be anything in
> > the archive. And I was willing to let it go as a weird one-off at the
> > time, but now that it wasted another 30 minutes of my life discovering
> > the problem again, I'm in favor of applying it.
> >
> > Whether it happens as part of your re-rolled series, or is applied
> > separately, I am OK either way. :)
> 
> Whether it comes from you or Taylor, I do favor to see it as a new
> message at lore archive than having to fish an older message from it
> ;-)

I re-sent it already as part of this thread. But I guess the definition
of "older" may depend on whether you were paying attention to the thread
at that point. ;)

Here it is again. Let's just consider it as its own topic. There is
nothing in Taylor's series that depends on it (it's just that it was
useful for me to reproduce his findings).

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

