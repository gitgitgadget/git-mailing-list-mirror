Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A221C433F5
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 06:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51C3F60231
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 06:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhKAGJv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 02:09:51 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51367 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbhKAGJp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 02:09:45 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6BE1516F564;
        Mon,  1 Nov 2021 02:07:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=DSztlFudaKL3
        rILX0sxrDh1wra7AuNpo8+ijMOoByLg=; b=P7fmpbS5TfKYr6XfxCXmL3QxeJ5o
        2tX0dvgOvtowcRv/gclQfe4i+xoZlzSS8YlrNLpX59ee2M7LhDT4bN1YPK088ymE
        GNJCA8M2v4lphNYhEqO9W4tcChOSE6P9/83EsLDjEAwKAM6IBYLiInBKT9SBaX2G
        4d05xWcxw9YJsUw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 56DDF16F563;
        Mon,  1 Nov 2021 02:07:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EAF4B16F562;
        Mon,  1 Nov 2021 02:07:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Fabian Stelzer <fs@gigacodes.de>
Subject: Re: [PATCH 2/2] gpg-interface: avoid buffer overrun in
 parse_ssh_output()
References: <f6fca7c0-079c-4337-23d9-cd970c79b8ad@web.de>
        <a72ebd19-9871-f811-cd5c-72b89dad6c6f@web.de>
Date:   Sun, 31 Oct 2021 23:07:07 -0700
In-Reply-To: <a72ebd19-9871-f811-cd5c-72b89dad6c6f@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 30 Oct 2021 19:07:38 +0200")
Message-ID: <xmqq4k8we7ec.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F256C7C4-3AD9-11EC-A557-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> If the string "key" we found in the output of ssh-keygen happens to be
> located at the very end of the line, then going four characters further
> leaves us beyond the end of the string.  Explicitly search for the
> space after "key" to handle a missing one gracefully.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> This code was added after v2.33.0.

Thanks.

Fabian, we are in -rc phase where we concentrate on fixing bugs in
the new code in 'master'.  A quick ack, "here is a better way to fix
it", or "no, that won't be needed because..." is very much
appreciated.


>  gpg-interface.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/gpg-interface.c b/gpg-interface.c
> index 62d340e78a..3838536f0a 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -409,9 +409,9 @@ static void parse_ssh_output(struct signature_check=
 *sigc)
>  		goto cleanup;
>  	}
>
> -	key =3D strstr(line, "key");
> +	key =3D strstr(line, "key ");
>  	if (key) {
> -		sigc->fingerprint =3D xstrdup(strstr(line, "key") + 4);
> +		sigc->fingerprint =3D xstrdup(strstr(line, "key ") + 4);
>  		sigc->key =3D xstrdup(sigc->fingerprint);
>  	} else {
>  		/*
> --
> 2.33.1
