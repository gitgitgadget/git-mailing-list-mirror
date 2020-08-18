Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AE5C433E1
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 19:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D37E6206B5
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 19:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MCtG1d0H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgHRTox (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 15:44:53 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53460 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbgHRTos (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 15:44:48 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 84240E5925;
        Tue, 18 Aug 2020 15:44:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ScCo2fW35iJu7jA/qXUHukPkaco=; b=MCtG1d
        0H9kEIXEvWD0VcLtzpkstQU3ojpnYs8OoqdonHa0EmLqExJUPNrbLIF1bOhXJ9lf
        iNTGE7tp2rs8BRXxkl6ZyLMerqUh306UAne8gDtetlILJJDx9KaWswxuFQiCnfiU
        mpp9J/5H2yzxVuTPSBiINz4gNSxvaGrkmKOVA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O9fA/CIP3ZwUWSqf7loiQBiTu/mRU35z
        EZJGJ0XMJisPRUmpqStn0aoJmxnASo4fHuDidKjBrqb7au8uaX6iM6dF2kjfNaA2
        t2Lm4xTW450aPRHWn9VtBtbbCQGSDAh2hdLXnJQNIURGDfcdcuhP4KG1TKUAkfjX
        rm/5d8DyYOk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7BC6AE5924;
        Tue, 18 Aug 2020 15:44:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C13EDE5923;
        Tue, 18 Aug 2020 15:44:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 0/2] add p in C tweaks
References: <pull.702.git.1597670589.gitgitgadget@gmail.com>
Date:   Tue, 18 Aug 2020 12:44:42 -0700
In-Reply-To: <pull.702.git.1597670589.gitgitgadget@gmail.com> (Phillip Wood
        via GitGitGadget's message of "Mon, 17 Aug 2020 13:23:06 +0000")
Message-ID: <xmqqmu2ryc0l.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 438A755E-E18B-11EA-B2CA-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> A code cleanup and small bug fix for the C version of add -p
>
> dscho has pointed out that the bug fix in the second patch gets lost in the
> other changes and suggested adding the last member of the enum (which fixes
> the bug with handling 'e') as a separate patch. I'm unsure as it feels odd
> to split up the introduction of the flags - I'd be interested to hear what
> others think.

Essentially, the original was doing:

    - In early part of patch_update_file(), decide what option to show
      in s->buf using "if (undecided_previous >= 0)" etc. boolean
      expression that is tailored for each command;

    - In later part of patch_update_file(), after getting an answer
      to the end user, try to use the same boolean expression that
      is tailored for each command to see if the given command is
      acceptable.

and the bug was that each pair of boolean expressions that are
supposed to be identical were duplicated in two places, and one pair
was not identical by mistake.

Your [2/2] fixes it by turning the above to

    - In early part of patch_update_file(), decide what option to show
      in s->buf using "if (undecided_previous >= 0)" etc. boolean
      expression that is tailored for each command, *AND* record the
      fact that the command is allowed in the permitted bitmask.

    - In later part of patch_update_file(), after getting an answer
      to the end user, consult the permitted bitmask computed
      earlier to see if the given command is acceptable.

Since there no longer is duplicated boolean expressions that are
supposed to be the same but different by a bug, once this conversion
is made, it is impossible to have the bug.  For that reason, I do
not think the suggested split makes much sense.

A much saner split, if we have to split this step into two, would be
to first fix the bug keeping the code structure of the original,
i.e. the later part guards the 'e' command with

	if (hunk_index + 1 == file_diff->mode_change)

but the earlier part also required !file_diff->deleted, i.e. the
condition should have been

	if (hunk_index + 1 > file_diff->mode_change && !file_diff->deleted)

So without introducing enum and permitted bitmask, you can fix the
bug in place, replacing the incorrect boolean condition in the later
part that guards the 'e' command with a corrected one.  That would
be a minimum fix that can become your new [2/2], whose theme is "to
fix the bug with minumum change".

On top of that, you can convert the function again to reach the
final shape that writes each boolean condition only once and records
the permitted commands in the bitmask.  That can be your new [3/2],
whose these is "to make it impossible to introduce the bug previous
step fixed".


> Phillip Wood (2):
>   add -p: use ALLOC_GROW_BY instead of ALLOW_GROW
>   add -p: fix checking of user input
>
>  add-patch.c | 67 +++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 42 insertions(+), 25 deletions(-)
>
>
> base-commit: 47ae905ffb98cc4d4fd90083da6bc8dab55d9ecc
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-702%2Fphillipwood%2Fwip%2Fadd-p-fixes-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-702/phillipwood/wip/add-p-fixes-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/702
