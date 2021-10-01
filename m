Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29C2C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 22:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE87461AA3
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 22:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355802AbhJAWQY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 18:16:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52267 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355158AbhJAWQU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 18:16:20 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B1B5D3BC2;
        Fri,  1 Oct 2021 18:14:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Vfs1xf+dtxP5
        V3A6uNHyIsUgtyAH76ahfvhoMBoAs7Y=; b=pzPLIHKKyJw3MiLDySYLTSBEECwN
        x3VN5aBRiYrArHbAASXYFTXz2RedkBWT65X30JRAGkyK12Khovz6zd32SStMp78N
        PmdYHHr97SnNM33yhEaClEPJbJDBOo2tkcbL5bp95ZDxVlW3fLE8+giG3cXt7qtn
        FqaUnrKqao2bYk4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 405CED3BBF;
        Fri,  1 Oct 2021 18:14:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A64BFD3BBD;
        Fri,  1 Oct 2021 18:14:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v10 17/17] fsck: report invalid object type-path
 combinations
References: <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
        <cover-v10-00.17-00000000000-20211001T091051Z-avarab@gmail.com>
        <patch-v10-17.17-838df0a979b-20211001T091051Z-avarab@gmail.com>
Date:   Fri, 01 Oct 2021 15:14:33 -0700
In-Reply-To: <patch-v10-17.17-838df0a979b-20211001T091051Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 1 Oct
 2021 11:16:53
        +0200")
Message-ID: <xmqqk0iw2y0m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F57B4AFC-2304-11EC-892D-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 260210bf8a1..30a516da29e 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -615,12 +616,18 @@ static int fsck_loose(const struct object_id *oid=
, const char *path, void *data)
>  	oi.sizep =3D &size;
>  	oi.typep =3D &type;
> =20
> -	if (read_loose_object(path, oid, &contents, &oi) < 0)
> -		err =3D error(_("%s: object corrupt or missing: %s"),
> -			    oid_to_hex(oid), path);
> +	if (read_loose_object(path, oid, &real_oid, &contents, &oi) < 0) {
> +		if (contents && !oideq(&real_oid, oid))
> +			err =3D error(_("%s: hash-path mismatch, found at: %s"),
> +				    oid_to_hex(&real_oid), path);
> +		else
> +			err =3D error(_("%s: object corrupt or missing: %s"),
> +				    oid_to_hex(oid), path);
> +	}
>  	if (type !=3D OBJ_NONE && type < 0)
>  		err =3D error(_("%s: object is of unknown type '%s': %s"),
> -			    oid_to_hex(oid), cb_data->obj_type.buf, path);
> +			    oid_to_hex(&real_oid), cb_data->obj_type.buf,
> +			    path);
>  	if (err < 0) {
>  		errors_found |=3D ERROR_OBJECT;
>  		return 0; /* keep checking other objects */

When we say "hash-path mismatch", we would have non-null contents,
presumably obtained from read_loose_object().  err is made negative
when we give that messge, and we come here to return.  Did we forget
to free "contents" in that case?

