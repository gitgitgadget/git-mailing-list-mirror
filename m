Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A8DEB64D7
	for <git@archiver.kernel.org>; Mon, 19 Jun 2023 01:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjFSBmN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Jun 2023 21:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjFSBmM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jun 2023 21:42:12 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03171BD
        for <git@vger.kernel.org>; Sun, 18 Jun 2023 18:42:10 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 783C61A0208;
        Sun, 18 Jun 2023 21:42:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oRbJOdbSF0/1bBsf5GfXA7DZrlF5XJjzaVrkNV
        d4ml4=; b=mTzHAYDK9HvVsWhaCulPsioPmQmuBLEEEmVxElmi3OjSMcXW4Wx2/l
        T2roqk1ImCyGIPa43b8RCu7OJgCN4zZ4QB9WN8E/xeAe4yx8A1O39tLiKn5DRjyY
        qI6ye4Zu3mK2wDW/ezBeh7PvEavYNyBNrYqndY31AzuQHnBqZz68s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6DFDC1A0207;
        Sun, 18 Jun 2023 21:42:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B205C1A0205;
        Sun, 18 Jun 2023 21:42:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nadav Goldstein <nadav.goldstein96@gmail.com>
Cc:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        Nadav Goldstein via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] Add 'preserve' subcommand to 'git stash'
References: <pull.1528.git.git.1686913210137.gitgitgadget@gmail.com>
        <xmqqjzw3qry6.fsf@gitster.g> <ZIzALOe8GBsNGIhR@ugly>
        <xmqqv8fnrwtt.fsf@gitster.g> <ZI1xLwemOs9Vxorf@ugly>
        <xmqqwn02qqp4.fsf@gitster.g>
        <f6a510f8-f569-6b1e-a74d-cdd103b39c10@gmail.com>
Date:   Sun, 18 Jun 2023 18:42:05 -0700
In-Reply-To: <f6a510f8-f569-6b1e-a74d-cdd103b39c10@gmail.com> (Nadav
        Goldstein's message of "Sun, 18 Jun 2023 12:05:21 +0300")
Message-ID: <xmqqwn00p6s2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7FA8A272-0E42-11EE-8795-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nadav Goldstein <nadav.goldstein96@gmail.com> writes:

> I heavily use stash to set quick points in my code so I could go back
> to them (during thought process), and I want to store my changes
> quickly and continue from there).

So it is more like "take a series of snapshots".  I do not think
"stash" is a good match for that, and I do not know how to bend
"stash" to make it a good match for that purpose while not hurting
the original use of the "stash" command.

Surely, the first part of "stash create" is a good way to take a
snapshot, but after creating a series of stash entries, we cannot
use them effectively as "snapshot we can go back to", and half the
problem lies in the application side ("stash apply") and the other
half comes from your design to leave the local changes in the
working tree and the index.

Let's imagine that while we are exploring, we came up with an idea,
wrote code and did a "git stash push && git stash apply" (or "git
stash snapshot").  We continue, and we do more modification, and do
another "git stash snapshot".  We do that again and create another
snapshot.  In total, on top of the HEAD that hasn't changed, we now
have three snapshots stash@{2}, stash@{1}, and stash@{0}.

Let's further imagine that the earliest first step was good
(i.e. the change stored in stash@{2}^..stash@{2} and the tree object
recorded in stash@{2}^{tree} are both good).  Also, the latest
change we made since we took the second snapshot (i.e. diff between
stash@{1} and stash@{0}) is good.

But the changes made in the second part was totally misdesigned and
beyond salvaging.  It has to be discarded and reworked from scratch.

Using stash@{2} to go back to the first snapshot may be trivial.
We'd do something like

    $ git reset --hard stash@{2} && git reset --soft HEAD^

But how would we salvage the latest part of the work on top of this
state, while excluding the crap we made before we took the second
snapshot?  Mostly because the main motivation behind "git stash" is
to preserve the change between HEAD and the current state while
preparing a clean slate to work on something totally unrelated for
us, its application side is geared towards applying the preserved
change (i.e. not the tree state of the stash entry, but the
differences between the tree state of the parent of the stash entry
and the tree state of the stash entry).  Asking "please apply the
difference recorded in the stash@{0}" would give us changes we made
while taking all three snapshots, which is bad for two reasons, (1)
because we have already recovered the changes we made before taking
the first snapshot above but stash@{0} contains that change
redundantly, and (2) stash@{0} also contains the change we made
between the first and the second snapshot, the crappy one we want to
discard.  We end up doing something unwierdy like this, perhaps?

    $ git diff stash@{1} stash@{0} | git apply

Besides, new users will be utterly confused if they realize that
stash@{0} would contain changes made in the all three phases and
their "stash pop/apply" on it would resurrect all of them.  So we
need to educate users with "stash entries created with 'stash
preserve' cannot be applied with 'stash pop' without care".

If we instead used normal commits during our exploring phase of the
development, this would have been much easier and cleaner:

    $ work work initial work
    $ git commit -a -m 'snapshot #1'
    $ work work more work
    $ git commit -a -m 'snapshot #2'
    $ work work great work
    $ git commit -a -m 'snapshot #3'

We only discover that earlier work was crap after trying to build on
top and the end result does not work well.  So the "great work" part
may have been very good, "initial work" part may be OK, but the
other part, i.e. "more work", while it may have looked like a good
idea, turns out to be unusable.  Fortunately, how to clean up such a
history is well established.  With "git rebase -i HEAD~3", we can
easily discard the "more work" part and preserve both "initial" and
"great" work in the result.

In short, we do not have to abuse stash to make a poor imitation of
already well understood workflow, and even if it were a good idea,
the "stash preserve" proposed in the thread would not be a good
ingredient to build something like that, because of its design,
i.e. the snapshots are not incremental and it is always relative to
the unmoving HEAD, hence recording older changes redundantly.

> Regarding using it as a flag in the stash push, I went to this
> direction initially, but stopped because of all of the flags you
> mentioned (keep-index, include-untracked etc...),...

As shown above, "stash preserve" is not a good alternative to
"commits then rebase".  In short, if you create N snapshots in a
row, if your changes between M-th snapshot and M+1-th snapshot were
so bad that they need to be discarded, it would make all of your
later snapshot hard to salvage.

Now let's see if we can salvage it for single-use snapshot that
cannot be combined.  The limitation is that you can only go back to
the state of a single stash entry, as if running "reset --hard".
Would the "stash preserve" with such a limited application still be
useful?  Even then lack of "include untracked" would probably be a
show-stopper for those people who create new files while "during
thought process", and here is why.

    $ work work work
    $ modify files A, B, C, D
    $ create new file E, F
    $ git stash snapshot
    $ work work more work
    $ git stash snapshot
    $ work work even more work
    $ git stash snapshot
    $ work work even more work
    $ ...

Now, if realize that these later work after the snapshot were all
bad, can we go back to the initial snapshot?

If you do not allow recording what was in the untracked files, the
contents of new files E and F may have been modified while you were
butchering your somewhat good initial step you recorded in your
first snapshot.

Not allowing pathspec would have similar issues.  While doing
exploratory programming, you may realize that changes you made to
some of the files are in good shape and worth including in a
snapshot while the state of other files are no better than what you
had in your previous snapshot, and you would want to be able to use
"git stash snapshot -- <pathspec>" to make the resulting snapshot
usable.

So whether it is done as a separate command "git stash preserve", or
it is done as an option to "git stash push --snapshot-only", the
users will need access to (some of) the options they expect to be
able to use the usual "stash push".  It may not have to support all
the options and operating modes from day one, but if it will have to
eventually learn many of them when it becomes complete, I do not see
a strong reason to have it as a separate command.

It is fine if some of the options are inherently incompatible with
"--snapshot-only" mode.  There are precedence in the code you can
find and mimic, like "--patch" and "--include-untracked" options
are marked to be incompatible.

But as I already said, I am not sure if it is worth pursuing this
route, as "commits then rebase" is well understood and established
workflow to help us during our exploratory programming use case.

Thanks.

