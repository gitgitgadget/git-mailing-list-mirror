Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D82C433F5
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 17:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347541AbiARRrp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 12:47:45 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57555 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiARRro (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 12:47:44 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BA9A517CADE;
        Tue, 18 Jan 2022 12:47:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g6szhg8qmGIDPAbdEsGpZnP5anBxDnlXmc+5s6
        FczYY=; b=ouws9AkEvrFTKskLBXWUaVLMZpa4euYN3GXMwOmyE43h0dOCGuw9CI
        owbpmz4I5BocL8uH/O1vOp4QmirRAzxp7YN9cm6yHNihDlI5n12R2xQNlpsTd6ta
        3h5TfkNIAyT7M+luddMsbahkJOJsNfp2uw8cZCqHPPFqyINs9HKIM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B220817CADD;
        Tue, 18 Jan 2022 12:47:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0645117CADA;
        Tue, 18 Jan 2022 12:47:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] Makefile: FreeBSD cannot do C99-or-below build
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
        <8deccc3a1dff7e4f7d613fa63d2781fd1f11f841.1638899124.git.gitgitgadget@gmail.com>
        <xmqqlf0w5bbc.fsf@gitster.g>
        <YbAVOtYXA1Hf9EtJ@coredump.intra.peff.net>
        <xmqq4k7j68eg.fsf@gitster.g>
        <YbEMnksMEuAz3Nt0@coredump.intra.peff.net>
        <211209.867dcekm9h.gmgdl@evledraar.gmail.com>
        <YbMWNZCpy578Qu+l@coredump.intra.peff.net>
        <220113.86tue7vr6d.gmgdl@evledraar.gmail.com>
        <YeDUA6NhHuCUkqXf@camp.crustytoothpaste.net>
        <xmqqilumayfh.fsf@gitster.g> <xmqqzgny7xo7.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2201181308540.2121@tvgsbejvaqbjf.bet>
Date:   Tue, 18 Jan 2022 09:47:39 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2201181308540.2121@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Tue, 18 Jan 2022 13:32:03 +0100
        (CET)")
Message-ID: <xmqq1r15szpg.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BBA01934-7886-11EC-A4B6-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In "make DEVELOPER=YesPlease" builds, we try to help developers to
catch as many potential issues as they can by using -Wall and
turning compilation warnings into errors.  In the same spirit, we
recently started adding -std=gnu99 to their CFLAGS, so that they can
notice when they accidentally used language features beyond C99.

It however turns out that FreeBSD 13.0 mistakenly uses C11 extension
in its system header files regardless of what __STDC_VERSION__ says,
which means that the platform (unless we tweak their system headers)
cannot be used for this purpose.

It seems that -std=gnu99 is only added conditionally even in today's
config.mak.dev, so it is fine if we dropped -std=gnu99 from there.
Which means that developers on FreeBSD cannot participate in vetting
use of features beyond C99, but there are developers on other
platforms who will, so it's not too bad.

We might want a more "fundamental" fix to make the platform capable
of taking -std=gnu99, like working around the use of unconditional
C11 extension in its system header files by supplying a set of
"replacement" definitions in our header files.  We chose not to
pursue such an approach for two reasons at this point:

 (1) The fix belongs to the FreeBSD project, not this project, and
     such an upstream fix may happen hopefully in a not-too-distant
     future.

 (2) Fixing such a bug in system header files and working it around
     can lead to unexpected breakages (other parts of their system
     header files may not be expecting to see and do not work well
     with our "replacement" definitions).  This close to the final
     release of this cycle, we have no time for that.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.mak.dev | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/config.mak.dev b/config.mak.dev
index d4afac6b51..3deb076d5e 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -20,9 +20,14 @@ endif
 endif
 endif
 
+ifneq ($(uname_S),FreeBSD)
 ifneq ($(or $(filter gcc6,$(COMPILER_FEATURES)),$(filter clang7,$(COMPILER_FEATURES))),)
 DEVELOPER_CFLAGS += -std=gnu99
 endif
+else
+# FreeBSD cannot limit to C99 because its system headers unconditionally
+# rely on C11 features.
+endif
 
 DEVELOPER_CFLAGS += -Wdeclaration-after-statement
 DEVELOPER_CFLAGS += -Wformat-security
-- 
2.35.0-rc1-135-g45b839adb0

