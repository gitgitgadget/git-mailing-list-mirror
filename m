Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B88C433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A02D760EB4
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhJ2Vos (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 17:44:48 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64067 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhJ2Voq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 17:44:46 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1090F16B76E;
        Fri, 29 Oct 2021 17:42:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=i4UC8Eoq1s6U/R+Jq66IxH9bkn1n1wIuQ6QyGC
        4GIOw=; b=UFodB/ZuDLKbYx9lhlMFRhAhY5XRu1D3100IEOLTH8tz9XEkY3d50x
        gt74vbmZgNr0HBK7DK9TFT+Z4+91vNpo0ZXP4cxBd6c6hy4aqrNenLPMA1uZFQXc
        1iS/Z+x2+IXchJu2YjV7vlULQpeeBXsqYLCaqjdxNgeExewdk8bCQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0990016B76D;
        Fri, 29 Oct 2021 17:42:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AB0C916B76C;
        Fri, 29 Oct 2021 17:42:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [Bug] wrapper.c uses unportable unsetenv
References: <012301d7cd01$90428960$b0c79c20$@nexbridge.com>
        <xmqqsfwjk1s3.fsf@gitster.g>
        <013501d7cd06$8c8281e0$a58785a0$@nexbridge.com>
        <013a01d7cd09$72d91cb0$588b5610$@nexbridge.com>
Date:   Fri, 29 Oct 2021 14:42:12 -0700
In-Reply-To: <013a01d7cd09$72d91cb0$588b5610$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Fri, 29 Oct 2021 17:10:44
        -0400")
Message-ID: <xmqqwnlvik3v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 14220A42-3901-11EC-B10F-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

> The actual issue is this:
>
>         if (!unsetenv(name))
>             ^
> "/home/ituglib/randall/git/wrapper.c", line 156: error(134):  expression
> must have arithmetic or pointer type
>
> This is with NO_UNSETENV = YesPlease. It makes no sense to me why this isn't
> compiling.

Ah, compat/unsetenv.c is broken.  gitunsetenv() should return int,
not void.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
Subject: unsetenv(3) returns int, not void

This compatilibity implementation has been returning a wrong type,
ever since 731043fd (Add compat/unsetenv.c ., 2006-01-25) added to
the system, yet nobody noticed it in the past 16 years, presumably
because no code checks failures in their unsetenv() calls.  Sigh.

For now, make it always succeed.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 compat/unsetenv.c | 2 +-
 git-compat-util.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git c/compat/unsetenv.c w/compat/unsetenv.c
index bf5fd7063b..46d49c2c5e 100644
--- c/compat/unsetenv.c
+++ w/compat/unsetenv.c
@@ -1,6 +1,6 @@
 #include "../git-compat-util.h"
 
-void gitunsetenv (const char *name)
+int gitunsetenv(const char *name)
 {
 #if !defined(__MINGW32__)
      extern char **environ;
diff --git c/git-compat-util.h w/git-compat-util.h
index b46605300a..0f7e369a5d 100644
--- c/git-compat-util.h
+++ w/git-compat-util.h
@@ -726,7 +726,7 @@ char *gitmkdtemp(char *);
 
 #ifdef NO_UNSETENV
 #define unsetenv gitunsetenv
-void gitunsetenv(const char *);
+int gitunsetenv(const char *);
 #endif
 
 #ifdef NO_STRCASESTR


