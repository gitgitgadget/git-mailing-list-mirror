Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C77AC433EF
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 20:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EBE660F70
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 20:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbhJNUz0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 16:55:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64563 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbhJNUzY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 16:55:24 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F700F8B75;
        Thu, 14 Oct 2021 16:53:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3wG/BFm+5flw
        Y5lH1ZRKxvgCpLUF4nUCiFMJrq8lEdY=; b=A+qKVaMfPQreaCjmasytRaY+j7T4
        5CvsYfTX9g+yBEJkJ9iPdBmfyEeHHOl3zButxDgoX0qYPUkIJgscpg1gYLH4JO24
        RsHDCDRJy+R5wPZ8q5jFkZrFIZTfpU5mARlh8Yg5PJyRhd1XyYBSdUZUzUsxI0xF
        WInTjrcxp1KOPls=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 77E0BF8B74;
        Thu, 14 Oct 2021 16:53:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AAE76F8B72;
        Thu, 14 Oct 2021 16:53:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 06/20] refs/files: remove "name exist?" check in
 lock_ref_oid_basic()
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
        <patch-06.20-3162bf28505-20211013T235900Z-avarab@gmail.com>
Date:   Thu, 14 Oct 2021 13:53:13 -0700
In-Reply-To: <patch-06.20-3162bf28505-20211013T235900Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 14 Oct
 2021 02:06:18
        +0200")
Message-ID: <xmqqh7djba6e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C027C99E-2D30-11EC-993F-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 0af6ee44552..0dd21b2e205 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1013,16 +1013,6 @@ static struct ref_lock *lock_ref_oid_basic(struc=
t files_ref_store *refs,
>  	CALLOC_ARRAY(lock, 1);
> =20
>  	files_ref_path(refs, &ref_file, refname);
> -	if (!refs_resolve_ref_unsafe(&refs->base, refname,
> -				     RESOLVE_REF_NO_RECURSE,
> -				     &lock->old_oid, type)) {
> -		if (!refs_verify_refname_available(&refs->base, refname,
> -						   NULL, NULL, err))
> -			strbuf_addf(err, "unable to resolve reference '%s': %s",
> -				    refname, strerror(errno));
> -
> -		goto error_return;
> -	}
> =20
>  	/*
>  	 * If the ref did not exist and we are creating it, make sure

This has the side effect of "type" not touched at all by this
function, which in turn triggers "type is used uninitialized?"
error in files_reflog_expire() that calls this function.

