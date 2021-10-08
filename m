Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4667DC433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27B3D60F57
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241608AbhJHT7D (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 15:59:03 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58982 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241464AbhJHT7D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 15:59:03 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9F53714C30B;
        Fri,  8 Oct 2021 15:57:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MtyWXAnrOqQyoF/7G+rC2pwqqR++e9UHGkeID+
        wwBjA=; b=rEy3k6wXybfoozwrz14NGYtQF5peFaohxDLmQFv+JExv/vZmWgAh6V
        K6cjTnUIPoDpbRVyuOM/jl8qpgigFw2btWkOi5nO9Sp2a7zq/yZRlKUKDa89NIig
        N5fPK79LAynUvBpSsAsuu1ghzM4K3jA92va4TElSDmoX1WwVOKymo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 97FA714C30A;
        Fri,  8 Oct 2021 15:57:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 05D5E14C309;
        Fri,  8 Oct 2021 15:57:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3] sparse index: fix use-after-free bug in
 cache_tree_verify()
References: <pull.1053.v2.git.1633600244854.gitgitgadget@gmail.com>
        <pull.1053.v3.git.1633630041829.gitgitgadget@gmail.com>
        <xmqqee8wpm0u.fsf@gitster.g>
        <4ccaad06-a1ae-bd1b-f25d-bfa899ffa98f@gmail.com>
Date:   Fri, 08 Oct 2021 12:57:02 -0700
In-Reply-To: <4ccaad06-a1ae-bd1b-f25d-bfa899ffa98f@gmail.com> (Phillip Wood's
        message of "Fri, 8 Oct 2021 10:09:46 +0100")
Message-ID: <xmqqwnmnjnn5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8993426-2871-11EC-946F-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 07/10/2021 22:23, Junio C Hamano wrote:
>> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> 
>>>       * Fixed the spelling of Stolee's name (sorry Stolee)
>>>       * Added "-q" to the test to prevent a failure on Microsoft's fork[1]
>>>           [1]
>>>      https://lore.kernel.org/git/ebbe8616-0863-812b-e112-103680f7298b@gmail.com/
>> I've seen the exchange, but ...
>> 
>>> -	for OPERATION in "merge -m merge" cherry-pick rebase
>>> +	for OPERATION in "merge -m merge" cherry-pick "rebase --apply -q" "rebase --merge"
>>>   	do
>> ... it looks too strange that only one of them requires a "--quiet"
>> option.  Is it a possibility to get whoever's fork corrected so that
>> it behaves sensibly without requiring the "-q" option only for the
>> particular rebase backend?
>
> The issue is caused by a patch that Microsoft is carrying that stops
> apply from creating paths with the skip-worktree bit set. As they're 
> upstreaming their sparse index and checkout work I expect it will show
> up on the list sooner or later. I agree the "-q" is odd and it also 
> means the test is weaker but I'm not sure what else we can do.

Perhaps passing "-q" to the other variant of "rebase" would make it
clear that (1) we do not want to worry about traces involved in the
verbose message generation and (2) there is nothing fishy going on
in only one of the "rebase" backends.

