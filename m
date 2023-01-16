Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDEDC54EBE
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 22:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjAPWSV convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 16 Jan 2023 17:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjAPWSR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 17:18:17 -0500
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6FEC657
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 14:18:16 -0800 (PST)
Received: by mail-pf1-f174.google.com with SMTP id s3so19455737pfd.12
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 14:18:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v24yeBnBW+SVFbnRRBSaPMbPtoN0w+Ye4/XuFs9RAmE=;
        b=sRCebMPcTp8xFc7XwZpJHd3T+pFVVwm+MVslhLRXw1TUoFS3pxWdERSPykkNQgSrlK
         me8HPtvKnI6YLmmIa98gYDoKifrqc6pXAlVFiHtEg0c4pOAnFoSMCvk7FASphe+YeDBs
         piV0nkdnZaYqMo2lHEyMMt9ZE3K490S5fEOIJeoFGOzW0AwQs+vxrhtqaHeRw2vXjjYR
         xjD0gHbVDByPM5p8d/0YNPhEwNckAHNC5mMMiN6l02XyPWDMvoIyNTxgd6CuF6JaLm+6
         Ff1gXGi9Wkd2p5w5QHQrM5X/jc/+d7MeNWqLkRPnS5z3U4SWpf189p2qjXo+VeCR/Yqv
         N9XA==
X-Gm-Message-State: AFqh2kotXqDdkEP+tl42+O1tsisFwXg8nOu3rw3sNGr0dOY8ls7hsSKK
        rZNACca9+ssw5bt4Xyeh2ZeMe2EwjnmfamLV0uycVYxIN+Y=
X-Google-Smtp-Source: AMrXdXvo5XgC5IZGnGgWTsa9B5aXHNhkHepNaGWvNtAaRdqd7cF7m2FFf6QKRQD/JSvHG/MmfgeAzwBcyEgMKKCkjUc=
X-Received: by 2002:a63:9dc5:0:b0:478:fbfd:5278 with SMTP id
 i188-20020a639dc5000000b00478fbfd5278mr37998pgd.268.1673907495401; Mon, 16
 Jan 2023 14:18:15 -0800 (PST)
MIME-Version: 1.0
References: <20230116172824.93218-1-carenas@gmail.com>
In-Reply-To: <20230116172824.93218-1-carenas@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 16 Jan 2023 17:18:04 -0500
Message-ID: <CAPig+cR3=wDFJPr8ViUTVFDx-AvaJUGWNUnqndJ2edQPL5smVw@mail.gmail.com>
Subject: Re: [PATCH] builtin/checkout: check the branch used in -B with worktrees
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, vustthat@gmail.com, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 16, 2023 at 12:30 PM Carlo Marcelo Arenas Belón
<carenas@gmail.com> wrote:
> builtin/checkout: check the branch used in -B with worktrees

Thanks for working on this and coming up with a fix. As mentioned
earlier, I had started looking into it[1], but lacked the time to
disentangle the logic, so I'm glad to see a patch arrive so quickly.

> When multiple worktrees are being used, checkout/switch check
> that the target branch is not already checked out with code that
> evolved from 8d9fdd7087 (worktree.c: check whether branch is rebased
> in another worktree, 2016-04-22), but that logic wasn't valid for
> -B/-C
>
> Avoid reusing the same `branch_info` structure for the checks and
> assumming that it will be rejected later if is a new branch that
> already exists as that doesn't apply to -B/-C.

Even though I'm familiar with the bug report[2] which sparked this
patch, I find the above description somewhat hard to digest; the
high-level problem it is addressing doesn't jump off the page at me.
Perhaps it can be rewritten something like this:

    checkout/switch: disallow checking out same branch in multiple worktrees

    Commands `git switch -C` and `git checkout -B` neglect to check
    whether the branch being forcibly created is already checked out
    in some other worktree, which can result in the undesirable
    situation of the same branch being checked out in multiple
    worktrees. For instance:

        $ git worktree list
        .../foo    beefb00f [main]
        $ git worktree add ../other
        Preparing worktree (new branch 'other')
        HEAD is now at beefb00f first
        $ cd ../other
        $ git switch -C main
        Switched to and reset branch 'main'
        $ git worktree list
        .../foo    beefb00f [main]
        .../other  beefb00f [main]
        $

    Fix this problem by teaching `git switch -C` and `git checkout -B`
    to check whether the branch in question is already checked out
    elsewhere.

after which you might include some details which you wrote about initially.

> Reported-by: Jinwook Jeong <vustthat@gmail.com>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> @@ -1533,13 +1534,12 @@ static int checkout_branch(struct checkout_opts *opts,
> -       if (new_branch_info->path && !opts->force_detach && !opts->new_branch &&
> -           !opts->ignore_other_worktrees) {
> +       if (check_branch_info->path && !opts->force_detach && !opts->ignore_other_worktrees) {
>                 int flag;
>                 char *head_ref = resolve_refdup("HEAD", 0, NULL, &flag);
>                 if (head_ref &&
> -                   (!(flag & REF_ISSYMREF) || strcmp(head_ref, new_branch_info->path)))
> -                       die_if_checked_out(new_branch_info->path, 1);
> +                   (!(flag & REF_ISSYMREF) || strcmp(head_ref, check_branch_info->path)))
> +                       die_if_checked_out(check_branch_info->path, 1);

This variable name change (`new_branch_info` => `check_branch_info`)
helps make the code clearer. Good. (I had found it more than a little
confusing to have similar named variables `new_branch_info` and
`opts->new_branch` even though they are unrelated and have very
different purposes.)

> diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
> @@ -125,6 +125,13 @@ test_expect_success 'die the same branch is already checked out' '
> +test_expect_success 'die the same branch is already checked out (checkout -B)' '
> +       (
> +               cd here &&
> +               test_must_fail git checkout -B newmain
> +       )
> +'

Although `git switch` and `git checkout` currently share
implementation, that might not always be the case going forward. As
such, this test could be made a bit more robust by testing both
commands rather than just `git-checkout`. So, perhaps:

    test_expect_success 'die the same branch is already checked out' '
        (
            cd here &&
            test_must_fail git checkout -B newmain &&
            test_must_fail git switch -C newmain
        )
    '

> +test_expect_success 'not die on re-checking out current branch (checkout -B)' '
> +       (
> +               cd there &&
> +               git checkout -B newmain
> +       )
> +'

Good to see you considered this case too. (I had tested it myself
manually when trying out your patch.)

[1]: https://lore.kernel.org/git/CAPig+cQc1+D9gH7BAC-r03bGKWx3a9jpPyLuP-ehH-X2P+fV6Q@mail.gmail.com/
[2]: https://lore.kernel.org/git/CAA3Q-aaO=vcZd9VLFr8UP-g06be80eUWN_GjygfyGkYmrLx9yQ@mail.gmail.com/
