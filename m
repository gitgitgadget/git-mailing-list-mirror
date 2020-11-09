Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8051C4741F
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 23:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EF902065D
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 23:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="X5/RKC8a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbgKIXRN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 18:17:13 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50026 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgKIXRN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 18:17:13 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 22E5D95EE8;
        Mon,  9 Nov 2020 18:17:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AeZSI1AgQox6TsFW6hs2/I7y8mg=; b=X5/RKC
        8azkoHWmOd+uKDuVvkwRnkHJUsUwU9tAr6CG3uyFSIKMwUxKWhP8tft7/OahFJxE
        LCd/sRVeUNPv2ki9MrWhthb3IhqxsT/qID4Nu/BRXciGD6x+vbJojPulbYlJ2uL6
        XTn8lEXt/LCpLU2ivwTfWj1zbK6jovMvxy7+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OWDDE4hErlHHHoGity6aNv4nenh5+nTS
        jxLYNG26/N7/zCxZp309CQwpF992R0ZWD2JHcqek1ozXMzETF+Yt8l1lG1/gsom8
        RJOn4z5ojmd1QS9DYhRLVQ96CsIOjOqycWUsfoeKJy2eONiToe4mrUd50dnrbKZn
        UszbKHDWlAA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1947695EE7;
        Mon,  9 Nov 2020 18:17:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9BF2E95EE6;
        Mon,  9 Nov 2020 18:17:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Seija K. via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, pi1024e <pi1024e@github.com>
Subject: Re: [PATCH] Simplified merge logic
References: <pull.911.git.git.1604871456715.gitgitgadget@gmail.com>
Date:   Mon, 09 Nov 2020 15:17:09 -0800
In-Reply-To: <pull.911.git.git.1604871456715.gitgitgadget@gmail.com> (Seija
        K. via GitGitGadget's message of "Sun, 08 Nov 2020 21:37:36 +0000")
Message-ID: <xmqqo8k69l3e.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B189F5D8-22E1-11EB-868B-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Seija K. via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: pi1024e <pi1024e@github.com>
>
> commit: Avoid extraneous boolean checking by simplifying the if statements.
> Signed-off-by: Seija <pi1024e@github.com>
> ---

Meh.

Admittedly, readability is somewhat subjective, but a rewrite like

        if (condition)                  if (!condition)
                do_when_true();                 do_when_false();
        else                       ==>  else
                do_when_false();                do_when_true();

while it may not be incorrect per-se needs more than a subjective "I
think this is more readable" to justify the code churn.

> diff --git a/builtin/merge.c b/builtin/merge.c
> index 4c133402a6..9664da6031 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -853,9 +853,8 @@ static void prepare_to_commit(struct commit_list *remoteheads)
>  	if (run_commit_hook(0 < option_edit, get_index_file(), "prepare-commit-msg",
>  			    git_path_merge_msg(the_repository), "merge", NULL))
>  		abort_commit(remoteheads, NULL);
> -	if (0 < option_edit) {
> -		if (launch_editor(git_path_merge_msg(the_repository), NULL, NULL))
> -			abort_commit(remoteheads, NULL);
> +	if (0 < option_edit && launch_editor(git_path_merge_msg(the_repository), NULL, NULL)) {
> +		abort_commit(remoteheads, NULL);
>  	}

This may reduce the number of lines, but personally I find that

	if (are we editing?) {
		if (run editor---did we fail?)
			abort();
	}

is much easier to read.

And much more importantly, it would be much easier to extend later
what hwppens when we decide to edit, than the new code proposed by
this patch.

> @@ -1213,7 +1212,7 @@ static int merging_a_throwaway_tag(struct commit *commit)
>  	if (!merge_remote_util(commit) ||
>  	    !merge_remote_util(commit)->obj ||
>  	    merge_remote_util(commit)->obj->type != OBJ_TAG)
> -		return is_throwaway_tag;
> +		return 0;

Likewise.  If somebody _must_ touch this function to gain commit
count without making the code harder to maintain, it may be an
option to use "goto leave;" here and then create a "leave:" label
before the other "return"---at least that may be worth considering,
but not this---when everybody else in the function wants to maintain
that the value in this variable is what is returned from the
function.

> @@ -1459,13 +1458,12 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  			fast_forward = FF_NO;
>  	}
>  
> -	if (!use_strategies) {
> -		if (!remoteheads)
> -			; /* already up-to-date */
> -		else if (!remoteheads->next)
> -			add_strategies(pull_twohead, DEFAULT_TWOHEAD);
> -		else
> +	if (!use_strategies && remoteheads) {
> +		/* not up-to-date */
> +		if (remoteheads->next)
>  			add_strategies(pull_octopus, DEFAULT_OCTOPUS);
> +		else
> +			add_strategies(pull_twohead, DEFAULT_TWOHEAD);
>  	}

Likewise.

	if (do we have to choose strategies ourselves?) {
		... depending on the case, choose strategy ...
	}

is much easier to reason about than

	if (do we have to choose strategies ourselves?, oh by the
    	    way, don't forget that already up-to-date case we do not
	    have to choose) {
		... the remainder ...
	}

and extend when we need to add something to do in the up-to-date
case as long as the end-user did not specify which strategy to use
in the future.  The reduced line count alone is not a good yardstick
to use when talking about code restructuring for readability and
maintainability.

Thanks.
