Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841052F2E
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 00:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713312184; cv=none; b=svdMKXiRAAyinJEh80WnXbA1jzY41kDs7UyD+DROhqJya3iIgFIosJ53eS+VNVDOtJ9sdTQu7Nvnqt6a1NlrzXy3ZVf+xskTSR/0IQ1yeYPJt2SCaTXKvJSlXkjXFvrZGomB4Hz3QijDyBTf8ShAjMXcQG3uX9AJN2UdX/8rUgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713312184; c=relaxed/simple;
	bh=3Rn148Tb27U7Koze/W8bg0Ri3gJwwh7RJc898Sg4wXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ej6ByzP+GNqPCIU2eqzBQYJH09HNCDym44a4gYl5DkPwp7nkAiQeCW+JGtxEK9cNYixNUNfL4JiMnjdMnWhOCIDmLXUtQJL7/t6Jd+wpKk2GhUf6JdgpIY+6j2DrXKDbAbJaB8DvmPL2XZwYa5UmJNwrHhI+PpcGZgAKV43pkN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=xvZhutbU; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="xvZhutbU"
Received: from tapette.tailf784c.ts.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id EA9625D4E2;
	Wed, 17 Apr 2024 00:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1713312176;
	bh=3Rn148Tb27U7Koze/W8bg0Ri3gJwwh7RJc898Sg4wXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=xvZhutbUJXDOr5bc1tXfeFBdge+ST21eyP7C7sULp+RY7TEDg+dh1wbwpNpRGSRAr
	 dUyyVbCY8L/QMoE/ZlGPww5wYfpiWy1FUB1BExBnPTqhURZQhHJgkDFr9Xhxj15HhJ
	 26+NEY1GNJ+ZheHt6X5Hddj78K4Izqxaz/6maRsoyi6usNBIy0hNxJxFirDIXNUD47
	 jXgJI8VblZkRmefYAWrUsOh62pJRe3ipGEonbk/kis35USLCX/MJA6i5WWvB6XEvN0
	 lecVzt4Z1iuaYju3334zpaXcLEFGExBOGgvj25TQKlJOItzU66XKL6m6O8AK8Fualg
	 VYtPCauuKXvGMRxaug2vYbfxX0P/X1bLJzvBWdrA/0tyidL0syNhi/f6pIEWo+38Mv
	 JkVMwC91IpFtXH9F8JY8nUoIS+BzUVdDqPPmIDlcfH2keAsUS1uSKfdfkmbqdUuPD/
	 erzpzrbsYBLqa9jjn7oeqbpNF/dnE8mHL/KyP7dvdCI7qpIFkVI
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>,
	Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 01/16] credential: add an authtype field
Date: Wed, 17 Apr 2024 00:02:25 +0000
Message-ID: <20240417000240.3611948-2-sandals@crustytoothpaste.net>
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

When Git makes an HTTP request, it can negotiate the type of
authentication to use with the server provided the authentication scheme
is one of a few well-known types (Basic, Digest, NTLM, or Negotiate).
However, some servers wish to use other types of authentication, such as
the Bearer type from OAuth2.  Since libcurl doesn't natively support
this type, it isn't possible to use it, and the user is forced to
specify the Authorization header using the http.extraheader setting.

However, storing a plaintext token in the repository configuration is
not very secure, especially if a repository can be shared by multiple
parties.  We already have support for many types of secure credential
storage by using credential helpers, so let's teach credential helpers
how to produce credentials for an arbitrary scheme.

If the credential helper specifies an authtype field, then it specifies
an authentication scheme (e.g., Bearer) and the password field specifies
the raw authentication token, with any encoding already specified.  We
reuse the password field for this because some credential helpers store
the metadata without encryption even though the password is encrypted,
and we'd like to avoid insecure storage if an older version of the
credential helper gets ahold of the data.

The username is not used in this case, but it is still preserved for the
purpose of finding the right credential if the user has multiple
accounts.

If the authtype field is not specified, then the password behaves as
normal and it is passed along with the username to libcurl.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 credential.c | 5 +++++
 credential.h | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/credential.c b/credential.c
index 18098bd35e..3dec433df5 100644
--- a/credential.c
+++ b/credential.c
@@ -26,6 +26,7 @@ void credential_clear(struct credential *c)
 	free(c->username);
 	free(c->password);
 	free(c->oauth_refresh_token);
+	free(c->authtype);
 	string_list_clear(&c->helpers, 0);
 	strvec_clear(&c->wwwauth_headers);
 
@@ -252,6 +253,9 @@ int credential_read(struct credential *c, FILE *fp)
 		} else if (!strcmp(key, "oauth_refresh_token")) {
 			free(c->oauth_refresh_token);
 			c->oauth_refresh_token = xstrdup(value);
+		} else if (!strcmp(key, "authtype")) {
+			free(c->authtype);
+			c->authtype = xstrdup(value);
 		} else if (!strcmp(key, "url")) {
 			credential_from_url(c, value);
 		} else if (!strcmp(key, "quit")) {
@@ -295,6 +299,7 @@ void credential_write(const struct credential *c, FILE *fp)
 	}
 	for (size_t i = 0; i < c->wwwauth_headers.nr; i++)
 		credential_write_item(fp, "wwwauth[]", c->wwwauth_headers.v[i], 0);
+	credential_write_item(fp, "authtype", c->authtype, 0);
 }
 
 static int run_credential_helper(struct credential *c,
diff --git a/credential.h b/credential.h
index acc41adf54..dc96ca0318 100644
--- a/credential.h
+++ b/credential.h
@@ -143,6 +143,12 @@ struct credential {
 	char *path;
 	char *oauth_refresh_token;
 	timestamp_t password_expiry_utc;
+
+	/**
+	 * The authorization scheme to use.  If this is NULL, libcurl is free to
+	 * negotiate any scheme it likes.
+	 */
+	char *authtype;
 };
 
 #define CREDENTIAL_INIT { \
