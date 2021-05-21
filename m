Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39897C433B4
	for <git@archiver.kernel.org>; Fri, 21 May 2021 07:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FA52611ED
	for <git@archiver.kernel.org>; Fri, 21 May 2021 07:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbhEUHJa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 03:09:30 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51795 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbhEUHJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 03:09:27 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 652C7121200;
        Fri, 21 May 2021 03:08:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=HCAThVn64uC1
        9aqxPgu8LXO1DvxF4uPomxtrHzvDmSk=; b=uYK6Lv03aW6JlU/0eujwnB7Swr/q
        uF37/sGN4o51ljtY/xyKzMtOOTrcskaN9cje6ra9uwnwlHqWIgqbYOgA7GkCj/K7
        YbcpiOZo2eYgHNIhS7O0JMsZ/y+U5DjJkvR6NsA1buZctjY4RfNmZ7GFlEVwCplv
        XQ0+7x2TYYVwabE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5C7571211FF;
        Fri, 21 May 2021 03:08:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A41EE1211FD;
        Fri, 21 May 2021 03:08:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Gregory Anders <greg@gpanders.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2 00/10] send-email: various optimizations to speed up
 by >2x
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
        <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com>
        <YKYdeom6SgAHqojm@coredump.intra.peff.net>
        <xmqqv97drmge.fsf@gitster.g> <875yzcpo52.fsf@evledraar.gmail.com>
Date:   Fri, 21 May 2021 16:07:59 +0900
In-Reply-To: <875yzcpo52.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 21 May 2021 08:23:15 +0200")
Message-ID: <xmqq7djssgxc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 47C7B554-BA03-11EB-B8E5-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Returning a flattened list is idiomatic in Perl, it means that a caller
> can do any of:
>
>     # I only care about the last value for a key, or only about
>     # existence checks
>     my %hash =3D func();
>
> Or:
>
>     # I want all key-values to iterate over
>     my @kv =3D func();
>
> Returning touples like this makes that less convenient for both, who'll
> need to do more work to unpack them.

Thanks---that was exactly what I was missing.  Following establshed
patterns is good.

So what remains is just the compatibility issues, I think.

Thanks for clarification.
