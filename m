Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14B8F1F43C
	for <e@80x24.org>; Sun, 12 Nov 2017 04:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751625AbdKLEpv (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Nov 2017 23:45:51 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51637 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751454AbdKLEpu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Nov 2017 23:45:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 52F2BA755F;
        Sat, 11 Nov 2017 23:45:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=E9ecAF3FBF6X
        gECUuSvkC0cplE4=; b=MOcCK1/ca/yXL3PB0W2F4F8BZZldyhpZKfwSGIwaKaJt
        mApcqpzesuJPD/CD3aAtluIkyDs0rUkQ+h7QjWfxExWJUlndyyI4RQFgTnzGaP1+
        cXGkMMRcRVkrGHVleYNkLrJwtMe/eJPvCaziZSvJXzQ4E/Aw5EB5wt+KLZeI+CM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=rmmpMz
        3ZdRftxsLh5uQtzrOnz5RmuorOsOgCXsWEm/XzArlnhywxmMxei3QjizQstGkHDt
        Df6Y52EmS7V/ZWKfMvpRvzNULHq1Rjj+OnKyGC0KkiSdYpEwW1dskeBKyeENcIEA
        30PqKJfcf2jnhDqFz98L5J8Za7EpTq7jshO9Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 497E7A755D;
        Sat, 11 Nov 2017 23:45:49 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A8FA8A755C;
        Sat, 11 Nov 2017 23:45:48 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     mqudsi@neosmart.net, git@vger.kernel.org,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] apply: avoid out-of-bounds access in fuzzy_matchlines()
References: <0101015f9c91871f-2f750aec-6877-4e29-9c15-c8399670dd48-000000@us-west-2.amazonses.com>
        <6ff27de7-ac22-3f2f-1f3b-2e0e6f10605a@web.de>
Date:   Sun, 12 Nov 2017 13:45:47 +0900
In-Reply-To: <6ff27de7-ac22-3f2f-1f3b-2e0e6f10605a@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 11 Nov 2017 15:10:19 +0100")
Message-ID: <xmqqinegcdfo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5A895C00-C764-11E7-AE0C-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> fuzzy_matchlines() uses a pointers to the first and last characters of
> two lines to keep track while matching them.  This makes it impossible
> to deal with empty strings.  It accesses characters before the start of
> empty lines.  It can also access characters after the end when checking
> for trailing whitespace in the main loop.
>
> Avoid that by using pointers to the first character and the one *after*
> the last one.  This is well-defined as long as the latter is not
> dereferenced.  Basically rewrite the function based on that premise; it
> becomes much simpler as a result.  There is no need to check for
> leading whitespace outside of the main loop anymore.

I recall vaguely that we were bitten by a bug or two due to another
instance of <begin,end> that deviates from the usual "close on the
left end, open on the right end" convention somewhere in the system
recently?

I think the fix of the function is correct, but at the same time, we
would want to clean it up after this fix lands by replacing the
function with the line comparison function we already have in the
xdiff/ layer, so that we can (1) reduce the code duplication and (2)
more importantly, do not have to be constrained by the (mistakenly
narrow) policy decision we currently seem to have to support only
"ignore-whitespace-change" and nothing else.  Of course, that should
not be done as part of this fix.  It is strictly a #leftoverbits item.

Thanks.

> Reported-by: Mahmoud Al-Qudsi <mqudsi@neosmart.net>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  apply.c | 59 ++++++++++++++++++++-------------------------------------=
--
>  1 file changed, 20 insertions(+), 39 deletions(-)
>
> diff --git a/apply.c b/apply.c
> index d676debd59..b8087bd29c 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -300,52 +300,33 @@ static uint32_t hash_line(const char *cp, size_t =
len)
>  static int fuzzy_matchlines(const char *s1, size_t n1,
>  			    const char *s2, size_t n2)
>  {
> -	const char *last1 =3D s1 + n1 - 1;
> -	const char *last2 =3D s2 + n2 - 1;
> -	int result =3D 0;
> +	const char *end1 =3D s1 + n1;
> +	const char *end2 =3D s2 + n2;
> =20
>  	/* ignore line endings */
> -	while ((*last1 =3D=3D '\r') || (*last1 =3D=3D '\n'))
> -		last1--;
> -	while ((*last2 =3D=3D '\r') || (*last2 =3D=3D '\n'))
> -		last2--;
> -
> -	/* skip leading whitespaces, if both begin with whitespace */
> -	if (s1 <=3D last1 && s2 <=3D last2 && isspace(*s1) && isspace(*s2)) {
> -		while (isspace(*s1) && (s1 <=3D last1))
> -			s1++;
> -		while (isspace(*s2) && (s2 <=3D last2))
> -			s2++;
> -	}
> -	/* early return if both lines are empty */
> -	if ((s1 > last1) && (s2 > last2))
> -		return 1;
> -	while (!result) {
> -		result =3D *s1++ - *s2++;
> -		/*
> -		 * Skip whitespace inside. We check for whitespace on
> -		 * both buffers because we don't want "a b" to match
> -		 * "ab"
> -		 */
> -		if (isspace(*s1) && isspace(*s2)) {
> -			while (isspace(*s1) && s1 <=3D last1)
> +	while (s1 < end1 && (end1[-1] =3D=3D '\r' || end1[-1] =3D=3D '\n'))
> +		end1--;
> +	while (s2 < end2 && (end2[-1] =3D=3D '\r' || end2[-1] =3D=3D '\n'))
> +		end2--;
> +
> +	while (s1 < end1 && s2 < end2) {
> +		if (isspace(*s1)) {
> +			/*
> +			 * Skip whitespace. We check on both buffers
> +			 * because we don't want "a b" to match "ab".
> +			 */
> +			if (!isspace(*s2))
> +				return 0;
> +			while (s1 < end1 && isspace(*s1))
>  				s1++;
> -			while (isspace(*s2) && s2 <=3D last2)
> +			while (s2 < end2 && isspace(*s2))
>  				s2++;
> -		}
> -		/*
> -		 * If we reached the end on one side only,
> -		 * lines don't match
> -		 */
> -		if (
> -		    ((s2 > last2) && (s1 <=3D last1)) ||
> -		    ((s1 > last1) && (s2 <=3D last2)))
> +		} else if (*s1++ !=3D *s2++)
>  			return 0;
> -		if ((s1 > last1) && (s2 > last2))
> -			break;
>  	}
> =20
> -	return !result;
> +	/* If we reached the end on one side only, lines don't match. */
> +	return s1 =3D=3D end1 && s2 =3D=3D end2;
>  }
> =20
>  static void add_line_info(struct image *img, const char *bol, size_t l=
en, unsigned flag)
