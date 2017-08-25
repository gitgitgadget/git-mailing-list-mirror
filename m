Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2207A208DB
	for <e@80x24.org>; Fri, 25 Aug 2017 21:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933070AbdHYVBD (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 17:01:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63809 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932319AbdHYVBD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 17:01:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D360E9BFB8;
        Fri, 25 Aug 2017 17:01:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=gQyOmqoOoSq5
        FkzdsI+6tIMuUvY=; b=f4F7VvrNu8PABaPeGxhq5c2hk+umRNYUlLZMKG3rbQkE
        R/CQYzN1cgVbZ2i+c7MDQdPZCoOfvu6ijxhprKqX1X+vLBQ1nsO+DuaZvT0BVlei
        QjMigFX//kfPAKJQK2LWzNddlLjNa84oAeIFzlc/eXajJbdA4GB31fpsSF4rFrA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=B4jDRm
        lpVvLu+FPUydeA7n8Q9Wytaq300Wmt4xVIUzjpcc5CQQkW2CwLjF/GcPyqxhjEwE
        HPJ3EkNlxauF35ZL+5HVy8RPce/FUiGqwKJ75fNqlflU3N24EiwYd4NyxiII7+R7
        gnoLZ+5KP9ZH0L8ZesSyxXJcQftsjvjSfFwzk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D0A79BFB5;
        Fri, 25 Aug 2017 17:01:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 152619BFB2;
        Fri, 25 Aug 2017 17:01:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/2] refs/files-backend: duplicate strings added to affected_refnames
References: <40c5e954dd84ff42552bccfea00144eecdbd1c7e.1503496797.git.martin.agren@gmail.com>
Date:   Fri, 25 Aug 2017 14:00:58 -0700
In-Reply-To: <40c5e954dd84ff42552bccfea00144eecdbd1c7e.1503496797.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Fri, 25 Aug 2017 20:49:15
 +0200")
Message-ID: <xmqq8ti7s6ph.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7F605A3E-89D8-11E7-A588-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> files_transaction_prepare() and the functions it calls add strings to a
> string list without duplicating them, i.e., we keep the original raw
> pointers we were given. That is "ok", since we keep them only for a
> short-enough time, but we end up leaking some of them.

Sorry, but I do not understand this statement.  If affected_refnames
string list borrows strings from other structures who own them, and
none of these strings are freed by clearing affected_refnames list,
that is not "leaking"---we didn't acquire the ownership, so it is
not our job to free them in the first place.  Among the original
owners of strings we borrow from, some may not properly free, in
which case that is a leak.

What problem are you solving?

>
> Switch to duplicating the strings, so that affected_refnames does not
> leak memory. The original strings might still leak, but at least that
> can now be addressed without worrying about these pointers.
>
> No-one takes any pointers to the strings in the list (it is basically
> only used to check for set membership), so it is ok for
> string_list_clear to free them.
>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  refs/files-backend.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 5cca55510..22daca2ba 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2407,7 +2407,7 @@ static int files_transaction_prepare(struct ref_s=
tore *ref_store,
>  			       "ref_transaction_prepare");
>  	size_t i;
>  	int ret =3D 0;
> -	struct string_list affected_refnames =3D STRING_LIST_INIT_NODUP;
> +	struct string_list affected_refnames =3D STRING_LIST_INIT_DUP;
>  	char *head_ref =3D NULL;
>  	int head_type;
>  	struct object_id head_oid;
