Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E15C4332F
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 01:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF98161051
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 01:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbhIMBMB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 21:12:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53370 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbhIMBMA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 21:12:00 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6AF1BE10D7;
        Sun, 12 Sep 2021 21:10:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NDA39yxLIWzk
        XlgeiKWWTzHqgJJ4/oALjMtI6u7JZ/U=; b=UEWngRnCAHeTXSEiIBCEUJWd5L79
        Q9f4gETA4hy5RS+fV/F283t/oAwNAGyA8H4Us+lZ3bYm59YtNPkNe0QNti9dZNke
        y5fqz3xmWhafF7lc+H2bi0y63Sv3LvaM0HBX5gqkd/wTzWg7u82j1g8GUP4IbnIS
        rHTydj+sUrwk6AA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 64280E10D6;
        Sun, 12 Sep 2021 21:10:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E1F5FE10D4;
        Sun, 12 Sep 2021 21:10:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, lehmacdj@gmail.com
Subject: Re: [PATCH 2/3] credential-cache: check for windows specific errors
References: <20210912202830.25720-1-carenas@gmail.com>
        <20210912202830.25720-3-carenas@gmail.com>
Date:   Sun, 12 Sep 2021 18:10:44 -0700
In-Reply-To: <20210912202830.25720-3-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Sun, 12 Sep 2021 13:28:29 -0700")
Message-ID: <xmqqwnnlgu0b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6BFCF3AE-142F-11EC-9BA3-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> Connect and reset errors aren't what will be expected by POSIX but
> are compatible with the ones used by WinSock.
>
> Alternatively a translation layer for read could be added (similar
> to the one provided by mingw-write()) to translate the odd EINVAL,
> into a more reasonable EPIPE, but this is more localized and still
> unlikely to cause confusion in other systems.

Are we sure EINVAL or ENETDOWN from outside the Windows world is
tolerable after read_in_full() failure in this context?

I'd rather see something like

	if (!r || (r < 0 && connection_closed(errno)))
		break;

with a local helper function connection_closed() allowing EINVAL
only with "#ifdef WINDOWS" to be safe.  The same for "the socket is
not yet open" codepath with another local helper function.

Thanks.

>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  builtin/credential-cache.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
> index 76a6ba3722..b12a79ae01 100644
> --- a/builtin/credential-cache.c
> +++ b/builtin/credential-cache.c
> @@ -28,7 +28,8 @@ static int send_request(const char *socket, const str=
uct strbuf *out)
>  		int r;
> =20
>  		r =3D read_in_full(fd, in, sizeof(in));
> -		if (r =3D=3D 0 || (r < 0 && errno =3D=3D ECONNRESET))
> +		if (r =3D=3D 0 ||
> +			(r < 0 && (errno =3D=3D ECONNRESET || errno =3D=3D EINVAL)))
>  			break;
>  		if (r < 0)
>  			die_errno("read error from cache daemon");
> @@ -75,7 +76,7 @@ static void do_cache(const char *socket, const char *=
action, int timeout,
>  	}
> =20
>  	if (send_request(socket, &buf) < 0) {
> -		if (errno !=3D ENOENT && errno !=3D ECONNREFUSED)
> +		if (errno !=3D ENOENT && errno !=3D ECONNREFUSED && errno !=3D ENETD=
OWN)
>  			die_errno("unable to connect to cache daemon");
>  		if (flags & FLAG_SPAWN) {
>  			spawn_daemon(socket);
