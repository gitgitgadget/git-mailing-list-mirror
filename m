Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12328AD4C
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 00:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713312187; cv=none; b=KmD15S0Ul9SsskBaHPHq0Fcz9ZLNbesnGyyOgxhpG8a7Mtk6lrNudoXc6vPRiqVQTXQArX6GObYJmq7yakolZHErjSu7hc1pNFFjHu1GxXjF7J8vdXnhxjxgcR+D7peON0XNVxjGRu76MO3m1EMqp6NlTd4gEnsWi7FgSAptOqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713312187; c=relaxed/simple;
	bh=Hu9AMRoEfj8kJCz7oMU2qCqaJx7NMEVkkiMsL0Hq+c0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SIb5eiNGTR3tTfhbxYID32xn7+R0ZIZuO35Sf/ZXlO3T3zChsJZl0LO+6akSw5Y14ewuizU3k681sFq8VNUxYqmjB6qdELLG6dP6IliRfJ7CpL/3i7uOSOntK5rk73QIRsvxNVWIJXrKVqOAgZ0pcg1rbST+SwzyNKJsWiOTKvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=IuxdMQ4A; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="IuxdMQ4A"
Received: from tapette.tailf784c.ts.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id C69FD5D6D1;
	Wed, 17 Apr 2024 00:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1713312177;
	bh=Hu9AMRoEfj8kJCz7oMU2qCqaJx7NMEVkkiMsL0Hq+c0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=IuxdMQ4AnM2RschHxDh1evEmRsHBQMQDG6P7cyzW4BJSGbROHx1VDQi9p5BcUCgJZ
	 6Ka24DuA1XSMfT1hiill6sy7MS5dtgcCScTTJJ1KO5Oe9+fBz1b6K4+9CnV5k1LxCi
	 geBGxN4xHcwhxCMYKxSSGcvN83OfBdokHWxyb4HyzZpVivRtuX+hKVwSI3cj8wSIJ4
	 IoBHEaDNTfB/ZRkCjmgz23SONk08JX0hZV/PiivjtOLn8soU+i5v7za0BktpJ6XL+o
	 mrgnaJom7PeguTHy0sYyuhTb9dwV3GRRA811fGZNEatA4fu8hyRoyPvbSUfH3ag6Fi
	 TJssnoMxz678Ryml/tJVAPDqdH6dxaKwzOuqJaiMsyAAOG+muGpx9J2EweK+bvfpFD
	 O92ScNf3yX5nLcot//WY/7QcAmp/TNi35zURi4hItC6a+lTtgaWpkOSoqWkBCb5IR8
	 rHofskWJfJu5+v2CSekB1aTmopN8zT1EXKGSgNLhkTDfoeUilhK
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>,
	Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 15/16] credential-cache: implement authtype capability
Date: Wed, 17 Apr 2024 00:02:39 +0000
Message-ID: <20240417000240.3611948-16-sandals@crustytoothpaste.net>
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

Now that we have full support in Git for the authtype capability, let's
add support to the cache credential helper.

When parsing data, we always set the initial capabilities because we're
the helper, and we need both the initial and helper capabilities to be
set in order to have the helper capabilities take effect.

When emitting data, always emit the supported capability and make sure
we emit items only if we have them and they're supported by the caller.
Since we may no longer have a username or password, be sure to emit
those conditionally as well so we don't segfault on a NULL pointer.
Similarly, when comparing credentials, consider both the password and
credential fields when we're matching passwords.

Adjust the partial credential detection code so that we can store
credentials missing a username or password as long as they have an
authtype and credential.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/credential-cache--daemon.c | 20 +++++++++++++++++---
 credential.c                       |  7 ++++---
 credential.h                       |  6 ++++++
 t/t0301-credential-cache.sh        |  1 +
 4 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index ccbcf99ac1..6ffedcd17c 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -115,6 +115,8 @@ static int read_request(FILE *fh, struct credential *c,
 		return error("client sent bogus timeout line: %s", item.buf);
 	*timeout = atoi(p);
 
+	credential_set_all_capabilities(c, CREDENTIAL_OP_INITIAL);
+
 	if (credential_read(c, fh, CREDENTIAL_OP_HELPER) < 0)
 		return -1;
 	return 0;
@@ -131,8 +133,18 @@ static void serve_one_client(FILE *in, FILE *out)
 	else if (!strcmp(action.buf, "get")) {
 		struct credential_cache_entry *e = lookup_credential(&c);
 		if (e) {
-			fprintf(out, "username=%s\n", e->item.username);
-			fprintf(out, "password=%s\n", e->item.password);
+			e->item.capa_authtype.request_initial = 1;
+			e->item.capa_authtype.request_helper = 1;
+
+			fprintf(out, "capability[]=authtype\n");
+			if (e->item.username)
+				fprintf(out, "username=%s\n", e->item.username);
+			if (e->item.password)
+				fprintf(out, "password=%s\n", e->item.password);
+			if (credential_has_capability(&c.capa_authtype, CREDENTIAL_OP_HELPER) && e->item.authtype)
+				fprintf(out, "authtype=%s\n", e->item.authtype);
+			if (credential_has_capability(&c.capa_authtype, CREDENTIAL_OP_HELPER) && e->item.credential)
+				fprintf(out, "credential=%s\n", e->item.credential);
 			if (e->item.password_expiry_utc != TIME_MAX)
 				fprintf(out, "password_expiry_utc=%"PRItime"\n",
 					e->item.password_expiry_utc);
@@ -157,8 +169,10 @@ static void serve_one_client(FILE *in, FILE *out)
 	else if (!strcmp(action.buf, "store")) {
 		if (timeout < 0)
 			warning("cache client didn't specify a timeout");
-		else if (!c.username || !c.password)
+		else if ((!c.username || !c.password) && (!c.authtype && !c.credential))
 			warning("cache client gave us a partial credential");
+		else if (c.ephemeral)
+			warning("not storing ephemeral credential");
 		else {
 			remove_credential(&c, 0);
 			cache_credential(&c, timeout);
diff --git a/credential.c b/credential.c
index 98b040cf11..ffaf31499e 100644
--- a/credential.c
+++ b/credential.c
@@ -80,7 +80,8 @@ int credential_match(const struct credential *want,
 	       CHECK(host) &&
 	       CHECK(path) &&
 	       CHECK(username) &&
-	       (!match_password || CHECK(password));
+	       (!match_password || CHECK(password)) &&
+	       (!match_password || CHECK(credential));
 #undef CHECK
 }
 
@@ -248,8 +249,8 @@ static void credential_getpass(struct credential *c)
 						 PROMPT_ASKPASS);
 }
 
-static int credential_has_capability(const struct credential_capability *capa,
-				     enum credential_op_type op_type)
+int credential_has_capability(const struct credential_capability *capa,
+			      enum credential_op_type op_type)
 {
 	/*
 	 * We're checking here if each previous step indicated that we had the
diff --git a/credential.h b/credential.h
index 19163fc6a0..f8df10937c 100644
--- a/credential.h
+++ b/credential.h
@@ -263,6 +263,12 @@ void credential_clear_secrets(struct credential *c);
  */
 void credential_next_state(struct credential *c);
 
+/**
+ * Return true if the capability is enabled for an operation of op_type.
+ */
+int credential_has_capability(const struct credential_capability *capa,
+			      enum credential_op_type op_type);
+
 int credential_read(struct credential *, FILE *,
 		    enum credential_op_type);
 void credential_write(const struct credential *, FILE *,
diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
index 8300faadea..3897353d55 100755
--- a/t/t0301-credential-cache.sh
+++ b/t/t0301-credential-cache.sh
@@ -31,6 +31,7 @@ test_atexit 'git credential-cache exit'
 helper_test cache
 helper_test_password_expiry_utc cache
 helper_test_oauth_refresh_token cache
+helper_test_authtype cache
 
 test_expect_success 'socket defaults to ~/.cache/git/credential/socket' '
 	test_when_finished "
