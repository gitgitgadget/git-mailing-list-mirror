Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209E8C4167B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 21:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D822523B03
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 21:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbgLHVBP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 16:01:15 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55903 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbgLHVBP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 16:01:15 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D6E94B6706;
        Tue,  8 Dec 2020 16:00:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4f1szD4mAqOA/UFo/lO1ptdX7K8=; b=FYX8Dk
        IZ2qIxTgvxW0zOKnwEZX4pXOd95HhKuBp//YpXDAfBHVis9BgHVsIkzdkO2lip5K
        mRZSWI/p8sbVIWTBjUhHr3SDURKJTL1ETRfjTykqxIdm8ms0/e+2lf2m5QkmTixn
        ZJ0KgLz2oiHSKMP+Qkg0S7L4gY24/MNgySd6k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IAmiZQZ8xHXPGF8d+ODLf03YfmcWq61r
        GddnGKbiLsWJhC9sZiMWhOJ0RaM1tBP3OWvdFBR1hn9vWkMLqDvcGsD2acmH8+mq
        9RYOg0qm/W9rYBnedvROnyBnsnuOfRNtQ6xqNReZ3a9qU6OK2B9GlhqVzJQ7gbia
        r4oe2/9LZMk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CF6C0B6705;
        Tue,  8 Dec 2020 16:00:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 48E63B6704;
        Tue,  8 Dec 2020 16:00:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: Cloning empty repository uses locally configured default branch
 name
References: <xmqq7dpt82l4.fsf@gitster.c.googlers.com>
        <20201208185538.973044-1-jonathantanmy@google.com>
Date:   Tue, 08 Dec 2020 13:00:31 -0800
In-Reply-To: <20201208185538.973044-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 8 Dec 2020 10:55:38 -0800")
Message-ID: <xmqqim9c6mj4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 68EDFEFA-3998-11EB-B918-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> > A small issue is that upload-pack protocol v0 doesn't even write the
>> > blank ref line ("000...000 capabilities^{}") if HEAD points to an unborn
>> > branch, but that can be fixed as in the patch below.
>> 
>> I think the codepaths we have today in process_capabilities() and
>> process_dummy_ref() (both in connect.c) would do the right thing
>> when it sees a blank ref line even when nothing gets transported,
>> but I smell that the rewrite of this state machine is fairly recent
>> (say in the past few years) and I do not offhand know if clients
>> before the rewrite of the state machine (say in v2.18.0) would be OK
>> with the change.  It should be easy to check, though.
>
> Yes - I backported my patch to v2.17.0 and it works:

I wouldn't be surprised if other reimplementations of Git (like
jgit, libgit2 and Go or Python or whatever your favorite language)
barfs, though.
