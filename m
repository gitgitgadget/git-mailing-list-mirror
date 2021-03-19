Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0098C433E0
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 15:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 912B461960
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 15:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhCSPyR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 11:54:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50628 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhCSPxw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 11:53:52 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CE68DB59CA;
        Fri, 19 Mar 2021 11:53:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3p6prE4cWNLl1KMTyVHRbSWlWyY=; b=ZV8qwm
        9UXnEVXPQFs3P7FGqyMF8iK2XwL2iEIk9OPjt4EOMlWUrzAJxNU70eCXsuNA8fg8
        9iLl6/uuZVUcLLtiYWIxpS/D64CzIgOHqBX1M79X9lEiW2itF4T2ptsPnOY8AyN2
        uniudBbEUiidZk5VbiXpN9Jbw9w4NGce+y0Cg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EV0ZfcyAudpC0QkYl6pysrPMo/fzl+gz
        eX2f3EhSbY+hLKSPjBeJGu7J16ftwuWe5Xfh3XInctpy2FkN/e++58xXp4+EU6lA
        opESD4xnfq46pw/SIQevZHgUcE4VgOfizkycszsAzdhk+USWPQM7RxU/ql6c9VQV
        t5q6NxSX8Us=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C6968B59C9;
        Fri, 19 Mar 2021 11:53:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 53039B59C8;
        Fri, 19 Mar 2021 11:53:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [RESEND PATCH 2/3] git-completion.bash: fix `git <args>...
 stash branch` bug
References: <cover.1615855962.git.liu.denton@gmail.com>
        <cover.1616060793.git.liu.denton@gmail.com>
        <be727d0171b16e488a357a959176e60bf9210d40.1616060793.git.liu.denton@gmail.com>
        <xmqqsg4sryq9.fsf@gitster.g> <YFRbM1st0yINtScF@generichostname>
Date:   Fri, 19 Mar 2021 08:53:50 -0700
In-Reply-To: <YFRbM1st0yINtScF@generichostname> (Denton Liu's message of "Fri,
        19 Mar 2021 01:05:07 -0700")
Message-ID: <xmqqy2ejnnqp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4CD2CE26-88CB-11EB-A97B-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Good observation. _git_stash() is called in the body of
> __git_complete_command() which is called by __git_main(). There is
> currently no mechanism by which to pass the index of the command over to
> _git_*() completion functions.

I think, given that "set | grep _git" tells us we use many globals
already, it would be OK to introduce another variable, call it
$__git_subcmd_pos, and assign to it when the command dispatcher
discovers which token on the command line is the subcommand name and
decides to call the subcommand specific completion helper function.

Or does the command dispatcher not exactly know the position
(e.g. iterates with "for w" and knows $w==stash in the current
iteration but it is not counting the position in the array)?  If so,
then we'd need a surgery larger than that.

But if we only need to set a variable, we won't have to change the
calling convention of these helpers (well, we shouldn't be changing
the arguments to completion functions lightly anyway---third-party
completion functions can be called from __git_complete_command, if I
am reading the code correctly, and we cannot update them all even if
we wanted to).

And most subcommands that do not care where on the command line the
subcommand name is won't have to change anything.

> That being said, passing in the index to all functions would definitely
> be doable. I can work on a series in the future that passes in the index
> of the command so that working with $cword is more robust but I'd prefer
> if that were handled outside this series to keep it focused.

If the breakage of "stash branch" were a serious show-stopper bug
that needs to be fixed right away, I would agree that a band-aid
solution that would work most of the time would be fine, but I
didn't get an impression that it is so urgent and we can afford to
fix it right this time, together with the other completion that
share the same problem (you mentioned _git_worktree IIRC).

Thanks.
