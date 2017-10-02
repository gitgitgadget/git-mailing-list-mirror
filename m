Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6696A202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 04:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbdJBEND (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 00:13:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58030 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751085AbdJBENC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 00:13:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 227CE93CFE;
        Mon,  2 Oct 2017 00:13:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jGMqQDefrJ/C
        CWRSOG+ESPGKI0E=; b=bPwlbWF58SDtZqeaR6JEj4efatT9+CU/6JF8WMbUNISq
        31Jm6n7vrSskCm5sCeDLdxyC9mm3nf7Kh9WzVNsyPlwr1WQrkmKzlw5CnLqDv/Sn
        aDyZekwkSWI45m1UzZshMg29Cvpxyck84s5bUmB8WZCCzkgOPF7luosSAGASXqw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=yPTBfn
        2l5HLiS1g1VC+Bhz87L0vH1pXDuqqBjq0z3X+8GYh50ukYdZzXDgPz9SRaXzYwmL
        iLv/0v36BRZKvfTrlAvNGbN7AznFfVA4p+OG3Ig9JAevHRM6pnZFKx2xhRMhbVbB
        iw+/41kds0n5gvvl/vgRZX6JxMMi3CwwPBVlU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A4D893CFD;
        Mon,  2 Oct 2017 00:13:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5CE0193CFA;
        Mon,  2 Oct 2017 00:13:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] tag: avoid NULL pointer arithmetic
References: <99e56671-bdf9-a59f-ae7b-758f1b7a8f14@web.de>
Date:   Mon, 02 Oct 2017 13:13:00 +0900
In-Reply-To: <99e56671-bdf9-a59f-ae7b-758f1b7a8f14@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 1 Oct 2017 16:45:13 +0200")
Message-ID: <xmqqwp4ep4qb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FAF4835C-A727-11E7-9DE5-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> lookup_blob() etc. can return NULL if the referenced object isn't of th=
e
> expected type.  In theory it's wrong to reference the object member in
> that case.  In practice it's OK because it's located at offset 0 for al=
l
> types, so the pointer arithmetic (NULL + 0) is optimized out by the
> compiler.  The issue is reported by Clang's AddressSanitizer, though.
>
> Avoid the ASan error by casting the results of the lookup functions to
> struct object pointers.  That works fine with NULL pointers as well.  W=
e
> already rely on the object member being first in all object types in
> other places in the code.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---

Yikes, that is tricky.

Taking the address of .object field appears to be a lot cleaner and
more kosher than casting, but from the compiler's point of view it's
quite the opposite.  Sigh.

Thanks.  The patch itself looks like the right solution to me.

>  tag.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tag.c b/tag.c
> index 7e10acfb6e..fcbe012f7a 100644
> --- a/tag.c
> +++ b/tag.c
> @@ -142,13 +142,13 @@ int parse_tag_buffer(struct tag *item, const void=
 *data, unsigned long size)
>  	bufptr =3D nl + 1;
> =20
>  	if (!strcmp(type, blob_type)) {
> -		item->tagged =3D &lookup_blob(&oid)->object;
> +		item->tagged =3D (struct object *)lookup_blob(&oid);
>  	} else if (!strcmp(type, tree_type)) {
> -		item->tagged =3D &lookup_tree(&oid)->object;
> +		item->tagged =3D (struct object *)lookup_tree(&oid);
>  	} else if (!strcmp(type, commit_type)) {
> -		item->tagged =3D &lookup_commit(&oid)->object;
> +		item->tagged =3D (struct object *)lookup_commit(&oid);
>  	} else if (!strcmp(type, tag_type)) {
> -		item->tagged =3D &lookup_tag(&oid)->object;
> +		item->tagged =3D (struct object *)lookup_tag(&oid);
>  	} else {
>  		error("Unknown type %s", type);
>  		item->tagged =3D NULL;
