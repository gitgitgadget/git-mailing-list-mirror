Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855D5C4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 10:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FD312222A
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 10:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgLOK7G (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 05:59:06 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65338 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbgLOK64 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 05:58:56 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 46CE3991EF;
        Tue, 15 Dec 2020 05:58:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=bp2nB6N9q7RHx0Fv0LSs9xe5iIY=; b=w9UaSdzdcztoO96Bx4FX
        5xsR+a489/v3izzzBl6pHmPDQ7DcY07a2QhCUiV0gUmz4lCAC8fgdrkNnwigONUs
        4uC0ENh93Om5Lsh4UNVuU5haYKR9m0cIzbYMwSAnCYWIO0ftKapJUFFEQ21gAVA3
        6SiyOiKeIFqyHk2fdqCX7O0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=GNEnBEV/gB40rbvDlbqEEAcOPamFiuCbQEnocCml4PrfHY
        P/Rfvn/EO8mD8jqLZgosnib+HuUjO/EeuxD0gtrUTl1Jzs29qBdmRdzNio65xrEL
        4I8aollK9B4BUCIrbUjyBMWPEb/AeyeuYiAwhSTQ60rZb+PO16pUKaKD3HXzA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E2C6991EC;
        Tue, 15 Dec 2020 05:58:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B6C0C991EB;
        Tue, 15 Dec 2020 05:58:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 0/5] making pull advice not to trigger when unneeded
References: <20201214202647.3340193-1-gitster@pobox.com>
        <5fd85811c3a6_d7c48208aa@natae.notmuch>
Date:   Tue, 15 Dec 2020 02:58:05 -0800
Message-ID: <xmqqmtyf8hfm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6964C6EE-3EC4-11EB-B38C-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> To avoid the ugly-looking "strcmp()" in the above, we may need to
>> adjust "--ff" (fast-forward without creating an extra merge commit)
>> and "--no-ff" (create an extra merge commit when the history could
>> be fast-forwarded) to imply "merge", though.
>> ...
>
> Or do you mean --ff doesn't override --rebase? Therefore it's more of an
> internal conceptual change.

I meant "--ff/--no-ff" without saying anything between merge and
rebase would make merge implied.  It was merely for the purpose of
getting rid of !opt_ff in the condition there and such an implied
merge would be one way to ensure that rebase_unspecified becomes
false.

"--no-ff --rebase" (in any order) would be a nonsense combination,
as it asks "please create an extra merge commit even when the
history fast-forwards, but by the way I do not want merge I want
rebase" [*1*].  It should error out when the history fast-forwards,
I think, and it probably should also error out when the history does
not fast-forward, instead of rebasing.

"--ff --rebase" (in any order), on the other hand, would be "if the
history fast-forwards, just do so without creating an extra merge
commit, by the way, I prefer rebase and not merge".  If the history
fast-forwards, it is OK to just fast-forward (using the merge
backend if needed), as rebasing against the history that is ahead of
us would mean all our unique development since we diverged from them,
which is nothing, will be replayed on top of their history.  If the
history does not fast-forward, then the precondition of "--ff" part
does not hold, so just rebasing as if "--ff" does not exist would
probably be OK, too.

In any case, I haven't thought the opt_ff part of the expression
through.  During the review of v5 3/3 (and doing v7 5/5), what I was
more interested in was to ensure the verbosity option, which would
control how verbose a message we should be giving, can stay
independent of other conditionals, which would control if we even
need to error out and/or give hints.

Thanks.


[Footnote]

*1* Even though the current code may simply ignore --no-ff after the
control is given to the rebase codepath,
