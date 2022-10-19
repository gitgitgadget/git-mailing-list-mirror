Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A0DC433FE
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 16:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiJSQQW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Oct 2022 12:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiJSQQV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2022 12:16:21 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24F94BA48
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 09:16:18 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 863D313CEC4;
        Wed, 19 Oct 2022 12:16:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kEaUpw4ZZ142nTW7/5oN4l8wqy34Ko38zTTN6g
        HELtU=; b=uWbi1gVJP++inMr9Sy5oqWZQ5d58jTvbA3NaTgt0SLfG+vlvjj8wuT
        1GoaUqvCTb+HxZdHAcOpWAPNZezcT/neXz3PHqSjMZ2n9wXiDoTVwRpqwVDog/Lz
        pLiV2/tLJoTl/u9e3GwxmcI2hz0sWpyCJgsL+dnndDp7nToJ3gf9I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7968C13CEC3;
        Wed, 19 Oct 2022 12:16:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D7DF013CEC2;
        Wed, 19 Oct 2022 12:16:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heather Lapointe <alpha@alphaservcomputing.solutions>
Cc:     Heather Lapointe via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 0/9] archive: Add --recurse-submodules to git-archive
 command
References: <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
        <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com>
        <xmqqo7u9t1zf.fsf@gitster.g>
        <CAFwvh9BwV=NEtF_gsh9Tr8gHz02=78m4MCBQbuXk5SzKCAm4RA@mail.gmail.com>
Date:   Wed, 19 Oct 2022 09:16:15 -0700
In-Reply-To: <CAFwvh9BwV=NEtF_gsh9Tr8gHz02=78m4MCBQbuXk5SzKCAm4RA@mail.gmail.com>
        (Heather Lapointe's message of "Tue, 18 Oct 2022 14:48:22 -0400")
Message-ID: <xmqqy1tbssa8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C0273F8-4FC9-11ED-A64C-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heather Lapointe <alpha@alphaservcomputing.solutions> writes:

> Thanks for taking a look.
>
> On Tue, Oct 18, 2022 at 2:34 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Today I was scheduled to be offline, so I won't dig further on the
>> issues this topic has now, but the new tests this series introduces,
>> namely t1023 and t5005, both relies on being able to clone a nested
>> submodule via file:// transport, which no longer is allowed.
>
> I was following the patterns of t/lib-submodule-update.sh. Are there
> better examples
> that I can follow?

Mimic what Taylor did to adjust to the new world order that was
introduced in the 2.38.1 update.

Look at 9c32cfb4 (Sync with v2.38.1, 2022-10-17), which merges
2.38.1 and updates the tests to adjust to the new world order, by
comparing the t/ directory of its first parent and the result of the
merge.  It shows what Taylor did to adjust the tests to adjust.

    $ git diff 9c32cfb4^ 9c32cfb4 t/

I personally doubt it is generally a good idea, as it sets a bad
pattern that tempts unsuspecting users to blindly copy and paste it
to their $HOME/.gitconfig without realizing what its ramifications
are, but the easiest workaround may be to mimic what was done in
t/lib-submodule-update.sh that sets protocol.file.allow
configuration knob globally.
