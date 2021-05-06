Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6894CC433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 02:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E43B610E9
	for <git@archiver.kernel.org>; Thu,  6 May 2021 02:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhEFCNP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 22:13:15 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50506 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhEFCNP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 22:13:15 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 33576124573;
        Wed,  5 May 2021 22:12:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6HKWuHIKlJD29wjb/LjXKjw6R25D46iAxSN46z
        827qQ=; b=yiJPzwIwlOuHFtHPYIfb6RwpuPviL0aQObxMAq6uMAvOAd1/wppNPA
        iLcKtUMJV+Ff9lwjGwMHpsxLHCqHD/wB47PTm4WIldW0MoU5W7mtFM7dJnuRgOKa
        OEN0uz/k6+BWDvcUB2khQUnzOvpAaCBtJI4sVIeksDhoJHRUGpkTs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2C6FB124572;
        Wed,  5 May 2021 22:12:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6C65712456F;
        Wed,  5 May 2021 22:12:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 4/5] fetch: teach independent negotiation (no packfile)
References: <cover.1617929278.git.jonathantanmy@google.com>
        <cover.1620162764.git.jonathantanmy@google.com>
        <1de34a6dced3f5477162dd675615342bc2dec05f.1620162764.git.jonathantanmy@google.com>
        <xmqq4kfi54kb.fsf@gitster.g>
        <9f650594-c8a6-4d89-2686-49de48aabb62@gmail.com>
Date:   Thu, 06 May 2021 11:12:13 +0900
In-Reply-To: <9f650594-c8a6-4d89-2686-49de48aabb62@gmail.com> (Derrick
        Stolee's message of "Wed, 5 May 2021 12:42:09 -0400")
Message-ID: <xmqqbl9o1ugy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A015CA4-AE10-11EB-9AFE-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> Moving to lookup_object() made me look around, but at this point the
>> object in question (which comes from the negotiation_tips) has been
>> instantiated, so it is OK.
>> 
>>     Side note. The big difference between lookup and parse is what
>>     happens when this process hasn't seen the object yet---the
>>     former will just return NULL instead of instantiating the
>>     in-core copy; for that reason, it is easier on the readers to
>>     use parse_object() if we know we want an in-core object *and*
>>     when we use it we want to see it parsed already).
>
> Please forgive my incorrect recommendation here. I was expecting
> lookup_object() to behave like lookup_commit(), which creates the
> object if it is not already in the cached set.

It is not wrong per-se to recommend or use lookup_object() in this
case, as long as who recommends or uses the function is certain that
the object should already exist in-core.

But it is just that the lookup_object() is often not what the caller
wants to use; it is a very rare use case for a caller to be able to
say "I am OK for you to return NULL to me for this object, even if
it is in our object store, when we do not yet have it in-core".  The
only exception is the implementation of lookup_<type>() helpers,
where they handle "not loaded yet" answer from lookup_object() with
create_object() and always return usable in-core object to the
caller.

So the sole practical use case for lookup_object() outside the
lookup_<type>() implementation becomes "I am 100% sure that an
object with this object name has already been loaded in-core, so
please let me access it", which may be optimized for a wrong case
(because most of the API pass in-core objects, not object names,
around).  I am not sure if this particular API strangeness can be
remedied, though.

Thanks.
