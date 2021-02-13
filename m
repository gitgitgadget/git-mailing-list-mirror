Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D8EC433E0
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 01:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA75F64E8E
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 01:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhBMBtM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 20:49:12 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63003 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhBMBtL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 20:49:11 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C5F1BB6704;
        Fri, 12 Feb 2021 20:48:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lbTHvUHb+FNVYPgAWdDCjg+gPXw=; b=ctoLga
        4GREgCAfW0TtDWu9cpdKrwBMpcpN9w2jhfXbsGbj41ls1QT1hIwxraMRW28Sxtq9
        9Y4ZuvbLzwBEvOt14Ualmd0k8jToXFdul2UQJTuO3+hqcHN2lQazfRFgezFMij7E
        phlG1OfzP3Df04R9g7HLgClN65K3aYcf1ajfk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bHWekO89pfHDm32/cpPXfoYoZ39JI6GH
        q6DD6R3BUOhKLo7Ui7UOhq1KKjlvtWbOZGK784Hp0hG6fa9yBj1uOfqdiH9JD84+
        eZp4BqsgMrYHwPqcIQ9YbL6z6tXYjTkp1M4lUZD0u51aHfO9VxQDIYu2I8+KCnIB
        xUbchWZNGR0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AE190B6703;
        Fri, 12 Feb 2021 20:48:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 266BDB6702;
        Fri, 12 Feb 2021 20:48:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 3/5] diffcore-rename: complete find_basename_matches()
References: <pull.843.v2.git.1612870326.gitgitgadget@gmail.com>
        <pull.843.v3.git.1612970140.gitgitgadget@gmail.com>
        <dc26881e4ed3447c6efdcd492463be294f99b8c4.1612970140.git.gitgitgadget@gmail.com>
Date:   Fri, 12 Feb 2021 17:48:25 -0800
In-Reply-To: <dc26881e4ed3447c6efdcd492463be294f99b8c4.1612970140.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Wed, 10 Feb 2021
        15:15:38 +0000")
Message-ID: <xmqqsg60u49i.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 90379C30-6D9D-11EB-9683-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	/* Now look for basename matchups and do similarity estimation */
> +	for (i = 0; i < num_src; ++i) {
> +		char *filename = rename_src[i].p->one->path;
> +		const char *base = NULL;
> +		intptr_t src_index;
> +		intptr_t dst_index;
> +
> +		/* Find out if this basename is unique among sources */
> +		base = get_basename(filename);
> +		src_index = strintmap_get(&sources, base);
> +		if (src_index == -1)
> +			continue; /* not a unique basename; skip it */
> +		assert(src_index == i);
> +
> +		if (strintmap_contains(&dests, base)) {
> +			struct diff_filespec *one, *two;
> +			int score;
> +
> +			/* Find out if this basename is unique among dests */
> +			dst_index = strintmap_get(&dests, base);
> +			if (dst_index == -1)
> +				continue; /* not a unique basename; skip it */

It would be a lot easier to read if "we must have the same singleton
in dests" in a single if condition, I suspect.  I.e.

		if (strintmap_contains(&dests, base) &&
		    0 <= (dst_index = (strintmap_get(&dests, base)))) {

It is a bit sad that we iterate over rename_src[] array, even though
we now have a map that presumably have fewer number of entries than
the original array, though.

> +			/* Ignore this dest if already used in a rename */
> +			if (rename_dst[dst_index].is_rename)
> +				continue; /* already used previously */

Since we will only be matching between unique entries in src and
dst, this "this has been used, so we cannot use it" will not change
during this loop.  I wonder if the preparation done in the previous
step, i.e. [PATCH v3 2/5], can take advantage of this fact, i.e.  a
dst that has already been used (in the previous "exact" step) would
not even have to be in &dests map, so that the strintmap_contains()
check can reject it much earlier.

Stepping back a bit, it appears to me that [2/5] and [3/5] considers
a source file having unique basename among the sources even if there
are many such files with the same basename, as long as all the other
files with the same basename have been matched in the previous
"exact" phase.  It probably does the same thing for destination
side.

Intended?

It feels incompatible with the spirit of these two steps aim for
(i.e. only use this optimization on a pair of src/dst with UNIQUE
basenames).  For the purpose of "we only handle unique ones", the
paths that already have matched should participate in deciding if
the files that survived "exact" phase have unique basename among
the original inpu?

Thanks.

