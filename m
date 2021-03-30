Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA89C433DB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 21:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1543619CA
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 21:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbhC3VK6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 17:10:58 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52987 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbhC3VK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 17:10:26 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3503D11ABFF;
        Tue, 30 Mar 2021 17:10:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fY19dpGBoAaW5jtuhaOMXxxuS3s=; b=tVXGy+
        rhWLt3ugNY4FKwAVZZIJAASDGRFscH22PE4DRPlJTW5YiGTGCV9GRMZtoc4OAH5s
        zgzLR4IxUGKelG0GrqGpiiZXMDjBdRBtzKw5b9iNVDc+LT1mYrZv6xrBfwKjbe5j
        UmclF/cxF10ObQa42b1u0Q3c8Cfhem4ppl3e0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kAD+Q4ENarrGOCTAxt1IEkq3D6oOvT9c
        MWVVfpEJZHcHFpT9aGeQVXJn7/LBl1rLFyVFYu8l34aA5e99c1khSzMzEfx2XxRA
        kw01Fgh3Nt4kEARMC3dyAklMOogbYVZ0W66AJAv8YLBGS/p2uRcLoF/84ueKexVd
        4fLJvUucv+Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2E9B911ABFE;
        Tue, 30 Mar 2021 17:10:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 640FC11ABFB;
        Tue, 30 Mar 2021 17:10:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [Bug] worktree prune --expires
References: <011901d72596$e5ed8670$b1c89350$@nexbridge.com>
Date:   Tue, 30 Mar 2021 14:10:21 -0700
In-Reply-To: <011901d72596$e5ed8670$b1c89350$@nexbridge.com> (Randall
        S. Becker's message of "Tue, 30 Mar 2021 15:00:00 -0400")
Message-ID: <xmqqim58cpqa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5785828A-919C-11EB-85AD-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> This is pretty much just a quibble, but the command parser for worktree
> prune --expires should really report when a timestamp is invalid. For
> example:
>
> worktree prune --expires A:30 actually

Assuming that you had "git" in front, and spelled "--expire" without
the extra 's':

$ git worktree prune --expire no.such.date
fatal: malformed expiration date 'no.such.date'

So apparently, "A:30" is taken as a expiration date that is not
malformed.

$ git rev-parse --since=A:30 --until=now
--max-age=1617138312
--min-age=1617138312

Appears to show that A:30 is interpreted as the same as 'now', but
thta is an unlucky coincidence of the day.

What happens in this case is that "A:" is discarded as cruft (just
like dots are discarded in "git log --since=8.days.ago"), and only
the "30" takes effect of filling an unspecified "date of the month"
[*1*].  And then the remainder is taken from the wallclock time, and
that is how the above "rev-parse" shows the same for A:30 and now,
as it is the 30th of the month for me right now.

$ git rev-parse --since=A:31 --until=now
--max-age=1617224881
--min-age=1617138481

gives me the same time tomorrow (for the same reason that today's
30th for me).


[Footnote]

*1* In A:30, there is no "date of month", "month", "year",
etc. specified, so we start from all unspecified, take the first
number that is discovered (i.e. 30) and fill "date of the month"
with it.

