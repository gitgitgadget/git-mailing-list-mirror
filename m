Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607CAC4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 05:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C05E61106
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 05:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhHSFwr convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 19 Aug 2021 01:52:47 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52]:43656 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbhHSFwq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 01:52:46 -0400
Received: by mail-ej1-f52.google.com with SMTP id b15so10245576ejg.10
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 22:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vwUS+OrFDi7DFp01jk0nqCVWcihf2rHwNXsleldDUwI=;
        b=kwBnWQI5UUBhYR4/qIV7ZbmWH2k653JVe5Y+m1EQdKTAxoNP81YdlK38+kLJYf29Il
         dzTfrAlagddYFmML9Xmg4s/8IffdBhQLV2BLXYxs3FT0QOPlOtzSwWqNARRQfvdtDgQ+
         okw6acQCqS0bjlz1Z9JJ+B1RA+38OEoptqJse68QQDUXzn7BHsyqvDxY/X9F+63rebp5
         elO+9WOFRVCAEPrCkGadE9RCY3vOqtGV9RikOpRc7RvlTvwxsRQEnTgLHUQkVobfwVA3
         V387UbJWcEv55YAoG5foWzJDi43FpqV4wBUiivIYixoGGKWi/yxqac1lf+HNX/6x/DXd
         WAtw==
X-Gm-Message-State: AOAM530z7LP2tSaG87HtwjbvwRqlP2ResNMp5iX+kkSrQpOz/WY6PS90
        kkgKB9Tkifa/1c2yESpqHvDCQj//00kRkD610FE=
X-Google-Smtp-Source: ABdhPJzRXHW8F8TaCSWACJDJ567kzu9aTSoCWrbvL31EuoS9044KRH25z4bM5TLEhsBoqqc4pX/i2oiW/dhLXVGKuEk=
X-Received: by 2002:a17:906:2792:: with SMTP id j18mr13834282ejc.168.1629352329638;
 Wed, 18 Aug 2021 22:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <YR3WS1AnqCuiJWyX@coredump.intra.peff.net> <20210819050103.25995-1-carenas@gmail.com>
In-Reply-To: <20210819050103.25995-1-carenas@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 19 Aug 2021 01:51:58 -0400
Message-ID: <CAPig+cRjMYzw+Hu1wy20w8oJ-4jRmOwMB9Rt=QmNu+=8Mj7skQ@mail.gmail.com>
Subject: Re: [PATCH] t3200: refactor symlink test
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 19, 2021 at 1:02 AM Carlo Marcelo Arenas Belón
<carenas@gmail.com> wrote:
> d1931bcf0d (refs: make errno output explicit for refs_resolve_ref_unsafe,
> 2021-07-20) add a test for a crash when refs is a symlink, but it fails
> on windows.
>
> add the missing SYMLINKS dependency and while at it, refactor it slightly
> to comply better with the CodingGuidelines.
>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> @@ -109,17 +109,22 @@ test_expect_success 'git branch -m n/n n should work' '
> -test_expect_success 'git branch -m with symlinked .git/refs' '
> +test_expect_success SYMLINKS 'git branch -m with symlinked .git/refs' '
>         git init subdir &&
>         test_when_finished "rm -rf subdir" &&
> -       (cd subdir &&
> -               for d in refs objects packed-refs ; do
> -               rm -rf .git/$d &&
> -               ln -s ../../.git/$d .git/$d ; done ) &&
> +       (
> +               cd subdir &&
> +               for d in refs objects packed-refs
> +               do
> +                       rm -rf .git/$d &&
> +                       ln -s ../../.git/$d .git/$d

Ideally, the above line should be:

    ln -s ../../.git/$d .git/$d || exit 1

to catch and signal a failure within the for-loop body (which happens
to be in a subshell; if not in a subshell, you'd use `|| return 1`).

> +               done
> +       ) &&
>         git --git-dir subdir/.git/ branch rename-src &&
> -       expect=$(git rev-parse rename-src) &&
> +       git rev-parse rename-src >expect &&
>         git --git-dir subdir/.git/ branch -m rename-src rename-dest &&
> -       test $(git rev-parse rename-dest) = "$expect" &&
> +       git rev-parse rename-dest >actual &&
> +       test_cmp expect actual &&
>         git branch -D rename-dest
>  '
