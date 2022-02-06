Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4906BC433EF
	for <git@archiver.kernel.org>; Sun,  6 Feb 2022 10:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbiBFKVR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Feb 2022 05:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiBFKVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Feb 2022 05:21:16 -0500
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E042BC0612A4
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 02:21:14 -0800 (PST)
Received: by mail-pj1-f48.google.com with SMTP id on2so1647353pjb.4
        for <git@vger.kernel.org>; Sun, 06 Feb 2022 02:21:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FWEbj7ZSQEpiVxlJ8cjfsP9diOqfkps3/d1NQRv+hik=;
        b=5pBxSaGtHG+zh/zYo2axB4Zdm17EUz7mKy+65uucvb5MK3MbYwnqi9DBJJg5ck9+fF
         JT/3SK59iIBQdsDGya+HZAktkhtveJFYVGgxwa5O+2CkjvsP5GnjpbgRF8s4JvWhzuym
         I7t0TWknTpABU7+jIfyK869NL2LSl2wNUdG2i2pKMBLLpKsi6pR8x491fLBbRP6PqohU
         u2m/XFEK1Uzzdj0ObOkRtyKEziAg0TvpRh78994Va98cL+WBTOjE1VPDGyo8Fmyep8J7
         m07ByIkuwPTIOQ6c5wwyZgUNwCjNXqH48K7afS0xEtqOkAUjwSJGBCsqyFuK6P3Gp4uK
         v9Og==
X-Gm-Message-State: AOAM5325wG1LvDVHKBDA0qnkJohXzf+p1UGTnA3czvpLmVJBscfwbVdc
        LkVcmVfxZOSHkXkuA7FYXSSlMaug/j9g4vlHo2IHU1eG8ag=
X-Google-Smtp-Source: ABdhPJzVt1O3LgAgJMMK8hhYi+Fy1k4LB8tY72kglD9KLoaY0YWgIFyeObKVJRn/U4tNs0lVkJblTaPawcugCH0UBok=
X-Received: by 2002:a17:90b:4d12:: with SMTP id mw18mr8217997pjb.104.1644142874289;
 Sun, 06 Feb 2022 02:21:14 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.v4.git.1643136134.gitgitgadget@gmail.com>
 <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com> <08b89d17ccfab93546c9e84accaea84ce93ab932.1643641259.git.gitgitgadget@gmail.com>
In-Reply-To: <08b89d17ccfab93546c9e84accaea84ce93ab932.1643641259.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 6 Feb 2022 05:21:03 -0500
Message-ID: <CAPig+cTqmjrciKZa7DPA8B5Em6bNPprrJGaO6xCkRvmxvzQgHw@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] sparse-checkout: set worktree-config correctly
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 31, 2022 at 10:01 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The previous change added repo_config_set_worktree_gently() to assist
> writing config values into the config.worktree file, if enabled. An
> earlier change added init_worktree_config() as a helper to initialize
> extensions.worktreeConfig if not already enabled.
>
> Let the sparse-checkout builtin use these helpers instead of attempting to
> initialize the worktree config on its own. This changes behavior of 'git
> sparse-checkout set' in a few important ways:
>
>  1. Git will no longer upgrade the repository format, since this is not
>     a requirement for understanding extensions.worktreeConfig.
>
>  2. If the main worktree is bare, then this command will not put the
>     worktree in a broken state.

Although the three of four of us involved in this discussion
understand what "broken state" means, such a description may be too
vague for future readers. To help them out, perhaps we can do a better
job of conveying the nature of the actual breakage by rewriting all of
the above like this:

    `git sparse-checkout set/init` enables worktree-specific
    configuration[*] by setting extensions.worktreeConfig=true, but
    neglects to perform the additional necessary bookkeeping of
    relocating `core.bare=true` and `core.worktree` from
    $GIT_COMMON_DIR/config to $GIT_COMMON_DIR/config.worktree, as
    documented in git-worktree.txt. As a result of this oversight,
    these settings, which are nonsensical for secondary worktrees, can
    cause Git commands to incorrectly consider a worktree bare (in the
    case of `core.bare`) or operate on the wrong worktree (in the case
    of `core.worktree`). Fix this problem by taking advantage of the
    recently-added init_worktree_config() which enables
    `extensions.worktreeConfig` and takes care of necessary
    bookkeeping.

    While at it, for backward-compatibility reasons, also stop
    upgrading the repository format to "1" since doing so is
    (unintentionally) not required to take advantage of
    `extensions.worktreeConfig`, as explained by 11664196ac ("Revert
    "check_repository_format_gently(): refuse extensions for old
    repositories"", 2020-07-15).

> The main reason to use worktree-specific config for the sparse-checkout
> builtin was to avoid enabling sparse-checkout patterns in one and
> causing a loss of files in another. If a worktree does not have a
> sparse-checkout patterns file, then the sparse-checkout logic will not
> kick in on that worktree.

Perhaps this paragraph can become the "[*]" footnote I referenced in
the above rewrite.

> Reported-by: Sean Allred <allred.sean@gmail.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
