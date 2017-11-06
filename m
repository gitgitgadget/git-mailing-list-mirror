Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C9B620281
	for <e@80x24.org>; Mon,  6 Nov 2017 01:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751285AbdKFB2j (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 20:28:39 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64807 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750769AbdKFB2i (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 20:28:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 58E83B5308;
        Sun,  5 Nov 2017 20:28:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mCnNqBviIevGATc+bIbKOryS4+8=; b=kerU5m
        9FzIi2VLNXlv25/HEMdUhRvfusAvUitfWjJTmlqehIqOrw+Yu5ZN5qoySFqKWjdR
        8l843Dsqv3RIqthwVcIHbVxnpwSxGkVvFJ6BGNqS4LZ/qp9Dq7nj7eHzIOXE8ERo
        XBzQg63KVpfvvxuYLZbySbR91rCBajnIEcYpU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vLCKGrPt3OMeM0cPGtuyuLOUNWWEQeDr
        82ey/EYzeJJLEX+MfKNJG6SUcHrk/UhGcqlxnEws/RR2xz/hejTVT7iYxxgKSXUO
        tCjSEngySVZ8RR7bvRb9//lvszQEHfpo8h192068yLmfVMOEf5bGKLM/FsX7Dcm6
        01bS65+V4pE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 502AFB5307;
        Sun,  5 Nov 2017 20:28:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BB202B5306;
        Sun,  5 Nov 2017 20:28:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/7] files_transaction_prepare(): don't leak flags to packed transaction
References: <cover.1509183413.git.mhagger@alum.mit.edu>
        <b8e61183ad5d5c046a9eff75ea0401cf2c2567c6.1509183413.git.mhagger@alum.mit.edu>
        <xmqq60ax6y95.fsf@gitster.mtv.corp.google.com>
        <4d2e6a29-e612-2eab-1b20-0c97a8871c5c@alum.mit.edu>
Date:   Mon, 06 Nov 2017 10:28:36 +0900
In-Reply-To: <4d2e6a29-e612-2eab-1b20-0c97a8871c5c@alum.mit.edu> (Michael
        Haggerty's message of "Sun, 5 Nov 2017 07:46:21 +0100")
Message-ID: <xmqqshdsjiuz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D03D28C8-C291-11E7-8F9F-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

>> That much I can understand.  But it is not explained why (1) we do
>> not pass old_oid anymore and (2) we do give HAVE_NEW.  
>> 
>> Presumably the justification for (1) is something like "because we
>> are not passing HAVE_OLD, we shouldn't have been passing old_oid at
>> all---it was a harmless bug because lack of HAVE_OLD made the callee
>> ignore old_oid"
>
> It's debatable whether the old code should even be called a bug. The
> callee is documented to ignore `old_oid` if `HAVE_OLD` is not set. But
> it was certainly misleading to pass unneeded information to the function.
>
>>                     (2) is "we need to pass HAVE_NEW, and we have
>> been always passing HAVE_NEW because update->flags at this point is
>> guaranteed to have it" or something like that?
>
> Correct. `REF_DELETING` is set by `lock_ref_for_update()` only if
> `update->flags & REF_HAVE_NEW` was set, and this code is only called if
> `REF_DELETING` is set.

It is is extra nice for you to give answers that are customized for
me like the above to my questions, but the questions came because
the log message did not answer them, so please make sure the next
person who did not read this exchange but reads only the resulting
commit does not have to ask the same question.

Thanks.
