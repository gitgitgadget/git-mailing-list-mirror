Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8663C433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 05:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbhLUFxb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 00:53:31 -0500
Received: from mail-pg1-f181.google.com ([209.85.215.181]:35737 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbhLUFxb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 00:53:31 -0500
Received: by mail-pg1-f181.google.com with SMTP id v25so6300648pge.2
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 21:53:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bfgv7pGLnKR3Ahz5WEvVGJwEn7/lDWpbkWdVy5vxgao=;
        b=kKLU1Uws8nVzoI9NH+1GBc2C8QWAUkx7CpmzDh785HcDxqOiPwXHkqs0S/whsz4Rxq
         lRBP9hcBJ11mzTkGi0ZYeApFoQfWlYL7nzSNTm+B2TyHQhjgxDzAof9XK1Da52uq8QLR
         VoMls2irs82nxIdW3qvD8J7blpqI4yxWHpeobFXlsWpAGayhaKDQ1KHUepbiaLkKfG5S
         4t/I/QG+cCmHzM20gUfWOAt2raSafbRFyFjp+30KI/D5uFwZ/1V/Z0GsaQLQCd02P4QG
         xHuWoJBuYf3QSmuuaJw2amiM+71NThBDyINj+3rq0X6Jyjw/GVh3qTDIUPATRVR1TW4F
         Jk+g==
X-Gm-Message-State: AOAM5319TbM6uTT4sn1PSc2wjqHQYSPWwqzMeKZwjqAMdF/+nG9v8Ht5
        OtrNL07h03P2RDz2RnMMb+344YUlW73KTXfKUpHTMhdx9YT8Lg==
X-Google-Smtp-Source: ABdhPJxrSe00SktJdFZSXZWfQ1ZfMNILthsTEb/DegddpA1j6kZR2jn7XrL5Qywyq2zGuRLBllHy2rHsR992Wxk525I=
X-Received: by 2002:a63:395:: with SMTP id 143mr1551794pgd.181.1640066010839;
 Mon, 20 Dec 2021 21:53:30 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com> <67993f6cff254d341ba4ad7fe7709b57eb3e74d4.1640015844.git.gitgitgadget@gmail.com>
In-Reply-To: <67993f6cff254d341ba4ad7fe7709b57eb3e74d4.1640015844.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 21 Dec 2021 00:53:19 -0500
Message-ID: <CAPig+cT=evew0iePP-TZ+DTJ=oY6hrjiOiDtYqEr6KLRvkqC9Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] config: add repo_config_set_worktree_gently()
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

On Mon, Dec 20, 2021 at 10:57 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> When adding config values to the worktree config, we might enable the
> extensions.worktreeConfig setting and create the config.worktree file
> for the first time. When the base repository is bare, this creates a
> change of behavior for determining if the worktree is bare or not. A
> worktree off of a bare repository is assumed to be non-bare when
> extensions.worktreeConfig is disabled. When extensions.worktreeConfig is
> enabled but config.worktree is empty, the worktree is considered bare
> because the base repo's core.bare=true setting is used.
>
> To avoid issues like this, create a helper that initializes all the
> right settings in the correct order. A caller will be added in the next
> change.

As discussed already in [1], [2], and [3], the solution implemented by
this patch is undesirable, and I gave an outline in [4] about how I
think the new utility function ought to be implemented instead, so I
won't say anything further about that here. However, I do still have
one or two review comments to make about the general approach taken by
patch. See below...

[1]: https://lore.kernel.org/git/CAPig+cQPUe9REf+wgVNjyak_nk3V361h-48rTFgk6TGC7vJgOA@mail.gmail.com/
[2]: https://lore.kernel.org/git/CAPig+cTVzMtiHzkJq7VRg4Xa3xhrq7KKCdK5OSDY6bvwKu_ynA@mail.gmail.com/
[3]: https://lore.kernel.org/git/6d72a020-ded7-6ef2-825c-ce6421194b26@gmail.com/
[4]: https://lore.kernel.org/git/CAPig+cTuLYFc9fpAe8Uq9fvBYuSGcc9SA1O-q1BRw0DYxDF4Eg@mail.gmail.com/

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/config.c b/config.c
> @@ -2880,6 +2880,33 @@ int git_config_set_gently(const char *key, const char *value)
> +int repo_config_set_worktree_gently(struct repository *r,
> +                                   const char *key, const char *value)
> +{
> +       int res;
> +       const char *config_filename = repo_git_path(r, "config.worktree");
> +
> +       /*
> +        * Ensure that core.bare reflects the current worktree, since the
> +        * logic for is_bare_repository() changes if extensions.worktreeConfig
> +        * is disabled.
> +        */
> +       if ((res = git_config_set_multivar_in_file_gently(config_filename, "core.bare",
> +                                                         r->worktree ? "false" : "true",
> +                                                         NULL, 0))) {
> +               error(_("unable to set core.bare setting in worktree config"));
> +               return res;
> +       }
> +       if (upgrade_repository_format(r, 1) < 0)
> +               return error(_("unable to upgrade repository format to enable worktreeConfig"));
> +       if ((res = git_config_set_gently("extensions.worktreeConfig", "true"))) {
> +               error(_("failed to set extensions.worktreeConfig setting"));
> +               return res;
> +       }
> +
> +       return git_config_set_multivar_in_file_gently(config_filename, key, value, NULL, 0);
> +}
> diff --git a/config.h b/config.h
> @@ -253,6 +253,12 @@ void git_config_set_in_file(const char *, const char *, const char *);
> +/**
> + * Write a config value into the config.worktree file for the current
> + * worktree. This will initialize extensions.worktreeConfig if necessary.
> + */
> +int repo_config_set_worktree_gently(struct repository *, const char *, const char *);

I understand your desire to make this "setter" function as transparent
and simple for clients as possible, however, I think it does too much
by conflating two very distinct operations (one which changes the
nature of the repository itself, and one which simply sets a config
variable), and is far too magical. It doesn't help that the function
name gives no indication of just how magical it is, and it is easy to
imagine people calling this function thinking that it's just a simple
"config setter" like all the other similarly-named functions, without
realizing the impact it may have on the repository overall (i.e.
upgrading to version 1 and changing to per-worktree config).

I would feel much more comfortable for the new utility function to
have a single-purpose: namely, to upgrade the repository to a
per-worktree configuration mode (if not already upgraded) as outlined
in [4]. That's it. It shouldn't do anything other than that. This way,
callers which need per-worktree configuration must call the new
function explicitly to obtain the desired behavior, rather than
getting per-worktree configuration as a magical and implicit
side-effect of calling what looks like a plain old "config setter".
This should make it easier to reason about. Taking this approach also
means that you don't need to introduce a special-purpose "config
setter" just for worktrees; instead, you'd use the normal existing
"config setter" functions. For instance, if the new utility function
is named enable_per_worktree_config(), then `git sparse-checkout init`
might do something like this:

    enable_per_worktree_config(r);
    config_path = repo_git_path(r, "config.worktree")
    git_config_set_in_file_gently(config_path, "core.sparseCheckout", ...);
    git_config_set_in_file_gently(config_path, "core.sparseCheckoutCone", ...);

(This, of course, assumes that repo_git_path() latches the changes
made by enable_per_worktree_config() so that it "does the right
thing", but it seems that existing code in `git sparse-checkout init`
is already expecting it to do so, so perhaps it does work that way.)
