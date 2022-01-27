Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A259AC433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 18:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244927AbiA0SXK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 13:23:10 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56384 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244957AbiA0SXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 13:23:09 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2274917F6B3;
        Thu, 27 Jan 2022 13:23:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=t2ZwUSHmCYYW
        kVx4kBCMwUA+mcVwj1MtaRqooq2l0lc=; b=TCvZSueut/3hJSQVENBwmM6fwoK7
        ogLrwm30PChFCrAuOOlMUaJfcSLnFnMdcSEQdXi7ljFJGpm3l9tsMTRRvogHnfeB
        l7oY5cvTHEzBm5lu92XBNQYagzuOft1Jr5K+BkplMCtdYTIuMvZ3RK/OScnmkrAd
        dmbIn0eK6D0Ec8I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1B9BF17F6B2;
        Thu, 27 Jan 2022 13:23:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8E1CA17F6B0;
        Thu, 27 Jan 2022 13:23:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] http API: fix dangling pointer issue noted by GCC 12.0
References: <patch-1.1-1cec367e805-20220126T212921Z-avarab@gmail.com>
        <xmqqczkengsg.fsf@gitster.g> <xmqq8rv2nggn.fsf@gitster.g>
        <220127.86mtjhdeme.gmgdl@evledraar.gmail.com>
Date:   Thu, 27 Jan 2022 10:23:05 -0800
In-Reply-To: <220127.86mtjhdeme.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 27 Jan 2022 04:45:19 +0100")
Message-ID: <xmqqv8y52g3a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2C44F984-7F9E-11EC-8738-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> If the motivation behind the original "do not get fooled by a reused
>> slot still working on somebody else's request---instead return when
>> our request is done" was indeed what I speculated, then the pointer
>> slot->finished when we leave this function should not matter to
>> anybody.  Would the following patch make the compiler realize that
>> we never smuggle a local variable's address out of this function via
>> a pointer in the structure?
>>
>>  http.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git c/http.c w/http.c
>> index 229da4d148..85437b1980 100644
>> --- c/http.c
>> +++ w/http.c
>> @@ -1367,6 +1367,9 @@ void run_active_slot(struct active_request_slot =
*slot)
>>  			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
>>  		}
>>  	}
>> +
>> +	if (slot->finished =3D=3D &finished)
>> +		slot->finished =3D NULL;
>>  }
>> =20
>>  static void release_active_slot(struct active_request_slot *slot)
>
> Yes, that does quiet it. The GCC warning is specifically about pointers
> that survive the exit of the function.

Thanks for a quick testing.

The real question is if this breaks anything.  By definition, if
this changes the behaviour, it is an indication that the code has
been somehow depending on having a pointer to a stackframe that has
already gone out of scope, which is a more serious problem.  I am
wondering if we need to dig further to find it out, and if so, how.

In any case, it looks like a more correct fix to address the "early
GCC 12" problem, than reverting baa7b67d (HTTP slot reuse fixes,
2006-03-10), at least to me.

Unless we devise another way to address the "slot reuse" issue, or
we come up with an explanation that the "slot reuse" issue is no
longer possible in todays code, that is.

Thanks.
