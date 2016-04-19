From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] http.c: implements the GIT_TRACE_CURL environment variable
Date: Tue, 19 Apr 2016 13:24:38 -0700
Message-ID: <xmqqy489z6rd.fsf@gitster.mtv.corp.google.com>
References: <20160419151044.27814-1-gitter.spiros@gmail.com>
	<20160419151044.27814-3-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, tboegi@web.de, ramsay@ramsayjones.plus.com,
	sunshine@sunshineco.com, peff@peff.net
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 22:24:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ascCV-0006YA-6U
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 22:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754511AbcDSUYn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Apr 2016 16:24:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55717 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753839AbcDSUYm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2016 16:24:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 69ECF12E48;
	Tue, 19 Apr 2016 16:24:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2Pc8haIcpFTw
	fGz98Ze6+pWQ1J0=; b=xw0/6lrTXpoZNqPQTA1nzkG6OC8MKbKVbeFKUml2eZno
	AuPM2W8vRo8+ud3BM8zTlRKZn4CB7eQDeDjKoL9+ODMMGPJ0oPE3K89aUlXL25oV
	P7FATz8Oy3OrEGrM6eMcwK+vg0QGMhNFZwctrAhZWvXF9cycS18tawrWxVO9YSo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=GVhggO
	FAoe5zTNtgPc1eK0JwR8mUDSYJ59tLolwbkHSQDMbyoemks0AV5Mhy80Mh6sGIU1
	STKKGNDiwJa/T6nhHqfgOR/7Qmu6yk0M9zzgTxdzp+QDCiMf83is78nbAdDz2nri
	x0VTjkN8IyFlrds6QWeuMGHvnadg3bNCm66gc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 60FC712E47;
	Tue, 19 Apr 2016 16:24:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B5DFD12E45;
	Tue, 19 Apr 2016 16:24:39 -0400 (EDT)
In-Reply-To: <20160419151044.27814-3-gitter.spiros@gmail.com> (Elia Pinto's
	message of "Tue, 19 Apr 2016 15:10:42 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BE22F7FE-066C-11E6-BF52-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291920>

Elia Pinto <gitter.spiros@gmail.com> writes:

> Implements the GIT_TRACE_CURL environment variable to allow a
> greater degree of detail of GIT_CURL_VERBOSE, in particular
> the complete transport header and all the data payload exchanged.
> It might be useful if a particular situation could require a more
> thorough debugging analysis
>
>
> Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>=20
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  http.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++-
>  1 file changed, 97 insertions(+), 1 deletion(-)
>
> diff --git a/http.c b/http.c
> index 4304b80..278991e 100644
> --- a/http.c
> +++ b/http.c
> @@ -11,6 +11,9 @@
>  #include "gettext.h"
>  #include "transport.h"
> =20
> +/*
> +tatic struct trace_key trace_curl =3D TRACE_KEY_INIT(CURL);
> +*/
>  #if LIBCURL_VERSION_NUM >=3D 0x070a08
>  long int git_curl_ipresolve =3D CURL_IPRESOLVE_WHATEVER;
>  #else
> @@ -464,6 +467,95 @@ static void set_curl_keepalive(CURL *c)
>  }
>  #endif
> =20
> +
> +void curl_dump(const char *text, unsigned char *ptr, size_t size, ch=
ar nohex)
> +{
> +	size_t i;
> +	size_t w;
> +	struct strbuf out =3D STRBUF_INIT;;

;; makes the next line decl-after-stmt.

> +
> +	unsigned int width =3D 0x10;




> +
> +	if (nohex)
> +		/* without the hex output, we can fit more on screen */
> +		width =3D 0x40;
> +
> +	strbuf_addf(&out, "%s, %10.10ld bytes (0x%8.8lx)\n",
> +		text, (long)size, (long)size);
> +
> +	for (i =3D 0; i < size; i +=3D width) {
> +
> +		strbuf_addf(&out, "%4.4lx: ", (long)i);
> +
> +		if (!nohex) {
> +			/* hex not disabled, show it */
> +			for (w =3D 0; w < width; w++)
> +				if (i + w < size)
> +					strbuf_addf(&out, "%02x ", ptr[i + w]);
> +				else
> +					strbuf_addf(&out,"   ");
> +		}
> +
> +		for (w =3D 0; (w < width) && (i + w < size); w++) {
> +			/* check for 0D0A; if found, skip past and start a new line of ou=
tput */
> +			if (nohex && (i + w + 1 < size) && ptr[i + w] =3D=3D '\r'
> +			    && ptr[i + w + 1] =3D=3D '\n') {
> +				i +=3D (w + 2 - width);
> +				break;
> +			}
> +			strbuf_addch(&out, (ptr[i + w] >=3D 0x20)
> +				&& (ptr[i + w] < 0x80) ? ptr[i + w] : '.');
> +			/* check again for 0D0A, to avoid an extra \n if it's at width */
> +			if (nohex && (i + w + 2 < size)
> +			    && ptr[i + w + 1] =3D=3D '\r'
> +			    && ptr[i + w + 2] =3D=3D '\n') {
> +				i +=3D (w + 3 - width);
> +				break;
> +			}
> +		}
> +		strbuf_addch(&out, '\n');
> +		trace_strbuf(&trace_curl, &out);
> +		strbuf_release(&out);
> +	}
> +}
> +
> +int curl_trace(CURL *handle, curl_infotype type,
> +	     char *data, size_t size, void *userp)
> +{
> +	const char *text;
> +	(void)handle;		/* prevent compiler warning */
> +
> +	switch (type) {
> +	case CURLINFO_TEXT:
> +		trace_printf_key(&trace_curl, "=3D=3D Info: %s", data);
> +	default:		/* in case a new one is introduced to shock us */
> +		return 0;
> +
> +	case CURLINFO_HEADER_OUT:
> +		text =3D "=3D> Send header";
> +		break;
> +	case CURLINFO_DATA_OUT:
> +		text =3D "=3D> Send data";
> +		break;
> +	case CURLINFO_SSL_DATA_OUT:
> +		text =3D "=3D> Send SSL data";
> +		break;
> +	case CURLINFO_HEADER_IN:
> +		text =3D "<=3D Recv header";
> +		break;
> +	case CURLINFO_DATA_IN:
> +		text =3D "<=3D Recv data";
> +		break;
> +	case CURLINFO_SSL_DATA_IN:
> +		text =3D "<=3D Recv SSL data";
> +		break;
> +	}
> +
> +	curl_dump(text, (unsigned char *)data, size, 1);
> +	return 0;
> +}
> +
> +
>  static CURL *get_curl_handle(void)
>  {
>  	CURL *result =3D curl_easy_init();
> @@ -563,7 +655,11 @@ static CURL *get_curl_handle(void)
>  			"your curl version is too old (>=3D 7.19.4)");
>  #endif
> =20
> -	if (getenv("GIT_CURL_VERBOSE"))
> +	if (trace_want(&trace_curl)) {
> +		curl_easy_setopt(result, CURLOPT_VERBOSE, 1L);
> +		curl_easy_setopt(result, CURLOPT_DEBUGFUNCTION, curl_trace);
> +		curl_easy_setopt(result, CURLOPT_DEBUGDATA, NULL);
> +	} else if (getenv("GIT_CURL_VERBOSE"))
>  		curl_easy_setopt(result, CURLOPT_VERBOSE, 1);
> =20
>  	curl_easy_setopt(result, CURLOPT_USERAGENT,
