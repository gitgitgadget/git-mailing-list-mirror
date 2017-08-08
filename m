Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4029F2047F
	for <e@80x24.org>; Tue,  8 Aug 2017 01:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbdHHBoU (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 21:44:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53123 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751891AbdHHBoT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 21:44:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 97DFEAA0F5;
        Mon,  7 Aug 2017 21:44:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bwr5fSsgYb2F5mA3c6eHLQ3MrRg=; b=Xz4bWo
        ILxtM8ofU9Mju3kGG2c1x28tIekLbmXxLVZNubyVUIVzqrTJm4z7KxbqJJwj1rHY
        dPv30pOkQhzXli887JU+BoE3yKMM3l77/WFVO33H8SshBGba+B5xLxQQeRHK6Xwd
        eIOSy4C/vfdi/Q6qrAMU+S7SA27VeunOHeCpk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RvEEdDVHRMUQ6ScrCGOz3Zzy6Sk/NdWO
        NeaWj6TUHp4lrB+Kzp5QEuuc7l3BTJSHMwO0gUq0lRrzZtCiYhdzXz/0KY/XOoSw
        RX6eeRYaUN2x8UDXSZSOmaOqsovxVKfLq8vgCENZtpFvhXSiyVPc8TVVEJEPIJ03
        QVjRBaBOqsU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F0D4AA0F4;
        Mon,  7 Aug 2017 21:44:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ED740AA0F3;
        Mon,  7 Aug 2017 21:44:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin Koegler <martin.koegler@chello.at>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Fix delta integer overflows
References: <1502129437-31226-1-git-send-email-martin@mail.zuhause>
        <xmqq1sonql76.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 07 Aug 2017 18:44:16 -0700
In-Reply-To: <xmqq1sonql76.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 07 Aug 2017 11:36:29 -0700")
Message-ID: <xmqqvalyn89b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1777CF20-7BDB-11E7-B1FA-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Martin Koegler <martin.koegler@chello.at> writes:
>
>> From: Martin Koegler <martin.koegler@chello.at>
>>
>> The current delta code produces incorrect pack objects for files > 4GB.
>>
>> Signed-off-by: Martin Koegler <martin.koegler@chello.at>
>> ---
>>  diff-delta.c | 23 ++++++++++++-----------
>>  1 file changed, 12 insertions(+), 11 deletions(-)
>>
>> Just pass any file > 4 GB to the delta-compression [by increasing the delta limits].
>> As file size, a truncated 32bit value will be encoded, leading to broken pack files.
>
> The patch obviously makes the code better and self consistent in
> that "struct delta_index" has src_size as ulong, and this function
> takes trg_size as ulong, and it was plain wrong for the code to
> assume that "i", which is uint, can receive it safely.
>
> In the longer term we might want to move to size_t or even
> uintmax_t, as the ulong on a platform may not be long enough in
> order to express the largest file size the platform can have, but
> this patch (1) is good even without such a change, and (2) gives a
> good foundation to build on if we want such a change on top.
>
> Thanks.  Will queue.

Having said that, I am a bit curious how you came to this patch.
Was the issue found by code inspection, or did you actually have a
real life use case to raise the core.bigFileThreshold configuration
to a value above 4GB?

Thanks.
