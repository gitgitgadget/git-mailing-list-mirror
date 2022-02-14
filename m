Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B9AC433F5
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 11:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352357AbiBNLrd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 06:47:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352936AbiBNLqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 06:46:09 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B433A1A0
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 03:44:33 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DE1A117E528;
        Mon, 14 Feb 2022 06:44:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=hefda7oSnJ0DBJgnXUNmkssdaMzAYRnNNZkI1+dLick=; b=kbrC
        s60vm7bJXyDrWi2r7fvsuN4M/lPUZ4bCVX9FGfssU8J+PF4Rew0V0kE3hjrpxIBz
        9DGIM1y1l17qw+YwiIzigcp/T1zMoHPmCwmNs2ztJjJQi5PVh74SLhUiLZjsoJ2i
        aBccRWj8uFk9+XiMrFXHM9jAZYQSS4SA7O+trVY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D716617E526;
        Mon, 14 Feb 2022 06:44:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E114717E522;
        Mon, 14 Feb 2022 06:44:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Viaceslavus via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Viaceslavus <vaceslavkozin619@gmail.com>
Subject: Re: [PATCH v2] hard reset safe mode
References: <pull.1137.git.1643802721612.gitgitgadget@gmail.com>
        <pull.1137.v2.git.1644618404948.gitgitgadget@gmail.com>
        <xmqqee4980qz.fsf@gitster.g>
        <c81e1226-2184-0f16-b81d-c11d894b4654@gmail.com>
Date:   Mon, 14 Feb 2022 03:44:25 -0800
Message-ID: <xmqqleyd4qqu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 767B0A5C-8D8B-11EC-A18B-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> I think it's better just to error out when there are staged changes.
> The message will be something like:
> "error: there are staged changes that will be hard-reset. Please
> commit or stash them before resetting. If you want to remove all
> changes from index, you can do so by running 'git reset'."

I do prefer not to have interactive prompt at all, as we _will_ get
it wrong when we shouldn't be doing the warning or prompting (i.e.
when no user is sitting in front of the terminal).

Another thing that I would be very opposed to in the posted patch is
the special casing of an initial commit.  If typing 10,000 lines of
material to create a new file, doing "git add", and changing mind
and saying "git reset --hard" to lose the new file is painful before
creating the first commit, doing exactly the same in a project after
10 years with 10,000 commits will hurt exactly the same way.  You'd
"lose" the 10,000 lines of material you prepared to the "accident"
either way.

One more thing the posted patch is designed in a wrong way is that
it cares about the state of _other_ branches; even if you "git reset
--hard" on an unborn branch, if there are some commits on other
branches that has nothing to do with your current state, it will do
what it was told to do regardless of "safe mode".  The "damage"
caused by such an "accident" would be the same for the end-user,
whether there is an unrelated branch with a commit or there isn't.
You'd "lose" the 10,000 lines of material you prepared to the
"accident" regardless.

So, I am strongly opposed to the posted patch.  "git reset --hard"
is designed to bring the index and the working tree to the pristine
state in a predictable way, and making it work differently depending
on a setting, or if it is on an unborn branch, or if there are
commits on any branch, goes very against its spirit.

After all, "reset --hard" is called *HARD* for a reason.  It is not
"unsafe".  It is designed to give you pristine state no matter what
and it tries very hard to do so, by even removing an untracked file
that is squatting the path at which the pristine state wants a
directory.

In other words, those who type "git reset --hard" WITHOUT wishing to
go back to the pristine state by clearing the deck may be using a
wrong command.

I wonder if "git reset" (i.e. mixed, not hard) is what they want to
use, instead.  It is the command to use when: "I've made a mess in
the index after doing 'add -p' and other things, and want to get the
index into pristine state, while keeping the working tree files".

After doing so, the first thing they can do is to "git diff" to
compare what they truly do not want to have anywhere and "git
checkout -- <path>" to update the whole file to the state in the
index, or "git checkout -p -- <path>" to update them piecemeal.

Or perhaps they want "git stash".  That would clear the deck and
give them the pristine state justlike "git reset --hard" would, but
if they found that they did so by mistake, they can immediately
unstash.

Having said all that, because "reset" is mostly about the index and
not about the working tree (the core of the Git's philosophy is that
the index is all that matters and the working tree files are just
ephemeral means to the end, which is to update the index with good
contents and to make tree out of it), I can see us adding another
mode, perhaps called "reset --clear", that is almost like "reset
--hard" with one distinction, for end-user's interactive use.

If you did this sequence:

    $ git reset --hard    ;# start from a pristine state

    $ date >new-file-a    ;# create a new file
    $ date >new-file-b    ;# create another new file
    $ git add new-file-a  ;# just add one of them

    $ git reset --hard    ;# get back to the pristine state

the second reset will make sure that neither of these two files are
in the index, but it also removes only one of the files in the
working tree, while leaving the other file in the working tree.

The fact that new-file-a has been "git add"ed means that after
losing new-file-a, its contents *can* be recovered (i.e. it is one
of the loose objects that is no longer reachable, and "git fsck
--lost-found" could theoretically give it back to you).

But new-file-b has never been added, so losing it is a more grave
loss.  So the behaviour to remove new-file-a that was in the index
while leaving new-file-b alone is somewhat justifiable, but not by a
large margin.  A new "reset --clear" mode _could_ make paths in the
index that do not appear in the resetted-to treeish (either HEAD or
an empty tree if the branch is unborn) untracked, while leaving their
working tree files alone.
