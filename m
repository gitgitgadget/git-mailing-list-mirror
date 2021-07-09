Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2535C07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 17:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83215613BD
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 17:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhGIRYI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 13:24:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62551 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhGIRYI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 13:24:08 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 230F6E1C9D;
        Fri,  9 Jul 2021 13:21:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5Or/mSJf/QZA+aleYpYduaBf17AbkKyxFePc5F
        Gm8Qc=; b=U5lp0fK9Y3grw1pEYydoSKFDXPvqCe8bFuRhF4JEQvWO+o+fv1jbFW
        rIpNymnU/YoXbhERJ1wjXnlbuV3fg9Xt9EJ7EWAwmKDG+nlsbGyspQfOpNFPAGp+
        akHQeng8GqsUaJEL/shbkEErNdpFda+rZ4kN+x9G2CMz3o2zlWJE4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A5B3E1C9C;
        Fri,  9 Jul 2021 13:21:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 865E4E1C9B;
        Fri,  9 Jul 2021 13:21:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Avishay Matayev <me@avishay.dev>
Cc:     git@vger.kernel.org, code@tpope.net
Subject: Re: [PATCH 2/3] Allow isatty to be overriden with GIT_FORCE_TTY
References: <20210706210317.706313-1-me@avishay.dev>
        <20210706210317.706313-3-me@avishay.dev> <xmqqbl7fgkvu.fsf@gitster.g>
        <CAJ-0Osy2RLiZmi9m=W=rpK6Bh5uXk-psO-BTb18a8COrsQANUw@mail.gmail.com>
Date:   Fri, 09 Jul 2021 10:21:21 -0700
In-Reply-To: <CAJ-0Osy2RLiZmi9m=W=rpK6Bh5uXk-psO-BTb18a8COrsQANUw@mail.gmail.com>
        (Avishay Matayev's message of "Fri, 9 Jul 2021 17:49:32 +0300")
Message-ID: <xmqqo8bb769a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 15A6D732-E0DA-11EB-BD18-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avishay Matayev <me@avishay.dev> writes:

> On Wed, 7 Jul 2021 at 01:03, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Avishay Matayev <me@avishay.dev> writes:
>>
>> > There are several behaviors where git will not attempt to do an action if a
>> > tty is not present, for example - `git_pager` (pager.c) will instruct git
>> > to not use the GIT_PAGER environment variable if stdout is not a pty.
>>
>> In general, I am negative on this approach, even though I agree that
>> the issue you are trying to solve is worth solving.  "Force pretend
>> that we are talking to a TTY" exposes too much of the internal
>> logic in the implementation to the end users.
>>
>> Often we use isatty() as an approximation for "are we being
>> interactive?", and I wouldn't have as much problem as I have with
>> the "FORCE_TTY" to an approach to give users a knob to tell us "do
>> not use your logic to guess---I am telling you that we are
>> interactive, so behave as such".
> I'm not sure that I understand your view on this patch.
> `git_isatty()` does exactly that, it gives the users that knob, doesn't it?
>
> If you don't find the approach in this patch good enough, what exactly
> do you suggest?

Start with not tying this feature with the word "TTY", probably.
