Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF32C433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 23:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2291261181
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 23:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238012AbhI0X61 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 19:58:27 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50320 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbhI0X61 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 19:58:27 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A2A84142A1B;
        Mon, 27 Sep 2021 19:56:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Je640hu+zyuq
        JzKhWxii9v6oFE9/5lYP2bJmY6nZH+k=; b=uzx+L/2aQr4BBfGdYRREzAb0p2Ti
        8FzfWJKTGH1oivUIclG87XyGFElNUjXpzjOBwzNbQo2Bg/4xwboswGvpPyTVsvgN
        Worlkgz4auFknBYBn13lG2kaEDHcF+kU3Jr2zrWTqrFd1ALzlIZh2oonFGN2HvbQ
        EVGZIlHNSVqdye4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 99846142A19;
        Mon, 27 Sep 2021 19:56:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F0972142A18;
        Mon, 27 Sep 2021 19:56:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 4/5] builtin/remote.c: add and use a REF_STATES_INIT
References: <cover-0.6-00000000000-20210927T004920Z-avarab@gmail.com>
        <cover-v2-0.5-00000000000-20210927T125715Z-avarab@gmail.com>
        <patch-v2-4.5-13ef9566903-20210927T125715Z-avarab@gmail.com>
        <xmqq4ka5oc1k.fsf@gitster.g> <87v92lzihd.fsf@evledraar.gmail.com>
Date:   Mon, 27 Sep 2021 16:56:44 -0700
In-Reply-To: <87v92lzihd.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 28 Sep 2021 01:38:16 +0200")
Message-ID: <xmqqv92lmv2b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 925EFCD4-1FEE-11EC-B3A9-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> The ownership of the "states" struct or its lifetime isn't different
> after this change. It's only that we're doing:
>
>     struct foo =3D FOO_INIT;
>     /* use &foo */
>
> Instead of:
>
>     struct foo;
>     memset(&foo, 0, sizeof(foo));
>     foo->some_list.strdup_strings =3D 1;

No, I am not talking about ownership of "foo" itself.  What changes
is ownership of some of the string_list embedded in "foo" that used
NOT to have strdup_strings member set now have the bit set, so the
string list owns the string.

>>> +	struct ref_states states =3D REF_STATES_INIT;
>>>  	struct string_list refs_to_prune =3D STRING_LIST_INIT_NODUP;
>>>  	struct string_list_item *item;
>>>  	const char *dangling_msg =3D dry_run
>>>  		? _(" %s will become dangling!")
>>>  		: _(" %s has become dangling!");
>>> =20
>>> -	memset(&states, 0, sizeof(states));
>>>  	get_remote_ref_states(remote, &states, GET_REF_STATES);
>>
>> Like this one, get_remote_ref_states() used to receive states that
>> are set to borrow strings, but now we get duplicated strings, right?
>> Are we leaking whatever strings we push to these string lists now?
>
> Ah, yes it *could* happen as a side-effect of this sotr of change that
> that memset() was implicitly flipping some string_list structs to the
> equivalent of strdup_strings=3D0.
>
> But that's not the case here, it was just memset() boilerplate, then in
> get_remote_ref_states() we'd set all the string lists we'd use to "dup"=
.

OK, get_remotes_ref_states() marked all string list to the dup
variant, then we won't have a problem.  I was trying to make sure
that was something you looked at when preparing these patches.

Thanks.
