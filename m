Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF477C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 19:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238818AbiG2TyA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 15:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiG2Tx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 15:53:59 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5099370E79
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 12:53:57 -0700 (PDT)
Received: (qmail 22315 invoked by uid 109); 29 Jul 2022 19:53:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Jul 2022 19:53:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28574 invoked by uid 111); 29 Jul 2022 19:53:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Jul 2022 15:53:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 29 Jul 2022 15:53:53 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] merge-file: fix build warning with gcc 4.8.5
Message-ID: <YuQ60ZUPBHAVETD7@coredump.intra.peff.net>
References: <365e01e93dce582e9d926e83bdc6891310d22699.1659084832.git.congdanhqx@gmail.com>
 <xmqqbkt7api9.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbkt7api9.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 29, 2022 at 08:48:46AM -0700, Junio C Hamano wrote:

> I think the concensus was that we should squelch the false warning
> on older compilers with -Wno-missing-braces, but then the discussion
> has stalled by a suggestion to introduce a way to detect older
> compilers that is different from how we do so at the same time, and
> went nowhere.
> 
> Hopefully we can add a simple -Wno-* without waiting for whole
> config.mak thing getting revamped this time?

Perhaps this?

-- >8 --
Subject: [PATCH] config.mak.dev: squelch -Wno-missing-braces for older gcc

Versions of gcc prior to 4.9 complain about an initialization like:

  struct inner { int x; };
  struct outer { struct inner; };
  struct outer foo = { 0 };

and insist on:

  struct outer foo = { { 0 } };

Newer compilers handle this just fine. And ignoring the window even on
older compilers is fine; the resulting code is correct, but we just get
caught by -Werror.

Let's relax this for older compilers to make developer lives easier (we
don't care much about non-developers on old compilers; they may see a
warning, but it won't stop compilation).

Signed-off-by: Jeff King <peff@peff.net>
---
Tested on a debian jessie chroot using gcc-4.8 and 4.9. Though note that
you also need to manually specify -std=gnu99 to get it to work at all
with those compilers these days! So I kind of wonder if it's even worth
catering to their warnings automatically.

 config.mak.dev | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/config.mak.dev b/config.mak.dev
index 335efd4620..b9878a4994 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -59,9 +59,13 @@ endif
 
 # uninitialized warnings on gcc 4.9.2 in xdiff/xdiffi.c and config.c
 # not worth fixing since newer compilers correctly stop complaining
+#
+# Likwise, gcc older than 4.9 complains about initializing a
+# struct-within-a-struct using just "{ 0 }"
 ifneq ($(filter gcc4,$(COMPILER_FEATURES)),)
 ifeq ($(filter gcc5,$(COMPILER_FEATURES)),)
 DEVELOPER_CFLAGS += -Wno-uninitialized
+DEVELOPER_CFLAGS += -Wno-missing-braces
 endif
 endif
 
-- 
2.37.1.804.g1775fa20e0

