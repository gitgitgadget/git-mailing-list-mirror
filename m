Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3F1C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 01:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239729AbhLVBLw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 20:11:52 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:37611 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhLVBLv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 20:11:51 -0500
Received: by mail-pl1-f172.google.com with SMTP id j13so612779plx.4
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 17:11:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M/RwkP7dWq1Y7buTzYJbzBKtpHqgfqtvcd6fFPDgEis=;
        b=CKNIFWw8YjkEbk+QX0kr068H7Iq3/2em3GR5jm4QYLW8nyPMfql2SauKAsaafV88Lg
         lu8RzQnY3gCiEld0VWmVKou2GkpasjguKiT4nS925C9UliUcULfji4ETTzYrBgmCs2s4
         NayGW1Kphqs1ic42U1CTMoVaRPf3En4LLxL5RtHgNuvfTb5kyUbt2h+v8W80A9+wgXZl
         AsdzhAO9s9WcXRCoCitqWl+CK0BfasCryBWyW51hd7RQ7h5GnsPDDWoA1bIT+ZC6fRxg
         TpfaC944oWAxnJSLdmrB1lURrBasvY5LX/jz7vMEq7vCcThlTeKTpNUH2HFhWe1vXK1E
         vcrg==
X-Gm-Message-State: AOAM530Fig+rittilRPQaeoWBuOHFt0FwfaqXYGhWXcp5q82orOZZRwO
        YyE/hXpN1bd58NfXoHBIsW0TIaqcLkks/92AOvk=
X-Google-Smtp-Source: ABdhPJz3/EZ4kxNq6W9DAUGLmhh2szT57O6NvONyD4hKEc+YPa5A4lqz32nijT6hW8l8YAqr9gAaVlOXUZmVNlUqxlc=
X-Received: by 2002:a17:902:b942:b0:148:a2f7:9d72 with SMTP id
 h2-20020a170902b94200b00148a2f79d72mr853597pls.145.1640135511114; Tue, 21 Dec
 2021 17:11:51 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
 <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com> <22896e9bb04cdf022cc13468d60808df69a6854f.1640114048.git.gitgitgadget@gmail.com>
In-Reply-To: <22896e9bb04cdf022cc13468d60808df69a6854f.1640114048.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 21 Dec 2021 20:11:40 -0500
Message-ID: <CAPig+cRi2SA6+poaemY8XR5ZoMweuztfiENpcRVOCnukg3Qa7w@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] config: add repo_config_set_worktree_gently()
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
> The previous change added upgrade_to_worktree_config() to assist
> creating a worktree-specific config for the first time. However, this
> requires every config writer to care about that upgrade before writing
> to the worktree-specific config. In addition, callers need to know how
> to generate the name of the config.worktree file and pass it to the
> config API.
>
> To assist, create a new repo_config_set_worktree_gently() method in the
> config API that handles the upgrade_to_worktree_config() method in
> addition to assigning the value in the worktree-specific config. This
> will be consumed by an upcoming change.

I still feel very uncomfortable about this function conflating two
very different concerns (upgrading the repository to per-worktree
config, and the simple setting of a config variable). Since I've
already explained my discomfort and suggested alternatives several
times during this discussion (most recently at [1]), I don't have all
that much more to say. However, I do have a few comments...

First, I would have no problem if this function "did the right thing"
where "the right thing" means correctly choosing between .git/config
and .git/config.worktree depending upon whether or not
`extensions.worktreeConfig` is set, and only that. It should not
perform any sort of repository upgrade on its own. Doing it this way
should satisfy your major concern of relieving callers from having to
figure out the correct configuration file name.

Second, if you absolutely must have this function, as implemented, as
part of the public API (despite my protests), please give it a name
which is sufficiently different from the other "config setter"
functions so that people won't be confused into thinking it's just
another "setter" without realizing that calling it has repository-wide
consequences.

Third, I don't have an objection if you want to make this function
private (static) to builtin/sparse-checkout.c, thus omitting it from
the public API. This way you can have its convenience where you want
it, and we can delay finishing this discussion until such time that it
becomes apparent that other modules want its convenience, as well, if
that ever comes about.

[1]: https://lore.kernel.org/git/CAPig+cRombN-8g0t7Hs9qQypJoY41gK3+kvypH4D0G6EB4JgbQ@mail.gmail.com/

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/config.c b/config.c
> index 9c9eef16018..81f3a689c11 100644
> --- a/config.c
> +++ b/config.c
> @@ -21,6 +21,7 @@
>  #include "dir.h"
>  #include "color.h"
>  #include "refs.h"
> +#include "worktree.h"
>
>  struct config_source {
>         struct config_source *prev;
> @@ -2880,6 +2881,15 @@ int git_config_set_gently(const char *key, const char *value)
>         return git_config_set_multivar_gently(key, value, NULL, 0);
>  }
>
> +int repo_config_set_worktree_gently(struct repository *r,
> +                                   const char *key, const char *value)
> +{
> +       return upgrade_to_worktree_config(r) ||
> +              git_config_set_multivar_in_file_gently(
> +                        repo_git_path(r, "config.worktree"),
> +                        key, value, NULL, 0);
> +}
> +
>  void git_config_set(const char *key, const char *value)
>  {
>         repo_config_set(the_repository, key, value);
> diff --git a/config.h b/config.h
> index 5531fc018e3..b05c51b3528 100644
> --- a/config.h
> +++ b/config.h
> @@ -253,6 +253,13 @@ void git_config_set_in_file(const char *, const char *, const char *);
>
>  int git_config_set_gently(const char *, const char *);
>
> +/**
> + * Write a config value into the config.worktree file for the current
> + * worktree. This will initialize extensions.worktreeConfig if necessary,
> + * which might trigger some changes to the root repository's config file.
> + */
> +int repo_config_set_worktree_gently(struct repository *, const char *, const char *);
> +
>  /**
>   * write config values to `.git/config`, takes a key/value pair as parameter.
>   */
> --
