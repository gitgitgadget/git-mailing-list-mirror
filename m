From: Knut Franke <k.franke@science-computing.de>
Subject: [PATCH 1/2] http: allow selection of proxy authentication method
Date: Mon, 26 Oct 2015 18:55:08 +0100
Message-ID: <1445882109-18184-1-git-send-email-k.franke@science-computing.de>
Cc: Knut Franke <k.franke@science-computing.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 26 19:05:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zqm9Y-0000ku-5G
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 19:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752824AbbJZSFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 14:05:46 -0400
Received: from mx1.science-computing.de ([217.243.222.155]:28484 "EHLO
	mx1.science-computing.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500AbbJZSFp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 14:05:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id 05D3E3B8A;
	Mon, 26 Oct 2015 18:55:34 +0100 (CET)
X-Virus-Scanned: amavisd-new
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (obi.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BBDH1gAg9ecO; Mon, 26 Oct 2015 18:55:33 +0100 (CET)
Received: from hallasan.science-computing.de (hallasan.science-computing.de [10.10.24.76])
	by scmail.science-computing.de (Postfix) with ESMTP id 80F02395E;
	Mon, 26 Oct 2015 18:55:33 +0100 (CET)
Received: by hallasan.science-computing.de (Postfix, from userid 1633)
	id 5B431A798C; Mon, 26 Oct 2015 18:55:46 +0100 (CET)
X-Mailer: git-send-email 2.3.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280204>

CURLAUTH_ANY does not work with proxies which answer unauthenticated requests
with a 307 redirect to an error page instead of a 407 listing supported
authentication methods. Therefore, allow the authentication method to be set
using the environment variable GIT_HTTP_PROXY_AUTHMETHOD or configuration
variables http.proxy-authmethod and remote.<name>.proxy-authmethod (in analogy
to http.proxy and remote.<name>.proxy).

The following values are supported:

* anyauth (default)
* basic
* digest
* negotiate
* ntlm

Signed-off-by: Knut Franke <k.franke@science-computing.de>
---
 Documentation/config.txt | 28 ++++++++++++++++++++++
 http.c                   | 61 ++++++++++++++++++++++++++++++++++++++++--------
 remote.c                 |  3 +++
 remote.h                 |  1 +
 4 files changed, 83 insertions(+), 10 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 391a0c3..9dff88d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1597,6 +1597,29 @@ http.proxy::
 	`curl(1)`).  This can be overridden on a per-remote basis; see
 	remote.<name>.proxy
 
+http.proxy-authmethod::
+	Set the method with which to authenticate against the HTTP proxy. This only
+    takes effect if the configured proxy URI contains a user name part (i.e. is
+    of the form 'user@host' or 'user@host:port'). This can be overridden on a
+    per-remote basis; see `remote.<name>.proxy-authmethod`. Both can be
+    overridden by the 'GIT_HTTP_PROXY_AUTHMETHOD' environment variable.
+    Possible values are:
++
+--
+* `anyauth` - Automatically pick a suitable authentication method. It is
+  assumed that the proxy answers an unauthenticated request with a 407
+  status code and one or more Proxy-authenticate headers with supported
+  authentication methods. This is the default.
+* `basic` - HTTP Basic authentication
+* `digest` - HTTP Digest authentication; this prevents the password from being
+  transmitted to the proxy in clear text
+* `negotiate` - GSS-Negotiate authentication (compare the --negotiate option
+  of `curl(1)`)
+* `ntlm` - NTLM authentication (compare the --ntlm option of `curl(1)`)
+--
++
+
+
 http.cookieFile::
 	File containing previously stored cookie lines which should be used
 	in the Git http session, if they match the server. The file format
@@ -2390,6 +2413,11 @@ remote.<name>.proxy::
 	the proxy to use for that remote.  Set to the empty string to
 	disable proxying for that remote.
 
+remote.<name>.proxy-authmethod::
+    For remotes that require curl (http, https and ftp), the method to use for
+    authenticating against the proxy in use (probably set in
+    `remote.<name>.proxy`). See `http.proxy-authmethod`.
+
 remote.<name>.fetch::
 	The default set of "refspec" for linkgit:git-fetch[1]. See
 	linkgit:git-fetch[1].
diff --git a/http.c b/http.c
index 7da76ed..f7366d0 100644
--- a/http.c
+++ b/http.c
@@ -63,6 +63,7 @@ static long curl_low_speed_limit = -1;
 static long curl_low_speed_time = -1;
 static int curl_ftp_no_epsv;
 static const char *curl_http_proxy;
+static const char *http_proxy_authmethod = NULL;
 static const char *curl_cookie_file;
 static int curl_save_cookies;
 struct credential http_auth = CREDENTIAL_INIT;
@@ -257,6 +258,9 @@ static int http_options(const char *var, const char *value, void *cb)
 	if (!strcmp("http.proxy", var))
 		return git_config_string(&curl_http_proxy, var, value);
 
+	if (!strcmp("http.proxy-authmethod", var))
+		return git_config_string(&http_proxy_authmethod, var, value);
+
 	if (!strcmp("http.cookiefile", var))
 		return git_config_string(&curl_cookie_file, var, value);
 	if (!strcmp("http.savecookies", var)) {
@@ -305,6 +309,43 @@ static void init_curl_http_auth(CURL *result)
 #endif
 }
 
+static void set_from_env(const char **var, const char *envname)
+{
+	const char *val = getenv(envname);
+	if (val)
+		*var = val;
+}
+
+static void init_curl_proxy_auth(CURL *result)
+{
+    set_from_env(&http_proxy_authmethod, "GIT_HTTP_PROXY_AUTHMETHOD");
+
+	if (http_proxy_authmethod) {
+		if (!strcmp(http_proxy_authmethod, "basic"))
+			curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_BASIC);
+		else if (!strcmp(http_proxy_authmethod, "digest"))
+			curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_DIGEST);
+		else if (!strcmp(http_proxy_authmethod, "negotiate"))
+			curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_GSSNEGOTIATE);
+		else if (!strcmp(http_proxy_authmethod, "ntlm"))
+			curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_NTLM);
+#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
+		else if (!strcmp(http_proxy_authmethod, "anyauth"))
+			curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
+#endif
+		// CURLAUTH_DIGEST_IE has no corresponding command-line option in
+		// curl(1) and is not included in CURLAUTH_ANY, so we leave it out
+		// here, too
+		else
+			error("Unknown proxy authentication method: %s",
+			      http_proxy_authmethod);
+	}
+#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
+	else
+		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
+#endif
+}
+
 static int has_cert_password(void)
 {
 	if (ssl_cert == NULL || ssl_cert_password_required != 1)
@@ -379,6 +420,7 @@ static CURL *get_curl_handle(void)
 	curl_easy_setopt(result, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
 #endif
 
+
 	if (http_proactive_auth)
 		init_curl_http_auth(result);
 
@@ -466,22 +508,13 @@ static CURL *get_curl_handle(void)
 	if (curl_http_proxy) {
 		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
 	}
-#if LIBCURL_VERSION_NUM >= 0x070a07
-	curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
-#endif
+	init_curl_proxy_auth(result);
 
 	set_curl_keepalive(result);
 
 	return result;
 }
 
-static void set_from_env(const char **var, const char *envname)
-{
-	const char *val = getenv(envname);
-	if (val)
-		*var = val;
-}
-
 void http_init(struct remote *remote, const char *url, int proactive_auth)
 {
 	char *low_speed_limit;
@@ -509,6 +542,9 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	if (remote && remote->http_proxy)
 		curl_http_proxy = xstrdup(remote->http_proxy);
 
+	if (remote && remote->http_proxy_authmethod)
+		http_proxy_authmethod = xstrdup(remote->http_proxy_authmethod);
+
 	pragma_header = curl_slist_append(pragma_header, "Pragma: no-cache");
 	no_pragma_header = curl_slist_append(no_pragma_header, "Pragma:");
 
@@ -607,6 +643,11 @@ void http_cleanup(void)
 		curl_http_proxy = NULL;
 	}
 
+	if (http_proxy_authmethod) {
+		free((void *)http_proxy_authmethod);
+		http_proxy_authmethod = NULL;
+	}
+
 	if (cert_auth.password != NULL) {
 		memset(cert_auth.password, 0, strlen(cert_auth.password));
 		free(cert_auth.password);
diff --git a/remote.c b/remote.c
index 1101f82..5704f86 100644
--- a/remote.c
+++ b/remote.c
@@ -427,6 +427,9 @@ static int handle_config(const char *key, const char *value, void *cb)
 	} else if (!strcmp(subkey, ".proxy")) {
 		return git_config_string((const char **)&remote->http_proxy,
 					 key, value);
+	} else if (!strcmp(subkey, ".proxy-authmethod")) {
+		return git_config_string((const char **)&remote->http_proxy_authmethod,
+					 key, value);
 	} else if (!strcmp(subkey, ".vcs")) {
 		return git_config_string(&remote->foreign_vcs, key, value);
 	}
diff --git a/remote.h b/remote.h
index 312b7ca..a221c5a 100644
--- a/remote.h
+++ b/remote.h
@@ -54,6 +54,7 @@ struct remote {
 	 * for curl remotes only
 	 */
 	char *http_proxy;
+	char *http_proxy_authmethod;
 };
 
 struct remote *remote_get(const char *name);
-- 
2.3.7

-- 
Vorstandsvorsitzender/Chairman of the board of management:
Gerd-Lothar Leonhart
Vorstand/Board of Management:
Dr. Bernd Finkbeiner, Dr. Arno Steitz
Vorsitzender des Aufsichtsrats/
Chairman of the Supervisory Board:
Philippe Miltin
Sitz/Registered Office: Tuebingen
Registergericht/Registration Court: Stuttgart
Registernummer/Commercial Register No.: HRB 382196
