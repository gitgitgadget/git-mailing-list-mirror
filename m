From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/6] url: decode buffers that are not NUL-terminated
Date: Fri, 14 Oct 2011 09:40:35 +0200
Message-ID: <66c8448543432308e8fce5e3e04076e875410f67.1318577792.git.git@drmicha.warpmail.net>
References: <4E9692BF.8040705@drmicha.warpmail.net>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 14 09:40:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REcNu-00061r-A3
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 09:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272Ab1JNHkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 03:40:46 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:48763 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753918Ab1JNHkp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2011 03:40:45 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id D8ED920B99;
	Fri, 14 Oct 2011 03:40:44 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute5.internal (MEProxy); Fri, 14 Oct 2011 03:40:44 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=qd
	LA+gF8LrCGMcKITnxiOvJlhfU=; b=ftF7LdinocHu41CF1nEgWLqgDFjyT1bEQu
	AjdXbzkztQDf79unkTDbm2hOEQaRMCgfg4cNCLE/eTYPqMVlv7HDnLT6DoKlvlNk
	4Oq7nYyD0tlxi+3n6F2jWQO0yJ2kSZ3qdRik53nLKiiXY0SrVGUfT6ryV2W4TPRV
	U75yCbgA0=
X-Sasl-enc: cyr3fymX5sD9lpD5VpQSKzZOrCDhCeMwZGDkRT/OFJ+M 1318578044
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 53F4B40499A;
	Fri, 14 Oct 2011 03:40:44 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.338.g0156b
In-Reply-To: <4E9692BF.8040705@drmicha.warpmail.net>
In-Reply-To: <cover.1318577792.git.git@drmicha.warpmail.net>
References: <cover.1318577792.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183547>

From: Jeff King <peff@peff.net>

The url_decode function needs only minor tweaks to handle
arbitrary buffers. Let's do those tweaks, which cleans up an
unreadable mess of temporary strings in http.c.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
1.7.7.338.g0156b
