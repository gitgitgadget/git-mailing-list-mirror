Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE0EC43334
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 15:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbiGLPiD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 11:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiGLPiA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 11:38:00 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6432761B19
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 08:37:59 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A49D13C098;
        Tue, 12 Jul 2022 11:37:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=13kNzP2QcLcDbduYsffnXhMQQG0IHurduAO9Ij
        6rXX8=; b=S0f6TLVWNHEpPbGLB85R04A4biLv7WK9G5XME0JSVKE4czf4FRs5NC
        AxmuJ5Iq6lXXdVwKGPuasJxRNYxamIg1nDBBJ6foIML4JEed30YwP2f5W4X4VADc
        /xv1k6SWf6fGIV+fl6JXleIf4Soi/DH/TEP8883m43Q52EFilBiiA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 61E2313C097;
        Tue, 12 Jul 2022 11:37:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C0FE913C096;
        Tue, 12 Jul 2022 11:37:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v4 00/12] rebase: update branches in multi-part topic
References: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
        <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
Date:   Tue, 12 Jul 2022 08:37:56 -0700
In-Reply-To: <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Tue, 12 Jul 2022 13:06:53
        +0000")
Message-ID: <xmqq8royibor.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9ABF475C-01F8-11ED-8472-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series is based on ds/branch-checked-out.
> ...
> Updates in v4
> =============
>
> This version took longer than I'd hoped (I had less time to work on it than
> anticipated) but it also has some major updates. These major updates are
> direct responses to the significant review this series has received. Thank
> you!
>
>  * The update-refs file now stores "ref/before/after" triples (still
>    separated by lines). This allows us to store the "before" OID of a ref in
>    addition to the "after" that we will write to that ref at the end of the
>    rebase. This allows us to do a "force-with-lease" update. The
>    branch_checked_out() updates should prevent Git from updating those refs
>    while under the rebase, but older versions and third-party tools don't
>    have that protection.

Nice.

>  * The update-refs file is updated with every update to the todo-list file.
>    This allows for some advanced changes to the file, including removing,
>    adding, and duplicating 'update-ref' commands.
>  * The message at the end of the rebase process now lists which refs were
>    updated with the update-ref steps. This includes any ref updates that
>    fail.
>  * The branch_checked_out() tests now use 'git bisect' and 'git rebase' as
>    black-boxes instead of testing their internals directly.
>
> Here are the more minor updates:
>
>  * Dropped an unnecessary stat() call.
>  * Updated commit messages to include extra details, based on confusion in
>    last round.
>  * The HEAD branch no longer appears as a comment line in the initial todo
>    list.
>  * The update-refs file is now written using a lockfile.
>  * Tests now use test_cmp_rev.
>  * A memory leak ('path' variable) is resolved.

Interesting.

This is a tangent, but may serve as some food for thought.

When I queue (or develop myself) a topic that depends on another
topic, I often do

    $ git checkout --detach vX.Y.Z ;# choose an appropriate base
    $ git merge --into derived-topic base-topic
    $ develop develop (or "git am")

which would end up in

    vX.Y.Z -----M---A---B---C derived-topic
               /
     base-topic

so that "git log --first-parent --oneline master.." would show the
commits in the topic plus the fact that it depends on which other
topic recorded in a single merge commit.  A topic that depends on
two or more topics can be handled the same way.

One good thing about this arrangement, unlike the "totally linear"
one depicted at the top of your cover letter, is that it is easier
to rebuild each topic independently and the first-parent view is
still useful.  If you futz with the base topic in a totally linear
history, "log --decorate" of the derived topic would no longer tell
you where the old iteration of the base topic ended.

It would be very nice to see the update-ref feature (or something
like that) makes it easy to deal with such a topology, too.

