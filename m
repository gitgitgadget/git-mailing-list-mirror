Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 144101F42B
	for <e@80x24.org>; Wed,  8 Nov 2017 02:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751629AbdKHCkV (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 21:40:21 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62601 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750947AbdKHCkU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 21:40:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A2EDB8CB0;
        Tue,  7 Nov 2017 21:40:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=V90cYut7jfZV
        uFz2FPfZZg2Bx6Y=; b=P685F6ar7XJrO2IBFwqpJbCEAjeRpYe+tueVplEg/1LE
        bdzjUsHCD1Vk5wZAUSxGEG3UHLzDEVxNRkMSGYqWUY2NvQQw7niaa9Xkc9abkl83
        a8lCBQKFOebZMD455ZUpAsh2HJLZEjByCg3yOwCS2RhxFd1ZcFafLcWEqQ9huCE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ourMFE
        0lsaib1mSYDsRc10dRs7bWxK1AmDrpa8k0BUGypgV8OE4eJkVZejaMdGDv1ieESo
        2HRkxg1uksLgfc4xX9nFwMMtecYSI1T3WhegfnFazWOVgz/4ZehDkAu3abEZxW6R
        pkMNsXPZE1LTG/kUjQ0vDD5Tm02irWszM0ojY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 21CD3B8CAF;
        Tue,  7 Nov 2017 21:40:19 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8EA59B8CAD;
        Tue,  7 Nov 2017 21:40:18 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/2] builtin/merge-base: free commit lists
References: <20171106110549.dkv725bjikcms3aj@sigill.intra.peff.net>
        <a5f5a259f4cbe3661eb1960e83e9bcce5080b580.1510083859.git.martin.agren@gmail.com>
Date:   Wed, 08 Nov 2017 11:40:17 +0900
In-Reply-To: <a5f5a259f4cbe3661eb1960e83e9bcce5080b580.1510083859.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Tue, 7 Nov 2017 21:39:44
 +0100")
Message-ID: <xmqqzi7xlcha.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 288D695A-C42E-11E7-9CCA-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> In several functions, we iterate through a commit list by assigning
> `result =3D result->next`. As a consequence, we lose the original point=
er
> and eventually leak the list.
>
> Rewrite the loops so that we keep the original pointers, then call
> `free_commit_list()`. Various alternatives were considered:

So, the reader expects to see a list of alternatives that we
considered but did not use in this solution to follow.

>
> 1) Use `UNLEAK(result)` before the loop. Simple change, but not very
> pretty. These would definitely be new lows among our usages of UNLEAK.

I am not sure if I agree with the judgment, but we did reject it, so
describing it as a candidate is good.

> 2) Use `pop_commit()` when looping. Slightly less simple change, but it
> feels slightly preferable to first display the list, then free it.

OK.

> 3) As in this patch, but with `UNLEAK()` instead of freeing. We'd still
> go through all the trouble of refactoring the loop, and because it's no=
t
> super-obvious that we're about to exit, let's just free the lists -- it
> probably doesn't affect the runtime much.

That does include what we did, too.  A rejected alternative is only
the first 3/4 of what this says.

    3) As in this patch, but with `UNLEAK()` instead of freeing. We'd
       still go through all the trouble of refactoring the loop, and the
       use of UNLEAK() is left questionable because it's not very obvious
       that we're about to exit.

and then you can begin a separate paragraph, after the above lists,
e.g.

    Let's just free the lists -- it probably doesn't affect the
    runtime much.

> In `handle_independent()` we can drop `result` while we're here and
> reuse the `revs`-variable instead. That matches several other users of
> `reduce_heads()`. The memory-leak that this hides will be addressed in
> the next commit.

The patch text looks agreeable.

Thanks.
