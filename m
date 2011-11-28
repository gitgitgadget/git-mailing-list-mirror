From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Infinite loop in cascade_filter_fn()
Date: Mon, 28 Nov 2011 11:18:08 -0800
Message-ID: <7vobvwukcv.fsf@alter.siamese.dyndns.org>
References: <Pine.GSO.4.63.1111231801580.5099@shipon.roxen.com>
 <20111125153829.GB10417@beez.lab.cmartin.tk>
 <Pine.GSO.4.63.1111251705330.22588@shipon.roxen.com>
 <20111125170219.GD10417@beez.lab.cmartin.tk>
 <7vy5v2wleb.fsf@alter.siamese.dyndns.org>
 <20111128104812.GA2386@beez.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Henrik =?utf-8?Q?Grubbstr=C3=B6m?= <grubba@roxen.com>,
	Git Mailing list <git@vger.kernel.org>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Mon Nov 28 20:18:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RV6iW-00067t-Lu
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 20:18:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753228Ab1K1TSM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Nov 2011 14:18:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46881 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752056Ab1K1TSL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2011 14:18:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 810B85BC4;
	Mon, 28 Nov 2011 14:18:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=54pxw1mvH6o1
	DY29zE6A3Z4n5QE=; b=P9ZfZCyQFG3Bi33z2aiWSXlr34vp0yrjyTDuloJ/hPwl
	gEVoB6FK95ZAVZGhsOIcEYRZYPuAK4VsqAQKviPOSioYpRyqM+FNbM0Qb01Y9y9C
	drMWp8OkGK9SwZmmqieJnJBTt0mjMp0jj4pf2mblvaSVd1znlmruK58St21Ugms=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=onv4TK
	gvi9XJbpmeu0Z/UzhBLj0R7952I5b7uyZ0qIee3ktt9AvzmDPFr5pJM6rGIT/4sL
	N+JUlU2Zb5SVfERHaYTIanpyaBTt/wfDSTNT4vHCtmdAslZzFhBoX1wVl5czd0Qr
	Y/d94/nNPQ2B9cTFzO90QD2eV1ZvmgLnyY5Ug=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7839C5BC3;
	Mon, 28 Nov 2011 14:18:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD35F5BC2; Mon, 28 Nov 2011
 14:18:09 -0500 (EST)
In-Reply-To: <20111128104812.GA2386@beez.lab.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Mon, 28 Nov 2011 11:48:12
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B56A9562-19F5-11E1-86AB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186028>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

>> Content-Type: multipart/signed; micalg=3Dpgp-sha1; protocol=3D"appli=
cation/pgp-signature"; boundary=3D"M9NhX3UHpAaciwkO"
>> Content-Disposition: inline

Please do not do this. It makes it unnecessarily cumbersome to handle
patches without adding much value to the patch.

> --- 8< ---
> Subject: [PATCHv2] convert: track state in LF-to-CRLF filter
>
> There may not be enough space to store CRLF in the output. If we don'=
t
> fill the buffer, then the filter will keep getting called with the sa=
me
> short buffer and will loop forever.
>
> Instead, always store the CR and record whether there's a missing LF
> if so we store it in the output buffer the next time the function get=
s
> called.
>
> Reported-by: Henrik Grubbstr=C3=B6m <grubba@roxen.com>
> Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
> ---
>  convert.c |   50 +++++++++++++++++++++++++++++++++++++-------------
>  1 files changed, 37 insertions(+), 13 deletions(-)
>
> diff --git a/convert.c b/convert.c
> index 86e9c29..1c91409 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -876,24 +876,39 @@ int is_null_stream_filter(struct stream_filter =
*filter)
>  /*
>   * LF-to-CRLF filter
>   */
> +
> +struct lf_to_crlf_filter {
> +	struct stream_filter filter;
> +	int want_lf;
> +};
> +
>  static int lf_to_crlf_filter_fn(struct stream_filter *filter,
>  				const char *input, size_t *isize_p,
>  				char *output, size_t *osize_p)
>  {
> -	size_t count;
> +	size_t count, o =3D 0;
> +	struct lf_to_crlf_filter *lfcrlf =3D (struct lf_to_crlf_filter *) f=
ilter;
> ...
> -};
> +static struct stream_filter *lf_to_crlf_filter(void)
> +{
> +	struct lf_to_crlf_filter *lfcrlf =3D xmalloc(sizeof(*lfcrlf));
> =20
> +	lfcrlf->filter.vtbl =3D &lf_to_crlf_vtbl;
> +	lfcrlf->want_lf =3D 0;
> +	return (struct stream_filter *)lfcrlf;
> +}

Patch looks sane; you may want to rename the variable to lf_crlf at lea=
st,
though. The name does not consist of three tokens ("lf", "cr" and "lf")
but of two ("lf" and "crlf"), and your naming loses it.
