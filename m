Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FB1C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 01:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbhLIBnS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 20:43:18 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61026 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbhLIBnS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 20:43:18 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5D3CE161144;
        Wed,  8 Dec 2021 20:39:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WMJLh5HQZ/sdPAiOVG6EIHd5+pAP/aAQvjwmE9
        DJh0w=; b=KR/QVPOL1yCm+UO0eC0tWls0302MyY1tFC8rNkf6D/wS5hUVHBhNLg
        uiu1XXjCjAic0jixrReeuRKqLdjFoEcQYlNorkoJp0+xBWjmtd7Fgn9DlPfraY50
        4eRTLwPCcv3Ix4b85jnas4tTRsOdK1xiKsex3+KnR7dAv8u0O6P2c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 47AE0161143;
        Wed,  8 Dec 2021 20:39:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3936B161142;
        Wed,  8 Dec 2021 20:39:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Neeraj Singh <neerajsi@microsoft.com>, <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org,
        "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: Re: [PATCH] git-compat-util(msvc): C11 does not imply support for
 zero-sized arrays
References: <pull.1094.git.1638823724410.gitgitgadget@gmail.com>
Date:   Wed, 08 Dec 2021 17:39:39 -0800
In-Reply-To: <pull.1094.git.1638823724410.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Mon, 06 Dec 2021 20:48:44
        +0000")
Message-ID: <xmqqee6mv9no.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E0D92E18-5890-11EC-8679-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> This seems to be required to define `FLEX_ARRAY` in a manner that MSVC
> in C11 mode accepts. Without this fix, building Git for Windows'
> experimental FSCache code would fail thusly:

So, what's the final verdict on this one, after a few back and forth
to clarify the "seems to be required" above?

In the meantime, I am tempted to queue the following as a pure
clean-up.

Thoughts?

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
Subject: [PATCH] flex-array: simplify compiler-specific workaround

We use "type array[];" syntax for the flex-array member at the end
of a struct under C99 or later, except when we are building with
older SUNPRO_C compilers.  As we find more vendor compilers that
claim to grok C99 but not understand  ts flex-array syntax, the
existing "If we are using C99, but not with these compilers..."
conditional will keep growing.

Make it more manageable by listing vendor-specific exceptions
earlier, with the expectation that new exceptions will not be
combined into existing ones to make the condition longer, and
instead will be implemented as a new "#elif" in the cascade of
#if/#elif/#else/#endif.  E.g. if MSC is found to have a quirk
similar to old SUNPRO_C, we can just add a single line 

    #elif defined(_MSC_VER)

immediately before "#elif defined(__GNUC__)" to cause us to fallback
to the safer but a bit wasteful version.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-compat-util.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git c/git-compat-util.h w/git-compat-util.h
index c6bd2a84e5..9ba047a58e 100644
--- c/git-compat-util.h
+++ w/git-compat-util.h
@@ -33,14 +33,23 @@
 /*
  * See if our compiler is known to support flexible array members.
  */
-#if defined(__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L) && (!defined(__SUNPRO_C) || (__SUNPRO_C > 0x580))
-# define FLEX_ARRAY /* empty */
+
+/*
+ * Check vendor specific quirks first, before checking the
+ * __STDC_VERSION__, as vendor compilers can lie and we need to be
+ * able to work them around.  Note that by not defining FLEX_ARRAY
+ * here, we can fall back to use the "safer but a bit wasteful" one
+ * later.
+ */
+#if defined(__SUNPRO_C) && (__SUNPRO_C <= 0x580)
 #elif defined(__GNUC__)
 # if (__GNUC__ >= 3)
 #  define FLEX_ARRAY /* empty */
 # else
 #  define FLEX_ARRAY 0 /* older GNU extension */
 # endif
+#elif defined(__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L)
+# define FLEX_ARRAY /* empty */
 #endif
 
 /*


