Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3B4C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 05:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbhLVFsd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 00:48:33 -0500
Received: from mail-pj1-f42.google.com ([209.85.216.42]:35788 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbhLVFsc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 00:48:32 -0500
Received: by mail-pj1-f42.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso4740005pji.0
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 21:48:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s2coigGwhj472zjQrt6pQpBTZKYXyzpgg3rHFXbFi1M=;
        b=4Iu3/waVeswbsZAoBFa7B4DjLpRrEpcLPXqOUZ/mw9CzTfUSDMOeetm4fzp0oFynD0
         qJk9ENKdV7wDfmiL4JvTArSuy1/Oe9yrifspzQx1oZdXILaFzO5/0tf7UQo2cWgflaZO
         tssx22v0/iFDjkfOrQEjBj5CV8xUwTEl4fFMLb8Wa9YyN1FN20/fTdWkRDYNWYblJKfk
         vz0VTnjVkDu/A6tQvXbK30FUvEKgADwuCpKJasi2ir3f5UK02yThiM8hsY15VMJB5oUx
         5cUdvkTWWobkBgj1/thOGshPpqzww5Wx5mP3zT71QaVjzagXduhwzuiC5ubNXfIwHwpA
         cszQ==
X-Gm-Message-State: AOAM530mfguvz6x+UVG12IJf4KchuLd71eHkiYcoeqkgpE17FnpOkQWX
        s39pF1oHn9bzcEiMWTmS9gkn2cUIoVrveieXot8=
X-Google-Smtp-Source: ABdhPJwslio3fmmgU24tvH4qkRDvAj2zroGs+yjU0HK6B085nNfr/X+wmqN/2nYsVZ7ZRtgGA7cOuKsBTWX3neKNCvE=
X-Received: by 2002:a17:902:8346:b0:148:997d:f60b with SMTP id
 z6-20020a170902834600b00148997df60bmr1407860pln.64.1640152112313; Tue, 21 Dec
 2021 21:48:32 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
 <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com> <06457fafa78e18b7bb7f6d87408b0759d98344d8.1640114048.git.gitgitgadget@gmail.com>
In-Reply-To: <06457fafa78e18b7bb7f6d87408b0759d98344d8.1640114048.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 22 Dec 2021 00:48:21 -0500
Message-ID: <CAPig+cRuY40RNi4bC3CBfghLLqz74VUPRbaYJYEhmF78b0GfPQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] sparse-checkout: use repo_config_set_worktree_gently()
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 21, 2021 at 2:14 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The previous change added repo_config_set_worktree_gently() to assist
> writing config values into the worktree.config file, especially when
> that may not have been initialized.
>
> When the base repo is bare, running 'git sparse-checkout init' in a
> worktree will create the config.worktree file for the worktree, but that
> will start causing the worktree to parse the bare repo's core.bare=true
> value and start treating the worktree as bare. This causes more problems
> as other commands are run in that worktree.
>
> The fix is to have this assignment into config.worktree be handled by
> the repo_config_set_worktree_gently() helper.
>
> Reported-by: Sean Allred <allred.sean@gmail.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> @@ -71,6 +71,20 @@ test_expect_success 'git sparse-checkout init' '
> +test_expect_success 'init in a worktree of a bare repo' '

Nit: Although `init` doing an incomplete job of enabling per-worktree
config was indeed the source of the problem, it actually manifested
when invoking other commands, such as `set`. Consequently, it may be
slightly misleading to talk about `init` in the test title. A title
such as "worktree of a bare repo" might be good enough. Anyhow, just a
nit.

> +       test_when_finished rm -rf bare worktree &&
> +       git clone --bare repo bare &&
> +       git -C bare worktree add ../worktree &&
> +       (
> +               cd worktree &&
> +               git sparse-checkout init &&
> +               test_must_fail git config core.bare &&

Nit: I'm rather "meh" on explicitly checking `core.bare` here since
it's not particularly relevant to the test: just testing `init + set`
alone is enough to trigger the bug which begat this patch series.
Future readers of this test might even be confused by the presence of
this `core.bare` check.

> +               git sparse-checkout set /*

The `/*` is expanding to all entries in the root of the filesystem,
which probably isn't what you intended. I suspect you want literal
"/*", in which case you need to quote it:

    git sparse-checkout set "/*"

> +       ) &&
> +       git -C bare config --list --show-origin >actual &&
> +       grep "file:config.worktree      core.bare=true" actual

As mentioned above, I'm fairly meh on this part (and perhaps leaning
toward the negative) since it places too much emphasis on a low-level
detail. I _could_ see this as a test of the new function which
upgrades the repo to per-worktree config, but that's not what _this_
test is about.

> +'
