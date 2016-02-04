From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/25] transport-helper.c: refactor set_helper_option()
Date: Thu, 04 Feb 2016 15:18:10 -0800
Message-ID: <xmqqlh70f4jx.fsf@gitster.mtv.corp.google.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
	<1454576641-29615-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 00:18:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRTAN-0002Pw-7s
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 00:18:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932646AbcBDXSS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 18:18:18 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55326 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752884AbcBDXSR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Feb 2016 18:18:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E5DEA41B4C;
	Thu,  4 Feb 2016 18:18:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/GEP/D4tMx6p
	qy9XnNS+n+ZgsWU=; b=EbbBnXSHK7JUnrkVTfpcrzggYYPsEKLSsuLOdzBGcDgJ
	Q1wx70C1Uq1Mvh7Tw6xTFYqGM6OD4HtrcMwh01swGdwxoCML/Nn5SVP9pcJTWBDJ
	1py1Ghte3f3qATDU5ytbSoWD9pDtZnPrUO76ZZeUQqRrHTtHvhpCbY5eO2koe6s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=a8sPk+
	MvzwlRrdOVzjTQtSfdKJbmWcyqvcv5bayM7BrkEMVVpySYyzZWYGBP51g1K2Trkx
	l/dY4fsDV3tV2Ag6XTViRqnY/XA91UgQWqVCbmb5gP5HvVp8d/A8dZ9QwME1TmwS
	JEHUxvulwLdhDoNKStP7d1UjMYFcPDm9zaYRE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D26B641B4B;
	Thu,  4 Feb 2016 18:18:11 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5564141B48;
	Thu,  4 Feb 2016 18:18:11 -0500 (EST)
In-Reply-To: <1454576641-29615-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 4 Feb
 2016 16:03:38 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8EF481BC-CB95-11E5-BAB7-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285516>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

Just like other patches, this is thin on the rationale.  You are
planning to invent another function that prepares the requrest in a
strbuf and allow it to call this helper to perform a single round
trip with the other side?  If that is the case, the split is very
sensible, but you need to say something about "why".

>  transport-helper.c | 37 +++++++++++++++++++++++--------------
>  1 file changed, 23 insertions(+), 14 deletions(-)
>
> diff --git a/transport-helper.c b/transport-helper.c
> index a6bff8b..35023da 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -260,6 +260,28 @@ static const char *boolean_options[] =3D {
>  	TRANS_OPT_FOLLOWTAGS,
>  	};
> =20
> +static int strbuf_set_helper_option(struct helper_data *data,
> +				    struct strbuf *buf)
> +{
> +	int ret;
> +
> +	sendline(data, buf);
> +	if (recvline(data, buf))
> +		exit(128);
> +
> +	if (!strcmp(buf->buf, "ok"))
> +		ret =3D 0;
> +	else if (starts_with(buf->buf, "error")) {
> +		ret =3D -1;
> +	} else if (!strcmp(buf->buf, "unsupported"))
> +		ret =3D 1;
> +	else {
> +		warning("%s unexpectedly said: '%s'", data->name, buf->buf);
> +		ret =3D 1;
> +	}
> +	return ret;
> +}
> +
>  static int set_helper_option(struct transport *transport,
>  			  const char *name, const char *value)
>  {
> @@ -291,20 +313,7 @@ static int set_helper_option(struct transport *t=
ransport,
>  		quote_c_style(value, &buf, NULL, 0);
>  	strbuf_addch(&buf, '\n');
> =20
> -	sendline(data, &buf);
> -	if (recvline(data, &buf))
> -		exit(128);
> -
> -	if (!strcmp(buf.buf, "ok"))
> -		ret =3D 0;
> -	else if (starts_with(buf.buf, "error")) {
> -		ret =3D -1;
> -	} else if (!strcmp(buf.buf, "unsupported"))
> -		ret =3D 1;
> -	else {
> -		warning("%s unexpectedly said: '%s'", data->name, buf.buf);
> -		ret =3D 1;
> -	}
> +	ret =3D strbuf_set_helper_option(data, &buf);
>  	strbuf_release(&buf);
>  	return ret;
>  }
