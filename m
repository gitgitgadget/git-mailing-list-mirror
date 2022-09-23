Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5357C04A95
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 17:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiIWRFh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 13:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbiIWRFe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 13:05:34 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DF412BDBE
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 10:05:32 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EF08A1B7C3D;
        Fri, 23 Sep 2022 13:05:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VjwBK8M+yZRbf03lf3gzI/YE84MGurW9xWd6dF
        FsAn4=; b=WSbLGAi8OQhYqljEEDYzWXq7SoZdEUQxon/IB8wsV1riDM+4FiYln1
        2JhIVH7IK+VYXmuQ7rPTIPP0G0VjVxr9yABOKi8kpmDbbKRArNsKCaBh3weTzWgD
        LnHC1iKkqOCjn12q4AAE4u4w4bwIfoiKm02q0UB9KdJcyyXQYJXfo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CFC671B7C3C;
        Fri, 23 Sep 2022 13:05:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 674941B7C3A;
        Fri, 23 Sep 2022 13:05:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, me@ttaylorr.com,
        chakrabortyabhradeep79@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] pack-bitmap: remove trace2 region from hot path
References: <pull.1365.git.1663938034607.gitgitgadget@gmail.com>
Date:   Fri, 23 Sep 2022 10:05:27 -0700
In-Reply-To: <pull.1365.git.1663938034607.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Fri, 23 Sep 2022 13:00:34
        +0000")
Message-ID: <xmqqpmfmuilk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EC85733E-3B61-11ED-BDE3-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:


> -		trace2_region_enter("pack-bitmap", "reading_lookup_table", the_repository);
>  		/* NEEDSWORK: cache misses aren't recorded */
>  		bitmap = lazy_bitmap_for_commit(bitmap_git, commit);
> -		trace2_region_leave("pack-bitmap", "reading_lookup_table", the_repository);
>  		if (!bitmap)
>  			return NULL;
>  		return lookup_stored_bitmap(bitmap);

As "git blame" is bad in finding a piece of code that no longer
exists, it may make sense to leave a comment around here why we do
not have a trace2 region around this call, perhaps?

+	/* do not add trace2_region around here in the hot path */
	bitmap = lazy_bitmap_for_commit(...);

or something?

Thanks.
