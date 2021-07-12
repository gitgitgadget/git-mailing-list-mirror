Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A916C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 20:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7778161245
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 20:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbhGLUl0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 16:41:26 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52560 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbhGLUl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 16:41:26 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 48A6E139E38;
        Mon, 12 Jul 2021 16:38:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=e/mENWJq/cXuItkbMh1VKeHLp3HAjcfqRBzt9G
        g/prc=; b=v1pJDxtS6myRx9L0eJglfHox0+cRRN+HT44w2hIjaKKA4Sag0cBYJZ
        bnTAx9LmTRrK34iIwpyPRJFY8uZDxhqRDHcpI7UK7Up8xAPGZRxY0xxpCQWqvkYu
        04/1mkQj0d6ckLPmg9jxociZFrT1N9XaLYv3HsoQSxJx6+2vjJfVE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3F5A9139E37;
        Mon, 12 Jul 2021 16:38:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B1B33139E36;
        Mon, 12 Jul 2021 16:38:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 14/19] [GSOC] cat-file: reuse ref-filter logic
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
        <70e83e4ba3cc8a55bb8d90cb2c581cd04ac116d4.1626090419.git.gitgitgadget@gmail.com>
        <CAP8UFD0vHw8cK90RbOUcrAcxNKiHVTMX0VEiK8+MNyHH0CNm4A@mail.gmail.com>
Date:   Mon, 12 Jul 2021 13:38:31 -0700
In-Reply-To: <CAP8UFD0vHw8cK90RbOUcrAcxNKiHVTMX0VEiK8+MNyHH0CNm4A@mail.gmail.com>
        (Christian Couder's message of "Mon, 12 Jul 2021 15:17:33 +0200")
Message-ID: <xmqqtukz2rp4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2039D0EA-E351-11EB-A6A4-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>> The performance for `git cat-file --batch-all-objects --batch
>> >/dev/null` on the Git repository itself with performance testing
>> tool `time` change from "27.37s user 0.29s system 98% cpu 28.089
>> total" to "33.69s user 1.54s system 87% cpu 40.258 total".
>
> Saying that a later patch will add a fast path which will mitigate the
> performance regression introduced by this patch might help reassure
> reviewers.

More importantly, why is such a fast-path even needed?  Isn't it a
sign that the ref-filter implementation is eating more cycles than
it should for given set of placeholders?  Do we know where the extra
cycles goes?

I find it somewhat alarming if we are talking about "fast-path"
workaround before understanding why we are seeing slowdown in the
first place.
