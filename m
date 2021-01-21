Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57445C433DB
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 23:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05C99224B2
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 23:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbhAUXiC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 18:38:02 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:37503 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbhAUXiA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 18:38:00 -0500
Received: by mail-ed1-f52.google.com with SMTP id g1so4560374edu.4
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 15:37:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LuP/p+Bh6j+WJq95GK55QNqbEB+Exfr4gMAnFpFuK7M=;
        b=nQReCm/zzzxe/cALfrf6oHy9EBmgWCn3HoTNApZ9jL50z3zrO5/I4bS2WrqpPMJlX+
         ZMCp+uh4sXFCakIhQ5cdqeTMTzIJU5auM2x0qb3JBKwGQTSNp1Vhw6GWxhTxv3nivO62
         wQuXUjOJ+eNqQyvHI4c60HeYK4GyItkVGM/TKtOjD+wNrCNE7dQCv2s7h0tIZXvj44Cd
         NatSaTT8XcFV0QU1m2eDEkrfwuRZ15jEowmHMuI9OaGt9XOLQfOtdYBGN9r+83AECGWV
         yXCLpODDe3vEApiB/UVHv5o3J4MYOf3Tw4pkOPr7vV/jH8ZrVjDIbFBhXwwlWvKt2/WT
         YzOQ==
X-Gm-Message-State: AOAM530QRZ9BE11/ZUdIHOxQJtAiirrHfZTQNrjTXhpU6mREPa8RlziV
        JCJAg2lS8cT/DejoCzTZPRGpXsjDi9EJdyDDqbk=
X-Google-Smtp-Source: ABdhPJyOcuqM7XtF34FcRpnRKwoSg+Hhpzuw4R96p1Yila2RkaLH+rBOyRWSvEjmAtUg6hrBzlzAQkj62N6F70/l01Y=
X-Received: by 2002:a50:f0dc:: with SMTP id a28mr1169314edm.291.1611272238957;
 Thu, 21 Jan 2021 15:37:18 -0800 (PST)
MIME-Version: 1.0
References: <pull.841.git.1611267638.gitgitgadget@gmail.com> <88c15617b4ba8ae3211b1a01861eb4165f3eda38.1611267638.git.gitgitgadget@gmail.com>
In-Reply-To: <88c15617b4ba8ae3211b1a01861eb4165f3eda38.1611267638.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 21 Jan 2021 18:37:07 -0500
Message-ID: <CAPig+cTMqy=57hGksH6GaCB7i=eJHTCWVzwED=PPZF1hNp_1nQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] range-diff: handle commit ranges other than A..B
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <ericsunshine@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 21, 2021 at 5:22 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> In the `SPECIFYING RANGES` section of gitrevisions[7], two ways are
> described to specify commit ranges that `range-diff` does not yet
> accept: "<commit>^!" and "<commit>^-<n>".
>
> Let's accept them.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/builtin/range-diff.c b/builtin/range-diff.c
> @@ -13,7 +13,26 @@ NULL
>  static int is_range(const char *range)
>  {
> +       if (strstr(range, ".."))
> +               return 1;
> +
> +       i = strlen(range);
> +       c = i ? range[--i] : 0;
> +       if (c == '!')
> +               i--; /* might be ...^! or ...^@ */
> +       else if (isdigit(c)) {
> +               /* handle ...^-<n> */
> +               while (i > 2 && isdigit(range[--i]))
> +                       ; /* keep trimming trailing digits */
> +               if (i < 2 || range[i--] != '-')
> +                       return 0;
> +       } else
> +               return 0;
> +
> +       return i > 0 && range[i] == '^';
>  }

Is this something that the --range-diff option of git-format-patch
will want to do, as well? At present,
builtin/log.c:infer_range_diff_ranges() detects a range only by
checking for "..", much like this function did before this patch. If
so, perhaps this function can be part of the public range-diff API
(or, indeed, part of some other more general API if it's not really
specific to range-diff).
