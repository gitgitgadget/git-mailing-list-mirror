Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA22C433B4
	for <git@archiver.kernel.org>; Sat,  1 May 2021 18:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2D9F61450
	for <git@archiver.kernel.org>; Sat,  1 May 2021 18:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbhEAS4O (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 May 2021 14:56:14 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:45601 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbhEAS4N (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 May 2021 14:56:13 -0400
Received: by mail-ej1-f42.google.com with SMTP id u3so1914519eja.12
        for <git@vger.kernel.org>; Sat, 01 May 2021 11:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4j87D9BeGihiorPYVBxzOv2RzJU43OnhKI8FV8cnmSM=;
        b=L46w/nUD5B5vYGlufGqthP/q87iteUnyqR+KvQOuZ0DLwwelDtOM0OKHU7LiDEEHzY
         NEdea16FkkMhol1PzB7Oi9iA6YNDdYT4W1hHAEqBD2Y8cnBkdwPjPvDapuqPgP53v99i
         HAyfAWfE87Sk0Nu5K7gAqpuKeav39ULyLIwzfT+6SRDHdlNlRtY6m+7fvF8K+qxLp4Wk
         664DpWDb37G72PYdLjGOfaar+alfxOi+S/ucbi5ze4wJKAIoYAZhq9LYts6VXL/ORiHP
         CgiVncIFJdxy0lOVSbfa2SSpnm/bB66V9y3enJZG2el5xCoqdQBwvAncXDbiDAPKuHmK
         JX8w==
X-Gm-Message-State: AOAM533xojZs3hcymQu6XNTolqtQBsYrWSskUS+A/05SY3eX/6iLEAZD
        Bkz4bzciSwbbXKH6qfxBKoM7po2kYRxJPnr7ib6AJaXglM0=
X-Google-Smtp-Source: ABdhPJxxNgynu5v9jQPNVtZt5tP8Lnmwtn2/iNUhuGBMtyWeO+8B0xaBxzXRkccmJqi3yFGvYECOUSBEGFlDGaJ6VZU=
X-Received: by 2002:a17:906:edcf:: with SMTP id sb15mr9821714ejb.202.1619895322573;
 Sat, 01 May 2021 11:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <YI12hK4X/gfl3u29@coredump.intra.peff.net> <YI124aZ1dbY5O67J@coredump.intra.peff.net>
In-Reply-To: <YI124aZ1dbY5O67J@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 1 May 2021 14:55:11 -0400
Message-ID: <CAPig+cSxB89mJcjaoLMLEgqdqi9SSP5+R9qjbVydvA-kVq-2+g@mail.gmail.com>
Subject: Re: [PATCH 5/9] t7450: test verify_path() handling of gitmodules
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 1, 2021 at 11:42 AM Jeff King <peff@peff.net> wrote:
> Commit 10ecfa7649 (verify_path: disallow symlinks in .gitmodules,
> 2018-05-04) made it impossible to load a symlink .gitmodules file into
> the index. However, there are no tests of this behavior. Let's make sure
> this case is covered. We can easily reuse the test setup created by
> the matching b7b1fca175 (fsck: complain when .gitmodules is a symlink,
> 2018-05-04).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
> @@ -139,7 +139,7 @@ test_expect_success 'index-pack --strict works for non-repo pack' '
> -test_expect_success 'fsck detects symlinked .gitmodules file' '
> +test_expect_success 'set up repo with symlinked .gitmodules file' '
>         git init symlink &&
>         (
>                 cd symlink &&
> @@ -155,8 +155,14 @@ test_expect_success 'fsck detects symlinked .gitmodules file' '
>                 {
>                         printf "100644 blob $content\t$tricky\n" &&
>                         printf "120000 blob $target\t.gitmodules\n"
> -               } >bad-tree &&
> -               tree=$(git mktree <bad-tree) &&
> +               } >bad-tree
> +       ) &&
> +       tree=$(git -C symlink mktree <symlink/bad-tree)
> +'

`tree` is an unusually generic name for this now-global variable. One
can easily imagine it being re-used by some unrelated test arbitrarily
inserted into this script, thus potentially breaking the following
tests which depend upon it. I wonder if a name such as `BAD_TREE`
would be more appropriate.
