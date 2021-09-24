Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A907FC433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 17:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B28161251
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 17:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344266AbhIXRvy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 13:51:54 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:44693 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343935AbhIXRvx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 13:51:53 -0400
Received: by mail-ed1-f51.google.com with SMTP id v18so3760461edc.11
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 10:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wv1LKlGrn/dlwevosvSOksN77v0WAPUmLVYALn9zuYs=;
        b=CZkn9POUlu1zgzI1zPAynDeISTOe4Kw4vUI8dqosf6uBT3LNBTaH0a9TZz/aFwDraa
         Ej1QHYXRaVNLbM5BoQaTza2gH0DIqBqe4ZiberhyKd7Q5a5eNfw4a2we3ZNY6134kREQ
         XujTXysJa44jVdkOYR2YUSOskjYzwYN//DD3Pt3FVS6aMKTe82qKFxSYrVDhc4bSOHHo
         PX3BizVFztmInCVUstqpVBjrun9wZqlX6hV2JvlTHfE9lbxaAzGE4wfkDWYh/WMiR0gH
         Se09mk6vy48o381fVY6KM+7SuJp0WgqS8C1+oZaw3iit0rfISebuVDOZae7WARddYpxk
         HD3A==
X-Gm-Message-State: AOAM531bh4Al0jmVq619wqyhONGrriHx3YfJskK774DCnR3IPfiw/wur
        0rLj0UqvEtfLppUO9XtBumYvgFweBTK1jodN57E=
X-Google-Smtp-Source: ABdhPJyPXoaW3aDm6SKigrNdMXoH2jDQpnVXq+LiZwgFVb5+ogLeF6xeXKg2M+KASA4KiAgqqb0zuL319TU/Wm/07n0=
X-Received: by 2002:a05:6402:34c6:: with SMTP id w6mr6518380edc.97.1632505818774;
 Fri, 24 Sep 2021 10:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1036.git.1632006923.gitgitgadget@gmail.com>
 <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com> <4b78a526d2acfbcd85d6e4cb94894725ea0350aa.1632465429.git.gitgitgadget@gmail.com>
In-Reply-To: <4b78a526d2acfbcd85d6e4cb94894725ea0350aa.1632465429.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 24 Sep 2021 13:50:07 -0400
Message-ID: <CAPig+cRCtuPtXesh8494W=HOQJishCY+vSX1Fr_mF86qvnEP9g@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] Comment important codepaths regarding nuking
 untracked files/dirs
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 24, 2021 at 2:37 AM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> In the last few commits we focused on code in unpack-trees.c that
> mistakenly removed untracked files or directories.  There may be more of
> those, but in this commit we change our focus: callers of toplevel
> commands that are expected to remove untracked files or directories.
>
> As noted previously, we have toplevel commands that are expected to
> delete untracked files such as 'read-tree --reset', 'reset --hard', and
> 'checkout --force'.  However, that does not mean that other highlevel
> commands that happen to call these other commands thought about or
> conveyed to users the possibility that untracked files could be removed.
> Audit the code for such callsites, and add comments near existing
> callsites to mention whether these are safe or not.
> [...]
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -356,6 +356,11 @@ static int add_worktree(const char *path, const char *refname,
> +               /*
> +                * NOTE: reset --hard is okay here, because 'worktree add'
> +                * refuses to work in an extant non-empty directory, so there
> +                * is no risk of deleting untracked files.
> +                */
>                 strvec_pushl(&cp.args, "reset", "--hard", "--no-recurse-submodules", NULL);

I understand that this comment helps you or some other person auditing
similar cases in the future, however, as a standalone comment for a
reader who isn't aware of the intention, it seems more confusing than
illuminating. It also detracts from the important purpose of `--hard`
here, which is that it is necessary in order to get `git reset` to
actually "checkout" the files into the empty directory, so use of
`--hard` is not an accident or carelessness.

These days, we'd probably just use:

    git restore --no-recurse-submodules .

instead (including the final `.`) to achieve the same, and that
wouldn't need any sort of cuationary comment like the one being added
by this patch. So, perhaps that's a better way to go, or maybe it's
outside the scope of this series...
