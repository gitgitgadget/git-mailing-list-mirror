Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677B7C433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 20:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345994AbiALUAT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 15:00:19 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59574 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350404AbiALT7V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 14:59:21 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C05DFE464;
        Wed, 12 Jan 2022 14:59:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2npZfLoeKBFc
        tDQYQMS1deTdW4bg/vfScdCC3JHUkGE=; b=Oudsg+XM+WH4VTY4UPtFf/OhaBsL
        FrdBQBGHVLWbRvyBz5FcgbXQ8KrjClYN0OPUEpf18K/9eF9ip6aHu8X7oPH0H++Z
        nYBB5JoAO7eKMM2hJ2/R5HZelPRrGkCFZ0QOjB0GzCG7WdLo1DDE2WwTw6rCADd2
        M2N1EtObRKh6Gr0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 53A37FE463;
        Wed, 12 Jan 2022 14:59:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B83A8FE462;
        Wed, 12 Jan 2022 14:59:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v3 1/3] refs API: use "failure_errno", not "errno"
References: <cover-v2-0.3-00000000000-20211212T195108Z-avarab@gmail.com>
        <cover-v3-0.3-00000000000-20220112T123117Z-avarab@gmail.com>
        <patch-v3-1.3-a45268ac24b-20220112T123117Z-avarab@gmail.com>
Date:   Wed, 12 Jan 2022 11:59:17 -0800
In-Reply-To: <patch-v3-1.3-a45268ac24b-20220112T123117Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 12 Jan
 2022 13:36:46
        +0100")
Message-ID: <xmqqh7a8u3my.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 208F5066-73E2-11EC-8FCA-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> @@ -1722,8 +1722,6 @@ const char *refs_resolve_ref_unsafe(struct ref_st=
ore *refs,
>  		if (refs_read_raw_ref(refs, refname, oid, &sb_refname,
>  				      &read_flags, failure_errno)) {
>  			*flags |=3D read_flags;
> -			if (errno)
> -				*failure_errno =3D errno;

Looks good. =20

The whole point of passing failure_errno down to refs_read_raw_ref()
is that we capture the reason of the failure there without having to
rely on errno at this point in the flow.  Removal of this assignment
makes perfect sense.

But ...

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index b529fdf237e..43a3b882d7c 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -382,7 +382,6 @@ static int files_read_raw_ref(struct ref_store *ref=
_store, const char *refname,
>  	if (lstat(path, &st) < 0) {
>  		int ignore_errno;
>  		myerr =3D errno;
> -		errno =3D 0;
>  		if (myerr !=3D ENOENT)
>  			goto out;
>  		if (refs_read_raw_ref(refs->packed_ref_store, refname, oid,
> @@ -399,7 +398,6 @@ static int files_read_raw_ref(struct ref_store *ref=
_store, const char *refname,
>  		strbuf_reset(&sb_contents);
>  		if (strbuf_readlink(&sb_contents, path, st.st_size) < 0) {
>  			myerr =3D errno;
> -			errno =3D 0;
>  			if (myerr =3D=3D ENOENT || myerr =3D=3D EINVAL)
>  				/* inconsistent with lstat; retry */
>  				goto stat_ref;
> @@ -469,6 +467,7 @@ static int files_read_raw_ref(struct ref_store *ref=
_store, const char *refname,
> =20
>  	strbuf_release(&sb_path);
>  	strbuf_release(&sb_contents);
> +	errno =3D 0;
>  	return ret;
>  }

... it is not clear to me if this part makes sense.  If everybody
above the callstack uses failure_errno as the source of truth,
clearing errno here in this function should not be necessary and is
misleading to readers of the code, no?
