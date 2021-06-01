Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CCAC47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 21:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3EBF613B9
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 21:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbhFAVVw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 17:21:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51456 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbhFAVVv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 17:21:51 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D9A84C7522;
        Tue,  1 Jun 2021 17:20:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=XZqRAHGGc3fk
        C9cc5p2BhaJ31ERGmMblOZZ+Tiugwfc=; b=WE4TbanxlTaqAL91gqEF5Z8Oieeu
        QlhZdFwahpxkbsj0Jnbppn/7EiaDmXGIfgJoS+xHU0YxsY/HGZPxtzepJhhJ602L
        TgpVVw1cT/h7qfAnVyiIchJyQ961+NosBRpHH7XubJJ4u+ZRhv2ZDSYoFDbSuslZ
        FapPzhH9XFVij30=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B2EF0C7520;
        Tue,  1 Jun 2021 17:20:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F283FC751F;
        Tue,  1 Jun 2021 17:20:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, David Coppa <dcoppa@openbsd.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] t0001: fix broken not-quite getcwd(3) test in bed67874e2
References: <cde6c1a5-3dfc-9710-bab9-b847a5dd960b@web.de>
        <patch-1.1-c70791bbd3-20210601T003743Z-avarab@gmail.com>
        <b650bef5-d739-d98d-e9f1-fa292b6ce982@web.de>
Date:   Wed, 02 Jun 2021 06:20:06 +0900
In-Reply-To: <b650bef5-d739-d98d-e9f1-fa292b6ce982@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 1 Jun 2021 18:15:39 +0200")
Message-ID: <xmqq4kehs2nt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 23FE3F2E-C31F-11EB-A847-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> On AIX under both bash and ksh this test breaks because "pwd -P" will
>> happily display the current working directory, but getcwd(3) called by
>> the "git init" we're testing here will fail to get it.
>>
>> I checked whether clobbering the $PWD environment variable would
>> affect it, and it didn't. Presumably these shells keep track of their
>> working directory internally.
>>
>> Let's change the test to a new "test-tool getcwd".
>
> Makes sense.
>
> If /bin/pwd can figure out the path to the current working directory
> without read permissions to parent directories then it might be possibl=
e
> to teach strbuf_getcwd() the same trick, though.  How does it do it?
> ...
> If strbuf_getcwd() were to learn any of these tricks, then so would
> "test-tool getcwd", via its xgetcwd() call.  At that point we'd better
> rename GETCWD_IGNORES_PERMS to XGETCWD_IGNORES_PERMS.
>
> But I guess we need none of that because we never got a request from
> an AIX user to support a /home directory without read permissions,
> right?

Nice "thinking aloud".
