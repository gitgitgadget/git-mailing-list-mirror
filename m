Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E763BC433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 19:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D6A9206DD
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 19:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391559AbgJOTaa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 15:30:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:33378 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391541AbgJOTaa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 15:30:30 -0400
Received: (qmail 24178 invoked by uid 109); 15 Oct 2020 19:30:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Oct 2020 19:30:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32202 invoked by uid 111); 15 Oct 2020 19:30:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Oct 2020 15:30:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Oct 2020 15:30:29 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: [PATCH v2 2/2] config.mak.dev: build with -fno-common
Message-ID: <20201015193029.GB1129761@coredump.intra.peff.net>
References: <20201015192845.GD1108210@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201015192845.GD1108210@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's an easy mistake to define a variable in a header with "int x;" when
you really meant to only declare the variable as "extern int x;"
instead. Clang and gcc will both allow this when building with
"-fcommon"; they put these "tentative definitions" in a common block
which the linker is able to resolve.

This is the default in clang and was the default in gcc until gcc-10,
since it helps some legacy code. However, we would prefer not to rely on
this because:

  - using "extern" makes the intent more clear (so it's a style issue,
    but it's one the compiler can help us catch)

  - according to the gcc manpage, it may yield a speed and code size
    penalty

So let's build explicitly with -fno-common when the DEVELOPER knob is
set, which will let developers using clang and older versions of gcc
notice these problems.

I didn't bother making this conditional on a particular version of gcc.
As far as I know, this option has been available forever in both gcc and
clang, so old versions don't need to avoid it. And we already expect gcc
and clang options throughout config.mak.dev, so it's unlikely anybody
setting the DEVELOPER knob is using anything else. It's a noop on
gcc-10, of course, but it's not worth trying to exclude it there.

Note that there's nothing to fix in the code; we already don't have any
issues here. But if you want to test the patch, you can add a bare "int
x;" into cache.h, which will cause the link step to fail.

Signed-off-by: Jeff King <peff@peff.net>
---
New in this version. It could be queued separately from the first.

 config.mak.dev | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.dev b/config.mak.dev
index 89b218d11a..89fefacd94 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -15,6 +15,7 @@ DEVELOPER_CFLAGS += -Wpointer-arith
 DEVELOPER_CFLAGS += -Wstrict-prototypes
 DEVELOPER_CFLAGS += -Wunused
 DEVELOPER_CFLAGS += -Wvla
+DEVELOPER_CFLAGS += -fno-common
 
 ifndef COMPILER_FEATURES
 COMPILER_FEATURES := $(shell ./detect-compiler $(CC))
-- 
2.29.0.rc1.562.g7bd9bc8902
