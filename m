Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E880C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 00:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7314E60F5B
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 00:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236196AbhH3Aa3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Aug 2021 20:30:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56734 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbhH3Aa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Aug 2021 20:30:29 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D616DFAD2;
        Sun, 29 Aug 2021 20:29:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E1gJcyGO9uc9QDML4cJhxxKWTyTZ9YZkOCESX9
        j89Ro=; b=sT8wFBYTAZ1mE5AQOCfnB91kiAjILukpso1OSQVqsoqEXuPL+5FPDH
        PU8/Azj5odx625vis5ZH7g0iH1gBvJuyW6Ytz8rCaW4QZRr/PFru+7MphJcrh3MS
        kOCG/oh7/fVa92eIO5hUfZ4jvjrSx+HedXKfrraHAyIfivILidIzI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 03AE3DFAD1;
        Sun, 29 Aug 2021 20:29:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 82C0BDFAD0;
        Sun, 29 Aug 2021 20:29:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yuri <yuri@rawbw.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Git re-creates newly added directory when it is pushed
References: <c0557284-8f82-76cc-8c47-0b1bc9f2ce5a@rawbw.com>
        <CABPp-BFwvDY6-6pQ2MSPzAGafONjTEMNUkLwuRuQCJ_wx2ns2w@mail.gmail.com>
        <xmqqv93n7q1v.fsf@gitster.g>
        <da2bfcc8-09b2-c909-a316-343ab3108a58@rawbw.com>
Date:   Sun, 29 Aug 2021 17:29:34 -0700
In-Reply-To: <da2bfcc8-09b2-c909-a316-343ab3108a58@rawbw.com>
        (yuri@rawbw.com's message of "Sun, 29 Aug 2021 17:14:15 -0700")
Message-ID: <xmqqk0k37p1t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5A55F6FC-0929-11EC-98E8-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yuri <yuri@rawbw.com> writes:

> On 8/29/21 5:07 PM, Junio C Hamano wrote:
>> This is one of the reasons why "rebase" (especially "rebase -i") may
>> want to insist starting at the top-level of the working tree, like
>> "git bisect" does.  Because running the command from a subdirectory
>> works most of the time until it doesn't, people tend to complain why
>> they should go up to the top-level before they can run the command.
>>
>> And this is why---it causes end-user confusion.
>
>
> But there's no confusion here - git doesn't have to delete the
> directory and recreate it, but it does it anyway.
>
> So this is just a bug that git disturbs users more than it should.

No, this is an example that users usually can be unaware of the
reason why it is a bad idea to start from subdirectories.

As Elijah explained, if a multi-step rebase had to stop and ask help
from the user to resolve conflict _before_ the step that creates the
user's current directory, it would leave the user in a confusing
situation where the user thinks is in a directory but that directory
does not yet exist in the filesystem.
