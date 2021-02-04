Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32819C433E6
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 18:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE7E664E27
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 18:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238982AbhBDSNa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 13:13:30 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59199 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238966AbhBDSMo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 13:12:44 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8F56F12240F;
        Thu,  4 Feb 2021 13:12:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ltB8dpKvoXXl
        Yr+Elca44PdhDEk=; b=H0cVT2sTtNJnalUqg4hvNz8xH6T/7gyRkavaclMYg31a
        WBjY95R8+uiw6seIJmN9WdJwWWZod5b8RvtcqxsVKZG4sf9cJCu/LV+rPI8se7YY
        HNwqrQL/3UcYxcDyK22BC61pWOJXNPBFTra0mVgSnwjb2VPXIyq5327+JEZDjsg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=mimpVO
        jkiRL5e135SZ3Lqr63I/d0mbQYKs7U6XzXeYIEMvh6rxCbnFO7k/myQmo+rcTNIl
        Fbt/nhFRZ/RxBbijR8TbqOat2+TCVue/scmH9P5KR1e5hiIRp7uSHsoN0f1tR7M5
        jXv9AcjJ4jmn+tOted2SIRuSss0FZ5YlzfvO4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 87E5512240E;
        Thu,  4 Feb 2021 13:12:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A6FAD12240C;
        Thu,  4 Feb 2021 13:11:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH 21/25] pickaxe: use PCREv2 for -G and -S
References: <20210203032811.14979-1-avarab@gmail.com>
        <20210203032811.14979-22-avarab@gmail.com>
        <87y2g4dgpc.fsf@evledraar.gmail.com>
Date:   Thu, 04 Feb 2021 10:11:56 -0800
In-Reply-To: <87y2g4dgpc.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 03 Feb 2021 21:44:31 +0100")
Message-ID: <xmqq4kir8zyr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 78B3B7C2-6714-11EB-91B9-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> There's a bug here where now different things are dispatched to either
> the -S or -G codepath wrongly, I've fixed it in my local version.
>
> Anyway, it's interesting between this and the -U0 change that we have
> little/no coverage for some/all of this. I'm trying to address that in
> preceding patches in v2.

Back when I did the original -S<fixed>, we weren't as focused on
good test coverage as we are now.  We may have added a lot more by
the time when we introduced -G and -S<regexp>, but your effort that
resulted in noticing the lack of basic coverage and rectifying the
situation is very much appreciated.

Thanks.
