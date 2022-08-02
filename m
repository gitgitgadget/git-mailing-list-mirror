Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68B0C00144
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 00:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbiHBAuf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 20:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiHBAue (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 20:50:34 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB02220E0
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 17:50:33 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 593051541A3;
        Mon,  1 Aug 2022 20:50:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Je1xBuzjG7giHxqbhkKrQtR0VWjB055YIWUYjx
        TDlQ0=; b=CA1OLNpEMHkDoS8wVoe/lVCOZj9N34CKWBwjNlcJoI8aSoxn7WVE85
        oyVMoJetNCCuY1/geA88UpFmYDzNi0WluJBbGaHPBmfbxeLRRtvyW/QX/8rlWV0M
        1ClKjJ/QclUVTZY1gXnb8pDIs1+NHFCeXEJpwInZSz8Guascr3uZ0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 515A71541A2;
        Mon,  1 Aug 2022 20:50:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BD84D1541A1;
        Mon,  1 Aug 2022 20:50:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, newren@gmail.com, Johannes.Schindelin@gmx.de,
        avarab@gmail.com
Subject: Re: [PATCH v7] submodule merge: update conflict error message
References: <20220726210020.3397249-1-calvinwan@google.com>
        <20220728211221.2913928-1-calvinwan@google.com>
Date:   Mon, 01 Aug 2022 17:50:30 -0700
In-Reply-To: <20220728211221.2913928-1-calvinwan@google.com> (Calvin Wan's
        message of "Thu, 28 Jul 2022 21:12:21 +0000")
Message-ID: <xmqqpmhjjwo9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C527C44-11FD-11ED-93E1-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

>  merge-ort.c                 | 112 ++++++++++++++++++++++++++++++++++--
>  t/t6437-submodule-merge.sh  |  78 +++++++++++++++++++++++--
>  t/t7402-submodule-rebase.sh |   9 ++-
>  3 files changed, 185 insertions(+), 14 deletions(-)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 01f150ef3b..4302e900ee 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -387,6 +387,9 @@ struct merge_options_internal {
>  
>  	/* call_depth: recursion level counter for merging merge bases */
>  	int call_depth;
> +
> +	/* field that holds submodule conflict information */
> +	struct string_list conflicted_submodules;
>  };
>  
>  struct version_info {
> @@ -517,6 +520,7 @@ enum conflict_and_info_types {
>  	CONFLICT_SUBMODULE_NOT_INITIALIZED,
>  	CONFLICT_SUBMODULE_HISTORY_NOT_AVAILABLE,
>  	CONFLICT_SUBMODULE_MAY_HAVE_REWINDS,
> +	CONFLICT_SUBMODULE_NULL_MERGE_BASE,
>  
>  	/* Keep this entry _last_ in the list */
>  	NB_CONFLICT_TYPES,
> @@ -570,6 +574,8 @@ static const char *type_short_descriptions[] = {
>  		"CONFLICT (submodule history not available)",
>  	[CONFLICT_SUBMODULE_MAY_HAVE_REWINDS] =
>  		"CONFLICT (submodule may have rewinds)",

The other ones are semi sentences ...

> +	[CONFLICT_SUBMODULE_NULL_MERGE_BASE] =
> +		"CONFLICT (submodule no merge base)"

... and this wants to become one, too, e.g. "submodule lacks merge
base", perhaps?

>  };

> @@ -686,6 +692,8 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
>  
>  	mem_pool_discard(&opti->pool, 0);
>  
> +	string_list_clear(&opti->conflicted_submodules, 1);
> +
>  	/* Clean out callback_data as well. */
>  	FREE_AND_NULL(renames->callback_data);
>  	renames->callback_data_nr = renames->callback_data_alloc = 0;
> @@ -1744,26 +1752,40 @@ static int merge_submodule(struct merge_options *opt,
>  
>  	int i;
>  	int search = !opt->priv->call_depth;
> +	int sub_initialized = 1;
>  
>  	/* store fallback answer in result in case we fail */
>  	oidcpy(result, opt->priv->call_depth ? o : a);
>  
>  	/* we can not handle deletion conflicts */
> -	if (is_null_oid(o))
> -		return 0;
>  	if (is_null_oid(a))
> -		return 0;
> +		BUG("submodule deleted on one side; this should be handled outside of merge_submodule()"); 
>  	if (is_null_oid(b))
> -		return 0;
> +		BUG("submodule deleted on one side; this should be handled outside of merge_submodule()");

OK.  It is interesting that the first condition (i.e. 'o' is
missing) we are removing is not about "we cannot handle deletion",
so this change corrects the code to match the comment.  As the BUG()
messages are the same on these sides,

	if (is_null_oid(a) || is_null_oid(b))
		BUG(...);

may be easier to read, perhaps?

> -	if (repo_submodule_init(&subrepo, opt->repo, path, null_oid())) {
> +	if ((sub_initialized = repo_submodule_init(&subrepo,
> +									opt->repo, path, null_oid()))) {

I wonder where this overly deep indentation come from?  Can the
.editorconfig file we ship with the project help?

>  		path_msg(opt, CONFLICT_SUBMODULE_NOT_INITIALIZED, 0,
>  			 path, NULL, NULL, NULL,
>  			 _("Failed to merge submodule %s (not checked out)"),
>  			 path);
> +		/*
> +		 * NEEDSWORK: Since the steps to resolve this error are
> +		 * more involved than what is currently in 
> +		 * print_submodule_conflict_suggestion(), we return
> +		 * immediately rather than generating an error message
> +		 */

OK.

>  		return 0;
>  	}
>  
> +	if (is_null_oid(o)) {
> +		path_msg(opt, CONFLICT_SUBMODULE_NULL_MERGE_BASE, 0,
> +			 path, NULL, NULL, NULL,
> +			 _("Failed to merge submodule %s (no merge base)"),
> +			 path);

OK.

> +		goto cleanup;
> +	}

> @@ -1849,7 +1871,15 @@ static int merge_submodule(struct merge_options *opt,
>  
>  	object_array_clear(&merges);
>  cleanup:
> -	repo_clear(&subrepo);
> +	if (!opt->priv->call_depth && !ret) {
> +		struct string_list *csub = &opt->priv->conflicted_submodules;
> +
> +		string_list_append(csub, path)->util =
> +				xstrdup(repo_find_unique_abbrev(&subrepo, b, DEFAULT_ABBREV));

This line could also lose one level of indent.

We record 'b' in its abbreviated form here, because the assumption
is that when merging the superproject, 'a' (which is the assumed
fallback answer wet up at the beginning of the furnction) is the
commit recorded in our side of the superproject, and it is the
commit checked out in the submodule, so the task of making the
necessary merge in the submodule is to go to the submodule and then
merge 'b' into HEAD.  Makes sense.

> @@ -4412,6 +4442,73 @@ static int record_conflicted_index_entries(struct merge_options *opt)
>  	return errs;
>  }
>  
> +static void print_submodule_conflict_suggestion(struct string_list *csub) {
> +	if (csub->nr > 0) {
> +		struct string_list_item *item;
> +		struct strbuf msg = STRBUF_INIT;
> +		struct strbuf tmp = STRBUF_INIT;
> +
> +		strbuf_addf(&tmp, _("Recursive merging with submodules currently only supports trivial cases."));
> +		strbuf_addf(&msg, "%s\n", tmp.buf);
> +		strbuf_release(&tmp);
> +
> +		strbuf_addf(&tmp, _("Please manually handle the merging of each conflicted submodule."));
> +		strbuf_addf(&msg, "%s\n", tmp.buf);
> +		strbuf_release(&tmp);
> +
> +		strbuf_addf(&tmp, _("This can be accomplished with the following steps:"));
> +		strbuf_addf(&msg, "%s\n", tmp.buf);
> +		strbuf_release(&tmp);
> +
> +		for_each_string_list_item(item, csub) {
> +			const char *abbrev= item->util;
> +			/*
> +			 * TRANSLATORS: This is a line of advice to resolve a merge conflict
> +			 * in a submodule. The second argument is the abbreviated id of the
> +			 * commit that needs to be merged.
> +			 * E.g. - go to submodule (sub), and either merge commit abc1234"
> +			 */
> +			strbuf_addf(&tmp, _("go to submodule (%s), and either merge commit %s"),
> +													item->string, abbrev);

Is this also an instance of overly deep indentation (it is so deep
that I cannot easily tell)?

When we say "either merge commit %s" (where %s is 'b'---what they
have as we saw earlier), do we need to mention what the value of 'a'
is to the user, or is it redundant because we are absolutely sure
that 'a' is what is checked out in the submodule?

> +			strbuf_addf(&msg, _(" - %s"), tmp.buf);
> +			strbuf_addf(&msg, "\n");
> +			strbuf_release(&tmp);
> +			strbuf_addf(&tmp, _("or update to an existing commit which has merged those changes"));

"those changes" means "a..b"?  Again, I just want to make sure that
the user in this situation knows "the other end" of the range when
they are told only about 'b'.

> +			strbuf_addf(&msg, _("   %s"), tmp.buf);
> +			strbuf_addf(&msg, "\n");
> +			strbuf_release(&tmp);
> +		}
> +		strbuf_addf(&tmp, _("come back to superproject and run:"));
> +		strbuf_addf(&msg, _(" - %s"), tmp.buf);
> +		strbuf_addf(&msg, "\n\n");
> +		strbuf_release(&tmp);
> +
> +		strbuf_addf(&tmp, "git add ");
> +		strbuf_add_separated_string_list(&tmp, " ", csub);
> +		strbuf_addf(&msg, _("       %s"), tmp.buf);
> +		strbuf_addf(&msg, "\n\n");
> +		strbuf_release(&tmp);
> +
> +		strbuf_addf(&tmp, _("to record the above merge or update"));
> +		strbuf_addf(&msg, _("   %s"), tmp.buf);
> +		strbuf_addf(&msg, "\n");
> +		strbuf_release(&tmp);
> +
> +		strbuf_addf(&tmp, _("resolve any other conflicts in the superproject"));
> +		strbuf_addf(&msg, _(" - %s"), tmp.buf);
> +		strbuf_addf(&msg, "\n");
> +		strbuf_release(&tmp);
> +
> +		strbuf_addf(&tmp, _("commit the resulting index in the superproject"));
> +		strbuf_addf(&msg, _(" - %s"), tmp.buf);
> +		strbuf_addf(&msg, "\n");
> +		strbuf_release(&tmp);
> +
> +		printf("%s", msg.buf);
> +		strbuf_release(&msg);
> +	}
> +}

OK.  Makes sense.

Thanks.
