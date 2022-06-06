Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40F8C433EF
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 17:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiFFRXS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 13:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiFFRXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 13:23:16 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8451BE35
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 10:23:13 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EF1CA19E9F2;
        Mon,  6 Jun 2022 13:23:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=VhKhaAKCkjW/
        qGYYMCrhbLChGIkHXt16q37MbCHF/Q4=; b=kqOb98jt+KtHp7g1r8UZ0jPYG/AH
        55LObYwAklJew0198R152iVyJu4g7rI5QqmiMhlFGRtj6/SBSZY9Le3ZYbSs8NlR
        DC1jk6sIlTqPmnvEHH2Ll8gNmmJSMQgGDmHM6P+H4IOlr89TjFQXyeR0+AAvgmhf
        qBn4qsd2Hbcbsfw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E6F4719E9F1;
        Mon,  6 Jun 2022 13:23:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4557F19E9EE;
        Mon,  6 Jun 2022 13:23:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH] read-cache.c: reduce unnecessary cache entry name copying
References: <pull.1249.git.1654436248249.gitgitgadget@gmail.com>
        <9195fe51-a696-1fb7-3617-a5b65358a806@web.de>
Date:   Mon, 06 Jun 2022 10:23:06 -0700
In-Reply-To: <9195fe51-a696-1fb7-3617-a5b65358a806@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 6 Jun 2022 11:48:13 +0200")
Message-ID: <xmqqy1y9905h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5538CAF2-E5BD-11EC-AEF3-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> diff --git a/read-cache.c b/read-cache.c
>> index 96ce489c7c5..e61af3a3d4d 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -1944,8 +1944,6 @@ static struct cache_entry *create_from_disk(stru=
ct mem_pool *ce_mem_pool,
>>  	ce->ce_namelen =3D len;
>>  	ce->index =3D 0;
>>  	oidread(&ce->oid, ondisk->data);
>> -	memcpy(ce->name, name, len);
>> -	ce->name[len] =3D '\0';
>
> This removal looks  correct to me.  The extra copying was added by
> 575fa8a3ed (read-cache: read data in a hash-independent way, 2019-02-19=
)
> but its commit message doesn't mention it.

I agree with the analysis.  When we are prefix-compressing the
entry, name[] may be much shorter than len, so this memcpy() may
potentially be reading beyond the end of the on-disk buffer, so the
original code is not just redundant, but it may simply be wrong.

Thanks, both.  Will queue.

>>
>>  	if (expand_name_field) {
>>  		if (copy_len)
>
> Some more context lines would help to see the redundancy; here they are=
:
>
> 	if (expand_name_field) {
> 		if (copy_len)
> 			memcpy(ce->name, previous_ce->name, copy_len);
> 		memcpy(ce->name + copy_len, name, len + 1 - copy_len);
> 		*ent_size =3D (name - ((char *)ondisk)) + len + 1 - copy_len;
> 	} else {
> 		memcpy(ce->name, name, len + 1);
> 		*ent_size =3D ondisk_ce_size(ce);
> 	}
>
>>
>> base-commit: ab336e8f1c8009c8b1aab8deb592148e69217085
