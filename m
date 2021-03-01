Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F613C433DB
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 21:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F74860232
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 21:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244144AbhCAV5T (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 16:57:19 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50115 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237957AbhCAVyv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 16:54:51 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C2A2A115AB2;
        Mon,  1 Mar 2021 16:53:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=C7ooxNcomqcuQlRzVOfW+FRrXRs=; b=weiUI4
        mipr1MatnfJVNucMIk/MbIzXYG3zIf/KH1a+zNmRikfM9i1Dgqd62ofNgJfdTXrf
        roERgODsaTqTUsBjwas1JW8Oq8GSK44r/1AMChq+sAselL2LMTOw5c9spc0i6yXX
        SheGEG7aRe3GKqkXMbWfyPmAjJ2SZbzZ442M0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MNo0S0ivZbpgrBQ6GnBymwZKa1Fda2fa
        x2XD4YlrF/s4l22q4Yp/lgoc8tqU10KnI9MchtV5rY3yHfx0dab5YgIyLmLBXFKi
        V8n9F3DqJPlOoKTUcYoJC+FcuSza9KT/j+wOxoGWAqDVi9ywaKRPrFMQYE2gKwyg
        6fl5le05EX4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BBA2D115AAF;
        Mon,  1 Mar 2021 16:53:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 042D1115AAE;
        Mon,  1 Mar 2021 16:53:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     tboegi@web.de, Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Dan.Moseley@microsoft.com
Subject: Re: [PATCH v2 1/1] git mv foo FOO ; git mv foo bar gave an assert
References: <xmqq7doqwvzx.fsf@gitster.c.googlers.com>
        <20210301170536.12265-1-tboegi@web.de>
        <xmqqzgzmptmy.fsf@gitster.c.googlers.com>
        <CAPx1GvcjO0-3nbcC_oYkYjhYenb_J9CoM6bZNaR_-t93cpppSw@mail.gmail.com>
Date:   Mon, 01 Mar 2021 13:53:43 -0800
In-Reply-To: <CAPx1GvcjO0-3nbcC_oYkYjhYenb_J9CoM6bZNaR_-t93cpppSw@mail.gmail.com>
        (Chris Torek's message of "Mon, 1 Mar 2021 11:36:28 -0800")
Message-ID: <xmqqy2f6mtg8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9839313A-7AD8-11EB-80D0-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chris Torek <chris.torek@gmail.com> writes:

> On Mon, Mar 1, 2021 at 11:26 AM Junio C Hamano <gitster@pobox.com> wrote:
>> Before the problematic patch, this used to be
>>
>>                } else if (cache_name_pos(src, length) < 0)
>>
>> I wonder if we should revert the change to use cache_file_exists()
>> in the first place (and rewrite the subsequent use of ce to match),
>> though.
>
> For what it's worth, that was what I did originally; the change
> to look up the ce "up front" was because someone objected to the
> double search implied by calling cache_name_pos once, then
> cache_file_exists to determine the correct error message...

cache_name_pos() bypasses the name-hash altogether because it won't
need case insensitive search at all, so the comparison is apples and
oranges.  The use of cache_file_exists() made sense if ignore_case
is wanted, but since with the "fix", we always match case
sensitively, I would suspect that it would start making sense to use
cache_name_pos() to grab exactly the ce we want.

Thanks.
