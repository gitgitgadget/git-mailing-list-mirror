Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F195EC433B4
	for <git@archiver.kernel.org>; Tue,  4 May 2021 01:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEC3A60FEE
	for <git@archiver.kernel.org>; Tue,  4 May 2021 01:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhEDBQa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 21:16:30 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61751 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhEDBQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 21:16:29 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B64EF142112;
        Mon,  3 May 2021 21:15:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UmmHo2JMm+6xJvbOa61g4mI+LExrC2tz4UmuMA
        Xnu6o=; b=KJLxcYkWw0/KrMezPf3LXL1oNM9wKrXdNRUTnBoSZDy7e/R9GRVeH1
        OqnN5dgMzUplwvxO9g0CM6tAvLytCETaq6Ugx2edm8IPC7m8X1EJC9LOa3Kp1B5W
        M/46OsgA4byIFvi8C/rUALEDcOtjtrabA7mFEw8ZP4XNhCEUlDQi4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AF59D142111;
        Mon,  3 May 2021 21:15:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C70CC142110;
        Mon,  3 May 2021 21:15:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Why doesn't `git log -m` imply `-p`?
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <xmqqwnsl93m3.fsf@gitster.g> <87im45clkp.fsf@osv.gnss.ru>
        <xmqqmttgfz8e.fsf@gitster.g> <xmqqy2d0cr5l.fsf@gitster.g>
        <87v9837tzm.fsf@osv.gnss.ru> <xmqqzgxfb80r.fsf@gitster.g>
        <87czu7u32v.fsf@osv.gnss.ru>
Date:   Tue, 04 May 2021 10:15:29 +0900
In-Reply-To: <87czu7u32v.fsf@osv.gnss.ru> (Sergey Organov's message of "Mon,
        03 May 2021 20:42:00 +0300")
Message-ID: <xmqqtunj70zy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3875C70C-AC76-11EB-B44F-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

>>  * "--patch", "--stat", "--cc" etc are to specify if we use the diff
>>    machinery and what kind of output is desired.
>
> So, in your view, --cc output is not a product of "diff machinery"?

I view --cc and -c as an enhanced form of --patch that is also
capable of handling multi-way diffs, in other words, choosing --cc
should be to say "give me textual patch for all commits; when there
are multiple parents, condense multi-way patches".

So, yes, strictly speaking, --diff-merges=cc was probably a mistake,
and in the ideal world, --diff-merges should have taken only one of
"compare with nothing" (optional), "compare with first-parent", and
"compare with all parents".  The last choice could output diffs in
various forms, like traditional -m (i.e. patch output separately for
each parent), --cc, -c, etc.  "compare with nothing" is optional
because we could also control on the "output format" side to say
"produce no output" (ala "git show -s").

But such an idealized orthogonal design without special casing will
often lead to usability problems and complaints that -m alone does
not produce anything, so I am OK to have cc and friends as the value
for --diff-merges for that reason.
