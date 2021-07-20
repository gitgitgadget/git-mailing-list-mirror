Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56ACC07E9B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 23:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBFC16008E
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 23:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbhGTW6o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 18:58:44 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54024 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236963AbhGTWyi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 18:54:38 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 696E713BCEA;
        Tue, 20 Jul 2021 19:35:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LJwgDvbznH2NsVrdFrI79UTmNnUrCj9iTXjvoS
        cUi3w=; b=kL95fFoESGBqAdUbTS5LqDXtGPQSOvGpp2smJLcurS8nT+uVMBpTo2
        bT0vuEZkPeR6o4XUN0KW5nLLt5zShOI5VNAnYhud3I3rN53gkMuQPlSpHWIwF1el
        l4SXYGi0D3Hd2Oj/zOhXQAVdfOEaUOcLk4S/qHpTZsrZuqBt6i26E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 612C413BCE9;
        Tue, 20 Jul 2021 19:35:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 41C4713BCE6;
        Tue, 20 Jul 2021 19:35:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 5/9] pull: ensure --rebase overrides ability to ff
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
        <3d9ff69198e5a604b124bf861df4d6ecf6eb661e.1626536508.git.gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 16:35:00 -0700
In-Reply-To: <3d9ff69198e5a604b124bf861df4d6ecf6eb661e.1626536508.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Sat, 17 Jul 2021
        15:41:43 +0000")
Message-ID: <xmqqwnpkftjv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1ACAAF04-E9B3-11EB-A152-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> Now that the handling of fast-forward-only in combination with rebases
> has been moved before the merge-vs-rebase logic, we have an unnecessary
> special fast-forward case left within the rebase logic.

It is correct to say that we could call run_rebase() and it will do
the right thing, even when can_ff is true, in this codepath.

But I am not sure if you want to do this as a part of this series.

The code in question comes from 33b842a1 (pull: fast-forward "pull
--rebase=true", 2016-06-29).  It was meant as a mere optimization
to avoid calling run_rebase() when we know we have nothing to replay
on top of their head after we fast-forward, and doing a pure
fast-forward is easier by calling run_merge().

In other words, the code this patch touches should not have anything
to do with the rebase-vs-fast-forward logic.

Now, if a benchmarking tells us that there is no difference between
calling an empty run_rebase() and run_merge(), I'd be perfectly fine
with this change, with the justification that we are "discarding an
earlier optimization that has become irrelevant".  But that would be
totally outside the theme of this topic, I would think.

Thanks.

> @@ -1070,13 +1070,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>  		    submodule_touches_in_range(the_repository, &upstream, &curr_head))
>  			die(_("cannot rebase with locally recorded submodule modifications"));
>  
> -		if (can_ff) {
> -			/* we can fast-forward this without invoking rebase */
> -			opt_ff = "--ff-only";
> -			ret = run_merge();
> -		} else {
> -			ret = run_rebase(&newbase, &upstream);
> -		}
> +		ret = run_rebase(&newbase, &upstream);
>  
>  		if (!ret && (recurse_submodules == RECURSE_SUBMODULES_ON ||
>  			     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND))
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index e2c0c510222..4b50488141f 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -295,7 +295,7 @@ test_expect_success '--rebase (merge) fast forward' '
>  	# The above only validates the result.  Did we actually bypass rebase?
>  	git reflog -1 >reflog.actual &&
>  	sed "s/^[0-9a-f][0-9a-f]*/OBJID/" reflog.actual >reflog.fuzzy &&
> -	echo "OBJID HEAD@{0}: pull --rebase . ff: Fast-forward" >reflog.expected &&
> +	echo "OBJID HEAD@{0}: pull --rebase . ff (finish): returning to refs/heads/to-rebase" >reflog.expected &&
>  	test_cmp reflog.expected reflog.fuzzy
>  '
>  
> @@ -307,8 +307,8 @@ test_expect_success '--rebase (am) fast forward' '
>  
>  	# The above only validates the result.  Did we actually bypass rebase?
>  	git reflog -1 >reflog.actual &&
> -	sed "s/^[0-9a-f][0-9a-f]*/OBJID/" reflog.actual >reflog.fuzzy &&
> -	echo "OBJID HEAD@{0}: pull --rebase . ff: Fast-forward" >reflog.expected &&
> +	sed -e "s/^[0-9a-f][0-9a-f]*/OBJID/" -e "s/[0-9a-f][0-9a-f]*$/OBJID/" reflog.actual >reflog.fuzzy &&
> +	echo "OBJID HEAD@{0}: rebase finished: refs/heads/to-rebase onto OBJID" >reflog.expected &&
>  	test_cmp reflog.expected reflog.fuzzy
>  '
