Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90122C433ED
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 04:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 638566143E
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 04:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbhD2E4D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 00:56:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57330 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhD2E4B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 00:56:01 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C0AE6D0E2C;
        Thu, 29 Apr 2021 00:55:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=M9gctQ/zjWJD
        Jy+NQqpz7VL73QbkH5IoyPkcwZLlF8U=; b=tZo/XqvMCfNgDSY422ysJwoBI90J
        QBO24FB1PAbvWnzuuM1vjmWau5lz6u6JcZEdZllgb3fEg4SSeWFZIp2NJOtNalj7
        dz7yEuvXb333iE2+IqUNEFtF38X36MB1ZI2KDLDjbfmJRXBhkGvlcNhh0sgjBfPL
        ZVKH8gVv4wSfgrU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B8635D0E2B;
        Thu, 29 Apr 2021 00:55:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 468EBD0E2A;
        Thu, 29 Apr 2021 00:55:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 08/10] object.c: don't go past "len" under die() in
 type_from_string_gently()
References: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com>
        <cover-00.10-0000000000-20210420T124428Z-avarab@gmail.com>
        <patch-08.10-f652d0fb5c-20210420T124428Z-avarab@gmail.com>
Date:   Thu, 29 Apr 2021 13:55:14 +0900
In-Reply-To: <patch-08.10-f652d0fb5c-20210420T124428Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 20 Apr
 2021 14:50:41 +0200")
Message-ID: <xmqq1rat8zbh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 165B8DFA-A8A7-11EB-AF26-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Fix a bug that's been with us ever since type_from_string_gently() was
> split off from type_from_string() in fe8e3b71805 (Refactor
> type_from_string() to allow continuing after detecting an error,
> 2014-09-10).
>
> When the type was invalid and we were in the non-gently mode we'd die,
> and then proceed to run off past the "len" of the buffer we were
> provided with.
>
> Luckily, I think that nothing ever used this function in that way. Any
> non-gentle invocation came via type_from_string(), which was passing a
> buffer with a NIL at the same place as the "len" would take us (we got
> it via strlen()).

NIL???


>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  object.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/object.c b/object.c
> index 70af833ca1..bad9e17f25 100644
> --- a/object.c
> +++ b/object.c
> @@ -50,7 +50,7 @@ int type_from_string_gently(const char *str, ssize_t =
len, int gentle)
>  	if (gentle)
>  		return -1;
> =20
> -	die(_("invalid object type \"%s\""), str);
> +	die(_("invalid object type \"%.*s\""), (int)len, str);
>  }

This makes total sense.  This is one of the reasons why I hate to
review your topics---many patches in them seem unwarranted churn,
but there are clear gems like this commit buried in late steps in
them so I need to read through them to find these anyway :-)


