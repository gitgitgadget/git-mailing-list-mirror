Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3777AC433F5
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 22:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377968AbiATW3y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 17:29:54 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50472 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377962AbiATW3y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 17:29:54 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 89CB2116B2F;
        Thu, 20 Jan 2022 17:29:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1NvOhjavD034
        o22YJ2/bCQx+iK9Cn/5aJzpKKF1RjdA=; b=l4IexCBlgTei11B/mPc3oygjzCFF
        fDT0e9S8aCsj2oPlDm6DCLrB0hC+1OCDwlRdfoCq5DXYF95ldt7ESzrUZbaetSl7
        IP/3EFLwKd3wOA51PwO8GrodpNtoz1S02/1lSgi2Ien5L4H0js5ymvYzmjx9Lzup
        trFSkpWpsiN90io=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 818FD116B2E;
        Thu, 20 Jan 2022 17:29:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E4C03116B2B;
        Thu, 20 Jan 2022 17:29:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Todd Zullinger <tmz@pobox.com>,
        Petr =?utf-8?B?xaBwbMOtY2hhbA==?= <psplicha@redhat.com>
Subject: Re: [PATCH] checkout: fix BUG() case in 9081a421a6
References: <YemTGQZ97vAPUPY0@pobox.com>
        <patch-1.1-21ddf7c628d-20220120T212233Z-avarab@gmail.com>
Date:   Thu, 20 Jan 2022 14:29:51 -0800
In-Reply-To: <patch-1.1-21ddf7c628d-20220120T212233Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 20 Jan
 2022 22:26:57 +0100")
Message-ID: <xmqqee52ghwg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7CA86F18-7A40-11EC-96E3-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Fix a regression in my 9081a421a6d (checkout: fix "branch info" memory
> leaks, 2021-11-16) where I'd assumed that the old_branch_info.path
> would have to start with refs/heads/*, but as has been reported[1]
> that's not the case.
>
> As a test case[2] to reproduce this shows the second "git checkout"
> here runs into the BUG() in the pre-image. The test being added is
> amended from[2] and will pass both with this change, and before
> 9081a421a6. I.e. our behavior now is again the same as before that
> commit.

> +test_expect_success REFFILES 'checkout a branch without refs/heads/* p=
refix' '
> +	git clone --no-tags . repo-odd-prefix &&
> +	(
> +		cd repo-odd-prefix &&
> +
> +		cp .git/refs/remotes/origin/HEAD .git/refs/heads/a-branch &&

I am not sure if this is a sensible test case to begin with.

It sets up recursive symbolic ref in this way:

	HEAD points at refs/heads/a-branch
	refs/heads/a-branch points at refs/remotes/origin/HEAD
	refs/remotes/origin/HEAD points at refs/remotes/origin/branch1

The checked out branch (i.e. what HEAD points at) is nominally a
local branch, but it totally violates the spirit of the safety valve
that says "HEAD" MUST point at a local branch or otherwise it is
detached.  Creating a commit while "a-branch" is checked out would
not affect *ANY* local branch state and instead makes an update to
the remote tracking branch that does not reflect *any* past states
at the remote repository.  Even worse, a "git fetch" that updates
the remote tracking branches will make the HEAD, the index and the
working tree into an inconsistent state.

Simply put, I think the BUG() is catching a case where we should
have been diagnosing as a broken repository.

So from my point of view, BUG() is indeed inappropriate because what
the conditional statement noticed was a broken repository, and not a
programming bug.

What we should never do is to promise this "only kosher in letter
but not in spirit" violation of "HEAD must point at a local branch"
rule will be supported.

So, unless I hear more convincing arguments (and Todd's example or
anything similar that makes "git commit" from that state update a
ref outside local branches is *not*), I am hesitant to call the new
behaviour and 9081a421a6d a regression.

What did the code before that BUG() do when faced with this nonsense
configuration?  If forbidding outright broke a sensible workflow
that happened to have been "working", I am OK to demote it to
warning() and restore the previous behaviour temporarily, whatever
it was (I think it was just old_branch_info.name was left unset
because we were not on local branch, but I don't know if the missing
.name was making any irrecoverable damage).  But the longer term
direction should be that we treat the "update HEAD ends up updating
some ref outside refs/heads/" a longstanding bug that needs to be
fixed.

Thanks.

