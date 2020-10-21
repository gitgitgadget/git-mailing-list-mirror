Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155C1C4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 19:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D3C224171
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 19:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wEnR+2Im"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406235AbgJUTqO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 15:46:14 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61659 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405923AbgJUTqO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 15:46:14 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 145F0FDCE6;
        Wed, 21 Oct 2020 15:46:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MZM6UigWeX12gpMxJg+otvHcB/I=; b=wEnR+2
        ImnTb50uZdrpcotOrLvOxKc3QvwVRum1dglGXeZrFey686Cp2vvKnjXO5J3asxnl
        Y/IP91Gzxs3a8OZb7VXV2GStTZWCWrGqgCj48R8Q3wwc84q/SH4OahV2DT+bcnq9
        i1ACP7P4Uhao2vefgcODGnXYMXqh3jgeWrn+w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=D5IZ6PMjz0zY1pm1Df4i3Uq6FWaxsQgS
        6Abe4bWuzRYtPUWseAMFV0wrZm3oUldaU71FCIOiQZiFJtKZGwnZvYJv/9aAy2Li
        QXjpPe/fOHUNdy0n0/VOrdWktV1U501bP4k9AUcSX89JwgyUm7KEGG2IwOOPAj7Q
        MlWkLgYat9M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0D53EFDCE5;
        Wed, 21 Oct 2020 15:46:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 247A4FDCE1;
        Wed, 21 Oct 2020 15:46:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] sequencer: allow metadata to be saved if using
 cherry-pick --no-commit
References: <20201021062430.2029566-1-eantoranz@gmail.com>
Date:   Wed, 21 Oct 2020 12:46:05 -0700
In-Reply-To: <20201021062430.2029566-1-eantoranz@gmail.com> (Edmundo Carmona
        Antoranz's message of "Wed, 21 Oct 2020 00:24:30 -0600")
Message-ID: <xmqqv9f37476.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0FA9F2BE-13D6-11EB-856C-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Edmundo Carmona Antoranz <eantoranz@gmail.com> writes:

> Currently, if 'git cherry-pick --no-commit' is run _and the cherry-pick
> operation is successful_, the metadata from the original revision is lost and
> to git it's like a cherry-pick operation is not taking place at all. Hence,
> we can't wrap up the cherry-pick operation by calling
> 'git cherry-pick --continue'.

This cuts both ways, though.

I often use the "--no-commit" form of the command as a better
version of the 'git show $that_commit | git apply --index' pipeline,
and what I'll do starting from the working tree that I prepare that
way is often *not* to commit it exactly or even use any data from
the original commit.

So a change like this would make the use of the command for my
usecase more cumbersome---now it leaves cruft behind, so I need to
clean it up later, but with what?  "cherry-pick --abort" would
try to muck with the index and the working tree, but that is not
definitely what I want.

So, personally, I am fairly negative on this line of change.  If the
user says upfront "--no-commit", then user does not want a commit,
so why should we even allow "--continue"?

Before dismissing the idea totally, let's see what potential use
cases this change _could_ benefit, and see if there are already ways
to satisfy these use cases without making this change.  For example,
if the user wants to examine the result before actually "committing"
to move the target branch forward with this change, keeping it an
option to back out if the result of cherry-picking turns out to be
bad, the "--no-commit first, examine, and --continue or --abort"
sequence may help such a workflow.

But the user can already do so without this change:

    $ git checkout target_branch^0 ;#detach
    $ git cherry-pick source_branch
    ... examine the result ...
    ... and if it is satisfactory ...
    $ git checkout -B target_branch
    ... or if it is not, then discard ...
    $ git checkout target_branch

> With this patch, we allow sequencer to save the metadata from the original
> cherry-pick operation so that 'git cherry-pick --continue' can be called.

