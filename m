Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2C8C0015E
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 19:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjHITHN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 15:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHITHM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 15:07:12 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1377B10DA
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 12:07:12 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A961F2280B;
        Wed,  9 Aug 2023 15:07:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=EzKeKNsFZX32
        IOJlDr6YJqvt6/3JSuw/ZC0KAPW+Mh4=; b=pSwHhTvBWeOIODfrur5OlJe9DSH/
        v2E9Zd4aHAXDqDbgCb5jC/Yv5TR3mr+QMpWEG8UVanJGsNyxM78+Gu2gWnaWsNR1
        fnDwXzIUqVBpTlY435vZCARwtZ5Qedfez/DQ9jBwsViHgfv1C/Gc41ztW8/qorUr
        4IjzFyFDKFhk8G4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A13132280A;
        Wed,  9 Aug 2023 15:07:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3B75822809;
        Wed,  9 Aug 2023 15:07:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] describe: fix --no-exact-match
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
        <xmqqo7k9fa5x.fsf@gitster.g>
        <4eea7e15-6594-93e2-27b5-3d6e3c0baac6@web.de>
        <20230808212720.GA760752@coredump.intra.peff.net>
        <xmqqzg3156sy.fsf@gitster.g>
        <20230809140902.GA775795@coredump.intra.peff.net>
        <22e5a87a-cd35-9793-5b6f-6eb368fdf40e@web.de>
Date:   Wed, 09 Aug 2023 12:07:07 -0700
In-Reply-To: <22e5a87a-cd35-9793-5b6f-6eb368fdf40e@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Wed, 9 Aug 2023 18:41:13 +0200")
Message-ID: <xmqqzg30m3vo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EFBD5738-36E7-11EE-8E88-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> Here's what it looks like, for reference.
>>
>> diff --git a/builtin/describe.c b/builtin/describe.c
>> index b28a4a1f82..718b5c3073 100644
>> --- a/builtin/describe.c
>> +++ b/builtin/describe.c
>> @@ -561,9 +561,11 @@ static void describe(const char *arg, int last_on=
e)
>>  static int option_parse_exact_match(const struct option *opt, const c=
har *arg,
>>  				    int unset)
>>  {
>> +	int *val =3D opt->value;
>
> This line would assign opt->value_int instead...
>
>> +
>>  	BUG_ON_OPT_ARG(arg);
>>
>> -	max_candidates =3D unset ? DEFAULT_CANDIDATES : 0;
>> +	*val =3D unset ? DEFAULT_CANDIDATES : 0;
>>  	return 0;
>>  }
>> ...
> Thoughts?  Too much churn?

Sorry, but I am not sure what is being proposed.  opt->value_int
would presumably be defined as a pointer to an int.  The calling
side presumably defines the options[] array entry so that the
&max_candidates address is given to opt->value_int and not to
opt->value_someothertype, and if you try to pass a pointer of a
wrong type, it would be caught as a type mismatch by the compiler,
so the above covers both ends (i.e. the address &max_candidates is
passed in the correct member of the struct, and the callback takes
val out of the correct member of the struct), as long as the
callback uses the right type.  If &max_candidates is int now, and
the above code is written to use opt->value_int, anybody who needs
to update max_candidates to ulong must make sure three things match,
i.e. the type of max_candidates variable itself, the member the
caller uses to pass &max_candidates in the struct (i.e. change to
use value_ulong and not value_int), and the type of the local
variable the callback function uses.

But I am failing to imagine how the calling side actually would look
like.  Can we do something along the lines of

    #define OPT_CALLBACK(s, l, v, a, h, cb)
	.short_name =3D (s),
	.long_name =3D (l),
	.value_ ## typeof(v) =3D &v,
	.help =3D (h),
	.callback =3D (cb),

with a clever CPP trick?  It sounds like either too much churn or
too much magic or both, at least to me.

Thanks.
