Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBFEC433E6
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4174B64E99
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241711AbhCDBDf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:03:35 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58024 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355452AbhCDA2k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 19:28:40 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A1205BEEC1;
        Wed,  3 Mar 2021 19:27:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MVH5CBdSdqGK
        di8NHcWuqiYUJHs=; b=USwPW3PGcy4DEXGzCZ/sfqUDy1GYlB2n0x3oB3awao48
        gkyizIZgzbsJqbmQaK306eWvcJru8y9qj7nFqN0CYafnO9cbX8wBPlznaBkDwVXT
        Lg0eYNxy3lxJDVY+Ry+SUZ7HIS0gcOIQ3psDOm3Qvz8NAqTjpCNyDyYBr9ldvM0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=AG22wb
        8EmHpo54WreNdRUG8kepdzwW/1pvV198n952a4SYdux1WVNs2s5+D/wsQC+VzP70
        cpxTdylN0Rn/MUptuJQcPCVWfl8yTYhUGPTA5OI2x3PY4ySDstNp4li3h+gwcJgp
        i6gNxvSSDwFlf2IAWjjDRurr+9SGUji4i3ZF0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9969BBEEC0;
        Wed,  3 Mar 2021 19:27:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2466BBEEBF;
        Wed,  3 Mar 2021 19:27:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2 09/10] grep/pcre2: move back to thread-only PCREv2
 structures
References: <20210204210556.25242-1-avarab@gmail.com>
        <20210218000728.13995-10-avarab@gmail.com>
Date:   Wed, 03 Mar 2021 16:27:55 -0800
In-Reply-To: <20210218000728.13995-10-avarab@gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 18 Feb 2021 01:07:27 +0100")
Message-ID: <xmqqh7lrhies.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 77277F98-7C80-11EB-9AFC-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> So let's remove this special case and make all of them thread-local
> again for simplicity. With this change we could move the
> pcre2_{malloc,free} functions around to live closer to their current
> use. I'm not doing that here to keep this change small, that cleanup
> will be done in a follow-up commit.

Nice.

