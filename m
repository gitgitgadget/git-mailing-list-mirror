From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCHv5 1/2] http.c: implement the GIT_TRACE_CURL environment variable
Date: Mon,  2 May 2016 14:28:12 +0000
Message-ID: <20160502142813.50868-2-gitter.spiros@gmail.com>
References: <20160502142813.50868-1-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, ramsay@ramsayjones.plus.com, gitster@pobox.com,
	sunshine@sunshineco.com, peff@peff.net,
	Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 16:28:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axEpp-0001VT-3v
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 16:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753546AbcEBO2V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2016 10:28:21 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36323 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbcEBO2T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 10:28:19 -0400
Received: by mail-wm0-f66.google.com with SMTP id w143so17298282wmw.3
        for <git@vger.kernel.org>; Mon, 02 May 2016 07:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jaMJESDCoz0wfNx2Ehwova5S15OEYo3QD+8VqS70JzU=;
        b=XbUQV1Xo1gjxw9ktHcl+R1TGtbJlLOitJEf2Q3LUrw1O6dds6Cd0moVynfk388GLeM
         QNl8m5zTTcgI++RpIL2rNIGwQYga7U9KXrQQa4ougkMf9BaUOHQ0GuIPU+GQ4e6O3zdo
         YMEqyjxYskoVmTjJ03s617FD1cLApqDwr+nFcl/WhZixq7WlLbgYJLshC9OWe3qzqMNQ
         DE3mM+oJZZO3zcijGXUrdby06ZSXAklckugghx/tzAEEr4G8ABm3wI4TS9fatprhvTkm
         /bjl33Y7VZ5UEnnjiZtahZhm7HeOMVV2kfAKjb0NlXQ3/MiIVyW0t7ISs0NA9Qzt77BG
         g/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jaMJESDCoz0wfNx2Ehwova5S15OEYo3QD+8VqS70JzU=;
        b=CmD2c002dNVy3vQqPPWF+s8pwRRvZb1YgIasS8SjkURlTypXRGy1W80UNyRyn6O9uP
         GG9YnQBKpuXE9v+i26NfUl2GYGp8RY/h621cZM3h12k1nw1HxNTSzQi1/BDiY8Lb5T5+
         g9Rx6R8o1uAmFMu9kKokgCbYHYfS28Z1J/rhUOFsa0vQc1vcUCtKN8s6Zps7vRGq2FV3
         19pOdcyIqOfYHw9GRwz+jgnfnhVTp6oJgWw/qwvwoL7W981fEBD6TaV2/9N2Obau4L73
         PJXTgQ4YK3Z6blbBGMhntgwKRPfseeELUZqI2M1pfvtYp/SCbwUS8hwmaPwUlD0aT7LC
         GlMg==
X-Gm-Message-State: AOPr4FVk8iqiKCdbDkyCUZENFSQoa5oL05d2ERq0eoZwGfkFfjBGMf6HVCFonLrF8vuRfw==
X-Received: by 10.28.195.7 with SMTP id t7mr18689364wmf.96.1462199298074;
        Mon, 02 May 2016 07:28:18 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id a200sm19197814wme.8.2016.05.02.07.28.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 May 2016 07:28:17 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.435.ga07a3e0
In-Reply-To: <20160502142813.50868-1-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293237>

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
 http.c                | 115 ++++++++++++++++++++++++++++++++++++++++++=
+++++++-
 http.h                |   4 ++
 3 files changed, 125 insertions(+), 2 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 34ff007..5e59576 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1076,6 +1076,14 @@ of clones and fetches.
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
index 985b995..5e2bc19 100644
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
@@ -478,6 +479,116 @@ static void set_curl_keepalive(CURL *c)
 }
 #endif
=20
+static void curl_dump(const char *text, unsigned char *ptr, size_t siz=
e, int nopriv)
+{
+	size_t i;
+	struct strbuf out =3D STRBUF_INIT;
+	unsigned int width =3D 80;
+
+	strbuf_addf(&out, "%s, %10.10ld bytes (0x%8.8lx)\n",
+		text, (long)size, (long)size);
+	trace_strbuf(&trace_curl, &out);
+
+	for (i =3D 0; i < size; i +=3D width) {
+		size_t w;
+		size_t prefix_len;
+		const char *header;
+
+		strbuf_reset(&out);
+		strbuf_addf(&out, "%s: ", text);
+		prefix_len =3D out.len;
+		for (w =3D 0; (w < width) && (i + w < size); w++) {
+			if ((i + w + 1 < size) && ptr[i + w] =3D=3D '\r'
+			    && ptr[i + w + 1] =3D=3D '\n') {
+				i +=3D (w + 2 - width);
+				break;
+			}
+			strbuf_addch(&out, (ptr[i + w] >=3D 0x20)
+				&& (ptr[i + w] < 0x80) ? ptr[i + w] : '.');
+			if ((i + w + 2 < size)
+			    && ptr[i + w + 1] =3D=3D '\r'
+			    && ptr[i + w + 2] =3D=3D '\n') {
+				i +=3D (w + 3 - width);
+				break;
+			}
+		}
+
+		/*
+		 * if we are called with nopriv substitute a dummy value
+		 * in the Authorization or Proxy-Authorization http header if
+		 * present.
+		 */
+		if (nopriv &&
+			(skip_prefix(out.buf + prefix_len, "Authorization:", &header)
+			|| skip_prefix(out.buf + prefix_len, "Proxy-Authorization:", &heade=
r))) {
+			/* The first token is the type, which is OK to log */
+			while (isspace(*header))
+				header++;
+			/* Everything else is opaque and possibly sensitive */
+			strbuf_setlen(&out, header - out.buf);
+			strbuf_addstr(&out, " <redacted>");
+		}
+		strbuf_addch(&out, '\n');
+		trace_strbuf(&trace_curl, &out);
+	}
+	strbuf_release(&out);
+}
+
+void setup_curl_trace(CURL *handle)
+{
+	if (!trace_want(&trace_curl)) return;
+	curl_easy_setopt(handle, CURLOPT_VERBOSE, 1L);
+	curl_easy_setopt(handle, CURLOPT_DEBUGFUNCTION, curl_trace);
+	curl_easy_setopt(handle, CURLOPT_DEBUGDATA, NULL);
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
+	int nopriv =3D 0;		/*
+				 * default: there are no sensitive data
+				 * in the trace to be skipped
+				 */
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
+	curl_dump(text, (unsigned char *)data, size, nopriv);
+	return 0;
+}
+
+
 static CURL *get_curl_handle(void)
 {
 	CURL *result =3D curl_easy_init();
@@ -576,9 +687,9 @@ static CURL *get_curl_handle(void)
 		warning("protocol restrictions not applied to curl redirects because=
\n"
 			"your curl version is too old (>=3D 7.19.4)");
 #endif
-
 	if (getenv("GIT_CURL_VERBOSE"))
-		curl_easy_setopt(result, CURLOPT_VERBOSE, 1);
+		curl_easy_setopt(result, CURLOPT_VERBOSE, 1L);
+	setup_curl_trace(result);
=20
 	curl_easy_setopt(result, CURLOPT_USERAGENT,
 		user_agent ? user_agent : git_user_agent());
diff --git a/http.h b/http.h
index 36f558b..cd186a4 100644
--- a/http.h
+++ b/http.h
@@ -225,4 +225,8 @@ extern int finish_http_object_request(struct http_o=
bject_request *freq);
 extern void abort_http_object_request(struct http_object_request *freq=
);
 extern void release_http_object_request(struct http_object_request *fr=
eq);
=20
+/* Debug callback and setup routine for curl_easy_setopt CURLOPT_DEBUG=
=46UNCTION */
+void setup_curl_trace(CURL *handle);
+int curl_trace(CURL *handle, curl_infotype type, char *data, size_t si=
ze, void *userp);
+
 #endif /* HTTP_H */
--=20
2.8.2.435.ga07a3e0
