Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F364C04A68
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 20:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbiG0UNe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 16:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiG0UNd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 16:13:33 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0002564C9
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 13:13:31 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DE398128B22;
        Wed, 27 Jul 2022 16:13:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4ujUvvCH8roYSCfMHQQ3co+Zv0qneQqwasnCJL
        lwVxw=; b=K1RDQExZtCUJ/1Hpi4qNANZd2MoO49YJZnZSWWRUcrqFG9bzTzU9gb
        q4xQn84vuXq/F0A0cVxkk/7TVn1QpUKTpOVCxt0a2LUEtBHYVb2oD/V6/pVTBlg1
        3S1455KU8+kjW2jselOnJFyO9+hdnbf76MIP2m9GOH9yavnhdCukY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D67F3128B21;
        Wed, 27 Jul 2022 16:13:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 11295128B20;
        Wed, 27 Jul 2022 16:13:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Justin Donnelly via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Justin Donnelly <justinrdonnelly@gmail.com>
Subject: Re: [PATCH] git-prompt: show 'CONFLICT' indicator at command prompt
References: <pull.1302.git.1658798595633.gitgitgadget@gmail.com>
Date:   Wed, 27 Jul 2022 13:13:28 -0700
In-Reply-To: <pull.1302.git.1658798595633.gitgitgadget@gmail.com> (Justin
        Donnelly via GitGitGadget's message of "Tue, 26 Jul 2022 01:23:15
        +0000")
Message-ID: <xmqq35ems49j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 94F2A9C6-0DE8-11ED-A4FE-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Justin Donnelly via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 1435548e004..2d30eb5c17e 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -84,6 +84,9 @@
>  # single '?' character by setting GIT_PS1_COMPRESSSPARSESTATE, or omitted
>  # by setting GIT_PS1_OMITSPARSESTATE.
>  #
> +# When there is a conflict, the prompt will include "|CONFLICT". This can
> +# be omitted by setting GIT_PS1_OMITCONFLICTSTATE.
> +#

It is unusual to subject our unsuspecting users to new features in a
way that is done by this patch.  A more usual practice, I think, is
to tell the users that they can set GIT_PS1_INCLUDECONFLICTSTATE to
"yes" if they want to opt in, and trigger the new feature only to
them.  Later, we may decide that the feature is useful and widely
apprlicable enough, at which time it may be turned on by default and
tell the users to set GIT_PS1_INCLUDECONFLICTSTATE to "no" if they
do not want to see it.  But one step at a time.

> @@ -508,6 +511,12 @@ __git_ps1 ()
>  		r="$r $step/$total"
>  	fi
>  
> +	local conflict="" # state indicator for unresolved conflicts
> +	if [[ -z "${GIT_PS1_OMITCONFLICTSTATE-}" ]] &&

And flipping the polarity and disabling it by default would be a
simple change, I would imagine, that can be made here.

> +	   [[ $(git ls-files --unmerged 2>/dev/null) ]]; then
> +		conflict="|CONFLICT"
> +	fi
> +
>  	local w=""
>  	local i=""
>  	local s=""
> @@ -572,7 +581,7 @@ __git_ps1 ()
>  	fi
>  
>  	local f="$h$w$i$s$u$p"
> -	local gitstring="$c$b${f:+$z$f}${sparse}$r${upstream}"
> +	local gitstring="$c$b${f:+$z$f}${sparse}$r${upstream}${conflict}"
>  
>  	if [ $pcmode = yes ]; then
>  		if [ "${__git_printf_supports_v-}" != yes ]; then
> diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
> index 6a30f5719c3..9314776211c 100755
> --- a/t/t9903-bash-prompt.sh
> +++ b/t/t9903-bash-prompt.sh
> @@ -183,7 +183,7 @@ test_expect_success 'prompt - interactive rebase' '
>  '
>  
>  test_expect_success 'prompt - rebase merge' '

Of course, this needs to be tweaked if we did so.  Running the test
in the default state will not need this change, but then ...

> -	printf " (b2|REBASE 1/3)" >expected &&
> +	printf " (b2|REBASE 1/3|CONFLICT)" >expected &&
>  	git checkout b2 &&
>  	test_when_finished "git checkout main" &&
>  	test_must_fail git rebase --merge b1 b2 &&

... a new test that runs the same thing but with the new feature
asked by setting the environment variable would show the new |CONFLICT
marker.

Thanks.
