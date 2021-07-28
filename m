Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D2BC4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 01:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57F2B60F9E
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 01:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbhG1BIR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 21:08:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61691 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbhG1BIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 21:08:16 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 445B7DD2F4;
        Tue, 27 Jul 2021 21:08:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1rQHwCgxoBuj6nIC4HVSFZRGOpw3lB1YfN1jCr
        07Yng=; b=qIbPvt/ilpXdPtfZU6iIg7qpXg6X8bGYQroAwshn7YiPT/MjUTsPuu
        bI0VOk7I0fii+WFLj6yTnn6X6ER4HFf4kigJFhkJniYSqJ29nqFIn/asLZvtJVx0
        ETT/E0pnJw1aIMvGpv8VsvL7b28PdZAD+rZe559UcumScygJXGjRY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 37713DD2F3;
        Tue, 27 Jul 2021 21:08:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9A1F7DD2F2;
        Tue, 27 Jul 2021 21:08:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     "lilinchao@oschina.cn" <lilinchao@oschina.cn>,
        git <git@vger.kernel.org>
Subject: Re: git apply --3way behaves abnormally when the patch contains
 binary changes.
References: <fdfd283aeee311ebbfb50024e87935e7@oschina.cn>
        <CAMKO5Cs1HP7JNmJLYKti0kajGmD4XK+Boc3WRV2Dpph5a3b5Xw@mail.gmail.com>
Date:   Tue, 27 Jul 2021 18:08:13 -0700
In-Reply-To: <CAMKO5Cs1HP7JNmJLYKti0kajGmD4XK+Boc3WRV2Dpph5a3b5Xw@mail.gmail.com>
        (Jerry Zhang's message of "Tue, 27 Jul 2021 15:44:08 -0700")
Message-ID: <xmqqv94vb5z6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48FDDD64-EF40-11EB-BF40-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerry Zhang <jerry@skydio.com> writes:

>>         # 2. based on left_bin branch, make any change, and commit
>>         git checkout -b right &&
>>         cat bin.png bin.png > bin.png &&
>>         git add bin.png &&
>>         git commit -m "update binary file" &&
>>
>>         # 3. make patch
>>         git diff --binary left..right >bin.diff &&
>>         # apply --3way, and it will fail
>>         test_must_fail git apply --index --3way bin.diff
>> '
>> "
>>
>> But  "git apply --index --3way bin.diff" will not faill on Git version 2.31.0.
> Are you sure? I checked out to "commit
> a5828ae6b52137b913b978e16cd2334482eb4c1f (HEAD, tag: v2.31.0)" and
> rebuilt and ran your test snippet and it still failed.

Isn't it just because the reproduction recipe is simply wrong?

It says

    * be on left branch and have a binary file
    * be on right branch and have a modified binary file
    * create a patch to take left to right

Notice that we have a patch and we are still on the right branch.
Of course, applying the patch to take us from left to right would
fail from that state, but I _think_ the intent of the reproduction
recipe was, after all of the above, do this here:

    * switch to left branch and attempt to apply the patch.

And the patch is meant to take us from left to right, and we are on
pristine left, the application ought to cleanly succeed, no?

"git apply bin.diff" would probably work correctly but I do not know
offhand what the code after your change does with --3way enabled.

We refuse to merge binary files, so I would not be surprised if we
failed the 3way in this case (even though we _could_ fast-forward,
it may not be worth complicating the --3way logic---nobody sane
would say --3way when it is unnecessary) but after 3way fails, do we
still correctly fall back to "straight application" like we do for
text patches with your change?  Before your change, we would have
first attempted the "straight application", which would succeed and
wouldn't have hit "3way will refuse to merge binaries" at all.

So, I do not think it is implausible that we are seeing a legit
regression report.

Thanks.
