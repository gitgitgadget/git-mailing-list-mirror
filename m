From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH v7 1/2] http.c: implement the GIT_TRACE_CURL environment variable
Date: Mon, 23 May 2016 13:44:02 +0000
Message-ID: <20160523134403.43880-2-gitter.spiros@gmail.com>
References: <20160523134403.43880-1-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org, tboegi@web.de, ramsay@ramsayjones.plus.com,
	gitster@pobox.com, sunshine@sunshineco.com, peff@peff.net
X-From: git-owner@vger.kernel.org Mon May 23 15:44:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4qA7-0004ji-Rm
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 15:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756018AbcEWNot convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 May 2016 09:44:49 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33050 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598AbcEWNoq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 09:44:46 -0400
Received: by mail-wm0-f66.google.com with SMTP id 67so15269530wmg.0
        for <git@vger.kernel.org>; Mon, 23 May 2016 06:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dpxXyyi/LOjjZigFGJ3yjJpfYe3Mr8JdAGUI0nAjmI0=;
        b=AABvahjekGT01wSbgTyMusRjDWaofxUOf9nNQtDmzxlwwutAolq4yvNODtoiWq/qwp
         fo4JUtbxd/vtR5ZUfs41jryPLakNHSgLgEGvvTCpOaPuidw91wA9ZXMgia/HTUkBr6+k
         ux2uCD+UFqY7co23XF40xARIj6Ai2LTzbtDgmIZm/vdUw+slhp5LkjCdFriqF19UxBl7
         dnzrqWuXkcOKik+AqA/g64V8F1cfu18WY7BWUX7vqjgfrSzLg1rALcqJiBwkh3ygejKt
         Oh9/EcXboP2KvbXIv0jOvJwv7eZE/o0ipKGxoAJpeHpNCqxaaVGJcggwrNOlCcJ3n2Yy
         oN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dpxXyyi/LOjjZigFGJ3yjJpfYe3Mr8JdAGUI0nAjmI0=;
        b=OS+bU2hfc9h7DjUf0AdykDnSCrXs+pbqISh4ww9Z3m2uKBmcJ+/N5weT/2PZfi3JyD
         we8yRe08Sst4wtoGdbsWkjZa1oxV46f8pOhLyBB7mspxve5JeUmclc0dpIrxI3UhMwej
         ui9AkN3VVZq8z2jsREZGTf0QPFY/ar8dmUkKEgDoFy82aOyPoaMOdw2F9IOF0+mz63OA
         UH3bKeRfV3WAuR6hcjdu/208MRZIE6I+AnEcsNDlS/UAROnaJL9y5psF1F7XG8WckJdK
         JzG66Tz/gzKtwp9jm84UOLlX3Yc1JbobwAHXZfcex+iDr831SDTsYv6ebcu/e9jXsLO5
         53EQ==
X-Gm-Message-State: ALyK8tL+UNlDd1QoOMGHg4S6UONnRGyPYOr/ERHb2ZTpLI7CQnipuGpX+DKaCYvvmlwVvQ==
X-Received: by 10.28.98.215 with SMTP id w206mr8294805wmb.79.1464011085076;
        Mon, 23 May 2016 06:44:45 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id t3sm13764131wmf.20.2016.05.23.06.44.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 May 2016 06:44:44 -0700 (PDT)
X-Mailer: git-send-email 2.8.3.614.g2da74fb.dirty
In-Reply-To: <20160523134403.43880-1-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295322>

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
 http.c                | 125 ++++++++++++++++++++++++++++++++++++++++++=
+++++++-
 http.h                |   2 +
 3 files changed, 133 insertions(+), 2 deletions(-)

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
index df6dd01..d661408 100644
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
@@ -477,6 +478,126 @@ static void set_curl_keepalive(CURL *c)
 }
 #endif
=20
+static void redact_sensitive_header(struct strbuf *header)
+{
+	const char *sensitive_header;
+
+	if (skip_prefix(header->buf, "Authorization:", &sensitive_header) ||
+	    skip_prefix(header->buf, "Proxy-Authorization:", &sensitive_heade=
r)) {
+		/* The first token is the type, which is OK to log */
+		while (isspace(*sensitive_header))
+			sensitive_header++;
+		while (*sensitive_header && !isspace(*sensitive_header))
+			sensitive_header++;
+		/* Everything else is opaque and possibly sensitive */
+		strbuf_setlen(header,  sensitive_header - header->buf);
+		strbuf_addstr(header, " <redacted>");
+	}
+}
+
+static void curl_dump_header(const char *text, unsigned char *ptr, siz=
e_t size, int hide_sensitive_header)
+{
+	struct strbuf out =3D STRBUF_INIT;
+	const char *sensitive_header;
+	struct strbuf **headers, **header;
+
+	strbuf_addf(&out, "%s, %10.10ld bytes (0x%8.8lx)\n",
+		text, (long)size, (long)size);
+	trace_strbuf(&trace_curl, &out);
+	strbuf_reset(&out);
+	strbuf_add(&out, ptr, size);
+	headers =3D strbuf_split_max(&out, '\n', 0);
+
+	for (header =3D headers; *header; header++) {
+		if (hide_sensitive_header)
+			redact_sensitive_header(*header);
+		strbuf_insert((*header), 0, text, strlen(text));
+		strbuf_insert((*header), strlen(text), ": ", 2);
+		strbuf_rtrim((*header));
+		strbuf_addch((*header), '\n');
+		trace_strbuf(&trace_curl, (*header));
+	}
+	strbuf_list_free(headers);
+	strbuf_release(&out);
+}
+
+static void curl_dump_data(const char *text, unsigned char *ptr, size_=
t size)
+{
+	size_t i;
+	struct strbuf out =3D STRBUF_INIT;
+	unsigned int width =3D 60;
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
+			unsigned char ch =3D ptr[i + w];
+
+			strbuf_addch(&out,
+				       (ch >=3D 0x20) && (ch < 0x80)
+				       ? ch : '.');
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
+	enum { NO_FILTER =3D 0, DO_FILTER =3D 1 };
+
+	switch (type) {
+	case CURLINFO_TEXT:
+		trace_printf_key(&trace_curl, "=3D=3D Info: %s", data);
+	default:		/* we ignore unknown types by default */
+		return 0;
+
+	case CURLINFO_HEADER_OUT:
+		text =3D "=3D> Send header";
+		curl_dump_header(text, (unsigned char *)data, size, DO_FILTER);
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
+		curl_dump_header(text, (unsigned char *)data, size, NO_FILTER);
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
+	if (!trace_want(&trace_curl))
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
@@ -575,9 +696,9 @@ static CURL *get_curl_handle(void)
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
2.8.3.614.g2da74fb.dirty
