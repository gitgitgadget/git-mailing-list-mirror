Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094B3C433E0
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 20:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B643E64F2A
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 20:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbhCRUbN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 16:31:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63128 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbhCRUak (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 16:30:40 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D36B7B358C;
        Thu, 18 Mar 2021 16:30:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sWXVZXjQVHhSGP5iwIhc9VqUsGk=; b=FDd7Gu
        eTrmRlJj98O3hfunFFu4yv9WlfGGM97MmXtlXj4Mvusq/h0rpo9Nh9MH7Jd1UorQ
        T4vnWZzxefsYe3sDf86d27HIovhQrR0aBnDcajSa+g30rEkhgG8LyZTw4hK27tO2
        lreN+LsZV0EbQGmZB6KwKjCjhW6cNvCXbTPCA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nM5SovdJYGBTYb9blKprusbu8n8jlT47
        p53tFnUyJBxg30dYdz8cB90KRzdIJhB9Rdfqk/Kq2Djhkxui20EGPLYEnXXUhXoA
        3eOYqxHKHglAfEZyNf+A2ryyy0c4QFK3O1Min9lbxBXH7I2hMBh7N6+KgiwPKxFI
        DLYUWnceWjo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C732CB358A;
        Thu, 18 Mar 2021 16:30:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 513BFB3588;
        Thu, 18 Mar 2021 16:30:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [RESEND PATCH 2/3] git-completion.bash: fix `git <args>...
 stash branch` bug
References: <cover.1615855962.git.liu.denton@gmail.com>
        <cover.1616060793.git.liu.denton@gmail.com>
        <be727d0171b16e488a357a959176e60bf9210d40.1616060793.git.liu.denton@gmail.com>
Date:   Thu, 18 Mar 2021 13:30:38 -0700
In-Reply-To: <be727d0171b16e488a357a959176e60bf9210d40.1616060793.git.liu.denton@gmail.com>
        (Denton Liu's message of "Thu, 18 Mar 2021 02:46:55 -0700")
Message-ID: <xmqqsg4sryq9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD8B65DA-8828-11EB-A1C5-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> When completions are offered for `git stash branch<TAB>`, the user is
> supposed to receive refs. This works in the case where the main git
> command is called without arguments but if options are provided, such as
> `git -C dir stash branch<TAB>`, then the `$cword -eq 3` provides
> incorrect results.
>
> Count the words relative to the first instance of "stash" so that we
> ignore arguments to the main git command.
>
> Unfortunately, this still does not work 100% correctly. For example, in
> the case of something like `git -C stash stash branch<TAB>`, this will
> incorrectly identify the first "stash" as the command. This seems to be
> an edge-case that we can ignore, though, as other functions, such as
> _git_worktree(), suffer from the same problem.

I am not familiar with how the completion support works, but doing
this inside _git_stash() and still not being able to tell which
"stash" on the command line is supposed to be the git subcommand
smells quite fishy to me.  

How did the caller decide to invoke _git_stash helper function in
the first place?

When it is given "git -C push --paginate stash branch<TAB>", it must
have parsed the command line, past the options given to the "git"
potty, to find "stash" on the command line that it is _git_stash and
not _git_push that needs to be called, no?  If it were possible to
propagate that information without losing it, then we do not have to
recompute where the subcommand name is at all, do we?

> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index fe79f6b71c..da46f46e3c 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -3016,6 +3016,9 @@ _git_stash ()
>  	local save_opts='--all --keep-index --no-keep-index --quiet --patch --include-untracked'
>  	local subcommands='push list show apply clear drop pop create branch'
>  	local subcommand="$(__git_find_on_cmdline "$subcommands save")"
> +	local stash_idx="$(__git_find_on_cmdline --show-idx stash)"
> +	stash_idx="${stash_idx% *}"
> +
>  	if [ -z "$subcommand" -a -n "$(__git_find_on_cmdline "-p")" ]; then
>  		subcommand="push"
>  	fi
> @@ -3060,7 +3063,7 @@ _git_stash ()
>  	branch,--*)
>  		;;
>  	branch,*)
> -		if [ $cword -eq 3 ]; then
> +		if [ $((cword - stash_idx)) -eq 2 ]; then
>  			__git_complete_refs
>  		else
>  			__gitcomp_nl "$(__git stash list \
