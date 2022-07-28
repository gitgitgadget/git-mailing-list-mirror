Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA72C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 21:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbiG1VbS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 17:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiG1VbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 17:31:16 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500C84E63E
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 14:31:15 -0700 (PDT)
Received: (qmail 19246 invoked by uid 109); 28 Jul 2022 21:31:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Jul 2022 21:31:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17710 invoked by uid 111); 28 Jul 2022 21:31:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Jul 2022 17:31:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Jul 2022 17:31:13 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH] CI: add SANITIZE=[address|undefined] jobs
Message-ID: <YuMAIfM3jv6lI9SA@coredump.intra.peff.net>
References: <patch-1.1-e48b6853dd5-20220726T110716Z-avarab@gmail.com>
 <YuGPeHn9wfF6tWA5@coredump.intra.peff.net>
 <220728.86o7x9jhrp.gmgdl@evledraar.gmail.com>
 <YuL7EotrIpnOn5BT@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YuL7EotrIpnOn5BT@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 28, 2022 at 05:09:38PM -0400, Jeff King wrote:

> > Ditto TEST_NO_MALLOC_CHECK=1 & --no-bin-wrappers, but we can think about
> > all of those some other time....
> 
> I'd be surprised if the malloc checking itself is all that expensive,
> though it does look like we call getconf and expr once per test there
> for setup. We could almost certainly hoist that out and call it once per
> script.

Nope, I was totally wrong here. Running with TEST_NO_MALLOC_CHECK=1 does
indeed make a big difference:

  Benchmark 1: make test
    Time (mean ± σ):     67.486 s ±  3.339 s    [User: 622.643 s, System: 409.951 s]
    Range (min … max):   63.634 s … 69.550 s    3 runs
   
  Benchmark 2: TEST_NO_MALLOC_CHECK=1 make test
    Time (mean ± σ):     57.596 s ±  0.899 s    [User: 577.273 s, System: 291.627 s]
    Range (min … max):   57.072 s … 58.634 s    3 runs

Eliminating the extra per-test processes with the patch below helps a
little, but most of the effort really is (presumably) going to the
actual malloc checking code:

  Benchmark 1: make test [nb: after applying patch...]
  Time (mean ± σ):     67.091 s ±  0.385 s    [User: 599.382 s, System: 410.781 s]
  Range (min … max):   66.648 s … 67.343 s    3 runs

Curious that most of the CPU time seems to go into system time. I'd have
thought it was extra internal malloc debugging bits, but maybe it is
allocating mmap/brk calls in a less efficient way. I dunno how any of it
actually works.

-Peff

---
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 55857af601..303fbe8ecc 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -557,14 +557,20 @@ then
 		: nothing
 	}
 else
+	if _GLIBC_VERSION=$(getconf GNU_LIBC_VERSION 2>/dev/null) &&
+	   _GLIBC_VERSION=${_GLIBC_VERSION#"glibc "} &&
+	    expr 2.34 \<= "$_GLIBC_VERSION" >/dev/null
+	then
+		USE_LIBC_MALLOC_DEBUG=t
+	else
+		USE_LIBC_MALLOC_DEBUG=
+	fi
 	setup_malloc_check () {
 		local g
 		local t
 		MALLOC_CHECK_=3	MALLOC_PERTURB_=165
 		export MALLOC_CHECK_ MALLOC_PERTURB_
-		if _GLIBC_VERSION=$(getconf GNU_LIBC_VERSION 2>/dev/null) &&
-		   _GLIBC_VERSION=${_GLIBC_VERSION#"glibc "} &&
-		   expr 2.34 \<= "$_GLIBC_VERSION" >/dev/null
+		if test -n "$USE_LIBC_MALLOC_DEBUG"
 		then
 			g=
 			LD_PRELOAD="libc_malloc_debug.so.0"
