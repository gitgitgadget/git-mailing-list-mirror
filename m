Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48305C433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 22:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C73861289
	for <git@archiver.kernel.org>; Thu,  6 May 2021 22:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhEFWef (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 18:34:35 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53325 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhEFWef (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 18:34:35 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 57F361285C3;
        Thu,  6 May 2021 18:33:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ms4LTBrNbKATOOq5j7bg0WXDQOnYpWWTYSckid
        60g3g=; b=NNl2FghLB/nfAd58AHZR9ehXdRSvJfQb3AOVbPytIFw9zZJ/7RihZC
        /2kyjRmOBU7OGq/IaWSHtZKGwDhu69EUq2A5evrQkKenhoUjWezWymrzVrNBDPzo
        P7oTVZhiP/nnvfjkvAb1KPvrvcXvczrOMMphu4OQsbRWJLF2060eg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3C1691285C2;
        Thu,  6 May 2021 18:33:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 619621285C1;
        Thu,  6 May 2021 18:33:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Firmin Martin <firminmartin24@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v1 0/8] format-patch: introduce --confirm-overwrite
References: <20210506165102.123739-1-firminmartin24@gmail.com>
Date:   Fri, 07 May 2021 07:33:31 +0900
In-Reply-To: <20210506165102.123739-1-firminmartin24@gmail.com> (Firmin
        Martin's message of "Thu, 6 May 2021 18:50:54 +0200")
Message-ID: <xmqqv97vwkzo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1712CE7E-AEBB-11EB-BA41-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Firmin Martin <firminmartin24@gmail.com> writes:

> Particulary, this behaviour could be awkward in the following
> hypothetical situations:
>
> * The user can easily erase a cover letter coming from prior versions or
> another patch series by reusing an old command line (e.g. autocompleted
> from the shell history).

"prior versions" implies that the user is better off using -v$n
where $n is the number greater than the one used for the prior
iteration by one, and there won't be any overwriting, so this is not
a very compelling use case.

But the next one is real.

> * Assuming that the user is writing a cover letter and realizes that
> small changes should be made. They make the change, amend and
> format-patch again to regenerate patches. If it happens that they use
> the same command again (e.g. with --cover-letter), the cover letter
> being written is gone.

Yes, after preparing, say, -v2, but before sending them out, it is
very plausible that proofreading of your own patches may make you
realize more issues in the series, which may make you go back to your
commits, "rebase -i" to improve them and re-run "format-patch -v2".

We do want to encourage such careful preparation of your patch
series before sending it out, and we want to support it well with
our tools.  Preventing overwriting of the cover (which will have the
same filename, with the same v2- prefix) is very valuable here.

There is another thing that I suspect people may find irritating in
the same workflow.  If you fix the commit title while "rebase -i" to
polish your v2 patch, it would result in a different filename from
the original v2, so you'd end up with something like

    v2-0000-cover-letter.patch
    v2-0001-thes-forny-change.patch
    v2-0001-this-phoney-change.patch
    v2-0002-another-sample-change.patch

while redoing a two-patch series.  The "thes-forny" thing is a
leftover from the first "format-patch -v2" run, you fixed typoes
with "rebase -i" after a self-review and other three files have the
result of the second "format-patch -v2" run.  You need a way to
somehow exclude that stale file when driving send-email; in other
words, before running

    git send-email v2-*.patch

you would want to move away v2-0001-thes-forny-change.patch that no
longer is part of the series.  I wonder if format-patch can help by
looking at the output directory before writing its output and move
the old files away, say, to "old-v2-*.patch" or something?  That
incidentally would solve your "files getting overwritten is
irritating" issue at the same time.

Coming back to the topic of cover letter, even when there is no risk
of ovetwriting, there is another thing we may want to improve to
help our users.  Suppose you are preparing your v2 patch after
sending out the v1.  The cover letter we generate for v2 will have
the same **BOILERPLATE** placeholders that need to be filled from
scratch.  As many things you wrote for the cover letter in the
previous round should be reusable, even though the list of titles of
the patch should be generated afresh, it would be nice if
format-patch can carry forward what you wrote in the cover letter
for the v1 iteration to the cover letter for this v2 iteration.

And when we have such a "reuse description in the existing cover
letter" support, the value of "don't overwrite" knob will mostly go
away.  Instead of failing the command by refusing to overwrite, you
can read what is in the existing cover-letter that is about to be
overwritten, combine the hand-written description with the material
automatically generated, and ovewrite the existing file, and as long
as you do a good job of preserving, nobody would complain that you
overwrote the file.

