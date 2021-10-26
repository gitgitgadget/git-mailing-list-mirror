Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B575C433EF
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 05:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B0FC60EFE
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 05:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbhJZF1o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 01:27:44 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:35555 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234682AbhJZF1m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 01:27:42 -0400
Received: by mail-ed1-f47.google.com with SMTP id g8so8108417edb.2
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 22:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jjhyJw4mV08nnWWwI0QNkGCKdN12lkFPMX+RLtWVNAk=;
        b=sosdeXy1TmIY8ZNZ6/5KbtHxm7VUd+gKCSa0qm/5PbCXS9V7CxWtmXUacVjz83R2Jf
         YH+Mt5LfasHSl3VGvOl10wHlox94H+DXShMfr4+haHQnKKNM0ICwO0JvsN9Ird/Er/Aa
         +hVpamGM4zdiMzGJwU/8tt+xB8QSP00LsyJ99Zfypmlfqzg2pEqPpyVx4j1jR3GUslYL
         r2XT7iti/wTsp30F+eE9SX/atEE/LElIxF9z4My55mlSh7WPZ9SBoF6f6OR9NwRnKVQY
         wHhp36qZnw2OS8VXQL+aLMZ2zT0mHwENIk0c/gpGDm9pKO7EVsCCfUKu6oxukQCo6FfM
         07yQ==
X-Gm-Message-State: AOAM531d+PfAbiohW/eCNRCyzWVb4CnHdeIkcgh5yvgPlvtZ26jIuEm7
        aUsYex8oHjig+lDpLQp7vWDrnGRSagiEGUt6T1d9hLbr
X-Google-Smtp-Source: ABdhPJyC9bPjQ730vHoibyLx1RsUznxmeVktjOOw2zmfLNRFJmLX4q0zGtg4j7ndCOH9tMT46gYrUdxXt/0t2PoRexQ=
X-Received: by 2002:a17:906:128d:: with SMTP id k13mr12468945ejb.517.1635225918205;
 Mon, 25 Oct 2021 22:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211024014256.3569322-1-eschwartz@archlinux.org>
 <20211026013452.1372122-1-eschwartz@archlinux.org> <20211026013452.1372122-3-eschwartz@archlinux.org>
In-Reply-To: <20211026013452.1372122-3-eschwartz@archlinux.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 26 Oct 2021 01:25:07 -0400
Message-ID: <CAPig+cTe9iMCteUYZZP_8cYoOzbg-95ptuVdvvk0SKUGMgrDjg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] pretty: add tag option to %(describe)
To:     Eli Schwartz <eschwartz@archlinux.org>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 25, 2021 at 9:36 PM Eli Schwartz <eschwartz@archlinux.org> wrote:
> The %(describe) placeholder by default, like `git describe`, only
> supports annotated tags. However, some people do use lightweight tags
> for releases, and would like to describe those anyway. The command line
> tool has an option to support this.
>
> Teach the placeholder to support this as well.
>
> Signed-off-by: Eli Schwartz <eschwartz@archlinux.org>
> ---
> diff --git a/pretty.c b/pretty.c
> @@ -1229,10 +1230,21 @@ static size_t parse_describe_args(const char *start, struct strvec *args)
>                 for (i = 0; !found && i < ARRAY_SIZE(option); i++) {
>                         switch(option[i].type) {
> +                       case OPT_BOOL:
> +                               if(match_placeholder_bool_arg(arg, option[i].name, &arg, &optval)) {

Style nit: add space after `if`

> +                                       if (optval) {
> +                                               strvec_pushf(args, "--%s", option[i].name);
> +                                       } else {
> +                                               strvec_pushf(args, "--no-%s", option[i].name);
> +                                       }

We would normally omit the braces for this simple `if`:

    if (optval)
        strvec_pushf(...);
    else
        strvec_pushf(...);

... or maybe even use the ternary operator:

    strvec_pushf(args, "--%s%s", optval ? "" : "no-", option[i].name);

but it's highly subjective whether or not that's more readable.
