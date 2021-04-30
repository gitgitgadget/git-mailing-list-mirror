Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857E1C433ED
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 00:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BBEA613D9
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 00:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhD3Ant (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 20:43:49 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52289 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhD3Ans (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 20:43:48 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8A9501208E3;
        Thu, 29 Apr 2021 20:43:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d0waPvZoLWsA03rN2n9l22d63jMgru1Wk4Jp0J
        Mx94U=; b=oeC8UxUH7K22ajHTq+YLFDLNSs66AfZKg2AgU+bscA9kZ+Gp3ijARo
        R1G3XDsxtKO/1FuBICmdhrBQBF6Xgqcl3o+vol/bAHfBUUxbwXdxTHuNrOZvjbrp
        v0QpB7uSbdWz17t5gEbN5cRSG7p4U96ONz1tsKVkp6aiihdUfZc+k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 835EB1208E2;
        Thu, 29 Apr 2021 20:43:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A3E541208E0;
        Thu, 29 Apr 2021 20:42:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sardorbek Imomaliev via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Sardorbek Imomaliev <sardorbek.imomaliev@gmail.com>
Subject: Re: [PATCH] Fix: fix comment for __git_complete_worktree_paths
References: <pull.943.git.1619685833872.gitgitgadget@gmail.com>
Date:   Fri, 30 Apr 2021 09:42:56 +0900
In-Reply-To: <pull.943.git.1619685833872.gitgitgadget@gmail.com> (Sardorbek
        Imomaliev via GitGitGadget's message of "Thu, 29 Apr 2021 08:43:53
        +0000")
Message-ID: <xmqq1rasfvqn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 02A4D5E0-A94D-11EB-B0A2-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Sardorbek Imomaliev via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Subject: Re: [PATCH] Fix: fix comment for __git_complete_worktree_paths

In this project, we write what area of the codebase the change
affects before the colon (I'll give you an example later).

> From: Sardorbek Imomaliev <sardorbek.imomaliev@gmail.com>
>
> Completion helper function fails for zsh because of wrongly put comment

Isn't it a bug in zsh that it does not understand that the comment
is about the command placed on the downstream of the pipe, like
this example?

	echo a b c |
	# upcase the input (a comment about the next line)
	tr a-z A-Z

Apparently bash is happy with the existing code, and dash and ksh
seems to be OK with the above construct, too.

Perhaps rephrase the log message like this instead?

    [PATCH] completion: work around zsh comment but in __git_complete_worktree_paths

    In contrib/completion/git-completion.bash, there is a construct
    where comment lines are placed between the command that is on
    the upstream of a pipe and the command that is on the downstream
    of a pipe in __git_complete_worktree_paths function.

    Unfortunately, this script is also used by Zsh completion, but
    Zsh mishandles this construct, resulting in a breakage:

        $ git worktree remove [TAB]
        $ git worktree remove __git_complete_worktree_paths:7: command not found: #

    Move the comment, even though it explains what happens on the
    downstream of the pipe and logically belongs where it is right
    now, before the entire pipeline, to work around this problem.

It might also be necessary to consider rephrasing the comment
itself, not just "Move the comment", to make sure that it is still
appropriate when used as a comment to cover the whole pipeline---the
original was meant to explain what happens in the downstream only.

Thanks.


> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index dfa735ea6299..b2e158edaf6b 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -3268,9 +3268,9 @@ _git_whatchanged ()
>  __git_complete_worktree_paths ()
>  {
>  	local IFS=$'\n'
> +	# Skip the first entry: it's the path of the main worktree,
> +	# which can't be moved, removed, locked, etc.
>  	__gitcomp_nl "$(git worktree list --porcelain |
> -		# Skip the first entry: it's the path of the main worktree,
> -		# which can't be moved, removed, locked, etc.
>  		sed -n -e '2,$ s/^worktree //p')"
>  }
>  
>
> base-commit: 311531c9de557d25ac087c1637818bd2aad6eb3a
