Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D51C433E0
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 21:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9CD923B44
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 21:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbhAVUx5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 15:53:57 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53899 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730987AbhAVUx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 15:53:28 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 485F6A8204;
        Fri, 22 Jan 2021 15:52:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kei6GtbksGsIyZiHIBElRQA9NCA=; b=vRf/d/
        3983wPpvrOqKlKu9WTgcOMWcVBYmSajOolUk9dNxPQjf1KKmXZ9DdXyIQmEFjC6S
        DVVOrtGnvfbNkrxrvxYcHLl1WI3E5RWfx2q2+T+4Zrz9D1OEe/iqShA6V2fKKy2o
        1fYlTcPOS++xsehI4B7VQYKXwIVsj9Z39NO2g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Bp8sdI1KVcoW8QdIpaeREMEBqlHFKNtL
        tqdodOmqKgmgm7/ZcJnbjT6HRnlMfmswFq2WXmhdx/Yzl7ApUHt5Naf0pm19z6hY
        qY3J9nnTQURJLswqXlqvhICQ0yzQFDe9r7KfXg1O+AhZLN+MWwhgQAMyNA8CZ2nT
        6aNKGex/54U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F8AAA8203;
        Fri, 22 Jan 2021 15:52:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 82E67A8202;
        Fri, 22 Jan 2021 15:52:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6] ls-files.c: add --deduplicate option
References: <CAOLTT8R=fF00WCVBSTDKHG_3p5RcZaxM2AU-cUj1sNWvy=mhCQ@mail.gmail.com>
        <20210122154640.3791035-1-adlternative@gmail.com>
Date:   Fri, 22 Jan 2021 12:52:42 -0800
In-Reply-To: <20210122154640.3791035-1-adlternative@gmail.com> (ZheNing Hu's
        message of "Fri, 22 Jan 2021 23:46:40 +0800")
Message-ID: <xmqqr1mc7kyt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C61D1ABA-5CF3-11EB-9D71-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> In order to provide users a better experience
> when viewing information about files in the index
> and the working tree, the `--deduplicate` option will suppress
> some duplicate name under some conditions.

Now is it just a single patch squashing everything together?
That does not look like it.

> @@ -317,7 +318,7 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
>  	for (i = 0; i < repo->index->cache_nr; i++) {
>  		const struct cache_entry *ce = repo->index->cache[i];
>  		struct stat st;
> -		int err;
> +		int stat_err;
>  
>  		construct_fullname(&fullname, repo, ce);
>  
> @@ -326,25 +327,43 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
>  			continue;
>  		if (ce->ce_flags & CE_UPDATE)
>  			continue;
> -		if (show_cached || show_stage) {
> -			if (!show_unmerged || ce_stage(ce))
> +		if ((show_cached || show_stage) &&
> +			(!show_unmerged || ce_stage(ce))) {
>  				show_ce(repo, dir, ce, fullname.buf,
>  					ce_stage(ce) ? tag_unmerged :
>  					(ce_skip_worktree(ce) ? tag_skip_worktree :
>  						tag_cached));
> +			if (show_cached && skipping_duplicates)
> +				goto skip_to_next_name;

Why should this be so complex?  You are dropping skipping_duplicates
when the output is not name-only, so shouldn't this look more like

		if ((show_cached || show_stage) &&
		    (!show_unmerged || ce_stage(ce)) {
			show_ce(...);
                        if (skipping_duplicates)
                        	goto skip_to_next_name;
		}

It seems that this still depends on the 2/3 from the previous
iteration, against which I suggested to merge the conditions of
nested if statements into one.  That should be done in the updated
2/3, not in this step, no?

>  		}
> +		if (!show_deleted && !show_modified)
> +			continue;

And this one also belongs to the step 2/3 that consolidates the two
loops into one.

I think you'd need to start from the three patches in v5, "rebase -i"
not just [3/3] but at least [2/3], too.

Thanks.
