Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44C6C43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 21:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242778AbiFCVF4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 17:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiFCVFz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 17:05:55 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860D92497A
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 14:05:54 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0C6BB187BBF;
        Fri,  3 Jun 2022 17:05:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fvwJynGjnm0iMEhRYG4Lghxh9vNfwEoaCYE236
        KJYHU=; b=YIzXVx+QkJclkNGg4hVRzSq7a35PrJ251WHcz/2zU4gfEXSTKmSGgX
        2aeOPx8wleLqy7BuXR6NWU/95E+WRGZf3Naz6uulDw8c4Y/fS96JaUHy74QKirWS
        x/5I5DyjpVp+ULyrv6J34ROqNsJCQ5HZDKD2iVnmnBUzFSNSmxkno=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 03F84187BBD;
        Fri,  3 Jun 2022 17:05:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A5834187BBB;
        Fri,  3 Jun 2022 17:05:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>, John Cai <johncai86@gmail.com>
Subject: Re: [RFC PATCH 1/3] test-tool: don't fake up BUG() exits as code 99
References: <RFC-cover-0.3-00000000000-20220525T234908Z-avarab@gmail.com>
        <RFC-patch-1.3-78431bdc8f0-20220525T234908Z-avarab@gmail.com>
        <xmqqv8theehf.fsf@gitster.g>
Date:   Fri, 03 Jun 2022 14:05:49 -0700
In-Reply-To: <xmqqv8theehf.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        03 Jun 2022 12:25:32 -0700")
Message-ID: <xmqqczfpe9ua.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2971D60-E380-11EC-BE16-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> However, in doing so we've been fooling ourselves when it comes to
>> what trace2 events we log. The events tested for in
>> 0a9dde4a04c (usage: trace2 BUG() invocations, 2021-02-05) are not the
>> real ones, but those that we emit only from the "test-tool".
>
> I can fully agree with the above reasoning, i.e. let's test what we
> do use in production, instead of something nobody uses for real, if
> we were adding a test for BUG() in vacuum, but why did we have to
> "fake" it in the first place?
> ...
> Are we sure that the reason no longer applies?  How do we know?  We
> would want to explain that to future developers in the proposed log
> message, I would think.

We can flip it the other way around.  

I do not think I ever saw anybody asked anybody on this list who got
a BUG() message to use the coredump to do something useful.  Don't
modern distros ship with "ulimit -c 0" these days?

It might be possible that a better direction is to introduce
GIT_ABORT_ON_BUG environment or core.abortOnBUG configuration that
chooses between abort() and exit(99), or something like that, and
then we switch to use the latter by default over time?
