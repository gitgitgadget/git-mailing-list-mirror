Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A06C433EF
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 07:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED12661268
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 07:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbhKEHxF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 03:53:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50094 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhKEHxE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 03:53:04 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 89A30E15EC;
        Fri,  5 Nov 2021 03:50:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=GJV3PL5ZqmNwPyq48mup4Uo9CXuC4XWPCmMMYB0qG+0=; b=mvfe
        Y8M3eqoIaw45+5bitV4N6LFvrm6tHhhZWt95fRL6nEWWPCtK/rcemJR9u6rtkZTZ
        A3LMrrgNcfvS95rjFuJXknq31XxoEajid9fM3nW1FTwcImMk+nxHp0Cd3CmTGwtB
        TKTVt27UyWYGbwf82Yook7zsUWwuLqtjfnt68/Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 820AAE15E8;
        Fri,  5 Nov 2021 03:50:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E5F20E15E7;
        Fri,  5 Nov 2021 03:50:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v5 2/4] introduce submodule.superprojectGitDir record
References: <20211104234942.3473650-1-emilyshaffer@google.com>
        <20211104234942.3473650-3-emilyshaffer@google.com>
Date:   Fri, 05 Nov 2021 00:50:22 -0700
Message-ID: <xmqqo86zxcqp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 087D3458-3E0D-11EC-AADC-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> By using a relative path instead of an absolute path, we can move the
> superproject directory around on the filesystem without breaking the
> submodule's cache. And by using the path from gitdir to gitdir, we can
> move the submodule within the superproject's tree structure without
> breaking the submodule's cache, too.

All of the above explains what the design choice is, and what
benefit the chosen design brings us.  But this last one ...

> Finally, by pointing at "get_git_common_dir()" instead of
> "get_git_dir()", we ensure the link will refer to the parent repo,
> not to a specific worktree.

... only says that we choose to point at the common one, not a
specific worktree (i.e. what behaviour was chosen by the design),
but it is left unclear what benefit it is trying to bring us.

Thinking aloud, imagine that there are two worktrees for the
superproject.  For simplicity, let's further imagine that these
worktrees have a clean check-out of the same commit, hence, these
two worktrees have the same commit from the same submodule checked
out at the same location relative to the project root.

The subdirectory in each of these two superproject worktrees that
checks out the submodule has .git file (as we "absorb" the gitdir in
the modern submodule layout) pointing at somewhere.  It probably is
OK if they point at the same place, but it might be more natural if
these two submodule checkouts are two worktrees for a single
submodule repository (this part I am not very clear, and that is why
I labeled the discussion "thinking aloud").

It seems to me that both design choices would have equally valid
arguments for them.  If both of these submodule worktrees point at
the "common" dir of the superproject, because the "common" one is
part of the primary worktree, which is harder to lose than secondary
worktrees, of the superproject, it is presumably harder to go stale
when "worktree rm" is done at superproject, which may be a plus.
But then from the "cached" pointer, each of these submodule
worktrees cannot tell which worktree of the superproject they are
checked out as a part of.  Of course we can go to the root level of
the submodule worktree and do the usual repository discovery to
learn where the root level of the superproject worktree it belongs
to, but it somehow feels that it defeats half the point of having
this "cache" information.

If we instead point at the git-dir, from there, it is just one level
of indirection to find out where the common dir of the superproject
is.

> If the new config is present, we can do some optional value-added
> behavior, like letting "git status" print additional info about the
> submodule's status in relation to its superproject, or like letting the
> superproject and submodule share an additional config file separate from
> either one's local config.

And one value-add that I would think of off the top of my head is to
show "we have commit X checked out, which is 4 commits on top of
what the superproject's index records for this submodule" when "git
status" is run in the submodule's worktree.  I do not know that is
an operation to specifically optimize for, but by choosing to
"cache" the common dir, not the one specific to the worktree of the
superporject our submodule checkout is a part of, the chosen design
seems to make it harder to implement?

Thanks.
