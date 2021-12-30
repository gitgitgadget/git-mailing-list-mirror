Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69850C433EF
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 09:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238047AbhL3JBk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 04:01:40 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:43827 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhL3JBj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 04:01:39 -0500
Received: by mail-pg1-f170.google.com with SMTP id 8so20948468pgc.10
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 01:01:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QnOHac8SQUUWkTeclUvDHgoOZ7JnspEmRyGltilMH0M=;
        b=Y5Aq+ux8XCk19YLVxdORWPzCLEVDPLeDLeCnBI8ZXbrt1IHymmDZv+H/mDpwaW8QPo
         IcnN7AGDY++M1RgcFAvBg+7qPn4vqKCfoflIa9G/9sIsLr3sdg8SiI2sSQ6fg0q698w1
         JbdoDd/irrCXQ3Cq30Hg8dbeGqeMgAkexJl7L8bf6j9bp31l1MJSUeOdzkS9T4tVz2RF
         rDev+1MPOgADT+e6bxiDkcxtUNx72ePZt7xFcGosqnRmV1jZ+BlbzrSm02ro0Hucr8N5
         r+PWQXcWgwPZv/3IIkc84jAKnXd0TcWUuMOE2Xcx4sYmn4ITje0CJXh02LtULP7oLtTj
         +l7g==
X-Gm-Message-State: AOAM533Fn7GvNjsrRDGyqlYSBMizIqfrmePy4g0JwbruzWt3GdYxt+d3
        u7fRTbKBbZfL6GB5ueTOoZfv2N49828N60IswvU=
X-Google-Smtp-Source: ABdhPJwo6Wq//iTHXEj9d7A2yQmdZ55Fzk+1VwHJrXPxTzfWQ3XUEjtk0zottq/vxXqkv90gw/MUQSVfJzu0ZZkK0Tk=
X-Received: by 2002:a63:395:: with SMTP id 143mr26894138pgd.181.1640854899273;
 Thu, 30 Dec 2021 01:01:39 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
 <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com> <b200819c1bb564695b68d8ed2caebfca0302f93f.1640727143.git.gitgitgadget@gmail.com>
In-Reply-To: <b200819c1bb564695b68d8ed2caebfca0302f93f.1640727143.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 30 Dec 2021 04:01:28 -0500
Message-ID: <CAPig+cTGdmzfY5r3gdewdEwcRMDdnS9FtZxZNLSCNQYHeQq=wA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] sparse-checkout: use repo_config_set_worktree_gently()
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
> The previous change added repo_config_set_worktree_gently() to assist
> writing config values into the worktree.config file, if enabled.

s/worktree.config/config.worktree/

(I made the same mistake several times earlier in this discussion.)

> Let the sparse-checkout builtin use this helper instead of attempting to
> initialize the worktree config on its own. This changes behavior of 'git
> sparse-checkout set' in a few important ways:

"worktree config" is a bit ambiguous here. It might be clearer to say
"enable per-worktree configuration" or "enable worktree-specific
configuration".

>  1. Git will no longer upgrade the repository format and add the
>     worktree config extension. The user should run 'git worktree
>     init-worktree-config' to enable this feature.
>
>  2. If worktree config is disabled, then this command will set the
>     core.sparseCheckout (and possibly core.sparseCheckoutCone and
>     index.sparse) values in the common config file.
>
>  3. If the main worktree is bare, then this command will not put the
>     worktree in a broken state.

There are a few other cases of ambiguity in this enumerated list, as
well, and the need for `s/main worktree is bare/repository is bare/`,
however, if you end up restructuring this series the to follow the
recipe Elijah set forth at the bottom of [1], then most of this
patch's commit message will be rewritten anyhow, so my mention of
these minor issues will be moot.

[1]: https://lore.kernel.org/git/CABPp-BHuO3B366uJuODMQo-y449p8cAMVn0g2MTcO5di3Xa7Zg@mail.gmail.com/

> The main reason to use worktree-specific config for the sparse-checkout
> builtin was to avoid enabling sparse-checkout patterns in one and
> causing a loss of files in another. If a worktree does not have a
> sparse-checkout patterns file, then the sparse-checkout logic will not
> kick in on that worktree.
>
> This new logic introduces a new user pattern that could lead to some
> confusion. Suppose a user has not upgraded to worktree config and
> follows these steps in order:
>
>  1. Enable sparse-checkout in a worktree.
>
>  2. Disable sparse-checkout in that worktree without deleting that
>     worktree's sparse-checkout file.
>
>  3. Enable sparse-checkout in another worktree.
>
> After these steps, the first worktree will have sparse-checkout enabled
> with whatever patterns exist. The worktree does not immediately have
> those patterns applied, but a variety of Git commands would apply the
> sparse-checkout patterns and update the worktree state to reflect those
> patterns. This situation is likely very rare and the workaround is to
> upgrade to worktree specific config on purpose. Users already in this
> state used the sparse-checkout builtin with a version that upgraded to
> worktree config, anyway.
>
> Reported-by: Sean Allred <allred.sean@gmail.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
