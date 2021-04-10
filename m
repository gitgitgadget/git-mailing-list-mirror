Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA074C433ED
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 22:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABF0C610E5
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 22:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbhDJW4U (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 18:56:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64612 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbhDJW4U (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Apr 2021 18:56:20 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F8DFC5036;
        Sat, 10 Apr 2021 18:56:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yYtATD9updAa
        13c0zGg+VpH3icc=; b=yE/XlU4mb+4fTatew79gfhoIVZT0luC+5XjM7nON4kOq
        buxBmLpvU0yM482VUo+pOcdqonwRkpCNIk+lZ4OcUp1FTggGeXO5Sz21HXzsJlFG
        UbByRdl+V5FanMhS4uY7zHkb+5x5NrWAlA3sBMweQKH8ZAPPvzEp6aPBrq+wjnc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=P+TgkZ
        MHwUmnKe2Bi7AEs1n6l644i1HTgjf/atUf7aO2d2rG3WXzC+eoGOHdhXlNgT7xpp
        k8LaKJMqaEqItfV4SuAg60sE+4IG/AbAYFHWg5oGMNJJwfZf18B6G8dbcY/XFasr
        ssRfdnLfL+MKVTPsxOOsJw/2LhYtzJb/KAlDE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C266BC5034;
        Sat, 10 Apr 2021 18:56:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5508EC5032;
        Sat, 10 Apr 2021 18:56:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Subject: Re: [PATCH] merge-ort: only do pointer arithmetic for non-empty lists
References: <pull.930.git.1618043449249.gitgitgadget@gmail.com>
        <1866b90b-fe07-18df-0d60-e2350d935375@web.de>
Date:   Sat, 10 Apr 2021 15:56:01 -0700
In-Reply-To: <1866b90b-fe07-18df-0d60-e2350d935375@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 10 Apr 2021 13:48:18 +0200")
Message-ID: <xmqq8s5pkav2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EC5F6748-9A4F-11EB-9B10-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> diff --git a/merge-ort.c b/merge-ort.c
>> index 5e118a85ee04..4da4b4688336 100644
>> --- a/merge-ort.c
>> +++ b/merge-ort.c
>> @@ -2504,8 +2504,10 @@ static void write_tree(struct object_id *result=
_oid,
>>  	 * We won't use relevant_entries again and will let it just pop off =
the
>>  	 * stack, so there won't be allocation worries or anything.
>>  	 */
>> -	relevant_entries.items =3D versions->items + offset;
>> -	relevant_entries.nr =3D versions->nr - offset;
>> +	if (versions->nr) {
>> +		relevant_entries.items =3D versions->items + offset;
>> +		relevant_entries.nr =3D versions->nr - offset;
>> +	}
>>  	QSORT(relevant_entries.items, relevant_entries.nr, tree_entry_order)=
;
>
> Reading the diff I was wondering if QSORT now gets handed uninitialized
> values if version-nr is 0.  The answer is no -- relevant_entries is
> initialized at declaration.  Otherwise the compiler would have probably
> warned, but sometimes it gets confused.
>
> I wonder why relevant_entries is introduced at all, though.  It's not
> referenced later.  So how about this instead?
>
> 	if (versions->nr)
> 		QSORT(versions->items + offset, nr, tree_entry_order);
>
> The intent to sort the last versions->nr-offset entries of versions,
> but only if it's not empty, is easier to see like this, I think.

That does make sense.  I wonder if there needs some assertion to
ensure that "offset" does not exceed "versions.nr", though.
