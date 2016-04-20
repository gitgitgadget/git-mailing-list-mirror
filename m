From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 3/3] http.c: implements the GIT_TRACE_CURL environment variable
Date: Wed, 20 Apr 2016 11:53:56 -0700
Message-ID: <xmqqzisoun5n.fsf@gitster.mtv.corp.google.com>
References: <20160420162825.62380-1-gitter.spiros@gmail.com>
	<20160420162825.62380-4-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, tboegi@web.de, ramsay@ramsayjones.plus.com,
	sunshine@sunshineco.com, peff@peff.net
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 20:54:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asxGI-0007AS-2p
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 20:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbcDTSyA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2016 14:54:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55039 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750850AbcDTSx7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2016 14:53:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E031D14DD8;
	Wed, 20 Apr 2016 14:53:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=MpptnzNHlCB4
	4sI1tlOkLyFwjpg=; b=wtsEZYYiSzN9oKxUJ1BPGwz1IW9fTKu1gjTdRl9kK5rQ
	0qt/KTWladOqTae6YGQmvd0W/sBDfxPKUrwPgZGLQ7V6n6w540W5yp5rZt7m0MrZ
	y3Y/QDa3P0Zvm44N0vqHWpnHoZd0XWTTEV0Q4Jk2nSsJKqsLcHndRLr7YsfhShU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=bdJUz7
	6lgQZYvFNWLvKEmjGkY39WotgJKMolaVagWF2pQ0vaQpwayoexNuOtqaVctoQMPi
	SRMorDvGU4yfh32wiM10AWd4ezY6NK/248TVgOLgXeGKe+w4TNnTaAetXRb5qk/+
	QtkM5lV64BhZRw0ahHluHbmYuN91V2+3WTIO8=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D60D614DD7;
	Wed, 20 Apr 2016 14:53:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1C09B14DD6;
	Wed, 20 Apr 2016 14:53:57 -0400 (EDT)
In-Reply-To: <20160420162825.62380-4-gitter.spiros@gmail.com> (Elia Pinto's
	message of "Wed, 20 Apr 2016 16:28:25 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3C870236-0729-11E6-93F2-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292055>

Elia Pinto <gitter.spiros@gmail.com> writes:

> Implements the GIT_TRACE_CURL environment variable to allow a

s/Implements/Implement/; speak as if you are giving an order to the
codebase to "be like so".

> greater degree of detail of GIT_CURL_VERBOSE, in particular
> the complete transport header and all the data payload exchanged.
> It might be useful if a particular situation could require a more
> thorough debugging analysis.
>
> Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  http.c | 101 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++-
>  http.h |   6 ++++
>  2 files changed, 106 insertions(+), 1 deletion(-)
>
> diff --git a/http.c b/http.c
> index 4304b80..507c386 100644
> --- a/http.c
> +++ b/http.c
> @@ -11,6 +11,7 @@
>  #include "gettext.h"
>  #include "transport.h"
> =20
> +static struct trace_key trace_curl =3D TRACE_KEY_INIT(CURL);
>  #if LIBCURL_VERSION_NUM >=3D 0x070a08
>  long int git_curl_ipresolve =3D CURL_IPRESOLVE_WHATEVER;
>  #else
> @@ -464,6 +465,100 @@ static void set_curl_keepalive(CURL *c)
>  }
>  #endif
> =20
> +

No need for this extra blank line.

> +void curl_dump(const char *text, unsigned char *ptr, size_t size, ch=
ar nohex)
> +{
> +	size_t i;
> +	size_t w;

Is it better to narrow the scope of 'w' to the "for (i)" loop?

> +	struct strbuf out =3D STRBUF_INIT;
> +

No need for this extra blank line.

> +	unsigned int width =3D 0x10;
> +
> +	if (nohex)
> +		/* without the hex output, we can fit more on screen */
> +		width =3D 0x40;
> +
> +	strbuf_addf(&out, "%s, %10.10ld bytes (0x%8.8lx)\n",
> +		text, (long)size, (long)size);

Inconsistent indentation that uses only two HT, when existing
lines and other new lines in thsi patch align with HT with SP
to match "(" on the previous line.

> +
> +	for (i =3D 0; i < size; i +=3D width) {
> +
> +		strbuf_addf(&out, "%4.4lx: ", (long)i);
> +
> +		if (!nohex) {
> +			/* hex not disabled, show it */

Unlike the previous "without the hex, we can fit more", this comment
is probably adds more noise than value.

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

Likewise.

> +			/* check again for 0D0A, to avoid an extra \n if it's at width */
> +			if (nohex && (i + w + 2 < size)
> +			    && ptr[i + w + 1] =3D=3D '\r'
> +			    && ptr[i + w + 2] =3D=3D '\n') {
> +				i +=3D (w + 3 - width);
> +				break;
> +			}
> +		}

This may only be the matter of taste, but I somehow found this "we
pretend to go width bytes at a time, unless there is a line-break in
which case we may fold before we hit width bytes" and need for
compensating with "w+3-width" here unnecessarily convoluted.  I
wonder if the code becomes clearer if insterad you said "we go one
line at a time, but we may fold the line if it is wider than width
bytes"?

> +		strbuf_addch(&out, '\n');
> +		trace_strbuf(&trace_curl, &out);
> +		strbuf_release(&out);
> +	}
> +}
> +
> +int curl_trace_want(void)
> +{
> +	return trace_want(&trace_curl);
> +}
> +
> +int curl_trace(CURL *handle, curl_infotype type,
> +	     char *data, size_t size, void *userp)

Inconsistent indentation.

> +{
> +	const char *text;
> +	(void)handle;		/* prevent compiler warning */

What compiler warning?  Usually unused parameter (not unused
variable) is not something compilers warn against.

> +	switch (type) {
> +	case CURLINFO_TEXT:
> +		trace_printf_key(&trace_curl, "=3D=3D Info: %s", data);
> +	default:		/* in case a new one is introduced to shock us */

The comment bothers me.

What is the longer term plan for this function?  Do we expect to
ignore some type of data, or do we expect to show all new type of
data?  If the former, "we ignore unknown types by default" is fine,
and if the latter, it probably makes more sense to show with
text=3D"unknown type"?

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
