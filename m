Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BD1C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 19:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2129364E22
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 19:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhBCTN2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 14:13:28 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62277 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhBCTN2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 14:13:28 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 938A910C050;
        Wed,  3 Feb 2021 14:12:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=G8MwVBgeF4OAcq4H3UG3G12CNb0=; b=Z6HZz+
        3Hg+K5077za9PGgOT4cTAfZdNvVoJ7S9cVzDdP7RAspgzVfHMXVaCcF5opbTAvZj
        X1UeixPm/DDIudaDVx6IV5K2+zjr+c9Hpx0OEYLp6KGB2jqjYuzYBM1ORxzMkpH9
        h0CmyxYfHGHMsC2bf0XHsv4ogI14xXKM1ELCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WY1YN1t4c4NqyN4FNIKNSEZWM5/YuALL
        rWnaC6tuOCoOiVY2JVDO9fWFREfQnWazYiAUb/sV9Loip3kyKAdqz3AUrJP4/7Oz
        VHCakqiOmX3icAU48VE4yyvWCLXEMkvx8Ke7uzRReKKCAjbk4c167u6QmFTzcMsP
        h/XPXJSCRR0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8BABD10C04E;
        Wed,  3 Feb 2021 14:12:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CEB9210C04A;
        Wed,  3 Feb 2021 14:12:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Karsten Blees <blees@dcon.de>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] diffcore-rename: filter rename_src list when possible
References: <pull.842.git.1612331345.gitgitgadget@gmail.com>
        <580ba9a10f54c7a2e7f28d60395fc2edae25eec1.1612331345.git.gitgitgadget@gmail.com>
Date:   Wed, 03 Feb 2021 11:12:40 -0800
In-Reply-To: <580ba9a10f54c7a2e7f28d60395fc2edae25eec1.1612331345.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Wed, 03 Feb 2021
        05:49:05 +0000")
Message-ID: <xmqqbld1c6dz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9C8F33C-6653-11EB-AFE1-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static int remove_unneeded_paths_from_src(int num_src,
> +					  int detecting_copies)
> +{
> +	int i, new_num_src;
> +
> +	/*
> +	 * Note on reasons why we cull unneeded sources but not destinations:
> +	 *   1) Pairings are stored in rename_dst (not rename_src), which we
> +	 *      need to keep around.  So, we just can't cull rename_dst even
> +	 *      if we wanted to.  But doing so wouldn't help because...
> +	 *
> +	 *   2) There is a matrix pairwise comparison that follows the
> +	 *      "Performing inexact rename detection" progress message.
> +	 *      Iterating over the destinations is done in the outer loop,
> +	 *      hence we only iterate over each of those once and we can
> +	 *      easily skip the outer loop early if the destination isn't
> +	 *      relevant.  That's only one check per destination path to
> +	 *      skip.
> +	 *
> +	 *      By contrast, the sources are iterated in the inner loop; if
> +	 *      we check whether a source can be skipped, then we'll be
> +	 *      checking it N separate times, once for each destination.
> +	 *      We don't want to have to iterate over known-not-needed
> +	 *      sources N times each, so avoid that by removing the sources
> +	 *      from rename_src here.
> +	 */
> +	if (detecting_copies)
> +		return num_src; /* nothing to remove */
> +	if (break_idx)
> +		return num_src; /* culling incompatbile with break detection */
> +
> +	for (i = 0, new_num_src = 0; i < num_src; i++) {
> +		/*
> +		 * renames are stored in rename_dst, so if a rename has
> +		 * already been detected using this source, we can just
> +		 * remove the source knowing rename_dst has its info.
> +		 */
> +		if (rename_src[i].p->one->rename_used)
> +			continue;
> +
> +		if (new_num_src < i)
> +			memcpy(&rename_src[new_num_src], &rename_src[i],
> +			       sizeof(struct diff_rename_src));
> +		new_num_src++;
> +	}
> +
> +	return new_num_src;
> +}

Essentially we are compacting rename_src[] array from num_src
elements down to new_num_src elements; we are losing pointers, but I
presume these are all borrowed pointers that we do not own and we
are not responsible for freeing?  If we were to free them, the
compaction would leave duplicates after the new tail (new_num_src)
and we'd end up having to worry about double-freeing, so hopefully
all we need to do is just to free the entire array of pointers, and
not the pointees.

Having to do this just once and being able to reduce the number of
entries we need to iterate over does sound like a good simple
optimization.

>  void diffcore_rename(struct diff_options *options)
>  {
>  	int detect_rename = options->detect_rename;
> @@ -463,10 +512,11 @@ void diffcore_rename(struct diff_options *options)
>  	struct diff_score *mx;
>  	int i, j, rename_count, skip_unmodified = 0;
>  	int num_destinations, dst_cnt;
> -	int num_sources;
> +	int num_sources, want_copies;
>  	struct progress *progress = NULL;
>  
>  	trace2_region_enter("diff", "setup", options->repo);
> +	want_copies = (detect_rename == DIFF_DETECT_COPY);
>  	if (!minimum_score)
>  		minimum_score = DEFAULT_RENAME_SCORE;
>  
> @@ -529,13 +579,10 @@ void diffcore_rename(struct diff_options *options)
>  		goto cleanup;
>  
>  	/*
> -	 * Calculate how many renames are left (but all the source
> -	 * files still remain as options for rename/copies!)
> +	 * Calculate how many renames are left
>  	 */
>  	num_destinations = (rename_dst_nr - rename_count);
> -	num_sources = rename_src_nr;
> -	if (detect_rename != DIFF_DETECT_COPY)
> -		num_sources -= rename_count;
> +	num_sources = remove_unneeded_paths_from_src(rename_src_nr, want_copies);

OK, this is in a sense an extended version of the previous step.

I am not sure if rename_src_nr can be left out of sync with reality
like this patch does, though.  The reference to that variable in
register_rename_src() and find_exact_renames() are OK as we are not
going to call them after we futz with the rename_src[] array, but
the reference in prefetch(), which does not actually happen early
but only when we start running estimate_similarity(), which is after
we compacted the rename_src[] array, would be affected, no?

Thanks.
