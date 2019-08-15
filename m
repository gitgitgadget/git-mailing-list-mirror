Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4503F1F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 16:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbfHOQeY (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 12:34:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57103 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730156AbfHOQeY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 12:34:24 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 31C9E15DD38;
        Thu, 15 Aug 2019 12:34:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=LwmcUoe+Hmz5
        ZrD/4Cehn2lULeQ=; b=mWAZmgnxSact9aNHTt6szDf7BFYhlLK7dc8B5e2nZF3j
        d9AW0ctqhQtgeg9zU1yWtZdcXoVFK85agzhuOQ7OImhE/Ao2+GS3wf6W29e0i28x
        ZsP6y6nNXhHEuOddf3IBlq5eG0y+ECIokfBSmLqQzxjcJSFcQfgD3QYoP66WXmM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=P+sw/4
        FwqYBfKySB1TuHjqWKeDfPGD5d8D5wHDEIf2n3nmobts/djAMNYf6NrB0rcpchGT
        IHxFsVqteWlqWy0cvntvviCMeTwuZWGh8AAj3uwkOFHcysCRoocqSoZz0j1cfz62
        lAq1QAcpEQ8JykFkzk0Y5lnffmi+0SZRXNPxg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 25C2B15DD37;
        Thu, 15 Aug 2019 12:34:21 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8B05215DD34;
        Thu, 15 Aug 2019 12:34:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Varun Naik <vcnaik94@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH] unpack-trees.c: handle empty deleted ita files
References: <20190813160353.50018-1-vcnaik94@gmail.com>
        <b7f4b745-8942-6d90-dbc5-7f79f2cc323e@web.de>
        <xmqqr25o7qmf.fsf@gitster-ct.c.googlers.com>
        <CAK_rgsGSfL2zQLP59O+PUCLGz0X8c4UQ3Zg=9M+nCww5C+X_gA@mail.gmail.com>
Date:   Thu, 15 Aug 2019 09:34:19 -0700
In-Reply-To: <CAK_rgsGSfL2zQLP59O+PUCLGz0X8c4UQ3Zg=9M+nCww5C+X_gA@mail.gmail.com>
        (Varun Naik's message of "Thu, 15 Aug 2019 09:17:09 -0700")
Message-ID: <xmqqtvai4cc4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8857654A-BF7A-11E9-A5F7-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Varun Naik <vcnaik94@gmail.com> writes:

> On Tue, Aug 13, 2019 at 1:33 PM Junio C Hamano <gitster@pobox.com> wrot=
e:
>>
>> The original code considered that two entries with the same mode and
>> the same "contents" are the same.  As nobody sane tracks an empty
>> file for an extended span of history, that meant that most of the
>> time, intent-to-add entries, which has the normal mode bits for the
>> blobs (with or without the executable bit) and object name for a
>> zero length blob, would have been judged "different".
>>
>
> I agree, this edge case is really arcane. The rabbit hole was deep :)

In retrospect, perhaps I shouldn't have used the empty-blob SHA-1
for I-T-A entries (instead, perhaps 0{40} or something impossible)
when I invented this feature at 39425819 ("git-add --intent-to-add
(-N)", 2008-08-21).  It made the code to "diff" easier than having
to special case comparison between a real blob and an I-T-A entry,
but we are paying the price for that laziness with a discussion and
a patch like this one.

>> So perhaps
>>
>> +       !ce_intent_to_add(a) && !ce_intent_to_add(b) &&
>>
>> i.e. "a cache entry is eligible to be same with something else only
>> when its I-T-A bit is unset".
>>
>
> I decided to follow Ren=C3=A9's suggestion in response to this. Patch c=
oming soon.

Either is fine as the implementation of the same semantics; I
however am not sure if two I-T-A entries should compare "same" or
"not same", or if we are better off catching the caller that feeds
two I-T-A entries to same() with a BUG().

Thanks.
