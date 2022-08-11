Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14E8C19F2A
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 17:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbiHKRKa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 13:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235099AbiHKRKL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 13:10:11 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2311A8CC7
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 09:43:13 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B672E154530;
        Thu, 11 Aug 2022 12:43:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Lat+4GzcWo9jKvAcbduuFi2B9NlCoP2KjKfS16
        38lhc=; b=CxQZqRqPDoVd+/KVJg8k0NK6DOEvUCItDRL4L0ZUfK4VVhUfSIE/EU
        Ab5QabcUBdWU1MWKMfAckVZA4lo5anHMeNaGrI+J4KVwNfcffqfTQ6cHPnlgpkpc
        9U7anNpZX+QTdMCPioPxicIEOVuOal1Lrvzy1hJI5gEojfaQenc/M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC82115452F;
        Thu, 11 Aug 2022 12:43:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 18C5A15452E;
        Thu, 11 Aug 2022 12:43:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Noam Yorav-Raphael <noamraph@gmail.com>, git@vger.kernel.org
Subject: Re: Fwd: Idea: add --squash to cherry-pick
References: <CAO8o=D6p+aFOeRdTDHwPa1E+V45Uqh-TuSZbz0WU=rE-ksGj_w@mail.gmail.com>
        <CAO8o=D7QC71mnyKSceMpYJzVO4=POva=mJQ1bi0teUHPB9xesA@mail.gmail.com>
        <a4c937ed-ea89-0564-db64-f0634fe7eeee@kdbg.org>
Date:   Thu, 11 Aug 2022 09:43:10 -0700
In-Reply-To: <a4c937ed-ea89-0564-db64-f0634fe7eeee@kdbg.org> (Johannes Sixt's
        message of "Thu, 11 Aug 2022 17:42:15 +0200")
Message-ID: <xmqqzggag28x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B03F8692-1994-11ED-BFA2-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> That question on Stackoverflow asks "how to do X with Y". But Y (git
> cherry-pick) is the wrong tool to do X (apply commits from a branch to
> somewhere else in squashed form).
>
>    git diff A...B | git apply --3way
>
> would do what you want. You would have to come up with a new commit
> message anyway, so cherry-pick would be of little use there.

I do agree that cherry-pick is not the best solution for that XY
problem, but in a typical undisciplined development work, it is not
entirely implausible that pieces from original commit message may
still be of some use, exactly the same way as people would want to
use "squash" while "rebase -i".  Most commits may have completely
unusable "oops fix", "worked more", etc. messages, but some of them
may summarize what the past handful steps with such garbage messages
have done, which may be worth salvaging.

If I were solving the XY problem, I would probably use "rebase -i".

To transplant the range A..B of the history on top of HEAD, for
example, I'd start with (notice ^0 after B, as I do not trust myself
so I'd leave the true branch B untouched as I may make mistakes
while running rebase):

    $ git checkout --detach HEAD	;# this is only to use @{-1} later
    $ git rebase -i --onto HEAD A B^0

Then if my goal is to squash everything down into a single commit,
then replace all 'pick', except for the first one, to 'squash'.
That will give me one single chance to edit a single commit message,
but the editor buffer starts with the log message from all of the
original, so I can pick good bits from them while writing new stuf.

I'll have the result on detached HEAD.  If I like the result, I may
update the branch I was originally on with it.

    $ git checkout -B @{-1}

Or, if I don't, perhaps because I made mistakes, then I can just
discard it and go back to the original branch.

    $ git checkout @{-1}

