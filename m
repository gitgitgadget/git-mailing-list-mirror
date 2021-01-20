Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7B4C43381
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 20:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAF9123444
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 20:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732297AbhATUgf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 15:36:35 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55551 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbhATU2k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 15:28:40 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C52E0AA5C4;
        Wed, 20 Jan 2021 15:27:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=87J9lRcHaROL2zFWLigB3xVjR5M=; b=pTE1nzbRjngkPhBXUcTn
        UzYDFSh0GYdhU5gz0GweJ/AyNce8fPKoByFjMDH8KbUmRT2qlP4NdPVP9YuQvKiU
        GzuqP73dB8kkUrMZiMgnY5X7l92BRt7WPVJyeaYFjQXsOqHO9Ua+eSoGJTQrpBHA
        /mOg+rHvA5+/cu5RFqmOZp4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=W8e1BSYOu2mujZWBET9roZIYGbPZyzQdOUc1ls1UlQXGjU
        rS4FV8iJD02vyhybbR56MqujSPeyFfgA0ycvt5CG95jVG9cF9oRnh//m8B4aj75g
        K0uaDCgVVWWnC0R0ApRau9vaKwpaz8L1lTYDAulQRGEsxlJkcyKc3NiWA4v24=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BB2B5AA5C3;
        Wed, 20 Jan 2021 15:27:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 439E7AA5C2;
        Wed, 20 Jan 2021 15:27:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Subject: Re: [PATCH v5 2/3] ls_files.c: consolidate two for loops into one
References: <pull.832.v4.git.1610856136.gitgitgadget@gmail.com>
        <pull.832.v5.git.1611037846.gitgitgadget@gmail.com>
        <802ff802be884349b4a63c0ae6e4b783e6c7aedb.1611037846.git.gitgitgadget@gmail.com>
Date:   Wed, 20 Jan 2021 12:27:40 -0800
Message-ID: <xmqqczxzfj5v.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F1DEAA52-5B5D-11EB-B5D5-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> Refactor the two for loops into one,skip showing the ce if it
> has the same name as the previously shown one, only when doing so
> won't lose information.
>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>  builtin/ls-files.c | 70 +++++++++++++++++++---------------------------
>  1 file changed, 29 insertions(+), 41 deletions(-)

This one needs a bit more work, but I like the basic structure of
the rewritten loop.

> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index f1617260064..1454ab1ae6f 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -312,51 +312,39 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
>  		if (show_killed)
>  			show_killed_files(repo->index, dir);
>  	}
> -	if (show_cached || show_stage) {
> -		for (i = 0; i < repo->index->cache_nr; i++) {
> -			const struct cache_entry *ce = repo->index->cache[i];
> +	if (! (show_cached || show_stage || show_deleted || show_modified))
> +		return;

If none of these four are given, nothing will be given after this
point, so returning early is good.

> +	for (i = 0; i < repo->index->cache_nr; i++) {
> +		const struct cache_entry *ce = repo->index->cache[i];
> +		struct stat st;
> +		int err;
>  
> +		construct_fullname(&fullname, repo, ce);
>  
> +		if ((dir->flags & DIR_SHOW_IGNORED) &&
> +			!ce_excluded(dir, repo->index, fullname.buf, ce))
> +			continue;
> +		if (ce->ce_flags & CE_UPDATE)
> +			continue;

The above two are common between the original two codepaths, and
merging them is good.

> +		if (show_cached || show_stage) {
> +			if (!show_unmerged || ce_stage(ce))
> +				show_ce(repo, dir, ce, fullname.buf,
> +					ce_stage(ce) ? tag_unmerged :
> +					(ce_skip_worktree(ce) ? tag_skip_worktree :
> +						tag_cached));
>  		}

We would want to reduce the indentation level of the show_ce() by
consolidating the nested if/if to

		if ((show_cached || show_stage) &&
                    (!show_unmerged || ce_stage(ce)))
			show_ce(...);


Everything below from this point should be skipped (especially, the
call to lstat()) unless show_modified and/or show_deleted was asked
by the caller, i.e.  we want to insert

		if (!(show_deleted || show_modified))
			continue;

here, before we call ce_skip_worktree(), I think.

> +		if (ce_skip_worktree(ce))
> +			continue;
> +		err = lstat(fullname.buf, &st);
> +		if (err) {
> +			if (errno != ENOENT && errno != ENOTDIR)
> +				error_errno("cannot lstat '%s'", fullname.buf);
> +			if (show_deleted)
> +				show_ce(repo, dir, ce, fullname.buf, tag_removed);
> +			if (show_modified)
>  				show_ce(repo, dir, ce, fullname.buf, tag_modified);
> -		}
> +		} else if (show_modified && ie_modified(repo->index, ce, &st, 0))
> +			show_ce(repo, dir, ce, fullname.buf, tag_modified);
>  	}

And this part would look somewhat different if we take my earlier
suggestion for [1/3].

Thanks.
