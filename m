Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E9AC433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 13:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3C186191D
	for <git@archiver.kernel.org>; Tue, 11 May 2021 13:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbhEKNGi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 09:06:38 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52051 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbhEKNGh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 09:06:37 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A856711CB05;
        Tue, 11 May 2021 09:05:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fpeG2Sh87IkgcV8OxZa3uYFrOkpoq6VqXUOAyV
        zWOfw=; b=w4/c0R9AUaEDsN7Rh5hhlG9z9fkDie4iCNn7dF3APCclD8ocUUOaMP
        JfZKuhkqLflY9H1Cm/BkAKgN3OeplqO9jAq1qq8rN52WKUSrdyU5knOJh/H+qLkN
        G4ol50m6dKgp+Z0bAOoL4QRjL5uxwScHTAE1WJMQYrTBMIVGCa7DE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8A3F011CB04;
        Tue, 11 May 2021 09:05:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A6CD611CB01;
        Tue, 11 May 2021 09:05:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Hariom Verma <hariom18599@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v2 2/2] [GSOC] ref-filter: introduce enum atom_type
References: <pull.951.git.1620487353.gitgitgadget@gmail.com>
        <pull.951.v2.git.1620659000.gitgitgadget@gmail.com>
        <a1f70b39b7efbadff9e2202968dd1ca65ea3c1b4.1620659000.git.gitgitgadget@gmail.com>
        <xmqqh7jaow31.fsf@gitster.g>
        <CAP8UFD3m0TA3nPDaPhaU3=FVF_r5cPM8xksVL6MpCOhNC4dT3g@mail.gmail.com>
Date:   Tue, 11 May 2021 22:05:25 +0900
In-Reply-To: <CAP8UFD3m0TA3nPDaPhaU3=FVF_r5cPM8xksVL6MpCOhNC4dT3g@mail.gmail.com>
        (Christian Couder's message of "Tue, 11 May 2021 07:51:44 +0200")
Message-ID: <xmqqbl9hmne2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E781E6E-B259-11EB-B10A-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> If it's -1 instead of 0, then it might be a bit more complex to
> initialize structs that contain such a field, as it cannot be done
> with only xcalloc().

In general, yes, but I would have thought that the codepath that
allocates used_atom[] elements are pretty isolated---it is not like
there are random xcalloc() all over the code.  In fact, there is
only one "used_atom_cnt++" in the whole file, which means there is
only one place that (re)allocates the array.

	...
	at = used_atom_cnt;
	used_atom_cnt++;
	REALLOC_ARRAY(used_atom, used_atom_cnt);
	used_atom[at].name = xmemdupz(atom, ep - atom);
	used_atom[at].type = valid_atom[i].cmp_type;
	used_atom[at].source = valid_atom[i].source;
	...

So, I do not think there is even any need to worry about "initialize
to invalid and fill it in as we discover what it really is"; if
there were such a use pattern, UNKNOWN would be handy, but that is
not what we are dealing with here.  In the above snippet, we already
have found from which valid_atom[] element to instantiate the new
element in used_atom[] array.

>> > + * ATOM_INVALID equals to the size of valid_atom array, which could help us
>> > + * iterate over valid_atom array like this:
>> > + *
>> > + *   for (i = ATOM_UNKNOWN + 1; i < ATOM_INVALID; i++) {
>>
>> I find it far more intuitive to say
>>
>>         for (i = 0; i < ATOM_INVALID; i++)
>>
>> than having to say UNKNOWN+1.

And here I was being embarrassingly silly.

As long as we do not waste any entry in valid_atom[] with leading
gap, trailing gap or gap in the middle, the way to iterate over such
an array is

	for (i = 0; i < ARRAY_SIZE(valid_atom); i++)

hence, there is no need for ATOM_MAX, and no need to burden us to
remember that UNKNOWN is near the bottom of the range, and INVALID
is near the top of the range.

