Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88ADC433FE
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 18:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AF01610F8
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 18:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbhKKS5N (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 13:57:13 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65515 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbhKKS5L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 13:57:11 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C4495F1857;
        Thu, 11 Nov 2021 13:54:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WcALZsZPZfNN
        1PPzpMVNsQdOn6eOGTMUhOoZF9A2j44=; b=Em7wj41REMUiBekqSAFmCD4EGhGO
        WT+lyDBphBFbO/kkrVNzRiqgs6h3TJ4w5SLzKKbZ+i7rbHZNj89P9JpjsXZbdeNv
        RqM6dTNNEKBfxZN5nuF29NJFYPrE9WoddePU4ZahtSBc7T6ckkTpFgVbtdNf1wfg
        F+1je0+Pa70ZWRI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BBDE2F1856;
        Thu, 11 Nov 2021 13:54:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2E3DFF1855;
        Thu, 11 Nov 2021 13:54:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Han Xin <chiyutianyi@gmail.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 2/2] object-file: free(*contents) only in
 read_loose_object() caller
References: <20211111030532.75910-1-hanxin.hx@alibaba-inc.com>
        <cover-0.2-00000000000-20211111T051800Z-avarab@gmail.com>
        <patch-2.2-e2a5468e2e0-20211111T051800Z-avarab@gmail.com>
Date:   Thu, 11 Nov 2021 10:54:18 -0800
In-Reply-To: <patch-2.2-e2a5468e2e0-20211111T051800Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 11 Nov
 2021 06:18:56 +0100")
Message-ID: <xmqqk0hele05.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C7D195DE-4320-11EC-804D-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index d87c28a1cc4..27b9e78094d 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -605,7 +605,7 @@ static int fsck_loose(const struct object_id *oid, =
const char *path, void *data)
>  	struct object *obj;
>  	enum object_type type =3D OBJ_NONE;
>  	unsigned long size;
> -	void *contents;
> +	void *contents =3D NULL;
>  	int eaten;
>  	struct object_info oi =3D OBJECT_INFO_INIT;
>  	struct object_id real_oid =3D *null_oid();
> @@ -630,6 +630,7 @@ static int fsck_loose(const struct object_id *oid, =
const char *path, void *data)
>  			    path);
>  	if (err < 0) {
>  		errors_found |=3D ERROR_OBJECT;
> +		free(contents);
>  		return 0; /* keep checking other objects */
>  	}
> =20
> diff --git a/object-file.c b/object-file.c
> index ac476653a06..c3d866a287e 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -2528,8 +2528,6 @@ int read_loose_object(const char *path,
>  	char hdr[MAX_HEADER_LEN];
>  	unsigned long *size =3D oi->sizep;
> =20
> -	*contents =3D NULL;
> -
>  	map =3D map_loose_object_1(the_repository, path, NULL, &mapsize);
>  	if (!map) {
>  		error_errno(_("unable to mmap %s"), path);
> @@ -2559,10 +2557,9 @@ int read_loose_object(const char *path,
>  			goto out;
>  		}
>  		if (check_object_signature(the_repository, expected_oid,
> -					   *contents, *size, oi->type_name->buf, real_oid)) {
> -			free(*contents);
> +					   *contents, *size,
> +					   oi->type_name->buf, real_oid))
>  			goto out;
> -		}
>  	}

Yeah, I have to say that read_loose_object() that frees *contents
without clearing *contents to NULL only because it wants to signal
if the failure comes from check_object_signature() step is quite
ugly.  Making the caller responsible for freeing (in other words,
when caller's *contents is non-NULL after function returns, it
always has a valid piece of memory to be freed) makes the contract
easier to explain.
