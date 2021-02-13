Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8189BC433E0
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 01:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4301364DD6
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 01:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhBMBdr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 20:33:47 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51459 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhBMBdq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 20:33:46 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 951CAB6525;
        Fri, 12 Feb 2021 20:33:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=myjOtIIkHCuA1UQiScg4zZvqcto=; b=EHOS4K
        MoCxQJpF1YkCTzMhQ2ylVQCL6V5Uw5SQzhLsvBynKQLZDBC23BXMyAJKYRh4hLca
        sb+lYRrw2r0OfDQeyWU+Z15lD4NzLiU2flWwuiN/eruMCsGfDvwTJ0twZF+j6/gc
        Uafw1j0hQD+Z/CpsOxww3xZ7jou5CauozhSgg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j7yYmGtVW9uECJhsVox8HU8+fveuiLah
        Coywg0THbVgqgaOR4zFG4u4naD/tt8BXpnlDi5Pw7ZEvOYeCfKN2hIxskIa+g8vs
        A9GkHOTGUtz351lH4ySv7JWHsu5FqJ01gzb3TZOIvI5EJv8+IRq9Ew5YXx2k3ZHD
        UFOF88BsWFA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C1C7B6523;
        Fri, 12 Feb 2021 20:33:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E88D9B6522;
        Fri, 12 Feb 2021 20:33:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 2/5] diffcore-rename: compute basenames of all source
 and dest candidates
References: <pull.843.v2.git.1612870326.gitgitgadget@gmail.com>
        <pull.843.v3.git.1612970140.gitgitgadget@gmail.com>
        <4fff9b1ff57b62587b1cbec2031f96199a214702.1612970140.git.gitgitgadget@gmail.com>
Date:   Fri, 12 Feb 2021 17:32:59 -0800
In-Reply-To: <4fff9b1ff57b62587b1cbec2031f96199a214702.1612970140.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Wed, 10 Feb 2021
        15:15:37 +0000")
Message-ID: <xmqqy2fsu4z8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 68C0AF54-6D9B-11EB-B367-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +MAYBE_UNUSED
> +static int find_basename_matches(struct diff_options *options,
> +				 int minimum_score,
> +				 int num_src)
> +{
> +	int i;
> +	struct strintmap sources;
> +	struct strintmap dests;
> +
> +	/* Create maps of basename -> fullname(s) for sources and dests */
> +	strintmap_init_with_options(&sources, -1, NULL, 0);
> +	strintmap_init_with_options(&dests, -1, NULL, 0);
> +	for (i = 0; i < num_src; ++i) {
> +		char *filename = rename_src[i].p->one->path;
> +		const char *base;
> +
> +		/* exact renames removed in remove_unneeded_paths_from_src() */
> +		assert(!rename_src[i].p->one->rename_used);
> +
> +		/* Record index within rename_src (i) if basename is unique */
> +		base = get_basename(filename);
> +		if (strintmap_contains(&sources, base))
> +			strintmap_set(&sources, base, -1);
> +		else
> +			strintmap_set(&sources, base, i);
> +	}
> +	for (i = 0; i < rename_dst_nr; ++i) {
> +		char *filename = rename_dst[i].p->two->path;
> +		const char *base;
> +
> +		if (rename_dst[i].is_rename)
> +			continue; /* involved in exact match already. */
> +
> +		/* Record index within rename_dst (i) if basename is unique */
> +		base = get_basename(filename);
> +		if (strintmap_contains(&dests, base))
> +			strintmap_set(&dests, base, -1);
> +		else
> +			strintmap_set(&dests, base, i);
> +	}
> +
> +	/* TODO: Make use of basenames source and destination basenames */

;-)

So at this point sources and dests can be used to quickly look up,
given a filename, if there is a single src among all sources, and a
single dst among all dests, that have the filename.

I wonder if the second loop over destinations can be "optimized"
further by using the sources map, though.  The reason you quash
entries with -1 when you see second instance of the same name is
because you intend to limit the heuristics only to a uniquely named
file among the removed files going to a uniquely named file among
the added files, right?  So even if a name is unique among dests,
if that name has duplicates on the source side, there is no point
recording its location.  i.e.

	/* record index within dst if it is unique in both dst and src */
	base = get_basename(filename);
	if (strintmap_contains(&sources, base) ||
	    strintmap_contains(&dests, base))
		strintmap_set(&dests, base, -1);
	else
		strintmap_set(&dests, base, i);

perhaps?

I guess it depends on what actually will be written in this "TODO"
space how effective such a change would be.  Presumably, you'd
iterate over &sources while skipping entries that record -1, to
learn (basename, i), and use the basename found there to consult
&dests to see if it yields a non-negative integer j, to notice that
rename_src[i] is a good candidate to match rename_dst[j].  If that
is the case, then such a change won't help as an optimization at
all, as we'd need to consult &dests map with the basename anyway,
so let's scratch the above idea.

In any case, after we walk over rename_src[] and rename_dst[] once,
the number of entries in &sources would be smaller than rename_src[]
so iterating over &sources, hunting for entries that record
non-negative index into rename_src[] would hopefully be cheaper than
the naive loop we've been working with.  I like the idea of using the
strintmap for this part of the code.

Thanks.


> +	strintmap_clear(&sources);
> +	strintmap_clear(&dests);
> +
> +	return 0;
> +}
> +
>  #define NUM_CANDIDATE_PER_DST 4
>  static void record_if_better(struct diff_score m[], struct diff_score *o)
>  {
