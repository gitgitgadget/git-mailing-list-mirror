Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5131CCA47B
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 16:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245032AbiFHQDr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 12:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244799AbiFHQD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 12:03:28 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB5A2506F2
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 09:03:26 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 566D41907A0;
        Wed,  8 Jun 2022 12:03:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yqVjmGiyFN7K1RnkXjT8S7S/D9CUX0m7oVGg+8
        5nEH0=; b=kV8Cw2ixvU3V2IWMmkEflHItLDULEOimElNUZlNWQGhAAu5QOIVfV2
        5ihnWlMstHDu+jYi2uZd0XxKNCMUXchrJHjoluYMMogWvdvf8ERGgtiaCG+BmkDU
        ki3FWRlf1BLFx3X5yORETkE2i0nA44RMRhTi1+T/5o8UetWdqRIYM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4B62319079F;
        Wed,  8 Jun 2022 12:03:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A3C9E19079D;
        Wed,  8 Jun 2022 12:03:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     phillip.wood@dunelm.org.uk, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de
Subject: Re: [PATCH 0/4] rebase: update branches in multi-part topic
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
        <YppSl4rOvVciLuXE@nand.local>
        <a63cba6e-d25a-ee6d-57f0-9562b6235d3b@gmail.com>
        <3bb8baa2-e3e0-5cf1-aace-b0ba3ec6eb77@github.com>
        <90ccd923-3552-fe88-5d6d-869def7f1aeb@gmail.com>
        <9354d1d3-c1b7-3baf-215f-30659ad48b22@github.com>
Date:   Wed, 08 Jun 2022 09:03:20 -0700
In-Reply-To: <9354d1d3-c1b7-3baf-215f-30659ad48b22@github.com> (Derrick
        Stolee's message of "Tue, 7 Jun 2022 15:39:37 -0400")
Message-ID: <xmqqbkv3rvlj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8500C4AA-E744-11EC-9B52-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>> I think the question of whether to update branches that are checked out in
>> another worktree is a question of whether it is less inconvenient to the user
>> to skip the ref update and leave the user to manually update the branch or to
>> update the ref and leave the worktree in a potentially awkward state if the
>> user was half way through building a commit. The answer probably depends on
>> the preferences of the user.

To some degree, it might be true, but I think the recent thinking is
that by default any refs being worked on by the user must be kept
intact.  "switch" does not let you check out a branch that is
already checked out elsewhere, "fetch" does not let you overwrite
the branch that is currently checked out without "--update-head-ok",
etc.

> I think that their 'git status' will look strange no matter what: their
> working directory and index could look significantly different from what
> the branch at HEAD is reporting. For this situation, I would rather continue
> preventing these ref updates from underneath worktrees.
>  
>> I've been using a script that updates the refs for all the branches being
>> rewritten for a while and have found it preferable to always update the ref
>> rather than have to do it manually. My script also updates the worktree
>> checkout to the new HEAD if there are no uncommitted changes which I have
>> found very convenient. My preference is probably because I tend not to have
>> uncommitted changes lying around in the worktrees whose branches get updated.
>
> Actually updating the worktree to match seems like an interesting twist, which
> we would want to consider if we go this route in the future.

Usually I caution against adding "features" that can complicate the
end-user experience like this, but in this case, the potential for
extra conflicts coming from such updates to the working trees may
not be too bad.

It all depends on why the user has these intermediate branches and
how they are used, but in order to see any conflicts happen after
rebasing a branch here, before you start that rebase, you need to
have in different working trees that had these intermediate branches
checked out and had local modifications on top of them.

I would say that you deserve it if conflicts resulting from such a
set-up hurts you ;-)  If you are using these intermediate branches
so that you can work on steps in the middle of the larger whole,
then the proposed "rebase --update-refs" is not for you.  Having
local modification in these separate working trees that check out
the intermediate branches is OK, but once you create a commit on
such a branch, the commit that is in the larger topic is no longer
at the tip, so "rebase --update-refs" would not notice it anyway.

Rather, if you have the intermediate branches, you'd probably want
to work on each of them to make them stable, and rebase them on top
of each other in an appropriate order.  "rebase --update-refs" that
runs on the larger topic does not have enough information to rebuild
it with tips of intermediate branches that are updated elsewhere.

Which means that anybody sane who uses "rebase --update-refs" would
not modify these intermediate branches outside the context of the
larger topic, and those who do not follow this rule can keep both
halves of their history ;-)

FWIW a complementary tool that would work in the other direction, to
expect the user to have worked on smaller branches and rebuild the
larger branch that contains them, is also missing from our tool set.
Those who check out these smaller branches in separate working trees
would want to use such a tool, not "rebase --update-ref".

Thanks.
