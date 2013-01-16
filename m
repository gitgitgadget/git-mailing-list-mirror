From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] attr: fix off-by-one directory component length
 calculation
Date: Wed, 16 Jan 2013 11:07:44 -0800
Message-ID: <7vzk09vtdr.fsf@alter.siamese.dyndns.org>
References: <1358256924-31578-1-git-send-email-pclouds@gmail.com>
 <201301152014.28433.avila.jn@gmail.com>
 <7vwqve2qk3.fsf@alter.siamese.dyndns.org>
 <CACsJy8Bn4GKJzi4n5cMPp+26dovT795nUqcXGNLgapf+r_PFCw@mail.gmail.com>
 <20130116020901.GA1041@duynguyen-vnpc.dek-tpc.internal>
 <7vbocp26xa.fsf@alter.siamese.dyndns.org>
 <CACsJy8C2uEgwozpWBfowYJea3XRB72rhzjsSFuG9Ud0afuQy6w@mail.gmail.com>
 <7vtxqhzo4m.fsf@alter.siamese.dyndns.org>
 <20130116060238.GA29523@duynguyen-vnpc.dek-tpc.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>,
	git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 20:08:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvYLK-00031M-J7
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 20:08:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756691Ab3APTHu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Jan 2013 14:07:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33575 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756133Ab3APTHt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2013 14:07:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52B28CAF1;
	Wed, 16 Jan 2013 14:07:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5ofrt61jT3g1
	+h3MpLHMGDK8eYU=; b=BE2BVSe70RdiLemrg6w1+pCB2MoeXBEApE6Btu3eGrR0
	ftVn8BP1erKqFfT8PkJzC3DaEXXarW0gJt1le4j3tSZvp16GR3XyO4s2Yi67uI7e
	KTRb/fFA7vHNkwBr/pivRdwS9VyVh2FDeQ5U03Zz7/4xQX9chWcOy116CjK/Sp0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xrfEz/
	U6DSnQKeM4e61Kn1rNFbwIS5RMvdv0XRqBI2+gcuS1OOzqi0q0N6PliqFbYKv02u
	a+jOKi3Z8Im3HvDg0Kr+Y+HPmDC4iCZvT/9aOTLhqg4P2ZPr8Ge1c731FZ7OHSnm
	AElpBxvlWlytaV3aXpJenskT2+N+YWZXoPqI8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 46A9CCAEF;
	Wed, 16 Jan 2013 14:07:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8076ACAE2; Wed, 16 Jan 2013
 14:07:46 -0500 (EST)
In-Reply-To: <20130116060238.GA29523@duynguyen-vnpc.dek-tpc.internal> (Duy
 Nguyen's message of "Wed, 16 Jan 2013 13:02:38 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 03E10828-6010-11E2-9E15-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213801>

Duy Nguyen <pclouds@gmail.com> writes:

> OK I get your point now. Something like this?
>
> -- 8< --
> Subject: [PATCH] attr: avoid calling find_basename() twice per path
>
> find_basename() is only used inside collect_all_attrs(), called once
> in prepare_attr_stack, then again after prepare_attr_stack()
> returns. Both calls return exact same value. Reorder the code to do
> the same task once. Also avoid strlen() because we knows the length
> after finding basename.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

Yeah, I think this is a nice code reduction, readability improvement
and micro optimization rolled into one.

>  attr.c | 45 ++++++++++++++++++---------------------------
>  1 file changed, 18 insertions(+), 27 deletions(-)
>
> diff --git a/attr.c b/attr.c
> index cfc6748..880f862 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -564,32 +564,12 @@ static void bootstrap_attr_stack(void)
>  	attr_stack =3D elem;
>  }
> =20
> -static const char *find_basename(const char *path)
> -{
> -	const char *cp, *last_slash =3D NULL;
> -
> -	for (cp =3D path; *cp; cp++) {
> -		if (*cp =3D=3D '/' && cp[1])
> -			last_slash =3D cp;
> -	}
> -	return last_slash ? last_slash + 1 : path;
> -}
> -
> -static void prepare_attr_stack(const char *path)
> +static void prepare_attr_stack(const char *path, int dirlen)
>  {
>  	struct attr_stack *elem, *info;
> -	int dirlen, len;
> +	int len;
>  	const char *cp;
> =20
> -	dirlen =3D find_basename(path) - path;
> -
> -	/*
> -	 * find_basename() includes the trailing slash, but we do
> -	 * _not_ want it.
> -	 */
> -	if (dirlen)
> -		dirlen--;
> -
>  	/*
>  	 * At the bottom of the attribute stack is the built-in
>  	 * set of attribute definitions, followed by the contents
> @@ -769,15 +749,26 @@ static int macroexpand_one(int attr_nr, int rem=
)
>  static void collect_all_attrs(const char *path)
>  {
>  	struct attr_stack *stk;
> -	int i, pathlen, rem;
> -	const char *basename;
> +	int i, pathlen, rem, dirlen;
> +	const char *basename, *cp, *last_slash =3D NULL;
> +
> +	for (cp =3D path; *cp; cp++) {
> +		if (*cp =3D=3D '/' && cp[1])
> +			last_slash =3D cp;
> +	}
> +	pathlen =3D cp - path;
> +	if (last_slash) {
> +		basename =3D last_slash + 1;
> +		dirlen =3D last_slash - path;
> +	} else {
> +		basename =3D path;
> +		dirlen =3D 0;
> +	}
> =20
> -	prepare_attr_stack(path);
> +	prepare_attr_stack(path, dirlen);
>  	for (i =3D 0; i < attr_nr; i++)
>  		check_all_attr[i].value =3D ATTR__UNKNOWN;
> =20
> -	basename =3D find_basename(path);
> -	pathlen =3D strlen(path);
>  	rem =3D attr_nr;
>  	for (stk =3D attr_stack; 0 < rem && stk; stk =3D stk->prev)
>  		rem =3D fill(path, pathlen, basename, stk, rem);
