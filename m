From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] make url-related functions reusable
Date: Sun, 23 May 2010 05:17:55 -0400
Message-ID: <20100523091755.GA16520@coredump.intra.peff.net>
References: <20100523091612.GB26123@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Dave Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Sun May 23 11:18:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OG7Jw-0004YU-BD
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 11:18:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753723Ab0EWJSB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 May 2010 05:18:01 -0400
Received: from peff.net ([208.65.91.99]:40950 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752476Ab0EWJSA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 May 2010 05:18:00 -0400
Received: (qmail 21134 invoked by uid 107); 23 May 2010 09:18:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 23 May 2010 05:18:01 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 23 May 2010 05:17:55 -0400
Content-Disposition: inline
In-Reply-To: <20100523091612.GB26123@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147561>

The is_url function and url percent-decoding functions were
static, but are generally useful. Let's make them available
to other parts of the code.

Signed-off-by: Jeff King <peff@peff.net>
---
There was some minor tweaking of the url_decode functions to be more
generally useful.

 Makefile       |    1 +
 http-backend.c |   59 +--------------------------
 transport.c    |   51 +-----------------------
 url.c          |  118 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 url.h          |   10 +++++
 5 files changed, 134 insertions(+), 105 deletions(-)
 create mode 100644 url.c
 create mode 100644 url.h

diff --git a/Makefile b/Makefile
index 07cab8f..4785f3f 100644
--- a/Makefile
+++ b/Makefile
@@ -627,6 +627,7 @@ LIB_OBJS += tree-diff.o
 LIB_OBJS += tree.o
 LIB_OBJS += tree-walk.o
 LIB_OBJS += unpack-trees.o
+LIB_OBJS += url.o
 LIB_OBJS += usage.o
 LIB_OBJS += userdiff.o
 LIB_OBJS += utf8.o
diff --git a/http-backend.c b/http-backend.c
index d1e83d0..f0e787e 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -6,6 +6,7 @@
 #include "exec_cmd.h"
 #include "run-command.h"
 #include "string-list.h"
+#include "url.h"
 
 static const char content_type[] = "Content-Type";
 static const char content_length[] = "Content-Length";
@@ -25,60 +26,6 @@ static struct rpc_service rpc_service[] = {
 	{ "receive-pack", "receivepack", -1 },
 };
 
-static int decode_char(const char *q)
-{
-	int i;
-	unsigned char val = 0;
-	for (i = 0; i < 2; i++) {
-		unsigned char c = *q++;
-		val <<= 4;
-		if (c >= '0' && c <= '9')
-			val += c - '0';
-		else if (c >= 'a' && c <= 'f')
-			val += c - 'a' + 10;
-		else if (c >= 'A' && c <= 'F')
-			val += c - 'A' + 10;
-		else
-			return -1;
-	}
-	return val;
-}
-
-static char *decode_parameter(const char **query, int is_name)
-{
-	const char *q = *query;
-	struct strbuf out;
-
-	strbuf_init(&out, 16);
-	do {
-		unsigned char c = *q;
-
-		if (!c)
-			break;
-		if (c == '&' || (is_name && c == '=')) {
-			q++;
-			break;
-		}
-
-		if (c == '%') {
-			int val = decode_char(q + 1);
-			if (0 <= val) {
-				strbuf_addch(&out, val);
-				q += 3;
-				continue;
-			}
-		}
-
-		if (c == '+')
-			strbuf_addch(&out, ' ');
-		else
-			strbuf_addch(&out, c);
-		q++;
-	} while (1);
-	*query = q;
-	return strbuf_detach(&out, NULL);
-}
-
 static struct string_list *get_parameters(void)
 {
 	if (!query_params) {
@@ -86,8 +33,8 @@ static struct string_list *get_parameters(void)
 
 		query_params = xcalloc(1, sizeof(*query_params));
 		while (query && *query) {
-			char *name = decode_parameter(&query, 1);
-			char *value = decode_parameter(&query, 0);
+			char *name = url_decode_parameter_name(&query);
+			char *value = url_decode_parameter_value(&query);
 			struct string_list_item *i;
 
 			i = string_list_lookup(name, query_params);
diff --git a/transport.c b/transport.c
index 8ce3936..4dba6f8 100644
--- a/transport.c
+++ b/transport.c
@@ -9,6 +9,7 @@
 #include "dir.h"
 #include "refs.h"
 #include "branch.h"
+#include "url.h"
 
 /* rsync support */
 
@@ -871,54 +872,6 @@ static int is_file(const char *url)
 	return S_ISREG(buf.st_mode);
 }
 
-static int isurlschemechar(int first_flag, int ch)
-{
-	/*
-	 * The set of valid URL schemes, as per STD66 (RFC3986) is
-	 * '[A-Za-z][A-Za-z0-9+.-]*'. But use sightly looser check
-	 * of '[A-Za-z0-9][A-Za-z0-9+.-]*' because earlier version
-	 * of check used '[A-Za-z0-9]+' so not to break any remote
-	 * helpers.
-	 */
-	int alphanumeric, special;
-	alphanumeric = ch > 0 && isalnum(ch);
-	special = ch == '+' || ch == '-' || ch == '.';
-	return alphanumeric || (!first_flag && special);
-}
-
-static int is_url(const char *url)
-{
-	const char *url2, *first_slash;
-
-	if (!url)
-		return 0;
-	url2 = url;
-	first_slash = strchr(url, '/');
-
-	/* Input with no slash at all or slash first can't be URL. */
-	if (!first_slash || first_slash == url)
-		return 0;
-	/* Character before must be : and next must be /. */
-	if (first_slash[-1] != ':' || first_slash[1] != '/')
-		return 0;
-	/* There must be something before the :// */
-	if (first_slash == url + 1)
-		return 0;
-	/*
-	 * Check all characters up to first slash - 1. Only alphanum
-	 * is allowed.
-	 */
-	url2 = url;
-	while (url2 < first_slash - 1) {
-		if (!isurlschemechar(url2 == url, (unsigned char)*url2))
-			return 0;
-		url2++;
-	}
-
-	/* Valid enough. */
-	return 1;
-}
-
 static int external_specification_len(const char *url)
 {
 	return strchr(url, ':') - url;
@@ -946,7 +899,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	if (url) {
 		const char *p = url;
 
-		while (isurlschemechar(p == url, *p))
+		while (is_urlschemechar(p == url, *p))
 			p++;
 		if (!prefixcmp(p, "::"))
 			helper = xstrndup(url, p - url);
diff --git a/url.c b/url.c
new file mode 100644
index 0000000..cd32b92
--- /dev/null
+++ b/url.c
@@ -0,0 +1,118 @@
+#include "cache.h"
+
+int is_urlschemechar(int first_flag, int ch)
+{
+	/*
+	 * The set of valid URL schemes, as per STD66 (RFC3986) is
+	 * '[A-Za-z][A-Za-z0-9+.-]*'. But use sightly looser check
+	 * of '[A-Za-z0-9][A-Za-z0-9+.-]*' because earlier version
+	 * of check used '[A-Za-z0-9]+' so not to break any remote
+	 * helpers.
+	 */
+	int alphanumeric, special;
+	alphanumeric = ch > 0 && isalnum(ch);
+	special = ch == '+' || ch == '-' || ch == '.';
+	return alphanumeric || (!first_flag && special);
+}
+
+int is_url(const char *url)
+{
+	const char *url2, *first_slash;
+
+	if (!url)
+		return 0;
+	url2 = url;
+	first_slash = strchr(url, '/');
+
+	/* Input with no slash at all or slash first can't be URL. */
+	if (!first_slash || first_slash == url)
+		return 0;
+	/* Character before must be : and next must be /. */
+	if (first_slash[-1] != ':' || first_slash[1] != '/')
+		return 0;
+	/* There must be something before the :// */
+	if (first_slash == url + 1)
+		return 0;
+	/*
+	 * Check all characters up to first slash - 1. Only alphanum
+	 * is allowed.
+	 */
+	url2 = url;
+	while (url2 < first_slash - 1) {
+		if (!is_urlschemechar(url2 == url, (unsigned char)*url2))
+			return 0;
+		url2++;
+	}
+
+	/* Valid enough. */
+	return 1;
+}
+
+static int url_decode_char(const char *q)
+{
+	int i;
+	unsigned char val = 0;
+	for (i = 0; i < 2; i++) {
+		unsigned char c = *q++;
+		val <<= 4;
+		if (c >= '0' && c <= '9')
+			val += c - '0';
+		else if (c >= 'a' && c <= 'f')
+			val += c - 'a' + 10;
+		else if (c >= 'A' && c <= 'F')
+			val += c - 'A' + 10;
+		else
+			return -1;
+	}
+	return val;
+}
+
+static char *url_decode_internal(const char **query, const char *stop_at)
+{
+	const char *q = *query;
+	struct strbuf out;
+
+	strbuf_init(&out, 16);
+	do {
+		unsigned char c = *q;
+
+		if (!c)
+			break;
+		if (stop_at && strchr(stop_at, c)) {
+			q++;
+			break;
+		}
+
+		if (c == '%') {
+			int val = url_decode_char(q + 1);
+			if (0 <= val) {
+				strbuf_addch(&out, val);
+				q += 3;
+				continue;
+			}
+		}
+
+		if (c == '+')
+			strbuf_addch(&out, ' ');
+		else
+			strbuf_addch(&out, c);
+		q++;
+	} while (1);
+	*query = q;
+	return strbuf_detach(&out, NULL);
+}
+
+char *url_decode(const char *url)
+{
+	return url_decode_internal(&url, NULL);
+}
+
+char *url_decode_parameter_name(const char **query)
+{
+	return url_decode_internal(query, "&=");
+}
+
+char *url_decode_parameter_value(const char **query)
+{
+	return url_decode_internal(query, "&");
+}
diff --git a/url.h b/url.h
new file mode 100644
index 0000000..15817f8
--- /dev/null
+++ b/url.h
@@ -0,0 +1,10 @@
+#ifndef URL_H
+#define URL_H
+
+extern int is_url(const char *url);
+extern int is_urlschemechar(int first_flag, int ch);
+extern char *url_decode(const char *url);
+extern char *url_decode_parameter_name(const char **query);
+extern char *url_decode_parameter_value(const char **query);
+
+#endif /* URL_H */
-- 
1.7.1.356.gc7d3.dirty
