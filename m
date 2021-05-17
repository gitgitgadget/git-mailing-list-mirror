Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8934DC433B4
	for <git@archiver.kernel.org>; Mon, 17 May 2021 22:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C398611B0
	for <git@archiver.kernel.org>; Mon, 17 May 2021 22:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242772AbhEQWPT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 18:15:19 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63211 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbhEQWPS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 18:15:18 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 872B5134675;
        Mon, 17 May 2021 18:14:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4/X3hv3KMj24hkJ5/K/HsdI8EE7pJdmbYzyDJ7
        0vz04=; b=wuuxHhz0qJAFPOCxrs0h/1pa7PuzIWBt39mrN17lV6NbAwnAdP42JR
        cKbG/bitq2O/fP3njykzNTDFFr6IVNaRz73KrZuDoCrybs1g1m2nSGjUD7JWqfFJ
        KnGDfemfgeW5R6PR4orCfxt+QaVWoeZmjteOGch/G1UyRBxD/UlHc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7F09A134674;
        Mon, 17 May 2021 18:14:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B68A8134672;
        Mon, 17 May 2021 18:13:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, stolee@gmail.com,
        git@jeffhostetler.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 3/4] read-cache: use hashfile instead of git_hash_ctx
References: <pull.916.git.1616785928.gitgitgadget@gmail.com>
        <pull.916.v2.git.1621254292.gitgitgadget@gmail.com>
        <b94172ccf5e91fe59a1d32774dbec23e624f1135.1621254292.git.gitgitgadget@gmail.com>
Date:   Tue, 18 May 2021 07:13:57 +0900
In-Reply-To: <b94172ccf5e91fe59a1d32774dbec23e624f1135.1621254292.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 17 May 2021
        12:24:51 +0000")
Message-ID: <xmqqfsyl57q2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D789482-B75D-11EB-8AE3-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> ...
> mult-pack-indexes, and commit-graphs. Therefore, it seems prudent to

multi-pack, I would say.

> There are still some remaining: the extension headers are hashed for use

some remaining what?  I first read an unwritten word as "issues",
but I think the answer is "uses of git_hash_ctx".

> in the End of Index Entries (EOIE) extension. This use of the
> git_hash_ctx is left as-is. There are multiple reasons to not use a
> hashfile here, including ...

> In addition to the test suite passing, I computed indexes using the
> previous binaries and the binaries compiled after this change, and found
> the index data to be exactly equal. Finally, I did extensive performance
> testing of "git update-index --force-write" on repos of various sizes,
> including one with over 2 million paths at HEAD. These tests
> demonstrated less than 1% difference in behavior, so the performance
> should be considered identical.

Hmph, does that mean 128k buffer is overkill and if we wanted to
unify the buffer sizes we should have used 8k instead?

Wait, the removal of fsync has made things faster in general, hasn't
it?  Did something else degrade performance to cancel that gain?

The patch looks an obvious improvement.  What was open-coded in
longhand is now a well structured series of API calls and the result
is much easier to follow and maintain.

Thanks.
