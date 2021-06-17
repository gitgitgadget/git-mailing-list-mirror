Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81DCC48BE5
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 00:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A80D36023F
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 00:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbhFQAis (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 20:38:48 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55450 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbhFQAir (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 20:38:47 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8A3E712C106;
        Wed, 16 Jun 2021 20:36:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5rm+uprPULUs
        VNj3v0tXEJrl8pgL2VSsm1O1Mnu4vps=; b=ITwTk4hh23eirBAc+wfMS5CY++2M
        seXpSzfI4ZI+lRSOdFpAQW6EYtaO/NKbH0L2pJ3ocdlZ7C0zjwysakg5MhJxkL8j
        4vj2eaS6S1TZMuOCvzoGcMvuw8kzaKCW2ZFM5xovoBBbka4IwaGZKXbRvwuNscdd
        adLY9idOrUrZOuo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 823E412C105;
        Wed, 16 Jun 2021 20:36:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CF04512C102;
        Wed, 16 Jun 2021 20:36:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH] test-lib: fix "$remove_trash" regression and
 match_pattern_list() bugs
References: <xmqqa6nqsd2i.fsf@gitster.g>
        <patch-1.1-436c723f4f8-20210616T082030Z-avarab@gmail.com>
        <YMm4F2uKZ4Dv3C4p@coredump.intra.peff.net>
        <87pmwmxd6f.fsf@evledraar.gmail.com>
Date:   Thu, 17 Jun 2021 09:36:36 +0900
In-Reply-To: <87pmwmxd6f.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 16 Jun 2021 11:49:20 +0200")
Message-ID: <xmqqh7hxnx7v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 137BFB96-CF04-11EB-8803-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> Whatever the expansion mechanism, I do think it's worth having callers
>> quote "$GIT_SKIP_TESTS" and then performing the expansion within
>> match_pattern_list. Then the nasty mechanics are all in that one place=
.
>
> I think it's rather clean to not quote it, i.e. to have the loop get a
> list of item and then things to match, it would also make it easier to
> e.g. port it to a native C program.

Sorry, I am not sure how it can work without quoting $GIT_SKIP_TESTS
and exposing the details of how we disable globbing when the caller
calls match_pattern_list.

A list of item in $GIT_SKIP_TESTS would not be able to pass t?000 in
it intact to the loop that processes each of the item on the list.

	for pattern in $GIT_SKIP_TESTS
	do
		attempt to match with $pattern
	done

will see t5000 in $pattern due to globbing.  It's not like "$@"
trick can be applied to any plain variable.
