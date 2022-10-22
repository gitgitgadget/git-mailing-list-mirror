Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C480CC433FE
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 17:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJVRAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Oct 2022 13:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJVRAr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2022 13:00:47 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCAB1CB2D
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 10:00:41 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9E7FB1C5DE1;
        Sat, 22 Oct 2022 13:00:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kMAZ9Zb5wA3bupdIJgNixhZ0EeIbKevLmKbYiE
        VPKBY=; b=OCvfX766J01rUFOB0ipKuiiEiKDGb3QUH+n/x+Y/x1zSNma75GBZoH
        BADnCtH0FWauVewMzcT8IbhTj74UeOBqW8c9GY/aE17WXu3X3/Kjn/Ho0g6U39hs
        qfNcm/K/mvrFlLBX0DakyyRdtc+3FWd4EZZqzX23BRp4Nt/JtZ5R8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 953981C5DDF;
        Sat, 22 Oct 2022 13:00:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9D1E81C5DDD;
        Sat, 22 Oct 2022 13:00:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        James Ramsay <james@jramsay.com.au>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH] pack-objects: introduce --exclude-delta=<pattern> option
References: <pull.1392.git.1666453564661.gitgitgadget@gmail.com>
Date:   Sat, 22 Oct 2022 10:00:36 -0700
In-Reply-To: <pull.1392.git.1666453564661.gitgitgadget@gmail.com> (ZheNing Hu
        via GitGitGadget's message of "Sat, 22 Oct 2022 15:46:04 +0000")
Message-ID: <xmqqr0yzhjyj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D2F1AE2-522B-11ED-B0D4-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> The server uses delta compression during git clone to reduce
> the amount of data transferred over the network, but delta
> compression for large binary blobs often does not reduce
> storage size significantly and wastes a lot of CPU. Git now
> disables delta compression for objects that meet these conditions:
>
> 1. files that have -delta set in .gitattributes
> 2. files that its size exceed the big_file_threshold
>
> However, in 1, .gitattributes needs to be set manually by the user,
> and in most cases the user does not actively set it, and it is not
> something that can be actively adjusted on the server aside. In 2,
> the big_file_threshold now defaults to 512MB, and many binary files
> smaller than that will be uselessly delta-compressed, and this is
> made worse if the server actively increases the big_file_threshold.

Who are you trying to help, though?  The user has to somehow
manually cause the --exclude-delta=<pattern> to be added at the
server side, so I do not see the new feature as correcting the
weakness you perceive in the approach to mark the undeltifiable
blobs in the attributes system at all.  Does this feature assume
that the server operator knows better than the project that can
maintain their own .gitattributes in tree?  If so, the server
operator can already use <bare-repository>/info/attributes file
to achieve that already, no?

Now hosting sites may not give hosted projects flexibility to
configure their own server side repositories, like its "config"
and "info/attributes", but that limitation would equally apply
what command line options pack-objects runs with.

So, again, it is not clear who this patch is trying to help and how.
If we assume that the hosting operators can give project owners more
control of how the server side is configured, then we can do that
already without a new option, no?

IOW

> Therefore, we need a way to be able to actively skip the delta
> compression of some files on the server.

I do not quite follow the "Therefore" here.

