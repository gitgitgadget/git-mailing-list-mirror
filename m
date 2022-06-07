Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22434C43334
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 17:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346360AbiFGR1B (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 13:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346817AbiFGRZb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 13:25:31 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B64110987
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 10:23:16 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BD4311A744C;
        Tue,  7 Jun 2022 13:23:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nlOnvZC0wh/O
        q3LTLWyEIllGrqyJ7ji4hntyXfZfNcU=; b=yXq4HWjHBl5kqHtjzsCZJWUdZ2mN
        c9NmijEKvOA7WQ87zNQCcSaaIzItBFaXARGF2av7Fo/onYYex0+QS8iV4eo5Vjf9
        y/fCJwHxw1k4UHPxnh/WqFCOcvF1p2lDsmhFCc3vogj9n+//NheKgRuKGAiJ1jgS
        RwLKHJxH9F3jEk8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B565B1A744B;
        Tue,  7 Jun 2022 13:23:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5CC791A7448;
        Tue,  7 Jun 2022 13:23:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Subject: Re: [PATCH 2/3] remote.c: don't dereference NULL in freeing loop
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
        <cover-0.3-00000000000-20220607T154520Z-avarab@gmail.com>
        <patch-2.3-0e258c230f6-20220607T154520Z-avarab@gmail.com>
Date:   Tue, 07 Jun 2022 10:23:11 -0700
In-Reply-To: <patch-2.3-0e258c230f6-20220607T154520Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 7 Jun
 2022 17:50:04 +0200")
Message-ID: <xmqqpmjkxu9s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 82136752-E686-11EC-A6C3-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Fix a bug in fd3cb0501e1 (remote: move static variables into
> per-repository struct, 2021-11-17) where we'd free(remote->pushurl[i])
> after having NULL'd out remote->pushurl. itself. We free

Wow, that's a bad one.  Why didn't anybody notice this at runtime, I
have to wonder.

>  	for (i =3D 0; i < remote->url_nr; i++)
>  		free((char *)remote->url[i]);
> -	FREE_AND_NULL(remote->pushurl);
> +	FREE_AND_NULL(remote->url);
> =20
>  	for (i =3D 0; i < remote->pushurl_nr; i++)
>  		free((char *)remote->pushurl[i]);
>  	FREE_AND_NULL(remote->pushurl);

Thanks.
