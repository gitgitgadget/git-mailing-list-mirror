Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9D3C388F9
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 17:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D0882224E
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 17:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503676AbgJURnR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 13:43:17 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:41204 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503673AbgJURnR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 13:43:17 -0400
Received: by mail-ej1-f67.google.com with SMTP id o26so4449742ejc.8
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 10:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fema+J86zv0/9JrtXx/TTuDYwp3tPblnbLlLkIr9hxk=;
        b=Ri7rudJpo9RVSXauMTMDozoa9FuXDUWJtv1PxGiG7MijpxDa6dcCLsx3z3PNmHnxFA
         NqXfZNAK0cgvH6Q0EbmibujogsLhR2y/+ayR7wyan3Mqh2CFsTfsee4whxvamXXPtWke
         WHLQ9ZrXtIerbCA1K1DLQs8VfYS8IkzDlOpiMx/iT5h37jTvzDwNtrAZ6KTUtOTefgCj
         GJ4KiLzgRmivCWORl8NHXCCdHdPhQc4pkIkUJIbjROsXB/XuLCP0m7kWwMR6QwVOLzZC
         TeobJLDCQ7nC+oKOvt98pfSvUAKVEybN0k98Cs+TNF9Mf/fd3O0uF737IS6wFbDhMSJK
         rspw==
X-Gm-Message-State: AOAM5330UmxkcXxbGOc6faAtAP7WWmQBVbFrjFAMAqui+q4FBROlwqy/
        /ONsGKzEOCWqF/F6HQbBwyk+vPga/5OHgW7m0/trD4oS2wU=
X-Google-Smtp-Source: ABdhPJz4+D9J5g7mt8PmU2fMByUIz7vKhciKKxaP5jKentpFTelT7Zqf1TYHsuMYoyJsg8aP4MWw7bSKLbUCcJ/XIM4=
X-Received: by 2002:a17:906:5f96:: with SMTP id a22mr4573625eju.168.1603302194497;
 Wed, 21 Oct 2020 10:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <pull.751.git.1602781723670.gitgitgadget@gmail.com> <20201021131012.20703-1-sangunb09@gmail.com>
In-Reply-To: <20201021131012.20703-1-sangunb09@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 21 Oct 2020 13:43:03 -0400
Message-ID: <CAPig+cSi1SSZTS86-6_0gDCeDqPCEvT+Lh3gLXe--Y1PDJSDfw@mail.gmail.com>
Subject: Re: [Outreachy] [PATCH v2] diff: do not show submodule with untracked
 files as "-dirty"
To:     Sangeeta Jain <sangunb09@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 21, 2020 at 9:10 AM Sangeeta Jain <sangunb09@gmail.com> wrote:
> [...]
> This patch makes `git diff HEAD` consistent with `git describe --dirty`
> when a submodule contains untracked files by making
> `--ignore-submodules=untracked` the default.
> [...]
> Signed-off-by: Sangeeta Jain <sangunb09@gmail.com>
> ---
> diff --git a/diff.c b/diff.c
> @@ -4585,6 +4585,9 @@ void repo_diff_setup(struct repository *r, struct diff_options *options)
> +       if(!options->flags.ignore_submodule_set)
> +               options->flags.ignore_untracked_in_submodules = 1;

Style nit: insert a space between 'if' and the opening parenthesis

> diff --git a/submodule.c b/submodule.c
> @@ -1678,6 +1679,8 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
>         if (ignore_untracked)
>                 strvec_push(&cp.args, "-uno");
> +       else
> +        strvec_push (&cp.args, "--ignore-submodules=none");

Style nit: use TAB for indentation, not spaces

Style nit: drop space between 'strvec_push' and open parenthesis

> diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
> @@ -503,6 +503,31 @@ test_expect_success 'untracked changes in added submodule (AM S..U)' '
> +test_expect_success 'untracked changes in added submodule (A. S...) (untracked ignored)' '
> +       (       cd super_repo &&
> +               ## create untracked file in the submodule.
> +               (       cd sub1 &&
> +                       echo "xxxx" >file_in_sub
> +               ) &&

I realize that you're following style of some, but not all tests, in
this file, but current the way we format subshells these days is:

    (
        cd foo &&
        ...
    ) &&

Whether you should adopt modern style or use existing style is a
judgment call. (If I was doing this, I might be inclined to follow
modern style rather than introducing even more of the unwanted old
style.)

But for really silly stuff like the 'echo', you don't need a subshell
at all, so it would be cleaner to write it like this without the
subshell:

    echo "xxxx" >sub1/file_in_sub &&

(But again, I see that you're just following local style.)

> +test_expect_success 'staged and untracked changes in added submodule (AM S.M.) (untracked ignored)' '
> +       (       cd super_repo &&
> +               (       cd sub1 &&
> +                       ## stage new changes in tracked file.
> +                       git add file_in_sub &&
> +                       ## create new untracked file.
> +                       echo "yyyy" >>another_file_in_sub
> +               ) &&

These days, `git` also understands -C, so this subshell likewise is
not necessary, and:

    git -C sub1 add file_in_sub &&
    echo "yyyy" >>sub1/another_file_in_sub

would be equivalent. (But perhaps that diverges too much from existing
style in the file? It's a judgment call.)

> diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
> @@ -94,36 +94,60 @@ test_expect_success 'status with added file in submodule (short)' '
> +test_expect_success 'status with untracked file in submodule (untracked ignored)' '
> +       (cd sub && git reset --hard) &&

These one-liner subshells are super common in this particular script.
These days we'd write this as:

    git -C sub reset --hard &&

Again, it's a judgment call whether to go with modern style or follow
existing style of the file.

Another option is to have a preparatory patch which first modernizes
the script, and then your new tests would follow modern style. But,
that may be outside of scope of your submission.

To summarize: The only really actionable review comments are the minor
style nits in the C code. The nits about style issues in the tests are
judgement calls, and could be handled (by someone) at a later date.
