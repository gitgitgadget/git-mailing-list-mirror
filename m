Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5306BC433E0
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 19:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E893A206F2
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 19:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mzvXV/V4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbgGUTXL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jul 2020 15:23:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60748 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgGUTXK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jul 2020 15:23:10 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F2106D295;
        Tue, 21 Jul 2020 15:23:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RSTOXz24qwxvy3LhP4LbIOdA1Tc=; b=mzvXV/
        V4xnhAAPMeGPEssdYeY9NhnFcDchsFhCGZOLdcDyCJlQTwQpVW3hmGIposnVxu6z
        GSn+A7mBaTzc6/18UGe95pvjZ23+pAom2l57qOLzN/57dJ7nYe9hOoxfn5tYn7F/
        dmDc7NXb8o10L7CfBwYuBVTpx5wK5n4h02JHo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SJQx8yS0PTmmKcYZ+zVajIFRq1tpsOm7
        7f9WMHED/azfV7KxWTzKw9HxLONd8tRUeZy+Ax5arcuxv+Zt40Q6Y/0BZn0Mqp9N
        fuxiQ1z40mRyITKGz7/fMtNaAtSqlwbTGc8AJylD8cWIJWpF/6LuX++x7BaaMFJi
        Qtutuwj+Luo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 772726D294;
        Tue, 21 Jul 2020 15:23:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 036A16D283;
        Tue, 21 Jul 2020 15:23:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sluongng@gmail.com
Subject: Re: [PATCH 2/2] pack-objects: prefetch objects to be packed
References: <xmqqd04p8ywt.fsf@gitster.c.googlers.com>
        <20200721163736.69610-1-jonathantanmy@google.com>
Date:   Tue, 21 Jul 2020 12:23:06 -0700
In-Reply-To: <20200721163736.69610-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Tue, 21 Jul 2020 09:37:36 -0700")
Message-ID: <xmqq5zag8yg5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9BA17B08-CB87-11EA-BE78-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> +	if (has_promisor_remote())
>> +		prefetch_to_pack(0);
>> +
>> 	for (i = 0; i < to_pack.nr_objects; i++) {
>> 
>> 
>> Was the patch done this way because scanning the entire array twice
>> is expensive?
>
> Yes. If we called prefetch_to_pack(0) first (as you suggest), this first
> scan involves checking the existence of all objects in the array, so I
> thought it would be expensive. (Checking the existence of an object
> probably brings the corresponding pack index into disk cache on
> platforms like Linux, so 2 object reads might not take much more time
> than 1 object read, but I didn't want to rely on this when I could just
> avoid the extra read.)
>
>> The optimization makes sense to me if certain
>> conditions are met, like...
>> 
>>  - Most of the time there is no missing object due to promisor, even
>>    if has_promissor_to_remote() is true;
>
> I think that optimizing for this condition makes sense - most pushes (I
> would think) are pushes of objects we create locally, and thus no
> objects are missing.
>
>>  - When there are missing objects due to promisor, pack_offset_sort
>>    will keep them near the end of the array; and

I do not see this one got answered, but it is crucial if you want to
argue that the "lazy decision to prefetch at the last moment" is a
good optimization.  If an object in the early part of to_pack array
is missing, you'd end up doing the same amount of work as the
simpler "if promissor is there, prefetch what is missing".

>>  - Given the oid, oid_object_info_extended() on it with
>>    OBJECT_INFO_FOR_PREFETCH is expensive.
>
> I see this as expensive since it involves checking of object existence.

But doesn't the "prefetch before starting the main loop" change the
equation? If we prefetch, we can mark the objects to be prefetched
in prefetch_to_pack() so that the main loop do not even have to
check, so the non-lazy loop taken outside the check_object() and
placed before the main loop would have to run .nr_objects times, in
addition to the main loop that runs .nr_objects times, but you won't
have to call oid_object_info_extended() twice on the same object?

>> Only when all these conditions are met, it would avoid unnecessary
>> overhead by scanning only a very later part of the array by delaying
>> the point in the array where prefetch_to_pack() starts scanning.
>
> Yes (and when there are no missing objects at all, there is no
> double-scanning).

In any case, the design choice needs to be justified in the log
message.  I am not sure if the lazy decision to prefetch at the last
moment is really worth the code smell.  Perhaps it is, if there is a
reason to believe that it would save extra work compared to the more
naive "if we have promissor remote, prefetch what is missing", but I
do not think I've heard that reason yet.

Thanks.
