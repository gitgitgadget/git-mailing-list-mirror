Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE93C433E0
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 23:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7422B206D8
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 23:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgLVXXE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 18:23:04 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51109 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgLVXXE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 18:23:04 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3AEE4103AE8;
        Tue, 22 Dec 2020 18:22:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3zv6WZOsg3+0C2DwczfqwGUyc2g=; b=BV+amJ
        tYOMnx3ke89jLCGCiWkFqx2B4ZDWOKXM4mWX7VIX6g2AiAYvt345HUqnQ58nkci8
        ph9YtRWvv/gvvbUlVmm7GhC/GYgYlHhgYt25lggbayGzioUqsmyd0zQeopBY8Mwp
        2Lc8uvcrsjZyU8SrxCrZjZb7kyvkqn8XbM4OI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=b+5lpBYZxgvyOxF6OEO3i/w6wfAcMb2w
        89cIN/FILmZsgUcufrNJCaN2AT2CBHibZnkikyWtLPcC1VuvigDRHdzvuNaU5U9D
        XcXBm2/NmqalitkUk1BOpzMgKgfdXa5T06ErCpbjZftXIhasyr0ZOxQqjN+z00NF
        EKob0GFBFn4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 33B2E103AE7;
        Tue, 22 Dec 2020 18:22:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 57BA5103AE4;
        Tue, 22 Dec 2020 18:22:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] gc: fix handling of crontab magic markers
References: <cover.1608585497.git.martin.agren@gmail.com>
        <689d3150e9822eeccac0e1d07c2ba26dac47b4c9.1608585497.git.martin.agren@gmail.com>
        <xmqqsg7xfoj9.fsf@gitster.c.googlers.com>
Date:   Tue, 22 Dec 2020 15:22:17 -0800
In-Reply-To: <xmqqsg7xfoj9.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 22 Dec 2020 14:45:30 -0800")
Message-ID: <xmqqo8ilfmty.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 895085EA-44AC-11EB-857B-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +test_expect_success 'stop preserves surrounding schedule' '
>> +	echo "Crucial information!" >>cron.txt &&
>> +	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance stop &&
>
> 31345d55 (maintenance: extract platform-specific scheduling,
> 2020-11-24) in ds/maintenance-part-4 needs to adjust this
> exported variable for the tests to pass in 'seen'
>
> Is it just the matter of replacing it with
>
> 	GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab ..."
>
> or is there more to it?

We'll see soon enough; I noticed the above while viewing

    https://github.com/git/git/runs/1597371646#step:6:2093

and since then I pushed another round of 'seen' with a non-textual
conflict resolution while merging the ds/maintenance-part-4 topic
in.

