Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AC6C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DD02611CD
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbhGLRLD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 13:11:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51937 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbhGLRLD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 13:11:03 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E2D3CB3A6;
        Mon, 12 Jul 2021 13:08:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qvVJeELYICcyu5Z6etgTOxD1+plrpT4D6WrBq/
        RX4gA=; b=dL6kCHzx0OITrVxFeRRvol1U+Xjwm28vknnKq0Sk6wFYktp3H9Qm+S
        viDzdasxS2jRIhsjwjcijQSwf61f71ksazvrs8pyJsFrHNWoXj9Ga0cxDsLhBCQq
        Lvx9W34ZHnVCs3tRMtxil0Fw/bV6VkzwMtDOXKJPhSDJ7+44/3dwI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 26DB9CB3A4;
        Mon, 12 Jul 2021 13:08:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B24CACB3A2;
        Mon, 12 Jul 2021 13:08:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        avarab@gmail.com, felipe.contreras@gmail.com, newren@gmail.com
Subject: Re: [PATCH] pull: abort if --ff-only is given and fast-forwarding
 is impossible
References: <20210711012604.947321-1-alexhenrie24@gmail.com>
        <00e246b1-c712-e6a5-5c27-89127d796098@gmail.com>
Date:   Mon, 12 Jul 2021 10:08:12 -0700
In-Reply-To: <00e246b1-c712-e6a5-5c27-89127d796098@gmail.com> (Phillip Wood's
        message of "Mon, 12 Jul 2021 11:21:04 +0100")
Message-ID: <xmqqpmvn5ukj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE1EF4F2-E333-11EB-89B8-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Thanks for revising this patch, I like this approach much better. I do
> however have some concerns about the interaction of pull.ff with the 
> rebase config and command line options. I'd naively expect the
> following behavior (where rebase can fast-forward if possible)
>
>   pull.ff  pull.rebase  commandline  action
>    only     not false                rebase
>    only     not false   --no-rebase  fast-forward only
>     *       not false    --ff-only   fast-forward only
>    only     not false    --ff        merge --ff
>    only     not false    --no-ff     merge --no-ff
>    only       false                  fast-forward only
>    only       false      --rebase    rebase
>    only       false      --ff        merge --ff
>    only       false      --no-ff     merge --no-ff

Do you mean by "not false" something other than "true"?  Are you
trying to capture what should happen when these configuration
options are unspecified as well (and your "not false" is "either set
to true or unspecified")?  I ask because the first row does not make
any sense to me.  It seems to say

    "If pull.ff is set to 'only', pull.rebase is not set to 'false',
    and the command line does not say anything, we will rebase".

I do agree with you that the command line options

    --ff-only
    --ff (aka "allow ff")
    --no-ff

should override pull.ff and

    --rebase
    --no-rebase (aka "merge")

should override pull.rebase configuration settings and also override
pull.ff set to 'only' (i.e. the user explicitly wants intregration
of the two histories and at that point "I usually just follow along"
which is "pull.ff=only" no longer applies).
