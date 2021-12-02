Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDF0C433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 16:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359812AbhLBRBz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 12:01:55 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61013 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348240AbhLBRBy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 12:01:54 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E8DBE15EE98;
        Thu,  2 Dec 2021 11:58:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Efq/xvyAIT2PYZ9WFsgDLVPPVit4ILNgwdD8a1
        xAUTU=; b=iwDlScMo2ZXcQrCgJGOyHIaGr72JF2yLWzjxQiwSwCdQBXFy8eSjET
        2fCHtTld8EkXTV0z0LoaO4kthp++t3FcrIAO4LMwQSP0vaLY1DQe5mlYJA9J2R5j
        IkxLpe6P/IlWOlsHtZfYIjOlEzPVTOz7hYKJJvEtotY+RT7rk7BXg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E10FB15EE97;
        Thu,  2 Dec 2021 11:58:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9688915EE96;
        Thu,  2 Dec 2021 11:58:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     phillip.wood@dunelm.org.uk,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Slavica =?utf-8?B?xJB1?= =?utf-8?B?a2nEhw==?= 
        <slawica92@hotmail.com>, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 2/2] add -i: default to the built-in implementation
References: <pull.1087.git.1638281655.gitgitgadget@gmail.com>
        <84824918ae4564a9194a1a55124ee8694f210437.1638281655.git.gitgitgadget@gmail.com>
        <a936a701-c13f-346e-69ee-85441ca20641@gmail.com>
        <nycvar.QRO.7.76.6.2112021557530.63@tvgsbejvaqbjf.bet>
Date:   Thu, 02 Dec 2021 08:58:26 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2112021557530.63@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 2 Dec 2021 16:01:53 +0100 (CET)")
Message-ID: <xmqq5ys7vt8t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 11D77704-5391-11EC-A5F1-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > +	if (use_builtin_add_i < 0 &&
>> > +	    git_config_get_bool("add.interactive.usebuiltin",
>> > +				&use_builtin_add_i))
>> > +		use_builtin_add_i = 1;
>> >   -	if (use_builtin_add_i == 1) {
>> > +	if (use_builtin_add_i != 0) {
>>
>> This could be simplified to "if (use_builtin_add_i)" but don't re-roll just
>> for that
>
> I was actually considering this, given that Git's coding practice suggests
> precisely the form you suggested.
>
> However, in this instance I found that form misleading: it would read to
> me as if `use_builtin_add_i` was a Boolean. But it is a tristate, it can
> also be `-1` ("undecided"). And I wanted to express "if this is not set to
> `false` specifically", therefore I ended up with my proposal.

I do not think that line of logic is sensible.  The variable starts
its life as a tristate (i.e. not just bool but can be unknown), and
the four new lines above the conditional the patch adds is exactly
about getting rid of the unknown-ness and turning it into a known
boolean.  After that happens, the variable can safely be used as a
boolean.  In fact, I view the four lines before it is exactly to
allow us to do so.

Writing "if not zero" implies that the variable can have a non-zero
value that is still "unknown" at this point in the code that has to
be defaulted to "true", which would mean that the "if unset, read
the config, and if that fails, default to true" logic above is not
doing its job.  That is a false impression that misleads readers of
the code.

So, I would say this conditional just should treat the variable as a
simple boolean.

