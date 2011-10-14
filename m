From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 5/6] http: use hostname in credential description
Date: Fri, 14 Oct 2011 09:40:39 +0200
Message-ID: <f3365a7c54c17c2c53e5204578a3406057e62b5f.1318577792.git.git@drmicha.warpmail.net>
References: <4E9692BF.8040705@drmicha.warpmail.net>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 14 09:41:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REcOA-0006DO-Eu
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 09:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932657Ab1JNHky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 03:40:54 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:50248 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932641Ab1JNHkw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2011 03:40:52 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 5B25320B80;
	Fri, 14 Oct 2011 03:40:52 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute4.internal (MEProxy); Fri, 14 Oct 2011 03:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=Wu
	Cm+HpLDh53Gv72IOUOfEZAkug=; b=ryFQZAb9wjP+QXlKqD10UQPFMyGABD5rhN
	Oyq+i7+kVHHPu/c/MFCW4jorGRv9OavnX9SK0IEABDUWoAVTaFsU6ZoCvJPHqWc+
	QmuVI5dTyKHgnKHqH9nWRgaarCSgIhINWr6ijwv9YB9K+TO8r8KhXNNFQ2x56q3b
	lqWrgpmWQ=
X-Sasl-enc: Ovc9JN0m2xb4mr+ullR7LkI4C7SDmwzv4i4121JFlXmF 1318578051
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id CC3C2404987;
	Fri, 14 Oct 2011 03:40:51 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.338.g0156b
In-Reply-To: <4E9692BF.8040705@drmicha.warpmail.net>
In-Reply-To: <cover.1318577792.git.git@drmicha.warpmail.net>
References: <cover.1318577792.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183552>

Until now, a request for an http password looked like:

  Username:
  Password:

Now it will look like:

  Username for 'example.com':
  Password for 'example.com':

Picked-from: Jeff King <peff@peff.net>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 http.c                |   41 +++++++++++++++++++++++++++++++++--------
 t/t5550-http-fetch.sh |    4 ++--
 2 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/http.c b/http.c
index 89e3cf4..149e116 100644
--- a/http.c
+++ b/http.c
@@ -42,7 +42,7 @@ static long curl_low_speed_time = -1;
 static int curl_ftp_no_epsv;
 static const char *curl_http_proxy;
 static const char *curl_cookie_file;
-static char *user_name, *user_pass;
+static char *user_name, *user_pass, *description;
 static const char *user_agent;
 
 #if LIBCURL_VERSION_NUM >= 0x071700
@@ -139,6 +139,25 @@ static void process_curl_messages(void)
 }
 #endif
 
+static char *git_getpass_one(const char *what, const char *desc)
+{
+	struct strbuf prompt = STRBUF_INIT;
+	char *r;
+
+	if (desc)
+		strbuf_addf(&prompt, "%s for '%s': ", what, desc);
+	else
+		strbuf_addf(&prompt, "%s: ", what);
+	/* FIXME: for usernames, we should do something less magical that
+	* actually echoes the characters. However, we need to read from
+	* /dev/tty and not stdio, which is not portable (but getpass will do
+	* it for us). http.c uses the same workaround. */
+	r = git_getpass(prompt.buf);
+
+	strbuf_release(&prompt);
+	return xstrdup(r);
+}
+
 static int http_options(const char *var, const char *value, void *cb)
 {
 	if (!strcmp("http.sslverify", var)) {
@@ -214,7 +233,7 @@ static void init_curl_http_auth(CURL *result)
 	if (user_name) {
 		struct strbuf up = STRBUF_INIT;
 		if (!user_pass)
-			user_pass = xstrdup(git_getpass("Password: "));
+			user_pass = xstrdup(git_getpass_one("Password", description));
 		strbuf_addf(&up, "%s:%s", user_name, user_pass);
 		curl_easy_setopt(result, CURLOPT_USERPWD,
 				 strbuf_detach(&up, NULL));
@@ -229,7 +248,7 @@ static int has_cert_password(void)
 		return 0;
 	/* Only prompt the user once. */
 	ssl_cert_password_required = -1;
-	ssl_cert_password = git_getpass("Certificate Password: ");
+	ssl_cert_password = git_getpass_one("Certificate Password", description);
 	if (ssl_cert_password != NULL) {
 		ssl_cert_password = xstrdup(ssl_cert_password);
 		return 1;
@@ -307,7 +326,7 @@ static CURL *get_curl_handle(void)
 
 static void http_auth_init(const char *url)
 {
-	char *at, *colon, *cp, *slash;
+	const char *at, *colon, *cp, *slash, *host;
 
 	cp = strstr(url, "://");
 	if (!cp)
@@ -323,16 +342,22 @@ static void http_auth_init(const char *url)
 	at = strchr(cp, '@');
 	colon = strchr(cp, ':');
 	slash = strchrnul(cp, '/');
-	if (!at || slash <= at)
-		return; /* No credentials */
-	if (!colon || at <= colon) {
+	if (!at || slash <= at) {
+		/* No credentials, but we may have to ask for some later */
+		host = cp;
+	}
+	else if (!colon || at <= colon) {
 		/* Only username */
 		user_name = url_decode_mem(cp, at - cp);
 		user_pass = NULL;
+		host = at + 1;
 	} else {
 		user_name = url_decode_mem(cp, colon - cp);
 		user_pass = url_decode_mem(colon + 1, at - (colon + 1));
+		host = at + 1;
 	}
+
+	description = url_decode_mem(host, slash - host);
 }
 
 static void set_from_env(const char **var, const char *envname)
@@ -828,7 +853,7 @@ static int http_request(const char *url, void *result, int target, int options)
 				 * but that is non-portable.  Using git_getpass() can at least be stubbed
 				 * on other platforms with a different implementation if/when necessary.
 				 */
-				user_name = xstrdup(git_getpass("Username: "));
+				user_name = xstrdup(git_getpass_one("Username", description));
 				init_curl_http_auth(slot->curl);
 				ret = HTTP_REAUTH;
 			}
diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index ed4db09..d1ab4d0 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -51,8 +51,8 @@ test_expect_success 'setup askpass helpers' '
 	GIT_ASKPASS="$PWD/askpass" &&
 	export GIT_ASKPASS &&
 	>askpass-expect-none &&
-	echo "askpass: Password: " >askpass-expect-pass &&
-	{ echo "askpass: Username: " &&
+	echo "askpass: Password for '\''$HTTPD_DEST'\'': " >askpass-expect-pass &&
+	{ echo "askpass: Username for '\''$HTTPD_DEST'\'': " &&
 	  cat askpass-expect-pass
 	} >askpass-expect-both
 '
-- 
1.7.7.338.g0156b
