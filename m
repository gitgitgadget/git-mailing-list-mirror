Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D943EC34056
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 18:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF56724670
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 18:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BuB8zoN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgBSSkY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 13:40:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56738 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgBSSkY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 13:40:24 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5FEA3477E8;
        Wed, 19 Feb 2020 13:40:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=33DnFQMK0dcxm8B6Y1LSSILt7cs=; b=BuB8zo
        N1FnMtGnyLsOTfnf5C9u6Uw0FLHh3NXzJ5zhXsUnrLQeTYyNx7fmBnzkMazAcC8O
        peJ+hl7cSUWPdzJt+Ot8gyvO/xlv1mi1cwAhF5CnmYvKe0Gy0AfP8Def9sdvHcrI
        yqaqIO4WsQGnGEvbdNqU2bla3ZjfDvrvytxaA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=glWM/yvdefKgFVR1wzanoLEcLHQd9LWN
        MirzUxEAS/LqntUmCGzVfjyFaiegkkMAR4v9eHDODJVSZk6VqIr64rtuFoHC05yL
        9dVJPROUsbn+Ia9TJuDKz9st/yuBNJZ0wnmZrhY2fq5ozkQkfq3xeqbM3VSI0lcP
        2LOHG09tUek=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 57EA9477E7;
        Wed, 19 Feb 2020 13:40:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A10AB477E6;
        Wed, 19 Feb 2020 13:40:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 2/2] merge-recursive: fix the refresh logic in update_file_flags
References: <pull.712.v3.git.git.1582064105813.gitgitgadget@gmail.com>
        <pull.712.v4.git.git.1582131847.gitgitgadget@gmail.com>
        <ba297fd67bb98bd06408241030cf42f410d5d366.1582131847.git.gitgitgadget@gmail.com>
Date:   Wed, 19 Feb 2020 10:40:17 -0800
In-Reply-To: <ba297fd67bb98bd06408241030cf42f410d5d366.1582131847.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Wed, 19 Feb 2020
        17:04:07 +0000")
Message-ID: <xmqq4kvmfmjy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 46F98C02-5347-11EA-8E5E-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> If we need to delete a higher stage entry in the index to place the file
> at stage 0, then we'll lose that file's stat information.  In such
> situations we may still be able to detect that the file on disk is the
> version we want (as noted by our comment in the code:
>   /* do not overwrite file if already present */
> ), but we do still need to update the mtime since we are creating a new
> cache_entry for that file.  Update the logic used to determine whether
> we refresh a file's mtime.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-recursive.c                    | 7 +++++--
>  t/t3433-rebase-across-mode-change.sh | 2 +-
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index aee1769a7ac..e6f943c5ccc 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -998,10 +998,13 @@ static int update_file_flags(struct merge_options *opt,
>  		free(buf);
>  	}
>  update_index:
> -	if (!ret && update_cache)
> -		if (add_cacheinfo(opt, contents, path, 0, update_wd,
> +	if (!ret && update_cache) {
> +		int refresh = (!opt->priv->call_depth &&
> +			       contents->mode != S_IFGITLINK);
> +		if (add_cacheinfo(opt, contents, path, 0, refresh,
>  				  ADD_CACHE_OK_TO_ADD))
>  			return -1;

Hmph, !.call_depth would avoid resetting update_wd to 0, so the only
difference this patch makes is when the caller of this helper passed
(update_wd == 0) during the outermost merge.  We did not tell
add_cacheinfo() to refresh, and refresh_cache_entry() was not
called.  But the new code forces refresh to happen for normal
entries.  The proposed log message explains that a refresh is needed
for a new cache entry, but if I am reading the code correctly, this
function is called with !update_wd from two places, one of which is
the "Adding %s" /* do not overwrite ... */ the log message mentions.

But the other one?  When both sides added identically, we do have an
up-to-date result on our side already, so shouldn't we avoid forcing
update_wd in that case?

I do not think passing refresh==1 in that case will produce an
incorrect result, but doesn't it force an unnecessary refreshing?

Puzzled.

> +	}
>  	return ret;
>  }
>  
> diff --git a/t/t3433-rebase-across-mode-change.sh b/t/t3433-rebase-across-mode-change.sh
> index f11fc35c3ee..05df964670f 100755
> --- a/t/t3433-rebase-across-mode-change.sh
> +++ b/t/t3433-rebase-across-mode-change.sh
> @@ -33,7 +33,7 @@ test_expect_success 'rebase changes with the apply backend' '
>  	git rebase side1
>  '
>  
> -test_expect_failure 'rebase changes with the merge backend' '
> +test_expect_success 'rebase changes with the merge backend' '
>  	test_when_finished "git rebase --abort || true" &&
>  	git checkout -b merge-backend side2 &&
>  	git rebase -m side1
