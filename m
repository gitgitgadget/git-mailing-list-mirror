Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01EFC433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 20:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357050AbiALUFI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 15:05:08 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55738 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357782AbiALUCz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 15:02:55 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 21C4216C1E9;
        Wed, 12 Jan 2022 15:02:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=F7F01i9a4HWX
        cDFRrBevrdsfdG7skIs3oxbbjirW8us=; b=dQC9GH3bdmtFpQ3kbex7Z/Jd1h3o
        Bkyzdg8zBJdtjUbqReOLiUQAlkTH/euVrSFKzOwfhXLt/SdwrUkF4HrLNpqT3mPz
        FiRm2gHo9UgEXlQ/s3529DNft2dVqHI1+s8fU41++59By1bgGio93lh3FgnyLk/s
        lSMB37fQ7G/EXJg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1A90516C1E8;
        Wed, 12 Jan 2022 15:02:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 886E916C1E6;
        Wed, 12 Jan 2022 15:02:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v3 2/3] sequencer: don't use die_errno() on
 refs_resolve_ref_unsafe() failure
References: <cover-v2-0.3-00000000000-20211212T195108Z-avarab@gmail.com>
        <cover-v3-0.3-00000000000-20220112T123117Z-avarab@gmail.com>
        <patch-v3-2.3-8d8691a5e93-20220112T123117Z-avarab@gmail.com>
Date:   Wed, 12 Jan 2022 12:02:50 -0800
In-Reply-To: <patch-v3-2.3-8d8691a5e93-20220112T123117Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 12 Jan
 2022 13:36:47
        +0100")
Message-ID: <xmqqczkwu3h1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9F668706-73E2-11EC-8E24-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change code that was faithfully migrated to the new "resolve_errno"
> API in ed90f04155d (refs API: make resolve_ref_unsafe() not set errno,
> 2021-10-16) to stop caring about the errno at all.
>
> When we fail to resolve "HEAD" after the sequencer runs it doesn't
> really help to say what the "errno" value is, since the fake backend
> errno may or may not reflect anything real about the state of the
> ".git/HEAD". With the upcoming reftable backend this fakery will
> become even more pronounced.

OK.  In principle I agree with the reasoning.  Perhaps it can be
better done as a preparation for the reftable backend in future
cycles, not now.

> So let's just die() instead of die_errno() here. This will also help
> simplify the refs_resolve_ref_unsafe() API. This was the only user of
> it that wasn't ignoring the "failure_errno" output parameter.

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  sequencer.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 6abd72160cc..03cdf548d72 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1281,7 +1281,7 @@ void print_commit_summary(struct repository *r,
>  	struct strbuf author_ident =3D STRBUF_INIT;
>  	struct strbuf committer_ident =3D STRBUF_INIT;
>  	struct ref_store *refs;
> -	int resolve_errno;
> +	int ignore_errno;
> =20
>  	commit =3D lookup_commit(r, oid);
>  	if (!commit)
> @@ -1333,11 +1333,9 @@ void print_commit_summary(struct repository *r,
> =20
>  	refs =3D get_main_ref_store(the_repository);
>  	head =3D refs_resolve_ref_unsafe(refs, "HEAD", 0, NULL, NULL,
> -				       &resolve_errno);
> -	if (!head) {
> -		errno =3D resolve_errno;
> -		die_errno(_("unable to resolve HEAD after creating commit"));
> -	}
> +				       &ignore_errno);
> +	if (!head)
> +		die(_("unable to resolve HEAD after creating commit"));
>  	if (!strcmp(head, "HEAD"))
>  		head =3D _("detached HEAD");
>  	else
