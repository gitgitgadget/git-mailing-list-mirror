Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C54C4361B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 18:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E02F2389F
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 18:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725918AbgLGSrm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 13:47:42 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58369 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgLGSrm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 13:47:42 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 21AA58A6AF;
        Mon,  7 Dec 2020 13:47:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tO7UOMAiIEJE4+809G6TFY0H/aI=; b=BRdTVp
        h1inT7voIwA8X/eualnFrourUXYjKXiiT9qv58Ov5oz+p77CsZeMW6YK9PWY3wCx
        1mU0IsctqLnrarVk2Q22VkOiU9WvMd/rTQtaFjABQT19BKNNhEP66TDvhmcKf1Gz
        j2JV3ZfmYElASODqmutYAPylXxPtLBT/Fnds0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Wne8nZ2UZQih9uiCdcI44/mZKfawHKgo
        ifLTIZuqQv9EQwiB/qKKUgaMkSeJPD98ckjnBrqZ18JcbvKdu6ordRndurjF7mWo
        NSslv/aNOCeE5ESGhxLlVr9iNtwrQrgJ86UqFhEBHkkxwRZ39BKZ2ZuxzPRBqbuc
        67NbseIbI3g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 188068A6AD;
        Mon,  7 Dec 2020 13:47:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8F63C8A6AC;
        Mon,  7 Dec 2020 13:46:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jan Engelhardt <jengelh@inai.de>, git@vger.kernel.org
Subject: Re: `git grep` is too picky about option parsing
References: <704q5rs6-63q1-sp78-9845-227oq8q42o8q@vanv.qr>
        <X85gMs1gPBNLff7f@coredump.intra.peff.net>
Date:   Mon, 07 Dec 2020 10:46:58 -0800
In-Reply-To: <X85gMs1gPBNLff7f@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 7 Dec 2020 12:02:42 -0500")
Message-ID: <xmqqa6upbgil.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9690CFCC-38BC-11EB-8C6C-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The problem is that it gives bundled short options a lower precedence
> than detecting possible typos against long options. My instinct is to
> say that this is wrong. We should allow valid things to work, and only
> add error heuristics if the user's request is nonsense (i.e., if one of
> the bundled options is not a valid one).

Thanks, I was coming to the same conclusion.

> But that actually contradicts
> the original example given in 3a9f0f41db! There it was trying to make:
>
>   git commit -amend
>
> an error. But that's a set of valid options, the same as:
>
>   git commit -a -m end
>
> So we'd be losing that protection. Another option would be to make the
> typo-checker a little more picky:
>
>   - require more than 3 characters; this is just punting off the
>     problem, though. Doing "-line foo" is valid. So is "-linefoo", for
>     that matter, though that one would do what we want since it stops
>     being a prefix.
>
>   - be more aggressive about how much of a long option we match in the
>     prefix (at least for the typo checker). "lin" is an awfully small
>     part of "line-number". People may plausibly use "--lin" or "--line"
>     as a shortcut, but I'm not sure that merits blocking the valid
>     "-lin" for the typo-checker.
>
> Either of those would let "-amend" continue to be an error, but fix
> "-lin".

I am wondering if a rule like "you cannot concatenate a short option
that takes argument with other short options" work.  The problem
with "-a -m end" is really that the 'm' takes arbitrary end-user
input.  So "commit -ave" would be fine, but "commit -ame" would not
be.  This would make both "-line foo" and "--linefoo" consistently
invalid, but "-lin -e foo" is still OK and make the rule easier to
explain.

Then we can probably lift the "more than 3 characters" heuristics,
which may be a good thing independently.


