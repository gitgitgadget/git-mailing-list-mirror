From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 1/4] http.h: Add debug callback and helper routine for
 implementing the GIT_TRACE_CURL environment variable in http.c
Date: Tue, 19 Apr 2016 22:48:54 +0100
Message-ID: <5716A7C6.40507@ramsayjones.plus.com>
References: <20160419151044.27814-1-gitter.spiros@gmail.com>
 <20160419151044.27814-2-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, gitster@pobox.com, sunshine@sunshineco.com,
	peff@peff.net, Junio C Hamano <gitster@pobox.com>
To: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 00:07:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asdnO-00011B-N6
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 00:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611AbcDSWGy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Apr 2016 18:06:54 -0400
Received: from avasout07.plus.net ([84.93.230.235]:51955 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbcDSWGy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 18:06:54 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout07 with smtp
	id kN6m1s0052D2Veb01N6nYe; Tue, 19 Apr 2016 23:06:51 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=EBOSESyhAAAA:8 a=ybZZDoGAAAAA:8 a=BCjA09oAAAAA:8 a=PKzvZo6CAAAA:8
 a=pGLkceISAAAA:8 a=cEvoh9r76P9KZmHScfAA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <20160419151044.27814-2-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291937>



On 19/04/16 16:10, Elia Pinto wrote:
> Add the debug callback and helper routine prototype used by
> curl_easy_setopt CURLOPT_DEBUGFUNCTION in http.c
> for implementing the GIT_TRACE_CURL environment variable
>=20
>=20
> Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>=20
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  http.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/http.h b/http.h
> index 4ef4bbd..a2d10bc 100644
> --- a/http.h
> +++ b/http.h
> @@ -224,4 +224,10 @@ extern int finish_http_object_request(struct htt=
p_object_request *freq);
>  extern void abort_http_object_request(struct http_object_request *fr=
eq);
>  extern void release_http_object_request(struct http_object_request *=
freq);
> =20
> +/* Debug callback and helper routine for curl_easy_setopt CURLOPT_DE=
BUGFUNCTION */
> +static struct trace_key trace_curl =3D TRACE_KEY_INIT(CURL);

Ah no, this would add 6 instances of the 'trace_curl' key in http-fetch=
=2Ec,
http-push.c, http-walker.c, http.c, imap-send.c and remote-curl.c. Hmm =
=2E..
since these would end up in different executables (by and large) it mig=
ht
work OK, ... but is simply not necessary.

Also, patches #1 and #2 should be squashed into one patch and, since th=
e
curl_dump() function is only called from http.c, it can be a static sym=
bol.

I think the minimal fixup (including Junio's comment on patch #2, which=
 also
triggered for me) is given in the patch below.

Hope that helps.

ATB,
Ramsay Jones

> +int curl_trace(CURL *handle, curl_infotype type, char *data, size_t =
size, void *userp);
> +void curl_dump(const char *text, unsigned char *ptr, size_t size, ch=
ar nohex);
> +
> +
>  #endif /* HTTP_H */

-- >8 --
Subject: [PATCH] curl-trace: fix scope/visibility of various symbols

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 http.c | 9 +++------
 http.h | 3 +--
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/http.c b/http.c
index 64dd975..ce91421 100644
--- a/http.c
+++ b/http.c
@@ -11,9 +11,7 @@
 #include "gettext.h"
 #include "transport.h"
=20
-/*
-tatic struct trace_key trace_curl =3D TRACE_KEY_INIT(CURL);
-*/
+struct trace_key trace_curl =3D TRACE_KEY_INIT(CURL);
 #if LIBCURL_VERSION_NUM >=3D 0x070a08
 long int git_curl_ipresolve =3D CURL_IPRESOLVE_WHATEVER;
 #else
@@ -468,12 +466,11 @@ static void set_curl_keepalive(CURL *c)
 #endif
=20
=20
-void curl_dump(const char *text, unsigned char *ptr, size_t size, char=
 nohex)
+static void curl_dump(const char *text, unsigned char *ptr, size_t siz=
e, char nohex)
 {
 	size_t i;
 	size_t w;
-	struct strbuf out =3D STRBUF_INIT;;
-
+	struct strbuf out =3D STRBUF_INIT;
 	unsigned int width =3D 0x10;
=20
 	if (nohex)
diff --git a/http.h b/http.h
index a2d10bc..00e4ad7 100644
--- a/http.h
+++ b/http.h
@@ -225,9 +225,8 @@ extern void abort_http_object_request(struct http_o=
bject_request *freq);
 extern void release_http_object_request(struct http_object_request *fr=
eq);
=20
 /* Debug callback and helper routine for curl_easy_setopt CURLOPT_DEBU=
GFUNCTION */
-static struct trace_key trace_curl =3D TRACE_KEY_INIT(CURL);
+extern struct trace_key trace_curl;
 int curl_trace(CURL *handle, curl_infotype type, char *data, size_t si=
ze, void *userp);
-void curl_dump(const char *text, unsigned char *ptr, size_t size, char=
 nohex);
=20
=20
 #endif /* HTTP_H */
--=20
2.8.0
