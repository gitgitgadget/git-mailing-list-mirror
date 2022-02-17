Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8847C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 18:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243969AbiBQSIJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 13:08:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239522AbiBQSII (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 13:08:08 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3D115DB28
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 10:07:51 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 932C2101ED1;
        Thu, 17 Feb 2022 13:07:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MDKJB6aNro1mtOe+3WlQDuMWJGX8IBfoZz0+iz
        ZUgAI=; b=SLGmqqGzORqrjlWBQGeodNdcfu2vKiPwN8CkWuYYK7E/+rjVs6b06F
        E0OITa55jcz2HJqFmQ45PBcPp4pQbwz4jpiWE9Zr/CFQoClL8s5ErqH+6ZT/wO4W
        Ol75fMxv+7ouZFLm25iN5/Sdf1ksCa3cc6Mfv9f1LIVYzIEwPYSyE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8AD42101ED0;
        Thu, 17 Feb 2022 13:07:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F06BE101ECE;
        Thu, 17 Feb 2022 13:07:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 4/5] sparse-checkout: error or warn when given
 individual files
References: <pull.1118.v3.git.1644985283.gitgitgadget@gmail.com>
        <pull.1118.v4.git.1645080889.gitgitgadget@gmail.com>
        <1fdebc1953fcc30a6a08b3efd62dcdb31f7e4704.1645080889.git.gitgitgadget@gmail.com>
Date:   Thu, 17 Feb 2022 10:07:48 -0800
In-Reply-To: <1fdebc1953fcc30a6a08b3efd62dcdb31f7e4704.1645080889.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Thu, 17 Feb 2022
        06:54:48 +0000")
Message-ID: <xmqqtucx9xjf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 849DE8AA-901C-11EC-820D-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  		int prefix_len = strlen(prefix);
>  
>  		if (!core_sparse_checkout_cone)
> @@ -703,20 +706,44 @@ static void sanitize_paths(int argc, const char **argv, const char *prefix)
>  		for (i = 0; i < argc; i++)
>  			argv[i] = prefix_path(prefix, prefix_len, argv[i]);
>  	}
> +
> +	if (skip_checks)
> +		return;

The placement of skip-checks here makes the earier die() between the
hunks in this block unskippable.

> +	for (i = 0; i < argc; i++) {
> +		struct cache_entry *ce;
> +		struct index_state *index = the_repository->index;
> +		int pos = index_name_pos(index, argv[i], strlen(argv[i]));
> +
> +		if (pos < 0)
> +			continue;

I _think_ the intent for this is to catch possbily common mistakes
rather than a hard rule, so while an unmerged path will evade this
check, I think it is an acceptable trade-off between code simplicity
and thoroughness.

> +		ce = index->cache[pos];
> +		if (S_ISSPARSEDIR(ce->ce_mode))
> +			continue;
> +
> +		if (core_sparse_checkout_cone)
> +			die(_("\"%s\" is not a directory; to treat it as a directory anyway, rerun with --skip-checks"), argv[i]);
> +		else
> +			warning(_("pass a leading slash before paths such as \"%s\" if you want a single file (see NON-CONE PROBLEMS in the git-sparse-checkout manual)."), argv[i]);
> +	}

Hmph. The skip_checks flag was introduced exactly so that what the
code catches as a possible problem is a false alarm, no?  I would
understand if both were die() to be conservative, of both were
warning() to be lenient, but one being die() and the other being
warning() makes this look somewhat uneven.

Besides, being leninent here somewhat defeats the point of having
skip_checks, no?  As long as we believe skip_checks option is useful,
shouldn't these be die() to be equally conservative?

