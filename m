Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04D7C433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 18:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240534AbiGNSMF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbiGNSMC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 14:12:02 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143401DA70
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 11:11:58 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E423E1439B8;
        Thu, 14 Jul 2022 14:11:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EECXv9WOzmkO2+u07UaukqTcr76GwvQiFT4bDg
        dITNU=; b=qBQNU+KzIIg+6HNRE+yOelA+QJySLu0Lw45eGyQW4heOzmmucTphnA
        ObJwmf1uXU46QnN95Cag4qWsD5B+Fdlx6UDy7dG0GWVf2yRANeTGDBQ43aq07ho0
        29dmoE/gumvzpWW+Sz4yT31ltQLYjZgcJrSU5QFduqGLpJf2WCzks=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DAF501439B7;
        Thu, 14 Jul 2022 14:11:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4A60F1439B6;
        Thu, 14 Jul 2022 14:11:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 00/12] rebase: update branches in multi-part topic
References: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
        <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
        <xmqq8royibor.fsf@gitster.g>
        <73311eba-244b-3c88-d0b9-f97f426f1de6@github.com>
Date:   Thu, 14 Jul 2022 11:11:55 -0700
In-Reply-To: <73311eba-244b-3c88-d0b9-f97f426f1de6@github.com> (Derrick
        Stolee's message of "Thu, 14 Jul 2022 10:50:56 -0400")
Message-ID: <xmqqv8rz5ztg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 72288BEC-03A0-11ED-BB71-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>  Before:
>
>   A---B----C---M---Q1---Q2---Q3 <-- refs/heads/Q
>    \          /
>     P1--P2--P3 <-- refs/heads/P
>
>  After rebasing both topics simultaneously (with 'git rebase --update-refs
>  C' while Q is checked out):
>
>   A---B---C---D---P1---P2---P3---Q1---Q2---Q3
> 			    ^              ^
> 			refs/heads/P  refs/heads/Q
>
> But it seems what you mean to say is to update the merge commit M, which
> means that the 'P' branch above has been updated independently of the 'Q'
> branch, so we need to update 'Q' after-the-fact.

I am not aiming to flatten P and Q into a single strand of pearls.
That would defeat the point of "git log --oneline --first-parent"
that can be used to view "master..Q", whose output would be "at the
bottom the topic P lies there, and on top there are 3 patches".

P's may be your ds/branch-checked-out topic while Q's may be this
topic.  Other people may find bugs, improvements and a room for
unwanted churns in the former, and P may gain a few more commit,
in which case M thru Q3 needs to be rebuilt.

In a manual procedure, when I realize that P will gain a few
more patches (or gets rewritten):

 * find what other topics depend on P and make a mental note (i.e. Q
   needs to be rebuilt)

 * perform an equivalent of "git rebase -i --onto A P", but without
   using "git rebase".

   - git checkout P
   - git checkout --detach master...	;# reuse the same base
   - git am -s				;# apply
   - git rebase -i                      ;# minor fix-up while queuing
   - git range-diff @{-1}...		;# sanity check
   - make test				;# further sanity check
   - git checkout -B @{-1}		;# update P to the new round
   - git range-diff @{1}...             ;# final sanity check

   this rebuilds P1, P2, and P3 into a new series on A

 * for each topic that needs rebuilding (i.e. Q), find M and rebuild
   it

   - git checkout Q
   - git checkout --detach master...	;# reuse the same base
   - git merge --into Q P		;# recreate M with updated P
   - git rebase --onto HEAD M Q		;# rebuild Q
   - git checkout -B @{-1}		;# update Q to sit on top of new P
   - git range-diff @{1}...		;# sanity check (should be empty)


> I'm not sure what that rebase would look like, indepdendent of
> updating refs.

I suspect that a creative use of "git rebase --rebase-merge master
Q" should allow me to get there.  Here is an outline of the todo
list you'd get out of "git rebase --rebase-merge -i v2.37.0" while
the topic ds/rebase-update-ref is checked out:

---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- 
label onto

# Branch ds-branch-checked-out
reset 5ed49a75f3 # Merge branch 'os/fetch-check-not-current-branch'
pick 31ad6b61bd branch: add branch_checked_out() helper
pick d2ba271aad branch: check for bisects and rebases
...
pick 9bef0b1e6e branch: drop unused worktrees variable
label ds-branch-checked-out

reset onto
merge -C 7fefa1b68e ds-branch-checked-out # Merge branch 'ds/branch-checked-out' into ds/rebase-update-ref
pick a0bfa0ec53 t2407: test bisect and rebase as black-boxes
pick 43547f7a52 t2407: test branches currently using apply backend
...
pick 8b2a776cab sequencer: notify user of --update-refs activity
---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- 

So it would likely involve

 - "git checkout Q && git rebase -i --rebase-merge master" to get
   the todo list.

 - remove all "pick"s for existing commits on branch P, and replace
   them with a "break"

 - add an update-ref insn to update ds/branch-checked-out topic
   using the ds-branch-checked-out label at the end of the todo
   list.

 - exit the editor, and in the "break" session, run "am" to accept
   the new round of patches for P.

 - "git rebase --continue" to let the tip labeled as P and let the
   rest of the todo list rebuild Q

but I am not sure what should happen when there are more than one
dependent topic (i.e. in addition to Q, topic R also depends on P).
It also is unclear in the above procedure with "rebase-merge" what
to feed to "range-diff" in the sanity-checking step.  I could type
"git range-diff P..." but being able to use @{-1} is a lot handier.

