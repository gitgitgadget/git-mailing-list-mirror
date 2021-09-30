Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BF0C433F5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 21:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76AB361A0B
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 21:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344447AbhI3VDF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 17:03:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52453 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhI3VDE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 17:03:04 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A4D8EC19D;
        Thu, 30 Sep 2021 17:01:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=syCiRfXzBjOF
        DbS5BIPB3EvySLuzUveNgu+iFqKpqhA=; b=xs97ovqU9xNi+1fL4PcUy6mMildy
        QejQ4pVtHjUUIVMiFiiiWz3QSXCdR8Ut+FQbhlpldKNAQaSikU12xkjhCbyMhevE
        wHUZ8A+Ufzi76p/TE0wZ5HP4PqeRgA1eH/X2zbQBPmXB6NGpG3SLD93TsmhbH0Dk
        nKtpqoEGlrXvu6Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 21213EC19B;
        Thu, 30 Sep 2021 17:01:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7BC83EC199;
        Thu, 30 Sep 2021 17:01:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v9 17/17] fsck: report invalid object type-path
 combinations
References: <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
        <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
        <patch-v9-17.17-8d926e41fc3-20210930T133300Z-avarab@gmail.com>
Date:   Thu, 30 Sep 2021 14:01:19 -0700
In-Reply-To: <patch-v9-17.17-8d926e41fc3-20210930T133300Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 30 Sep
 2021 15:37:22
        +0200")
Message-ID: <xmqqsfxlaicg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8FF06344-2231-11EC-9FE7-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 623f8fc3194..980c26e3b25 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -598,23 +598,30 @@ static int fsck_loose(const struct object_id *oid=
, const char *path, void *data)
>  	struct object *obj;
>  	enum object_type type;
>  	unsigned long size;
> -	void *contents;
> +	unsigned char *contents =3D NULL;
>  	int eaten;
>  	struct strbuf sb =3D STRBUF_INIT;
>  	struct object_info oi =3D OBJECT_INFO_INIT;
> -	int err =3D 0;
> +	struct object_id real_oid =3D *null_oid();
> +	int ret;
> =20
>  	oi.type_name =3D &sb;
>  	oi.sizep =3D &size;
>  	oi.typep =3D &type;
> =20
> -	if (read_loose_object(path, oid, &contents, &oi) < 0)
> -		err =3D error(_("%s: object corrupt or missing: %s"),
> -			    oid_to_hex(oid), path);
> +	ret =3D read_loose_object(path, oid, &real_oid, (void **)&contents, &=
oi);
> +	if (ret < 0) {
> +		if (contents && !oideq(&real_oid, oid))
> +			error(_("%s: hash-path mismatch, found at: %s"),
> +			      oid_to_hex(&real_oid), path);
> +		else
> +			error(_("%s: object corrupt or missing: %s"),
> +			      oid_to_hex(oid), path);
> +	}
>  	if (type < 0)
> -		err =3D error(_("%s: object is of unknown type '%s': %s"),
> -			    oid_to_hex(oid), sb.buf, path);
> -	if (err) {
> +		ret =3D error(_("%s: object is of unknown type '%s': %s"),
> +			    oid_to_hex(&real_oid), sb.buf, path);
> +	if (ret < 0) {
>  		errors_found |=3D ERROR_OBJECT;
>  		goto cleanup;
>  	}

This is immediately touching up what 16/17 has introduced, which is
making it a bit harder to follow than necessary, so let's take the
whole postimage of 16+17.

> static int fsck_loose(const struct object_id *oid, const char *path, vo=
id *data)
> {
> 	struct object *obj;
> 	enum object_type type;
> 	unsigned long size;
> 	unsigned char *contents =3D NULL;
> 	int eaten;
> 	struct strbuf sb =3D STRBUF_INIT;
> 	struct object_info oi =3D OBJECT_INFO_INIT;
> 	struct object_id real_oid =3D *null_oid();
> 	int ret;
>=20
> 	oi.type_name =3D &sb;
> 	oi.sizep =3D &size;
> 	oi.typep =3D &type;
>=20
> 	ret =3D read_loose_object(path, oid, &real_oid, (void **)&contents, &o=
i);
> 	if (ret < 0) {
> 		if (contents && !oideq(&real_oid, oid))
> 			error(_("%s: hash-path mismatch, found at: %s"),
> 			      oid_to_hex(&real_oid), path);
> 		else
> 			error(_("%s: object corrupt or missing: %s"),
> 			      oid_to_hex(oid), path);

We can emit an error() message from either one of these.  contents
may or may not be NULL, ret is negative, and we continue.  Do we
know anything about the value of type at this point?  IOW, will we
get into the body of the next "if (type < 0)" statement to overwrite
ret with -1?

> 	}
> 	if (type < 0)
> 		ret =3D error(_("%s: object is of unknown type '%s': %s"),
> 			    oid_to_hex(&real_oid), sb.buf, path);
> 	if (ret < 0) {
> 		errors_found |=3D ERROR_OBJECT;
> 		goto cleanup;

In any case, we'd jump to clean-up if any of the above hold, so we'd
avoid hittign the next BUG().

> 	}
>=20
> 	if (!contents && type !=3D OBJ_BLOB)
> 		BUG("read_loose_object streamed a non-blob");
>=20
> 	obj =3D parse_object_buffer(the_repository, oid, type, size,
> 				  contents, &eaten);
>=20
> 	if (!obj) {
> 		errors_found |=3D ERROR_OBJECT;
> 		error(_("%s: object could not be parsed: %s"),
> 		      oid_to_hex(oid), path);
> 		goto cleanup_eaten;
> 	}
>=20
> 	obj->flags &=3D ~(REACHABLE | SEEN);
> 	obj->flags |=3D HAS_OBJ;
> 	if (fsck_obj(obj, contents, size))
> 		errors_found |=3D ERROR_OBJECT;
>=20
> cleanup_eaten:
> 	if (!eaten)
> 		free(contents);
> cleanup:
> 	strbuf_release(&sb);

In the "goto cleanup" error case above, we haven't done anything
that would have caused the object contents eaten, and contents may
either point at an allocated memory or NULL (in the "hash-path
mismatch" case, we may have contents allocated but nobody has freed
it yet, leaking it).

I am wondering if we initialized "eaten" to false, we can get rid of
one of the two labels we added in this series, which would fix this
leak as well, no?

> 	return 0; /* keep checking other objects, even if we saw an error */
> }
