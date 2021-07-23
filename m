Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28DEC4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 15:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC4B460E73
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 15:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbhGWOkq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 10:40:46 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50655 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbhGWOkp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 10:40:45 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9921D1384B5;
        Fri, 23 Jul 2021 11:21:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=A3WBQ1Qkc1c/
        BVbx2DjHADZB6CoGjzmqPuLsDkrsBos=; b=Gfym1w4pZ657RvJQB6I4FoKfjojm
        DeEP5xB4iM3PIszvYZ9o/FcW5UD9QXQGOEYiYkJvPhW0bYICPOsPzyc8tXz1vYgr
        4ZW3z5Sd/gQdYNz1bZng/L0YJuA6kETOMUVKOho4OqrJacF/XCYVRmBh/tsrnIRA
        68C3U/w5jnupa7w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 925E81384B4;
        Fri, 23 Jul 2021 11:21:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D73AC1384B2;
        Fri, 23 Jul 2021 11:21:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org,
        Tom Cook <tom.k.cook@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] setup: only die on invalid .git under RUN_SETUP
References: <CAFSh4Uyr5v9Ao-j0j7yO_HkUZSovBmSg7ADia7XCNZfsspFUYg@mail.gmail.com>
        <patch-1.1-fc26c46d39-20210722T140648Z-avarab@gmail.com>
        <8fbf200c-2d88-dce2-84c3-ead330e975e8@gmail.com>
        <87tukls7ax.fsf@evledraar.gmail.com>
Date:   Fri, 23 Jul 2021 08:21:13 -0700
In-Reply-To: <87tukls7ax.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 23 Jul 2021 11:33:30 +0200")
Message-ID: <xmqq8s1xqcnq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9F53AF4C-EBC9-11EB-BF54-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>> +	int die_on_error =3D !nongit_ok;
>>> +	enum discovery_result discovery;
>>> ...    	/*
>>> +	case GIT_DIR_GITFILE_NOT_A_REPO:
>>> +		if (!nongit_ok)
>>> +			die(_("not a git repository: %s"), dir.buf);
>>> +		*nongit_ok =3D 1;
>>> +		break;
>>> +	case GIT_DIR_INVALID_GITFILE:
>>> +		if (!nongit_ok)
>>
>> Variable die_on_error could be used in two `if`s above.
>
> Re-reading my own code I think it's better just to drop die_on_error
> entirely and use !nongit_ok consistently, as the rest of the function
> does. What do yo think?

I think "not X_ok" means we do not consider X is OK, and agree with
you that the code is clearer without an extra indirection (I do not
know if you meant to address me, though).


