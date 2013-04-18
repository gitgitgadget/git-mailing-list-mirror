From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 07/13] utf8.c: add reencode_string_len() that can handle NULs in string
Date: Thu, 18 Apr 2013 10:25:57 -0700
Message-ID: <7vobdb7ntm.fsf@alter.siamese.dyndns.org>
References: <1364636112-15065-1-git-send-email-pclouds@gmail.com>
	<1366100702-31745-1-git-send-email-pclouds@gmail.com>
	<1366100702-31745-8-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 19:26:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USsb0-0006M0-Sd
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 19:26:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966834Ab3DRR0B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Apr 2013 13:26:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58338 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935970Ab3DRR0A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Apr 2013 13:26:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4F9D1717E;
	Thu, 18 Apr 2013 17:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=AN4qxCx5rzpQLi22qSPKOrclE
	a4=; b=LG5ll3WjYcMuHc/6A4uCJ9cSAEK9dLq0B0q/YxRX8Z8pA+Hl01gSdLYLc
	j4ODee0UwO8Jn3oncQ6FQx+EvLStLC/HbMlr+tGXTZbU5HaxDKV+l91TYaxwlMyS
	xoiShqnlZl+xBSQdvLJN8It6FtQbvNbxO7kEHBMeMSopjpwrgU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=GPL79w0cdVQS9r72hUq
	M/MGHp4C6D31GJSRrOV68Apfao52WdRcG63P2iv7+Qax2n8lMJi7T2sDDoDOKALp
	63fq//9Fn9QvGovuOQ1cvDzMQ8KTp9o5yJBtBZMX77w0KRhxDeWZchDcZPTjoBh8
	jhXt7h/Ro0lqCkb2NOlj9Tpc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C93EF1717D;
	Thu, 18 Apr 2013 17:25:59 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4128F1717B;
	Thu, 18 Apr 2013 17:25:59 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 09131860-A84D-11E2-8924-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221670>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/utf8.h b/utf8.h
> index d3da96f..a43ef9a 100644
> --- a/utf8.h
> +++ b/utf8.h
> @@ -17,12 +17,25 @@ void strbuf_add_wrapped_bytes(struct strbuf *buf,=
 const char *data, int len,
>  			     int indent, int indent2, int width);
> =20
>  #ifndef NO_ICONV
> -char *reencode_string_iconv(const char *in, size_t insz, iconv_t con=
v);
> -char *reencode_string(const char *in, const char *out_encoding, cons=
t char *in_encoding);
> +char *reencode_string_iconv(const char *in, size_t insz,
> +			    iconv_t conv, int *outsz);
> +char *reencode_string_len(const char *in, int insz,
> +			  const char *out_encoding,
> +			  const char *in_encoding,
> +			  int *outsz);
>  #else
> -#define reencode_string(a,b,c) NULL
> +#define reencode_string_len(a,b,c,d,e) NULL
>  #endif
> =20
> +static inline char *reencode_string(const char *in,
> +				    const char *out_encoding,
> +				    const char *in_encoding)
> +{
> +	return reencode_string_len(in, strlen(in),
> +				   out_encoding, in_encoding,
> +				   NULL);
> +}
> +
>  int mbs_chrlen(const char **text, size_t *remainder_p, const char *e=
ncoding);
> =20
>  #endif

Nicely done.
