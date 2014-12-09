From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 3/4] attr: do not attempt to expand when we know it's not a macro
Date: Tue, 09 Dec 2014 15:56:04 -0800
Message-ID: <xmqqwq60js2z.fsf@gitster.dls.corp.google.com>
References: <1418133205-18213-1-git-send-email-pclouds@gmail.com>
	<1418133205-18213-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 00:56:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyUdZ-0004c0-BG
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 00:56:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbaLIX4I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Dec 2014 18:56:08 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59145 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751321AbaLIX4H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Dec 2014 18:56:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B5E825A6E;
	Tue,  9 Dec 2014 18:56:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=dnt756hEoLN7
	Rt99DCldOWzEC0k=; b=KLqmss1VaZYti72mdGtiBUb+/sE5bjSFHfNMemRfZ9eK
	erxNaVD2bcmBeH/du46il3sWA2GoZ9Ps+gJUKHZHMpyCqO/wvC0huihU6dIwTXRI
	FRh0t9UK55bsmkUSV/hiul0rNSJi7QGqmiJrDfNf6bMuu8CPrxlu2eKqPP3FBrE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=YWpSDZ
	W2gx4kmoRkQl6U7qp0z+jlf/V+OSMVhsFl0QQ+k2h2zgossKBE5r1Gfd2WDwsqgQ
	Mqt9EepUYN3U/2Gg6h2CEBjWZblQnnL8+N16ZVdbS2q+/wlzx5PggzsJBeToop+F
	0g8qSRgZQdc/9AHlYC5ibLPKe02UjhQae1fnM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F2BF425A6D;
	Tue,  9 Dec 2014 18:56:05 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 738B225A6C;
	Tue,  9 Dec 2014 18:56:05 -0500 (EST)
In-Reply-To: <1418133205-18213-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 9 Dec
 2014 20:53:24 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F01E36CE-7FFE-11E4-88BE-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261180>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Keep track of all recognized macros in the new "maybe_macro" field.
> This this field is true, it _may_ be a macro (depending on what's in
> the current attr stack). But if the field is false, it's definitely
> not a macro, no need to go through the whole attr stack in
> macroexpand_one() to search for one.
>
> Without this, "git grep abcdefghi" on git.git hits the inner loop in
> macroexpand_one() about 2500 times. With this, it's about 60 times.

Nice ;-)

>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  attr.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/attr.c b/attr.c
> index def09c7..4ec6186 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -32,6 +32,7 @@ struct git_attr {
>  	struct git_attr *next;
>  	unsigned h;
>  	int attr_nr;
> +	int maybe_macro;
>  	char name[FLEX_ARRAY];
>  };
>  static int git_attr_nr;
> @@ -95,6 +96,7 @@ static struct git_attr *git_attr_internal(const cha=
r *name, int len)
>  	a->h =3D hval;
>  	a->next =3D git_attr_hash[pos];
>  	a->attr_nr =3D git_attr_nr++;
> +	a->maybe_macro =3D 0;
>  	git_attr_hash[pos] =3D a;
> =20
>  	REALLOC_ARRAY(check_all_attr, git_attr_nr);
> @@ -244,9 +246,10 @@ static struct match_attr *parse_attr_line(const =
char *line, const char *src,
>  		      sizeof(*res) +
>  		      sizeof(struct attr_state) * num_attr +
>  		      (is_macro ? 0 : namelen + 1));
> -	if (is_macro)
> +	if (is_macro) {
>  		res->u.attr =3D git_attr_internal(name, namelen);
> -	else {
> +		res->u.attr->maybe_macro =3D 1;
> +	} else {
>  		char *p =3D (char *)&(res->state[num_attr]);
>  		memcpy(p, name, namelen);
>  		res->u.pat.pattern =3D p;
> @@ -687,7 +690,8 @@ static int macroexpand_one(int attr_nr, int rem)
>  	struct match_attr *a =3D NULL;
>  	int i;
> =20
> -	if (check_all_attr[attr_nr].value !=3D ATTR__TRUE)
> +	if (check_all_attr[attr_nr].value !=3D ATTR__TRUE ||
> +	    !check_all_attr[attr_nr].attr->maybe_macro)
>  		return rem;
> =20
>  	for (stk =3D attr_stack; !a && stk; stk =3D stk->prev)
