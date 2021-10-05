Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CABC433EF
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 19:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A41D461181
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 19:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhJETco (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 15:32:44 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65409 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhJETco (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 15:32:44 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 37351152DBB;
        Tue,  5 Oct 2021 15:30:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4cxqN2U9ak7Gk+MhtDucCJLgiYX8UH9u7RiRD6
        kkoDY=; b=aNIRCnvdSUSh/CldcqtrCDax83KOcUbv0dzlaAiIbMQWOgY/6UU8LN
        JgA5OKHVmlmsqUeDaO82KNfV4Y+FgCUvMk8gPWtqPHq09mqoZsAEwib3FAKj1tCQ
        osG+FZhPuELBQYB7KGEwVfhEEFcENA0kwZvMon4KBK23eg89Nf+wo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3099D152DBA;
        Tue,  5 Oct 2021 15:30:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7E9EF152DB7;
        Tue,  5 Oct 2021 15:30:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kevin Willford via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH v2 1/7] reset: behave correctly with sparse-checkout
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
        <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
        <22c69bc60308fef13acd7c3aab4e11e175c89440.1633440057.git.gitgitgadget@gmail.com>
Date:   Tue, 05 Oct 2021 12:30:49 -0700
In-Reply-To: <22c69bc60308fef13acd7c3aab4e11e175c89440.1633440057.git.gitgitgadget@gmail.com>
        (Kevin Willford via GitGitGadget's message of "Tue, 05 Oct 2021
        13:20:51 +0000")
Message-ID: <xmqqfstftgk6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF79A078-2612-11EC-8D33-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kevin Willford via GitGitGadget" <gitgitgadget@gmail.com> writes:

> When using the sparse checkout feature, 'git reset' will add entries to
> the index that will have the skip-worktree bit off but will leave the
> working directory empty. File data is lost because the index version of
> the files has been changed but there is nothing that is in the working
> directory. This will cause the next 'git status' call to show either
> deleted for files modified or deleting or nothing for files added. The
> added files should be shown as untracked and modified files should be
> shown as modified.

I am on vacation today, so let me be brief.

Let me see if I am understanding the situation correctly.

We have the index, with a path that records a blob, but the path is
marked with skip-wortree bit.

    $ rm -fr test && mkdir test && cd test
    $ git init .
    $ date >no-skip
    $ date >skip
    $ git add no-skip skip
    $ git commit -m initial
     2 files changed, 2 insertions(+)
     create mode 100644 no-skip
     create mode 100644 skip
    $ date >no-skip
    $ date >skip
    $ git add no-skip skip
    $ git update-index --skip-wortree skip
    $ rm skip
    $ git commit -m second
    [master e9088ad] second
     2 files changed, 2 insertions(+), 2 deletions(-)
    $ ls *skip
    no-skip
    $ git ls-files -t
    H no-skip
    S skip
    $ git status
    On branch master
    nothing to commit, working tree clean

Note.  There is no 'reset' done yet so far.

The user is happy with the state because

 (1) The user marked the path "skip" with skip-worktree bit, and
     thanks to that, even though "skip" is absent in the working
     tree, the "git status" does not complain.

 (2) The user marked the path "skip" with skip-worktree bit because
     the user did not want to see such a file in the working tree.
     And "git commit -m second", "git ls-files -t", or "git status"
     that were done to get here did not make it materialize in the
     working tree all of sudden.

And then the user says "git reset HEAD^" to switch to a different
commit.

    $ git reset HEAD^
    $ ls *skip
    no-skip
    $ git ls-files -t
    M no-skip
    D skip
    $ git status -suno
     M no-skip
     D skip

The user is unhappy with the state because "skip" is shown as lost.

Do I understand the situation you are trying to deal with correctly?

> To fix this when the reset is running if there is not a file in the
> working directory and if it will be missing with the new index entry or
> was not missing in the previous version, we create the previous index
> version of the file in the working directory so that status will report
> correctly and the files will be availble for the user to deal with.

Assuming I read the problem description correctly, I am highly
skeptical that the above is a correct approach to keep the user
happy.  Yes, if you created a working tree file with contents that
match the blob recorded for the path in the initial commit when
"reset HEAD^" is done, you may keep "git status" quiet, so (1) above
will be kept, but what about (2)?  The user marked the path with
"skip" but, because the path should not appear on the working tree.
The "fix" is countermanding that wish by the user, isn't it?

Wouldn't a fix to the situation be to 

 * Add the blob for "skip" taken from the initial commit to the
   index, just like the entry for "no-skip" is updated;

 * But remember that "skip" was marked with "skip-worktree" bit
   immediately before "git reset" was asked to do its thing, and
   re-add the bit to the path in the index before "git reset" gives
   the control back to the usre;

 * And keep the working tree untouched, without writing anything out
   to "skip".  If the user had a (possibly unrelated) file there, it
   will not be overwritten, and if the user left the path absent, it
   will still be absent.

so that the last three diagnostic commands in the above sample
sequence would instead read:

    $ ls *skip
    no-skip
    $ git ls-files -t
    M no-skip
    S skip
    $ git status -suno
     M no-skip

i.e. skip gets updated in the index only, nothing changes in the
working tree for "skip" or "no-skip", and status reports that
"no-skip" is different from the index but "skip" hasn't changed in
the working tree since the index (thanks to its skip-worktree bit).

Then the user will be happy in the same way as the user was happy
immediately after the state marked with "There is no 'reset' done
yet so far." above, on both counts, not just for "status does not
report something got changed" part but also "user didn't want to see
'skip' in the working tree, and 'skip' did not materialize" part.

Thanks.
