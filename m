Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA796C2D0DB
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 16:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87477214AF
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 16:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgA0Q7R (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 11:59:17 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37393 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgA0Q7R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 11:59:17 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so12279564wru.4
        for <git@vger.kernel.org>; Mon, 27 Jan 2020 08:59:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4V+180VurbbOjZCq6OH85b+alrQrue604R2IdWfooKo=;
        b=KfZXukLKTZJYmqOGa3bJULLNGfdUP/DR6pPmy6Q2wEn06/n+GfiV6q3L4NwMILJ/1p
         WwPlKOssBRWzIz4NUcVkfM/Z3d6DEIVzpykb2IbMOBUWt6kzZhjcvZKkbFspNaFBFhMh
         2ybYzGLPT5zFpfzo55DPO4bVGCUmObVURnpD7I7ud4TlV73S0F7JuQB8tfH5I55y3pP/
         Pj14u3Nx0L5q1XFWniUXaOTxjvOXVnXSs+xWWV2OSZxCNFTqsMijIp31hwoBdr/6NxJQ
         rAHIMjNpuSQoQ8SE2dqOZNhVF9bjRPBDzPyvv/9zdhOqPnbqg8PqfBDZRKVHUYQpzaTo
         yf5w==
X-Gm-Message-State: APjAAAUZhkMPdH7aPxUB7mDBhvLAfPcYlUl0doCj8OtmJ7qkc5cvkLna
        RqqOJXRz8fqDAtoPKckvwyZi7DKR3KQsYW0QNbmIGH3X
X-Google-Smtp-Source: APXvYqyghuZb4LPF+9uKBzeV3EQfT2MxOkBCFSPzh+nNanIxiSOEGe8PxVDRnF2NCurggm2Mwnfy+xvLCuP4vmIUQB0=
X-Received: by 2002:a5d:5752:: with SMTP id q18mr9700943wrw.277.1580144354858;
 Mon, 27 Jan 2020 08:59:14 -0800 (PST)
MIME-Version: 1.0
References: <20200127100933.10765-1-git@zjvandeweg.nl> <20200127100933.10765-2-git@zjvandeweg.nl>
In-Reply-To: <20200127100933.10765-2-git@zjvandeweg.nl>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 27 Jan 2020 11:59:03 -0500
Message-ID: <CAPig+cS03oS9PhN_cusjpzoCzwNmgc5rXiVAmG3ceUCFw71PVg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] config: learn the --stdin option for instructions
To:     Zeger-Jan van de Weg <git@zjvandeweg.nl>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 27, 2020 at 5:17 AM Zeger-Jan van de Weg <git@zjvandeweg.nl> wrote:
> When setting values in the git config, the value is part of the
> arguments for execution. This potentially leaks the value through
> logging, or other programs like `ps`.
>
> Add the `--stdin` option that reads from stdin for instructions to set
> and unset values to hide them from prying eyes. The instructions are based
> on the `update-ref` DSL, and accept the set and unset commands.
>
> Signed-off-by: Zeger-Jan van de Weg <git@zjvandeweg.nl>
> ---
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> @@ -259,6 +264,30 @@ Valid `<type>`'s include:
> +STDIN
> +-----
> +
> +With `--stdin`, config reads instructions from standard input and performs
> +all modifications in sequence.
> +
> +Specify commands of the form:
> +
> +    set SP <key> SP <newvalue>
> +    unset SP <key>

If you follow the precedent of the git-update-ref documentation, these
should be:

    set SP <key> SP <newvalue> LF
    unset SP <key> LF

I'm not sure we really need to be calling the value "newvalue" (I
guess you picked that up from git-update-ref.txt). "value" should be
fine, thus:

    set SP <key> SP <value> LF
    unset SP <key> LF

> +Alternatively, use `-z` or `--null` to specify in NUL-terminated format, without
> +quoting:
> +
> +    set SP <key> NULL <newvalue>
> +    unset SP <key>

A few comments:

First, this is talking about the NUL character, not a NULL pointer,
so: s/NULL/NUL/

Second, this doesn't give any indication about how the lines should be
terminated. It should instead be written as:

    set SP <key> NUL <value> NUL
    unset SP <key> NUL

Third, importantly, unlike git-update-ref from which this DSL takes
inspiration and in which "refs" might have oddball names for which
NUL-termination makes sense, it's hard to imagine a case in which a
configuration key would be so strange as to warrant NUL-termination.
This observation suggests a simpler DSL in which only <value> is
NUL-terminated:

    set SP <key> SP <value> NUL
    unset SP <key> LF

(The proposed code changes in config.c would need adjustment, as well,
to implement this revised DSL.)

> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> @@ -380,6 +380,66 @@ test_expect_success '--add' '
> +test_expect_success '--stdin works on no input' '
> +    echo -n "" | git config --stdin
> +'

`echo -n` is not portable. If you want no input at all, either grab it
from /dev/null:

    git config --stdin </dev/null

or use `printf` to suppress printing of the line-terminator:

    printf "" | git config --stdin

> +test_expect_success '--stdin with --null flag' '
> +    echo -ne "set bar.baz\0false" | git config --stdin --null &&
> +    Git config --get bar.baz >output &&
> +    echo false >expect &&
> +    test_cmp expect output
> +'

Likewise, non-portable use of `echo -n` and `echo "...\0...". Use
`printf` instead:

    printf "set bar.baz\0false" | git config --stdin --null &&

(But note that this isn't even testing NUL-termination of <value>.)
