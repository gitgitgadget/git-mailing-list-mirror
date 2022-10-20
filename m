Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D0DC433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 22:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJTWkf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 18:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiJTWkd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 18:40:33 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7883C15201A
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 15:40:31 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B6D6151404;
        Thu, 20 Oct 2022 18:40:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uXBrEMPG2O7vlD1aA0xhWB1FS9t4Jo9cuiVAhL
        T9aSY=; b=tyjTZzwUUBlYcKrcr5NsCBDBXci4LXSl+PRSCVsNgeBoIa0JjnNFD/
        x6AW5ZXOGOznmST54ZQjJSziinEBi85jwEZtMPTbttFz/ALyveJJf41SKN75QwpT
        /+5leqyp0aG5G+R0JBTajr0vCx6ffxxzcOLt6InZsUtMlqJQrPJD4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 72D23151403;
        Thu, 20 Oct 2022 18:40:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D82E2151402;
        Thu, 20 Oct 2022 18:40:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v2 0/7] clone, submodule update: check out submodule
 branches
References: <pull.1321.git.git.1661806456.gitgitgadget@gmail.com>
        <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com>
Date:   Thu, 20 Oct 2022 15:40:28 -0700
In-Reply-To: <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com> (Glen
        Choo via GitGitGadget's message of "Thu, 20 Oct 2022 20:20:31 +0000")
Message-ID: <xmqqh6zyqftv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3314BE74-50C8-11ED-BF98-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> During the v1 discussion, I realize that my idea of the new submodule UX has
> already diverged from what was initially communicated to the list. I plan to
> check in a technical document describing the plans for new submodule UX,
> which should hopefully make these discussions smoother (e.g. the commit
> message in patch 7 can make reference to the doc).

Good.

> = Description
>
> This series teaches "git clone --recurse-submodules" and "git submodule
> update" to understand "submodule.propagateBranches" (see Further Reading for
> context), i.e. if the superproject has a branch checked out and a submodule
> is cloned, the submodule will have the same branch checked out.
>
> To do this, "git submodule update" checks if ...
> = Series history
>
> Changes in v2:
>
>  * The superproject's "submodule.propagateBranches" value is always used,
>    even if false.
>  * Branches are now created at clone time (by adding a new flag to "git
>    submodule clone"), instead of at update time.
>  * Rebase onto newer master. This got adjusted slightly to incorporate
>    ab/submodule-helper-leakfix.
>  * Add more tests to demonstrate edge case behavior.
>  * Assorted commit message and doc improvements.

As the previous round was more than a month old and is clearly not a
bugfix but is adding a new feature, I do not mind updating to the
newer base after a new feature release was made.  There isn't much
to be gained, other than that we can easily sanity check by running
"git diff @{1} @{0}" on the branch to compare the iterations, by
keeping the same base.  We are not going to merge this topic down to
maintenance tracks after it graduates to 'master' anyway.

But I got curious and tried to adjust these patches back on the
previous base 07ee72db (Sync with 'maint', 2022-08-26).  It turns
out that the conflicts needed to be resolved were fairly trivial.

Merging the topic that was recreated on top of the same old base
into today's 'master' of course needed the same conflict resolution
but that is something we've been doing every time we rebuild 'seen'
(read: at least twice a day, but often more).  Applying these
patches directly on today's 'master' of course produced the
identical tree as the tree of this trial merge.

> = Future work
>
>  * Patch 5, which refactors resolve_gitlink_ref(), notes that a better
>    interface would be to return the refname instead of using an "out"
>    parameter, but we use an "out" parameter so that any new callers trying
>    to use the old function signature will get stopped by the compiler. The
>    refactor can be finished at a later time.

OK.

>  * Patch 5 uses the name "target" when we are talking about what a symref
>    points to, instead of "referent" like the other functions. "target" is
>    the better choice, since "referent" could also apply to non-symbolic
>    refs, but that cleanup is quite big.

I do not see a huge difference between the two.  "target" can be
used in contexts that are not about symbolic refs, and "referent"
can be used in contexts that are not about symbolic refs, too.  As
long as they are unified in one way or another, it would be fine.
