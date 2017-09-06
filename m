Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53F15208E3
	for <e@80x24.org>; Wed,  6 Sep 2017 01:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753658AbdIFB0e (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 21:26:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54678 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752609AbdIFB0d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 21:26:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 25EAE95515;
        Tue,  5 Sep 2017 21:26:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=uxUAx5PSI8pzg5VZBeXfycpJG
        fE=; b=XDPdicPzCyaoak28OF+kFyeTQ13bAxWrPl034du9Qumk2oROPbz4ZGNst
        Ur05SWDVZogXbPIZeA555TFJtfh/GXmkt3XscZUE5yZSMWW2WlvEX07K3HQVxoAh
        nL1UmAxCl2KfDw7voWISEmgVpxUyV0pe7YBcpqAZQxhrDm1URA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=rRBhtWn7B17Mm0sV69D
        zoXp9bygCxqyXTY3yTKGVextu0EPZoGag0D0vU95mwuUG6Yt6eLELPzGqLjVeMmn
        Z02mKIQMnMIDohacDM599YmdhBkL18EQ4t7zJthk8AtE0mIo5ChBryLK8GzaD/4C
        jVu0PhbpPrky/+BQRryutUQc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B9E395514;
        Tue,  5 Sep 2017 21:26:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7A19095513;
        Tue,  5 Sep 2017 21:26:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        "brian m. carlson" <sandals@crustytoothpaste.ath.cx>
Subject: Re: [PATCH] refs: make sure we never pass NULL to hashcpy
References: <20170904200504.15249-1-t.gummerer@gmail.com>
Date:   Wed, 06 Sep 2017 10:26:31 +0900
Message-ID: <xmqqh8wgaa7s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6A613C8E-92A2-11E7-AFF6-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> gcc on arch linux (version 7.1.1) warns that a NULL argument is passed
> as the second parameter of memcpy.
>
> In file included from refs.c:5:0:
> refs.c: In function =E2=80=98ref_transaction_verify=E2=80=99:
> cache.h:948:2: error: argument 2 null where non-null expected [-Werror=3D=
nonnull]
>   memcpy(sha_dst, sha_src, GIT_SHA1_RAWSZ);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from git-compat-util.h:165:0,
>                  from cache.h:4,
>                  from refs.c:5:
> /usr/include/string.h:43:14: note: in a call to function =E2=80=98memcp=
y=E2=80=99 declared here
>  extern void *memcpy (void *__restrict __dest, const void *__restrict _=
_src,
>               ^~~~~~
> ...
> diff --git a/refs.c b/refs.c
> index ba22f4acef..d8c12a9c44 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -896,10 +896,14 @@ struct ref_update *ref_transaction_add_update(
> =20
>  	update->flags =3D flags;
> =20
> -	if (flags & REF_HAVE_NEW)
> +	if (flags & REF_HAVE_NEW) {
> +		assert(new_sha1);
>  		hashcpy(update->new_oid.hash, new_sha1);
> -	if (flags & REF_HAVE_OLD)
> +	}
> +	if (flags & REF_HAVE_OLD) {
> +		assert(old_sha1);
>  		hashcpy(update->old_oid.hash, old_sha1);
> +	}

It is hugely annoying to see a halfway-intelligent compiler forces
you to add such pointless asserts.

The only way the compiler could error on this is by inferring the
fact that new_sha1/old_sha1 could be NULL by looking at the callsite
in ref_transaction_update() where these are used as conditionals to
set HAVE_NEW/HAVE_OLD that are passed.  Even if the compiler were
doing the whole-program analysis, the other two callsites of the
function pass the address of oid.hash[] in an oid structure so it
should know these won't be NULL.

Or is the compiler being really dumb and triggering an error for
every use of

	memcpy(dst, src, size);

that must now be written as

	assert(src);
	memcpy(dst, src, size);

???  That would be doubly annoying.

I wonder if REF_HAVE_NEW/REF_HAVE_OLD are really needed in these
codepaths, though.  Perhaps we can instead declare !!new_sha1 means
we have the new side and rewrite the above part to

	if (new_sha1)
		hashcpy(update->new_oid.hash, new_sha1);

without an extra and totally pointless assert()?

>  	update->msg =3D xstrdup_or_null(msg);
>  	return update;
>  }
