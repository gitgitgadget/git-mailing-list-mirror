Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0077B208CD
	for <e@80x24.org>; Tue, 15 Aug 2017 19:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752583AbdHOTTZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 15:19:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55173 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752311AbdHOTTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 15:19:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B7829C970;
        Tue, 15 Aug 2017 15:19:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ctYHBK8haHj5
        THOJOMJBh1WY0Rk=; b=PNHh5yBRgU9y5fEKdaH8gcbgfQ0yrL0xTyoReGA3meoK
        JIUX3ovqD/wq1c/cPfALAzsSfU1/H/Mr8Zf8mMlovAQc+F0+WenMOzY7zyKylKmY
        yYEqRaYtgSCy0JQH72YmrpVGH8SG2wUXZFerHZqP6flZ+fh9+4CnkDQ3vzDobww=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Y/ws1F
        8UEgaYm86UzjsnIVPucTH6KDV0vTUCVlAcx6ACaSUoOCg4I7tDu0bcPJFOP2pHK2
        P62Bdz9qvv+3qUEh1VS8gkFw1MkxQom3ySiczzhjuCnGf1InLUMDbC+nQPX0KYxD
        XMVIWZlns1CeZfMUTJBkWeWkoMGcnoCVZEHUE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 942089C96F;
        Tue, 15 Aug 2017 15:19:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 04BB29C96B;
        Tue, 15 Aug 2017 15:19:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/5] strbuf_reset: don't write to slopbuf with ThreadSanitizer
References: <cover.1502780343.git.martin.agren@gmail.com>
        <931ffb00319f40e3c9e099f17eeae6a0c1de41ea.1502780344.git.martin.agren@gmail.com>
        <xmqqk224r7rv.fsf@gitster.mtv.corp.google.com>
        <CAN0heSqwBNqrQPxOFZPCdFDA58P0JsKUqrw-KhVCcE1WKFTKbA@mail.gmail.com>
Date:   Tue, 15 Aug 2017 12:19:22 -0700
In-Reply-To: <CAN0heSqwBNqrQPxOFZPCdFDA58P0JsKUqrw-KhVCcE1WKFTKbA@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Tue, 15 Aug 2017 21:06:13
 +0200")
Message-ID: <xmqq7ey4r64l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A5B42658-81EE-11E7-8093-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

>> diff --git a/strbuf.h b/strbuf.h
>> index 2075384e0b..1a77fe146a 100644
>> --- a/strbuf.h
>> +++ b/strbuf.h
>> @@ -147,7 +147,10 @@ static inline void strbuf_setlen(struct strbuf *s=
b, size_t len)
>>         if (len > (sb->alloc ? sb->alloc - 1 : 0))
>>                 die("BUG: strbuf_setlen() beyond buffer");
>>         sb->len =3D len;
>> -       sb->buf[len] =3D '\0';
>> +       if (sb->buf !=3D strbuf_slopbuf)
>> +               sb->buf[len] =3D '\0';
>> +       else
>> +               assert(!strbuf_slopbuf[0]);
>>  }
>>
>>  /**
>
> When writing my patch, I used assert() and figured that with tsan, we'r=
e
> in some sort of "debug"-mode anyway. If we decide to always do the
> check, would it make sense to do "else if (strbuf_slopbuf[0]) BUG(..);"
> instead of the assert? Or, if we do prefer the assert, would the
> performance-worry be moot?

I wasn't thinking about performance impact of having an assert();
the use of it in the above was merely copied from yours ;-)
