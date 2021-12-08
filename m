Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B0CC433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 19:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbhLHTy1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 14:54:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:46952 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229750AbhLHTy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 14:54:27 -0500
Received: (qmail 11072 invoked by uid 109); 8 Dec 2021 19:50:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Dec 2021 19:50:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6461 invoked by uid 111); 8 Dec 2021 19:50:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Dec 2021 14:50:55 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Dec 2021 14:50:54 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH] config.mak.dev: specify -std=gnu99 for gcc/clang
Message-ID: <YbEMnksMEuAz3Nt0@coredump.intra.peff.net>
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
 <8deccc3a1dff7e4f7d613fa63d2781fd1f11f841.1638899124.git.gitgitgadget@gmail.com>
 <xmqqlf0w5bbc.fsf@gitster.g>
 <YbAVOtYXA1Hf9EtJ@coredump.intra.peff.net>
 <xmqq4k7j68eg.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4k7j68eg.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 07, 2021 at 08:13:43PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> error: ISO C99 doesn't support unnamed structs/unions [-Werror=pedantic]
> >
> > Hmm. It's interesting that the regular DEVELOPER=1 doesn't catch this.
> > It's because we don't specify -std there, and newer gcc defaults to
> > gnu17 (unnamed unions appeared in c11, I think). I wonder if it would be
> > helpful to teach config.mak.dev to pass -std=c99.
> 
> FWIW, I use -std=gnu99 as our Makefile suggests.

I think the patch below would have detected this both locally for
Han-Wen, but also in C.

-- >8 --
Subject: [PATCH] config.mak.dev: specify -std=gnu99 for gcc/clang

The point of DEVELOPER=1 is to turn up the warnings so we can catch
portability or correctness mistakes at the compiler level. But since
modern compilers tend to default to modern standards like gnu17, we
might miss warnings about older standards, even though we expect Git to
build with compilers that use them.

So it's helpful for developer builds to set the -std argument to our
lowest-common denominator. Traditionally this was c89, but since we're
moving to assuming c99 in 7bc341e21b (git-compat-util: add a test
balloon for C99 support, 2021-12-01) that seems like a good spot to
land. And as explained in that commit, we want "gnu99" because we still
want to take advantage of some extensions when they're available.

The new argument kicks in only for clang and gcc (which we know to
support "-std=" and "gnu" standards). And only for compiler versions
which default to a newer standard. That will avoid accidentally
silencing any build problems that non-developers would run into on older
compilers that default to c89.

My digging found that the default switched to gnu11 in gcc 5.1.0.
Clang's documentation is less clear, but has done so since at least
clang-7. So that's what I put in the conditional here. It's OK to err on
the side of not-enabling this for older compilers. Most developers (as
well as CI) are using much more recent versions, so any warnings will
eventually surface.

A concrete example is anonymous unions, which became legal in c11.
Without this patch, "gcc -pedantic" will not complain about them, but
will if we add in "-std=gnu99".

Signed-off-by: Jeff King <peff@peff.net>
---
 config.mak.dev | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/config.mak.dev b/config.mak.dev
index 7673fed114..d4afac6b51 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -19,6 +19,11 @@ endif
 endif
 endif
 endif
+
+ifneq ($(or $(filter gcc6,$(COMPILER_FEATURES)),$(filter clang7,$(COMPILER_FEATURES))),)
+DEVELOPER_CFLAGS += -std=gnu99
+endif
+
 DEVELOPER_CFLAGS += -Wdeclaration-after-statement
 DEVELOPER_CFLAGS += -Wformat-security
 DEVELOPER_CFLAGS += -Wold-style-definition
-- 
2.34.1.503.gbf394de69d

