Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD82C433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 05:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD4E160230
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 05:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbhJZFjX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 01:39:23 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:36581 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234962AbhJZFjW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 01:39:22 -0400
Received: by mail-ed1-f50.google.com with SMTP id s1so8658479edd.3
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 22:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o8WKG2ILepgWvbWci80nA3WPDPlnL7FeruDZ7knQCU8=;
        b=lSOTZjZExgsIhsJd27Bq+xSNGf9ikTtnQnsPBEnW9EyKvuRiSWvZ+ryickqNfNKnZ/
         aTPjXL9F9AhhhyCRFLwUk3lGK0yHKT35DGJbR+SoUliMLKH5Jysz7S9BBbNZAALHub+5
         wc3dzPfBgr66DNDFqXjWmoOQl8GTeazIoEXQlSCpkp1AG0JEpSypZOaTnV1Cfu+Yhdqs
         KzybaXEn+HTR3y54EiLhN9MHhblKNPLFUfaMAPxBzxW6L2AjjZg3lxIdZMU/YinKnQ2V
         wl2fd7TuHyXEzNY1gvFmTd9p+TFRP6QCJrTXkJ/UuZd86ukpeCyr9vWvOziQ0Oe1HBbR
         gqeQ==
X-Gm-Message-State: AOAM532tdBfofVNKY2VsbWi2iIu5VHawcQKNKHg8Xs4TYwEmWELz8AQX
        UjUoerVhcBJj3FO51vDZdCX8X/D0FIUaDAqu4tM3Dtr7
X-Google-Smtp-Source: ABdhPJwvvcmMrvNTrfJbxHP084BZjHYZYdFVyUYenOC8uIYkyPfrwbYTxNJs04aj4sPiv3qwT9divUdCtxeUEONA/hY=
X-Received: by 2002:a17:907:764f:: with SMTP id kj15mr23677223ejc.72.1635226618121;
 Mon, 25 Oct 2021 22:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <20211024014256.3569322-1-eschwartz@archlinux.org>
 <20211026013452.1372122-1-eschwartz@archlinux.org> <20211026013452.1372122-4-eschwartz@archlinux.org>
In-Reply-To: <20211026013452.1372122-4-eschwartz@archlinux.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 26 Oct 2021 01:36:47 -0400
Message-ID: <CAPig+cT3u5uLq46Cyg3HZnGqy+UseHA-CN4dMDV1nYVyHkH-+Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] pretty: add abbrev option to %(describe)
To:     Eli Schwartz <eschwartz@archlinux.org>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 25, 2021 at 9:36 PM Eli Schwartz <eschwartz@archlinux.org> wrote:
> The %(describe) placeholder by default, like `git describe`, uses a
> seven-character abbreviated commit object name. This may not be
> sufficient to fully describe all commits in a given repository,
> resulting in a placeholder replacement changing its length because the
> repository grew in size.  This could cause the output of git-archive to
> change.
>
> Add the --abbrev option to `git describe` to the placeholder interface
> in order to provide tools to the user for fine-tuning project defaults
> and ensure reproducible archives.
>
> One alternative would be to just always specify --abbrev=40 but this may
> be a bit too biased...
>
> Signed-off-by: Eli Schwartz <eschwartz@archlinux.org>
> ---
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> @@ -222,6 +222,10 @@ The placeholders are:
> +** 'abbrev=<N>': Instead of using the default number of hexadecimal digits
> +   (which will vary according to the number of objects in the repository with a
> +   default of 7) of the abbreviated object name, use <n> digits, or as many digits
> +   as needed to form a unique object name.

Inconsistent mix of `<N>` and `<n>`.

> diff --git a/pretty.c b/pretty.c
> @@ -1245,6 +1246,19 @@ static size_t parse_describe_args(const char *start, struct strvec *args)
> +                       case OPT_INTEGER:
> +                               if (match_placeholder_arg_value(arg, option[i].name, &arg,
> +                                                               &argval, &arglen) && arglen) {
> +                                       if (!arglen)
> +                                               return 0;

Same question I asked while reviewing the other patch regarding
checking `arglen` in both conditionals: `if (... && arglen)` vs. `if
(!arglen)`
