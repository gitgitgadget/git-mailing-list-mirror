Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B3BC4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A86D72388C
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbgLHWSV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 17:18:21 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54807 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729323AbgLHWSU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 17:18:20 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A3A95108A6D;
        Tue,  8 Dec 2020 17:17:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aE9v5QYkE2R1gEiESj3JtY+IUDo=; b=M91OK2
        qKN+m0eZobSu0X1/T+eS7jmO6//aq9ICyYXkgBwM3uB6kf/yUW27mH2vnQ7lGUyE
        4aVc+22jky5z7XWFAYGA3NaHA5ImtL1vnJhUm7u1McZZr5B2S3oeMSffESib3dRd
        +GaUXdqlsKlHR2LzkMd8WGKZpY03CkWqu4pP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nBvJtRmYTr+2QOmiMxnFKfQZOJO5Q+Bn
        ZJ4rf4usVXeotenww/cycDANQ/Om3Gp2yNDnJxVekCRLb30MMOXF9MItpzCVk2kf
        hs3hZhVzeatvb0UnOIyDXVJMd7adkP34hs8OFfenmTPFknWnBAVHQ3C5J+H4SJrf
        MbSylbN0qVw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9BE44108A6C;
        Tue,  8 Dec 2020 17:17:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EA967108A6B;
        Tue,  8 Dec 2020 17:17:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v2 1/1] maintenance: fix SEGFAULT when no repository
References: <20201124164405.29327-1-rafaeloliveira.cs@gmail.com>
        <20201126204141.1438-1-rafaeloliveira.cs@gmail.com>
        <20201126204141.1438-2-rafaeloliveira.cs@gmail.com>
        <20201208201256.GK36751@google.com>
        <xmqqsg8g559i.fsf@gitster.c.googlers.com>
Date:   Tue, 08 Dec 2020 14:17:32 -0800
In-Reply-To: <xmqqsg8g559i.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 08 Dec 2020 13:58:49 -0800")
Message-ID: <xmqqh7ow54eb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2BA6C166-39A3-11EB-A8A5-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Josh Steadmon <steadmon@google.com> writes:
>
>> Caught a typo here, sending this as a squash patch since it's already in
>> next:
>
> The breakage and the fix looks obvious to me, but...
>
> How did CI allow 'next' to pass with such a typo, I wonder?
> Moreover, my pre-push tests of all the integration branches
> I didn't notice this to fail, but I cannot see how it could
> have been succeeded.  Puzzled...

That is because of this:

    $ (sh t7900-maintenance.sh 2>&1; echo $?) | tail -5
    ok 25 - register preserves existing strategy
    t7900-maintenance.sh: line 444: test_execpt_success: command not found
    # passed all 25 test(s)
    1..25
    0

The story is the same with prove.

    $ prove t7900-maintenance-sh
    t7900-maintenance.sh .. 24/? t7900-maintenance.sh: line 444: test_execpt_success: command not found
    t7900-maintenance.sh .. ok
    All tests successful.
    Files=1, Tests=25,  2 wallclock secs ( 0.02 usr  0.01 sys +  0.97 cusr  0.97 csys =  1.97 CPU)
    Result: PASS

Since this typo appeared immediately before test_done, we _could_
improve test_done to pay attention to $? when it starts (and in a
similar fashion, we _could_ also check $? at the beginning of the
test_expect_* for the previous step), but I do not think that is a
good approach that would scale well.  There are legitimate reasons
we have to write things other than test_expect_* at the top level
of the script (e.g. test helper function may have to be defined to
be shared amongst the test pieces in the same script).

I wonder if it is a good direction to go to run the tests with the
"set -e" option on, and accept its peculiarities.
