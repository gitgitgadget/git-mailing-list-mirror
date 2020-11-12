Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7BDC5519F
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 17:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFD5D20759
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 17:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UUnM53Z4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgKLRU7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 12:20:59 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56572 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgKLRU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 12:20:59 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B42696884;
        Thu, 12 Nov 2020 12:20:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=h18Jdz3kccLp
        91Hgv9wo4MVJ+Ug=; b=UUnM53Z4xyo8BLqIJUXEWFfh5o7JeLKZLsndy8hM5noW
        NSKccL/b+SyQ9raYqr/+ZNk/7rRYEcUo/ENGXjB5AC3941NNqG2k9LHIBCgRhv08
        FK0u/WU9QTU6rDkh+u2b33btQ9x5GmM5IdDKYRZOlqbiL9F938eVES8qsJPOZj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Sz5uZN
        OlT88SNY4VoWokdFcCX3Wn+cN1kFdI+yS2RmhvrIdSIDNaNlBqnnt0fyAAx27UQc
        9IjWimcTJhCkII/0+RVm1NxEHJPjWHvm8v+xzLLWfuLzKxi6fhxphr2pSC068Izb
        +JNZu1bRSP8HHjumH4O/xAjvRMBNfzTb92nLo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B26F96883;
        Thu, 12 Nov 2020 12:20:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9E10696882;
        Thu, 12 Nov 2020 12:20:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/2] completion: bash: check for alias loop
References: <20201110020343.548848-1-felipe.contreras@gmail.com>
        <20201110020343.548848-3-felipe.contreras@gmail.com>
        <20201112100204.GC4270@szeder.dev>
Date:   Thu, 12 Nov 2020 09:20:55 -0800
In-Reply-To: <20201112100204.GC4270@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Thu, 12 Nov 2020 11:02:04 +0100")
Message-ID: <xmqqsg9ejxu0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6CE3B276-250B-11EB-9320-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>>  	while [[ -n "$cur" ]]; do
>> +		if [[ "$list" =3D=3D *"$cur "* ]]; then
>
> I suspect the right hand side should be *" $cur "* ...
>
>> +			# loop detected
>> +			return
>> +		fi
>> +
>>  		cmdline=3D$(__git config --get "alias.$cur")
>> -		last=3D$cur
>> +		list=3D"$cur $list"
>
> ... and this should be list=3D" $cur $list", because otherwise a partia=
l
> match is possible and would be mistaken for a loop (though I didn't
> actually test whether that's indeed the case).

Traditionist may use

	list=3D
	while :
	do
		cur=3D$(obtain cur somehow)
                case " $list " in
                *" $cur "*) : cur appears in list ;;
                esac
                list=3D"$cur${list+ }$list"
	done

to make the invariant "$list is a SP-separated tokens, no extra SP on
either ends" and I think the same idea would work with [[ $a =3D=3D $b ]]=
,
but "one SP on both ends, two SPs in between" like yours do is OK, too.

Not keeping excess SPs out of the list (unlike the above "no extra
SP on ends") means how "finally, take the first token in the list,
that's the answer" is coded, though.  You'd need to split off the
leading SP from it (below).

>>  		cur=3D
>> =20
>>  		for word in $cmdline; do
>> @@ -1149,7 +1154,7 @@ __git_aliased_command ()
>>  		done
>>  	done
>> =20
>> -	cur=3D$last
>> +	cur=3D"${list%% *}"
>>  	if [[ "$cur" !=3D "$1" ]]; then
>>  		echo "$cur"
>>  	fi
>> --=20
>> 2.29.2
>>=20
