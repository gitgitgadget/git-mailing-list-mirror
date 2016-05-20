From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH v6 1/2] http.c: implement the GIT_TRACE_CURL environment variable
Date: Fri, 20 May 2016 10:37:07 +0000
Message-ID: <20160520103708.38308-2-gitter.spiros@gmail.com>
References: <20160520103708.38308-1-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org, tboegi@web.de, ramsay@ramsayjones.plus.com,
	gitster@pobox.com, sunshine@sunshineco.com, peff@peff.net
X-From: git-owner@vger.kernel.org Fri May 20 12:38:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3hol-0006QP-7R
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 12:38:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933057AbcETKhx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 May 2016 06:37:53 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35128 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932455AbcETKht (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 06:37:49 -0400
Received: by mail-wm0-f68.google.com with SMTP id s63so13472453wme.2
        for <git@vger.kernel.org>; Fri, 20 May 2016 03:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QFVEx9Jr75yXkdwpkNtEMHz7hIfbQC0oZngf8qQXO/4=;
        b=0TvYi+EMrWRWnJDGX2YpUOHdh5Im170hB/hdrJ7pY/sLJzIMqBSkjXYp0V5eP2q6ow
         tqGhfHvWjHVq+4+2nzbPTI3A82gs4u6K4HaraKaFnjFty+WHO1ub0/Iec64722riWHS6
         M0dQZvnER112GM3zFtJic62HDfde2bU2+hSWHb71PBvO9xTfgK3HzpiejEexTFGg0i7v
         Con/ki0o7qrH/J+v3YtTRMfvhZNCinoI5bNB6t/vE+s89cSHygF5VmpcOxYK86jXGm/c
         XncDlZj/UVLz5KTpYXPrjJh5TqZpanoz0Yk8DqtFFwj1hTotjSMF7gjU6PdIBL1NFpdq
         wJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QFVEx9Jr75yXkdwpkNtEMHz7hIfbQC0oZngf8qQXO/4=;
        b=LnWCCqGF3R7g/v4sPW4Jt66Pwya0jkD3GrdhgTGO1U5y0SONv/6Q7RT7W9KHrQzr43
         InT9GzYwJtmuM46Q1FdbWIzz96zoGJQvJoIHxT9MACdi6HLfKhGgzrFoas9bOhU7aTkV
         MHzz477pBJxHeCFX0biU5S5ugJQuJJYeepqiN+b9si/K70L/Hh6pkmxF6ZQ9Se+Bt00i
         Wc43SWlWuhJ8lJkhamgt8lGompOEXgqG16hxHaGZzDKvSSP5VoY5Rbjsh9gN+DD/0hdZ
         OewCUx/5RUttr2uno9DQtRl9azozXSM9KqXDO3XBcHQHZwNQzIMBtFwhb8ohEr54C6i/
         8FWg==
X-Gm-Message-State: AOPr4FX0Jy2mpFsUoS1pKI2koqZsN49Bdo7In/sKwVQ3rK1n6J08I2vRkZizB/hXA3RpTA==
X-Received: by 10.28.62.15 with SMTP id l15mr2887386wma.30.1463740668195;
        Fri, 20 May 2016 03:37:48 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id k127sm1372659wmf.21.2016.05.20.03.37.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 May 2016 03:37:47 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.435.g7c6234f.dirty
In-Reply-To: <20160520103708.38308-1-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295158>

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
 http.c                | 124 ++++++++++++++++++++++++++++++++++++++++++=
+++++++-
 http.h                |   2 +
 3 files changed, 132 insertions(+), 2 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index dd6dbf7..a46a356 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1077,6 +1077,14 @@ of clones and fetches.
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
index df6dd01..ba32bac 100644
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
@@ -477,6 +478,125 @@ static void set_curl_keepalive(CURL *c)
 }
 #endif
=20
+static void curl_dump_header(const char *text, unsigned char *ptr, siz=
e_t size, int nopriv_header)
+{
+	struct strbuf out =3D STRBUF_INIT;
+	const char *header;
+	struct strbuf **header_list, **ptr_list;
+
+	strbuf_addf(&out, "%s, %10.10ld bytes (0x%8.8lx)\n",
+		text, (long)size, (long)size);
+	trace_strbuf(&trace_curl, &out);
+	strbuf_reset(&out);
+	strbuf_add(&out,ptr,size);
+	header_list =3D strbuf_split_max(&out, '\n', 0);
+
+	for (ptr_list =3D header_list; *ptr_list; ptr_list++) {
+	/*
+	 * if we are called with nopriv_header substitute a dummy value
+	 * in the Authorization or Proxy-Authorization http header if
+	 * present.
+	 */
+	if (nopriv_header &&
+		(skip_prefix((*ptr_list)->buf , "Authorization:", &header)
+		|| skip_prefix((*ptr_list)->buf , "Proxy-Authorization:", &header)))=
 {=20
+		/* The first token is the type, which is OK to log */
+		while (isspace(*header))
+			header++;
+		while (*header && !isspace(*header))
+			header++;
+		/* Everything else is opaque and possibly sensitive */
+		strbuf_setlen((*ptr_list),  header - (*ptr_list)->buf );
+		strbuf_addstr((*ptr_list), " <redacted>");
+	}
+	strbuf_insert((*ptr_list), 0, text, strlen(text));
+	strbuf_insert((*ptr_list), strlen(text), ": ", 2);
+	strbuf_rtrim((*ptr_list));
+	strbuf_addch((*ptr_list), '\n');
+	trace_strbuf(&trace_curl, (*ptr_list));
+	}
+	strbuf_list_free(header_list);
+	strbuf_release(&out);
+}
+static void curl_dump_data(const char *text, unsigned char *ptr, size_=
t size)
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
+
+		strbuf_reset(&out);
+		strbuf_addf(&out, "%s: ", text);
+		for (w =3D 0; (w < width) && (i + w < size); w++) {
+			strbuf_addch(&out, (ptr[i + w] >=3D 0x20)
+				&& (ptr[i + w] < 0x80) ? ptr[i + w] : '.');
+		}
+		strbuf_addch(&out, '\n');
+		trace_strbuf(&trace_curl, &out);
+	}
+	strbuf_release(&out);
+}
+
+static int curl_trace(CURL *handle, curl_infotype type, char *data, si=
ze_t size, void *userp)
+{
+	const char *text;
+	int nopriv_header =3D 0;	/*
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
+		nopriv_header =3D 1;
+		curl_dump_header(text, (unsigned char *)data, size, nopriv_header);
+		break;
+	case CURLINFO_DATA_OUT:
+		text =3D "=3D> Send data";
+		curl_dump_data(text, (unsigned char *)data, size);
+		break;
+	case CURLINFO_SSL_DATA_OUT:
+		text =3D "=3D> Send SSL data";
+		curl_dump_data(text, (unsigned char *)data, size);
+		break;
+	case CURLINFO_HEADER_IN:
+		text =3D "<=3D Recv header";
+		nopriv_header =3D 0;
+		curl_dump_header(text, (unsigned char *)data, size, nopriv_header);
+		break;
+	case CURLINFO_DATA_IN:
+		text =3D "<=3D Recv data";
+		curl_dump_data(text, (unsigned char *)data, size);
+		break;
+	case CURLINFO_SSL_DATA_IN:
+		text =3D "<=3D Recv SSL data";
+		curl_dump_data(text, (unsigned char *)data, size);
+		break;
+	}
+	return 0;
+}
+
+void setup_curl_trace(CURL *handle)
+{
+	if (!trace_want(&trace_curl))=20
+		return;
+	curl_easy_setopt(handle, CURLOPT_VERBOSE, 1L);
+	curl_easy_setopt(handle, CURLOPT_DEBUGFUNCTION, curl_trace);
+	curl_easy_setopt(handle, CURLOPT_DEBUGDATA, NULL);
+}
+
+
 static CURL *get_curl_handle(void)
 {
 	CURL *result =3D curl_easy_init();
@@ -575,9 +695,9 @@ static CURL *get_curl_handle(void)
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
index 36f558b..5ab9d9c 100644
--- a/http.h
+++ b/http.h
@@ -225,4 +225,6 @@ extern int finish_http_object_request(struct http_o=
bject_request *freq);
 extern void abort_http_object_request(struct http_object_request *freq=
);
 extern void release_http_object_request(struct http_object_request *fr=
eq);
=20
+/* setup routine for curl_easy_setopt CURLOPT_DEBUGFUNCTION */
+void setup_curl_trace(CURL *handle);
 #endif /* HTTP_H */
--=20
2.8.2.435.g7c6234f.dirty
