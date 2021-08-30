Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C934C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 00:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AD8D60F51
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 00:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbhH3AIv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Aug 2021 20:08:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51226 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhH3AIu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Aug 2021 20:08:50 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E2195ED1D1;
        Sun, 29 Aug 2021 20:07:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UwfCyfJsJWoG3anSdqmIwMSr5vNjQOgy1lHwRX
        15gSg=; b=RuB8I87QXICA7Ci9ra6AyYmu8lWaWKtj2r4vZIihlTMPbt56+0YY74
        0Rc12m0fDqnjAU2IPICpo1AcAjVje3U948nphCiNmEJK/FgV9JroKQg+BRDda14h
        1VDDy/mSyxOd8EN3ruSgYvxC4crkuKLJ64PDCLuszSYp6jUZRO8sY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D9950ED1D0;
        Sun, 29 Aug 2021 20:07:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6B1BFED1CF;
        Sun, 29 Aug 2021 20:07:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Yuri <yuri@rawbw.com>, Git Mailing List <git@vger.kernel.org>
Subject: Re: Git re-creates newly added directory when it is pushed
References: <c0557284-8f82-76cc-8c47-0b1bc9f2ce5a@rawbw.com>
        <CABPp-BFwvDY6-6pQ2MSPzAGafONjTEMNUkLwuRuQCJ_wx2ns2w@mail.gmail.com>
Date:   Sun, 29 Aug 2021 17:07:56 -0700
In-Reply-To: <CABPp-BFwvDY6-6pQ2MSPzAGafONjTEMNUkLwuRuQCJ_wx2ns2w@mail.gmail.com>
        (Elijah Newren's message of "Fri, 27 Aug 2021 22:33:10 -0700")
Message-ID: <xmqqv93n7q1v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 549C031C-0926-11EC-822C-D601C7D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> Why does Git have to delete and then create again the directory when it
>> is already there?
>>
>>
>> This isn't a big issue, but it is very odd that git deletes the working
>> directory.
>
> It was deleted by the rebase operation, because rebase (currently)
> works by first checking out the target commit onto which it will apply
> all your local patches.  That target didn't have the directory; the
> directory was added by your local patches.  So checking out that
> commit necessarily deletes the directory.  Then rebase applies each of
> your local patches, one by one, updating the working directory as it
> applies them.  Since your local patches create that directory, it gets
> re-created by this process.

This is one of the reasons why "rebase" (especially "rebase -i") may
want to insist starting at the top-level of the working tree, like
"git bisect" does.  Because running the command from a subdirectory
works most of the time until it doesn't, people tend to complain why
they should go up to the top-level before they can run the command.

And this is why---it causes end-user confusion.

