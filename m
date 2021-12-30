Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3F3C433F5
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 08:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237807AbhL3ImJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 03:42:09 -0500
Received: from mail-pj1-f52.google.com ([209.85.216.52]:45758 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbhL3ImI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 03:42:08 -0500
Received: by mail-pj1-f52.google.com with SMTP id f18-20020a17090aa79200b001ad9cb23022so22509531pjq.4
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 00:42:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tXXBBew/kY8cTrTmp19LXk2zyqUfrGjHCEqHuyRYEhE=;
        b=z6nUh3W7BqKvo1nnXvOSom+d7N7TRIPorqupOUZv62PcqUHYFf8d9EpWfzgjrwWAD+
         ocG6T3C7dKm+aXPuiWLMCYvg33wGEZyKCUwNnmT6jbfba07iFnwyzxtbxdFH0mafE9Go
         rTuD2lvXBJ9gh53EcZBIVlP1bCScrEvbpdCkNOORKfj3WBogALER47b+Vo0mI8cFIdUS
         8xe7R4OykYQBhgUarkf43ddSmj5655KdgxuSVpZ4p7tGlm5MfBn9UvqTqr4Oj9lwLHek
         qblIntMgpox+FV8eFwmAgMM2m8DAFAC1Dl3lk5kojCTArBHCnn/Qlhvhg7NkPrAlc6nM
         6+BA==
X-Gm-Message-State: AOAM531YHmWis6emeSg5ZTYGn/n8e4HSxyFUCt0p/ZfCAufVfZit329x
        Qmxmb6+cs9uoFLtV8D+YLXtNucJk+srM7YsVlRM=
X-Google-Smtp-Source: ABdhPJy+tWPmR60ADaIVkprR8Lec9D/6kF+y1qTCby8qiNMwsibgAqUg5HuGUQn0+uUr7rBvSZViuuKue8UjAEAI5oc=
X-Received: by 2002:a17:902:b688:b0:149:a1d6:c731 with SMTP id
 c8-20020a170902b68800b00149a1d6c731mr4576450pls.145.1640853728378; Thu, 30
 Dec 2021 00:42:08 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
 <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com> <e2a0a458115a26cfb855f7040f15e5198072b3a5.1640727143.git.gitgitgadget@gmail.com>
In-Reply-To: <e2a0a458115a26cfb855f7040f15e5198072b3a5.1640727143.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 30 Dec 2021 03:41:57 -0500
Message-ID: <CAPig+cTn1049oZQwcLk82LPoOZ9N3mYQifSDObejdcvZwo6ZJg@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] worktree: add 'init-worktree-config' subcommand
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 28, 2021 at 4:32 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> [...]
> To gain access to the core repository's config and config.worktree file,
> we reference a repository struct's 'commondir' member. If the repository
> was a submodule instead of a worktree, then this still applies
> correctly.

In [1], I suggested that you should be using `repository->gitdir`
rather than `repository->commondir` to access the `.git/config` file.
Is the above paragraph saying that my suggestion was incorrect? Or is
it incorrect only in the case of submodules? Or what is it saying?

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -1031,6 +1032,85 @@ static int repair(int ac, const char **av, const char *prefix)
> +static int init_worktree_config(int ac, const char **av, const char *prefix)
> +{
> +       struct repository *r = the_repository;
> +       char *common_config_file = xstrfmt("%s/config", r->commondir);
> +       char *main_worktree_file = xstrfmt("%s/config.worktree", r->commondir);

Specifically, in [1], I said that `common_config_file` should be using
`r->gitdir` (and that the use of `r->commondir` was correct for
`main_worktree_file`).

[1]: https://lore.kernel.org/git/CAPig+cQrJ9yWjkc8VMu=uyx_qtrXdL3cNnxLVafoxOo6e-r9kw@mail.gmail.com/

> +       git_configset_init(&cs);
> +       git_configset_add_file(&cs, common_config_file);
> +
> +       /*
> +        * If the format and extension are already enabled, then we can
> +        * skip the upgrade process.
> +        */
> +       if (repository_format_worktree_config)
> +               return 0;

Rather than `return 0`, should this be `goto cleanup`...

> +       if (upgrade_repository_format(r, 1) < 0) {
> +               res = error(_("unable to upgrade repository format to enable worktreeConfig"));
> +               goto cleanup;
> +       }
> +       if ((res = git_config_set_gently("extensions.worktreeConfig", "true"))) {
> +               error(_("failed to set extensions.worktreeConfig setting"));
> +               goto cleanup;
> +       }

... as is done for these two cases?

> +cleanup:
> +       git_configset_clear(&cs);
> +       free(common_config_file);
> +       free(main_worktree_file);
> +       return res;
> +}
