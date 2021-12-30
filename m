Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8834CC433EF
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 21:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242190AbhL3Vno (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 16:43:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54821 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237603AbhL3Vnn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 16:43:43 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0680D10EAAC;
        Thu, 30 Dec 2021 16:43:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lBCpXmDe5LA0
        Jop5CDzFNHQsFlSOOAgI4w4AApHUIQs=; b=HqUyycocB7jWT1pU2XR+POa60Osk
        2MU53YkOtHSWDgtkRtLs6KQrI4ivNTYRB87u9whY0cTWPdOYbYS8tSIN61FU3/bh
        5clUBVH4Dex/Dcvc0oWfZvvv4mVsVNUvShu7FlbFQWPSPJ6UZIWa1gIfgPjEmO70
        yBVrs0pb+wnf6/Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F0CCE10EAAB;
        Thu, 30 Dec 2021 16:43:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5CA3210EAA6;
        Thu, 30 Dec 2021 16:43:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v6 4/6] object-name: show date for ambiguous tag objects
References: <cover-v5-0.6-00000000000-20211125T215529Z-avarab@gmail.com>
        <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com>
        <patch-v6-4.6-b5aa6e266f6-20211228T143223Z-avarab@gmail.com>
Date:   Thu, 30 Dec 2021 13:43:41 -0800
In-Reply-To: <patch-v6-4.6-b5aa6e266f6-20211228T143223Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 28 Dec
 2021 15:35:00
        +0100")
Message-ID: <xmqqv8z5py42.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8E99C498-69B9-11EC-99BE-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/object-name.c b/object-name.c
> index dcf3ab99990..990f384129e 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -403,21 +403,26 @@ static int show_ambiguous_object(const struct obj=
ect_id *oid, void *data)
>  	} else if (type =3D=3D OBJ_TAG) {
>  		struct tag *tag =3D lookup_tag(ds->repo, oid);
>  		const char *tag_tag =3D "";
> +		timestamp_t tag_date =3D 0;
> =20
> -		if (!parse_tag(tag) && tag->tag)
> +		if (!parse_tag(tag) && tag->tag) {
>  			tag_tag =3D tag->tag;
> +			tag_date =3D tag->date;
> +		}
> =20
>  		/*
>  		 * TRANSLATORS: This is a line of
>  		 * ambiguous tag object output. E.g.:
>  		 *
> -		 *    "deadbeef tag Some Tag Message"
> +		 *    "deadbeef tag 2021-01-01 - Some Tag Message"
>  		 *
>  		 * The second argument is the "tag" string from
>  		 * object.c, it should (hopefully) already be
>  		 * translated.
>  		 */
> -		strbuf_addf(&desc, _("%s tag %s"), hash, tag_tag);
> +		strbuf_addf(&desc, _("%s tag %s - %s"), hash,
> +			    show_date(tag_date, 0, DATE_MODE(SHORT)),
> +			    tag_tag);

So, when parse_tag() errors out, we show "" and epoch?  We should be
able to do a better error reporting than that; tag_tag and tag_date
are both local and they do not have to be used to store sentinel values
like that.  Instead perhaps remember that we failed to parse_tag(),
and _omit_ unavailable piece of information from the output?  I dunno.

>  	} else if (type =3D=3D OBJ_TREE) {
>  		/*
>  		 * TRANSLATORS: This is a line of ambiguous <type>
