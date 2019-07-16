Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CA861F461
	for <e@80x24.org>; Tue, 16 Jul 2019 16:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387770AbfGPQyF (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 12:54:05 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53801 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbfGPQyF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 12:54:05 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 964356DD8A;
        Tue, 16 Jul 2019 12:54:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3qUKQJbt5/yc483kABypZoH1HOY=; b=N/3jxP
        97KWOvxnoekQQn+6meGbbDkpb6/rSOoTz+B8eLkpVBS0V3ON9AWR5PIpv6iKrR+x
        tYsnmFzZw+duhLGOx+y2KOr4d8m4tXuNfx1UCervhgJb3pvuIwvdZypEztzEmTFK
        N4ZrE16fy+GwkLYz/BTjml/YUxt6aBMmA+XYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LV+ZTRUQeaVHO40HlwWWn6bU1GiNVaf9
        aLL7OfMKiCtEl1CwxarCqsR0tKphacH8/u1apAPIWfTRkfzPUQAjTJwVXb2lB+Ul
        JVYGkdxiEthuyZeS1zeSRyYSNjeM9QmhS6nQrv0NmMiz+a01CpFVShaWkoMtUK2J
        4qXNTQuhNI4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8E28E6DD89;
        Tue, 16 Jul 2019 12:54:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 965506DD84;
        Tue, 16 Jul 2019 12:54:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] transport-helper: enforce atomic in push_refs_with_push
References: <20190702005340.66615-1-emilyshaffer@google.com>
        <20190709211043.48597-1-emilyshaffer@google.com>
        <CAPUEspgjSAqHUP2vsCCjqG8b0QkWdgoAByh4XdqsThQMt=V38w@mail.gmail.com>
Date:   Tue, 16 Jul 2019 09:53:59 -0700
In-Reply-To: <CAPUEspgjSAqHUP2vsCCjqG8b0QkWdgoAByh4XdqsThQMt=V38w@mail.gmail.com>
        (Carlo Arenas's message of "Tue, 16 Jul 2019 00:10:16 -0700")
Message-ID: <xmqq8ssx53a0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4FE7E286-A7EA-11E9-B60B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> On Tue, Jul 9, 2019 at 2:16 PM Emily Shaffer <emilyshaffer@google.com> wrote:
>>
>> diff --git a/transport.c b/transport.c
>> index f1fcd2c4b0..d768bc275e 100644
>> --- a/transport.c
>> +++ b/transport.c
>> @@ -1226,6 +1226,19 @@ int transport_push(struct repository *r,
>>                 err = push_had_errors(remote_refs);
>>                 ret = push_ret | err;
>>
>> +               if ((flags & TRANSPORT_PUSH_ATOMIC) && err) {
>> +                       for (struct ref *it = remote_refs; it; it = it->next)
>
> moving "struct ref it" out of the loop, allows for building with ancient
> compilers that don't support C90 (even if only by default) as I found
> out while building pu in a Centos 6 box

Does everything else compile OK with your rather old compiler on
Centos 6?  I was historically rather pedantic to stick to C89 but
for past several years we've been experimenting with a bit more
modern features of the language to see if anybody screams (namely,
designated initializers in structs and arrays, and trailing comma in
enum definition) but I think we still reject variable definition in
for loop control (we saw and rewrote another patch that tried to use
it late last year).

Apparently, this one slipped our review process.

Thanks.

cf. https://public-inbox.org/git/xmqqwopgqsws.fsf@gitster-ct.c.googlers.com/
cf. https://public-inbox.org/git/xmqqmuuz9jih.fsf@gitster-ct.c.googlers.com/



 
