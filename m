Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F449C433E0
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 06:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19AC864F10
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 06:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbhCSGAm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 02:00:42 -0400
Received: from mail-ej1-f41.google.com ([209.85.218.41]:44821 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbhCSGAg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 02:00:36 -0400
Received: by mail-ej1-f41.google.com with SMTP id b9so7757629ejc.11
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 23:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bdfmX3agsBDTgEdFeb9UOh0uC+HuSEf38YaM0Txw1Gw=;
        b=HAk+s8sH2jBNJKUnTo1jTM33nEFkCGe8LrBu5sxfXviR+MInSrwisnq480AJQ7lh0J
         Q8ijC+7mvLxYrQwxNzZc5YDi/u6IADIYLxiuSSdEH9sAkbGDk8A0HkuAdvOOZFW0zeqc
         b4FAjPKGUugjzrj3wGSa7nSDImpaW+6Ywb7O+DjdshRhPxHxxBDGesfZuuws2EGb45NJ
         v4FPvsE8HF/iLOOvPJV8J+k9weDdLr7ApV4E1emNVvhZWkWEmdUDQUzv0bqo5qtJILNf
         GrgpuOoFYOd3LD+V/z18qFbCGEYwIgQ+ks3ndrTSrkvNWmxOE44JpAny3yGNyD+aswzj
         V1KA==
X-Gm-Message-State: AOAM5332154a5mqwUgT3fAECQT+Y4mBReCRHYFu6XbgMufFX5rn7pV8l
        ykCbvd886xJsiE2hnSoErzIyhGC000sV3LlaP74=
X-Google-Smtp-Source: ABdhPJyLWeaI2OO0HJX5rHkf6tnjSzKBwaBdEQ+y7OqBZ4OUjfIBttmFdynPdBEDCIPoKfze69p1t9ebJ0QWYscjep8=
X-Received: by 2002:a17:907:7684:: with SMTP id jv4mr2494124ejc.231.1616133635150;
 Thu, 18 Mar 2021 23:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <pull.885.v5.git.1615883137212.gitgitgadget@gmail.com> <pull.885.v6.git.1616047200968.gitgitgadget@gmail.com>
In-Reply-To: <pull.885.v6.git.1616047200968.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 19 Mar 2021 02:00:24 -0400
Message-ID: <CAPig+cTv55r+Nr9pb1jQh99YjzkWgjfeYFUEgcMr1LM9g=5xXA@mail.gmail.com>
Subject: Re: [PATCH v6] format-patch: allow a non-integral version numbers
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 18, 2021 at 2:00 AM ZheNing Hu via GitGitGadget
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
> @@ -1662,13 +1662,18 @@ static void print_bases(struct base_tree_info *bases, FILE *file)
> +static const char *diff_title(struct strbuf *sb,
> +                             const char *reroll_count,
> +                             const char *generic,
> +                             const char *rerolled)
>  {
> -       if (reroll_count <= 0)
> +       int v;
> +
> +       /* RFC may be v0, so allow -v1 to diff against v0 */
> +       if (reroll_count && !strtol_i(reroll_count, 10, &v))
> +               strbuf_addf(sb, rerolled, v - 1);
> +       else
>                 strbuf_addstr(sb, generic);
> -       else /* RFC may be v0, so allow -v1 to diff against v0 */
> -               strbuf_addf(sb, rerolled, reroll_count - 1);
>         return sb->buf;
>  }

The comment about RFC and v0 doesn't really make sense anymore. Its
original purpose was to explain why the `if` condition (which goes
away with this patch) was `<=0` rather than `<=1`. It might make sense
to keep the comment if the code is written like this:

    if (reroll_count &&
            !strtol_i(reroll_count, 10, &v) &&
            reroll_count >= 1)
        strbuf_addf(sb, rerolled, v - 1);
    else
        ...

However, I'm not sure it's worth re-rolling just to make this change.

Thanks.
