Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAB9C2D0A8
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 08:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D2F8206C3
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 08:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgI3IGl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 04:06:41 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:45157 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbgI3IGl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 04:06:41 -0400
Received: by mail-ej1-f67.google.com with SMTP id i26so1424666ejb.12
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 01:06:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gd40GxpuWR78htrfr+O3Fux49jBySzMo2SBnypl6Z2o=;
        b=hhyvpHwtxrYE1wqfv+l3zdVcDlX/UFGJAVTklmd5T6BmP5VQ/2jf9vzvtL+vihZCUm
         z2IZbgiGQcaPaFjCLCjrCUzRAuE+cM470kRloeMDg4u9XBzBRCg/HHK5gZIuEZ4RPLiU
         EgWbgh3fu9fXjD1CzYV47EVOISkC5JGBI1OQG/Jy7EjpbRCdhmCI8o1hGsEGEEHA45LE
         WcqYwdkTaGJ86suEN7DZe+OoE1XYVO84rGsi7KbexkJhYWoxLs0Mwy5HWcB+JbxlbNer
         bUMWPDbPB4U17DGeO1d4NtWHVPuR6NZbSV0z/Kc31Q7KUhZDryGnTMrWE4Y11xB8E1C0
         IOmQ==
X-Gm-Message-State: AOAM531LsShJlaxQKQFmOlMXcp0mQIb8hrSVYtd9T+Lt8vTfKyHCVfPO
        zTwB7iasuFrihoO6gkl7UrC4nEQeJvOXxegTEgIcFLgdx8E=
X-Google-Smtp-Source: ABdhPJw8m0vT2k8I3DOiDqcJ5NhWulxaoOTiI+yeR1PdwwcIODTCctjFpEOS5zUicy/MT5q3CDPsQlGHUisMM/GMcxs=
X-Received: by 2002:a17:906:2cd2:: with SMTP id r18mr1644714ejr.371.1601453199259;
 Wed, 30 Sep 2020 01:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200928154953.30396-1-rafaeloliveira.cs@gmail.com> <20200928154953.30396-3-rafaeloliveira.cs@gmail.com>
In-Reply-To: <20200928154953.30396-3-rafaeloliveira.cs@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 30 Sep 2020 04:06:28 -0400
Message-ID: <CAPig+cSa4JZ0SaM9p+Jfvv_5h8mexRcKdiz=hSi37BG_sLsk7Q@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] t2402: add test to locked linked worktree marker
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 28, 2020 at 11:50 AM Rafael Silva
<rafaeloliveira.cs@gmail.com> wrote:
> Test the output of the `worktree list` command to show when
> a linked worktree is locked and test to not mistakenly
> mark main or unlocked worktrees.

In addition to Junio's review comments...

> Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
> ---
> diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
> @@ -61,6 +61,19 @@ test_expect_success '"list" all worktrees --porcelain' '
> +test_expect_success 'show locked worktree with (locked)' '

Existing test titles in this script seem to follow a particular
pattern (for the most part). Perhaps this could say instead:

    test_expect_success '"list" all worktrees with "locked"' '

> +       echo "$(git rev-parse --show-toplevel) $(git rev-parse --short HEAD) [$(git symbolic-ref --short HEAD)]" >expect &&

I see that this is following existing practice in this script of
piling up $(git ...) invocations which can lose the individual exit
codes, so I can't complain about it, but I'll note that these days
we'd more likely than not try to preserve the exit codes, perhaps like
this:

    path=$(git rev-parse --show-toplevel) &&
    rev=$(git rev-parse --short HEAD) &&
    sym=$(git symbolic-ref --short HEAD) &&
    echo "$path $rev [$sym]" >expect &&

However, that gets verbose since you're doing it for multiple lines (below).

> +       test_when_finished "rm -rf locked unlocked out actual expect && git worktree prune" &&
> +       git worktree add --detach locked master &&
> +       git worktree add --detach unlocked master &&
> +       git worktree lock locked &&
> +       echo "$(git -C locked rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD) (locked)" >>expect &&
> +       echo "$(git -C unlocked rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >>expect &&
> +       git worktree list >out &&
> +       sed "s/  */ /g" <out >actual &&
> +       test_cmp expect actual
> +'

I realize that Junio proposed an alternate simpler approach which
checks specifically the attribute in which you are interested, but
here's yet another (typed-in-email) approach you could use:

    test_when_finished "..." &&
    git worktree add --detach locked master &&
    git worktree add --detach unlocked master &&
    git worktree list >out &&
    sed '/\/locked/s/$/ (locked)/' out >expect &&
    git worktree lock locked &&
    git worktree list >actual &&
    test_cmp expect actual
