From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCHv2 2/2] http: use credential API to handle proxy authentication
Date: Tue, 26 Jan 2016 13:02:48 +0000
Message-ID: <1453813368-8990-2-git-send-email-gitter.spiros@gmail.com>
References: <1453813368-8990-1-git-send-email-gitter.spiros@gmail.com>
Cc: k.franke@science-computing.de,
	Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 26 14:03:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO3H0-0001SD-5n
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 14:03:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbcAZNC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 08:02:58 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38292 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932487AbcAZNCz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 08:02:55 -0500
Received: by mail-wm0-f53.google.com with SMTP id b14so129166031wmb.1
        for <git@vger.kernel.org>; Tue, 26 Jan 2016 05:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BWbbHYs3FSy2FMyGrpuE9CofLTMqA1nzDY1EiiCpAjA=;
        b=oM04bxLaXEbXi5Fb7+ewB5y209AwT5SIZw3zDFEph9XXDIPB/WpIjNvVCGybXis7J9
         LG6nDl46fiYZ1ipW3EDNzEgMzqDekN6QllX4lkN5wqD/US5lm3uks7ySBt/BfpqKL0cI
         S63QRHUqHtEH9eLTlwm1s7BzzxIdY/cRgpsfvp5/iLEnPaAxvKWN79WqfD8CnJYivJwo
         9ncfHBn7/unfy7y7PTReiA+ZTukIOhWiGw3rOVAj6DN5OUuWRWGz52eP8WujVO2fXGJl
         oD3ogAL2Yf2wmB3i+wkpZYVm17PNTGRkGFDI5N3i5stpcSVjRwqNJ5kQc9dFvpbM+RHz
         p5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BWbbHYs3FSy2FMyGrpuE9CofLTMqA1nzDY1EiiCpAjA=;
        b=PEqGUjSiNF2ZUAaMBEJo7JUlBVWGvLZ4Ku7ThS4V8cw+pKAamwmrrCuIR0tpqkv6XB
         gUZRPRnTrvr+Jz/8W5fI1qUqZAYv1jvBRKMIotpUZY9QPOnmi+BL5njuC7V9Hj2Z1jAW
         1P0L8XT54dHlAp5TcYE/up/iPF80d/+iQmEnjeeAGdcMBD5o3XuzOO2TfQPYPkfpuPZ/
         UfxjPMdAcnKgDc6oxGUQ353SeSd4P3JBWyXr1do7B2H8VcMwXAICsx+I22HGMdhOHXPq
         KKcktqbKvxVhWb583vyU/LOZZDLHb5FrMrNpDyoWKnhTk7861ABfQR9CbbGwoxKonHwl
         KGww==
X-Gm-Message-State: AG10YOR3yoLUbcXDGeVpSqEG0oJufbCAIWOj0MzCA32m3mjg5B0ISocXR70qsxG1u7KIdw==
X-Received: by 10.28.45.151 with SMTP id t145mr25448846wmt.88.1453813374158;
        Tue, 26 Jan 2016 05:02:54 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([40.113.119.92])
        by smtp.gmail.com with ESMTPSA id w194sm10344314wmd.0.2016.01.26.05.02.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Jan 2016 05:02:53 -0800 (PST)
X-Mailer: git-send-email 2.7.0.77.gc864936
In-Reply-To: <1453813368-8990-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284812>

From: Knut Franke <k.franke@science-computing.de>

Currently, the only way to pass proxy credentials to curl is by including them
in the proxy URL. Usually, this means they will end up on disk unencrypted, one
way or another (by inclusion in ~/.gitconfig, shell profile or history). Since
proxy authentication often uses a domain user, credentials can be security
sensitive; therefore, a safer way of passing credentials is desirable.

If the configured proxy contains a username but not a password, query the
credential API for one. Also, make sure we approve/reject proxy credentials
properly.

For consistency reasons, add parsing of http_proxy/https_proxy/all_proxy
environment variables, which would otherwise be evaluated as a fallback by curl.
Without this, we would have different semantics for git configuration and
environment variables.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Elia Pinto <gitter.spiros@gmail.com>
Signed-off-by: Knut Franke <k.franke@science-computing.de>
Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
This is the second version of the patch,
based on the rebase of kf/http-proxy-auth-methods on origin/next ($gmane/283734).

I have tested that the fix introduced by the commit 6d7afe07 
still works properly. 
(http://stackoverflow.com/questions/15227130/using-a-socks-proxy-with-git-for-the-http-transport#15228479)

I do not know if it is correct that I add my signed off, if not free to delete it.

 Documentation/config.txt | 10 +++++--
 http.c                   | 77 ++++++++++++++++++++++++++++++++++++++++++++++++
 http.h                   |  1 +
 3 files changed, 85 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0a4d41e..02bcde6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1610,9 +1610,13 @@ help.htmlPath::
 
 http.proxy::
 	Override the HTTP proxy, normally configured using the 'http_proxy',
-	'https_proxy', and 'all_proxy' environment variables (see
-	`curl(1)`).  This can be overridden on a per-remote basis; see
-	remote.<name>.proxy
+	'https_proxy', and 'all_proxy' environment variables (see `curl(1)`). In
+	addition to the syntax understood by curl, it is possible to specify a
+	proxy string with a user name but no password, in which case git will
+	attempt to acquire one in the same way it does for other credentials. See
+	linkgit:gitcredentials[7] for more information. The syntax thus is
+	'[protocol://][user[:password]@]proxyhost[:port]'. This can be overridden
+	on a per-remote basis; see remote.<name>.proxy
 
 http.proxyAuthMethod::
 	Set the method with which to authenticate against the HTTP proxy. This
diff --git a/http.c b/http.c
index f46bfc4..dfc53c1 100644
--- a/http.c
+++ b/http.c
@@ -80,6 +80,8 @@ static struct {
 	 * here, too
 	 */
 };
+static struct credential proxy_auth = CREDENTIAL_INIT;
+static const char *curl_proxyuserpwd;
 static const char *curl_cookie_file;
 static int curl_save_cookies;
 struct credential http_auth = CREDENTIAL_INIT;
@@ -177,6 +179,9 @@ static void finish_active_slot(struct active_request_slot *slot)
 #else
 		slot->results->auth_avail = 0;
 #endif
+
+		curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CONNECTCODE,
+			&slot->results->http_connectcode);
 	}
 
 	/* Run callback if appropriate */
@@ -334,8 +339,32 @@ static void var_override(const char **var, char *value)
 	}
 }
 
+static void set_proxyauth_name_password(CURL *result)
+{
+#if LIBCURL_VERSION_NUM >= 0x071301
+		curl_easy_setopt(result, CURLOPT_PROXYUSERNAME,
+			proxy_auth.username);
+		curl_easy_setopt(result, CURLOPT_PROXYPASSWORD,
+			proxy_auth.password);
+#else
+		struct strbuf s = STRBUF_INIT;
+
+		strbuf_addstr_urlencode(&s, proxy_auth.username, 1);
+		strbuf_addch(&s, ':');
+		strbuf_addstr_urlencode(&s, proxy_auth.password, 1);
+		curl_proxyuserpwd = strbuf_detach(&s, NULL);
+		curl_easy_setopt(result, CURLOPT_PROXYUSERPWD, curl_proxyuserpwd);
+#endif
+}
+
 static void init_curl_proxy_auth(CURL *result)
 {
+	if (proxy_auth.username) {
+		if (!proxy_auth.password)
+			credential_fill(&proxy_auth);
+		set_proxyauth_name_password(result);
+	}
+
 	var_override(&http_proxy_authmethod, getenv("GIT_HTTP_PROXY_AUTHMETHOD"));
 
 #if LIBCURL_VERSION_NUM >= 0x070a07 /* CURLOPT_PROXYAUTH and CURLAUTH_ANY */
@@ -517,6 +546,31 @@ static CURL *get_curl_handle(void)
 		curl_easy_setopt(result, CURLOPT_USE_SSL, CURLUSESSL_TRY);
 #endif
 
+	/*
+	 * CURL also examines these variables as a fallback; but we need to query
+	 * them here in order to decide whether to prompt for missing password (cf.
+	 * init_curl_proxy_auth()).
+	 *
+	 * Unlike many other common environment variables, these are historically
+	 * lowercase only. It appears that CURL did not know this and implemented
+	 * only uppercase variants, which was later corrected to take both - with
+	 * the exception of http_proxy, which is lowercase only also in CURL. As
+	 * the lowercase versions are the historical quasi-standard, they take
+	 * precedence here, as in CURL.
+	 */
+	if (!curl_http_proxy) {
+		if (!strcmp(http_auth.protocol, "https")) {
+			var_override(&curl_http_proxy, getenv("HTTPS_PROXY"));
+			var_override(&curl_http_proxy, getenv("https_proxy"));
+		} else {
+			var_override(&curl_http_proxy, getenv("http_proxy"));
+		}
+		if (!curl_http_proxy) {
+			var_override(&curl_http_proxy, getenv("ALL_PROXY"));
+			var_override(&curl_http_proxy, getenv("all_proxy"));
+		}
+	}
+
 	if (curl_http_proxy) {
 		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
 #if LIBCURL_VERSION_NUM >= 0x071800
@@ -530,6 +584,16 @@ static CURL *get_curl_handle(void)
 			curl_easy_setopt(result,
 				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4);
 #endif
+		if (strstr(curl_http_proxy, "://"))
+			credential_from_url(&proxy_auth, curl_http_proxy);
+		else {
+			struct strbuf url = STRBUF_INIT;
+			strbuf_addf(&url, "http://%s", curl_http_proxy);
+			credential_from_url(&proxy_auth, url.buf);
+			strbuf_release(&url);
+		}
+
+		curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);
 	}
 	init_curl_proxy_auth(result);
 
@@ -673,6 +737,15 @@ void http_cleanup(void)
 		curl_http_proxy = NULL;
 	}
 
+	if (proxy_auth.password) {
+		memset(proxy_auth.password, 0, strlen(proxy_auth.password));
+		free(proxy_auth.password);
+		proxy_auth.password = NULL;
+	}
+
+	free((void *)curl_proxyuserpwd);
+	curl_proxyuserpwd = NULL;
+
 	free((void *)http_proxy_authmethod);
 	http_proxy_authmethod = NULL;
 
@@ -1005,6 +1078,8 @@ static int handle_curl_result(struct slot_results *results)
 
 	if (results->curl_result == CURLE_OK) {
 		credential_approve(&http_auth);
+		if (proxy_auth.password)
+			credential_approve(&proxy_auth);
 		return HTTP_OK;
 	} else if (missing_target(results))
 		return HTTP_MISSING_TARGET;
@@ -1019,6 +1094,8 @@ static int handle_curl_result(struct slot_results *results)
 			return HTTP_REAUTH;
 		}
 	} else {
+		if (results->http_connectcode == 407)
+			credential_reject(&proxy_auth);
 #if LIBCURL_VERSION_NUM >= 0x070c00
 		if (!curl_errorstr[0])
 			strlcpy(curl_errorstr,
diff --git a/http.h b/http.h
index 4f97b60..f83cfa6 100644
--- a/http.h
+++ b/http.h
@@ -54,6 +54,7 @@ struct slot_results {
 	CURLcode curl_result;
 	long http_code;
 	long auth_avail;
+	long http_connectcode;
 };
 
 struct active_request_slot {
-- 
2.7.0.77.gc864936
