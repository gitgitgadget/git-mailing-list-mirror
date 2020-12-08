Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A445C4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 21:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FEE5239FD
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 21:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbgLHVDB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 16:03:01 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63671 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbgLHVDA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 16:03:00 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB11D95603;
        Tue,  8 Dec 2020 16:02:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=cGOo23FnB/h8fNYCjK0kkHFJ3dM=; b=AFge6XMzoXfkNLXD/S1w
        hn1PyvvjmwWNFxGAWadmeVeLthjZS36O3/9hidCqBIX12twQmwamECqzD9NyoIK6
        Tr5YODrcHWftqlRcTtQGW7RooB/PJmK1TxYzhBn2gQQfZADw25Bop/WH/gv4VMUB
        UBa4OUpJ8/DoCAzCIuHUNHE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=Qhd0wHW2aGJ7MZbipSFSbnSv3oXDlcSoEKsrDhLZMyHGG7
        3QEOOIwub++yCo+CJIuZNpa7ks1PmGo3RVZ3HccjfC26XwasAUgdqgYd33TFJ1jK
        9rxXd/jHfrFalOzqy5ztFw6lSFZ6Ido/kR0LmdxSDuJ77jzgidms5/JyXiipw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C383595602;
        Tue,  8 Dec 2020 16:02:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3EB0E95601;
        Tue,  8 Dec 2020 16:02:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sangeeta <sangunb09@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [Outreachy][PATCH v6] diff: do not show submodule with
 untracked files as "-dirty"
References: <pull.751.git.1602781723670.gitgitgadget@gmail.com>
        <20201026175742.33356-1-sangunb09@gmail.com>
        <CAHjREB7W2P9_P4LoMHVVzV_YR5-_51zdbRZ0fpEDVkgkd7sh8w@mail.gmail.com>
        <xmqqblges4ue.fsf@gitster.c.googlers.com>
        <CAHjREB7-QWHBOQQPdDdEM-gJm=w3+4D=N=5TaS3UE__6XnSpJA@mail.gmail.com>
Date:   Tue, 08 Dec 2020 13:02:15 -0800
Message-ID: <xmqqblf46mg8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6E4AFB0-3998-11EB-9C43-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sangeeta <sangunb09@gmail.com> writes:

> Hey,
>
> I worked on passing --ignore-submodules=none as the default behavior
> of git status so that the user doesn't end up deleting a submodule
> that has uncommitted (untracked) files.
>
> The following changes make git status pass the ignoreSubmodules none
> argument as default.
>
> @@ -4587,7 +4587,7 @@ void repo_diff_setup(struct repository *r,
> struct diff_options *options)
>         options->orderfile = diff_order_file_cfg;
>
>         if (!options->flags.ignore_submodule_set)
> -               handle_ignore_submodules_arg(options, "untracked");
> +               options->flags.ignore_untracked_in_submodules = 1;
>
>         if (diff_no_prefix) {
>                 options->a_prefix = options->b_prefix = "";
>
>
> @@ -607,6 +607,9 @@ static void
> wt_status_collect_changes_worktree(struct wt_status *s)
>                 rev.diffopt.flags.override_submodule_config = 1;
>                 handle_ignore_submodules_arg(&rev.diffopt,
> s->ignore_submodule_arg);
>         }
> +       else if(!rev.diffopt.flags.ignore_submodule_set){
> +               handle_ignore_submodules_arg(&rev.diffopt, "none");
> +       }
>
> I have had to set the flag manually in diff.c because when we call
> handle_ignore_submodules_arg() with "untracked" arg,
> options->flags.ignore_submodule_set is set to 1 and therefore when we
> check for it in wt-status.c it appears that user has already set some
> config and therefore we shouldn't add "none" as ignoreSubmodules arg.
>
> Another way to do that is to have one more flag in diff_options that
> can let us know whether options->flags.ignore_submodule_set was set by
> the user or by diff passing untracked as the default argument.
>
> Can someone please help me with what might be the right way to proceed?

Hmph, neither sounds "right"---having to circumvent the assignment
to _set flag made in the handle_ helper by either manually setting
the underlying flag, or by introducing another flag that stops from
the _set flag getting updated, sounds like working around a flaw of
the approach to use _set flag and set it in the handle_ helper in
the first place...



