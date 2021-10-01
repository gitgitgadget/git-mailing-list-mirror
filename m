Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAECBC433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 20:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91DDD61A10
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 20:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355530AbhJAUyg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 16:54:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53795 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhJAUyf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 16:54:35 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B4BCBF4379;
        Fri,  1 Oct 2021 16:52:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3xm1pbBRMkqDKKkB8WqTH1cRUs8OzrJdgzf31O
        B6d8I=; b=SeL/XS9jFpeZBO7dPnBMCxUnG+uTbbx/yCox03vlElUD4/uu5XK7uO
        vE6SSk7FydLQiIKZpS8vz+SXEqv+S1D/Nwt2D0i+fhkh4zETcnyH0B7KStFklDtr
        aM6ukqSBf0kn2sVVOzCs/uVu6eHpu2Ee402b3eJJXio3omCniDu60=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ABF53F4378;
        Fri,  1 Oct 2021 16:52:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 213AFF4377;
        Fri,  1 Oct 2021 16:52:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 03/11] reset_head(): don't run checkout hook if there is
 an error
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
        <28872cbca687b057663a4e3408cb94d69fb60f94.1633082702.git.gitgitgadget@gmail.com>
Date:   Fri, 01 Oct 2021 13:52:48 -0700
In-Reply-To: <28872cbca687b057663a4e3408cb94d69fb60f94.1633082702.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Fri, 01 Oct 2021 10:04:54
        +0000")
Message-ID: <xmqqtui05uxr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8A2642D0-22F9-11EC-AF9B-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> The hook should only be run if the worktree and refs were successfully
> updated.

OK.  This is a behaviour change visible to end-users, and deserves a
mention in the release notes.

 - When "git rebase" attempted to check out a branch (or detached
   the HEAD) to work on, we used to always call the "post-checkout"
   hook, even if the checkout failed to update the ref.  The hook is
   no longer called if the checkout fails.

or something.

Again, can the bug this step fixes be protected with a new test in
t/ please?

>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  reset.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/reset.c b/reset.c
> index fc4dae3fd2d..5abb1a5683e 100644
> --- a/reset.c
> +++ b/reset.c
> @@ -125,7 +125,7 @@ reset_head_refs:
>  			ret = create_symref("HEAD", switch_to_branch,
>  					    reflog_head);
>  	}
> -	if (run_hook)
> +	if (!ret && run_hook)
>  		run_hook_le(NULL, "post-checkout",
>  			    oid_to_hex(orig ? orig : null_oid()),
>  			    oid_to_hex(oid), "1", NULL);
