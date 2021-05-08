Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A936C433B4
	for <git@archiver.kernel.org>; Sat,  8 May 2021 10:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCEBF6143B
	for <git@archiver.kernel.org>; Sat,  8 May 2021 10:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhEHKOQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 06:14:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63111 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbhEHKOP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 May 2021 06:14:15 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 31A9FD45AD;
        Sat,  8 May 2021 06:13:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XFaiJoN5oJzXZA/OzzXXAfyBth2ju8jyMvWNE+
        JfaEg=; b=OyRlAaKrenS46wAFQ1uE7LaAchXgMNb9lJ+x568awt0WIzbJD1aTt+
        F5S4bv51Kf8v+pJnpPLGG+04JSLBAvKX5X5/apLAmMRFZRkGPW1XgDWeaJzbpk0g
        dVGQXiRH9+Rdz9V0A/gQBmwmhwyMFeUn5cWH6rcBTHMAOW7EhO+XM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 27E36D45AC;
        Sat,  8 May 2021 06:13:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A81C2D45AB;
        Sat,  8 May 2021 06:13:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/8] t7300: add testcase showing unnecessary
 traversal into ignored directory
References: <pull.1020.git.git.1620360300.gitgitgadget@gmail.com>
        <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
        <a3bd253fa8e8ae47d19beb35327d8283ffa49289.1620432500.git.gitgitgadget@gmail.com>
Date:   Sat, 08 May 2021 19:13:11 +0900
In-Reply-To: <a3bd253fa8e8ae47d19beb35327d8283ffa49289.1620432500.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Sat, 08 May 2021
        00:08:13 +0000")
Message-ID: <xmqqczu1v8i0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FF17BB1E-AFE5-11EB-AA76-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> PNPM is apparently creating deeply nested (but ignored) directory

Sorry, but what's PNPM?

> structures; traversing them is costly performance-wise, unnecessary, and
> in some cases is even throwing warnings/errors because the paths are too
> long to handle on various platforms.  Add a testcase that demonstrates
> this problem.
>
> Initial-test-by: Jason Gore <Jason.Gore@microsoft.com>
> Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t7300-clean.sh | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
> index a74816ca8b46..5f1dc397c11e 100755
> --- a/t/t7300-clean.sh
> +++ b/t/t7300-clean.sh
> @@ -746,4 +746,44 @@ test_expect_success 'clean untracked paths by pathspec' '
>  	test_must_be_empty actual
>  '
>  
> +test_expect_failure 'avoid traversing into ignored directories' '
> +	test_when_finished rm -f output error &&
> +	test_create_repo avoid-traversing-deep-hierarchy &&
> +	(
> +		cd avoid-traversing-deep-hierarchy &&
> +
> +		>directory-random-file.txt &&
> +		# Put this file under directory400/directory399/.../directory1/
> +		depth=400 &&
> +		for x in $(test_seq 1 $depth); do

Style.  Lose semicolon, have "do" on the next line on its own,
aligned with "for".  Tip: you shouldn't need any semicolon other
than the doubled ones in case/esac in your shell script.

> +			mkdir "tmpdirectory$x" &&
> +			mv directory* "tmpdirectory$x" &&
> +			mv "tmpdirectory$x" "directory$x"
> +		done &&
> +
> +		git clean -ffdxn -e directory$depth >../output 2>../error &&
> +
> +		test_must_be_empty ../output &&
> +		# We especially do not want things like
> +		#   "warning: could not open directory "
> +		# appearing in the error output.  It is true that directories
> +		# that are too long cannot be opened, but we should not be
> +		# recursing into those directories anyway since the very first
> +		# level is ignored.
> +		test_must_be_empty ../error &&
> +
> +		# alpine-linux-musl fails to "rm -rf" a directory with such
> +		# a deeply nested hierarchy.  Help it out by deleting the
> +		# leading directories ourselves.  Super slow, but, what else
> +		# can we do?  Without this, we will hit a
> +		#     error: Tests passed but test cleanup failed; aborting
> +		# so do this ugly manual cleanup...
> +		while test ! -f directory-random-file.txt; do

Ditto.

> +			name=$(ls -d directory*) &&
> +			mv $name/* . &&
> +			rmdir $name
> +		done

Hmph, after seeing the discussion thread of v1, I was expecting to
see a helper in Perl that cd's down and then comes back up while
removing what is in its directory (and I expected something similar
for creation side we saw above).

> +	)
> +'
> +
>  test_done
