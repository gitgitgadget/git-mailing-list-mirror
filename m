Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886C9C433F5
	for <git@archiver.kernel.org>; Mon,  3 Jan 2022 23:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbiACXer (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 18:34:47 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64920 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiACXeq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 18:34:46 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6DD3C10EF9F;
        Mon,  3 Jan 2022 18:34:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Sspxd65y0maZIiHcEfur9SXdffQSFY/s1IfsSt
        e594g=; b=ErjZLvxpQvNeubwR+LGmOzVpmVUK/jFOaZfHapSToG0uPrQmPsl1k/
        PMRVdMwdM9rWS6v9HvbhP621oq31Zt526PG90hSARHTmZT7myLXeX1yDFcHeUtMz
        2wfSfc8o6BxKZchnuQlMsBDOAU9GDwFRB3OZVtaKxPuvUjnA10sSk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 647A010EF9E;
        Mon,  3 Jan 2022 18:34:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C4F6710EF9D;
        Mon,  3 Jan 2022 18:34:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Fabian Stelzer <fs@gigacodes.de>, Git List <git@vger.kernel.org>,
        Pedro Martelletto <pedro@yubico.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] gpg-interface: trim CR from ssh-keygen
References: <pull.1090.git.1638538276608.gitgitgadget@gmail.com>
        <20220103095337.600536-1-fs@gigacodes.de>
        <CAPig+cS6h6o2_dJAZC1M1Ace29bN2mhPgaEtTWtj3oXfcHq9cA@mail.gmail.com>
Date:   Mon, 03 Jan 2022 15:34:41 -0800
In-Reply-To: <CAPig+cS6h6o2_dJAZC1M1Ace29bN2mhPgaEtTWtj3oXfcHq9cA@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 3 Jan 2022 12:17:06 -0500")
Message-ID: <xmqqee5oieb2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BA2DA4DA-6CED-11EC-85AB-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Jan 3, 2022 at 9:24 AM Fabian Stelzer <fs@gigacodes.de> wrote:
>> We need to trim \r from the output of 'ssh-keygen -Y find-principals' on
>> Windows, or we end up calling 'ssh-keygen -Y verify' with a bogus signer
>> identity. ssh-keygen.c:2841 contains a call to puts(3), which confirms
>> this hypothesis. Signature verification passes with the fix.
>>
>> Helped-by: Pedro Martelletto <pedro@yubico.com>
>> Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
>> ---
>> diff --git a/gpg-interface.c b/gpg-interface.c
>> @@ -509,7 +509,10 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
>> -                       trust_size = strcspn(line, "\n");
>> +                       trust_size = strcspn(line, "\n"); /* truncate at LF */
>> +                       if (trust_size && trust_size != strlen(line) &&
>> +                           line[trust_size - 1] == '\r')
>> +                               trust_size--; /* the LF was part of CRLF at the end */
>
> I may be misunderstanding, but isn't the strlen() unnecessary?
>
>     if (trust_size && line[trust_size] &&
>         line[trust_size - 1] == '\r')
>             trust_size--;

That changes behaviour when "line" has more than one lines in it.
strcspn() finds the first LF, and the posted patch ignores CRLF not
at the end of line[].  Your variant feels more correct if the
objective is to find the end of the first line (regardless of the
choice of the end-of-line convention, either LF or CRLF) and omit
the line terminator.
