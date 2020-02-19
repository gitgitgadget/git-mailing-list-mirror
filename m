Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FE3C3524E
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 21:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D6124654
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 21:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rRClDo7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbgBSVjd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 16:39:33 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58073 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgBSVjd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 16:39:33 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 66777C2201;
        Wed, 19 Feb 2020 16:39:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8YV0g/7VYgrjJaNqpTz1S2wW1S0=; b=rRClDo
        7HYILFmHtYqGl92NyR/TpWfeCIA5QjrQcauEIq2F0QETV+J3tt+UIhRla2npABe1
        h6SInGcmNJ5yT5dLUiCm6DHM+1GiNEdt+JvPsoAYkfc6hYjmXiVYIOe2vPfugjJQ
        v7gBt/NMpAK7Sz6UZCD66GY8edSjuqYh2sH3I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pcNMH/BPMsA3kvYmUwt1Wkc8bcdENu4m
        HHdhKmHQnSSYb1mnkgKeIyVL4do147xMWXQZiSNe1jIVkRMMMOSx8mWdeH5t8ln0
        N20qai00tCARAhyIJk4cfPdoes9kC+bS6mXGg1BieNwI4GfI4GuHJVkl8vUro/KV
        9RbWdZqZZfY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5D9EEC2200;
        Wed, 19 Feb 2020 16:39:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7702AC21FF;
        Wed, 19 Feb 2020 16:39:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] merge-recursive: fix the refresh logic in update_file_flags
References: <pull.712.v3.git.git.1582064105813.gitgitgadget@gmail.com>
        <pull.712.v4.git.git.1582131847.gitgitgadget@gmail.com>
        <ba297fd67bb98bd06408241030cf42f410d5d366.1582131847.git.gitgitgadget@gmail.com>
        <xmqq4kvmfmjy.fsf@gitster-ct.c.googlers.com>
        <CABPp-BFH2qgM2oR-6g-3RgPegpq4yZujizxCb=_Ax0g2WFOYYw@mail.gmail.com>
Date:   Wed, 19 Feb 2020 13:39:26 -0800
In-Reply-To: <CABPp-BFH2qgM2oR-6g-3RgPegpq4yZujizxCb=_Ax0g2WFOYYw@mail.gmail.com>
        (Elijah Newren's message of "Wed, 19 Feb 2020 11:32:03 -0800")
Message-ID: <xmqq36b6dzox.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E5ECEA8-5360-11EA-A5E8-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> Hmph, !.call_depth would avoid resetting update_wd to 0, so the only
>> difference this patch makes is when the caller of this helper passed
>> (update_wd == 0) during the outermost merge.  We did not tell
>> add_cacheinfo() to refresh, and refresh_cache_entry() was not
>> called.  But the new code forces refresh to happen for normal
>> entries.  The proposed log message explains that a refresh is needed
>> for a new cache entry, but if I am reading the code correctly, this
>> function is called with !update_wd from two places, one of which is
>> the "Adding %s" /* do not overwrite ... */ the log message mentions.
>>
>> But the other one?  When both sides added identically, we do have an
>> up-to-date result on our side already, so shouldn't we avoid forcing
>> update_wd in that case?
>
> This change doesn't force update_wd (write out a new file, also
> implies refreshing is needed), this only forces refreshing (check
> stat-related fields of existing file).
>
>> I do not think passing refresh==1 in that case will produce an
>> incorrect result, but doesn't it force an unnecessary refreshing?
>>
>> Puzzled.
>
> It does force a refreshing, and it is a necessary one based on
> merge-recursive's design.  You can verify by putting an "exit 1" right
> ...
> So, this was a bug all along for BOTH cases, we just didn't notice before.

Ah, thanks.  It was just me getting a wrong impression from the
proposed log message that only the other one needed refresh; if both
sides need a refresh, then the change is absolutely correct.

Thanks for clearing my puzzlement.  Will queue.

