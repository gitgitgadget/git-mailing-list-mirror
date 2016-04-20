From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCHv3 3/3] http.c: implements the GIT_TRACE_CURL environment variable
Date: Wed, 20 Apr 2016 16:28:25 +0000
Message-ID: <20160420162825.62380-4-gitter.spiros@gmail.com>
References: <20160420162825.62380-1-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, ramsay@ramsayjones.plus.com, gitster@pobox.com,
	sunshine@sunshineco.com, peff@peff.net,
	Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 18:28:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asuzd-0000UP-Lg
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 18:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbcDTQ2h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2016 12:28:37 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36509 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619AbcDTQ2e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 12:28:34 -0400
Received: by mail-wm0-f67.google.com with SMTP id l6so15195517wml.3
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 09:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=69baZtvhzMGR333iotBNZQE1KO7s0XjC4Ti8KqBEPJY=;
        b=s4T5L7OFVxN1T8rh6j7OI//Uow8codHhz/kw5xBW9JWQzz+O/OtGX3KgfjWGB9aGI4
         70w25HxRjhCT8sFYe/vUb5Op1n/cxfeMtVw8WLIGQJQpRL7VWim0y85siBk2DAEBIYb/
         yeK69f/YCsfI0sZ35ArbI+HSSxuPJQchrJ7CFhwcfeqqcBTF6WHqvrUzgaPi4trD3FZN
         5j8sL5NEt6xw5rABu0SxlKcY0uf9sKrpM2oCVD4vROSoRksIZnpSBsCrQq+gBg58FNLJ
         X2HSSN/YXxLSL8j0LTA4/Z7/J28h2H83nTjH7Dpx3C0a/tlQ+sxvQUObYB82WlR5iiRB
         YMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=69baZtvhzMGR333iotBNZQE1KO7s0XjC4Ti8KqBEPJY=;
        b=jwUlpPR6hoCofkJNiaF6bwMlf2bogWX2FTowbaaZtuqtGpacXXovcAqnSQACB8CTuo
         QnPgOmnQA5HOjH7pb5jZe8SAgnF+1FGJifRDymXvlCh4PUgLLYUtcJJQRIuWFNAQEDxs
         hM5Y7ReN77FvNsusEa9MgZZR/cN8pZbVMdCodCQ0nplJGT7YOcMXtXyK93khwSBQasUJ
         gZ4x8CyNGS0QAd6HkQO699asZ35yh+4ElCBCq0o4+PJ0kYE8Lx8qIb/7cjdtpCxHWZW8
         GVrJ3LPfzeBqqpWTvOiHwNoS+Z76Xo6UaFX8WWeRpkWfon1BMEPgJ5GN4dcOKZmXcbH3
         LOPw==
X-Gm-Message-State: AOPr4FVd3q1zjqMdKzvrnpylI6Scaoe4vP3TKUKFJREhVUqaq19ABvkq7ga2RWQaU5QpSg==
X-Received: by 10.194.16.133 with SMTP id g5mr9794779wjd.42.1461169712525;
        Wed, 20 Apr 2016 09:28:32 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id qt3sm6368445wjc.32.2016.04.20.09.28.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Apr 2016 09:28:32 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.383.g31b84cc
In-Reply-To: <20160420162825.62380-1-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292042>

Implements the GIT_TRACE_CURL environment variable to allow a
greater degree of detail of GIT_CURL_VERBOSE, in particular
the complete transport header and all the data payload exchanged.
It might be useful if a particular situation could require a more
thorough debugging analysis.

Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 http.c | 101 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
 http.h |   6 ++++
 2 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/http.c b/http.c
index 4304b80..507c386 100644
--- a/http.c
+++ b/http.c
@@ -11,6 +11,7 @@
 #include "gettext.h"
 #include "transport.h"
=20
+static struct trace_key trace_curl =3D TRACE_KEY_INIT(CURL);
 #if LIBCURL_VERSION_NUM >=3D 0x070a08
 long int git_curl_ipresolve =3D CURL_IPRESOLVE_WHATEVER;
 #else
@@ -464,6 +465,100 @@ static void set_curl_keepalive(CURL *c)
 }
 #endif
=20
+
+void curl_dump(const char *text, unsigned char *ptr, size_t size, char=
 nohex)
+{
+	size_t i;
+	size_t w;
+	struct strbuf out =3D STRBUF_INIT;
+
+	unsigned int width =3D 0x10;
+
+	if (nohex)
+		/* without the hex output, we can fit more on screen */
+		width =3D 0x40;
+
+	strbuf_addf(&out, "%s, %10.10ld bytes (0x%8.8lx)\n",
+		text, (long)size, (long)size);
+
+	for (i =3D 0; i < size; i +=3D width) {
+
+		strbuf_addf(&out, "%4.4lx: ", (long)i);
+
+		if (!nohex) {
+			/* hex not disabled, show it */
+			for (w =3D 0; w < width; w++)
+				if (i + w < size)
+					strbuf_addf(&out, "%02x ", ptr[i + w]);
+				else
+					strbuf_addf(&out,"   ");
+		}
+
+		for (w =3D 0; (w < width) && (i + w < size); w++) {
+			/* check for 0D0A; if found, skip past and start a new line of outp=
ut */
+			if (nohex && (i + w + 1 < size) && ptr[i + w] =3D=3D '\r'
+			    && ptr[i + w + 1] =3D=3D '\n') {
+				i +=3D (w + 2 - width);
+				break;
+			}
+			strbuf_addch(&out, (ptr[i + w] >=3D 0x20)
+				&& (ptr[i + w] < 0x80) ? ptr[i + w] : '.');
+			/* check again for 0D0A, to avoid an extra \n if it's at width */
+			if (nohex && (i + w + 2 < size)
+			    && ptr[i + w + 1] =3D=3D '\r'
+			    && ptr[i + w + 2] =3D=3D '\n') {
+				i +=3D (w + 3 - width);
+				break;
+			}
+		}
+		strbuf_addch(&out, '\n');
+		trace_strbuf(&trace_curl, &out);
+		strbuf_release(&out);
+	}
+}
+
+int curl_trace_want(void)
+{
+	return trace_want(&trace_curl);
+}
+
+int curl_trace(CURL *handle, curl_infotype type,
+	     char *data, size_t size, void *userp)
+{
+	const char *text;
+	(void)handle;		/* prevent compiler warning */
+
+	switch (type) {
+	case CURLINFO_TEXT:
+		trace_printf_key(&trace_curl, "=3D=3D Info: %s", data);
+	default:		/* in case a new one is introduced to shock us */
+		return 0;
+
+	case CURLINFO_HEADER_OUT:
+		text =3D "=3D> Send header";
+		break;
+	case CURLINFO_DATA_OUT:
+		text =3D "=3D> Send data";
+		break;
+	case CURLINFO_SSL_DATA_OUT:
+		text =3D "=3D> Send SSL data";
+		break;
+	case CURLINFO_HEADER_IN:
+		text =3D "<=3D Recv header";
+		break;
+	case CURLINFO_DATA_IN:
+		text =3D "<=3D Recv data";
+		break;
+	case CURLINFO_SSL_DATA_IN:
+		text =3D "<=3D Recv SSL data";
+		break;
+	}
+
+	curl_dump(text, (unsigned char *)data, size, 1);
+	return 0;
+}
+
+
 static CURL *get_curl_handle(void)
 {
 	CURL *result =3D curl_easy_init();
@@ -563,7 +658,11 @@ static CURL *get_curl_handle(void)
 			"your curl version is too old (>=3D 7.19.4)");
 #endif
=20
-	if (getenv("GIT_CURL_VERBOSE"))
+	if (curl_trace_want()) {
+		curl_easy_setopt(result, CURLOPT_VERBOSE, 1L);
+		curl_easy_setopt(result, CURLOPT_DEBUGFUNCTION, curl_trace);
+		curl_easy_setopt(result, CURLOPT_DEBUGDATA, NULL);
+	} else if (getenv("GIT_CURL_VERBOSE"))
 		curl_easy_setopt(result, CURLOPT_VERBOSE, 1);
=20
 	curl_easy_setopt(result, CURLOPT_USERAGENT,
diff --git a/http.h b/http.h
index 4ef4bbd..e452f6a 100644
--- a/http.h
+++ b/http.h
@@ -224,4 +224,10 @@ extern int finish_http_object_request(struct http_=
object_request *freq);
 extern void abort_http_object_request(struct http_object_request *freq=
);
 extern void release_http_object_request(struct http_object_request *fr=
eq);
=20
+/* Debug callback and helper routine for curl_easy_setopt CURLOPT_DEBU=
GFUNCTION */
+int curl_trace_want(void);
+int curl_trace(CURL *handle, curl_infotype type, char *data, size_t si=
ze, void *userp);
+void curl_dump(const char *text, unsigned char *ptr, size_t size, char=
 nohex);
+
+
 #endif /* HTTP_H */
--=20
2.8.1.383.g31b84cc
