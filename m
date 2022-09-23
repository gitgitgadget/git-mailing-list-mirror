Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322D0C04A95
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 17:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiIWR0K (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 13:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbiIWRZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 13:25:58 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51130EDD17
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 10:25:55 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D8E64151D8F;
        Fri, 23 Sep 2022 13:25:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4R379Z+pmKg9ksXMeQMqFPmViXX1JPyz7H7Q+z
        tAp5o=; b=vMXbpnpGKXuBtgcrXLwA3Peb3v3wcEpvSMfMrnKFUzxVihT6dmA0Im
        HWXu7ealUPkeGFU3+sldiQv3/0g6jTh3KABBjJlZIeYoLqyhxWPnq/8OGfr6XPON
        8eUYoBLo6zwW1kir/ThusZaCesrcoh2UvtumvlNGkNmhwGBNpTzH4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CE8D3151D8E;
        Fri, 23 Sep 2022 13:25:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3FF91151D8D;
        Fri, 23 Sep 2022 13:25:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, me@ttaylorr.com,
        chakrabortyabhradeep79@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] pack-bitmap: remove trace2 region from hot path
References: <pull.1365.git.1663938034607.gitgitgadget@gmail.com>
        <xmqqpmfmuilk.fsf@gitster.g>
Date:   Fri, 23 Sep 2022 10:25:52 -0700
In-Reply-To: <xmqqpmfmuilk.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        23 Sep 2022 10:05:27 -0700")
Message-ID: <xmqqedw2uhnj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C6956CDA-3B64-11ED-8524-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>
>> -		trace2_region_enter("pack-bitmap", "reading_lookup_table", the_repository);
>>  		/* NEEDSWORK: cache misses aren't recorded */
>>  		bitmap = lazy_bitmap_for_commit(bitmap_git, commit);
>> -		trace2_region_leave("pack-bitmap", "reading_lookup_table", the_repository);
>>  		if (!bitmap)
>>  			return NULL;
>>  		return lookup_stored_bitmap(bitmap);
>
> As "git blame" is bad in finding a piece of code that no longer
> exists, it may make sense to leave a comment around here why we do
> not have a trace2 region around this call, perhaps?
>
> +	/* do not add trace2_region around here in the hot path */
> 	bitmap = lazy_bitmap_for_commit(...);
>
> or something?
>
> Thanks.

Also, we'd need to disable t5310.150 that expects to see
reading_lookup_table label in the trace.

