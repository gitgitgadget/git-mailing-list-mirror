Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2992381E
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 01:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711242797; cv=none; b=D62kswI9zHBCdLTnbvBsYN0tV4yS8MSs8TXlreWGXR/WXawYngBqgFqjH9LGpm58VUrQhRnb1oK3t7R58NO0BgGKNj9X+33NFvof4ZOhUZG1nyA2jdXjCsCOZRGJmvoFJKWpzz4ZQcRDKRGtU78g0cOmE3FbEWAjE0kwW7xxvZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711242797; c=relaxed/simple;
	bh=qGU6XNgtV2kXpA80MARJyjobtj3uvHtnP78Flo7vlCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p39hFlMfEk9DRSaghtU1SnPgHJ7rtT5hlzs985R+zUgK4z8QLIw0h5R3cLZkoPlShrUVGTDOFVNFXxPpynkvLmBiZBmB9RrVldxUPBvnm4yuB6UT6PoW+v6RuZjJQ6imAz1FiP+FvTzkNgrz6pl7gK6GzQ+vVedf89CgrPIGjjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=BJNYOgwi; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="BJNYOgwi"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 25F1C5D410;
	Sun, 24 Mar 2024 01:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1711242786;
	bh=qGU6XNgtV2kXpA80MARJyjobtj3uvHtnP78Flo7vlCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=BJNYOgwiIbTwlnKwsKJaXS2afvDFhW/dQlRdandI7d7EhMfUcRvEG6PnALv1KErPb
	 uodFDXIRvIqDTiZSrbXCMcdE9uwbme2DjY9J011kGpT93+/AGWXOVmJSdOVSiUcJFD
	 QciPbTml4dThYky+Wy5s7d0rRe5lsJ0QdWj8FUIFikQipadxIKYHweQiV0JA1VL263
	 uWNQD6zImLslhdPVKyk7IO5kNjGG3+0D1HIFG0qGwmPb0BfnGVO/c+wo3pZerKrv+T
	 lulv/VPtzWEjTj5vPC8tPcKOXNSt8JhwXsY9PeejKt+GyF9pKnZARLaUBe+VgLXaGM
	 eiNrbYTszd3RK5mEuQoCGnAcucRVpTsNW70xujjINdHeY7Osj696mp+tyGLnpzAFcx
	 2eSEH4rfCz40+kUTd9MPF9vc2ewbH8g59SmFpzunApg3Sgi5YGOOsbl2iYk7wEd4uc
	 6yrlLZQv+YzggHOtbsUBmZ15NXk2sjXaDkEvczOLnuuDzhiuvlf
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>
Subject: [PATCH 07/13] http: add support for authtype and credential
Date: Sun, 24 Mar 2024 01:12:55 +0000
Message-ID: <20240324011301.1553072-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8
In-Reply-To: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we have the credential helper code set up to handle arbitrary
authentications schemes, let's add support for this in the HTTP code,
where we really want to use it.  If we're using this new functionality,
don't set a username and password, and instead set a header wherever
we'd normally do so, including for proxy authentication.

Since we can now handle this case, ask the credential helper to enable
the appropriate capabilities.

Finally, if we're using the authtype value, set "Expect: 100-continue".
Any type of authentication that requires multiple rounds (such as NTLM
or Kerberos) requires a 100 Continue (if we're larger than
http.postBuffer) because otherwise we send the pack data before we're
authenticated, the push gets a 401 response, and we can't rewind the
stream.  We don't know for certain what other custom schemes might
require this, the HTTP/1.1 standard has required handling this since
1999, the broken HTTP server for which we disabled this (Google's) is
now fixed and has been for some time, and libcurl has a 1-second
fallback in case the HTTP server is still broken.  In addition, it is
not unreasonable to require compliance with a 25-year old standard to
use new Git features.  For all of these reasons, do so here.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 http.c                      |  48 ++++++++++---
 http.h                      |   3 +
 remote-curl.c               |   4 +-
 t/t5563-simple-http-auth.sh | 133 ++++++++++++++++++++++++++++++++++++
 4 files changed, 176 insertions(+), 12 deletions(-)

diff --git a/http.c b/http.c
index 4f5df6fb14..f98c520924 100644
--- a/http.c
+++ b/http.c
@@ -561,18 +561,34 @@ static int curl_empty_auth_enabled(void)
 	return 0;
 }
 
+struct curl_slist *http_append_auth_header(const struct credential *c,
+					   struct curl_slist *headers)
+{
+	if (c->authtype && c->credential) {
+		struct strbuf auth = STRBUF_INIT;
+		strbuf_addf(&auth, "Authorization: %s %s",
+			    c->authtype, c->credential);
+		headers = curl_slist_append(headers, auth.buf);
+		strbuf_release(&auth);
+	}
+	return headers;
+}
+
 static void init_curl_http_auth(CURL *result)
 {
-	if (!http_auth.username || !*http_auth.username) {
+	if ((!http_auth.username || !*http_auth.username) &&
+	    (!http_auth.credential || !*http_auth.credential)) {
 		if (curl_empty_auth_enabled())
 			curl_easy_setopt(result, CURLOPT_USERPWD, ":");
 		return;
 	}
 
-	credential_fill(&http_auth, 0);
+	credential_fill(&http_auth, 1);
 
-	curl_easy_setopt(result, CURLOPT_USERNAME, http_auth.username);
-	curl_easy_setopt(result, CURLOPT_PASSWORD, http_auth.password);
+	if (http_auth.password) {
+		curl_easy_setopt(result, CURLOPT_USERNAME, http_auth.username);
+		curl_easy_setopt(result, CURLOPT_PASSWORD, http_auth.password);
+	}
 }
 
 /* *var must be free-able */
@@ -586,17 +602,22 @@ static void var_override(const char **var, char *value)
 
 static void set_proxyauth_name_password(CURL *result)
 {
+	if (proxy_auth.password) {
 		curl_easy_setopt(result, CURLOPT_PROXYUSERNAME,
 			proxy_auth.username);
 		curl_easy_setopt(result, CURLOPT_PROXYPASSWORD,
 			proxy_auth.password);
+	} else if (proxy_auth.authtype && proxy_auth.credential) {
+		curl_easy_setopt(result, CURLOPT_PROXYHEADER,
+				 http_append_auth_header(&proxy_auth, NULL));
+	}
 }
 
 static void init_curl_proxy_auth(CURL *result)
 {
 	if (proxy_auth.username) {
-		if (!proxy_auth.password)
-			credential_fill(&proxy_auth, 0);
+		if (!proxy_auth.password && !proxy_auth.credential)
+			credential_fill(&proxy_auth, 1);
 		set_proxyauth_name_password(result);
 	}
 
@@ -1469,7 +1490,7 @@ struct active_request_slot *get_active_slot(void)
 
 	curl_easy_setopt(slot->curl, CURLOPT_IPRESOLVE, git_curl_ipresolve);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPAUTH, http_auth_methods);
-	if (http_auth.password || curl_empty_auth_enabled())
+	if (http_auth.password || http_auth.credential || curl_empty_auth_enabled())
 		init_curl_http_auth(slot->curl);
 
 	return slot;
@@ -1758,7 +1779,8 @@ static int handle_curl_result(struct slot_results *results)
 	} else if (missing_target(results))
 		return HTTP_MISSING_TARGET;
 	else if (results->http_code == 401) {
-		if (http_auth.username && http_auth.password) {
+		if ((http_auth.username && http_auth.password) ||\
+		    (http_auth.authtype && http_auth.credential)) {
 			credential_reject(&http_auth);
 			return HTTP_NOAUTH;
 		} else {
@@ -2066,11 +2088,15 @@ static int http_request(const char *url,
 	/* Add additional headers here */
 	if (options && options->extra_headers) {
 		const struct string_list_item *item;
-		for_each_string_list_item(item, options->extra_headers) {
-			headers = curl_slist_append(headers, item->string);
+		if (options && options->extra_headers) {
+			for_each_string_list_item(item, options->extra_headers) {
+				headers = curl_slist_append(headers, item->string);
+			}
 		}
 	}
 
+	headers = http_append_auth_header(&http_auth, headers);
+
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
 	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
@@ -2191,7 +2217,7 @@ static int http_request_reauth(const char *url,
 		BUG("Unknown http_request target");
 	}
 
-	credential_fill(&http_auth, 0);
+	credential_fill(&http_auth, 1);
 
 	return http_request(url, result, target, options);
 }
diff --git a/http.h b/http.h
index c5f8cc4620..a516ca4a9a 100644
--- a/http.h
+++ b/http.h
@@ -175,6 +175,9 @@ int http_get_file(const char *url, const char *filename,
 
 int http_fetch_ref(const char *base, struct ref *ref);
 
+struct curl_slist *http_append_auth_header(const struct credential *c,
+					   struct curl_slist *headers);
+
 /* Helpers for fetching packs */
 int http_get_info_packs(const char *base_url,
 			struct packed_git **packs_head);
diff --git a/remote-curl.c b/remote-curl.c
index f96bda2431..1c5416812a 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -931,7 +931,7 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
 		if (err != HTTP_OK)
 			return -1;
 
-		if (results.auth_avail & CURLAUTH_GSSNEGOTIATE)
+		if (results.auth_avail & CURLAUTH_GSSNEGOTIATE || http_auth.authtype)
 			needs_100_continue = 1;
 	}
 
@@ -942,6 +942,8 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
 	headers = curl_slist_append(headers, needs_100_continue ?
 		"Expect: 100-continue" : "Expect:");
 
+	headers = http_append_auth_header(&http_auth, headers);
+
 	/* Add Accept-Language header */
 	if (rpc->hdr_accept_language)
 		headers = curl_slist_append(headers, rpc->hdr_accept_language);
diff --git a/t/t5563-simple-http-auth.sh b/t/t5563-simple-http-auth.sh
index ab8a721ccc..b3ed0d9fc2 100755
--- a/t/t5563-simple-http-auth.sh
+++ b/t/t5563-simple-http-auth.sh
@@ -74,6 +74,7 @@ test_expect_success 'access using basic auth' '
 	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
 
 	expect_credential_query get <<-EOF &&
+	capability[]=authtype
 	protocol=http
 	host=$HTTPD_DEST
 	wwwauth[]=Basic realm="example.com"
@@ -87,6 +88,43 @@ test_expect_success 'access using basic auth' '
 	EOF
 '
 
+test_expect_success 'access using basic auth via authtype' '
+	test_when_finished "per_test_cleanup" &&
+
+	set_credential_reply get <<-EOF &&
+	capability[]=authtype
+	authtype=Basic
+	credential=YWxpY2U6c2VjcmV0LXBhc3N3ZA==
+	EOF
+
+	# Basic base64(alice:secret-passwd)
+	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
+	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
+	EOF
+
+	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
+	WWW-Authenticate: Basic realm="example.com"
+	EOF
+
+	test_config_global credential.helper test-helper &&
+	GIT_CURL_VERBOSE=1 git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
+
+	expect_credential_query get <<-EOF &&
+	capability[]=authtype
+	protocol=http
+	host=$HTTPD_DEST
+	wwwauth[]=Basic realm="example.com"
+	EOF
+
+	expect_credential_query store <<-EOF
+	capability[]=authtype
+	authtype=Basic
+	credential=YWxpY2U6c2VjcmV0LXBhc3N3ZA==
+	protocol=http
+	host=$HTTPD_DEST
+	EOF
+'
+
 test_expect_success 'access using basic auth invalid credentials' '
 	test_when_finished "per_test_cleanup" &&
 
@@ -108,6 +146,7 @@ test_expect_success 'access using basic auth invalid credentials' '
 	test_must_fail git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
 
 	expect_credential_query get <<-EOF &&
+	capability[]=authtype
 	protocol=http
 	host=$HTTPD_DEST
 	wwwauth[]=Basic realm="example.com"
@@ -145,6 +184,7 @@ test_expect_success 'access using basic auth with extra challenges' '
 	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
 
 	expect_credential_query get <<-EOF &&
+	capability[]=authtype
 	protocol=http
 	host=$HTTPD_DEST
 	wwwauth[]=FooBar param1="value1" param2="value2"
@@ -183,6 +223,7 @@ test_expect_success 'access using basic auth mixed-case wwwauth header name' '
 	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
 
 	expect_credential_query get <<-EOF &&
+	capability[]=authtype
 	protocol=http
 	host=$HTTPD_DEST
 	wwwauth[]=foobar param1="value1" param2="value2"
@@ -226,6 +267,7 @@ test_expect_success 'access using basic auth with wwwauth header continuations'
 	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
 
 	expect_credential_query get <<-EOF &&
+	capability[]=authtype
 	protocol=http
 	host=$HTTPD_DEST
 	wwwauth[]=FooBar param1="value1" param2="value2"
@@ -271,6 +313,7 @@ test_expect_success 'access using basic auth with wwwauth header empty continuat
 	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
 
 	expect_credential_query get <<-EOF &&
+	capability[]=authtype
 	protocol=http
 	host=$HTTPD_DEST
 	wwwauth[]=FooBar param1="value1" param2="value2"
@@ -312,6 +355,7 @@ test_expect_success 'access using basic auth with wwwauth header mixed line-endi
 	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
 
 	expect_credential_query get <<-EOF &&
+	capability[]=authtype
 	protocol=http
 	host=$HTTPD_DEST
 	wwwauth[]=FooBar param1="value1" param2="value2"
@@ -326,4 +370,93 @@ test_expect_success 'access using basic auth with wwwauth header mixed line-endi
 	EOF
 '
 
+test_expect_success 'access using bearer auth' '
+	test_when_finished "per_test_cleanup" &&
+
+	set_credential_reply get <<-EOF &&
+	capability[]=authtype
+	authtype=Bearer
+	credential=YS1naXQtdG9rZW4=
+	EOF
+
+	# Basic base64(a-git-token)
+	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
+	Bearer YS1naXQtdG9rZW4=
+	EOF
+
+	CHALLENGE="$HTTPD_ROOT_PATH/custom-auth.challenge" &&
+
+	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
+	WWW-Authenticate: FooBar param1="value1" param2="value2"
+	WWW-Authenticate: Bearer authorize_uri="id.example.com" p=1 q=0
+	WWW-Authenticate: Basic realm="example.com"
+	EOF
+
+	test_config_global credential.helper test-helper &&
+	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
+
+	expect_credential_query get <<-EOF &&
+	capability[]=authtype
+	protocol=http
+	host=$HTTPD_DEST
+	wwwauth[]=FooBar param1="value1" param2="value2"
+	wwwauth[]=Bearer authorize_uri="id.example.com" p=1 q=0
+	wwwauth[]=Basic realm="example.com"
+	EOF
+
+	expect_credential_query store <<-EOF
+	capability[]=authtype
+	authtype=Bearer
+	credential=YS1naXQtdG9rZW4=
+	protocol=http
+	host=$HTTPD_DEST
+	EOF
+'
+
+test_expect_success 'access using bearer auth with invalid credentials' '
+	test_when_finished "per_test_cleanup" &&
+
+	set_credential_reply get <<-EOF &&
+	capability[]=authtype
+	authtype=Bearer
+	credential=incorrect-token
+	EOF
+
+	# Basic base64(a-git-token)
+	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
+	Bearer YS1naXQtdG9rZW4=
+	EOF
+
+	CHALLENGE="$HTTPD_ROOT_PATH/custom-auth.challenge" &&
+
+	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
+	WWW-Authenticate: FooBar param1="value1" param2="value2"
+	WWW-Authenticate: Bearer authorize_uri="id.example.com" p=1 q=0
+	WWW-Authenticate: Basic realm="example.com"
+	EOF
+
+	test_config_global credential.helper test-helper &&
+	test_must_fail git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
+
+	expect_credential_query get <<-EOF &&
+	capability[]=authtype
+	protocol=http
+	host=$HTTPD_DEST
+	wwwauth[]=FooBar param1="value1" param2="value2"
+	wwwauth[]=Bearer authorize_uri="id.example.com" p=1 q=0
+	wwwauth[]=Basic realm="example.com"
+	EOF
+
+	expect_credential_query erase <<-EOF
+	capability[]=authtype
+	authtype=Bearer
+	credential=incorrect-token
+	protocol=http
+	host=$HTTPD_DEST
+	wwwauth[]=FooBar param1="value1" param2="value2"
+	wwwauth[]=Bearer authorize_uri="id.example.com" p=1 q=0
+	wwwauth[]=Basic realm="example.com"
+	EOF
+'
+
 test_done
