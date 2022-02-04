Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362ACC433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 21:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240842AbiBDVPS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 16:15:18 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62166 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240936AbiBDVPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 16:15:16 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A2E111A118;
        Fri,  4 Feb 2022 16:15:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=uFAqihZ2GrH0
        ErZYA7pfWBtabqms8Ctsk++mJ+tCUYU=; b=BlqFhD1KmyghFJ9Vzt2eHy3/7jrU
        nH5Zt+a96ctnhuIMktIRoPWcHFF104swUwGMoAaRKcXTHnB6WGt6dyYb1GFc+Eln
        NNl7cDLesjlc6vMHeWDdfgAl3aF5QZZhBOHRt5OfL5JyqMmXi8hJF/OZylTX1bKf
        g/2IucvxRP1KJoQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 015E111A117;
        Fri,  4 Feb 2022 16:15:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 61F2911A116;
        Fri,  4 Feb 2022 16:15:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 06/11] object API: make check_object_signature()
 oideq()-like, move docs
References: <cover-00.10-00000000000-20220201T144803Z-avarab@gmail.com>
        <cover-v2-00.11-00000000000-20220204T135005Z-avarab@gmail.com>
        <patch-v2-06.11-636a647ac51-20220204T135005Z-avarab@gmail.com>
Date:   Fri, 04 Feb 2022 13:15:14 -0800
In-Reply-To: <patch-v2-06.11-636a647ac51-20220204T135005Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 4 Feb
 2022 14:51:20
        +0100")
Message-ID: <xmqqczk2l4f1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8C08C92E-85FF-11EC-BA70-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Make the return value of check_object_signature() behave like oideq()
> and memcmp() instead of returning negative values on failure.

First of all, oideq() and memcmp() behave completely oppositely to
each other.  When given two same things, eq() says "true" and cmp()
says 0.  They use the opposite polarity.  Which one do you want?

I am not enthused to see a function that used to signal success with
0 and failure with a negative value to suddenly start returning 1
for "they are identical" and 0 for "they are not the same", without
changing its name or parameters to help compilers catch new call
sites that still expect the old behaviour (hence can use "ret < 0",
and "ret" interchangeably to check for "failure - the given data
does not hash to the object name").

> This reduces the boilerplate required when calling the function, and
> makes the calling code behave the same is if though we'd called
> oideq(), which is basically what we're doing here. We already had some
> callers using "f() < 0", with others using "!f()". Instead of
> declaring the latter a bug let's convert all callers to it.
>
> It is unfortunate that there's also cases where we "return -1" on
> various errors, and we can't tell those apart from the expected OID
> being less than the real OID, but this was the case already.

Well, it is not checking "less than" to begin with, no?  The point
of calling this function is to see if the "object_signature" (aka
"hash") is correct for the object data we have, and yield yes/no (or
success or failure) answer.  If we encountered an error while trying
to compute that answer, well, we failed to ensure that the hash
matches the contents, so it is reasonable to say "no, it does not
match".

> This change is rather dangerous stand-alone as we're changing the
> return semantics, but not changing the prototype.

Yes, if you know it, why do it and have reviewers spend their cycles?

If the function is renamed so that its name ends with "eq" or
"matches" (e.g. object_signature_matches()), such a change may be
justified, though.
