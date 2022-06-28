Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68C1C433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 21:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiF1VJh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 17:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiF1VJg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 17:09:36 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B8035DF7
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 14:09:35 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C44C124731;
        Tue, 28 Jun 2022 17:09:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LJls2fUlLvM50lrSJb5ZT82blXjLH0k6kog13t
        rv3NI=; b=ghM7W19CYkypb3lR1cPAUUfxVJv8B/vcxi1UV/WgelUE7F9XLbSCpZ
        Z1f2xD9Enuu7CNYRq3GBaRkiVpxO3z11UDg8utf8fj6xIXJL829rsdunrS2smghq
        agjoQ3Q8KR78phsD79WgNTdCODb8CX9zT4NWxBh3+vo2BKR1jSesE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 91F91124730;
        Tue, 28 Jun 2022 17:09:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E625C12472E;
        Tue, 28 Jun 2022 17:09:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 6/8] rebase: add --update-refs option
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
        <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
        <918b398d6a2264a99acadd319f780c796bbafc18.1656422759.git.gitgitgadget@gmail.com>
Date:   Tue, 28 Jun 2022 14:09:32 -0700
In-Reply-To: <918b398d6a2264a99acadd319f780c796bbafc18.1656422759.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 28 Jun 2022
        13:25:57 +0000")
Message-ID: <xmqqbkucijg3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9BFF3384-F726-11EC-9BCE-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> When working on a large feature, it can be helpful to break that feature
> into multiple smaller parts that become reviewed in sequence. During
> development or during review, a change to one part of the feature could
> affect multiple of these parts. An interactive rebase can help adjust
> the multi-part "story" of the branch.
>
> However, if there are branches tracking the different parts of the
> feature, then rebasing the entire list of commits can create commits not
> reachable from those "sub branches". It can take a manual step to update
> those branches.
>
> Add a new --update-refs option to 'git rebase -i' that adds 'update-ref
> <ref>' steps to the todo file whenever a commit that is being rebased is
> decorated with that <ref>. At the very end, the rebase process updates
> all of the listed refs to the values stored during the rebase operation.
>
> Be sure to iterate after any squashing or fixups are placed. Update the
> branch only after those squashes and fixups are complete. This allows a
> --fixup commit at the tip of the feature to apply correctly to the sub
> branch, even if it is fixing up the most-recent commit in that part.
>
> One potential problem here is that refs decorating commits that are
> already marked as "fixup!" or "squash!" will not be included in this
> list. Generally, the reordering of the "fixup!" and "squash!" is likely
> to change the relative order of these refs, so it is not recommended.
> The workflow here is intended to allow these kinds of commits at the tip
> of the rebased branch while the other sub branches come along for the
> ride without intervention.
>
> This change update the documentation and builtin to accept the
> --update-refs option as well as updating the todo file with the
> 'update-ref' commands. Tests are added to ensure that these todo
> commands are added in the correct locations.

OK, so command line option is `--update-refs` because the range
being rebased could contain more than one branch tips, and the
option causes one `update-ref` insn per such ref left in the todo
list?  I had to read the above twice to remind me what was going on.

The design looks OK here but has "rebase-merge/update-refs" already
came into the picture, or will it be in future steps?  I lost track.

Let's read on.

Thanks.
