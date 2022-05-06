Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC7BC433F5
	for <git@archiver.kernel.org>; Fri,  6 May 2022 18:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238515AbiEFSgC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 14:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiEFSgB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 14:36:01 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6508C6D4DD
        for <git@vger.kernel.org>; Fri,  6 May 2022 11:32:17 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 87DE017E56C;
        Fri,  6 May 2022 14:32:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=53dswNdInW22
        2J0/WAhtOeRY9oQR+wu9y/orZccdCM8=; b=fU8eziotygokC41dETSBLVfJs6AB
        UmVlXFe7VVnfM6AhMFAp0ivflwR268YDg8ZQ9wJzRGcbcXkrEfaP+2b7g0lEJxcG
        Pefr+XNcHoRz+aRYsYWhf9t0/eltBt1cjMxIUIOyJ4fMWY7hcf2Rm+VQSzIh1rrB
        XnOAQnK6nK1ZDUg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7F78117E56B;
        Fri,  6 May 2022 14:32:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.111.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0696217E56A;
        Fri,  6 May 2022 14:32:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jason Hatton <jhatton@globalfinishing.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] Prevent git from rehashing 4GBi files
References: <CY4PR16MB1655EE6CC2218AEA35B451E3AFC59@CY4PR16MB1655.namprd16.prod.outlook.com>
Date:   Fri, 06 May 2022 11:32:11 -0700
In-Reply-To: <CY4PR16MB1655EE6CC2218AEA35B451E3AFC59@CY4PR16MB1655.namprd16.prod.outlook.com>
        (Jason Hatton's message of "Fri, 6 May 2022 17:08:16 +0000")
Message-ID: <xmqqbkwaldg4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D8E01240-CD6A-11EC-9B9F-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jason Hatton <jhatton@globalfinishing.com> writes:

>>Philip Oakley <philipoakley@iee.email> writes:
>>
>>> This "Munge" above isn't telling the reader 'why'/'what' is going on.
>>> The comment should in some way highlight that a zero size result is
>>> special, and that we have the roll over issue when the stored in 32 b=
its
>>> - the double duty of racy vs changed in the stat data heuristic.
>>> Synonyms of 'munge' ?
>
> mangle?
> hash?
>
>>>
>>>
>>>> + */
>>>> +unsigned int munge_st_size(off_t st_size) {
>>>> +    unsigned int sd_size =3D st_size;
>>>> +
>>>> +    if(!sd_size && st_size)
>>
>>Style.
>
> Something like 1<<31?

Sorry, missing SP between "if" and "(" was what stood out like a
sore thumb.

>>
>>>> +        return 0x80000000;

The .sd_size member is merely defined as "unsigned int" and so is
the return value from this helper.  They have no idea how big an
integer they are dealing with.  It is limited to 32-bit explicitly
only because create_from_disk() uses get_be32() on ondisk->size to
get the value to be assigned to the member.

So I agree with writing it as 31-bit shift for ease of reading, but
perhaps a comment to indicate where that size comes from would help
the readers while we are at it, perhaps?

		return 1U<<31; /* ondisk_cache_entry.size */

I dunno.

>>>> +    else
>>>> +        return sd_size;
>>>> +}
>>
>>This may treat non-zero multiple of 4GiB as "not racy", but has
>>anybody double checked the concern R=C3=A9ne brought up earlier that a
>>4GiB file that was added and then got rewritten to 2GiB within the
>>same second would suddenly start getting treated as not racy?
>>
>>The patch (the firnal version of it anyway) needs to be accompanied
>>by a handful of test additions to tickle corner cases like that.
>>
>>Thanks, all, for working on this.
>
> If the file size is changed by exactly 2GiB is a concern. This is an is=
sue for
> files exactly a multiple of 4GiB. However, all files that are changed b=
y a
> multiple of 4GiB are vulnerable.

So if you have a 4GiB file, "git add" it, then rewrite it with a
different contents to make it a 8GiB file within the same second,
would Git mistakenly think that there is no change, because the racy
git protection is gone with this change?  I think that was one of
the concerns (there may have been others I am forgetting).

