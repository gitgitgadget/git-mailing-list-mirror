Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98749C433DB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 23:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63214619C0
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 23:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhC3X7G (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 19:59:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63110 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbhC3X6o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 19:58:44 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 93E3BB0C33;
        Tue, 30 Mar 2021 19:58:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=760oOgUGJdp4
        EZlwSJxmjTjdoM8=; b=sPK4bwoSBgJE7ijBGO9DSZ7UIaHmQI9OHnSR0J/eWw36
        GR3RYVTzdYlaGlh/FKGwbf7GxX44XSAtREl3V2ecU5cRkisyF7adeY9NY8Dja5Hv
        gyRI3qqyZ4LeLvoePlGvFmvYFG9dpt4RDfBscIdERjw/p+F57Lorfq2LT+Dyn5k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=C8bTe1
        HPo71jw/3XSuSCPBZ2uEUqdx/sEcU0McmRIdtONOwpQ7YdXttK+al1tYLFf3phL2
        tnXtEubqX8Z9MzmV4Ya+yr1nKq160/f4RpScxZKaXwgVcXMnj/J+3rTopoh4X8p2
        GvNZnZk0a5lTlthSqt5Tv9xYd1kVUJj0SvX80=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A8CBB0C32;
        Tue, 30 Mar 2021 19:58:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CE403B0C2F;
        Tue, 30 Mar 2021 19:58:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2 18/22] pickaxe -S: slightly optimize contains()
References: <20210203032811.14979-1-avarab@gmail.com>
        <20210216115801.4773-19-avarab@gmail.com>
Date:   Tue, 30 Mar 2021 16:58:42 -0700
In-Reply-To: <20210216115801.4773-19-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 16 Feb 2021 12:57:57 +0100")
Message-ID: <xmqqeefw9ost.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DB41B6D6-91B3-11EB-BBF2-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> When the "log -S<pat>" switch counts occurrences of <pat> on the
> pre-image and post-image of a change. As soon as we know we had e.g. 1
> before and 2 now we can stop, we don't need to keep counting past 2.

Logical.

I do not know how much difference this would make in practice,
though.  The performance characteristics between "diff A B"
and "diff B A" with the same pickaxe -Sneedle would be asymmetric
with this optimization, which is a bit curious (but not incorrect).

I wonder if there is a good heuristics to decide which, between one
and two, blob to start counting.  Obviously, scanning the one that
is likely to contain fewer occurrence of the needle, before we can
employ this optimization to the other side, is what we want.

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  diffcore-pickaxe.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
> index 66e34d254f1..76c178bae2b 100644
> --- a/diffcore-pickaxe.c
> +++ b/diffcore-pickaxe.c
> @@ -68,7 +68,8 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
>  	return ecbdata.hit;
>  }
> =20
> -static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kw=
s)
> +static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kw=
s,
> +			     unsigned int limit)
>  {
>  	unsigned int cnt =3D 0;
>  	unsigned long sz =3D mf->size;
> @@ -88,6 +89,9 @@ static unsigned int contains(mmfile_t *mf, regex_t *r=
egexp, kwset_t kws)
>  				sz--;
>  			}
>  			cnt++;
> +
> +			if (limit && cnt =3D=3D limit)
> +				return cnt;
>  		}
> =20
>  	} else { /* Classic exact string match */
> @@ -99,6 +103,9 @@ static unsigned int contains(mmfile_t *mf, regex_t *=
regexp, kwset_t kws)
>  			sz -=3D offset + kwsm.size[0];
>  			data +=3D offset + kwsm.size[0];
>  			cnt++;
> +
> +			if (limit && cnt =3D=3D limit)
> +				return cnt;
>  		}
>  	}
>  	return cnt;
> @@ -108,8 +115,8 @@ static int has_changes(mmfile_t *one, mmfile_t *two=
,
>  		       struct diff_options *o,
>  		       regex_t *regexp, kwset_t kws)
>  {
> -	unsigned int c1 =3D one ? contains(one, regexp, kws) : 0;
> -	unsigned int c2 =3D two ? contains(two, regexp, kws) : 0;
> +	unsigned int c1 =3D one ? contains(one, regexp, kws, 0) : 0;
> +	unsigned int c2 =3D two ? contains(two, regexp, kws, c1 + 1) : 0;
>  	return c1 !=3D c2;
>  }
