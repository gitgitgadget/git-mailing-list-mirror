From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 4/4] attr: avoid heavy work when we know the specified attr is not defined
Date: Tue, 09 Dec 2014 16:18:57 -0800
Message-ID: <xmqqsigojr0u.fsf@gitster.dls.corp.google.com>
References: <1418133205-18213-1-git-send-email-pclouds@gmail.com>
	<1418133205-18213-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 01:19:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyUzh-0005PC-S6
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 01:19:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbaLJATA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Dec 2014 19:19:00 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62508 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751587AbaLJATA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Dec 2014 19:19:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E3A425FFD;
	Tue,  9 Dec 2014 19:18:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0NLqLAdlItUh
	85GFg9SKRF8PXaw=; b=NE+eWe7X9X6AXOqgg3LQRaNDvOtIjDTLqhdXmkKM+GbX
	Qh6tW2idJaposJuiyUgKrDvlZdRtgLrif1GZEHbuccxrD2ObH1FFGkBGygdthyhR
	Jk2XdTh7lid4ygMlKo8uPa7yDvCtQnKYwT3UmkOuorEd368VG0NEFmqqxsVkVIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=f2QkWe
	89xVhD4p1i5Qtx4Thk3xCEvVM8FOiF+we218MLfT5zig1ekKCAA+5SFde4p/5P9k
	7zHfy0xHP8Tsyi2336YbkKBeqXWgYY3P2ORxxTSgZW+VEEwrWGMY56+3KPHgRiHu
	m88y6UBRhzc1/oy0AGYmrunxaXl9z4MXJbjC8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0501225FFC;
	Tue,  9 Dec 2014 19:18:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 81B8F25FFB;
	Tue,  9 Dec 2014 19:18:58 -0500 (EST)
In-Reply-To: <1418133205-18213-5-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 9 Dec
 2014 20:53:25 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 22851B5C-8002-11E4-B117-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261181>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +static void collect_selected_attrs(const char *path, int num,
> +				   struct git_attr_check *check)
> +{
> +	struct attr_stack *stk;
> +	int i, pathlen, rem, dirlen;
> +	int basename_offset;
> +
> +	pathlen =3D split_path(path, &dirlen, &basename_offset);
> +	prepare_attr_stack(path, dirlen);
> +	if (cannot_trust_maybe_real) {
> +		for (i =3D 0; i < git_attr_nr; i++)
> +			check_all_attr[i].value =3D ATTR__UNKNOWN;

Judging from the fact that

 (1) the only caller calls this function in this fashion based on the
     setting of "cannot-trust" bit,

 (2) this and the other function the only caller calls share the
     same code in their beginning part, and

 (3) the body of the if() statement here duplicates the code from
     collect_all_attrs(),

I smell that a much better split is possible.

Why isn't this all inside a single function collect_all_attrs()?
That single function may no longer be collect_ALL_attrs, so renaming
it to collect_attrs() is fine, but then that function may have this
if () to initialize all of them to ATTR__UNKNOWN or do the else part
we see below, and when organized that way we do not need to have
duplicated code (or split_path() helper function), no?

> +	} else {
> +		rem =3D num;
> +		for (i =3D 0; i < num; i++) {
> +			struct git_attr_check *c;
> +			c =3D check_all_attr + check[i].attr->attr_nr;
> +			if (check[i].attr->maybe_real)
> +				c->value =3D ATTR__UNKNOWN;
> +			else {
> +				c->value =3D ATTR__UNSET;
> +				rem--;
> +			}
> +		}
> +		if (!rem)
> +			return;
> +	}
> +	rem =3D git_attr_nr;
> +	for (stk =3D attr_stack; 0 < rem && stk; stk =3D stk->prev)
> +		rem =3D fill(path, pathlen, basename_offset, stk, rem);
> +}
> +
>  int git_check_attr(const char *path, int num, struct git_attr_check =
*check)
>  {
>  	int i;
> =20
> -	collect_all_attrs(path);
> +	if (cannot_trust_maybe_real)
> +		collect_all_attrs(path);
> +	else
> +		collect_selected_attrs(path, num, check);
> =20
>  	for (i =3D 0; i < num; i++) {
>  		const char *value =3D check_all_attr[check[i].attr->attr_nr].value=
;
