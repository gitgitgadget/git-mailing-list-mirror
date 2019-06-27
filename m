Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A6B61F461
	for <e@80x24.org>; Thu, 27 Jun 2019 17:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfF0R1A (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 13:27:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34293 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfF0R07 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 13:26:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id k11so3503116wrl.1
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 10:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XhTs9yHaKQLHwFXIBhgSb9XXD2MhpG39d0xUZwcGbbw=;
        b=Q8qcTM7Ii2yRxokld3Rvs0aRG4akXvPp/0gNO+/9Qu5sOPjlLnW5U7ZvVvqjitPuhF
         6oU/inxxgse2/zyzWaiMwP39hdTdOOKF4W9ajMjtoGYFF8jO3ZEqGRQK0gp25R8IdLxA
         WZ2UItrx2LNLhullcU2974rQbx135Tf5BluohKCn04Neojry6jB1uDNcjXlOEsUaq0XO
         qJAXfPkcWvuPviZeRqfn+sT2l+jBDtm7GzJ3tHZIOgwnO/trrP4u8Z5dCIW6895H7h4w
         ZdgBis2tY1WZCfzfl0fcP1rDqPYAjZqY6/lWVx1XK/ZgS+42BbwlE41HS65L3XRi2V1O
         QEmg==
X-Gm-Message-State: APjAAAW1113zeehjaFXqf98hernN+tS1y+3CVM/jgMuQvhBnJ5Jwptg4
        VJlSGFvP20fNtgidfJrVPJTMVVoVI44SoCI9hzI=
X-Google-Smtp-Source: APXvYqycOnD6sEHY5Ink6a/7vgupSDfkFt8PbHatxz6vcTd986uR2ueQN+gZGf1V/8+1717Hb3nFNTxhSsPXGC79w/Q=
X-Received: by 2002:adf:f101:: with SMTP id r1mr4311042wro.170.1561656417067;
 Thu, 27 Jun 2019 10:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.147.git.gitgitgadget@gmail.com> <0c9d2aead5f729942968314679c5a1ca2e0370d0.1561628237.git.gitgitgadget@gmail.com>
In-Reply-To: <0c9d2aead5f729942968314679c5a1ca2e0370d0.1561628237.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 27 Jun 2019 13:26:45 -0400
Message-ID: <CAPig+cTkzeyGjvftxmaA5Du2Dm4myzchJhrnHi=noJ7nLiLp-A@mail.gmail.com>
Subject: Re: [PATCH 2/2] mingw: use Unicode functions explicitly
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 27, 2019 at 5:37 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Many Win32 API functions actually exist in two variants: one with
> the `A` suffix that takes ANSI parameters (`char *` or `const char *`)
> and one with the `W` suffix that takes Unicode parameters (`wchar_t *`
> or `const wchar_t *`).
>
> The ANSI variant assumes that the strings are encoded according to
> whatever is the current locale. This is not what Git wants to use on
> Windows: we assume that `char *` variables point to strings encoded in
> UTF-8.
>
> There is a pseudo UTF-8 locale on Windows, but it does not work
> as one might expect.

What does "does not work as one might expect" mean? The reader is left
hanging, not knowing why or how the UTF-8 locale on Windows is
undesirable.

> In addition, if we overrode the user's locale, that
> would modify the behavior of programs spawned by Git (such as editors,
> difftools, etc), therefore we cannot use that pseudo locale.
>
> Further, it is actually highly encouraged to use the Unicode versions
> instead of the ANSI versions, so let's do precisely that.
>
> Note: when calling the Win32 API functions _without_ any suffix, it
> depends whether the `UNICODE` constant is defined before the relevant
> headers are #include'd. Without that constant, the ANSI variants are
> used. Let's be explicit and avoid that ambiguity.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
