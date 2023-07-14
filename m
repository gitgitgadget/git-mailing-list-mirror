Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66677EB64DC
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 21:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbjGNVG0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 17:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbjGNVGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 17:06:25 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0363A99
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 14:06:20 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 21F931A06C;
        Fri, 14 Jul 2023 17:06:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cnqOn12cQi83T4PTYC7j0HxkztlYQIExjol+vU
        Z2SzI=; b=mOIVoijapTmIPW59O93lvsXvqBYYW5mQAVlyHkLxWkvxNH5VipZEj6
        PKBKCTyhQDu5W1NP85ybEeTe5v+SzDMYjh8lrCjvvBMjj9KhQi01beDi9pbYJbkI
        tLzEGTRCrfPFqkzfiaNbhLBBw8kiZkfvfAVkRPqkOo4qgfAfYPBa4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1A2A91A06B;
        Fri, 14 Jul 2023 17:06:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AB3351A06A;
        Fri, 14 Jul 2023 17:06:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        "D. Ben Knoble" <ben.knoble@gmail.com>, Git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: t2400 on freebsd12
References: <CALnO6CDryTsguLshcQxx97ZxyY42Twu2hC2y1bLOsS-9zbqXMA@mail.gmail.com>
        <CALnO6CCc-J+fe9qKaoyYUMM3xMEUnV5w7NKWSbn6xTgEjbac5w@mail.gmail.com>
        <xmqqfs5ro8v7.fsf@gitster.g>
        <356tacvizwbtwigdkz4byrrzsyjuktcb7cxaibf6wjocffgycp@iwhmszuuvzpl>
        <CAPig+cRMXJkrEgyVtC0u2QK=5QNnJOQnXBU_rE+JiGufEYH9sg@mail.gmail.com>
Date:   Fri, 14 Jul 2023 14:06:15 -0700
In-Reply-To: <CAPig+cRMXJkrEgyVtC0u2QK=5QNnJOQnXBU_rE+JiGufEYH9sg@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 14 Jul 2023 12:19:41 -0400")
Message-ID: <xmqq8rbinqyg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 45D03B62-228A-11EE-B222-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> I haven't been following this thread closely, but I wonder if the
> `grep` introduced by patch [3/8] of the cited patch series is
> problematic:
>
>     grep -E "fatal:( options)? .* cannot be used together" actual
>
> since BSD lineage regexp (including macOS) historically did not
> support the "?" repetition operator. Perhaps an easy fix would be to
> simplify this to:
>
>     grep "cannot be used together" actual

We do not seem to get the same breakage on macOS CI runs (otherwise
this would have been caught much earlier).  We do have many "grep
-E" invocations to ask for ERE but not many of them uses zero-or-one
'?'  in our test suite.  But I would be somewhat surprised if
test_dir_is_empty is broken on FreeBSD and nobody has noticed it for
this long.

I got an impression from the discussion so far that this breakage is
flaky and not always reproducible.  I wonder if "stress" thing helps
the chance to reproduce for those with FreeBSD boxes?

   $ cd t && sh ./t2400-* --stress

Thanks.
