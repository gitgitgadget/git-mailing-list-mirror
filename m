Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03333C433DF
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 23:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFAEF20702
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 23:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YgiE8NG/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731332AbgGUXwE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jul 2020 19:52:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55780 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgGUXwE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jul 2020 19:52:04 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 85F5D6F07A;
        Tue, 21 Jul 2020 19:52:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0s8eXzX0s1tvZAnDw1fF4JXLKzo=; b=YgiE8N
        G/ZeRF9JU3A/Tyt9nny+7iO52bcwrUvqNDEB6V3+/DY21rpTMvc+AH2C7D2rcUa4
        0znpwqzleXxToChEpGA9VBzk9dI9FfwKB6MCmb34giXhqXw5vkKH6zz2Morxkp+E
        6LUqg/EjzzEj8DsfrdVkE+VvVSfEho4UB1+io=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mHWXyfLsSSk4MB2DuMOyn4qWsTBaTo6U
        mr5peLcVquEMp+kQ7g+DLTqlI8b7jQcpu7yp3/N8BIdiyPzXjzaN1YWfqXPqwple
        sJz+RH2QpnIx01CEKtMQ93kJ4kQZZmrePbCcnaHmHFCK5rRb/jYX5CElwE40UXY/
        ddrtmNdkVt8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D5B16F079;
        Tue, 21 Jul 2020 19:52:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B6A116F077;
        Tue, 21 Jul 2020 19:52:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sluongng@gmail.com
Subject: Re: [PATCH 2/2] pack-objects: prefetch objects to be packed
References: <xmqq5zag8yg5.fsf@gitster.c.googlers.com>
        <20200721232036.1358644-1-jonathantanmy@google.com>
Date:   Tue, 21 Jul 2020 16:51:59 -0700
In-Reply-To: <20200721232036.1358644-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 21 Jul 2020 16:20:36 -0700")
Message-ID: <xmqqzh7s5sv4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B880D3E-CBAD-11EA-B32F-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> My argument is that typically *no* objects are missing, so we should
> delay the prefetch as much as possible in the hope that we don't need it
> at all. I admit that if some objects are missing, I don't know where
> they will be in the to_pack list.

OK, if the common case we optimize for is where there is no object
missing, then of course "prefetch missing ones upfront" will spend
cycles to ensure all objects we will pack exist before going into
the main loop, so the "delay as much as possible" optimization makes
sense.

>> In any case, the design choice needs to be justified in the log
>> message.  I am not sure if the lazy decision to prefetch at the last
>> moment is really worth the code smell.  Perhaps it is, if there is a
>> reason to believe that it would save extra work compared to the more
>> naive "if we have promissor remote, prefetch what is missing", but I
>> do not think I've heard that reason yet.
>
> I still think that there is a reason (the extra existence check), but if
> we think that the extra existence check is fast enough (compared to the
> other operations in pack-objects) or that there is a way to avoid
> calling oid_object_info_extended() twice for the same object (even with
> moving the prefetch loop to the beginning), then I agree that we don't
> need the lazy decision. (Or if we want to write the simpler code now and
> only improve the performance if we need it later, that's fine with me
> too.)

Now I finally have, I think, heard some of the reasoning behind the
design decision made before this patch was written.  That should be
written in the proposed log message.

Thanks.

