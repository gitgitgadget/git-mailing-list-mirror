Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AF5C25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 19:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241298AbiHQTS3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 15:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240952AbiHQTSY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 15:18:24 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AA5DAE
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 12:18:22 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AB67012DB96;
        Wed, 17 Aug 2022 15:18:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iHbCevJQ/XE1FNFdtCKj0tLjQb0XyIyC7vW5IE
        QGJk0=; b=DYW4pr7DNr7whPcwj8E4WX11rrEoV5vEm4lbkeAYnqtL5f1/yxHOv3
        7r1cMRdKP+Vk+3cUf9cR2rsp0OMK3wSQQwZZiWajeoK2ee21eX0g7FhQitUvrken
        w5LYZUim8CR77SjSf7WIOALmXkPzxjGSrptmN9akqL6W1IpmG1qqE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A3AB812DB95;
        Wed, 17 Aug 2022 15:18:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1DA1712DB94;
        Wed, 17 Aug 2022 15:18:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v8 08/14] merge-resolve: rewrite in C
References: <20210317204939.17890-1-alban.gruin@gmail.com>
        <20220809185429.20098-1-alban.gruin@gmail.com>
        <20220809185429.20098-9-alban.gruin@gmail.com>
        <08ea1eec-58fb-cbfa-d405-0d4159c99515@gmail.com>
        <xmqqilmzkd7p.fsf@gitster.g>
        <qs23r0n8-9r24-6095-3n9n-9131s69974p1@tzk.qr>
        <xmqqedxgt1zx.fsf@gitster.g>
        <848p4p89-2219-7874-ss50-2o0rp4r02902@tzk.qr>
        <CABPp-BGSFYWvA5HktLf33=w7JB95iDLDNoE0gdA3oUtb+qYoQQ@mail.gmail.com>
Date:   Wed, 17 Aug 2022 12:18:20 -0700
In-Reply-To: <CABPp-BGSFYWvA5HktLf33=w7JB95iDLDNoE0gdA3oUtb+qYoQQ@mail.gmail.com>
        (Elijah Newren's message of "Wed, 17 Aug 2022 12:06:16 -0700")
Message-ID: <xmqq7d36vfur.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B55D4AC-1E61-11ED-B2A7-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> There's also another concern you tried to address in your other email;
> let me quote from that email here:
>
>> If you want to have an easy example of a custom merge strategy, then let's
>> have that easy example. `git-merge-resolve.sh` ain't that example.
>>
>> It would be a different matter if you had commented about
>> `git-merge-ours.sh`:
>> https://github.com/git/git/blob/v2.17.0/contrib/examples/git-merge-ours.sh
>> That _was_ a simple and easy example.
>
> ...and it was _utterly useless_ as an example.  It only checked that
> the user hadn't modified the index since HEAD.  It doesn't demonstrate
> anything about how to merge differing entries, since that merge
> strategy specifically ignores changes made on the other side.  Since
> merging differing entries is the whole point of writing a strategy, I
> see no educational value in that particular script.
>
> `git-merge-resolve.sh` may be an imperfect example, but it's certainly
> far superior to that.
> ...
> If someone makes a better example (which I agree could be done,
> especially if it added lots of comments about what was required and
> why), and ensures we keep useful test coverage (maybe using Junio's
> c-resolve suggestion in another email), then my concerns about
> reimplementing git-merge-resolve.sh in C go away.
>
> If that happens, then I still think it's a useless exercise to do the
> reimplementation -- unless someone can provide evidence of `-s
> resolve` being in use -- but it's not a harmful exercise and wouldn't
> concern me.
>
> If the better example and mechanism to retain good test coverage
> aren't provided, then I worry that reimplementing is a bunch of work
> for an at best theoretical benefit, coupled with a double whammy
> practical regression.

Ah, you said many things I wanted to say already.  Thanks.
