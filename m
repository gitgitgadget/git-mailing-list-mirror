Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D012CA92E
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 01:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712451837; cv=none; b=smfB0GKIB3I9Z4mC7yqNnvWNMzkXDNQ4diHw4cKL84KRByIC2Dgjs+ZwLpIs99rXuUgaCmy7sYjNVosBN2L/XOJ9uSue9TDSbZf2VBSqk5/yZDxznlNr6teYV3yht4yKkcp7r8baXCJ5lbnanGm4Rk5WSEAQaYR5OK69y5LpQyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712451837; c=relaxed/simple;
	bh=PRj748hYNPeWkCq/E3EbeUP1FiL3fObn2emJ+y4CqMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTvD3zCDl5dv1WksCHVZbJG2XZ1nLnypTuQ2Ldp5f+EF1ZbkgoF7MZqcBWUglfnnf5NpdLr5xPV04OU9M/h+yUtXjNCtXx9pPhoOO/1BQmmmpZP+95qAeVnNNH2q5ezgFTHAl62jiZWoXfctLs5qphTJE6oVQ2XI1nlXeQSNIMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7367 invoked by uid 109); 7 Apr 2024 01:03:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 07 Apr 2024 01:03:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11261 invoked by uid 111); 7 Apr 2024 01:03:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Apr 2024 21:03:57 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Apr 2024 21:03:54 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH 08/11] http: use git_config_string_dup()
Message-ID: <20240407010354.GH868358@coredump.intra.peff.net>
References: <20240407005656.GA436890@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240407005656.GA436890@coredump.intra.peff.net>

There are many calls to git_config_string() in the HTTP code, leading to
possible leaks if a config variable is seen multiple times. I split
these out from the other "easy" cases because the change to non-const
pointers has some follow-on effects:

  1. When these variables are passed to var_override(), that should now
     take a non-const pointer (and consequently can drop the cast it
     passes to free).

  2. That file also has the somewhat redundant set_from_env() helper,
     which did _not_ free the existing value, and so has basically the
     same leak as git_config_string(). Rather than adjust it to take a
     non-const pointer, we can just swap it out for var_override(),
     fixing the leak and reducing the number of helpers at the same
     time.

This makes for a fairly big patch, but we have to do it all at once to
keep the compiler happy (or alternatively, insert a bunch of temporary
casts into http.c).

Note that some of these are git_config_pathname_dup(); it seemed better
to convert them all together, since the root of the problem (and the
solution) are essentially the same.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c | 105 +++++++++++++++++++++++++++------------------------------
 1 file changed, 49 insertions(+), 56 deletions(-)

diff --git a/http.c b/http.c
index e73b136e58..f2bcc9083e 100644
--- a/http.c
+++ b/http.c
@@ -38,11 +38,11 @@ char curl_errorstr[CURL_ERROR_SIZE];
 
 static int curl_ssl_verify = -1;
 static int curl_ssl_try;
-static const char *curl_http_version = NULL;
-static const char *ssl_cert;
-static const char *ssl_cert_type;
-static const char *ssl_cipherlist;
-static const char *ssl_version;
+static char *curl_http_version;
+static char *ssl_cert;
+static char *ssl_cert_type;
+static char *ssl_cipherlist;
+static char *ssl_version;
 static struct {
 	const char *name;
 	long ssl_version;
@@ -59,23 +59,23 @@ static struct {
 	{ "tlsv1.3", CURL_SSLVERSION_TLSv1_3 },
 #endif
 };
-static const char *ssl_key;
-static const char *ssl_key_type;
-static const char *ssl_capath;
-static const char *curl_no_proxy;
+static char *ssl_key;
+static char *ssl_key_type;
+static char *ssl_capath;
+static char *curl_no_proxy;
 #ifdef GIT_CURL_HAVE_CURLOPT_PINNEDPUBLICKEY
-static const char *ssl_pinnedkey;
+static char *ssl_pinnedkey;
 #endif
-static const char *ssl_cainfo;
+static char *ssl_cainfo;
 static long curl_low_speed_limit = -1;
 static long curl_low_speed_time = -1;
 static int curl_ftp_no_epsv;
-static const char *curl_http_proxy;
-static const char *http_proxy_authmethod;
+static char *curl_http_proxy;
+static char *http_proxy_authmethod;
 
-static const char *http_proxy_ssl_cert;
-static const char *http_proxy_ssl_key;
-static const char *http_proxy_ssl_ca_info;
+static char *http_proxy_ssl_cert;
+static char *http_proxy_ssl_key;
+static char *http_proxy_ssl_ca_info;
 static struct credential proxy_cert_auth = CREDENTIAL_INIT;
 static int proxy_ssl_cert_password_required;
 
@@ -95,7 +95,7 @@ static struct {
 	 */
 };
 #ifdef CURLGSSAPI_DELEGATION_FLAG
-static const char *curl_deleg;
+static char *curl_deleg;
 static struct {
 	const char *name;
 	long curl_deleg_param;
@@ -108,11 +108,11 @@ static struct {
 
 static struct credential proxy_auth = CREDENTIAL_INIT;
 static const char *curl_proxyuserpwd;
-static const char *curl_cookie_file;
+static char *curl_cookie_file;
 static int curl_save_cookies;
 struct credential http_auth = CREDENTIAL_INIT;
 static int http_proactive_auth;
-static const char *user_agent;
+static char *user_agent;
 static int curl_empty_auth = -1;
 
 enum http_follow_config http_follow_config = HTTP_FOLLOW_INITIAL;
@@ -366,28 +366,28 @@ static int http_options(const char *var, const char *value,
 			const struct config_context *ctx, void *data)
 {
 	if (!strcmp("http.version", var)) {
-		return git_config_string(&curl_http_version, var, value);
+		return git_config_string_dup(&curl_http_version, var, value);
 	}
 	if (!strcmp("http.sslverify", var)) {
 		curl_ssl_verify = git_config_bool(var, value);
 		return 0;
 	}
 	if (!strcmp("http.sslcipherlist", var))
-		return git_config_string(&ssl_cipherlist, var, value);
+		return git_config_string_dup(&ssl_cipherlist, var, value);
 	if (!strcmp("http.sslversion", var))
-		return git_config_string(&ssl_version, var, value);
+		return git_config_string_dup(&ssl_version, var, value);
 	if (!strcmp("http.sslcert", var))
-		return git_config_pathname(&ssl_cert, var, value);
+		return git_config_pathname_dup(&ssl_cert, var, value);
 	if (!strcmp("http.sslcerttype", var))
-		return git_config_string(&ssl_cert_type, var, value);
+		return git_config_string_dup(&ssl_cert_type, var, value);
 	if (!strcmp("http.sslkey", var))
-		return git_config_pathname(&ssl_key, var, value);
+		return git_config_pathname_dup(&ssl_key, var, value);
 	if (!strcmp("http.sslkeytype", var))
-		return git_config_string(&ssl_key_type, var, value);
+		return git_config_string_dup(&ssl_key_type, var, value);
 	if (!strcmp("http.sslcapath", var))
-		return git_config_pathname(&ssl_capath, var, value);
+		return git_config_pathname_dup(&ssl_capath, var, value);
 	if (!strcmp("http.sslcainfo", var))
-		return git_config_pathname(&ssl_cainfo, var, value);
+		return git_config_pathname_dup(&ssl_cainfo, var, value);
 	if (!strcmp("http.sslcertpasswordprotected", var)) {
 		ssl_cert_password_required = git_config_bool(var, value);
 		return 0;
@@ -436,27 +436,27 @@ static int http_options(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp("http.proxy", var))
-		return git_config_string(&curl_http_proxy, var, value);
+		return git_config_string_dup(&curl_http_proxy, var, value);
 
 	if (!strcmp("http.proxyauthmethod", var))
-		return git_config_string(&http_proxy_authmethod, var, value);
+		return git_config_string_dup(&http_proxy_authmethod, var, value);
 
 	if (!strcmp("http.proxysslcert", var))
-		return git_config_string(&http_proxy_ssl_cert, var, value);
+		return git_config_string_dup(&http_proxy_ssl_cert, var, value);
 
 	if (!strcmp("http.proxysslkey", var))
-		return git_config_string(&http_proxy_ssl_key, var, value);
+		return git_config_string_dup(&http_proxy_ssl_key, var, value);
 
 	if (!strcmp("http.proxysslcainfo", var))
-		return git_config_string(&http_proxy_ssl_ca_info, var, value);
+		return git_config_string_dup(&http_proxy_ssl_ca_info, var, value);
 
 	if (!strcmp("http.proxysslcertpasswordprotected", var)) {
 		proxy_ssl_cert_password_required = git_config_bool(var, value);
 		return 0;
 	}
 
 	if (!strcmp("http.cookiefile", var))
-		return git_config_pathname(&curl_cookie_file, var, value);
+		return git_config_pathname_dup(&curl_cookie_file, var, value);
 	if (!strcmp("http.savecookies", var)) {
 		curl_save_cookies = git_config_bool(var, value);
 		return 0;
@@ -472,7 +472,7 @@ static int http_options(const char *var, const char *value,
 	}
 
 	if (!strcmp("http.useragent", var))
-		return git_config_string(&user_agent, var, value);
+		return git_config_string_dup(&user_agent, var, value);
 
 	if (!strcmp("http.emptyauth", var)) {
 		if (value && !strcmp("auto", value))
@@ -484,7 +484,7 @@ static int http_options(const char *var, const char *value,
 
 	if (!strcmp("http.delegation", var)) {
 #ifdef CURLGSSAPI_DELEGATION_FLAG
-		return git_config_string(&curl_deleg, var, value);
+		return git_config_string_dup(&curl_deleg, var, value);
 #else
 		warning(_("Delegation control is not supported with cURL < 7.22.0"));
 		return 0;
@@ -493,7 +493,7 @@ static int http_options(const char *var, const char *value,
 
 	if (!strcmp("http.pinnedpubkey", var)) {
 #ifdef GIT_CURL_HAVE_CURLOPT_PINNEDPUBLICKEY
-		return git_config_pathname(&ssl_pinnedkey, var, value);
+		return git_config_pathname_dup(&ssl_pinnedkey, var, value);
 #else
 		warning(_("Public key pinning not supported with cURL < 7.39.0"));
 		return 0;
@@ -572,10 +572,10 @@ static void init_curl_http_auth(CURL *result)
 }
 
 /* *var must be free-able */
-static void var_override(const char **var, char *value)
+static void var_override(char **var, char *value)
 {
 	if (value) {
-		free((void *)*var);
+		free(*var);
 		*var = xstrdup(value);
 	}
 }
@@ -1208,13 +1208,6 @@ static CURL *get_curl_handle(void)
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
@@ -1291,14 +1284,14 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	if (getenv("GIT_SSL_NO_VERIFY"))
 		curl_ssl_verify = 0;
 
-	set_from_env(&ssl_cert, "GIT_SSL_CERT");
-	set_from_env(&ssl_cert_type, "GIT_SSL_CERT_TYPE");
-	set_from_env(&ssl_key, "GIT_SSL_KEY");
-	set_from_env(&ssl_key_type, "GIT_SSL_KEY_TYPE");
-	set_from_env(&ssl_capath, "GIT_SSL_CAPATH");
-	set_from_env(&ssl_cainfo, "GIT_SSL_CAINFO");
+	var_override(&ssl_cert, getenv("GIT_SSL_CERT"));
+	var_override(&ssl_cert_type, getenv("GIT_SSL_CERT_TYPE"));
+	var_override(&ssl_key, getenv("GIT_SSL_KEY"));
+	var_override(&ssl_key_type, getenv("GIT_SSL_KEY_TYPE"));
+	var_override(&ssl_capath, getenv("GIT_SSL_CAPATH"));
+	var_override(&ssl_cainfo, getenv("GIT_SSL_CAINFO"));
 
-	set_from_env(&user_agent, "GIT_HTTP_USER_AGENT");
+	var_override(&user_agent, getenv("GIT_HTTP_USER_AGENT"));
 
 	low_speed_limit = getenv("GIT_HTTP_LOW_SPEED_LIMIT");
 	if (low_speed_limit)
@@ -1314,9 +1307,9 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	if (max_requests < 1)
 		max_requests = DEFAULT_MAX_REQUESTS;
 
-	set_from_env(&http_proxy_ssl_cert, "GIT_PROXY_SSL_CERT");
-	set_from_env(&http_proxy_ssl_key, "GIT_PROXY_SSL_KEY");
-	set_from_env(&http_proxy_ssl_ca_info, "GIT_PROXY_SSL_CAINFO");
+	var_override(&http_proxy_ssl_cert, getenv("GIT_PROXY_SSL_CERT"));
+	var_override(&http_proxy_ssl_key, getenv("GIT_PROXY_SSL_KEY"));
+	var_override(&http_proxy_ssl_ca_info, getenv("GIT_PROXY_SSL_CAINFO"));
 
 	if (getenv("GIT_PROXY_SSL_CERT_PASSWORD_PROTECTED"))
 		proxy_ssl_cert_password_required = 1;
-- 
2.44.0.872.g288abe5b5b

