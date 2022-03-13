Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316B5C433EF
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 19:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbiCMTmc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 15:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbiCMTmc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 15:42:32 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC24846660
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 12:41:23 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B5C9611DF52;
        Sun, 13 Mar 2022 15:41:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=afXhkHckx5CkQRWdZMyJ/PpFCW3ScachO9fP3r
        1iAqI=; b=awsY7ZqSed4A1CBU3gGRkpq5UW1hes7ldl5DvCGFf16sT6VOljlHmF
        DyaPuSatbfF3o05yDYMRDslPLH7YFe+K9Z2+SfBBQf2eqegTxJVfD3K7z0Dt80Oh
        grJrnAG4wblZjxZqMAN/QC05mIuoTyUtDlglAMnktAd9RFyzglrk0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AD17411DF51;
        Sun, 13 Mar 2022 15:41:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1D29911DF4F;
        Sun, 13 Mar 2022 15:41:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH] partial-clone: add a partial-clone test case
References: <pull.1175.git.1647193162570.gitgitgadget@gmail.com>
Date:   Sun, 13 Mar 2022 19:41:21 +0000
In-Reply-To: <pull.1175.git.1647193162570.gitgitgadget@gmail.com> (Abhradeep
        Chakraborty via GitGitGadget's message of "Sun, 13 Mar 2022 17:39:22
        +0000")
Message-ID: <xmqq4k41vdwe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8F9EAFCC-A305-11EC-8332-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
>
> In a blobless-cloned repo, `git log --follow -- <path>` (`<path>` have
> an exact OID rename) doesn't download blob of the file from where the
> new file is renamed.

Is this "doesn't" (documenting current behaviour, without saying if
it is wrong or is desired) or "shouldn't" (documenting the desired
behaviour, which the current implementation may or may not satisfy)?

> +test_expect_success 'git log --follow does not download blobs if an exact OID rename found (blobless clone)' '

That's mouthful.

> +	rm -rf repo partial.git &&
> +	test_create_repo repo &&
> +	content="some dummy content" &&
> +	test_commit -C repo create-a-file file.txt "$content" &&
> +	git -C repo mv file.txt new-file.txt &&
> +	git -C repo commit -m rename-the-file &&
> +	test_config -C repo uploadpack.allowfilter 1 &&
> +	test_config -C repo uploadpack.allowanysha1inwant 1 &&
> +
> +	git clone --filter=blob:none "file://$(pwd)/repo" partial.git &&
> +	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
> +		git -C partial.git log --follow -- new-file.txt > "$(pwd)/trace.txt" &&

Lose SP after '>'.

		git -C partial.git log --follow -- new-file.txt >"$(pwd)/trace.txt" &&

> +	! test_subcommand_inexact fetch <trace.txt

Looking at the implementation of the helper, it seems to be prepared
to handle negation itself.  Shouldn't this be

	test_subcommand_inexact ! fetch <trace.txt

instead?

> +'
> +
>  test_expect_success 'lazy-fetch when accessing object not in the_repository' '
>  	rm -rf full partial.git &&
>  	test_create_repo full &&
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 0f439c99d61..07a2b60c103 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1811,7 +1811,7 @@ test_subcommand_inexact () {
>  		shift
>  	fi
>  
> -	local expr=$(printf '"%s".*' "$@")
> +	local expr=$(printf '.*"%s".*' "$@")

The original wanted to make sure that the arguments to the helper
are initial items of a comma separated list, and an existing caller,
for example, i.e.

  test_subcommand_inexact git pack-objects --honor-pack-keep <trace

is relying on the behaviour to make sure 'git', 'pack-objects', ...
appear at the beginning of "[...]" enclosed list.  This change
breaks its ability to notice that an insertion of unrelated token
before 'git' as an error.

In other words, it looks like an uncalled-for selfish change.

Why can't you specify what should NOT come before "fetch" in your
use of this helper?

>  	expr="${expr%,}"

The preimage already has this problem, but the stripping of trailing
comma here is a result of mistaken copy-and-paste from the exact
variant, I think.  test_subcommand uses

	local expr=$(printf '"%s",' "$@")

to concatenate "$@" into a single comma-separated string, so it
perfectly makes sense to drop the last one here, but with or without
your change here, neither is adding a comma that need to be
stripped.


It is not _your_ theme, but I think this helper is poorly designed,
especially compared to the original "exact" variant.

        test_subcommand_inexact () {
                local negate=
                if test "$1" = "!"
                then
                        negate=t
                        shift
                fi

                local expr=$(printf '"%s".*' "$@")
                expr="${expr%,}"

                if test -n "$negate"
                then
                        ! grep "\"event\":\"child_start\".*\[$expr\]"
                else
                        grep "\"event\":\"child_start\".*\[$expr\]"
                fi
        }


I've already touched that "${expr%,}" there is a totally useful
statement that will always be a no-op.

When "test_subcommand_inexact git pack-objects" is run, the printf
assigns to $expr:

		expr='"git".*"pack-objects".*'

and the actual grep command invoked becomes

	grep '"event":"child_start".*\["git".*"pack-objects".*\]'

I am not sure if that is what we really want.

I wonder if it was more like this that the original wanted to grep for:

	grep '"event":"child_start".*\["git","pack-objects",.*\]'

in which case the two lines there should be more like

	local expr=$(printf '"%s",' "$@")
	expr="${expr%,}.*"

I would think.  This comes from Derrick's e4d0c11c (repack: respect
kept objects with '--write-midx -b', 2021-12-20).

