Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EFAE92FC2
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 20:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjJEU5E (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 16:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjJEU4u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 16:56:50 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781F81AC
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 13:56:48 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E163E1DDC7;
        Thu,  5 Oct 2023 16:56:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=nUY0rVfoeJqFVaR7nXMwEmQcbkCyEtSqssuPdc
        DDtOs=; b=aAOgqIfXgRYi8WimCC2HVlPI7Kj+tIJqWZWfp2l2PjxAqrlRAy7Ybf
        Xf96sfnUoQwkmyQShR0PVZvfLIni/fFjDsIfalf78Tnd5HLWEQOJLCGjGPlMK1R7
        Q+sbPGhx6tmT25st3MqeNSCSUohBG952dcaExLRGy7nBGzeSlIRSc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DA21C1DDC6;
        Thu,  5 Oct 2023 16:56:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 71A9A1DDC5;
        Thu,  5 Oct 2023 16:56:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] merge-ort: initialize repo in index state
In-Reply-To: <pull.1583.git.git.1696519349407.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Thu, 05 Oct 2023 15:22:29 +0000")
References: <pull.1583.git.git.1696519349407.gitgitgadget@gmail.com>
Date:   Thu, 05 Oct 2023 13:56:42 -0700
Message-ID: <xmqqv8bkhjp1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B1054454-63C1-11EE-9874-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> initialize_attr_index() does not initialize the repo member of
> attr_index. Starting in 44451a2e5e (attr: teach "--attr-source=<tree>"
> global option to "git", 2023-05-06), this became a problem because
> istate->repo gets passed down the call chain starting in
> git_check_attr(). This gets passed all the way down to
> replace_refs_enabled(), which segfaults when accessing r->gitdir.
>
> Fix this by initializing the repository in the index state.
>
> Signed-off-by: John Cai <johncai86@gmail.com>
> Helped-by: Christian Couder <christian.couder@gmail.com>
> ---

Nice spotting.

> +test_expect_success '3-way merge with --attr-source' '
> +	test_when_finished rm -rf 3-way &&
> +	git init 3-way &&
> +	(
> +		cd 3-way &&
> +		test_commit initial file1 foo &&
> +		base=$(git rev-parse HEAD) &&
> +		git checkout -b brancha &&
> +		echo bar>>file1 &&

We need a space before but not after ">>".

> +		git commit -am "adding bar" &&
> +		source=$(git rev-parse HEAD) &&
> +		echo baz>>file1 &&

Ditto.

> +		git commit -am "adding baz" &&
> +		merge=$(git rev-parse HEAD) &&

Sorry, but I got lost.  We have the $base commit on the default
initial branch, from which forked branch-A which we created two
commits to add lines "bar" and "baz" to file1.  We are calling the
tip of this branch-A $merge, and the parent of $merge is called
$source.

> +		test_must_fail git --attr-source=HEAD merge-tree -z --write-tree \
> +		--merge-base "$base" --end-of-options "$source" "$merge" >out &&

So, is this asking "merge-tree" to merge "$source" and "$merge", one
of which is the direct parent of the other one?  Aren't we missing a
"checkout @{-1}" before we add "baz" or something?

If the attitude taken by this test is "we do not really care if the
attempted merge is meaningless and would never happen in the real
world, as the only thing we care is to see "git" not to segfault",
then we probably shouldn't even check ...

> +		grep "Merge conflict in file1" out

... if we failed due to conflict with a "grep" like this.  As "out"
is a binary file (thanks to the use of "-z" on the command line of
"merge-tree" invocation), I am not sure if you can rely on "grep" to
find this error message in 'out', depending on your implementation
of "grep".

On the other hand, the new test can do a more realistic merge
between two commits, where having an attribute in some tree object
(which preferrably is *not* HEAD and .gitattribute does not exist in
the working tree) given to the --attr-source option does make a
difference, and verify the contents of the "file1" recorded in the
resulting tree.  That way, the test can verify that the attributes
are read from the right place without segfaulting.

> +	)
> +'
> +
>  test_expect_success 'file change A, B (same)' '
>  	git reset --hard initial &&
>  	test_commit "change-a-b-same-A" "initial-file" "AAA" &&
>
> base-commit: 493f4622739e9b64f24b465b21aa85870dd9dc09

Thanks.
