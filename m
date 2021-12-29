Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390FAC433F5
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 06:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238978AbhL2Ghn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 01:37:43 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:45980 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbhL2Ghm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 01:37:42 -0500
Received: by mail-pg1-f180.google.com with SMTP id 2so17716909pgb.12
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 22:37:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=49Efjt+uJbd/UKCzypxMFkRjdRnNsAeuljAgxO3/hF0=;
        b=eHbjfXHjYZ2NyVb1ZawCychKqBo0PsMuCngmkZsHmIcXSIRPEPPAS5QXEQb6krSK/u
         rdsHnFZRr6Rtw0aUVnOKf3cfth4IXa3gpWzTG5I2Eidfh6QneRrFrcf8FlyZB/2Ef6zJ
         5zoVLRN3vxIlVYVWmNHKFBGjkVnP3RXJj64TW1G+0XdsBrzwHtdCExHBRhsP2jhoxbns
         Pzf2ntSf0eM6jXldSokypcf3w3B6/y4K19v/9SH59iQPZV/ip598htMjjbsKZVXiQDrp
         YKS7cG4vnnqdxEY0RVWN0rElJ+pdTguRWbp8pw7LnfshGog40QauERV9e2ReCumvU3UL
         Hcpw==
X-Gm-Message-State: AOAM531dNrtMFxJ2xv0y5oN0Nzyx58loAFFDOSW4/ho6hC9DgxscWXUc
        nABtcPu1Zz6gD73E+Kz/UWSnm5DD8I9OBgf4lQdwxpHPr0bDpw==
X-Google-Smtp-Source: ABdhPJwwH71dZKC+10XanLAPE7sw+18RoNd3pNYFzA+m7h69EZjrm9QVGQbPxzWUe7gIxF4YlkM24qY2JlkoqAduScw=
X-Received: by 2002:a05:6a00:2347:b0:4ba:bd36:1743 with SMTP id
 j7-20020a056a00234700b004babd361743mr25276955pfj.15.1640759862000; Tue, 28
 Dec 2021 22:37:42 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
 <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com> <fcece09546cbdb5f1bcd0d0c5aaa3a54e9d3b852.1640727143.git.gitgitgadget@gmail.com>
In-Reply-To: <fcece09546cbdb5f1bcd0d0c5aaa3a54e9d3b852.1640727143.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 29 Dec 2021 01:37:30 -0500
Message-ID: <CAPig+cSUOknNC9GMyPvAqdBU0r1MVgvSpvgpSpXUmBm67HO7PQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] worktree: copy sparse-checkout patterns and config
 on add
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
> When adding a new worktree, it is reasonable to expect that we want to
> use the current set of sparse-checkout settings for that new worktree.
> This is particularly important for repositories where the worktree would
> become too large to be useful. This is even more important when using
> partial clone as well, since we want to avoid downloading the missing
> blobs for files that should not be written to the new worktree.
>
> The only way to create such a worktree without this intermediate step of
> expanding the full worktree is to copy the sparse-checkout patterns and
> config settings during 'git worktree add'. Each worktree has its own
> sparse-checkout patterns, and the default behavior when the
> sparse-checkout file is missing is to include all paths at HEAD. Thus,
> we need to have patterns from somewhere, they might as well be the
> current worktree's patterns. These are then modified independently in
> the future.
>
> In addition to the sparse-checkout file, copy the worktree config file
> if worktree config is enabled and the file exists. This will copy over
> any important settings to ensure the new worktree behaves the same as
> the current one.

This is not a proper review. I just happened to very quickly scan my
eyes over this patch without even having looked at any of the others,
nor have I read the v3 cover letter closely yet. Nevertheless, while
skimming this patch, an issue jumped out at me...

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -336,6 +336,47 @@ static int add_worktree(const char *path, const char *refname,
> +       /*
> +        * If we are using worktree config, then copy all currenct config
> +        * values from the current worktree into the new one, that way the
> +        * new worktree behaves the same as this one.
> +        */

s/currenct/current/

> +       if (repository_format_worktree_config) {
> +               char *from_file = git_pathdup("config.worktree");
> +               char *to_file = xstrfmt("%s/worktrees/%s/config.worktree",
> +                                       realpath.buf, name);
> +
> +               if (file_exists(from_file)) {
> +                       if (safe_create_leading_directories(to_file) ||
> +                           copy_file(to_file, from_file, 0666))
> +                               error(_("failed to copy worktree config from '%s' to '%s'"),
> +                                     from_file, to_file);
> +               }

I presume that you lifted this idea from [1] in which I offhandedly
mentioned that one possible way to implement Elijah's desire to copy
sparse-checkout configuration when a new worktree is created would be
to simply copy the existing worktree-specific configuration to the new
worktree. Unfortunately, a direct implementation of that idea suffers
the same problem which started this entire thread. Namely:

    % git clone --bare <url>/bare.git
    % cd bare.git/
    % git worktree init-worktree-config
    % git worktree add -d ../foo
    Preparing worktree (detached HEAD a0df8ce)
    HEAD is now at a0df8ce gobbledygook
    % cd ../foo/
    % git sparse-checkout init
    fatal: this operation must be run in a work tree
    % git config --get --show-origin --show-scope core.bare
    worktree file:.../bare.git/worktrees/foo/config.worktree true

The problem is that for a bare repository, after `git worktree
init-worktree-config`, "bare.git/config.worktree" contains the
repo-specific `core.bare=true` setting, so copying
"bare.git/config.worktree" to
"bare.git/worktrees/<id>/config.worktree" verbatim has undesired
consequences.

The obvious way to work around this problem is to (again) special-case
`core.bare` and `core.worktree` to remove them when copying the
worktree-specific configuration. Whether or not that is the best
solution or even desirable is a different question. (I haven't thought
it through enough to have an opinion.)

[1]: https://lore.kernel.org/git/CAPig+cRYKKGA1af4hV0fz_nZWNG=zMgAziuAimDxWTz6L8u3Tg@mail.gmail.com/
