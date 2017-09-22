Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08D32202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 04:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751798AbdIVEXK (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 00:23:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51933 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751368AbdIVEXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 00:23:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 152829479A;
        Fri, 22 Sep 2017 00:23:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KOl6I2Jd11BNjS3A8EhPcUnl7Gw=; b=Sx6LrS
        j7G1h/rG5ashBwavMakLjDrskfF/fxZ3wNXnQvpctwMSC3OOVGBBQ1PgG2Bd6VOl
        YOqFyqgotRXfY9vSQfzy1VVykzrsvbPBhDRqdNS0y5ne6HQGQ3W673PrU6OOIXDY
        lcnwRK06I/qn0t37uBBX7WGS5a+cAZEsDGNyc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Scaz5mVuZ8UMOSeK17CzCiagV754wswr
        H+0K1YDtxQW4q3LWjYbjfASQUt9pRD57GHSOXx+jgw7VX4gEdptoQC/Z4q6FR0Og
        hSTCRLbl+KVN+YrJJyiP4PgfQkDqMCO+xfWg5WxD0OzaeMou1OPl3w9bE4WJ+bWe
        wHvjUKqyuiI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B3FA94799;
        Fri, 22 Sep 2017 00:23:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5647094798;
        Fri, 22 Sep 2017 00:23:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC v2] refs: strip out not allowed flags from ref_transaction_update
References: <CAMy9T_ED1KBqkE9GCHrOrt0frnYAx1vka7Xx1DrXmjJBNNKahw@mail.gmail.com>
        <20170912225921.27705-1-t.gummerer@gmail.com>
        <4ae6cb35-ecf4-e2a2-302d-95e1442cf101@alum.mit.edu>
Date:   Fri, 22 Sep 2017 13:23:07 +0900
In-Reply-To: <4ae6cb35-ecf4-e2a2-302d-95e1442cf101@alum.mit.edu> (Michael
        Haggerty's message of "Thu, 21 Sep 2017 10:40:43 +0200")
Message-ID: <xmqq8th7l5uc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC9B9410-9F4D-11E7-B2EA-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I wouldn't worry too much about this anomaly. `REF_ISPRUNING` is an ugly
> internal kludge, but allowing it in the mask doesn't make anything worse.
>
>>  refs.c | 2 ++
>>  refs.h | 8 ++++++++
>>  2 files changed, 10 insertions(+)
>> 
>> diff --git a/refs.c b/refs.c
>> index ba22f4acef..fad61be1da 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -921,6 +921,8 @@ int ref_transaction_update(struct ref_transaction *transaction,
>>  		return -1;
>>  	}
>>  
>> +	flags &= REF_TRANSACTION_UPDATE_ALLOWED_FLAGS;
>> +
>
> I would advocate considering it a bug if the caller passes in options
> that we are going to ignore anyway:
>
>         if (flags & ~REF_TRANSACTION_UPDATE_ALLOWED_FLAGS)
>                 BUG("illegal flags %x in ref_transaction_update", flags);

It sounds like a sensible thing to do.  Thanks.
