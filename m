Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D76C433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 20:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2418761883
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 20:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhC2Uxb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 16:53:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53626 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbhC2Uw7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 16:52:59 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B28ECC5E5B;
        Mon, 29 Mar 2021 16:52:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dI1utStn/mcdwnD501cvc9HG53Y=; b=E10IYZ
        OpANqqiW3BfkBUFubuWKCjyUVtMhf59plz/duW1zC07CNRZ84PSDCvHQmg8NTM57
        7prGsoewtuuN01ORfg7bV5gI9E4ZuPff3aZjYSNpFvUWklKa1j5I9LHDpi5ZWl5R
        cXNmVtiwu6IpykvN1kkvK++yTmQP3f3D5YGzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eig+ShBPiWs1r7wau6KG37UUKYp6fsTL
        bdaCZFVYt005hFLtJr0o7zkC0hia0T3x3kGmrCLPMhg8RVaVzjI7EkDWumalBL4J
        KdBq/gYwmRlpaaG+h9zmL11Vqxue43wdMfGvmqvE/RKX/tN0sDEK2RwnJrPBQjl5
        gz+CUt0Lt8U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AA339C5E5A;
        Mon, 29 Mar 2021 16:52:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3347FC5E59;
        Mon, 29 Mar 2021 16:52:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] sequencer: fix edit handling for cherry-pick and revert
 messages
References: <pull.988.git.git.1616742969145.gitgitgadget@gmail.com>
        <440980f5-81c9-4201-61a4-29acb0346c65@gmail.com>
Date:   Mon, 29 Mar 2021 13:52:57 -0700
In-Reply-To: <440980f5-81c9-4201-61a4-29acb0346c65@gmail.com> (Phillip Wood's
        message of "Mon, 29 Mar 2021 10:23:08 +0100")
Message-ID: <xmqqwntpiswm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE1FF222-90D0-11EB-B01C-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 26/03/2021 07:16, Elijah Newren via GitGitGadget wrote:
>> From: Elijah Newren <newren@gmail.com>
>> save_opts() should save any non-default values.  It was intended to
>> do
>> this, but since most options in struct replay_opts default to 0, it only
>> saved non-zero values.  Unfortunatley,
>
> s/Unfortunatley/Unfortunately/ also s/iff/if/ in a few places below.

I think the latter is delibrate use of common abbreviation of "if
and only if".

> It might be worth emphasizing that despite its name
> continue_single_pick() is used to commit conflict resolutions
> regardless of the number of picks - I had to check the code to see
> what it was doing in the multi-pick case.

metoo ;-)

> I was surprised how big a change was required to the existing code but
> it seems this is surprising tricky to get right - I cannot think of
> any simplifications.

Thanks for a review.
