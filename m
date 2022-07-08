Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEDBC433EF
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 15:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238180AbiGHPlx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 11:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237919AbiGHPlw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 11:41:52 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4449261D6C
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 08:41:51 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C284143AF8;
        Fri,  8 Jul 2022 11:41:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=avh/Z28viOHhgrPYamcq8a2ZVJ/cgPu7X/0sR7
        mLQbI=; b=HAx4AQgcZqicNuIRivLcq797p4vyV57ctEGv3X/uzvDraI6Wl70pnE
        Qdzv+ZCVgzUSM6MGBlLnrsJ6kENuypweIVDSWesYqmhvJAJx/Z3WU4gtPgd0mYkr
        gLb2UrvpR/o/EwfBZKMGgJQFKaP+dxxtCmWZXh2IMrIVr8+fZmA7w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 61D9E143AF6;
        Fri,  8 Jul 2022 11:41:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A2D9A143AF5;
        Fri,  8 Jul 2022 11:41:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 2/3] clone: propagate empty remote HEAD even with
 other branches
References: <YsdyLS4UFzj0j/wB@coredump.intra.peff.net>
        <Ysdy+STDIhCZU05+@coredump.intra.peff.net>
Date:   Fri, 08 Jul 2022 08:41:47 -0700
In-Reply-To: <Ysdy+STDIhCZU05+@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 7 Jul 2022 19:57:45 -0400")
Message-ID: <xmqqedyvwr0k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7AB4A514-FED4-11EC-AE60-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So let's pull the HEAD setup out of this conditional entirely. This
> de-duplicates some of the code and the result is easy to follow, because
> helper functions like find_ref_by_name() do the right thing even in the
> empty-repo case (i.e., by returning NULL).

Nicely done.  The first stage becomes purely about optionally
fetching when there are some refs to fetch, and then we compute
where our HEAD should be separately.  Very clean.

> Rewritten in v2 to extract more of the logic. Bigger diff, but I think
> the end result is good. Try reading with "-w", as well.

I somehow found that the rendition with "-w" less easier to follow ;-)

> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> index 00ce9aec23..2b3a78b842 100755
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -250,6 +250,44 @@ test_expect_success 'bare clone propagates empty default branch' '
>  	grep "refs/heads/mydefaultbranch" file_empty_child.git/HEAD
>  '
>  
> +test_expect_success 'clone propagates unborn HEAD from non-empty repo' '
> +	test_when_finished "rm -rf file_unborn_parent file_unborn_child" &&
> +
> +	git init file_unborn_parent &&
> +	(
> +		cd file_unborn_parent &&
> +		git checkout -b branchwithstuff &&
> +		test_commit --no-tag stuff &&
> +		git symbolic-ref HEAD refs/heads/mydefaultbranch
> +	) &&
> +
> +	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
> +	git -c init.defaultBranch=main -c protocol.version=2 \
> +		clone "file://$(pwd)/file_unborn_parent" \
> +		file_unborn_child 2>stderr &&
> +	grep "refs/heads/mydefaultbranch" file_unborn_child/.git/HEAD &&

We know they do not have mydefaultbranch2 branch, so this grep may
be sufficient, but peeking into the implementation detail of HEAD is
not necessary.  The kosher way is way more verbose and awkward,
though:

	git -C file_unborn_child symbolic-ref HEAD >actual &&
	echo refs/heads/mydefaultbranch >expect &&
	test_cmp actual expect &&

I dunno.

> +	grep "warning: remote HEAD refers to nonexistent ref" stderr
> +'
> +
> +test_expect_success 'bare clone propagates unborn HEAD from non-empty repo' '
> +	test_when_finished "rm -rf file_unborn_parent file_unborn_child.git" &&
> +
> +	git init file_unborn_parent &&
> +	(
> +		cd file_unborn_parent &&
> +		git checkout -b branchwithstuff &&
> +		test_commit --no-tag stuff &&
> +		git symbolic-ref HEAD refs/heads/mydefaultbranch
> +	) &&
> +
> +	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
> +	git -c init.defaultBranch=main -c protocol.version=2 \
> +		clone --bare "file://$(pwd)/file_unborn_parent" \
> +		file_unborn_child.git 2>stderr &&
> +	grep "refs/heads/mydefaultbranch" file_unborn_child.git/HEAD &&

Likewise.

> +	! grep "warning:" stderr
> +'
> +
>  test_expect_success 'fetch with file:// using protocol v2' '
>  	test_when_finished "rm -f log" &&
