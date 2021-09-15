Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123DCC433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 20:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E49F46105A
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 20:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhIOUKB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 16:10:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64960 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbhIOUKA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 16:10:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 25544E72AE;
        Wed, 15 Sep 2021 16:08:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ccHDeEdXBbWpXUXgHixw+mQ7tYa8aXWgrU60Fp
        3aof8=; b=q9lT8vwFRwlkGqCrwl5vHkkaADj0xqiFfMkxthwgfptAs9bA1EEA32
        nGzzBuxqw5JT1iwsvPoiI3ZVKU5tq+UOA4RX348olg0eWGNFaFBfV2MqHOScLf4t
        ibzK4CcwoyJpIjjg7cP4YtjbHVUx78EkGiESwoHAYwOdkBrmG0y9M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B6FBE72AC;
        Wed, 15 Sep 2021 16:08:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 85703E72AB;
        Wed, 15 Sep 2021 16:08:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH] t1400: avoid SIGPIPE race condition on fifo
References: <1e9e62a2c5f74db91aaded83783076c28b757836.1630659922.git.ps@pks.im>
        <YUIptJNN5DxrkydV@coredump.intra.peff.net>
        <YUIsZCTqm56KfilP@coredump.intra.peff.net>
Date:   Wed, 15 Sep 2021 13:08:39 -0700
In-Reply-To: <YUIsZCTqm56KfilP@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 15 Sep 2021 13:24:52 -0400")
Message-ID: <xmqqee9pwqig.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8424524-1660-11EC-B903-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Sep 15, 2021 at 01:13:25PM -0400, Jeff King wrote:
>
>> I think this test may be racy. I saw a strange failure from it in CI:
>> 
>>   https://github.com/peff/git/runs/3605506649?check_suite_focus=true#step:5:6734
>> 
>> I can't reproduce the problem locally with "--stress", but the failure
>> there is on macOS (and likewise, a nearby run failed with a timeout just
>> for macOS, which could be caused by a racy deadlock).
>
> Ah, I just wasn't trying hard enough. Using --run=1,190 lets it run a
> lot more tightly, and I got a failure pretty quickly. Here's the fix (on
> top of ps/update-ref-batch-flush).
>
> -- >8 --
> Subject: [PATCH] t1400: avoid SIGPIPE race condition on fifo
>
> t1400.190 sometimes fails or even hangs because of the way it uses
> fifos. Our goal is to interactively read and write lines from
> update-ref, so we have two fifos, in and out. We open a descriptor
> connected to "in" and redirect output to that, so that update-ref does
> not see EOF as it would if we opened and closed it for each "echo" call.

Thanks.  I think I see the same breakage in last night's pushout of
'seen'.

Will queue.
