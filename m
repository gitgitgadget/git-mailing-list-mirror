From: Jeff King <peff@peff.net>
Subject: [PATCH 07/14] http: use credential API to get passwords
Date: Mon, 18 Jul 2011 03:50:53 -0400
Message-ID: <20110718075053.GG12341@sigill.intra.peff.net>
References: <20110718074642.GA11678@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 09:51:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiibU-0004Sy-Vs
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 09:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227Ab1GRHu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 03:50:56 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50625
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752479Ab1GRHuz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 03:50:55 -0400
Received: (qmail 19857 invoked by uid 107); 18 Jul 2011 07:51:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Jul 2011 03:51:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jul 2011 03:50:53 -0400
Content-Disposition: inline
In-Reply-To: <20110718074642.GA11678@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177350>

This patch converts the http code to use the new credential
API, both for http authentication as well as for getting
certificate passwords.

Most of the code change is simply variable naming (the
passwords are now contained inside a struct). The biggest
change is determining a "unique" context to pass to the
credential API.  This patch uses "http:$host" for http
authentication and "cert:$file" for opening certificate
files.

We pass an empty list of methods to the credential API,
which means that we will use the internal credential_getpass
function. This should yield no behavior change, except that
we now print "Password for 'certificate':" instead of
"Certificate Password:" when asking for certificate
passwords.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c                |   90 +++++++++++++++++++++++++++----------------------
 t/t5550-http-fetch.sh |    2 +-
 2 files changed, 51 insertions(+), 41 deletions(-)

diff --git a/http.c b/http.c
index 89e3cf4..4c047be 100644
--- a/http.c
+++ b/http.c
@@ -3,6 +3,7 @@
 #include "sideband.h"
 #include "run-command.h"
 #include "url.h"
+#include "credential.h"
 
 int data_received;
 int active_requests;
@@ -42,7 +43,7 @@ static long curl_low_speed_time = -1;
 static int curl_ftp_no_epsv;
 static const char *curl_http_proxy;
 static const char *curl_cookie_file;
-static char *user_name, *user_pass;
+static struct credential http_auth;
 static const char *user_agent;
 
 #if LIBCURL_VERSION_NUM >= 0x071700
@@ -53,7 +54,7 @@ static const char *user_agent;
 #define CURLOPT_KEYPASSWD CURLOPT_SSLCERTPASSWD
 #endif
 
-static char *ssl_cert_password;
+static struct credential cert_auth;
 static int ssl_cert_password_required;
 
 static struct curl_slist *pragma_header;
@@ -211,11 +212,11 @@ static int http_options(const char *var, const char *value, void *cb)
 
 static void init_curl_http_auth(CURL *result)
 {
-	if (user_name) {
+	if (http_auth.username) {
 		struct strbuf up = STRBUF_INIT;
-		if (!user_pass)
-			user_pass = xstrdup(git_getpass("Password: "));
-		strbuf_addf(&up, "%s:%s", user_name, user_pass);
+		credential_fill(&http_auth, NULL);
+		strbuf_addf(&up, "%s:%s",
+			    http_auth.username, http_auth.password);
 		curl_easy_setopt(result, CURLOPT_USERPWD,
 				 strbuf_detach(&up, NULL));
 	}
@@ -223,18 +224,19 @@ static void init_curl_http_auth(CURL *result)
 
 static int has_cert_password(void)
 {
-	if (ssl_cert_password != NULL)
-		return 1;
 	if (ssl_cert == NULL || ssl_cert_password_required != 1)
 		return 0;
-	/* Only prompt the user once. */
-	ssl_cert_password_required = -1;
-	ssl_cert_password = git_getpass("Certificate Password: ");
-	if (ssl_cert_password != NULL) {
-		ssl_cert_password = xstrdup(ssl_cert_password);
-		return 1;
-	} else
-		return 0;
+	if (!cert_auth.description)
+		cert_auth.description = "certificate";
+	if (!cert_auth.unique) {
+		struct strbuf unique = STRBUF_INIT;
+		strbuf_addf(&unique, "cert:%s", ssl_cert);
+		cert_auth.unique = strbuf_detach(&unique, NULL);
+	}
+	if (!cert_auth.username)
+		cert_auth.username = xstrdup("");
+	credential_fill(&cert_auth, NULL);
+	return 1;
 }
 
 static CURL *get_curl_handle(void)
@@ -263,7 +265,7 @@ static CURL *get_curl_handle(void)
 	if (ssl_cert != NULL)
 		curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
 	if (has_cert_password())
-		curl_easy_setopt(result, CURLOPT_KEYPASSWD, ssl_cert_password);
+		curl_easy_setopt(result, CURLOPT_KEYPASSWD, cert_auth.password);
 #if LIBCURL_VERSION_NUM >= 0x070903
 	if (ssl_key != NULL)
 		curl_easy_setopt(result, CURLOPT_SSLKEY, ssl_key);
@@ -307,10 +309,12 @@ static CURL *get_curl_handle(void)
 
 static void http_auth_init(const char *url)
 {
-	char *at, *colon, *cp, *slash;
+	const char *at, *colon, *cp, *slash, *host, *proto_end;
+	char *decoded;
+	struct strbuf unique = STRBUF_INIT;
 
-	cp = strstr(url, "://");
-	if (!cp)
+	proto_end = strstr(url, "://");
+	if (!proto_end)
 		return;
 
 	/*
@@ -319,20 +323,31 @@ static void http_auth_init(const char *url)
 	 * "proto://<user>@<host>/...", or just
 	 * "proto://<host>/..."?
 	 */
-	cp += 3;
+	cp = proto_end + 3;
 	at = strchr(cp, '@');
 	colon = strchr(cp, ':');
 	slash = strchrnul(cp, '/');
-	if (!at || slash <= at)
-		return; /* No credentials */
-	if (!colon || at <= colon) {
+
+	if (!at || slash <= at) {
+		/* No credentials, but we may have to ask for some later */
+		host = cp;
+	}
+	else if (!colon || at <= colon) {
 		/* Only username */
-		user_name = url_decode_mem(cp, at - cp);
-		user_pass = NULL;
+		http_auth.username = url_decode_mem(cp, at - cp);
+		host = at + 1;
 	} else {
-		user_name = url_decode_mem(cp, colon - cp);
-		user_pass = url_decode_mem(colon + 1, at - (colon + 1));
+		http_auth.username = url_decode_mem(cp, colon - cp);
+		http_auth.password = url_decode_mem(colon + 1, at - (colon + 1));
+		host = at + 1;
 	}
+
+	strbuf_add(&unique, url, proto_end - url);
+	strbuf_addch(&unique, ':');
+	decoded = url_decode_mem(host, slash - host);
+	strbuf_addstr(&unique, decoded);
+	free(decoded);
+	http_auth.unique = strbuf_detach(&unique, NULL);
 }
 
 static void set_from_env(const char **var, const char *envname)
@@ -456,10 +471,10 @@ void http_cleanup(void)
 		curl_http_proxy = NULL;
 	}
 
-	if (ssl_cert_password != NULL) {
-		memset(ssl_cert_password, 0, strlen(ssl_cert_password));
-		free(ssl_cert_password);
-		ssl_cert_password = NULL;
+	if (cert_auth.password) {
+		memset(cert_auth.password, 0, strlen(cert_auth.password));
+		free(cert_auth.password);
+		cert_auth.password = NULL;
 	}
 	ssl_cert_password_required = 0;
 }
@@ -819,16 +834,11 @@ static int http_request(const char *url, void *result, int target, int options)
 		else if (missing_target(&results))
 			ret = HTTP_MISSING_TARGET;
 		else if (results.http_code == 401) {
-			if (user_name) {
+			if (http_auth.username) {
+				credential_reject(&http_auth, NULL);
 				ret = HTTP_NOAUTH;
 			} else {
-				/*
-				 * git_getpass is needed here because its very likely stdin/stdout are
-				 * pipes to our parent process.  So we instead need to use /dev/tty,
-				 * but that is non-portable.  Using git_getpass() can at least be stubbed
-				 * on other platforms with a different implementation if/when necessary.
-				 */
-				user_name = xstrdup(git_getpass("Username: "));
+				credential_fill(&http_auth, NULL);
 				init_curl_http_auth(slot->curl);
 				ret = HTTP_REAUTH;
 			}
diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index ed4db09..af3bc6b 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -66,7 +66,7 @@ test_expect_success 'cloning password-protected repository can fail' '
 
 test_expect_success 'http auth can use user/pass in URL' '
 	>askpass-query &&
-	echo wrong >askpass-reponse &&
+	echo wrong >askpass-response &&
 	git clone "$HTTPD_URL_USER_PASS/auth/repo.git" clone-auth-none &&
 	test_cmp askpass-expect-none askpass-query
 '
-- 
1.7.6.rc1.12.g65e2
