Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E1BC4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 17:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 471C860C40
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 17:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhG2RJO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 13:09:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59011 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhG2RJO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 13:09:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D343E1795;
        Thu, 29 Jul 2021 13:09:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=grTY2aIS9zgv3GR5gMkX5K1PVymxaA6GTP0auz
        mvaqc=; b=SJonMedUpkEFY0ZtDotN+stu1eXhnprBNH5puh2O/6LmuT/wUGe0Mu
        USRqwnYW9c2fr2v2WB3/Jk8aB5cy/LdbGqjDoIBHzKi7uVoTixxJGDMypkDz5kgt
        vxIPPfaoVm9pf6f9dUe/IdI3sCS1R/87LIJlnLne+cF52CB8QcGow=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 857BBE1794;
        Thu, 29 Jul 2021 13:09:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 06FF5E1793;
        Thu, 29 Jul 2021 13:09:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Daniel Knittl-Frank <knittl89@googlemail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Using two-dot range notation in `git rebase`?
References: <b3b5f044-8c76-ec71-45d6-1c7fea93c519@iee.email>
        <CACx-yZ1Je+tnZdJ21gDPeuQa-QTuY2t9mDujNr7wqJWFMwwzxA@mail.gmail.com>
        <dc7668ff-37ad-1d9e-fc92-df432549b4e2@iee.email>
        <YQKBNXsMdroX3DfY@coredump.intra.peff.net>
Date:   Thu, 29 Jul 2021 10:09:09 -0700
In-Reply-To: <YQKBNXsMdroX3DfY@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 29 Jul 2021 06:21:41 -0400")
Message-ID: <xmqqv94t59oq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B0B388DC-F08F-11EB-8711-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I do think "git rebase --onto here old..end" is a sensible thing to ask
> for. If we were designing it today, I'd probably suggest that rebase
> take arbitrary revision sets (and either require "--onto", or perhaps as
> long as there is only one negative tip given, that becomes the "--onto"
> point).

The unfortunate origin of "rebase" makes this a bit awkward.  If it
were a tool to cherry-pick multiple commits on top of the current
commit ("on arbitrary point" is trivially implemented by first
checking that point out and make it cuttent), the range notation
would have made a lot more sense, and I think it indeed is what the
multi-pick kind of "git cherry-pick" today does.

But "rebase" is a tool to "rebase a branch", and it is done by
replaying the history leading to the tip of a given branch (the one
that is currently checked out being the default) on top of another
commit.  So its parameters serve dual purpose---which part of the
commit DAG to take commits to be replayed from *and* which branch
will be used to point at the tip of the resulting rewritten history.

If you can forget the latter, then multi-pick cherry-pick is already
there [*1*].

Before revision.c API was extended to learn rev_cmdline_info, taking
an "extended SHA-1" expression (e.g. A..B~2) from the user, and
ensuring there is only one positive tip and it is given as a branch
name was simply too cumbersome and error prone.  I do not offhand
know the current rev_cmdline_info is sufficiently rich to allow us
do so.

For the simplest "git rebase [--onto newbase] oldbase..tip", I do
not think it is such a big deal to type it with .. replaced with a
single SP, so I do not necessarily agree with you that it is a
sensible thing to ask for.

[Footnote]

*1* There is an issue in multi-pick "git cherry-pick" that I cannot
    replace my daily use of "git rebase" with it.  It does not honor
    notes rewriting and I lose the notes/amlog records.  This is
    unfortunately by design (for the same reason why the "-x" option
    lost its default status from cherry-pick, the tool tries to
    dissociate the resulting commit as much from the original commit
    as possible, and carrying forward notes attached to the original
    to the rewritten goes against that spirit).

