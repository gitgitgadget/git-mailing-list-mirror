Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9C5CD613F
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 21:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378803AbjJIVl7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 17:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378784AbjJIVl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 17:41:57 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C541A3
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 14:41:56 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 528B81BC3EF;
        Mon,  9 Oct 2023 17:41:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=J6xiFFPhrIc7i3Hv3kAogSAUKSivWcO9pwjGXn
        3/Krk=; b=W2qTob4h3kT9NNRyHpxgQx42IKb4GVioBL4js0pSn7/Nz8PXTe4GO1
        DFIHNdVJsArC8HcEkdkYKCES/ID6EUE/LVcwqAU0YVytVJI9WlUAQB2H3PXgwr+C
        ejKESUs7JNeu4jJ05JZbGWEnJreGzex77it2iFXRxQBD/GmoRsF8E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 49DF91BC3EE;
        Mon,  9 Oct 2023 17:41:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9B9B81BC3EC;
        Mon,  9 Oct 2023 17:41:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3] merge-ort: initialize repo in index state
In-Reply-To: <pull.1583.v3.git.git.1696857660374.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Mon, 09 Oct 2023 13:21:00 +0000")
References: <pull.1583.v2.git.git.1696781998420.gitgitgadget@gmail.com>
        <pull.1583.v3.git.git.1696857660374.gitgitgadget@gmail.com>
Date:   Mon, 09 Oct 2023 14:41:53 -0700
Message-ID: <xmqq4jizxyla.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA0F8BAE-66EC-11EE-B15D-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     Fix this by initializing the repository in the index state.
>     
>     Changes since V2:
>     
>      * fixed test by using printf instead of echo

Much better than using unportable \n with echo.

>      -+		echo "foo\nbar\nbaz" >expect &&
>      ++		printf "foo\nbar\nbaz\n" >expect &&

But if we are using printf, it would be easier to read lines
separately, which would look more like

	printf "%s\n" foo bar baz >expect

And we have

	test_write_lines foo bar baz >expect

to make it even more discoverable.

>       +		git cat-file -p "$tree:file1" >actual &&
>       +		test_cmp expect actual
>       +	)
>
>
>  merge-ort.c           |  1 +
>  t/t4300-merge-tree.sh | 27 +++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 7857ce9fbd1..36537256613 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -1902,6 +1902,7 @@ static void initialize_attr_index(struct merge_options *opt)
>  	struct index_state *attr_index = &opt->priv->attr_index;
>  	struct cache_entry *ce;
>  
> +	attr_index->repo = opt->repo;
>  	attr_index->initialized = 1;
>  
>  	if (!opt->renormalize)
> diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
> index 57c4f26e461..c3a03e54187 100755
> --- a/t/t4300-merge-tree.sh
> +++ b/t/t4300-merge-tree.sh
> @@ -86,6 +86,33 @@ EXPECTED
>  	test_cmp expected actual
>  '
>  
> +test_expect_success '3-way merge with --attr-source' '
> +	test_when_finished rm -rf 3-way &&
> +	git init 3-way &&
> +	(
> +		cd 3-way &&
> +		test_commit initial file1 foo &&
> +		base=$(git rev-parse HEAD) &&
> +		git checkout -b brancha &&
> +		echo bar >>file1 &&
> +		git commit -am "adding bar" &&
> +		source=$(git rev-parse HEAD) &&
> +		git checkout @{-1} &&
> +		git checkout -b branchb &&
> +		echo baz >>file1 &&
> +		git commit -am "adding baz" &&
> +		merge=$(git rev-parse HEAD) &&
> +		git checkout -b gitattributes &&
> +		test_commit "gitattributes" .gitattributes "file1 merge=union" &&

OK, the branch "gitattributes" will be used to drive merge of file1
using the union merge to avoid conflicting.

> +		git checkout @{-1} &&

But such attribute will only be available in that branch, not in the
checked out working tree.  And then

> +		tree=$(git --attr-source=gitattributes merge-tree --write-tree \
> +		--merge-base "$base" --end-of-options "$source" "$merge") &&

we use the gitattributes branch as the tree-ish to take the
attribute information from.  Makes sense.

> +		printf "foo\nbar\nbaz\n" >expect &&

I'll squash in the "test_write_lines" change while queuing.

> +		git cat-file -p "$tree:file1" >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
>  test_expect_success 'file change A, B (same)' '
>  	git reset --hard initial &&
>  	test_commit "change-a-b-same-A" "initial-file" "AAA" &&
>
> base-commit: 493f4622739e9b64f24b465b21aa85870dd9dc09

Thanks.  Looking good.
