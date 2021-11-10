Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDD5C433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 19:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77B686113E
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 19:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhKJTur (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 14:50:47 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56958 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhKJTuq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 14:50:46 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 781AF10055F;
        Wed, 10 Nov 2021 14:47:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9Ez6erSxyZuDWFpaQqkyb3ktuIwu2H5RLR1fpr
        MbH34=; b=oWo7D99G7l9RXQDDDa02O5aEC2x8YXBm/2dK9Q2dCIL15kx6v0p7Rp
        Gj0HhaVepUrjqXwiqR5Eb4c/5qjgP+Tu+FZi6aDo2MeYpCz4KAY0yvtl6ryHKyAr
        x2ITbRJ95RoKAfNLzty790sFbL9MF7FQWWY6AOMkwOL3VvTEKUMYU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E5EF10055E;
        Wed, 10 Nov 2021 14:47:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D1E4F10055D;
        Wed, 10 Nov 2021 14:47:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, lenaic@lhuard.fr,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] maintenance: disable cron on macOS
References: <pull.1075.git.1636569360002.gitgitgadget@gmail.com>
Date:   Wed, 10 Nov 2021 11:47:56 -0800
In-Reply-To: <pull.1075.git.1636569360002.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Wed, 10 Nov 2021 18:35:59
        +0000")
Message-ID: <xmqqh7cjyeqb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1AB109F0-425F-11EC-90B0-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     This one is really tricky because we can't notice anything is wrong
>     without running git maintenance start or git maintenance stop
>     interactively on macOS. The tests pass just fine because the UI alert
>     gets automatically ignored during the test suite.
>     
>     This is a bit of a half-fix: it avoids the UI alert, but has a corner
>     case of not un-doing the cron schedule if a user manages to select it
>     (under suitable permissions such that it succeeds). For the purpose of
>     the timing of the release, I think this is an appropriate hedge.

Reverting the "git maintainance run --scheduler=<scheduler>" topic
altogether to give us time to stop and think may be another obvious
option, but it probably is OK to tell macOS users that they may have
cron but Git won't work with their cron with this patch.

In any case, let's leave it (slightly) broken for macOS folks by
applying this quickfix.

Thanks.


PS.

I was puzzled by the lack of a call to validate_scheduler() at the
very beginning of resolve_scheduler(), by the way.  Or even earlier
during the verification of the command line options.  I wonder if
on macOS, --scheduler=nosuch and --scheduler=cron should behave the
same way, both saying "unrecognized", instead of saying that only to
the former and "not available" to the latter.
