Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A683C433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 18:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbiDVSLz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 14:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbiDVSGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 14:06:16 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC68E2B00
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 11:03:20 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EB3CA135587;
        Fri, 22 Apr 2022 13:26:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gq6pUJfry3gU4hRFT/MHtQVLEYMXkZd3/3Frcz
        EEWZ8=; b=DA6gXdge0anYnTbUdrro4C+k/xkwdTQsHfaHH8XFOe1At1sYBAxZbq
        EFY1Sig7doamOOUbdwLFSNoFiEN+gV8PFo/uczs5DlPIo2ZCsJH/zsyo3gi0pYX1
        ZuVRDzGQZvtcDPh8BsN4vKVvHlpG6aouvUunOc64RfufjXQ2OwUjk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E3179135586;
        Fri, 22 Apr 2022 13:26:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 58C34135585;
        Fri, 22 Apr 2022 13:26:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "gdd via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        gdd <gregory.david@p1sec.com>
Subject: Re: [PATCH] show-branch: fix SEGFAULT on both --current & --reflog
References: <pull.1222.git.1650634704191.gitgitgadget@gmail.com>
Date:   Fri, 22 Apr 2022 10:26:22 -0700
In-Reply-To: <pull.1222.git.1650634704191.gitgitgadget@gmail.com> (gdd via
        GitGitGadget's message of "Fri, 22 Apr 2022 13:38:24 +0000")
Message-ID: <xmqqv8v19ght.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 54E8B3F2-C261-11EC-8F91-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"gdd via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Gregory DAVID <gregory.david@p1sec.com>
>
> If run `show-branch` with `--current` and `--reflog` simultaneously, a
> SEGFAULT appears.

Thanks for noticing.  As I said elsewhere, "--current" was invented
for the sole purpose of being used together with branches and
individual commits, not in "--reflog" or "--merge-base" modes.

And as I also said elsewhere, I do not think of a good reason why a
user would want to use these two together.

Can you tell us a bit more about what you were trying to achieve
when you used them together?

While waiting for your (and others) valid use cases I probably have
missed (I said "do not think of" above, not "I think there cannot
be"), let's speculate what sensible meaning the combination could
have.

As is clear from an existing error when two branches are given:

    $ git show-branch --reflog master maint
    fatal: --reflog option needs one branch name

the "--reflog" mode is not even prepared to work with more than one
branch.  It is to show reflog entries taken from one branch (it
could be HEAD)'s reflog.

But "--current" is about "Among the branches I listed on the command
line, the current branch may or may not be included. If not, please
pretend as if I had the current branch there, too".

So, if we said

    $ git show-branch --reflog --current maint

while we are on 'master' branch, that is the same as saying

    $ git show-branch --reflog master maint

which should get a usage error, and if we are on 'maint' branch,
then maint is already there, so there is no point in giving
'--current' to begin with.

Because

    $ git show-branch --reflog

defaults to showing the reflog entries from current branch,

    $ git show-branch --reflog --current 

hoping that it would show the reflog entries of the current branch
is indeed a plausible interpretation, but even in this case, it is
not necessary to give "--current".

So, unless there is a reason why it makes sense to enumerate recent
reflog entries from a branch *and* the tip of the current branch at
the same time, I am very much inclined to make it clear that
"--reflog" and "--current" are mutually incompatible by making it an
error to give both.

In addition, we _could_ allow a command line with "--reflog --current"
and nothing else on it, and ignore "--current" only in that case, to
"support" the "plausible interpretation" above, but I do not think
it is worth it.

> It seems that it has been introduced in: Commit 1aa68d6735
> (show-branch: --current includes the current branch., 2006-01-11)

Yes, the commit should have noticed the invalid combination of
options were given and errored out.  Since omission of such a check
lead to a segfaulting bug without producing any useful output, it
is safe to make it an error to give these options at the same time.

Thanks.
