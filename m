Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B52C433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C9C564FE2
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhCKRxS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 12:53:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57864 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhCKRww (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 12:52:52 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0168ABC05D;
        Thu, 11 Mar 2021 12:52:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6vnNHXQtO0vqa2+oWDNxvHv1Uu8=; b=MDy/Sk
        Ag4OeXlsSOM9Gf3KK9RdGd0ClmRT1jUCyMF3kpxbJn4vf7tnu1Ih7EISh9zT6L17
        l/zL1Yube8/AAzIpilj58sLljxD5FRKhlMvJ37NP2jaGB63YT+PRAQ6F4cmXpQfr
        6I0l148qiGDB0r8kqCodL2tZKfctyedzxe76I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Bdg/OEFlTjQRVkmoJzHAqfJoXU4gliP+
        YRMAbzUpgAF+RL9htX9pk9PF1bnHl8sn5FYvLx/JrY95H7vbujpIckJF5hm0FNVO
        bShTkWI6yBBpfnrEfHtHPLoe/CGkGL0IRFJhlqvJqiaRZar9NPBXFAMZPocU7TY6
        rC8jaeeg7G4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EBC88BC05C;
        Thu, 11 Mar 2021 12:52:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7D811BC05B;
        Thu, 11 Mar 2021 12:52:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ephrim Khong <dr.khong@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] merge-recursive: create new files with O_EXCL
References: <f6cd9386-8a58-ee52-4c7b-60d9bd14a51d@gmail.com>
        <xmqqblbqipeh.fsf@gitster.g>
        <cd7c6682-7409-f72c-8751-02b70a423f83@gmail.com>
Date:   Thu, 11 Mar 2021 09:52:50 -0800
In-Reply-To: <cd7c6682-7409-f72c-8751-02b70a423f83@gmail.com> (Ephrim Khong's
        message of "Thu, 11 Mar 2021 10:54:41 +0100")
Message-ID: <xmqqlfatefwt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 996514AE-8292-11EB-B037-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ephrim Khong <dr.khong@gmail.com> writes:

>> I do not think we mind fixing the use of O_TRUNC with "remove and
>> then create with O_EXCL", but we'd probably want to
>> 
>>  * understand why only this place matters, or perhaps other uses of
>>    O_TRUNC needs the same fix to work "correctly" with your NFS
>>    mounts, in which case we'd need all of them addressed in the same
>>    series of patches, and
>
> I'd say that is up to you. Personally I'd rather err on the side of
> caution and leave the other code as is, especially since it is not
> really required for the file mode issue as described above.

OK.

Especially the other places are prepared to deal with a leftover
stale file, there is no reason to add extra cost to unlink before
recreating.  If we know this place we will never have an existing
file (because we unlinked), then TRUNC -> EXCL is a no-cost change
for us.

If some of these other places turn out to be problem for you and
other users who are affected by the same NFS mount problem, we may
need to replace these places' open(CREAT|TRUNC) with a wrapper that
conditionally does an unlink+open(CREAT|EXCL) with a Makefile knob.

But before doing any of that, we'd need to see ...

>>  * understand why your NFS mount is broken and give a better
>>    explanation as to why we need to have a workaround in our code.
>
> I'll work on this, but unfortunately have no idea of how to properly
> debug it. Since it is a company server without administrative rights and
> the backend is some IBM storage system, the options are limited and
> processes are slow. What I did find out so far is that it is not a race
> condition with unlink. A simple openat() without O_EXCL already produces
> the wrong file mode.

... this resolved, I would think.

Thanks.
