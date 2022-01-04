Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D254C433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 23:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbiADXqb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 18:46:31 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58830 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiADXqa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 18:46:30 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DDA2CFA47B;
        Tue,  4 Jan 2022 18:46:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jHMDr+9dgGeykme/MkuYVS1X7qZvBNFlHdcdiY
        olz0w=; b=CFAvFO5Ij8jauLuxIfynlDLPeEHX6QC13zt8C7S1X7xk2jBobn9hZ1
        RvVsujvtIiUx7jueXfOHsecOvUdTL0N4YDK1XFPPD9LadXzEtW5i4ZnFSITenI/9
        HCJhInRacCNQ60IC4DKRpEoxP2ZDE0Xs6gb28m3Kgb5PE3QPfcB30=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D4862FA47A;
        Tue,  4 Jan 2022 18:46:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 33BFBFA479;
        Tue,  4 Jan 2022 18:46:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] stash: do not return before restoring untracked files
References: <pull.1180.git.git.1641337498996.gitgitgadget@gmail.com>
Date:   Tue, 04 Jan 2022 15:46:27 -0800
In-Reply-To: <pull.1180.git.git.1641337498996.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Tue, 04 Jan 2022 23:04:58
        +0000")
Message-ID: <xmqqy23v83os.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 89A3DCFA-6DB8-11EC-9B1C-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/builtin/stash.c b/builtin/stash.c
> index 18c812bbe03..397210168da 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -561,18 +561,19 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
>  		if (index)
>  			fprintf_ln(stderr, _("Index was not unstashed."));
>  
> -		return ret;
> +		goto restore_untracked;
>  	}
>  
>  	if (has_index) {
>  		if (reset_tree(&index_tree, 0, 0))
> -			return -1;
> +			ret = -1;
>  	} else {
>  		unstage_changes_unless_new(&c_tree);
>  	}
>  
> +restore_untracked:
>  	if (info->has_u && restore_untracked(&info->u_tree))
> -		return error(_("could not restore untracked files from stash"));
> +		ret = error(_("could not restore untracked files from stash"));

In other words, instead of doing an early return, we try to
resurrect untracked ones and always show the "git status" before
returning.

I think that takes us in the right direction.  I looked at other
early returns in this function, and while there may be a room for
improvements when the --index stash does not apply well, I think it
can be left outside the topic of this patch.

Will queue.

Thanks.

>  	if (!quiet) {
>  		struct child_process cp = CHILD_PROCESS_INIT;
> @@ -592,7 +593,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
>  		run_command(&cp);
>  	}
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int apply_stash(int argc, const char **argv, const char *prefix)
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 2c66cfbc3b7..2a7d8e511db 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -1376,4 +1376,28 @@ test_expect_success 'git stash can pop directory -> file saved changes' '
>  	)
>  '
>  
> +test_expect_success 'restore untracked files even when we hit conflicts' '
> +	git init restore_untracked_after_conflict &&
> +	(
> +		cd restore_untracked_after_conflict &&
> +
> +		echo hi >a &&
> +		echo there >b &&
> +		git add . &&
> +		git commit -m first &&
> +		echo hello >a &&
> +		echo something >c &&
> +
> +		git stash push --include-untracked &&
> +
> +		echo conflict >a &&
> +		git add a &&
> +		git commit -m second &&
> +
> +		test_must_fail git stash pop &&
> +
> +		test_path_is_file c
> +	)
> +'
> +
>  test_done
>
> base-commit: 2ae0a9cb8298185a94e5998086f380a355dd8907
