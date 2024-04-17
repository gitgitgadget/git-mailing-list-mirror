Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E5B5680
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 00:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713312186; cv=none; b=K1AEqqzbBM8h6h585OT5iD/EPNWKW41EPM62mYJ5rbfE8TTOqhN8L2+wsByPhDr4JOtCRH1fkk6SInZonuke4HlLfhUuZroRKUeHKmW3yZ/HZKv3MzIMLWzq848+UIDfTstNbYK9HB3V0rVdO8AGit/nIzOc3BIwkAxW6+QMDIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713312186; c=relaxed/simple;
	bh=8quWGpTsBQIRksQuP6cG61ynLNaTJvPBYRl5ekZay/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUZt2AoUP88Pn/nf74Lnt48IXTspr8RD/+8R47ad/eRkAitS6Ts9ozLLiZIqCm7zg22rHfqrH+E6KvFCG1rIgJnBBJT3LDgzFEBVzxesdoejy4UNZwVrejgTm7Rqu7nHXYl7K3pmkZDcBp1N3kJSZc87jI+3IRm7eV7TTyA7n/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=q1Ise9mX; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="q1Ise9mX"
Received: from tapette.tailf784c.ts.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 6F5005D4EA;
	Wed, 17 Apr 2024 00:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1713312177;
	bh=8quWGpTsBQIRksQuP6cG61ynLNaTJvPBYRl5ekZay/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=q1Ise9mXzPw6OvkTP2fX/kUVzqU+I+q7SLIIUeVG0B/+7DlwSAJWJZsIHa3FH1Ke+
	 STlBmQfZUPP1b2m9cDMom+HiXh9xpEuL23D/Ni+/+HOMGIMASyHNc5l2tTqsHWCpG+
	 4qwFwi6n+/boRFMOD0L5Cdq7eDiaTYcLMB703Ty//rfXBjVRirOPh5fLQvStSvDRWb
	 4gaxTLzdRl8pyVFJua5BMGdDRZgl9SC8X26OA9IprB50XZOrE1jJ/HR/cl022P9muT
	 /7KNMzM/FAhZmLfAe0qG4uxWN01ULm1HAbbPUzmDcYuL7EYC/EQewDARmqXmdn067x
	 iYos7T2ntuOj+0i63AfSTlJbMNhjZA92CsuAxG/ISuMLIrzhpvAq9YyMJI/2u2l1HW
	 cL/AYamoV4d8UfqCuXRe6F/5CGqZN//omDaxHTA83Zww+jpjrUXFesohMoUfhP5eCh
	 pznuN/7IRzXzQ2NXZns+uylDFJqQcg6iqR6rOQrssUi6no6a6SF
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>,
	Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 09/16] credential: add an argument to keep state
Date: Wed, 17 Apr 2024 00:02:33 +0000
Message-ID: <20240417000240.3611948-10-sandals@crustytoothpaste.net>
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

Until now, our credential code has mostly deal with usernames and
passwords and we've let libcurl deal with the variant of authentication
to be used.  However, now that we have the credential value, the
credential helper can take control of the authentication, so the value
provided might be something that's generated, such as a Digest hash
value.

In such a case, it would be helpful for a credential helper that gets an
erase or store command to be able to keep track of an identifier for the
original secret that went into the computation.  Furthermore, some types
of authentication, such as NTLM and Kerberos, actually need two round
trips to authenticate, which will require that the credential helper
keep some state.

In order to allow for these use cases and others, allow storing state in
a field called "state[]".  This value is passed back to the credential
helper that created it, which avoids confusion caused by parsing values
from different helpers.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-credential.txt | 28 +++++++++++++++++++---------
 credential.c                     | 20 +++++++++++++++++---
 credential.h                     |  7 +++++++
 t/t0300-credentials.sh           | 28 ++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index 230ac4c2c3..f63a8e0458 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -211,6 +211,15 @@ can determine whether the operation was successful.
 This value should not be sent unless the appropriate capability (see below) is
 provided on input.
 
+`state[]`::
+	This value provides an opaque state that will be passed back to this helper
+	if it is called again.  Each different credential helper may specify this
+	once.  The value should include a prefix unique to the credential helper and
+	should ignore values that don't match its prefix.
++
+This value should not be sent unless the appropriate capability (see below) is
+provided on input.
+
 `wwwauth[]`::
 
 	When an HTTP response is received by Git that includes one or more
@@ -223,18 +232,19 @@ they appear in the HTTP response. This attribute is 'one-way' from Git
 to pass additional information to credential helpers.
 
 `capability[]`::
-	This signals that the caller supports the capability in question.
-	This can be used to provide better, more specific data as part of the
+	This signals that Git, or the helper, as appropriate, supports the capability
+	in question.  This can be used to provide better, more specific data as part
+	of the protocol.  A `capability[]` directive must precede any value depending
+	on it and these directives _should_ be the first item announced in the
 	protocol.
 +
-The only capability currently supported is `authtype`, which indicates that the
-`authtype`, `credential`, and `ephemeral` values are understood.  It is not
-obligatory to use these values in such a case, but they should not be provided
-without this capability.
+There are two currently supported capabilities.  The first is `authtype`, which
+indicates that the `authtype`, `credential`, and `ephemeral` values are
+understood.  The second is `state`, which indicates that the `state[]` and
+`continue` values are understood.
 +
-Callers of `git credential` and credential helpers should emit the
-capabilities they support unconditionally, and Git will gracefully
-handle passing them on.
+It is not obligatory to use the additional features just because the capability
+is supported, but they should not be provided without the capability.
 
 Unrecognised attributes and capabilities are silently discarded.
 
diff --git a/credential.c b/credential.c
index 3531d74346..48826fb5a2 100644
--- a/credential.c
+++ b/credential.c
@@ -30,6 +30,7 @@ void credential_clear(struct credential *c)
 	free(c->authtype);
 	string_list_clear(&c->helpers, 0);
 	strvec_clear(&c->wwwauth_headers);
+	strvec_clear(&c->state_headers);
 
 	credential_init(c);
 }
@@ -293,8 +294,13 @@ int credential_read(struct credential *c, FILE *fp,
 			c->ephemeral = !!git_config_bool("ephemeral", value);
 		} else if (!strcmp(key, "wwwauth[]")) {
 			strvec_push(&c->wwwauth_headers, value);
-		} else if (!strcmp(key, "capability[]") && !strcmp(value, "authtype")) {
-			credential_set_capability(&c->capa_authtype, op_type);
+		} else if (!strcmp(key, "state[]")) {
+			strvec_push(&c->state_headers, value);
+		} else if (!strcmp(key, "capability[]")) {
+			if (!strcmp(value, "authtype"))
+				credential_set_capability(&c->capa_authtype, op_type);
+			else if (!strcmp(value, "state"))
+				credential_set_capability(&c->capa_state, op_type);
 		} else if (!strcmp(key, "password_expiry_utc")) {
 			errno = 0;
 			c->password_expiry_utc = parse_timestamp(value, NULL, 10);
@@ -337,8 +343,12 @@ static void credential_write_item(FILE *fp, const char *key, const char *value,
 void credential_write(const struct credential *c, FILE *fp,
 		      enum credential_op_type op_type)
 {
-	if (credential_has_capability(&c->capa_authtype, op_type)) {
+	if (credential_has_capability(&c->capa_authtype, op_type))
 		credential_write_item(fp, "capability[]", "authtype", 0);
+	if (credential_has_capability(&c->capa_state, op_type))
+		credential_write_item(fp, "capability[]", "state", 0);
+
+	if (credential_has_capability(&c->capa_authtype, op_type)) {
 		credential_write_item(fp, "authtype", c->authtype, 0);
 		credential_write_item(fp, "credential", c->credential, 0);
 		if (c->ephemeral)
@@ -357,6 +367,10 @@ void credential_write(const struct credential *c, FILE *fp,
 	}
 	for (size_t i = 0; i < c->wwwauth_headers.nr; i++)
 		credential_write_item(fp, "wwwauth[]", c->wwwauth_headers.v[i], 0);
+	if (credential_has_capability(&c->capa_state, op_type)) {
+		for (size_t i = 0; i < c->state_headers.nr; i++)
+			credential_write_item(fp, "state[]", c->state_headers.v[i], 0);
+	}
 }
 
 static int run_credential_helper(struct credential *c,
diff --git a/credential.h b/credential.h
index da2a4802b7..c307300d12 100644
--- a/credential.h
+++ b/credential.h
@@ -144,6 +144,11 @@ struct credential {
 	 */
 	struct strvec wwwauth_headers;
 
+	/**
+	 * A `strvec` of state headers from credential helpers.
+	 */
+	struct strvec state_headers;
+
 	/**
 	 * Internal use only. Keeps track of if we previously matched against a
 	 * WWW-Authenticate header line in order to re-fold future continuation
@@ -159,6 +164,7 @@ struct credential {
 		 username_from_proto:1;
 
 	struct credential_capability capa_authtype;
+	struct credential_capability capa_state;
 
 	char *username;
 	char *password;
@@ -180,6 +186,7 @@ struct credential {
 	.helpers = STRING_LIST_INIT_DUP, \
 	.password_expiry_utc = TIME_MAX, \
 	.wwwauth_headers = STRVEC_INIT, \
+	.state_headers = STRVEC_INIT, \
 }
 
 /* Initialize a credential structure, setting all fields to empty. */
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index eceb6bbfbe..432f029d48 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -46,9 +46,12 @@ test_expect_success 'setup helper scripts' '
 	credential=$1; shift
 	. ./dump
 	echo capability[]=authtype
+	echo capability[]=state
 	test -z "${capability##*authtype*}" || exit 0
 	test -z "$authtype" || echo authtype=$authtype
 	test -z "$credential" || echo credential=$credential
+	test -z "${capability##*state*}" || exit 0
+	echo state[]=verbatim-cred:foo
 	EOF
 
 	write_script git-credential-verbatim-ephemeral <<-\EOF &&
@@ -129,6 +132,28 @@ test_expect_success 'credential_fill invokes helper with ephemeral credential' '
 	verbatim-ephemeral: host=example.com
 	EOF
 '
+test_expect_success 'credential_fill invokes helper with credential and state' '
+	check fill "verbatim-cred Bearer token" <<-\EOF
+	capability[]=authtype
+	capability[]=state
+	protocol=http
+	host=example.com
+	--
+	capability[]=authtype
+	capability[]=state
+	authtype=Bearer
+	credential=token
+	protocol=http
+	host=example.com
+	state[]=verbatim-cred:foo
+	--
+	verbatim-cred: get
+	verbatim-cred: capability[]=authtype
+	verbatim-cred: capability[]=state
+	verbatim-cred: protocol=http
+	verbatim-cred: host=example.com
+	EOF
+'
 
 test_expect_success 'credential_fill invokes multiple helpers' '
 	check fill useless "verbatim foo bar" <<-\EOF
@@ -152,6 +177,7 @@ test_expect_success 'credential_fill invokes multiple helpers' '
 test_expect_success 'credential_fill response does not get capabilities when helpers are incapable' '
 	check fill useless "verbatim foo bar" <<-\EOF
 	capability[]=authtype
+	capability[]=state
 	protocol=http
 	host=example.com
 	--
@@ -162,10 +188,12 @@ test_expect_success 'credential_fill response does not get capabilities when hel
 	--
 	useless: get
 	useless: capability[]=authtype
+	useless: capability[]=state
 	useless: protocol=http
 	useless: host=example.com
 	verbatim: get
 	verbatim: capability[]=authtype
+	verbatim: capability[]=state
 	verbatim: protocol=http
 	verbatim: host=example.com
 	EOF
