Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD62C6377A
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 16:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE17961409
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 16:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344141AbhGSPlL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 11:41:11 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58002 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349783AbhGSPgP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 11:36:15 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 476CA132364;
        Mon, 19 Jul 2021 12:16:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vw17XI2mp25v
        xuYLF8stSkZW2kyAImRFOkQPg0WsXVE=; b=jbwE3s0PXaddJNomaVlUqISM2WDs
        Gsih1caMukYwsuP6++QWXLeBNjwN95IhXBXVY2tBof6GEG9JKOz4ZpN/O7+868eb
        sIW8nA1xwvEOcnVYF2LnuVnNoJzke+eC+jxH9rwXclKrjoXOELhSXZq76mfRsLmR
        tmN4Mwt2dVYsjk4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4053D132363;
        Mon, 19 Jul 2021 12:16:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 85037132362;
        Mon, 19 Jul 2021 12:16:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 02/11] refs/files: remove unused REF_DELETING in
 lock_ref_oid_basic()
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com>
        <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
        <patch-02.11-033c0cec33d-20210716T140631Z-avarab@gmail.com>
Date:   Mon, 19 Jul 2021 09:16:49 -0700
In-Reply-To: <patch-02.11-033c0cec33d-20210716T140631Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 16 Jul
 2021 16:12:58
        +0200")
Message-ID: <xmqqk0lmnury.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B9E31188-E8AC-11EB-A13A-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The lock_ref_oid_basic() function has gradually been replaced by use
> of the file transaction API, there are only 4 remaining callers of
> it.

Peff mentioned "file, not ref?", and I wonder about the same thing.

Inside the implementation of ref transaction (e.g. the codepath that
calls lock_ref_for_update() from files_transaction_prepare()), we do
end up calling the lockfile API and you could (but I'd prefer not to
see you do so) call it "file transaction API", but I think you meant
that most callers no longer perform low-level "acquire lock, update
and release" and instead use the ref transaction.

> None of those callers pass REF_DELETING, the last such caller went
> away in 8df4e511387 (struct ref_update: move "have_old" into "flags",
> 2015-02-17). This is the start of even more removal of unused code in
> and around this function.

While I agree that no existing calls to lock_ref_oid_basic() pass
REF_DELETING to it (hence this patch is a benign no-op), inside
ref_transaction_commit(), 8df4e511387 still used REF_DELETING, I
think, like so:

	/* Acquire all locks while verifying old values */
	for (i =3D 0; i < n; i++) {
		struct ref_update *update =3D updates[i];
		unsigned int flags =3D update->flags;

		if (is_null_sha1(update->new_sha1))
			flags |=3D REF_DELETING;
		update->lock =3D lock_ref_sha1_basic(
				update->refname,
				((update->flags & REF_HAVE_OLD) ?
				 update->old_sha1 : NULL),
				NULL,
				flags,
				&update->type);


> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  refs/files-backend.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 677b7e4cdd2..326f0224218 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -934,8 +934,6 @@ static struct ref_lock *lock_ref_oid_basic(struct f=
iles_ref_store *refs,
> =20
>  	if (mustexist)
>  		resolve_flags |=3D RESOLVE_REF_READING;
> -	if (flags & REF_DELETING)
> -		resolve_flags |=3D RESOLVE_REF_ALLOW_BAD_NAME;
> =20
>  	files_ref_path(refs, &ref_file, refname);
>  	resolved =3D !!refs_resolve_ref_unsafe(&refs->base,
