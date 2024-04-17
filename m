Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527768BFC
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 00:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713312187; cv=none; b=fRx6oeWlgBWFeswTUE0haK4jPNXLQyS55vlY0aX9GKMFTw23aoYL8ZYMqiVScJd1yyiZhZuwacWwTdLgAHzyEGFTGCA695T6dYVPQXqlTLKbeGXouo0JSwUQRxfvOEMmNmsXRhKeaFpeHPMWnZ8MnSw6P/oHxunbZG9C8/s+HwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713312187; c=relaxed/simple;
	bh=6K+hBGtum5nkXPRLV+XM6cyIIm7H6ZxheBQLzTmiUHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPIXRiP3cENHP7hoFoXvUFhat4HcDyF11qXAXMF/05Ef1ikORGIR9wX+Lq0g/CrWvR1Ci4ldvCRhA6YnWYvbAjF9EzvZ+whQheSaO5qHuwxyeBltP6J1Eib1HFGYOmEM38cmpN8z7m+/t+TOre7M16azZy91EV2qJ8X27RS3yfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=0fKUGlwa; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="0fKUGlwa"
Received: from tapette.tailf784c.ts.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id A83915D6CF;
	Wed, 17 Apr 2024 00:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1713312177;
	bh=6K+hBGtum5nkXPRLV+XM6cyIIm7H6ZxheBQLzTmiUHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=0fKUGlwaNop1ZnoYKcDkRx4RdboUUfdiPssjUJfyF+VDGqVpo3e5EzF+TCaloplSE
	 UemAgAGMeHAgu9iS2/alWgukIT4+my1gOLM3SJ84HC3Hbfh3SSwU3XCPMejtODHfCt
	 FtQCeVevoNtskeiBYXG2E0sVblQ6XRojiySNxuAiylW5ur+tyUDFIDlDNuOpb+YZmz
	 xZPon7MXPOLg26pLJ0T5BJZY6wqei08ogohyjY0I/ACW2SOSqLO+MtaHAGlMiQU/XH
	 27lv0QgofVw7Ty9Ongh7PwQzdy8gckpw5we9GnC1Ax5xioaOcWMkbFIkGIlDJHw2Rp
	 VWHZW/YIkjWJ5a4YgxiJ94DT9KEX0uGcDb+pJVbi9+YtoffiGMummmVKqR2eCyqIi3
	 nMDl1rfKkdnGur5hpv6IaARSoQWBYPJuhWDyEKQZ8q5euQL0QwkW7n2g008MBMOBXY
	 ty5WOMHOXcEj89UlKpnfCMKEg6Z+ph/WejwvGkEE8Hrw9//oF2c
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>,
	Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 13/16] credential: add support for multistage credential rounds
Date: Wed, 17 Apr 2024 00:02:37 +0000
Message-ID: <20240417000240.3611948-14-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8
In-Reply-To: <20240417000240.3611948-1-sandals@crustytoothpaste.net>
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
 <20240417000240.3611948-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Over HTTP, NTLM and Kerberos require two rounds of authentication on the
client side.  It's possible that there are custom authentication schemes
that also implement this same approach.  Since these are tricky schemes
to implement and the HTTP library in use may not always handle them
gracefully on all systems, it would be helpful to allow the credential
helper to implement them instead for increased portability and
robustness.

To allow this to happen, add a boolean flag, continue, that indicates
that instead of failing when we get a 401, we should retry another round
of authentication.  However, this necessitates some changes in our
current credential code so that we can make this work.

Keep the state[] headers between iterations, but only use them to send
to the helper and only consider the new ones we read from the credential
helper to be valid on subsequent iterations.  That avoids us passing
stale data when we finally approve or reject the credential.  Similarly,
clear the multistage and wwwauth[] values appropriately so that we
don't pass stale data or think we're trying a multiround response when
we're not.  Remove the credential values so that we can actually fill a
second time with new responses.

Limit the number of iterations of reauthentication we do to 3.  This
means that if there's a problem, we'll terminate with an error message
instead of retrying indefinitely and not informing the user (and
possibly conducting a DoS on the server).

In our tests, handle creating multiple response output files from our
helper so we can verify that each of the messages sent is correct.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-credential.txt | 13 +++++
 builtin/credential.c             |  1 +
 credential.c                     | 32 ++++++++++--
 credential.h                     | 27 +++++++++-
 http.c                           | 59 +++++++++++----------
 t/t5563-simple-http-auth.sh      | 89 ++++++++++++++++++++++++++++++--
 6 files changed, 185 insertions(+), 36 deletions(-)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index 4bbf2db9ca..3d3accc273 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -222,6 +222,19 @@ provided on input.
 This value should not be sent unless the appropriate capability (see below) is
 provided on input.
 
+`continue`::
+	This is a boolean value, which, if enabled, indicates that this
+	authentication is a non-final part of a multistage authentication step. This
+	is common in protocols such as NTLM and Kerberos, where two rounds of client
+	authentication are required, and setting this flag allows the credential
+	helper to implement the multistage authentication step.  This flag should
+	only be sent if a further stage is required; that is, if another round of
+	authentication is expected.
++
+This value should not be sent unless the appropriate capability (see below) is
+provided on input.  This attribute is 'one-way' from a credential helper to
+pass information to Git (or other programs invoking `git credential`).
+
 `wwwauth[]`::
 
 	When an HTTP response is received by Git that includes one or more
diff --git a/builtin/credential.c b/builtin/credential.c
index 643bf0b5e4..3568e57025 100644
--- a/builtin/credential.c
+++ b/builtin/credential.c
@@ -22,6 +22,7 @@ int cmd_credential(int argc, const char **argv, const char *prefix UNUSED)
 
 	if (!strcmp(op, "fill")) {
 		credential_fill(&c, 0);
+		credential_next_state(&c);
 		credential_write(&c, stdout, CREDENTIAL_OP_RESPONSE);
 	} else if (!strcmp(op, "approve")) {
 		credential_set_all_capabilities(&c, CREDENTIAL_OP_HELPER);
diff --git a/credential.c b/credential.c
index c93de92f65..98b040cf11 100644
--- a/credential.c
+++ b/credential.c
@@ -31,10 +31,23 @@ void credential_clear(struct credential *c)
 	string_list_clear(&c->helpers, 0);
 	strvec_clear(&c->wwwauth_headers);
 	strvec_clear(&c->state_headers);
+	strvec_clear(&c->state_headers_to_send);
 
 	credential_init(c);
 }
 
+void credential_next_state(struct credential *c)
+{
+	strvec_clear(&c->state_headers_to_send);
+	SWAP(c->state_headers, c->state_headers_to_send);
+}
+
+void credential_clear_secrets(struct credential *c)
+{
+	FREE_AND_NULL(c->password);
+	FREE_AND_NULL(c->credential);
+}
+
 static void credential_set_capability(struct credential_capability *capa,
 				      enum credential_op_type op_type)
 {
@@ -302,6 +315,8 @@ int credential_read(struct credential *c, FILE *fp,
 				credential_set_capability(&c->capa_authtype, op_type);
 			else if (!strcmp(value, "state"))
 				credential_set_capability(&c->capa_state, op_type);
+		} else if (!strcmp(key, "continue")) {
+			c->multistage = !!git_config_bool("continue", value);
 		} else if (!strcmp(key, "password_expiry_utc")) {
 			errno = 0;
 			c->password_expiry_utc = parse_timestamp(value, NULL, 10);
@@ -369,8 +384,10 @@ void credential_write(const struct credential *c, FILE *fp,
 	for (size_t i = 0; i < c->wwwauth_headers.nr; i++)
 		credential_write_item(fp, "wwwauth[]", c->wwwauth_headers.v[i], 0);
 	if (credential_has_capability(&c->capa_state, op_type)) {
-		for (size_t i = 0; i < c->state_headers.nr; i++)
-			credential_write_item(fp, "state[]", c->state_headers.v[i], 0);
+		if (c->multistage)
+			credential_write_item(fp, "continue", "1", 0);
+		for (size_t i = 0; i < c->state_headers_to_send.nr; i++)
+			credential_write_item(fp, "state[]", c->state_headers_to_send.v[i], 0);
 	}
 }
 
@@ -441,6 +458,9 @@ void credential_fill(struct credential *c, int all_capabilities)
 	if ((c->username && c->password) || c->credential)
 		return;
 
+	credential_next_state(c);
+	c->multistage = 0;
+
 	credential_apply_config(c);
 	if (all_capabilities)
 		credential_set_all_capabilities(c, CREDENTIAL_OP_INITIAL);
@@ -453,8 +473,10 @@ void credential_fill(struct credential *c, int all_capabilities)
 			/* Reset expiry to maintain consistency */
 			c->password_expiry_utc = TIME_MAX;
 		}
-		if ((c->username && c->password) || c->credential)
+		if ((c->username && c->password) || c->credential) {
+			strvec_clear(&c->wwwauth_headers);
 			return;
+		}
 		if (c->quit)
 			die("credential helper '%s' told us to quit",
 			    c->helpers.items[i].string);
@@ -474,6 +496,8 @@ void credential_approve(struct credential *c)
 	if (((!c->username || !c->password) && !c->credential) || c->password_expiry_utc < time(NULL))
 		return;
 
+	credential_next_state(c);
+
 	credential_apply_config(c);
 
 	for (i = 0; i < c->helpers.nr; i++)
@@ -485,6 +509,8 @@ void credential_reject(struct credential *c)
 {
 	int i;
 
+	credential_next_state(c);
+
 	credential_apply_config(c);
 
 	for (i = 0; i < c->helpers.nr; i++)
diff --git a/credential.h b/credential.h
index c307300d12..19163fc6a0 100644
--- a/credential.h
+++ b/credential.h
@@ -145,10 +145,15 @@ struct credential {
 	struct strvec wwwauth_headers;
 
 	/**
-	 * A `strvec` of state headers from credential helpers.
+	 * A `strvec` of state headers received from credential helpers.
 	 */
 	struct strvec state_headers;
 
+	/**
+	 * A `strvec` of state headers to send to credential helpers.
+	 */
+	struct strvec state_headers_to_send;
+
 	/**
 	 * Internal use only. Keeps track of if we previously matched against a
 	 * WWW-Authenticate header line in order to re-fold future continuation
@@ -159,6 +164,7 @@ struct credential {
 	unsigned approved:1,
 		 ephemeral:1,
 		 configured:1,
+		 multistage: 1,
 		 quit:1,
 		 use_http_path:1,
 		 username_from_proto:1;
@@ -187,6 +193,7 @@ struct credential {
 	.password_expiry_utc = TIME_MAX, \
 	.wwwauth_headers = STRVEC_INIT, \
 	.state_headers = STRVEC_INIT, \
+	.state_headers_to_send = STRVEC_INIT, \
 }
 
 /* Initialize a credential structure, setting all fields to empty. */
@@ -238,6 +245,24 @@ void credential_reject(struct credential *);
 void credential_set_all_capabilities(struct credential *c,
 				     enum credential_op_type op_type);
 
+/**
+ * Clear the secrets in this credential, but leave other data intact.
+ *
+ * This is useful for resetting credentials in preparation for a subsequent
+ * stage of filling.
+ */
+void credential_clear_secrets(struct credential *c);
+
+/**
+ * Prepares the credential for the next iteration of the helper protocol by
+ * updating the state headers to send with the ones read by the last iteration
+ * of the protocol.
+ *
+ * Except for internal callers, this should be called exactly once between
+ * reading credentials with `credential_fill` and writing them.
+ */
+void credential_next_state(struct credential *c);
+
 int credential_read(struct credential *, FILE *,
 		    enum credential_op_type);
 void credential_write(const struct credential *, FILE *,
diff --git a/http.c b/http.c
index 906eb098c8..9a514404d0 100644
--- a/http.c
+++ b/http.c
@@ -1780,6 +1780,10 @@ static int handle_curl_result(struct slot_results *results)
 	else if (results->http_code == 401) {
 		if ((http_auth.username && http_auth.password) ||\
 		    (http_auth.authtype && http_auth.credential)) {
+			if (http_auth.multistage) {
+				credential_clear_secrets(&http_auth);
+				return HTTP_REAUTH;
+			}
 			credential_reject(&http_auth);
 			return HTTP_NOAUTH;
 		} else {
@@ -2177,6 +2181,7 @@ static int http_request_reauth(const char *url,
 			       void *result, int target,
 			       struct http_get_options *options)
 {
+	int i = 3;
 	int ret = http_request(url, result, target, options);
 
 	if (ret != HTTP_OK && ret != HTTP_REAUTH)
@@ -2190,35 +2195,35 @@ static int http_request_reauth(const char *url,
 		}
 	}
 
-	if (ret != HTTP_REAUTH)
-		return ret;
+	while (ret == HTTP_REAUTH && --i) {
+		/*
+		 * The previous request may have put cruft into our output stream; we
+		 * should clear it out before making our next request.
+		 */
+		switch (target) {
+		case HTTP_REQUEST_STRBUF:
+			strbuf_reset(result);
+			break;
+		case HTTP_REQUEST_FILE:
+			if (fflush(result)) {
+				error_errno("unable to flush a file");
+				return HTTP_START_FAILED;
+			}
+			rewind(result);
+			if (ftruncate(fileno(result), 0) < 0) {
+				error_errno("unable to truncate a file");
+				return HTTP_START_FAILED;
+			}
+			break;
+		default:
+			BUG("Unknown http_request target");
+		}
 
-	/*
-	 * The previous request may have put cruft into our output stream; we
-	 * should clear it out before making our next request.
-	 */
-	switch (target) {
-	case HTTP_REQUEST_STRBUF:
-		strbuf_reset(result);
-		break;
-	case HTTP_REQUEST_FILE:
-		if (fflush(result)) {
-			error_errno("unable to flush a file");
-			return HTTP_START_FAILED;
-		}
-		rewind(result);
-		if (ftruncate(fileno(result), 0) < 0) {
-			error_errno("unable to truncate a file");
-			return HTTP_START_FAILED;
-		}
-		break;
-	default:
-		BUG("Unknown http_request target");
+		credential_fill(&http_auth, 1);
+
+		ret = http_request(url, result, target, options);
 	}
-
-	credential_fill(&http_auth, 1);
-
-	return http_request(url, result, target, options);
+	return ret;
 }
 
 int http_get_strbuf(const char *url,
diff --git a/t/t5563-simple-http-auth.sh b/t/t5563-simple-http-auth.sh
index 515185ae00..5d5caa3f58 100755
--- a/t/t5563-simple-http-auth.sh
+++ b/t/t5563-simple-http-auth.sh
@@ -21,9 +21,17 @@ test_expect_success 'setup_credential_helper' '
 	CREDENTIAL_HELPER="$TRASH_DIRECTORY/bin/git-credential-test-helper" &&
 	write_script "$CREDENTIAL_HELPER" <<-\EOF
 	cmd=$1
-	teefile=$cmd-query.cred
+	teefile=$cmd-query-temp.cred
 	catfile=$cmd-reply.cred
 	sed -n -e "/^$/q" -e "p" >>$teefile
+	state=$(sed -ne "s/^state\[\]=helper://p" "$teefile")
+	if test -z "$state"
+	then
+		mv "$teefile" "$cmd-query.cred"
+	else
+		mv "$teefile" "$cmd-query-$state.cred"
+		catfile="$cmd-reply-$state.cred"
+	fi
 	if test "$cmd" = "get"
 	then
 		cat $catfile
@@ -32,13 +40,15 @@ test_expect_success 'setup_credential_helper' '
 '
 
 set_credential_reply () {
-	cat >"$TRASH_DIRECTORY/$1-reply.cred"
+	local suffix="$(test -n "$2" && echo "-$2")"
+	cat >"$TRASH_DIRECTORY/$1-reply$suffix.cred"
 }
 
 expect_credential_query () {
-	cat >"$TRASH_DIRECTORY/$1-expect.cred" &&
-	test_cmp "$TRASH_DIRECTORY/$1-expect.cred" \
-		 "$TRASH_DIRECTORY/$1-query.cred"
+	local suffix="$(test -n "$2" && echo "-$2")"
+	cat >"$TRASH_DIRECTORY/$1-expect$suffix.cred" &&
+	test_cmp "$TRASH_DIRECTORY/$1-expect$suffix.cred" \
+		 "$TRASH_DIRECTORY/$1-query$suffix.cred"
 }
 
 per_test_cleanup () {
@@ -479,4 +489,73 @@ test_expect_success 'access using bearer auth with invalid credentials' '
 	EOF
 '
 
+test_expect_success 'access using three-legged auth' '
+	test_when_finished "per_test_cleanup" &&
+
+	set_credential_reply get <<-EOF &&
+	capability[]=authtype
+	capability[]=state
+	authtype=Multistage
+	credential=YS1naXQtdG9rZW4=
+	state[]=helper:foobar
+	continue=1
+	EOF
+
+	set_credential_reply get foobar <<-EOF &&
+	capability[]=authtype
+	capability[]=state
+	authtype=Multistage
+	credential=YW5vdGhlci10b2tlbg==
+	state[]=helper:bazquux
+	EOF
+
+	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
+	id=1 creds=Multistage YS1naXQtdG9rZW4=
+	id=2 creds=Multistage YW5vdGhlci10b2tlbg==
+	EOF
+
+	CHALLENGE="$HTTPD_ROOT_PATH/custom-auth.challenge" &&
+
+	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
+	id=1 status=401 response=WWW-Authenticate: Multistage challenge="456"
+	id=1 status=401 response=WWW-Authenticate: Bearer authorize_uri="id.example.com" p=1 q=0
+	id=2 status=200
+	id=default response=WWW-Authenticate: Multistage challenge="123"
+	id=default response=WWW-Authenticate: Bearer authorize_uri="id.example.com" p=1 q=0
+	EOF
+
+	test_config_global credential.helper test-helper &&
+	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
+
+	expect_credential_query get <<-EOF &&
+	capability[]=authtype
+	capability[]=state
+	protocol=http
+	host=$HTTPD_DEST
+	wwwauth[]=Multistage challenge="123"
+	wwwauth[]=Bearer authorize_uri="id.example.com" p=1 q=0
+	EOF
+
+	expect_credential_query get foobar <<-EOF &&
+	capability[]=authtype
+	capability[]=state
+	authtype=Multistage
+	protocol=http
+	host=$HTTPD_DEST
+	wwwauth[]=Multistage challenge="456"
+	wwwauth[]=Bearer authorize_uri="id.example.com" p=1 q=0
+	state[]=helper:foobar
+	EOF
+
+	expect_credential_query store bazquux <<-EOF
+	capability[]=authtype
+	capability[]=state
+	authtype=Multistage
+	credential=YW5vdGhlci10b2tlbg==
+	protocol=http
+	host=$HTTPD_DEST
+	state[]=helper:bazquux
+	EOF
+'
+
 test_done
