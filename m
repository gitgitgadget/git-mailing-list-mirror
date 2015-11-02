From: Knut Franke <k.franke@science-computing.de>
Subject: [PATCH 1/2] http: allow selection of proxy authentication method
Date: Mon,  2 Nov 2015 17:54:23 +0100
Message-ID: <1446483264-15123-2-git-send-email-k.franke@science-computing.de>
References: <1445882109-18184-1-git-send-email-k.franke@science-computing.de>
 <1446483264-15123-1-git-send-email-k.franke@science-computing.de>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Knut Franke <k.franke@science-computing.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 02 18:04:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtIXA-0001KJ-NE
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 18:04:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754214AbbKBREc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 12:04:32 -0500
Received: from mx3.science-computing.de ([193.197.16.20]:14493 "EHLO
	mx3.science-computing.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754194AbbKBRE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 12:04:29 -0500
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id 764D74140;
	Mon,  2 Nov 2015 17:54:45 +0100 (CET)
X-Virus-Scanned: amavisd-new
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (guiness.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LQckC_Qz-ffz; Mon,  2 Nov 2015 17:54:44 +0100 (CET)
Received: from hallasan.science-computing.de (hallasan.science-computing.de [10.10.24.76])
	by scmail.science-computing.de (Postfix) with ESMTP id 9D4424900;
	Mon,  2 Nov 2015 17:54:44 +0100 (CET)
Received: by hallasan.science-computing.de (Postfix, from userid 1633)
	id 93B08A7980; Mon,  2 Nov 2015 17:54:44 +0100 (CET)
X-Mailer: git-send-email 2.3.7
In-Reply-To: <1446483264-15123-1-git-send-email-k.franke@science-computing.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280701>

CURLAUTH_ANY does not work with proxies which answer unauthenticated requests
with a 307 redirect to an error page instead of a 407 listing supported
authentication methods. Therefore, allow the authentication method to be set
using the environment variable GIT_HTTP_PROXY_AUTHMETHOD or configuration
variables http.proxyAuthmethod and remote.<name>.proxyAuthmethod (in analogy
to http.proxy and remote.<name>.proxy).

The following values are supported:

* anyauth (default)
* basic
* digest
* negotiate
* ntlm

Signed-off-by: Knut Franke <k.franke@science-computing.de>
Reviewed-by: Junio C Hamano <gitster@pobox.com>
Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/config.txt | 26 +++++++++++++++++
 http.c                   | 72 ++++++++++++++++++++++++++++++++++++++++++++++--
 remote.c                 |  3 ++
 remote.h                 |  1 +
 4 files changed, 99 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 391a0c3..6f29893 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1597,6 +1597,27 @@ http.proxy::
 	`curl(1)`).  This can be overridden on a per-remote basis; see
 	remote.<name>.proxy
 
+http.proxyAuthMethod::
+	Set the method with which to authenticate against the HTTP proxy. This only
+	takes effect if the configured proxy URI contains a user name part (i.e. is
+	of the form 'user@host' or 'user@host:port'). This can be overridden on a
+	per-remote basis; see `remote.<name>.proxyAuthMethod`. Both can be
+	overridden by the 'GIT_HTTP_PROXY_AUTHMETHOD' environment variable.
+	Possible values are:
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
+
 http.cookieFile::
 	File containing previously stored cookie lines which should be used
 	in the Git http session, if they match the server. The file format
@@ -2390,6 +2411,11 @@ remote.<name>.proxy::
 	the proxy to use for that remote.  Set to the empty string to
 	disable proxying for that remote.
 
+remote.<name>.proxyAuthMethod::
+	For remotes that require curl (http, https and ftp), the method to use for
+	authenticating against the proxy in use (probably set in
+	`remote.<name>.proxy`). See `http.proxyAuthMethod`.
+
 remote.<name>.fetch::
 	The default set of "refspec" for linkgit:git-fetch[1]. See
 	linkgit:git-fetch[1].
diff --git a/http.c b/http.c
index 7da76ed..1172819 100644
--- a/http.c
+++ b/http.c
@@ -63,6 +63,24 @@ static long curl_low_speed_limit = -1;
 static long curl_low_speed_time = -1;
 static int curl_ftp_no_epsv;
 static const char *curl_http_proxy;
+static const char *http_proxy_authmethod = NULL;
+static struct {
+	const char *name;
+	long curlauth_param;
+} proxy_authmethods[] = {
+	{ "basic", CURLAUTH_BASIC },
+	{ "digest", CURLAUTH_DIGEST },
+	{ "negotiate", CURLAUTH_GSSNEGOTIATE },
+	{ "ntlm", CURLAUTH_NTLM },
+#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
+	{ "anyauth", CURLAUTH_ANY },
+#endif
+	/*
+	 * CURLAUTH_DIGEST_IE has no corresponding command-line option in
+	 * curl(1) and is not included in CURLAUTH_ANY, so we leave it out
+	 * here, too
+	 */
+};
 static const char *curl_cookie_file;
 static int curl_save_cookies;
 struct credential http_auth = CREDENTIAL_INIT;
@@ -257,6 +275,9 @@ static int http_options(const char *var, const char *value, void *cb)
 	if (!strcmp("http.proxy", var))
 		return git_config_string(&curl_http_proxy, var, value);
 
+	if (!strcmp("http.proxyauthmethod", var))
+		return git_config_string(&http_proxy_authmethod, var, value);
+
 	if (!strcmp("http.cookiefile", var))
 		return git_config_string(&curl_cookie_file, var, value);
 	if (!strcmp("http.savecookies", var)) {
@@ -305,6 +326,42 @@ static void init_curl_http_auth(CURL *result)
 #endif
 }
 
+/* assumes *var is either NULL or free-able */
+static void env_override(const char **var, const char *envname)
+{
+	const char *val = getenv(envname);
+	if (val) {
+		if (*var)
+			free((void*)*var);
+		*var = xstrdup(val);
+	}
+}
+
+static void init_curl_proxy_auth(CURL *result)
+{
+	env_override(&http_proxy_authmethod, "GIT_HTTP_PROXY_AUTHMETHOD");
+
+#if LIBCURL_VERSION_NUM >= 0x070a07 /* CURLOPT_PROXYAUTH and CURLAUTH_ANY */
+	if (http_proxy_authmethod) {
+		int i;
+		for (i = 0; i < ARRAY_SIZE(proxy_authmethods); i++) {
+			if (!strcmp(http_proxy_authmethod, proxy_authmethods[i].name)) {
+				curl_easy_setopt(result, CURLOPT_PROXYAUTH,
+						proxy_authmethods[i].curlauth_param);
+				break;
+			}
+		}
+		if (i == ARRAY_SIZE(proxy_authmethods)) {
+			warning("unsupported proxy authentication method %s: using anyauth",
+					http_proxy_authmethod);
+			curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
+		}
+	}
+	else
+		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
+#endif
+}
+
 static int has_cert_password(void)
 {
 	if (ssl_cert == NULL || ssl_cert_password_required != 1)
@@ -466,9 +523,7 @@ static CURL *get_curl_handle(void)
 	if (curl_http_proxy) {
 		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
 	}
-#if LIBCURL_VERSION_NUM >= 0x070a07
-	curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
-#endif
+	init_curl_proxy_auth(result);
 
 	set_curl_keepalive(result);
 
@@ -509,6 +564,12 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	if (remote && remote->http_proxy)
 		curl_http_proxy = xstrdup(remote->http_proxy);
 
+	if (remote && remote->http_proxy_authmethod) {
+		if (http_proxy_authmethod)
+			free((void*)http_proxy_authmethod);
+		http_proxy_authmethod = xstrdup(remote->http_proxy_authmethod);
+	}
+
 	pragma_header = curl_slist_append(pragma_header, "Pragma: no-cache");
 	no_pragma_header = curl_slist_append(no_pragma_header, "Pragma:");
 
@@ -607,6 +668,11 @@ void http_cleanup(void)
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
index 10f1ffc..0e3bba8 100644
--- a/remote.c
+++ b/remote.c
@@ -428,6 +428,9 @@ static int handle_config(const char *key, const char *value, void *cb)
 	} else if (!strcmp(subkey, ".proxy")) {
 		return git_config_string((const char **)&remote->http_proxy,
 					 key, value);
+	} else if (!strcmp(subkey, ".proxyauthmethod")) {
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
