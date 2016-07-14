Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 617A120196
	for <e@80x24.org>; Thu, 14 Jul 2016 20:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbcGNUWI (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 16:22:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54468 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751224AbcGNUWF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 16:22:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 65DAC2A97C;
	Thu, 14 Jul 2016 16:22:04 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dawcqWcbjZa8HPQMD85acaDOuHg=; b=rLu6t6
	8VLhUZvQLkFcEFw7XOfKhH+h8tjDqpaCwyv3y0m7Ai4GMHpK0q9FDhNgCjsJa6/l
	PvVNZIGoUIfdzupElrSKo5k8/uFZHauvLrtLINH+RM1Qm2KRoJO2ofXXolHHiSBj
	1lLbljZdMFFizqEwjMq33zsUtsPPdJgfP/8Pg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ex/SJsIxxOA9qj2MUTU6O4XJr6wHJf1P
	isFV8Yxe6uJxJ99o9JW1EkV056NsFE5n2mw2espFIX5VRLhuoVoBEUd0H6d42dgs
	S4t4XdMaDccGBEcTHJW55skhK80RsPBCCCYYSWCvxkY98m4FThoqQutwdjI3vyKX
	dGzB7slAtDk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B1FE2A97B;
	Thu, 14 Jul 2016 16:22:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CFE0E2A97A;
	Thu, 14 Jul 2016 16:22:03 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v4 2/5] t5000: test tar files that overflow ustar headers
References: <20160630090614.GA16725@sigill.intra.peff.net>
	<20160630090857.GB17463@sigill.intra.peff.net>
	<alpine.DEB.2.20.1607141745420.6426@virtualbox>
	<20160714182108.GB16497@sigill.intra.peff.net>
	<xmqqshvcourb.fsf@gitster.mtv.corp.google.com>
	<20160714201018.GA18372@sigill.intra.peff.net>
Date:	Thu, 14 Jul 2016 13:22:01 -0700
In-Reply-To: <20160714201018.GA18372@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 14 Jul 2016 16:10:18 -0400")
Message-ID: <xmqqbn20otqu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A0BDBA50-4A00-11E6-9E96-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> +#if ULONG_MAX == 0x7FFFFFFF
>> +#define USTAR_MAX_SIZE ULONG_MAX
>> +#define USTAR_MAX_MTIME ULONG_MAX
>> +#else
>>  #define USTAR_MAX_SIZE 077777777777UL
>>  #define USTAR_MAX_MTIME 077777777777UL
>> +#endif
>>  
>>  /* writes out the whole block, but only if it is full */
>>  static void write_if_needed(void)
>
> If for some reason we are wrong that objects cannot be larger than
> ULONG_MAX (e.g., later on we convert everything to size_t, and 64-bit
> LLP platforms handle large objects just fine), then we would prematurely
> switch to extended headers on those platforms.
>
> I think that's OK. This would just need cleaned up as part of the
> conversion from "unsigned long" to "size_t" (the correct check would
> then be against the max size_t).

> Also, shouldn't it be checking against 0xFFFFFFFF?

Correct.  Somehow I thought I was checking with LONG_MAX.  Will correct.

> An easier check would be "sizeof()", but I guess we can't use that in a
> preprocessor directive.

Yes, I tried it and failed ;-)

>> -test_expect_success TAR_HUGE 'system tar can read our huge size' '
>> +test_expect_success TAR_HUGE,64BIT 'system tar can read our huge size' '
>
> The 64BIT prereq is really "unsigned long is 64-bit". I wonder if we
> should call it UL64 or something like that to make it more clear.
>
> That makes it unnecessarily tied-in with the implementation, but it does
> make it more clear what we care about; the distinction matters for
> things like LP64 vs LLP64.

I do not think any platform is weird enough to have different sizes
for long and ulong, so I am not sure you need UL64.

But pointer size can legitimately be different, so it has a value to
differentiate between LP64 and LLP64, if we start doing things like
"does this platform have large virtual address space?"

LONG_IS_64BIT perhaps to be more readable?
