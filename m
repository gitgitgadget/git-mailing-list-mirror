Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B59C433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 21:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84CAA22CE3
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 21:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgLDVzS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 16:55:18 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50265 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgLDVzR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 16:55:17 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D613110FB12;
        Fri,  4 Dec 2020 16:54:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6XNbl9LsnBuPMjTfbN7pvPmSVIo=; b=PyiseZ
        Wya6n5+j0cz0590NSneG0ZjRTw/fllMhwG9rqOo/3kBuKNpTXvypG6qdtnjcFOz2
        g5fJ27Ccm7XhkWl0b31pMlUvd1h5SnVK6dT28yomE9Le6Ksuca1pvD6N3Uv6nHQp
        KG2BCWVQC5o5U4a1UXv/VAs+AZIfBJSUYSTMU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qqTCfNF1Iiy+wFtw65l4uSPVUK0fkYvx
        L1jFoyZRkfo303C87EC2nmhfqpWvU2MPjdOF4G3TgyF39GMfxy8F3e9gSMt6Ck1V
        IoLECl6gRmx0MrTjDqRJhZuV7ZHWIPHuAoPNECTbUk1ECS3TDTdAiSOnGoEF1Sfe
        3lHkuisSJcI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CF49C10FB11;
        Fri,  4 Dec 2020 16:54:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 219FF10FB0D;
        Fri,  4 Dec 2020 16:54:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 6/9] oid-array: provide a for-loop iterator
References: <X8qEg/KiAQDugPC0@coredump.intra.peff.net>
        <X8qFo+GJJTbaPV58@coredump.intra.peff.net>
        <CAPig+cTLs5bkY=Pwg+4tT2KHfVHFjkrNTeS_ygGEwq0cOOJ9wQ@mail.gmail.com>
Date:   Fri, 04 Dec 2020 13:54:31 -0800
In-Reply-To: <CAPig+cTLs5bkY=Pwg+4tT2KHfVHFjkrNTeS_ygGEwq0cOOJ9wQ@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 4 Dec 2020 14:18:45 -0500")
Message-ID: <xmqq1rg5dyp4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4AF763B6-367B-11EB-A5DF-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Dec 4, 2020 at 1:54 PM Jeff King <peff@peff.net> wrote:
>> [...]
>> The caller does have to remember to sort the array first. We could add
>> an assertion into the helper that array->sorted is set, but I didn't
>> want to complicate what is otherwise a pretty fast code path.
>> [...]
>> Signed-off-by: Jeff King <peff@peff.net>
>> ---
>> diff --git a/oid-array.h b/oid-array.h
>> @@ -111,4 +113,24 @@ void oid_array_filter(struct oid_array *array,
>> +/**
>> + * Find the next unique oid in the array after position "cur". You
>> + * can use this to iterate over unique elements, like:
>> + *
>> + *   size_t i;
>> + *   oid_array_sort(array);
>> + *   for (i = 0; i < array->nr; i = oid_array_next_unique(array, i))
>> + *     printf("%s", oid_to_hex(array->oids[i]);
>> + *
>> + * Non-unique iteration can just increment with "i++" to visit each element.
>> + */
>
> Minor: I see that the example code sorts the array first -- which is
> necessary, as explained in the commit message -- but I wonder if it is
> worth calling out explicitly in the prose:
>
>     Find the next unique oid in the array after position `cur`.
>     The array must be sorted for this to work. You can use
>     this to iterate over unique elements like this:
>
>> +static inline size_t oid_array_next_unique(struct oid_array *array, size_t cur)

Perhaps the function can make it clear that it expects to be fed a
sorted array in its name, which would be even better?

>> +{
>> +       do {
>> +               cur++;
>> +       } while (cur < array->nr &&
>> +                oideq(array->oid + cur, array->oid + cur - 1));
>> +       return cur;
>> +}
