Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E39C433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 17:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377171AbiCYRIq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 13:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358056AbiCYRIn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 13:08:43 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38098E615B
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:07:09 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DD68310F007;
        Fri, 25 Mar 2022 13:07:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=e9/0HF4kUwjuCAwRSq4kdMcPyXYqoqj2XLRPS8
        +G2uM=; b=AOvAAhBIhSV/qtSvILxSVHkCVqk6eE2vP9XIWq1GwNn6Aicvmh3hri
        tZQxU0YEj05wlbYA3oX1LXBRm42vKAmnfagNx5xtk6mRjzErCsMunE7uEhNmhB+7
        TvQfJPc49745PTvfBq3/kYPWlKRzB0fmSUBfXBkCNKgtbB0L2otU8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A085510F006;
        Fri, 25 Mar 2022 13:07:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C494410F005;
        Fri, 25 Mar 2022 13:07:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, chakrabortyabhradeep79@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 1/2] t7700: check post-condition in kept-pack test
References: <pull.1185.git.1647894845421.gitgitgadget@gmail.com>
        <pull.1185.v2.git.1648146897.gitgitgadget@gmail.com>
        <f2f8d12929bcbd630b2de3ce770a6763989ffcff.1648146897.git.gitgitgadget@gmail.com>
Date:   Fri, 25 Mar 2022 10:07:04 -0700
In-Reply-To: <f2f8d12929bcbd630b2de3ce770a6763989ffcff.1648146897.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 24 Mar 2022
        18:34:56 +0000")
Message-ID: <xmqqmthearlz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FF723E16-AC5D-11EC-B346-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +get_sorted_objects_from_packs () {
> +	git show-index <$(cat) >raw &&
> +	cut -d" " -f2 raw | sort
> +}

As pointed out by Taylor, this "the standard input gives us the name
of a file to be read" looks strange.  It may work, and it may even
give the easiest interface to use by all the callers, but if we were
designing a more generic helper function suitable to be added to the
test-lib*.sh, we wouldn't design it like so---instead it would be
either "we read the contents of the .idx file from the standard
input" or "the first argument is the name of the .idx file".

>  test_expect_success '--write-midx -b packs non-kept objects' '
> +	git init repo &&
> +	test_when_finished "rm -fr repo" &&
> +	(
> +		cd repo &&
> +
> +		# Create a kept pack-file
> +		test_commit base &&
> +		git repack -ad &&
> +		find $objdir/pack -name "*.idx" >before &&
> +		>$objdir/pack/$(basename $(cat before) .idx).keep &&

We probably want to sanity check "repack -a" by insisting "before"
has found exactly one .idx file, before using it this way.

		test_line_count = 1 before &&
		before=$(cat before) &&
		>"${before%.idx}.keep"

> +		# Create a non-kept pack-file
> +		test_commit other &&
> +		git repack &&
> +
> +		# Create loose objects
> +		test_commit loose &&
> +
> +		# Repack everything
> +		git repack --write-midx -a -b -d &&
> +
> +		# There should be two pack-files now, the
> +		# old, kept pack and the new, non-kept pack.
> +		find $objdir/pack -name "*.idx" | sort >after &&
> +		test_line_count = 2 after &&

OK.  "after" gets sorted because we will pass it to "comm" later.

> +		find $objdir/pack -name "*.keep" >kept &&
> +		test_line_count = 1 kept &&

Since we've made sure "before" is a one-liner earlier, we could just
say

		test_cmp before kept &&

instead, no?

> +		# Get object list from the kept pack.
> +		get_sorted_objects_from_packs \
> +			<before \
> +			>old.objects &&
		
OK.

> +		# Get object list from the one non-kept pack-file
> +		comm -13 before after >new-pack &&

OK.  This should give only one line of output but that is merely
assumed.  We know after has 2 and before has 1, but haven't made
sure that before is a subset of after.

		test_line_count = 1 new-pack &&

> +		get_sorted_objects_from_packs \
> +			<new-pack \
> +			>new.objects &&

OK.

> +		# None of the objects in the new pack should
> +		# exist within the kept pack.
> +		comm -12 old.objects new.objects >shared.objects &&

Great.

> +		test_must_be_empty shared.objects
> +	)
>  '
>  
>  test_expect_success TTY '--quiet disables progress' '
