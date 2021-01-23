Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18381C433E0
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 19:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D253F22D50
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 19:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbhAWTvk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 14:51:40 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53969 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbhAWTvi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 14:51:38 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C3245AFA8E;
        Sat, 23 Jan 2021 14:50:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yTj5ohHPcXNOqc6zLnAe79tU0Os=; b=EraITM
        RDtCGbUkYcH6oRaWU+/Iwuj4/o7WMIbgyxxrh3nnpteeIyIman79b5qvDhoPbEwW
        wyVdYljOGdXseyAQJGM/2XtEaw5v8K4B+hx5Qv4eUbtmcQvvY/FkgCM+wh8Rhw1S
        l359Y68WTXTAekeyIVVWgFFaJWGus8Cd1fJdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kVsXPIHduwQVBFrdhyLQDW7y9YObUYti
        BZoIBioJhRFhWhDcCvidFgeKxJQAM2zjrF7UJ/bXzrDj/6oOc38plpvTIZ9QpqQu
        K00IZDeAJkOikxfvTuuZkDtpkdvpVgMcHx2NtkydKxAewWNhIoDfDovkvkke858r
        nQgXi6S+tZM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BA1EFAFA8D;
        Sat, 23 Jan 2021 14:50:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 49BF0AFA8C;
        Sat, 23 Jan 2021 14:50:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 2/3] ls_files.c: consolidate two for loops into one
References: <pull.832.v5.git.1611037846.gitgitgadget@gmail.com>
        <pull.832.v6.git.1611397210.gitgitgadget@gmail.com>
        <3997d390883e0ee13d343ad56cb535cd99d1af4e.1611397210.git.gitgitgadget@gmail.com>
Date:   Sat, 23 Jan 2021 11:50:54 -0800
In-Reply-To: <3997d390883e0ee13d343ad56cb535cd99d1af4e.1611397210.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Sat, 23 Jan 2021 10:20:09
        +0000")
Message-ID: <xmqq8s8j4eld.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E3F1644-5DB4-11EB-A417-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> Refactor the two for loops into one,skip showing the ce if it
> has the same name as the previously shown one, only when doing so
> won't lose information.

This message is all stale now.  This step does only refactoring,
without "skip showing" and others.

I've rebased the series locally and sending out a "v7" for your
review later.

Thanks.

>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>  builtin/ls-files.c | 70 ++++++++++++++++++++--------------------------
>  1 file changed, 30 insertions(+), 40 deletions(-)
>
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 1e264bd1329..966c0ab0296 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -312,49 +312,39 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
>  		if (show_killed)
>  			show_killed_files(repo->index, dir);
>  	}
> -	if (show_cached || show_stage) {
> -		for (i = 0; i < repo->index->cache_nr; i++) {
> -			const struct cache_entry *ce = repo->index->cache[i];
> -
> -			construct_fullname(&fullname, repo, ce);
> -
> -			if ((dir->flags & DIR_SHOW_IGNORED) &&
> -			    !ce_excluded(dir, repo->index, fullname.buf, ce))
> -				continue;
> -			if (show_unmerged && !ce_stage(ce))
> -				continue;
> -			if (ce->ce_flags & CE_UPDATE)
> -				continue;
> -			show_ce(repo, dir, ce, fullname.buf,
> -				ce_stage(ce) ? tag_unmerged :
> -				(ce_skip_worktree(ce) ? tag_skip_worktree :
> -				 tag_cached));
> -		}
> -	}
> -	if (show_deleted || show_modified) {
> -		for (i = 0; i < repo->index->cache_nr; i++) {
> -			const struct cache_entry *ce = repo->index->cache[i];
> -			struct stat st;
> -			int stat_err;
> +	if (! (show_cached || show_stage || show_deleted || show_modified))
> +		return;
> +	for (i = 0; i < repo->index->cache_nr; i++) {
> +		const struct cache_entry *ce = repo->index->cache[i];
> +		struct stat st;
> +		int stat_err;
>  
> -			construct_fullname(&fullname, repo, ce);
> +		construct_fullname(&fullname, repo, ce);
>  
> -			if ((dir->flags & DIR_SHOW_IGNORED) &&
> -			    !ce_excluded(dir, repo->index, fullname.buf, ce))
> -				continue;
> -			if (ce->ce_flags & CE_UPDATE)
> -				continue;
> -			if (ce_skip_worktree(ce))
> -				continue;
> -			stat_err = lstat(fullname.buf, &st);
> -			if (stat_err && (errno != ENOENT && errno != ENOTDIR))
> -				error_errno("cannot lstat '%s'", fullname.buf);
> -			if (stat_err && show_deleted)
> -				show_ce(repo, dir, ce, fullname.buf, tag_removed);
> -			if (show_modified &&
> -				(stat_err || ie_modified(repo->index, ce, &st, 0)))
> -					show_ce(repo, dir, ce, fullname.buf, tag_modified);
> +		if ((dir->flags & DIR_SHOW_IGNORED) &&
> +			!ce_excluded(dir, repo->index, fullname.buf, ce))
> +			continue;
> +		if (ce->ce_flags & CE_UPDATE)
> +			continue;
> +		if (show_cached || show_stage) {
> +			if (!show_unmerged || ce_stage(ce))
> +				show_ce(repo, dir, ce, fullname.buf,
> +					ce_stage(ce) ? tag_unmerged :
> +					(ce_skip_worktree(ce) ? tag_skip_worktree :
> +						tag_cached));
>  		}
> +		if (!show_deleted && !show_modified)
> +			continue;
> +		if (ce_skip_worktree(ce))
> +			continue;
> +		stat_err = lstat(fullname.buf, &st);
> +		if (stat_err && (errno != ENOENT && errno != ENOTDIR))
> +			error_errno("cannot lstat '%s'", fullname.buf);
> +		if (stat_err && show_deleted)
> +			show_ce(repo, dir, ce, fullname.buf, tag_removed);
> +		if (show_modified &&
> +			(stat_err || ie_modified(repo->index, ce, &st, 0)))
> +				show_ce(repo, dir, ce, fullname.buf, tag_modified);
>  	}
>  
>  	strbuf_release(&fullname);
