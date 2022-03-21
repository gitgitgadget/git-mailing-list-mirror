Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95FEC433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 19:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352472AbiCUTQH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 15:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345444AbiCUTQG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 15:16:06 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7975948396
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 12:14:39 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 92711108873;
        Mon, 21 Mar 2022 15:14:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uKk2pOuJnC2MEVN5B8S81iSXvW+0TiHPARWtf1
        KtER4=; b=pUH16ydSZm7fDqA/KzdfU10LGbAM5ah88sfJogo9ycS4Dfyq24pKN4
        D3PuTS/7jz+ubb++jaiwI4jP6XMp9l7MqBWogQ2eabFcl9zPRfjFKyGp5D5E3vSC
        BLU8E32mDnjYGAUvitEJISW+lqXljq8HQhxq/buM4PfjxzW2iSVlE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A177108872;
        Mon, 21 Mar 2022 15:14:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F0FCB108871;
        Mon, 21 Mar 2022 15:14:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Victoria Dye <vdye@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] mv: integrate with sparse-index
References: <20220315100145.214054-1-shaoxuan.yuan02@gmail.com>
        <20220315100145.214054-2-shaoxuan.yuan02@gmail.com>
        <1ab24e4b-1feb-e1bc-4ae4-c28a69f77e05@github.com>
        <CAJyCBORDOJUwTzOC+hYwGGPUBCXST0_mBdwRLh2N+cA=5k0d4A@mail.gmail.com>
        <675c7681-c495-727d-1262-ee8c6a5c8ce5@github.com>
        <CAJyCBORfAV_TV6DrOxgim4KtU9T-uTibOaQCsJZsi5_FQfci1Q@mail.gmail.com>
        <97a665fe-07c9-c4f6-4ab6-b6c0e1397c31@github.com>
        <xmqqo824cbxl.fsf@gitster.g>
        <e127dadb-7b44-55f8-16ea-9fcf94905db8@github.com>
Date:   Mon, 21 Mar 2022 12:14:36 -0700
In-Reply-To: <e127dadb-7b44-55f8-16ea-9fcf94905db8@github.com> (Derrick
        Stolee's message of "Mon, 21 Mar 2022 11:20:08 -0400")
Message-ID: <xmqq8rt3xgmb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 26C9C292-A94B-11EC-90E0-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>>> Another tool that may help you here is 'git ls-files --sparse -t'. It lists
>>> the files in the index and their "tags" ('H' is "normal" tracked files, 'S'
>>> is SKIP_WORKTREE, etc. [4]), which can help identify when a file you'd
>>> expect to be SKIP_WORKTREE is not and vice versa.
>> 
>> Wonderful.
>> 
>> Quite honestly, because the code will most likely compile correctly
>> if you just remove the unconditional "we first expand the in-core
>> index fully" code, and because the "sparse index" makes the existing
>> index walking code fail in unexpected and surprising ways, I
>> consider it unsuitably harder for people who are not yet familiar
>> with the system.  Without a good test coverage (which is hard to
>> give unless you are familiar with the code being tested X-<), one
>> can easily get confused and lost.
>
> Certainly, 'git mv' is looking to be harder than expected, but there
> is a lot of interesting exploration happening in the process.

Yeah, I know.

I am suprised that it is harder than expected *to* *you*, though.
After having seen a few other topics, I thought that you should know
how deceptively easy to lose "require-full" and how hard to audit
the code that may expect "a flat list of paths" in the in-core index
;-).

> Thanks for persisting on this one, Shaoxuan!

Yes, thanks.  And thanks for mentoring Shaoxuan.
