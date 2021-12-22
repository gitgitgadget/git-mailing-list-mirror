Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E1CC433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 06:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239137AbhLVGFM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 01:05:12 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:36779 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239092AbhLVGFL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 01:05:11 -0500
Received: by mail-pf1-f173.google.com with SMTP id v13so1416799pfi.3
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 22:05:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vj+R1Fi/l0QZSL9aqndVfC3j3fzB6iVpjkmrbQsqZIs=;
        b=4wRQYRDv/+MjhiqEjTPEKMZNZOOIRmhf0iBHh2MErFOWFfrjNUVSXL0Wslsba39y93
         l4sb660eTnnBD/+P0aId6WvNRouT8WPGUpWLV+t93h1v5MS+xRROmDve8GaCvEbBwhyq
         WSZN1v2L0hUvSCIGEdcqetyXigtODpxaed6KCSXd+zHWnF6aln7nwSnOmzuAKOA7Zdq0
         7JHzmll8gzaKwXsZuXDIhcEd3StqQJaNfDW2X2FW5A2RCLhKc1jNJ0wrfTEAwzqYPIBm
         g1T32AfvYxJgBfnABLxVotpIkfBaHQjOq+mMS9ywnrC6JgJcLDbCpvyjk8yoLeLW6Nmz
         MDMg==
X-Gm-Message-State: AOAM53078VuiB+ZHKziHGdsymCONkNhKSiefcUYbW93w18YBOREfu7ze
        xDvn9cPsnZwWgTo0RD9NyHzfwiWGxPhfRoChm7y7MZgoW5T5Ug==
X-Google-Smtp-Source: ABdhPJx4H0yh1W2P1aGsYn5bPPrksbmz88cmKmOK1fCte9v3Z1M+O+sNsW6M5OmsN4GYeQ4BVLTTaFC1e3rdgnWIDmM=
X-Received: by 2002:a05:6a00:230b:b0:4ae:d8b2:dc0c with SMTP id
 h11-20020a056a00230b00b004aed8b2dc0cmr1548110pfh.67.1640153111051; Tue, 21
 Dec 2021 22:05:11 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com> <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 22 Dec 2021 01:05:00 -0500
Message-ID: <CAPig+cTxS54QyAjHB3JhqNndKiBdxyt_ROtOnxKt0VGswJj=8A@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Sparse checkout: fix bug with worktree of bare repo
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 21, 2021 at 2:14 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The root cause is that 'git sparse-checkout init' writes to the worktree
> config without checking that core.bare might need to be set. This only
> matters when the base repository is bare, since creating the config.worktree
> file and enabling extensions.worktreeConfig will cause Git to treat the base
> repo's core.bare=false as important for this worktree.

I'm having trouble understanding what this is trying to say. Did you
mean "true" rather than "false" in the final sentence? Anyhow, I think
this description is somewhat stale. A more succinct way to describe
the issue is that `git sparse-checkout init` wasn't correctly
upgrading the repo to per-worktree configuration, with the result that
the `core.bare=true` setting of a bare repo bled into
worktree-specific configuration, which caused a bit of havoc. This
patch series fixes `init` to upgrade the repo properly.

> The critical bits are in Patches 3, 4, and 5 which introduce a helper for
> upgrading to worktree config, a helper to write to worktree config, and then
> consume that config helper in builtin/sparse-checkout.c and sparse-index.c.
>
> Update in v2
> ============
>
>  * Eric correctly pointed out that I was writing core.bare incorrectly. It
>    should move out of the core config and into the core repository's
>    worktree config.
>  * Patch 3 is new, separating the "upgrade" logic out of config.c, but it is
>    still called by the config helper to make it painless to write worktree
>    config.

It's good to see the "upgrade to per-worktree config" split out to a
standalone single-purpose utility function. I left several review
comments in that patch, the most important of which is that the
implementation is incomplete (because it doesn't relocate
`core.worktree`), thus it can leave the repo in an inconsistent and
broken state. Several of the other review comments are actionable, as
well.

I'm still concerned about and uncomfortable with the implementation of
the new repo_config_set_worktree_gently(), but I've left ample
comments about that elsewhere in this discussion, so I needn't go into
it here.

Thanks for working on this.
