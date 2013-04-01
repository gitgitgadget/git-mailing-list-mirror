From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/12] utf8.c: add utf8_strnwidth() with the ability
 to skip ansi sequences
Date: Mon, 01 Apr 2013 11:04:32 -0700
Message-ID: <7v8v52jff3.fsf@alter.siamese.dyndns.org>
References: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
 <1364636112-15065-1-git-send-email-pclouds@gmail.com>
 <1364636112-15065-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 01 20:05:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMj6O-0000Mz-LH
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 20:05:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757680Ab3DASEg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Apr 2013 14:04:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48158 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757246Ab3DASEf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Apr 2013 14:04:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28A6C116B4;
	Mon,  1 Apr 2013 18:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=61P9xhar3bK+
	fYtghA0qxijJikk=; b=OP148WqrTlJey5KLa8GyZW0pnA0sQGQ5KwHjqCKBncTq
	tSZkFoPecYMui9nxIIiztToyKeiRQZsURWIrnG4QwhTsnKIPO+1DogDjK42C3q9w
	ytzNaCdx+NU1h63CqlmX3enelpCsqBIXvkIGEPgo2YvYibOu610oZ2+4l+Q6T/M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=WjWBgY
	6oSkfrN0oYpNpZW1quVTwdkqkg67eP/86X2D0x1EQ8aCGOCI+ZGL4dzcSsJ5Ycmw
	/aMjwYb2Ndj9flxFzLHpwXZjXPie2F3fqB70AZqZ6vFrUpKvJUWPEjor6PX0eiT7
	51TMj4qRuygvEbXa9Tatogs+Lxnm2ndLedisg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 209EB116B3;
	Mon,  1 Apr 2013 18:04:34 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7EB15116B0; Mon,  1 Apr
 2013 18:04:33 +0000 (UTC)
In-Reply-To: <1364636112-15065-5-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 30 Mar
 2013 16:35:04 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9B74A3F4-9AF6-11E2-A200-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219696>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  utf8.c | 20 ++++++++++++++------
>  utf8.h |  1 +
>  2 files changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/utf8.c b/utf8.c
> index 82c2ddf..38322a1 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -266,18 +266,26 @@ int utf8_width(const char **start, size_t *rema=
inder_p)
>   * string, assuming that the string is utf8.  Returns strlen() inste=
ad
>   * if the string does not look like a valid utf8 string.
>   */
> -int utf8_strwidth(const char *string)
> +int utf8_strnwidth(const char *string, int len, int skip_ansi)
>  {
>  	int width =3D 0;
>  	const char *orig =3D string;
> =20
> -	while (1) {
> -		if (!string)
> -			return strlen(orig);
> -		if (!*string)
> -			return width;
> +	if (len =3D=3D -1)
> +		len =3D strlen(string);
> +	while (string && string < orig + len) {
> +		int skip;
> +		while (skip_ansi &&
> +		       (skip =3D display_mode_esc_sequence_len(string)))

We prefer to avoid assignment in conditionals; please write the
second as something like:

	((var =3D func(...)) !=3D 0)

to clarify that it is not a misspelled comparison.

> +			string +=3D skip;
>  		width +=3D utf8_width(&string, NULL);
>  	}
> +	return string ? width : len;
> +}
> +
> +int utf8_strwidth(const char *string)
> +{
> +	return utf8_strnwidth(string, -1, 0);
>  }
> =20
>  int is_utf8(const char *text)
> diff --git a/utf8.h b/utf8.h
> index 501b2bd..a556932 100644
> --- a/utf8.h
> +++ b/utf8.h
> @@ -4,6 +4,7 @@
>  typedef unsigned int ucs_char_t;  /* assuming 32bit int */
> =20
>  int utf8_width(const char **start, size_t *remainder_p);
> +int utf8_strnwidth(const char *string, int len, int skip_ansi);
>  int utf8_strwidth(const char *string);
>  int is_utf8(const char *text);
>  int is_encoding_utf8(const char *name);
