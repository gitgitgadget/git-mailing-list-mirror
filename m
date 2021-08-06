Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AD5C4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 19:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EF6C61159
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 19:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243827AbhHFTUk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 15:20:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:41474 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243805AbhHFTUj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 15:20:39 -0400
Received: (qmail 16684 invoked by uid 109); 6 Aug 2021 19:20:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Aug 2021 19:20:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15177 invoked by uid 111); 6 Aug 2021 19:20:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Aug 2021 15:20:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 6 Aug 2021 15:20:22 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH] makefile: update detect-compiler for newer Xcode version
Message-ID: <YQ2LdvwEnZN9LUQn@coredump.intra.peff.net>
References: <20210806080634.11869-1-carenas@gmail.com>
 <m2sfzmu1t7.fsf@gmail.com>
 <xmqq8s1eigto.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8s1eigto.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 06, 2021 at 11:11:31AM -0700, Junio C Hamano wrote:

> > So maybe we could add another case for "Homebrew clang"?
> 
> $ clang --version 2>&1 | sed -ne 's/ version .*//p'
> Debian clang
> 
> It might be necessary to cope with this "$VENDOR clang version"
> convention better with something like the following.

Good catch. Unfortunately your patch below isn't sufficient because
get_family() is broken, too. :(

It insists on there being an extra word after the actual version. There
is for gcc, but not for clang on my system:

  $ CC=gcc get_version_line
  gcc version 10.2.1 20210110 (Debian 10.2.1-6)

  $ CC=clang get_version_line
  Debian clang version 11.0.1-2

Doing this on top of your patch makes "./detect-compiler clang" behave
as expected:

diff --git a/detect-compiler b/detect-compiler
index a80442a327..fd388ae783 100755
--- a/detect-compiler
+++ b/detect-compiler
@@ -13,11 +13,11 @@ get_version_line() {
 }
 
 get_family() {
-	get_version_line | sed 's/^\(.*\) version [0-9][^ ]* .*/\1/'
+	get_version_line | sed 's/^\(.*\) version [0-9].*/\1/'
 }
 
 get_version() {
-	get_version_line | sed 's/^.* version \([0-9][^ ]*\) .*/\1/'
+	get_version_line | sed 's/^.* version \([0-9][^ ]*\).*/\1/'
 }
 
 print_flags() {

> I am afraid that this patch is being a bit too aggressive about
> LLVM, as I do not know if "$VENDOR LLVM version" is also a thing, or
> it is just oddity only at Apple, though.

I think even before this issue, all of the versioning of Apple's clang
is suspect. The "Apple LLVM" bit comes from Eric in:

  https://lore.kernel.org/git/20180318090607.GA26226@flurp.local/

But downthread we realized that the version numbers there don't match
the clang ones:

  https://lore.kernel.org/git/CAPig+cRQXQ_DowS2Dsc1x3TAGJjnWig7P4eYS4kQ+C2piAdSWA@mail.gmail.com/

Duy indicated in the cover letter:

  https://lore.kernel.org/git/20180324125348.6614-1-pclouds@gmail.com/

that the apple support was probably wrong, but it looks like nobody
stepped up in the meantime to fix it. In practice I think it mostly
works anyway because "clang4" is the only version check we have for
clang. So if we err "ahead" a few versions (which is what Apple's
scheme does), you only get bit if you have a pretty old version of
Xcode.

I think if we wanted to get it right, we'd need to encode into the
script some form of the version table here:

  https://en.wikipedia.org/wiki/Xcode#Xcode_11.x_-_13.x_%28since_SwiftUI_framework%29

-Peff
