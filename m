Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E666EC2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 08:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B90356054E
	for <git@archiver.kernel.org>; Sat, 22 May 2021 08:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhEVIui (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 04:50:38 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65158 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhEVIui (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 04:50:38 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EEBC514573E;
        Sat, 22 May 2021 04:49:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4Ft6bWtCbbopzQRk9NnF7P8yZAWHk4QrbT7kwy
        60n3s=; b=Hg8QW7ookD+nhaAbt/5WhAt3JxqTNK75WeHQkZ46K81iVXS4M3KyRZ
        j/3gDoQjKRQHCcPaGsv0XuSBhz3paq803Kuo5Wl3lYTAFFBbpHWV5Hv2OSrPr61K
        JcopL4TZSdKI2ARWIn8QYsSktY/SNL9Jp1R4abbLSGvq7PbAMSz70=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D947D14573D;
        Sat, 22 May 2021 04:49:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1BEC314573C;
        Sat, 22 May 2021 04:49:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Josh Steadmon <steadmon@google.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: RFC: error codes on exit
References: <YKWggLGDhTOY+lcy@google.com>
        <60a5afeeb13b4_1d8f2208a5@natae.notmuch>
        <CAMMLpeScunGg5WM4N90vG+yN3tOATqhsL2iRLsJ43ksNyTx_wQ@mail.gmail.com>
        <dc14c50d-c626-19f8-e615-52ca3c9051dc@zytor.com>
Date:   Sat, 22 May 2021 17:49:09 +0900
In-Reply-To: <dc14c50d-c626-19f8-e615-52ca3c9051dc@zytor.com> (H. Peter
        Anvin's message of "Fri, 21 May 2021 16:20:01 -0700")
Message-ID: <xmqqfsyfqhkq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 93DD31DA-BADA-11EB-9483-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> On 5/21/21 9:53 AM, Alex Henrie wrote:
>> On Wed, May 19, 2021 at 6:40 PM Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>>
>>> It's good to not include many initial codes, but I would start with at
>>> least three:
>>>
>>>    OK = 0,
>>>    UNKNOWN = 1,
>>>    NORMAL = 2,
>> If you go that route, could you please pick a word other than
>> "normal"
>> to describe errors that are not entirely unexpected? I'm worried that
>> someone will see "normal" and use it instead of "OK" to indicate
>> success.
>> 
>
> <sysexits.h>

Is the value assignment standardized across systems?

We want human-readable names in the source to help developers while
we want platform neutral output in the log so that log collectors
can do some "intelligent" things about the output.  If EX_USAGE is
always 64 everywhere, that is great---we can emit "64" in the log
and log collectors can take it as if they saw "EX_USAGE".  But if
the value assignment is platform-dependent, it does not help all
that much.

    Side note.  We had a similar discussion on <errno.h> and
    strerror(); the numbers do not help without knowing which
    platform the error came from, and strerror() output is localized
    and not suitable for machine consumption.

In a sense, it is worse than we keep a central mapping between names
programmers use to give to the new fatal() helper function and the
string the tracing machinery will emit for these names.

Thanks.
