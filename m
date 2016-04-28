From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCHv4 1/2] http.c: implement the GIT_TRACE_CURL environment variable
Date: Thu, 28 Apr 2016 11:57:47 +0000
Message-ID: <20160428115748.37177-2-gitter.spiros@gmail.com>
References: <20160428115748.37177-1-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, ramsay@ramsayjones.plus.com, gitster@pobox.com,
	sunshine@sunshineco.com, peff@peff.net,
	Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 13:58:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avkaA-00025g-85
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 13:58:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693AbcD1L6G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Apr 2016 07:58:06 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36721 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455AbcD1L6E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 07:58:04 -0400
Received: by mail-wm0-f68.google.com with SMTP id w143so22659936wmw.3
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 04:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2+hHNqSjQf1NK5tMC3or6GL2s/PdlRVJUINEqwZLo9c=;
        b=hj2SX7pGU25jiHfKdBZM5kgyHTuGv91EQ1Nrn5Wql6KSoHMS3sEp8H1YAXumswm86E
         HgZTH1hWUWtR4vHa0FV+c/8so7qh2F+uLIP/vx+Viue72F3cXXouLMe3NjpcCklzXxci
         42AZJpaXKvUE4gRHFh/hx7Bv/WDBMveZweuGhPApi/9PFck8XnpIJQkBu4oqvgdiUGO4
         gJARmrT6W44O4yPej1m7GfdJQeBk+GM+00yuPAR2zQBlAYhJYQTsWzCMuHF1Id4jh2fy
         ebvu8LrDVIIAduykxBVQHze6xbBU9OZ5ieyoApkpYu+TTKWlTSUp4o1OzmGwcLl12Apa
         Pw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2+hHNqSjQf1NK5tMC3or6GL2s/PdlRVJUINEqwZLo9c=;
        b=UYLO9XHsov5elHtSERmgjdxvJ7NUU/Eamm8S1JWnOBvA7DmxrrDo+EY+YS+3yhSNG5
         Q87vGvd2I5WX1wn0rqnJM9TK7+mq/ZqF35GNz2/LtC+L3oWi4n457gQGBLYSQT85/RS+
         eEJ/VQPcQW52GSB1NzTJ+xwKZ5GpM/BVnzYXiGVwEW9aDBrfAq/9ev+nmNi9qRKWeLZG
         ODB843WPMl29eXHsB2cGTA68ALd5HQU5oJ0/0W4zAr/Do5Q7kE1rqp8u9uyPMkf/L64e
         g2HLdjpZLmxRBTVvqW9JgcAnpcZVf3hKCRnrmitaF/P9ABKv1GdtUt1kYXv2e40GuqaG
         tKiA==
X-Gm-Message-State: AOPr4FXTxrc270EACesQ+YuPP+xqjxz/a2gFB8OHavw8Q+cMs/e5j4EitRxbueTctShbiw==
X-Received: by 10.28.39.196 with SMTP id n187mr2002370wmn.4.1461844682330;
        Thu, 28 Apr 2016 04:58:02 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id xt9sm9319278wjb.17.2016.04.28.04.58.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Apr 2016 04:58:01 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.487.gf8c3767.dirty
In-Reply-To: <20160428115748.37177-1-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292866>

Implement the GIT_TRACE_CURL environment variable to allow a
greater degree of detail of GIT_CURL_VERBOSE, in particular
the complete transport header and all the data payload exchanged.
It might be useful if a particular situation could require a more
thorough debugging analysis. Document the new GIT_TRACE_CURL
environment variable.

Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 Documentation/git.txt |   8 ++++
 http.c                | 109 ++++++++++++++++++++++++++++++++++++++++++=
+++++++-
 http.h                |   4 ++
 3 files changed, 120 insertions(+), 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 8afe349..958db0f 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1075,6 +1075,14 @@ of clones and fetches.
 	cloning of shallow repositories.
 	See 'GIT_TRACE' for available trace output options.
=20
+'GIT_TRACE_CURL'::
+	Enables a curl full trace dump of all incoming and outgoing data,
+	including descriptive information, of the git transport protocol.
+	This is similar to doing curl --trace-ascii on the command line.
+	This option overrides setting the GIT_CURL_VERBOSE environment
+	variable.
+	See 'GIT_TRACE' for available trace output options.
+
 'GIT_LITERAL_PATHSPECS'::
 	Setting this variable to `1` will cause Git to treat all
 	pathspecs literally, rather than as glob patterns. For example,
diff --git a/http.c b/http.c
index 985b995..5c2c729 100644
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
@@ -478,6 +479,108 @@ static void set_curl_keepalive(CURL *c)
 }
 #endif
=20
+static void curl_dump(const char *text, unsigned char *ptr, size_t siz=
e, char nohex, char nopriv)
+{
+	size_t i;
+	struct strbuf out =3D STRBUF_INIT;
+	unsigned int width =3D 0x10;
+
+	/* without the hex output, we can fit more on screen */
+	if (nohex) width =3D 0x50;
+
+	strbuf_addf(&out, "%s, %10.10ld bytes (0x%8.8lx)\n",
+		text, (long)size, (long)size);
+	trace_strbuf(&trace_curl, &out);
+	strbuf_reset(&out);
+
+	for (i =3D 0; i < size; i +=3D width) {
+		size_t w;
+		strbuf_addf(&out, "%s: ", text);
+		if (!nohex) {
+			for (w =3D 0; w < width; w++)
+				if (i + w < size)
+					strbuf_addf(&out, "%02x ", ptr[i + w]);
+				else
+					strbuf_addf(&out,"   ");
+		}
+		for (w =3D 0; (w < width) && (i + w < size); w++) {
+			if (nohex && (i + w + 1 < size) && ptr[i + w] =3D=3D '\r'
+			    && ptr[i + w + 1] =3D=3D '\n') {
+				i +=3D (w + 2 - width);
+				break;
+			}
+			strbuf_addch(&out, (ptr[i + w] >=3D 0x20)
+				&& (ptr[i + w] < 0x80) ? ptr[i + w] : '.');
+			if (nohex && (i + w + 2 < size)
+			    && ptr[i + w + 1] =3D=3D '\r'
+			    && ptr[i + w + 2] =3D=3D '\n') {
+				i +=3D (w + 3 - width);
+				break;
+			}
+		}
+		/* if we are called with nopriv we skip the Authorization field if p=
resent
+		 * and print a blank line
+		*/
+		if ( nopriv && strstr(out.buf, "Authorization:"))
+			strbuf_reset(&out);
+
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
+int curl_trace(CURL *handle, curl_infotype type, char *data, size_t si=
ze, void *userp)
+{
+	const char *text;
+	(void)handle;		/* prevent compiler unused parameter warning if checke=
d */
+	(void)userp;		/* prevent compiler unused parameter warning if checked=
 */
+	char nopriv =3D 0;	/* default: there are no sensitive data
+				 * in the trace to be skipped
+				*/
+
+	switch (type) {
+	case CURLINFO_TEXT:
+		trace_printf_key(&trace_curl, "=3D=3D Info: %s", data);
+	default:		/* we ignore unknown types by default */
+		return 0;
+
+	case CURLINFO_HEADER_OUT:
+		text =3D "=3D> Send header";
+		nopriv =3D 1;
+		break;
+	case CURLINFO_DATA_OUT:
+		text =3D "=3D> Send data";
+		nopriv =3D 0;
+		break;
+	case CURLINFO_SSL_DATA_OUT:
+		text =3D "=3D> Send SSL data";
+		nopriv =3D 0;
+		break;
+	case CURLINFO_HEADER_IN:
+		text =3D "<=3D Recv header";
+		nopriv =3D 0;
+		break;
+	case CURLINFO_DATA_IN:
+		text =3D "<=3D Recv data";
+		nopriv =3D 0;
+		break;
+	case CURLINFO_SSL_DATA_IN:
+		text =3D "<=3D Recv SSL data";
+		nopriv =3D 0;
+		break;
+	}
+
+	curl_dump(text, (unsigned char *)data, size, 1, nopriv);
+	return 0;
+}
+
+
 static CURL *get_curl_handle(void)
 {
 	CURL *result =3D curl_easy_init();
@@ -577,7 +680,11 @@ static CURL *get_curl_handle(void)
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
index 36f558b..1ee80e5 100644
--- a/http.h
+++ b/http.h
@@ -225,4 +225,8 @@ extern int finish_http_object_request(struct http_o=
bject_request *freq);
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
+
 #endif /* HTTP_H */
--=20
2.8.1.487.gf8c3767.dirty
