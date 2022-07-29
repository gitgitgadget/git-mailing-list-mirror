Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F063AC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 20:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238844AbiG2UtK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 16:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiG2UtI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 16:49:08 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4D17697E
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 13:49:07 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-31f41584236so62399337b3.5
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 13:49:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=gbWQUVaDk2bf5ioBLtdX4XRvVeXNWv8Y1FEuK6z8Jsw=;
        b=YsbyEmCeBnPWHODG5Io5zpIH51fYIpvRoBmKYeD9A1trm4z6ILF4yVTowU1gW99uZg
         oU2DaF1kOZcWl/4T67y3xSzierx0COgY+03cLZQUjb9JykIwzFQnP0hrb9RYA47oDe/Z
         A3pWI8MjlSNLrQS74h6kLI3u2fJtdbZvx5xdc9Y9WCMj4ZYnxR/TWBQXPHFQvPzaW7Pw
         zJ2mFHkWIdY3xvdz+AfvUZ+9BEr9nKHrSzVtGBHvnDBo+DxKS2kuaRr3vKeYawEyYs/o
         RJFn2SimG/Foxu8JcxqWJMC7HwwCfPDSnsNB0tWlyDxNuwTi7W6AnBV9on8Hm9qGoU8P
         Y2rg==
X-Gm-Message-State: ACgBeo0I1gGmT+YXEmKOd8jwgF7Ugb7ynMzdEydLV9aohVWxf5HmAqJn
        hMJVOqIDoQSGF6nTA4RHYheUWAz+eN637uY3ask=
X-Google-Smtp-Source: AA6agR5WXZagXzKthJQL1EB5JK8CbTfyy674xOeRBd24P31qcOXscLvBSXOuwSb5ugwLVXeWa1UHsY6ZvUqdTzuexo4=
X-Received: by 2002:a0d:e853:0:b0:321:c297:c9b2 with SMTP id
 r80-20020a0de853000000b00321c297c9b2mr4655988ywe.493.1659127746682; Fri, 29
 Jul 2022 13:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <365e01e93dce582e9d926e83bdc6891310d22699.1659084832.git.congdanhqx@gmail.com>
 <xmqqbkt7api9.fsf@gitster.g> <YuQ60ZUPBHAVETD7@coredump.intra.peff.net>
In-Reply-To: <YuQ60ZUPBHAVETD7@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 29 Jul 2022 16:48:55 -0400
Message-ID: <CAPig+cSiAEgopj1zwR4kUG=ZLJQrNAVj0P5g4veWYD-ERr=irw@mail.gmail.com>
Subject: Re: [PATCH] merge-file: fix build warning with gcc 4.8.5
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 29, 2022 at 3:53 PM Jeff King <peff@peff.net> wrote:
> Subject: [PATCH] config.mak.dev: squelch -Wno-missing-braces for older gcc
>
> Versions of gcc prior to 4.9 complain about an initialization like:
>
>   struct inner { int x; };
>   struct outer { struct inner; };
>   struct outer foo = { 0 };
>
> and insist on:
>
>   struct outer foo = { { 0 } };
>
> Newer compilers handle this just fine. And ignoring the window even on
> older compilers is fine; the resulting code is correct, but we just get
> caught by -Werror.
>
> Let's relax this for older compilers to make developer lives easier (we
> don't care much about non-developers on old compilers; they may see a
> warning, but it won't stop compilation).
>
> Signed-off-by: Jeff King <peff@peff.net>

Leaving aside for the moment the problem with Apple's oddball invented
version numbers for `clang`, should this patch also take older `clang`
versions into consideration rather than focusing only on `gcc`? (Of
course, `clang` could be dealt with in a separate patch if you'd
rather not worry about it here.)

> diff --git a/config.mak.dev b/config.mak.dev
> index 335efd4620..b9878a4994 100644
> --- a/config.mak.dev
> +++ b/config.mak.dev
> @@ -59,9 +59,13 @@ endif
>
>  # uninitialized warnings on gcc 4.9.2 in xdiff/xdiffi.c and config.c
>  # not worth fixing since newer compilers correctly stop complaining
> +#
> +# Likwise, gcc older than 4.9 complains about initializing a
> +# struct-within-a-struct using just "{ 0 }"
>  ifneq ($(filter gcc4,$(COMPILER_FEATURES)),)
>  ifeq ($(filter gcc5,$(COMPILER_FEATURES)),)
>  DEVELOPER_CFLAGS += -Wno-uninitialized
> +DEVELOPER_CFLAGS += -Wno-missing-braces
>  endif
>  endif
