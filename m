Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5601C433E2
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 17:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C72C221EC
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 17:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qUeURnuL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgIQRSR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 13:18:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52599 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgIQRRa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 13:17:30 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 622538F559;
        Thu, 17 Sep 2020 13:16:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YVVlB1FbdOYqTxmetmwHIgQecdU=; b=qUeURn
        uLBMAaXSIVAtEcblhrGholez3jkTRerIMMPPsCI3O+AFTsXkh6KEHw+qLGdxdshX
        SctsFPvDefRYe89tA5g3jV2YimkUNfUh6nAsIkwiiQffHbDQRR5oBgQoJ1o8oPd8
        V2ac5uJWOATj94xQZEUcc2bfbO1MZbX8rS/RA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hldavowP7oSBtOcuJCzwfejD7FbnLCZx
        EhhODTc+INXW1Fk8YFZAWz7LzTtPK78zOPX4egIYa0Gf8teBuWwaR2wVvK4VoQ96
        lp/iD2CYcheMQP/E4rCT7uOxP2/EVXBnDQ9dK2IWvkXOp3zGS+XaRjqtdYAesJ+J
        C5UstjZdIUw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B4628F558;
        Thu, 17 Sep 2020 13:16:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CCD1E8F557;
        Thu, 17 Sep 2020 13:16:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 06/10] diff-lib: define diff_get_merge_base()
References: <cover.1599723087.git.liu.denton@gmail.com>
        <cover.1600328335.git.liu.denton@gmail.com>
        <6aac57ca022963fb41d93905e41dff36dccd5969.1600328335.git.liu.denton@gmail.com>
Date:   Thu, 17 Sep 2020 10:16:51 -0700
In-Reply-To: <6aac57ca022963fb41d93905e41dff36dccd5969.1600328335.git.liu.denton@gmail.com>
        (Denton Liu's message of "Thu, 17 Sep 2020 00:44:10 -0700")
Message-ID: <xmqqd02ks4qk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 93D62630-F909-11EA-A3FD-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> +void diff_get_merge_base(const struct rev_info *revs, struct object_id *mb)
> +{
> +	int i;
> +	struct commit *mb_child[2] = {0};
> +	struct commit_list *merge_bases;
> +
> +	for (i = 0; i < revs->pending.nr; i++) {
> +		struct object *obj = revs->pending.objects[i].item;
> +		if (obj->flags)
> +			die(_("--merge-base does not work with ranges"));
> +		if (obj->type != OBJ_COMMIT)
> +			die(_("--merge-base only works with commits"));
> +	}

This is the first use of die() in this file, that is designed to
keep a set of reusable library functions so that the caller(s) can
do their own die().  They may want to become

	return error(_(...));

The same comment applies to all die()s the patch adds.

> +	/*
> +	 * This check must go after the for loop above because A...B
> +	 * ranges produce three pending commits, resulting in a
> +	 * misleading error message.
> +	 */

Should "git diff --merge-base A...B" be forbidden, or does it just
ask the same thing twice and is not a die-worthy offence?

> +	if (revs->pending.nr > ARRAY_SIZE(mb_child))
> +		die(_("--merge-base does not work with more than two commits"));

Compare with hardcoded '2' in the condition.  The requirement for
mb_child[] is that it can hold at least 2 (changes in the future may
find it convenient if its size gets increased to 3 to hold NULL sentinel
to signal end-of-list, for example).   Comparison with ARRAY_SIZE() may
be appropriate in different situations but not here where the code knows
it wants to reject more than two no matter how big mb_child[] is.

> +	for (i = 0; i < revs->pending.nr; i++)
> +		mb_child[i] = lookup_commit_reference(the_repository, &revs->pending.objects[i].item->oid);
> +	if (revs->pending.nr < ARRAY_SIZE(mb_child)) {
> +		struct object_id oid;
> +
> +		if (revs->pending.nr != 1)
> +			BUG("unexpected revs->pending.nr: %d", revs->pending.nr);

This is an obviously impossible condition as we will not take more
than 2.

> +		if (get_oid("HEAD", &oid))
> +			die(_("unable to get HEAD"));
> +		mb_child[1] = lookup_commit_reference(the_repository, &oid);
> +	}
> +
> +	merge_bases = repo_get_merge_bases(the_repository, mb_child[0], mb_child[1]);
> +	if (!merge_bases)
> +		die(_("no merge base found"));
> +	if (merge_bases->next)
> +		die(_("multiple merge bases found"));
> +
> +	oidcpy(mb, &merge_bases->item->object.oid);
> +
> +	free_commit_list(merge_bases);
> +}


OK.

>  int run_diff_index(struct rev_info *revs, unsigned int option)
>  {
>  	struct object_array_entry *ent;
> diff --git a/diff.h b/diff.h
> index 0cc874f2d5..ae2bb7001a 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -580,6 +580,8 @@ void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc);
>   */
>  const char *diff_aligned_abbrev(const struct object_id *sha1, int);
>  
> +void diff_get_merge_base(const struct rev_info *revs, struct object_id *mb);

Without an actual caller, we cannot judge if this interface is
designed right, but we'll see soon in the next steps ;-)

Looking good so far.

Thanks.

> +
>  /* do not report anything on removed paths */
>  #define DIFF_SILENT_ON_REMOVED 01
>  /* report racily-clean paths as modified */
