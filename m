From: Jeff King <peff@peff.net>
Subject: [PATCH 05/13] http: use credential API to get passwords
Date: Thu, 24 Nov 2011 06:01:50 -0500
Message-ID: <20111124110150.GC8417@sigill.intra.peff.net>
References: <20111124105801.GA6168@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 12:02:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTX42-00049T-Mg
	for gcvg-git-2@lo.gmane.org; Thu, 24 Nov 2011 12:01:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755948Ab1KXLBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Nov 2011 06:01:54 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49640
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755935Ab1KXLBw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2011 06:01:52 -0500
Received: (qmail 10182 invoked by uid 107); 24 Nov 2011 11:02:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Nov 2011 06:02:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Nov 2011 06:01:50 -0500
Content-Disposition: inline
In-Reply-To: <20111124105801.GA6168@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185900>

This patch converts the http code to use the new credential
API, both for http authentication as well as for getting
certificate passwords.

Most of the code change is simply variable naming (the
passwords are now contained inside the credential struct)
or deletion of obsolete code (the credential code handles
URL parsing and prompting for us).

The behavior should be the same, with one exception: the
credential code will prompt with a description based on the
credential components. Therefore, the old prompt of:

  Username for 'example.com':
  Password for 'example.com':

now looks like:

  Username for 'https://example.com/repo.git':
  Password for 'https://user@example.com/repo.git':

Note that we include more information in each line,
specifically:

  1. We now include the protocol. While more noisy, this is
     an important part of knowing what you are accessing
     (especially if you care about http vs https).

  2. We include the username in the password prompt. This is
     not a big deal when you have just been prompted for it,
     but the username may also come from the remote's URL
     (and after future patches, from configuration or
     credential helpers).  In that case, it's a nice
     reminder of the user for which you're giving the
     password.

  3. We include the path component of the URL. In many
     cases, the user won't care about this and it's simply
     noise (i.e., they'll use the same credential for a
     whole site). However, that is part of a larger
     question, which is whether path components should be
     part of credential context, both for prompting and for
     lookup by storage helpers. That issue will be addressed
     as a whole in a future patch.

Similarly, for unlocking certificates, we used to say:

  Certificate Password for 'example.com':

and we now say:

  Password for 'cert:///path/to/certificate':

Showing the path to the client certificate makes more sense,
as that is what you are unlocking, not "example.com".

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c                |  113 +++++++++++--------------------------------------
 t/t5550-http-fetch.sh |   38 ++++++++++++-----
 2 files changed, 52 insertions(+), 99 deletions(-)

diff --git a/http.c b/http.c
index e6c7597..917a1ae 100644
--- a/http.c
+++ b/http.c
@@ -3,6 +3,7 @@
 #include "sideband.h"
 #include "run-command.h"
 #include "url.h"
+#include "credential.h"
 
 int data_received;
 int active_requests;
@@ -42,7 +43,7 @@
 static int curl_ftp_no_epsv;
 static const char *curl_http_proxy;
 static const char *curl_cookie_file;
-static char *user_name, *user_pass, *description;
+static struct credential http_auth = CREDENTIAL_INIT;
 static const char *user_agent;
 
 #if LIBCURL_VERSION_NUM >= 0x071700
@@ -53,7 +54,7 @@
 #define CURLOPT_KEYPASSWD CURLOPT_SSLCERTPASSWD
 #endif
 
-static char *ssl_cert_password;
+static struct credential cert_auth = CREDENTIAL_INIT;
 static int ssl_cert_password_required;
 
 static struct curl_slist *pragma_header;
@@ -139,27 +140,6 @@ static void process_curl_messages(void)
 }
 #endif
 
-static char *git_getpass_with_description(const char *what, const char *desc)
-{
-	struct strbuf prompt = STRBUF_INIT;
-	char *r;
-
-	if (desc)
-		strbuf_addf(&prompt, "%s for '%s': ", what, desc);
-	else
-		strbuf_addf(&prompt, "%s: ", what);
-	/*
-	 * NEEDSWORK: for usernames, we should do something less magical that
-	 * actually echoes the characters. However, we need to read from
-	 * /dev/tty and not stdio, which is not portable (but getpass will do
-	 * it for us). http.c uses the same workaround.
-	 */
-	r = git_getpass(prompt.buf);
-
-	strbuf_release(&prompt);
-	return xstrdup(r);
-}
-
 static int http_options(const char *var, const char *value, void *cb)
 {
 	if (!strcmp("http.sslverify", var)) {
@@ -232,11 +212,11 @@ static int http_options(const char *var, const char *value, void *cb)
 
 static void init_curl_http_auth(CURL *result)
 {
-	if (user_name) {
+	if (http_auth.username) {
 		struct strbuf up = STRBUF_INIT;
-		if (!user_pass)
-			user_pass = xstrdup(git_getpass_with_description("Password", description));
-		strbuf_addf(&up, "%s:%s", user_name, user_pass);
+		credential_fill(&http_auth);
+		strbuf_addf(&up, "%s:%s",
+			    http_auth.username, http_auth.password);
 		curl_easy_setopt(result, CURLOPT_USERPWD,
 				 strbuf_detach(&up, NULL));
 	}
@@ -244,18 +224,14 @@ static void init_curl_http_auth(CURL *result)
 
 static int has_cert_password(void)
 {
-	if (ssl_cert_password != NULL)
-		return 1;
 	if (ssl_cert == NULL || ssl_cert_password_required != 1)
 		return 0;
-	/* Only prompt the user once. */
-	ssl_cert_password_required = -1;
-	ssl_cert_password = git_getpass_with_description("Certificate Password", description);
-	if (ssl_cert_password != NULL) {
-		ssl_cert_password = xstrdup(ssl_cert_password);
-		return 1;
-	} else
-		return 0;
+	if (!cert_auth.password) {
+		cert_auth.protocol = xstrdup("cert");
+		cert_auth.path = xstrdup(ssl_cert);
+		credential_fill(&cert_auth);
+	}
+	return 1;
 }
 
 static CURL *get_curl_handle(void)
@@ -282,7 +258,7 @@ static int has_cert_password(void)
 	if (ssl_cert != NULL)
 		curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
 	if (has_cert_password())
-		curl_easy_setopt(result, CURLOPT_KEYPASSWD, ssl_cert_password);
+		curl_easy_setopt(result, CURLOPT_KEYPASSWD, cert_auth.password);
 #if LIBCURL_VERSION_NUM >= 0x070903
 	if (ssl_key != NULL)
 		curl_easy_setopt(result, CURLOPT_SSLKEY, ssl_key);
@@ -324,42 +300,6 @@ static int has_cert_password(void)
 	return result;
 }
 
-static void http_auth_init(const char *url)
-{
-	const char *at, *colon, *cp, *slash, *host;
-
-	cp = strstr(url, "://");
-	if (!cp)
-		return;
-
-	/*
-	 * Ok, the URL looks like "proto://something".  Which one?
-	 * "proto://<user>:<pass>@<host>/...",
-	 * "proto://<user>@<host>/...", or just
-	 * "proto://<host>/..."?
-	 */
-	cp += 3;
-	at = strchr(cp, '@');
-	colon = strchr(cp, ':');
-	slash = strchrnul(cp, '/');
-	if (!at || slash <= at) {
-		/* No credentials, but we may have to ask for some later */
-		host = cp;
-	}
-	else if (!colon || at <= colon) {
-		/* Only username */
-		user_name = url_decode_mem(cp, at - cp);
-		user_pass = NULL;
-		host = at + 1;
-	} else {
-		user_name = url_decode_mem(cp, colon - cp);
-		user_pass = url_decode_mem(colon + 1, at - (colon + 1));
-		host = at + 1;
-	}
-
-	description = url_decode_mem(host, slash - host);
-}
-
 static void set_from_env(const char **var, const char *envname)
 {
 	const char *val = getenv(envname);
@@ -432,7 +372,7 @@ void http_init(struct remote *remote, const char *url)
 		curl_ftp_no_epsv = 1;
 
 	if (url) {
-		http_auth_init(url);
+		credential_from_url(&http_auth, url);
 		if (!ssl_cert_password_required &&
 		    getenv("GIT_SSL_CERT_PASSWORD_PROTECTED") &&
 		    !prefixcmp(url, "https://"))
@@ -481,10 +421,10 @@ void http_cleanup(void)
 		curl_http_proxy = NULL;
 	}
 
-	if (ssl_cert_password != NULL) {
-		memset(ssl_cert_password, 0, strlen(ssl_cert_password));
-		free(ssl_cert_password);
-		ssl_cert_password = NULL;
+	if (cert_auth.password != NULL) {
+		memset(cert_auth.password, 0, strlen(cert_auth.password));
+		free(cert_auth.password);
+		cert_auth.password = NULL;
 	}
 	ssl_cert_password_required = 0;
 }
@@ -836,17 +776,11 @@ static int http_request(const char *url, void *result, int target, int options)
 		else if (missing_target(&results))
 			ret = HTTP_MISSING_TARGET;
 		else if (results.http_code == 401) {
-			if (user_name && user_pass) {
+			if (http_auth.username && http_auth.password) {
+				credential_reject(&http_auth);
 				ret = HTTP_NOAUTH;
 			} else {
-				/*
-				 * git_getpass is needed here because its very likely stdin/stdout are
-				 * pipes to our parent process.  So we instead need to use /dev/tty,
-				 * but that is non-portable.  Using git_getpass() can at least be stubbed
-				 * on other platforms with a different implementation if/when necessary.
-				 */
-				if (!user_name)
-					user_name = xstrdup(git_getpass_with_description("Username", description));
+				credential_fill(&http_auth);
 				init_curl_http_auth(slot->curl);
 				ret = HTTP_REAUTH;
 			}
@@ -866,6 +800,9 @@ static int http_request(const char *url, void *result, int target, int options)
 	curl_slist_free_all(headers);
 	strbuf_release(&buf);
 
+	if (ret == HTTP_OK)
+		credential_approve(&http_auth);
+
 	return ret;
 }
 
diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index 3d6e871..398a2d2 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -49,40 +49,56 @@ test_expect_success 'setup askpass helpers' '
 	EOF
 	chmod +x askpass &&
 	GIT_ASKPASS="$PWD/askpass" &&
-	export GIT_ASKPASS &&
-	>askpass-expect-none &&
-	echo "askpass: Password for '\''$HTTPD_DEST'\'': " >askpass-expect-pass &&
-	{ echo "askpass: Username for '\''$HTTPD_DEST'\'': " &&
-	  cat askpass-expect-pass
-	} >askpass-expect-both
-'
+	export GIT_ASKPASS
+'
+
+expect_askpass() {
+	dest=$HTTPD_DEST/auth/repo.git
+	{
+		case "$1" in
+		none)
+			;;
+		pass)
+			echo "askpass: Password for 'http://$2@$dest': "
+			;;
+		both)
+			echo "askpass: Username for 'http://$dest': "
+			echo "askpass: Password for 'http://$2@$dest': "
+			;;
+		*)
+			false
+			;;
+		esac
+	} >askpass-expect &&
+	test_cmp askpass-expect askpass-query
+}
 
 test_expect_success 'cloning password-protected repository can fail' '
 	>askpass-query &&
 	echo wrong >askpass-response &&
 	test_must_fail git clone "$HTTPD_URL/auth/repo.git" clone-auth-fail &&
-	test_cmp askpass-expect-both askpass-query
+	expect_askpass both wrong
 '
 
 test_expect_success 'http auth can use user/pass in URL' '
 	>askpass-query &&
 	echo wrong >askpass-response &&
 	git clone "$HTTPD_URL_USER_PASS/auth/repo.git" clone-auth-none &&
-	test_cmp askpass-expect-none askpass-query
+	expect_askpass none
 '
 
 test_expect_success 'http auth can use just user in URL' '
 	>askpass-query &&
 	echo user@host >askpass-response &&
 	git clone "$HTTPD_URL_USER/auth/repo.git" clone-auth-pass &&
-	test_cmp askpass-expect-pass askpass-query
+	expect_askpass pass user@host
 '
 
 test_expect_success 'http auth can request both user and pass' '
 	>askpass-query &&
 	echo user@host >askpass-response &&
 	git clone "$HTTPD_URL/auth/repo.git" clone-auth-both &&
-	test_cmp askpass-expect-both askpass-query
+	expect_askpass both user@host
 '
 
 test_expect_success 'fetch changes via http' '
-- 
1.7.7.4.5.gb32a5
