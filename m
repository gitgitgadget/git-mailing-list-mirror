Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DFDC433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 18:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbiCASES (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiCASEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 13:04:16 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2515205C4
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 10:03:32 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4126610F74B;
        Tue,  1 Mar 2022 13:03:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jYSs0dgGyNu4PxlVlTiKwjQhavaujtiXpkNfxG
        DJajQ=; b=oQik55YDdvhmUEvNu3e+kxdeyTYdz7b15LRee3VuokhIG8uC5n4ZFE
        ypkfsxTw364BYjSN0M5PL7TyOxlvX3O5hiNvJD9UJM1emWP7FURD57Hg23Am7Kom
        fdpMrCYLwaxRI8khSQipsiynrC/UFWLWZvtRAmUV9/97tWhV+8NtE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 38E9A10F74A;
        Tue,  1 Mar 2022 13:03:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6F41810F749;
        Tue,  1 Mar 2022 13:03:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH v2 2/2] t7063: mtime-mangling instead of delays in
 untracked cache testing
References: <pull.1166.git.1646041236.gitgitgadget@gmail.com>
        <pull.1166.v2.git.1646127910.gitgitgadget@gmail.com>
        <3e3c9c7faace505958aa01ff82bef5fad3204c67.1646127910.git.gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 10:03:30 -0800
In-Reply-To: <3e3c9c7faace505958aa01ff82bef5fad3204c67.1646127910.git.gitgitgadget@gmail.com>
        (Tao Klerks via GitGitGadget's message of "Tue, 01 Mar 2022 09:45:10
        +0000")
Message-ID: <xmqqk0ddr1n1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E77A001E-9989-11EC-82A8-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +chmtime_worktree_root () {
> +	# chmtime doesnt handle relative paths on windows, so need
> +	# to "hardcode" a reference to the worktree folder name.
> +	test-tool -C .. chmtime $1 worktree
> +}
> +

Enclose $1 in a pair of double-quotes to help readers.  They do not
have to wonder if the caller is interested in (or has to worry
about) triggering word splitting at $IFS if you did so.

>  avoid_racy() {
>  	sleep 1
>  }
> @@ -90,6 +96,9 @@ test_expect_success 'setup' '
>  	cd worktree &&
>  	mkdir done dtwo dthree &&
>  	touch one two three done/one dtwo/two dthree/three &&
> +	test-tool chmtime =-300 one two three done/one dtwo/two dthree/three &&
> +	test-tool chmtime =-300 done dtwo dthree &&
> +	chmtime_worktree_root =-300 &&

I am wondering if it is better to spelling it out like this:

	test-tool -C.. chmtime =-300 worktree &&

instead of hiding the fact that "../worktree" is being touched
behind a one-line helper.  Being able to explicitly write "worktree"
in the context that this particular code path uses the "worktree"
directory is a big plus, but at the same time, bypassing the helper
makes it unclear why we just don't chmtime "../worktree", and will
strongly tempt future developers into breaking it, so, I dunno.

What's the reason why utime() works only on a path in the current
directory and cannot take "../worktree" again?  If we cannot solve
that, I guess an extra helper with a big comment, like we see in
this patch, would be the least bad solution.

Thanks.
