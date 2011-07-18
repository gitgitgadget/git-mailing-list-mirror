From: Jeff King <peff@peff.net>
Subject: [PATCH 02/14] url: decode buffers that are not NUL-terminated
Date: Mon, 18 Jul 2011 03:48:51 -0400
Message-ID: <20110718074851.GB12341@sigill.intra.peff.net>
References: <20110718074642.GA11678@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 09:49:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiiZc-0003iC-Vl
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 09:49:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753119Ab1GRHsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 03:48:54 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50615
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753003Ab1GRHsx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 03:48:53 -0400
Received: (qmail 19717 invoked by uid 107); 18 Jul 2011 07:49:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Jul 2011 03:49:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jul 2011 03:48:51 -0400
Content-Disposition: inline
In-Reply-To: <20110718074642.GA11678@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177345>

The url_decode function needs only minor tweaks to handle
arbitrary buffers. Let's do those tweaks, which cleans up an
unreadable mess of temporary strings in http.c.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c |   27 ++++-----------------------
 url.c  |   26 ++++++++++++++++++--------
 url.h  |    1 +
 3 files changed, 23 insertions(+), 31 deletions(-)

diff --git a/http.c b/http.c
index a1ea3db..c93716c 100644
--- a/http.c
+++ b/http.c
@@ -307,8 +307,7 @@ static CURL *get_curl_handle(void)
 
 static void http_auth_init(const char *url)
 {
-	char *at, *colon, *cp, *slash, *decoded;
-	int len;
+	char *at, *colon, *cp, *slash;
 
 	cp = strstr(url, "://");
 	if (!cp)
@@ -328,29 +327,11 @@ static void http_auth_init(const char *url)
 		return; /* No credentials */
 	if (!colon || at <= colon) {
 		/* Only username */
-		len = at - cp;
-		user_name = xmalloc(len + 1);
-		memcpy(user_name, cp, len);
-		user_name[len] = '\0';
-		decoded = url_decode(user_name);
-		free(user_name);
-		user_name = decoded;
+		user_name = url_decode_mem(cp, at - cp);
 		user_pass = NULL;
 	} else {
-		len = colon - cp;
-		user_name = xmalloc(len + 1);
-		memcpy(user_name, cp, len);
-		user_name[len] = '\0';
-		decoded = url_decode(user_name);
-		free(user_name);
-		user_name = decoded;
-		len = at - (colon + 1);
-		user_pass = xmalloc(len + 1);
-		memcpy(user_pass, colon + 1, len);
-		user_pass[len] = '\0';
-		decoded = url_decode(user_pass);
-		free(user_pass);
-		user_pass = decoded;
+		user_name = url_decode_mem(cp, colon - cp);
+		user_pass = url_decode_mem(colon + 1, at - (colon + 1));
 	}
 }
 
diff --git a/url.c b/url.c
index 3e06fd3..389d9da 100644
--- a/url.c
+++ b/url.c
@@ -68,18 +68,20 @@ static int url_decode_char(const char *q)
 	return val;
 }
 
-static char *url_decode_internal(const char **query, const char *stop_at,
-				 struct strbuf *out, int decode_plus)
+static char *url_decode_internal(const char **query, int len,
+				 const char *stop_at, struct strbuf *out,
+				 int decode_plus)
 {
 	const char *q = *query;
 
-	do {
+	while (len) {
 		unsigned char c = *q;
 
 		if (!c)
 			break;
 		if (stop_at && strchr(stop_at, c)) {
 			q++;
+			len--;
 			break;
 		}
 
@@ -88,6 +90,7 @@ static char *url_decode_internal(const char **query, const char *stop_at,
 			if (0 <= val) {
 				strbuf_addch(out, val);
 				q += 3;
+				len -= 3;
 				continue;
 			}
 		}
@@ -97,34 +100,41 @@ static char *url_decode_internal(const char **query, const char *stop_at,
 		else
 			strbuf_addch(out, c);
 		q++;
-	} while (1);
+		len--;
+	}
 	*query = q;
 	return strbuf_detach(out, NULL);
 }
 
 char *url_decode(const char *url)
 {
+	return url_decode_mem(url, strlen(url));
+}
+
+char *url_decode_mem(const char *url, int len)
+{
 	struct strbuf out = STRBUF_INIT;
-	const char *colon = strchr(url, ':');
+	const char *colon = memchr(url, ':', len);
 
 	/* Skip protocol part if present */
 	if (colon && url < colon) {
 		strbuf_add(&out, url, colon - url);
+		len -= colon - url;
 		url = colon;
 	}
-	return url_decode_internal(&url, NULL, &out, 0);
+	return url_decode_internal(&url, len, NULL, &out, 0);
 }
 
 char *url_decode_parameter_name(const char **query)
 {
 	struct strbuf out = STRBUF_INIT;
-	return url_decode_internal(query, "&=", &out, 1);
+	return url_decode_internal(query, -1, "&=", &out, 1);
 }
 
 char *url_decode_parameter_value(const char **query)
 {
 	struct strbuf out = STRBUF_INIT;
-	return url_decode_internal(query, "&", &out, 1);
+	return url_decode_internal(query, -1, "&", &out, 1);
 }
 
 void end_url_with_slash(struct strbuf *buf, const char *url)
diff --git a/url.h b/url.h
index 7100e32..abdaf6f 100644
--- a/url.h
+++ b/url.h
@@ -4,6 +4,7 @@
 extern int is_url(const char *url);
 extern int is_urlschemechar(int first_flag, int ch);
 extern char *url_decode(const char *url);
+extern char *url_decode_mem(const char *url, int len);
 extern char *url_decode_parameter_name(const char **query);
 extern char *url_decode_parameter_value(const char **query);
 
-- 
1.7.6.rc1.12.g65e2
