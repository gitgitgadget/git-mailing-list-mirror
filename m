Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07F7C433EF
	for <git@archiver.kernel.org>; Fri, 13 May 2022 07:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377736AbiEMHNM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 May 2022 03:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377722AbiEMHMs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 May 2022 03:12:48 -0400
Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BC326C4CE
        for <git@vger.kernel.org>; Fri, 13 May 2022 00:12:45 -0700 (PDT)
Received: by psionic.psi5.com (Postfix, from userid 1002)
        id 845BD40CA9; Fri, 13 May 2022 09:04:42 +0200 (CEST)
From:   Simon.Richter@hogyros.de
To:     git@vger.kernel.org
Cc:     Simon Richter <Simon.Richter@hogyros.de>
Subject: [PATCH 2/3] Add config option/env var to limit HTTP auth methods
Date:   Fri, 13 May 2022 09:04:15 +0200
Message-Id: <20220513070416.37235-3-Simon.Richter@hogyros.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513070416.37235-1-Simon.Richter@hogyros.de>
References: <20220513070416.37235-1-Simon.Richter@hogyros.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Simon Richter <Simon.Richter@hogyros.de>

This allows forcing an authentication mechanism when the available
credentials do not match the automatically selected "best" mechanism.

For example, MS DevOps server supports both NTLM and Basic authentication,
but the NTLM backend is connected to the user database only and does not
accept Personal Access Tokens; curl however selects NTLM over Basic if both
are available.

Signed-off-by: Simon Richter <Simon.Richter@hogyros.de>
---
 Documentation/config/http.txt   | 19 +++++++++++++++++++
 Documentation/config/remote.txt |  4 ++++
 http.c                          | 33 ++++++++++++++++++++++++++++++++-
 remote.c                        |  4 ++++
 remote.h                        |  3 +++
 5 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
index 7003661c0d..d9875afa4d 100644
--- a/Documentation/config/http.txt
+++ b/Documentation/config/http.txt
@@ -1,3 +1,22 @@
+http.authMethod::
+	Set the method with which to authenticate to the HTTP server, if
+	required. This can be overridden on a per-remote basis; see
+	`remote.<name>.authMethod`. Both can be overridden by the
+	`GIT_HTTP_AUTHMETHOD` environment variable.  Possible values are:
++
+--
+* `anyauth` - Automatically pick a suitable authentication method. It is
+  assumed that the server answers an unauthenticated request with a 401
+  status code and one or more WWW-Authenticate headers with supported
+  authentication methods. This is the default.
+* `basic` - HTTP Basic authentication
+* `digest` - HTTP Digest authentication; this prevents the password from being
+  transmitted to the server in clear text
+* `negotiate` - GSS-Negotiate authentication (compare the --negotiate option
+  of `curl(1)`)
+* `ntlm` - NTLM authentication (compare the --ntlm option of `curl(1)`)
+--
+
 http.proxy::
 	Override the HTTP proxy, normally configured using the 'http_proxy',
 	'https_proxy', and 'all_proxy' environment variables (see `curl(1)`). In
diff --git a/Documentation/config/remote.txt b/Documentation/config/remote.txt
index 0678b4bcfe..0f87234427 100644
--- a/Documentation/config/remote.txt
+++ b/Documentation/config/remote.txt
@@ -10,6 +10,10 @@ remote.<name>.url::
 remote.<name>.pushurl::
 	The push URL of a remote repository.  See linkgit:git-push[1].
 
+remote.<name>.authMethod::
+	For http and https remotes, the method to use for
+	authenticating against the server. See `http.authMethod`.
+
 remote.<name>.proxy::
 	For remotes that require curl (http, https and ftp), the URL to
 	the proxy to use for that remote.  Set to the empty string to
diff --git a/http.c b/http.c
index 318dc5daea..c5af90b1b8 100644
--- a/http.c
+++ b/http.c
@@ -108,6 +108,7 @@ static const char *curl_proxyuserpwd;
 static const char *curl_cookie_file;
 static int curl_save_cookies;
 struct credential http_auth = CREDENTIAL_INIT;
+static const char *http_authmethod;
 static int http_proactive_auth;
 static const char *user_agent;
 static int curl_empty_auth = -1;
@@ -356,6 +357,9 @@ static int http_options(const char *var, const char *value, void *cb)
 	if (!strcmp("http.useragent", var))
 		return git_config_string(&user_agent, var, value);
 
+	if (!strcmp("http.authmethod", var))
+		return git_config_string(&http_authmethod, var, value);
+
 	if (!strcmp("http.emptyauth", var)) {
 		if (value && !strcmp("auto", value))
 			curl_empty_auth = -1;
@@ -450,6 +454,27 @@ static void var_override(const char **var, char *value)
 	}
 }
 
+static void init_curl_http_auth_method(CURL *result)
+{
+	var_override(&http_authmethod, getenv("GIT_HTTP_AUTHMETHOD"));
+
+	if (http_authmethod) {
+		int i;
+		for (i = 0; i < ARRAY_SIZE(authmethods); i++) {
+			if (!strcmp(http_authmethod, authmethods[i].name)) {
+				http_auth_methods = authmethods[i].curlauth_param;
+				break;
+			}
+		}
+		if (i == ARRAY_SIZE(authmethods)) {
+			warning("unsupported authentication method %s: using anyauth",
+					http_authmethod);
+			http_auth_methods = CURLAUTH_ANY;
+		}
+	}
+	curl_easy_setopt(result, CURLOPT_HTTPAUTH, http_auth_methods);
+}
+
 static void set_proxyauth_name_password(CURL *result)
 {
 		curl_easy_setopt(result, CURLOPT_PROXYUSERNAME,
@@ -786,7 +811,7 @@ static CURL *get_curl_handle(void)
 #endif
 
 	curl_easy_setopt(result, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
-	curl_easy_setopt(result, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
+	init_curl_http_auth_method(result);
 
 #ifdef CURLGSSAPI_DELEGATION_FLAG
 	if (curl_deleg) {
@@ -1040,6 +1065,9 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	if (remote && remote->http_proxy)
 		curl_http_proxy = xstrdup(remote->http_proxy);
 
+	if (remote)
+		var_override(&http_authmethod, remote->http_authmethod);
+
 	if (remote)
 		var_override(&http_proxy_authmethod, remote->http_proxy_authmethod);
 
@@ -1504,6 +1532,9 @@ static int handle_curl_result(struct slot_results *results)
 			if (results->auth_avail) {
 				http_auth_methods &= results->auth_avail;
 				http_auth_methods_restricted = 1;
+				/* fail if no methods left */
+				if(http_auth_methods == 0)
+					return HTTP_NOAUTH;
 			}
 			return HTTP_REAUTH;
 		}
diff --git a/remote.c b/remote.c
index 42a4e7106e..dca7b82c9f 100644
--- a/remote.c
+++ b/remote.c
@@ -155,6 +155,7 @@ static void remote_clear(struct remote *remote)
 	FREE_AND_NULL(remote->pushurl);
 	free((char *)remote->receivepack);
 	free((char *)remote->uploadpack);
+	FREE_AND_NULL(remote->http_authmethod);
 	FREE_AND_NULL(remote->http_proxy);
 	FREE_AND_NULL(remote->http_proxy_authmethod);
 }
@@ -461,6 +462,9 @@ static int handle_config(const char *key, const char *value, void *cb)
 			remote->fetch_tags = -1;
 		else if (!strcmp(value, "--tags"))
 			remote->fetch_tags = 2;
+	} else if (!strcmp(subkey, "authmethod")) {
+		return git_config_string((const char **)&remote->http_authmethod,
+					 key, value);
 	} else if (!strcmp(subkey, "proxy")) {
 		return git_config_string((const char **)&remote->http_proxy,
 					 key, value);
diff --git a/remote.h b/remote.h
index 4a1209ae2c..c063d30356 100644
--- a/remote.h
+++ b/remote.h
@@ -105,6 +105,9 @@ struct remote {
 	const char *receivepack;
 	const char *uploadpack;
 
+	/* The method for authenticating against the (HTTP) server */
+	char *http_authmethod;
+
 	/* The proxy to use for curl (http, https, ftp, etc.) URLs. */
 	char *http_proxy;
 
-- 
2.30.2

