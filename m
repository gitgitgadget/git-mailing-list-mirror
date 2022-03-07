Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A538C4332F
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 16:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240575AbiCGQ5H (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 11:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244344AbiCGQ5G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 11:57:06 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFD37E08B
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 08:56:11 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1114A10CCEB;
        Mon,  7 Mar 2022 11:56:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ye0CRYuoge5yOQNSJfD4wXTiTDIXxIIZxdkpbq
        TAt2U=; b=XIJMvgi7MRlrXpni5Qff+tXT4D3K/xCqFo+nQRvs3NDCq9LIRiwsS3
        DzoQAzB7LY5ZCd3qrRzO8hKVks4hQS6/sz9hl1yKWO2NiBzKeWqX72rxGAwW+ker
        6EIGsEwaSa5iBnStkf35tlzs4LxF0nesOwkoyF9EyvMGDnZ/vOEJo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 07B5610CCEA;
        Mon,  7 Mar 2022 11:56:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 68CE510CCE9;
        Mon,  7 Mar 2022 11:56:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com
Subject: Re: [PATCH 11/11] bundle: unbundle promisor packs
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
        <ec51d0a50e6e64ae37795d77f7d33204b9b71ecd.1645638911.git.gitgitgadget@gmail.com>
        <xmqqzgm5wafu.fsf@gitster.g>
        <ee6c7a5b-63e8-af1c-fdb7-75dca9cd798d@github.com>
Date:   Mon, 07 Mar 2022 08:56:09 -0800
In-Reply-To: <ee6c7a5b-63e8-af1c-fdb7-75dca9cd798d@github.com> (Derrick
        Stolee's message of "Mon, 7 Mar 2022 09:48:33 -0500")
Message-ID: <xmqqv8wpu2fq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D513F2E-9E37-11EC-BAE9-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> Of course, looking closer at it... "git bundle unbundle" doesn't
> actually store the refs directly in the refspace, but instead only
> outputs the refs that it used.

True.  I was more thinking about equivalence between

    cd src_repo
    git clone --no-local --filter=... . ../partial.network.cloned
    git bundle create --filter=... partial.bndl
    git clone partial.bndl ../partial.bundle.cloned

The two resulting repositories should look very similar except for
that the remote.origin.* of the former would expect that it pushes
back to where it was cloned from, while the latter would not.

> +		git init unbundled &&
> +		(
> +			cd unbundled &&
> +			# This creates the first pack-file in the
> +			# .git/objects/pack directory. Look for a .promisor.
> +			git bundle unbundle ../partial.bdl >ref-list.txt &&
> +			ls .git/objects/pack/pack-*.promisor >promisor &&
> +			test_line_count = 1 promisor

And can we enumerate the objects we have in .git/objects, both loose
and packed?

> +		) &&
> +
> +		git clone --filter=blob:none --mirror "file://$(pwd)" cloned &&
> +		git -C cloned for-each-ref \
> +			--format="%(objectname) %(refname)" >cloned-refs.txt &&
> +		echo "$(git -C cloned rev-parse HEAD) HEAD" >>cloned-refs.txt &&
> +		test_cmp cloned-refs.txt unbundled/ref-list.txt

Likewise here?  I think the two should match, and that was what I
was wondering if we should enforce.

>  	'
>  done
>  
> --- >8 ---
>
> I also attempted doing a "git clone --bare partial.bdl unbundled.git" to
> get the 'git clone' command to actually place the refs. However, 'git clone'
> does not set up the repository filter based on the bundle, so it reports
> missing blobs (even though there is no checkout).

Understandable, as cloning from a bundle, if I recall correctly, was
done as yet another special case in "git clone", differently from
the main "over the network" code path.  And from end-user's point of
view, I think updating it is part of introducing the filtered
bundle.

Thanks.
