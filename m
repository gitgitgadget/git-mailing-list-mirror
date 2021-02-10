Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51CDC433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 21:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1B3B64E66
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 21:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhBJVe4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 16:34:56 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62265 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbhBJVez (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 16:34:55 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 503C71066C7;
        Wed, 10 Feb 2021 16:34:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TmAfZA12hNiM
        cq9B29a5greW0Y8=; b=MEvwoz4E/92ZOALJj4I3t+8f7YqzpgUWlsYAjBANu7te
        lTJFOcccFDVc7AopBiKhlVWaSuU46jiAIxBHFqW3RBqv1jn7W3w7fNlz9VpXQRju
        qnZcivMIlSUAgTmhfvLEizj1xlYzQkDckcslR/OHFYgDKL7JrZ48hyDScy3g29k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=PS9klf
        90qv8lsRpqPK9fYlNHe+tsxAiYIDv/aIneMY78ugC81kp77IUEvVWGEs+UsKdVuC
        BOW8zVhAHok89042doeE/trsRXh+ZS5oPaWGwkcKZTU3i4+nTVHiycja47rF4dpt
        IGD4TnPEJYTO5Fclty5mwSV+tq+VrJtHgNsDk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 496B21066C4;
        Wed, 10 Feb 2021 16:34:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C063A1066C3;
        Wed, 10 Feb 2021 16:34:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH 00/10] grep/pcre2: memory allocation fixes
References: <191d3a2280232ff98964fd42bfe0bc85ee3708f5.1571227824.git.gitgitgadget@gmail.com>
        <20210204210556.25242-1-avarab@gmail.com>
Date:   Wed, 10 Feb 2021 13:34:10 -0800
In-Reply-To: <20210204210556.25242-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 4 Feb 2021 22:05:46 +0100")
Message-ID: <xmqqlfbv1ub1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B7131FE4-6BE7-11EB-AE0F-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This series fixes up bugs in our PCRE v2 wrapper code and how it
> handles malloc()/free().
>
> Junio: I'm splitting this off my recently sent 25 patch series, which
> I should probably have sent as an RFC:
> https://lore.kernel.org/git/20210203032811.14979-1-avarab@gmail.com/
>
> It's on top of "next", as it would otherwise conflict with my
> in-flight ab/grep-pcre-invalid-utf8, ab/lose-grep-debug and ab/retire-p=
cre1.

These three seem to be solid and I am planning to merge them down to
'master' soonish.  I was hoping that the series would get enough
reviews by the time it happens so that I can expect an update that
cleanly applies on top of 'master', and the plan seems to be working
well ;-)

