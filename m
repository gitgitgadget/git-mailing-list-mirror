Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B278C433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 18:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349524AbhK2SWg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 13:22:36 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55808 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241278AbhK2SUf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 13:20:35 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2D3BC16D264;
        Mon, 29 Nov 2021 13:17:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=efvjhVfill+4GifGEJ/Rd09SaocqP111lhcb7k
        vcR40=; b=D/wlpFD4y8ezUZ/+Kz+k2YlpDcrF4mm9Elhp/W0h0yyuK/gqBjwm2I
        D65wISqK+HOKseBbKACkslmbHbV6tq0Yj41QtgxwsHqoYnXm7ks+UU0WKUH7jHzo
        /6qBWqxCUlvtceZXGCojaZcVwzRJI6HYpSpKzCLSC1gEUn+KKg/Wc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 25FBD16D263;
        Mon, 29 Nov 2021 13:17:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4A28116D262;
        Mon, 29 Nov 2021 13:17:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?utf-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87_=28Aleen=29_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Aleen =?utf-8?B?5b6Q5rKb5paH?= <pwxu@coremail.cn>,
        =?utf-8?B?5b6Q5rKb5paHIChBbGVlbik=?= <aleen42@vip.qq.com>
Subject: Re: [PATCH v11 2/2] am: support --empty=<option> to handle empty
 patches
References: <pull.1076.v10.git.1637567471.gitgitgadget@gmail.com>
        <pull.1076.v11.git.1637681215.gitgitgadget@gmail.com>
        <6051ad9440a966124e9147ec344ee6d87c46944a.1637681215.git.gitgitgadget@gmail.com>
        <CABPp-BF-eYcJ7eS==VK3M2xOqf5z4KNK4dP6qd_UcfLO1NWBeg@mail.gmail.com>
Date:   Mon, 29 Nov 2021 10:17:11 -0800
In-Reply-To: <CABPp-BF-eYcJ7eS==VK3M2xOqf5z4KNK4dP6qd_UcfLO1NWBeg@mail.gmail.com>
        (Elijah Newren's message of "Fri, 26 Nov 2021 12:14:03 -0800")
Message-ID: <xmqqo8623jyw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 935498AA-5140-11EC-B95D-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> +--empty=(die|drop|keep)::
>> +       By default, or when the option is set to 'die', the command
>> +       errors out on an input e-mail message that lacks a patch. When
>> +       this option is set to 'drop', skip such an e-mail message instead.
>> +       When this option is set to 'keep', create an empty commit,
>> +       recording the contents of the e-mail message as its log.
>
> What does 'errors out' mean?  Is the am operation aborted, and the
> user return to the pre-am state?  Or is the am operation interrupted,
> with the user being asked to choose whether to keep or drop the patch?

I think it is the same as how "git am" without this sees a piece of
e-mail without any patch in it.  It exits with non-zero status, but
keeps the contents of .git/rebase-apply directory intact so that the
user can decide what the next action should be.  "the command stops
with non-zero status and gives control back to the user" might be a
better explanation.

As to the name of the option's value, I think 'die' is a much better
word than 'ask' for this behaviour.  It is not like we retain
control, give "do you want to do X or Y?"  prompt and do either X or
Y ourselves, which is what I expect out of 'ask'.  If we just exit
with non-zero value and give the control back to the user, then we
are not asking.

This is a tangent, but in the current Documentation/git-am.txt, the
phrasing for "--skip" and "--resolved" are a bit inconsistent.

 - The "--skip" operation calls the situation it is designed to handle
   "an aborted patch".

 - The "--resolved" operation calls it "a patch failure".

The "--abort" operation interestingly does not use any word to
explain the situation it is designed to be used in.  It just
assumes that the user knows "git am" session is somehow still in
effect.


