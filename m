Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8951AC433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 21:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B7706135F
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 21:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbhDTVLN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 17:11:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62997 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbhDTVLN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 17:11:13 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D89EB957A;
        Tue, 20 Apr 2021 17:10:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ka/sCNvODVY9JVSekv//T8yZZ4I=; b=HysTV2
        QvVhdNhRrcIEYyS1Lp5ow1h5g5SKk1/N562mtgBvdcMaSz6DAa1UZso+7V6HWmtA
        Yz++eG9cqIdwl33Fxq/yXpls0Un+UwfX1+Yn6OAFx0kepVp8DAOUHKCFw5dL+uXY
        1TTXxg3pRu3kd5f1o4sDgpXzFx0gpo88uVf8M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tmIUJQgobfHVkuMZV0TH5NSs5rzoN/7W
        dtXck9XZsOQWwKhUGbVM2HhUG2Akw/J7CP0R/ZEA9v2RHxLCNaJodgs6FuJqOBtS
        lthP00/oNpgrD8IUiRqWR5W1JHIjTZXv2zNMhgkOPDgyRuyiLqbDeO/CPRayoiSk
        FvjfrQExRmU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 75406B9579;
        Tue, 20 Apr 2021 17:10:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 00AFFB9578;
        Tue, 20 Apr 2021 17:10:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 5/5] git-completion.bash: consolidate no-subcommand case
 for _git_stash()
References: <cover.1618910364.git.liu.denton@gmail.com>
        <b4a9b0afa7ab28b701499982f5a8fc66eb7e19e8.1618910364.git.liu.denton@gmail.com>
Date:   Tue, 20 Apr 2021 14:10:39 -0700
In-Reply-To: <b4a9b0afa7ab28b701499982f5a8fc66eb7e19e8.1618910364.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 20 Apr 2021 02:19:51 -0700")
Message-ID: <xmqqk0ow4q7k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DC170C7C-A21C-11EB-81A2-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> We have a separate if case for when no subcommand is given. It is
> simpler to just consolidate this logic into the case statement below.

Hmph, I am not quite sure if the removal of the first case is making
the code easier to follow.  Is this supposed to be a no-op clean-up,
or is it fixing some bugs?

> It would be nice to complete remove the magic that deals with indices
> and replace it with what was originally there,
>
> 	if [ -z "$subcommand" -a -n "$(__git_find_on_cmdline "-p")" ]; then
> 	        subcommand="push"
> 	fi
>
> but this gives a slightly incorrect completion. In the case where we're
> attempting to complete `git stash -a <TAB>` we will get the subcommands
> back as a respose instead of the completions for `git stash push`, which
> is what we'd expect. We could potentially hardcode all of the short
> options but that would be too much work to maintain so we stick with the
> index solution.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 30 +++++++++++++-------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 7bce9a0112..060adc0ed7 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -3016,22 +3016,22 @@ _git_stash ()
>  	local subcommands='push list show apply clear drop pop create branch'
>  	local subcommand="$(__git_find_on_cmdline "$subcommands save")"
>  
> -	if [ -z "$subcommand" ]; then
> -		case "$((cword - __git_cmd_idx)),$cur" in
> -		*,--*)
> -			__gitcomp_builtin stash_push
> -			;;
> -		1,sa*)
> -			__gitcomp "save"
> -			;;
> -		1,*)
> -			__gitcomp "$subcommands"
> -			;;
> -		esac
> -		return
> -	fi
> -
>  	case "$subcommand,$cur" in
> +	,--*)
> +		__gitcomp_builtin stash_save
> +		;;
> +	,sa*)
> +		__git_init_builtin_opts stash_save
> +		if ((cword - __git_cmd_idx == 1)); then
> +			__gitcomp "save"
> +		fi
> +		;;
> +	,*)
> +		__git_init_builtin_opts stash_save
> +		if ((cword - __git_cmd_idx == 1)); then
> +			__gitcomp "$subcommands"
> +		fi
> +		;;
>  	list,--*)
>  		# NEEDSWORK: can we somehow unify this with the options in _git_log() and _git_show()
>  		__gitcomp_builtin stash_list "$__git_log_common_options $__git_diff_common_options"
