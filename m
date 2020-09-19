Return-Path: <SRS0=5dtp=C4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C9CC43464
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 17:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71AF921707
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 17:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LfTOjiYs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgISRsF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Sep 2020 13:48:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52612 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgISRsF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Sep 2020 13:48:05 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD5A6716AD;
        Sat, 19 Sep 2020 13:48:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nr3PRD9Eo11XZHHmBQn7LbN9BXk=; b=LfTOji
        Ysvb7o5B4WubWvJvbiYyKLJkvhirRLYW5N0i6vJUJ8fCFzNcyglf/CkNCEKAA9My
        KbszEbZMluW9+ZDqkNIX2lGjX/Sfv0Emv73Rapp3ZyU5tDPMu52B5z7eSvv35Rnf
        lxWRynnB+of8q4lW07g0qXrcPD/MNgnjW9VnM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rc8vS8+9hM2QAAs7AQcUGVYkwJSnB858
        gYHfJ6zGFzpPYS+oFZGUFpcSE3RO1i0WK+cG4FoBELtUOKQXq3YpzIzzPZX7QlMb
        xBhjGaHtYUbIW6V8L9+jd6asHQpl/HKn05MCif/0XoPzV0cHPInlKjfuvN5BrE6C
        F5tKnqh7miE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B45E7716AA;
        Sat, 19 Sep 2020 13:48:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 37B4D716A9;
        Sat, 19 Sep 2020 13:48:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] push: make `--force-with-lease[=<ref>]` safer
References: <20200904185147.77439-1-shrinidhi.kaushik@gmail.com>
        <nycvar.QRO.7.76.6.2009072119350.56@tvgsbejvaqbjf.bet>
        <xmqqr1rcxdsu.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2009090542430.54@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.2009101220400.56@tvgsbejvaqbjf.bet>
        <20200910144456.GA25125@mail.clickyotomy.dev>
        <nycvar.QRO.7.76.6.2009120013070.56@tvgsbejvaqbjf.bet>
        <xmqqk0wwjf4p.fsf@gitster.c.googlers.com>
        <20200916053141.GA29901@mail.clickyotomy.dev>
        <nycvar.QRO.7.76.6.2009161214030.56@tvgsbejvaqbjf.bet>
Date:   Sat, 19 Sep 2020 10:48:00 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2009161214030.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 16 Sep 2020 12:20:46 +0200 (CEST)")
Message-ID: <xmqqsgbdk69b.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 438123B8-FAA0-11EA-B053-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> No, I don't think that would suffice. For several reasons:
>
> - the user could have checked out the remote-tracking branch directly
>   (`git switch --detach origin/my-branch`), as opposed to actually
>   integrating the revision into the branch at some stage. I know that I do
>   that sometimes.
>
> - even if the remote-tracking branch has not been checked out directly, it
>   might have been `git pull --rebase`d into a _different_ branch, in which
>   case the reflog of `HEAD` would say "yep, I saw this commit!" but that
>   would not mean that it was integrated into the branch we want to
>   (force-)push.
>
> - the reflog of the `HEAD` is worktree-specific, and if the user pushes
>   from a different worktree (e.g. to push multiple branches at the same
>   time, or because the push is scripted and run from a different working
>   directory), it would be missed.
>
> - and if we take a little step back, we do see that the reflog of `HEAD`
>   _does_ answer a different question from what we actually asked.
>
> Sure, it would be faster, but is that worth the consequences?

It is not about "would be faster" but is trying to be more inclusive
of different workflows.

One minor downside consequence of not looking at the reflog of HEAD
is that it does not make the new option useful for those who could
benefit from it.

They detach HEAD at the tip of the remote-tracking branch, work on
the replacement history while on the detached HEAD, and then force
update the local branch from there once they are done (this is a
variant to the first one you said you "do sometimes").  This is a
handy technique to allow them to always compare the previous round
of their effort (which is untouched while they prepare the new
iteration on detached HEAD) with what they achieved so far on HEAD.

After finishing, they would go on to deal with other branches, so
the local branch prepared to be force-pushed may no longer be the
current one.  Without checking with the reflog of HEAD, there is no
way to notice that the local branch to be force-pushed (which no
longer is the current branch) was built using the commit at the tip
of the remote-tracking branch we are losing, because the branch's
reflog would have only one entry that records where it was before
adjusting for the updated remote-tracking branch, and where it is
now after rebuilding.

It is inevitable for a heuristics like the one that was proposed to
work only for those with some workflows while excluding those with
some other workflows, and that is why I said it is "minor" downside
that it does not make the feature useful for some people who could
potentially benefit and also that is why I think it is perfectly OK
to draw the line there and not support them.  After all, the line
has to be drawn somewhere, and the looser the heuristics are, the
wider the potential audience *and* at the same time the wider the
potential of false positives.

Where we drew the line and its consequences must be communicated
clearly in the documentation, though.

Thanks.
