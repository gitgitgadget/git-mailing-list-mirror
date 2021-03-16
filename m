Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D459C433DB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 23:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 110F164EFD
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 23:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhCPXgz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 19:36:55 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:35776 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhCPXgv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 19:36:51 -0400
Received: by mail-ej1-f48.google.com with SMTP id dx17so75033281ejb.2
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 16:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xvDaSS2mr9eifLZsYNyF2jxMZ95CPvvLt8Dtj7nWCtU=;
        b=U1xZiNCT0c6VHLI+QimkR6ZMFsVb+jAYbIuxyAVKWNwD9gAPdVgCWhUv0l2ekyHphN
         snBr5wIHm+L7eY76CZ0+DBDxpfFfP0DF+DhWnmUKJqK4BTMabUujq8BMMA73dUS4xmZ6
         Bs/xQZY2OutOwddAj8+UZF49YwEo4DZlGjLYEmf4QtCOPToB8aL9I6LsDf5HwRN/6bWd
         PLLrGzFTOrCHYsvtkTSYvFYvhErOm1MSNdUsPmq7D3TylncEDnhcUQnAnwF4tCHck65o
         OmIeWb4jvpPwff4z8/3wGmdksOBUEPLkRsZ7J2h55bVavCdQJDmYEgZb8FgHOcGCo2xY
         xaTg==
X-Gm-Message-State: AOAM532r+Q845u6mTwQCqlTqyIzQBVUQ567xJFzgV7fX0F3t733zKxxG
        vBrgFoD5g6nJXf/ggrUiP8x0cZejiOg9l1kBHUp1rTXCiBU=
X-Google-Smtp-Source: ABdhPJzDc6+wFXNAbkuwDQ/3fGNdpD4KHyjWHPQpeiZxb1JlSAXO/J3kyQo9SzCeznlN4WoyVksVtwdUwtGpqjL5LVY=
X-Received: by 2002:a17:906:68c5:: with SMTP id y5mr32705031ejr.371.1615937810523;
 Tue, 16 Mar 2021 16:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.885.v4.git.1614928211635.gitgitgadget@gmail.com> <pull.885.v5.git.1615883137212.gitgitgadget@gmail.com>
In-Reply-To: <pull.885.v5.git.1615883137212.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 16 Mar 2021 19:36:39 -0400
Message-ID: <CAPig+cQSUewNPNRP95HORKLUDCrRsmX==r_bEHacNEuTUMwFQA@mail.gmail.com>
Subject: Re: [PATCH v5] format-patch: allow a non-integral version numbers
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 16, 2021 at 4:25 AM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Usually we can only use `format-patch -v<n>` to generate integral
> version numbers patches, but sometimes a same fixup should be
> labeled as a non-integral version like `v1.1`, so teach `format-patch`
> to allow a non-integral version which may be helpful to send those
> patches.
>
> `<n>` can be any string, such as `-v1.1`.  In the case where it
> is a non-integral value, the "Range-diff" and "Interdiff"
> headers will not include the previous version.
>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
> diff --git a/builtin/log.c b/builtin/log.c
> @@ -1662,13 +1662,19 @@ static void print_bases(struct base_tree_info *bases, FILE *file)
> +static const char *diff_title(struct strbuf *sb,
> +                             const char *reroll_count,
> +                             const char *generic,
> +                             const char *rerolled)
>  {
> +       int reroll_count_int = -1;
> +
> +       if (reroll_count)
> +               strtol_i(reroll_count, 10, &reroll_count_int);
> +       if (reroll_count_int <= 0)
>                 strbuf_addstr(sb, generic);
>         else /* RFC may be v0, so allow -v1 to diff against v0 */
> +               strbuf_addf(sb, rerolled, reroll_count_int - 1);
>         return sb->buf;
>  }

Thanks. The logic of this version is much easier to understand now
that the number parsing has been moved into diff_title().

It may still be a bit confusing for someone reading this code to
understand why you don't check the return value of strtol_i().
Therefore, it might be a good idea to add an /* in-code comment */
explaining why you don't check whether the parse succeeded or failed.
However, if we rewrite the code like this:

    int v;
    if (reroll_count && !strtol_i(reroll_count, 10, &v))
        strbuf_addf(sb, rerolled, v - 1);
    else
        strbuf_addstr(sb, generic);
    return sb->buf;

then the logic becomes obvious, and we don't even need a comment.
(Notice that I also shortened the variable name since the code is just
as clear with a short name as with a long spelled out name such as
"reroll_count_int".)
