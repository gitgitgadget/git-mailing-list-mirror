Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1CAC433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 05:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EB9560FF2
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 05:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhJVFZh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 01:25:37 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:44798 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhJVFZg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 01:25:36 -0400
Received: by mail-ed1-f50.google.com with SMTP id w14so9677910edv.11
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 22:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8uHrTZfZC+ghkfiA5dTSWWWku6P5i2ToLFUXaBkaYso=;
        b=Pb4uhEH8dsNB6i84TVEn6wO+eCCupsd3hCkeY1eJLP9KLTrWCLWcw2oY7zkRkcn76h
         Pc2CGqPmIg/n0u14uzSEsFVuOHNuh3/nJHH6PJOUfsVngwGZJn8KlI6qPOwJvMzUtJA1
         l6mjQ3L181UpmtD2ENNsKkicSSX+PD/kYMRVzTvfy6vIk/GD5ktkpcmPhIACXtU+/pLX
         OMh2tgiDWPh7iCsS5YWOGz3qB6G8yxb09uy4wzxv0b2WaBr3LGHMWnLGOBsGzh68MYQd
         YOQx4sc+DszYQk4CVSSefNSgXnJQlyYuFFLvTnILpnZyfN6MMih9InKdAgmcS/GEpGqb
         3g3g==
X-Gm-Message-State: AOAM530H40u10dSdQacZvEXJOGflIFoPn4zno31uhqCLwrHGjCDLT+PD
        gyt4Ai9vvMGa35s3LgaJ9neGppV/Za6gkg7UmvA=
X-Google-Smtp-Source: ABdhPJww9AfyeE7hw3K1+6McQ3gy8s3/LPl56APiaZCoAgNqV0Wpd0uTX6dcaq09pdfZBPKOXPP8Q91610ZaL6HXAUQ=
X-Received: by 2002:a05:6402:5113:: with SMTP id m19mr14401802edd.231.1634880198148;
 Thu, 21 Oct 2021 22:23:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
 <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com> <507020bbef08a02afc53815754cc999c390eb7c7.1634826309.git.gitgitgadget@gmail.com>
In-Reply-To: <507020bbef08a02afc53815754cc999c390eb7c7.1634826309.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 22 Oct 2021 01:23:07 -0400
Message-ID: <CAPig+cT1j6NsZaSM+_JgGksmH4XGsnh7Pe=dbELoBU+FisHGag@mail.gmail.com>
Subject: Re: [PATCH v4 29/29] t7527: test status with untracked-cache and fsmonitor--daemon
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 21, 2021 at 10:26 AM Jeff Hostetler via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Create 2x2 test matrix with the untracked-cache and fsmonitor--daemon
> features and a series of edits and verify that status output is
> identical.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
> diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
> @@ -508,4 +510,98 @@ test_expect_success 'cleanup worktrees' '
> +test_lazy_prereq UNTRACKED_CACHE '
> +       { git update-index --test-untracked-cache; ret=$?; } &&
> +       test $ret -ne 1
> +'

I may be missing something obvious, but can't this be expressed more simply as:

    test_lazy_prereq UNTRACKED_CACHE '
        git update-index --test-untracked-cache
        test $? -ne 1
    '

How significant is it to test specifically against 1? If not, then
even simpler would be:

    test_lazy_prereq UNTRACKED_CACHE '
        git update-index --test-untracked-cache
    '

which is also more robust since it won't be fooled by die() or crashes.

> +test_expect_success 'Matrix: setup for untracked-cache,fsmonitor matrix' '
> +       test_might_fail git config --unset core.useBuiltinFSMonitor &&

More idiomatic:

    test_unconfig core.useBuiltinFSMonitor &&

> +       git update-index --no-fsmonitor &&
> +       test_might_fail git fsmonitor--daemon stop
> +'
> +
> +matrix_clean_up_repo () {
> +       git reset --hard HEAD
> +       git clean -fd
> +}

Since calls to this function are part of the &&-chain in tests, it
probably would be a good idea to maintain the &&-chain within the body
of the function, as well.

> +matrix_try () {
> +       test_expect_success "Matrix[uc:$uc][fsm:$fsm] $fn" '
> +               matrix_clean_up_repo &&
> +               $fn &&
> +               if test $uc = false -a $fsm = false

We avoid -a and -o with `test` and instead chain them with &&:

    if test $uc = false && test $fsm = false

Documentation/CodingGuidelines mentions this. Also see [1] & [2].

[1]: https://lore.kernel.org/git/xmqqa6qkb5fi.fsf@gitster.g/
[2]: https://lore.kernel.org/git/CAPig+cQFFsLeE921WpzTxVnBMnNRiKs4N=hUQ2UQi1VznNEQwg@mail.gmail.com/

> +               then
> +                       git status --porcelain=v1 >.git/expect.$fn
> +               else
> +                       git status --porcelain=v1 >.git/actual.$fn
> +                       test_cmp .git/expect.$fn .git/actual.$fn
> +               fi
> +       '

Broken &&-chain in the `else` arm.

> +       return $?
> +}

No callers care about the return value of this function, so the
`return $?` can be dropped.

> +uc_values="false"
> +test_have_prereq UNTRACKED_CACHE && uc_values="false true"
> +for uc_val in $uc_values
> +do
> +       if test $uc_val = false
> +       then
> +               test_expect_success "Matrix[uc:$uc_val] disable untracked cache" '
> +                       git config core.untrackedcache false &&
> +                       git update-index --no-untracked-cache
> +               '
> +       else
> +               test_expect_success "Matrix[uc:$uc_val] enable untracked cache" '
> +                       git config core.untrackedcache true &&
> +                       git update-index --untracked-cache
> +               '
> +       fi
> +
> +       fsm_values="false true"
> +       for fsm_val in $fsm_values
> +       do
> +               if test $fsm_val = false
> +               then
> +                       test_expect_success "Matrix[uc:$uc_val][fsm:$fsm_val] disable fsmonitor" '
> +                               test_might_fail git config --unset core.useBuiltinFSMonitor &&

Ditto: test_unconfig()

> +                               git update-index --no-fsmonitor &&
> +                               test_might_fail git fsmonitor--daemon stop 2>/dev/null
> +                       '

stderr is redirected within tests anyhow, so we normally don't
suppress it manually like this (especially since it may come in handy
when debugging a failing test).

> +               else
> +                       test_expect_success "Matrix[uc:$uc_val][fsm:$fsm_val] enable fsmonitor" '
> +                               git config core.useBuiltinFSMonitor true &&
> +                               git fsmonitor--daemon start &&
> +                               git update-index --fsmonitor
> +                       '
> +               fi
> +
> +               matrix_try $uc_val $fsm_val edit_files
> +               matrix_try $uc_val $fsm_val delete_files
> +               matrix_try $uc_val $fsm_val create_files
> +               matrix_try $uc_val $fsm_val rename_files
> +               matrix_try $uc_val $fsm_val file_to_directory
> +               matrix_try $uc_val $fsm_val directory_to_file
> +
> +               if test $fsm_val = true
> +               then
> +                       test_expect_success "Matrix[uc:$uc_val][fsm:$fsm_val] disable fsmonitor at end" '
> +                               test_might_fail git config --unset core.useBuiltinFSMonitor &&

Ditto: test_unconfig()

> +                               git update-index --no-fsmonitor &&
> +                               test_might_fail git fsmonitor--daemon stop 2>/dev/null

Ditto: stderr

> +                       '
> +               fi
> +       done
> +done
