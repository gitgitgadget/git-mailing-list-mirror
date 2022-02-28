Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CC5C433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 22:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbiB1WU2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 17:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiB1WU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 17:20:27 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF3420F5A
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 14:19:47 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 36C991061C3;
        Mon, 28 Feb 2022 17:19:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7eUR1lmm/8++1kv34qQ8X04/eSNvpRwktNUNFv
        A3pJM=; b=ldRAjiU5nxYMmUKBK95zTl+5zQSz41nSaqMy1k6UCTTDg8U7HGEO9u
        w6qLl0jEvjTtfXok0iMaR7T0vINyV9bfKdzJF3X9+5c6TFsrFBJJDMwUVRbMPaQQ
        X1JhMoL7YxCxX2N2nNtVN1MiECovlWBbmwUgJfPTedQ4FICvraUdA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D0DD1061C2;
        Mon, 28 Feb 2022 17:19:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8EBE01061C0;
        Mon, 28 Feb 2022 17:19:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH 2/2] t7063: mtime-mangling instead of delays in
 untracked cache testing
References: <pull.1166.git.1646041236.gitgitgadget@gmail.com>
        <a1806c56333ee96f9cda8c77ae56517181b691c0.1646041237.git.gitgitgadget@gmail.com>
Date:   Mon, 28 Feb 2022 14:19:45 -0800
In-Reply-To: <a1806c56333ee96f9cda8c77ae56517181b691c0.1646041237.git.gitgitgadget@gmail.com>
        (Tao Klerks via GitGitGadget's message of "Mon, 28 Feb 2022 09:40:36
        +0000")
Message-ID: <xmqqr17my6pq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 895AD0B2-98E4-11EC-8E5C-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Tao Klerks <tao@klerks.biz>
>
> The untracked cache test uses an avoid_racy function to deal with
> an mtime-resolution challenge in testing: If an untracked cache
> entry's mtime falls in the same second as the mtime of the index
> the untracked cache was stored in, then it cannot be trusted.
>
> Explicitly delaying tests is a simple effective strategy to
> avoid these issues, but should be avoided where possible.
>
> Switch from a delay-based strategy to instead backdating
> all file changes using test-tool chmtime, where that is an
> option, to shave 9 seconds off the test run time.

OK.

> Don't update test cases that delay for other reasons, for now at
> least (4 seconds).

Sad but one step at a time.

> +chmmtime_worktree_root () {

Not "chmtime_worktree_root"?  Is doubled-m intended?

> +	# chmtime doesnt handle relative paths on windows, so need
> +	# to "hardcode" a reference to the worktree folder name.
> +	cd .. &&
> +	test-tool chmtime $1 worktree &&
> +	cd worktree

An unsuspecting caller will be left in a directory it didn't expect
to when "test-tool chmtime" fails, which is not nice.

	(
		cd .. &&
		test-tool chmtime "$1" worktree
	)

at least until the tool learns to do

	test-tool chmtime "$1" ../worktree

or

	test-tool -C.. chmtime "$1" worktree

Oh, isn't the last one already available?

> +}
> +
>  avoid_racy() {
>  	sleep 1
>  }
> @@ -90,6 +98,9 @@ test_expect_success 'setup' '
>  	cd worktree &&
>  	mkdir done dtwo dthree &&
>  	touch one two three done/one dtwo/two dthree/three &&
> +	test-tool chmtime =-300 one two three done/one dtwo/two dthree/three &&
> +	test-tool chmtime =-300 done dtwo dthree &&

Not a huge deal, but it would have been very nice if "test-tool chmtime"
had a "-R" option to recurse into directories.
