Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44C4C00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 16:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238648AbiHEQmZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 12:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbiHEQmD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 12:42:03 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17ACE1581C
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 09:42:02 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9094B12CBCC;
        Fri,  5 Aug 2022 12:41:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t8eyCRqxOdRRLnSpdiwErertmd9tZaiQX2ShTp
        aeOwI=; b=Lt43GLB5sdp6RqGScLbkhL1fRVLhInn1ITDXuSgMUAvhUNKEAs9n3h
        pB44kJR7Kz2VdrAb5Pr9BEhFKFF/vO4o5ykPc+KjWcL0k1NECQk+1oO4grDCCS3H
        tNdjwzIctg6Tj90bEwzBu43XXkxpV03qbvnDXGufhF4GfQsN6Alf4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8879412CBCB;
        Fri,  5 Aug 2022 12:41:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D621812CBCA;
        Fri,  5 Aug 2022 12:41:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>, git@vger.kernel.org,
        Emily Noneman <emily.noneman@gmail.com>,
        Paul Horn <git@knutwalker.engineer>
Subject: Re: [PATCH] revision.c: set-up "index_state.repo", don't segfault
 in pack-objects
References: <CAKvVO18RVye=PkBRv=trj2GHh8ccGKL5j0mMq2eHQ1SX=wsr8A@mail.gmail.com>
        <patch-1.1-3ff17707481-20220805T141816Z-avarab@gmail.com>
        <b6299f8a-f75a-0e96-a6a6-55a7280584bf@github.com>
        <Yu02dOo4G8sy8tI6@coredump.intra.peff.net>
Date:   Fri, 05 Aug 2022 09:41:57 -0700
In-Reply-To: <Yu02dOo4G8sy8tI6@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 5 Aug 2022 11:25:40 -0400")
Message-ID: <xmqqo7wyzlpm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8620CD3C-14DD-11ED-B026-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Of the two patches, I think 4447d4129d is the better approach. The
> assumption in the code seems to be that do_read_index() (and thus
> read_index_from(), etc) will set up istate->repo. That patch fixes a
> corner case where we failed to do so. And with that fix, there's no need
> for the callers to set things up ahead of time. So it covers all of
> those initializers you mentioned.

Yeah, I tend to agree that Martin's fix, which is a more focused
one, is the better approach between the two.  It was merged to
the 'master' track only a few days ago.

We are at the end of the week #4 of this 12-week cycle, and we've
accumulated about two dozens of topics already on 'maint' since the
first maintenance release v2.37.1 was done, so we may have a chance
to merge Martin's fix down to 'maint' before tagging the v2.37.2
release.

One thing that may help is to add a test similar to the situation
Emily & Paul had to t7063 on top of 4447d4129d before merging it
down, perhaps?

In your reproduction, the "rm .git/index" step makes the worktree's
branch "not checked out" (the commit is empty so "worktree add" may
check out no files, and removing the index will make it as if you
did "clone --no-checkout") ...

  git init repo
  cd repo
  git commit --allow-empty -m base

  git config core.untrackedCache true
  git worktree add at
  rm .git/worktrees/wt/index

  git gc

...  but it is not something an end user is likely to do, so I am
still curious how this was triggered in real life.

Ah, OK, I think the steps can be tweaked to

      git config core.untrackedCache true
    - git worktree add at
    - rm .git/worktrees/wt/index
    + git worktree add --no-checkout wt

      git gc

i.e. (1) With "worktree add --no-checkout", there is no need to
manually remove the index file, and (2) "at" is an obvious typo of
"wt".  This does not require the history to be a singleton empty
tree, either.

And that is a less implausible thing for users to be doing, but may
still not be very common.  Perhaps the --no-checkout is a prelude to
set up a custom sparse checkout pattern, to avoid a wasteful full
tree checkout before doing so, or something?  If that is the case,
then the above sequence becomes a very plausible thing for users to
be doing.

> Emily, Paul: I'm 99% sure this will be the case given my reproduction
> above, but if you could try reproducing the problem with the current tip
> of "master" from git.git, that would confirm the findings.

Yes, indded.  That would be very helpful.

Thanks, all, for discussing the problem and its solution(s), and
thanks in advance for further testing to help the fix forward.
