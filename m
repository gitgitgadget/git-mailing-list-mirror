Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28F2C433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 16:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235868AbhLTQVM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 11:21:12 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:43826 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbhLTQVL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 11:21:11 -0500
Received: by mail-pf1-f182.google.com with SMTP id 196so5625131pfw.10
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 08:21:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lyPUY6CDA1ES95PN7GyvsFJ/xBDlQC7lUiZ2WozL78E=;
        b=zWWMFyN5Mrb7LheRkjim+xBpc+KGoD8WBxGpsaL5pO+3zPIHHtuumKnjwSckAPJhz6
         f3O7mA7ct6l3VgZxy/QqdBRosz9MD76gOzURA5Td+DqUZJ48hD3aDenehKRlTHMxFkZQ
         yXwHpu1TZbqxqDe4CT/mvvAkYrXwDrqaOJnUw+aDpN9EClb1Qr4ymHY7gypUe/cHG5Lt
         ECTDq0DrAAu5JtZQHSQMgL+XMmOctgC2jb2EWFiPxLJnrwStUq5FB1h95kokRo8mip+A
         jkgWGvOl/u6GeiXcM9B4OiyieNPQ2l77Vq95YXwDfpsBo0GceIldlahCaSLQff8j98iU
         yTKQ==
X-Gm-Message-State: AOAM530Y5gVuk4pWU9hR8PW/GvKErchdj5g+3Cr49jDdaCXl3BaLCVZw
        99Y+ejK7DGcpYzLs7PFRjKcn+wOR6934BzSf28I=
X-Google-Smtp-Source: ABdhPJzcXSnd0mAO4ggqyDw1H3+41RFtpE1kqdYRT9njovuDPTcdx1JQM+vmiz/lmmJxcNXMc1SvhM8tBctv3RSfrik=
X-Received: by 2002:a63:e245:: with SMTP id y5mr15578928pgj.139.1640017271190;
 Mon, 20 Dec 2021 08:21:11 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 20 Dec 2021 11:21:00 -0500
Message-ID: <CAPig+cTVzMtiHzkJq7VRg4Xa3xhrq7KKCdK5OSDY6bvwKu_ynA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Sparse checkout: fix bug with worktree of bare repo
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 20, 2021 at 10:57 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> This patch series includes a fix to the bug reported by Sean Allred [1] and
> diagnosed by Eric Sunshine [2].
>
> The root cause is that 'git sparse-checkout init' writes to the worktree
> config without checking that core.bare might need to be set. This only
> matters when the base repository is bare, since creating the config.worktree
> file and enabling extensions.worktreeConfig will cause Git to treat the base
> repo's core.bare=false as important for this worktree.

Thanks for jumping on this so quickly. Unfortunately, however, as
mentioned in [1] and [2], I think the approach implemented here of
setting `core.bare=false` in the worktree-specific config is
fundamentally flawed since it only addresses the problem for worktrees
in which `git sparse-checkout init` has been run, but leaves all other
worktrees potentially broken (both existing and new worktrees). As far
as I can see, the _only_ correct solution is for the new helper
function to enable `extensions.worktreeConfig` _and_ relocate
`core.bare` and `core.worktree` from .git/config to
.git/worktree.config, thus implementing the requirements documented in
git-worktree.txt.

I also raised a separate question in [2] about whether `git
sparse-checkout init` or the new helper function should be warning the
user that upgrading the repository format and setting
`extensions.worktreeConfig` might break third-party tools. However,
that question is tangential to the fix being addressed here and
doesn't need to be addressed by this series.

[1]: https://lore.kernel.org/git/CAPig+cQ6U_yFw-X2OWrizB1rbCvc4bNxuSzKFzmoLNnm0GH8Eg@mail.gmail.com/
[2]: https://lore.kernel.org/git/CAPig+cQPUe9REf+wgVNjyak_nk3V361h-48rTFgk6TGC7vJgOA@mail.gmail.com/
