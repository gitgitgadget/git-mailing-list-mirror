Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA8A51F462
	for <e@80x24.org>; Tue,  4 Jun 2019 20:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfFDU1i (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 16:27:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56056 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfFDU1i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 16:27:38 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D10CA15D97A;
        Tue,  4 Jun 2019 16:27:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4A77kkPG8JEK
        LCTSCiOFemqOjGo=; b=SZrRrh8oHv9ytFKgGmogyO02YYivUFxNxe5aJ+8qUUhs
        Ee3TIKO8/21a7He4V+JsO4tEkKB/k0rdaN8DME69bqfo7yxJA++pw41he/1fa3QK
        xYJFqc310Nc2cJQeOf7bHSgzCQE3GxjpboZ5EKXGIdDRoPkV913DAow5KZP7DKI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=H1nRt4
        7xWVaeJO6JScIcJ0MaD7bfr/LYltDZs/RlObrlNAn2BkeF4krPutsRqjYzHx7bbc
        yr2kkiHmLcgPhV6KdTxxVH/5bM79d7yQAQpCDUDKY39kvBS9I4eVbv1TTg11oZex
        +Yqh43mu7VlOipENXbtzTACYAZUyLjNWkU5iI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C7DA415D979;
        Tue,  4 Jun 2019 16:27:35 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 34AF915D978;
        Tue,  4 Jun 2019 16:27:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        jeffhostetler@microsoft.com, l.s.r@web.de, spearce@spearce.org,
        jrn@google.com
Subject: Re: [PATCH v2 1/2] url: do not read past end of buffer
References: <cover.1559670300.git.matvore@google.com>
        <9628f0bfeda578a1c7d157d61b87f5c430567d74.1559670300.git.matvore@google.com>
Date:   Tue, 04 Jun 2019 13:27:34 -0700
In-Reply-To: <9628f0bfeda578a1c7d157d61b87f5c430567d74.1559670300.git.matvore@google.com>
        (Matthew DeVore's message of "Tue, 4 Jun 2019 10:57:04 -0700")
Message-ID: <xmqq4l55t7t5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 300EFC32-8707-11E9-B0E5-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

> url_decode_internal could have been tricked into reading past the lengt=
h
> of the **query buffer if there are fewer than 2 characters after a % (i=
n
> a null-terminated string, % would have to be the last character).
> Prevent this from happening by checking len before decoding the %
> sequence.
>
> Helped-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> Signed-off-by: Matthew DeVore <matvore@google.com>
> ---
>  url.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/url.c b/url.c
> index 25576c390b..9ea9d5611b 100644
> --- a/url.c
> +++ b/url.c
> @@ -39,21 +39,21 @@ static char *url_decode_internal(const char **query=
, int len,
>  		unsigned char c =3D *q;
> =20
>  		if (!c)
>  			break;
>  		if (stop_at && strchr(stop_at, c)) {
>  			q++;
>  			len--;
>  			break;
>  		}
> =20
> -		if (c =3D=3D '%') {
> +		if (c =3D=3D '%' && (len < 0 || len >=3D 3)) {
>  			int val =3D hex2chr(q + 1);

This made me wonder what happens when the caller sent -1 in len, but
hex2chr() stops on such a string with % plus one hexadecimal at the
end of the string, and we'd end up copying these two bytes one at a
time, which is what we want, so it is OK.  And the rejection of %00
done in 2/2 follows the same codeflow here, which is quite straight
forward.

Nice.


>  			if (0 <=3D val) {
>  				strbuf_addch(out, val);
>  				q +=3D 3;
>  				len -=3D 3;
>  				continue;
>  			}
>  		}
> =20
>  		if (decode_plus && c =3D=3D '+')
