Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A66C433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 17:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CAE660EFE
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 17:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhJLRUH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 13:20:07 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53569 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhJLRUG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 13:20:06 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D70C9163F00;
        Tue, 12 Oct 2021 13:18:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6FpnZ9mTUKz7
        qZjQkGelq7Opr4W7w3ynk7cL8Kqxw0o=; b=CG35Ho2mvARmz0lKxl9CzrlHsbVh
        9ajjmJkGSRBpA8zy90ku+JUt6ZFUN6vP0+96mW1fc0MQ7WztHmZQFHXcSjA9vZEC
        3oR4od1eQ78YksY/cRJMryrNWENIYYez7n7uwP7sqBbAmRAsCbW5rWjpo5ELlMH5
        h1k5ykPKMfI4fMI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CFF86163EFF;
        Tue, 12 Oct 2021 13:18:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6F491163EFD;
        Tue, 12 Oct 2021 13:18:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Robin Dupret <robin.dupret@gmail.com>,
        git@vger.kernel.org, Robin Dupret <robin.dupret@hey.com>
Subject: Re: [PATCH] http-backend: remove a duplicated code branch
References: <20211011192546.1571-1-robin.dupret@hey.com>
        <20211011192546.1571-2-robin.dupret@hey.com>
        <YWTyr6joJlyi1TPe@coredump.intra.peff.net>
        <8735p6li20.fsf@evledraar.gmail.com>
Date:   Tue, 12 Oct 2021 10:18:01 -0700
In-Reply-To: <8735p6li20.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 12 Oct 2021 11:07:55 +0200")
Message-ID: <xmqqbl3u5fhy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5B083FA0-2B80-11EC-9A2E-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> diff --git a/http-backend.c b/http-backend.c
> index e7c0eeab230..13bc421b4e8 100644
> --- a/http-backend.c
> +++ b/http-backend.c
> @@ -462,19 +462,19 @@ static void run_service(const char **argv, int bu=
ffer_input)
>  	const char *encoding =3D getenv("HTTP_CONTENT_ENCODING");
>  	const char *user =3D getenv("REMOTE_USER");
>  	const char *host =3D getenv("REMOTE_ADDR");
> -	int gzipped_request =3D 0;
> +	int gzipped_request;
>  	struct child_process cld =3D CHILD_PROCESS_INIT;
>  	ssize_t req_len =3D get_content_length();
> =20
> -	if (encoding && !strcmp(encoding, "gzip"))
> -		gzipped_request =3D 1;
> -	else if (encoding && !strcmp(encoding, "x-gzip"))
> -		gzipped_request =3D 1;
> -
>  	if (!user || !*user)
>  		user =3D "anonymous";
>  	if (!host || !*host)
>  		host =3D "(none)";
> +	if (!encoding)
> +		encoding =3D "";
> +
> +	gzipped_request =3D (!strcmp(encoding, "gzip") ||
> +			   !strcmp(encoding, "x-gzip"))

In general, I'd frown upon such a conversion.  In the the current
code, "encoding" might go dead after this point, but we are losing
information for no good reason by making !encoding and !*encoding
indistinguisable after this point.  Compared to that, the rewrite in
the patch that started this discussion would be more preferrable.

Thanks.

