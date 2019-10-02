Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 275EF1F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 05:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfJBFzv (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 01:55:51 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62967 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfJBFzv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 01:55:51 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E7A9782752;
        Wed,  2 Oct 2019 01:55:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ns725TCm546On255ryGItU2JTAg=; b=X2NjH1
        973NhXTbGPXQ6HeTB7+KhXn1I/3Et3VLaZhNBAHx+nxC51nWf3mVRXLqusVhTkNG
        3AeXq/8AvTvHk1Dw5+Dh+S4Qqij+8qTgNs/Ml2Oznp4OZXY44Mv61ilbO5l3V5Bz
        AxcMc3zFj/1mW2l8CSMpawFNE0J2PquBMFzDY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GpMIxMSfiy4jqqfdV5FamzDJ2E66wew4
        FJcYIB+UqVU54P/NTXr3+C1OMNCblk84gLSJLyZ486L1z/qDx9Qmjj7svaU6Y9Pv
        t4964wRg+1IqoWXV2/M8BK9nxklvIb9J/KUYMM+LXZN8awzSjzMqrDxddksnzVQc
        8We6oX0FAuI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D45A282751;
        Wed,  2 Oct 2019 01:55:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F195982750;
        Wed,  2 Oct 2019 01:55:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        CB Bailey <cb@hashpling.org>, dstolee@microsoft.com
Subject: Re: [PATCH v4] diffcore-break: use a goto instead of a redundant if statement
References: <20190929204322.1244907-1-alexhenrie24@gmail.com>
        <xmqqa7amimzc.fsf@gitster-ct.c.googlers.com>
        <CAMMLpeQLXN=jvD6MSJPdUTr60MiKdQq=zHFQ7aiatFuhqX1aeQ@mail.gmail.com>
        <xmqq36gei07z.fsf@gitster-ct.c.googlers.com>
        <CAMMLpeQps8jvgpBXDnzqeeSsH7RA=__XjnDb4p_4SdGB-G2mSw@mail.gmail.com>
Date:   Wed, 02 Oct 2019 14:55:43 +0900
In-Reply-To: <CAMMLpeQps8jvgpBXDnzqeeSsH7RA=__XjnDb4p_4SdGB-G2mSw@mail.gmail.com>
        (Alex Henrie's message of "Mon, 30 Sep 2019 11:36:46 -0600")
Message-ID: <xmqqk19ng080.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 46E67A40-E4D9-11E9-B62A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> On Mon, Sep 30, 2019 at 3:48 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Alex Henrie <alexhenrie24@gmail.com> writes:
>>
>> > Well, I admit that code clarity is somewhat subjective. To me it's not
>> > obvious that "if (q->nr <= j)" means "if the loop exited normally",

I agree that it is subjective, but "if counter hasn't run beyond the
limit" immediately after a loop is a pretty-well established idiom
to see if we broke out prematurely.

> To me at least it was not clear what code is executed if the peer
> survives. The fact that I put the goto label in the wrong place the
> first time only underscores the difficulty of understanding this
> function. But with a goto (and with its label in the correct place),
> the execution path is obvious.

Well, the fact that the version with goto jumping to a wrong place
was so easy to spot as buggy might be an indication that goto made
it obvious to CB, but clearly use of goto did not make logic obvious
at least to the older version of you who wrote the buggy code.

Well I am being a bit mean in the above ;-) A more fair statement
would be that your bug did not come from goto; I think what
contributed more to the logic flaw in your earlier round was the
merging of two diff_q() calls from unrelated codepath.  Without that
change, and with the knowledge of "did the loop terminate early"
idiom, the version without 'goto' is obvious, and with only 'goto'
change, that original obviousness would not diminish.
