Received: from mail-gateway-shared11.cyon.net (mail-gateway-shared11.cyon.net [194.126.200.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA82647DD7C
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 10:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792231823; cv=none; b=nFvkLZ6q2THbmGnVgqeA65Gzaf+Xo4Wku/95PXCwydgeOb+Gy5kaLdyNcjDxsPdFEpfRXJ4W4hjse+NvF00UUY0PS8VyWidIdclN1QY6rjX4fAs0p85WKy3/FhFYFCk2F85zUW4TfoyUB8fny85Rjh1M3kpQ96ZfsqLDQceUTkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792231823; c=relaxed/simple;
	bh=ZXTd38g+c8v2k5tvydYya7enPQo2pg6khwx9CcQMk1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rca9imRSxUek60eJIYpFubPRxIHGKPCAqDlOkZIVpA+/m+lFBzKyd0QdFxf//IwYEUvv6LmGeBQI4QvAyzu6B7IWBLfQ0PgTrO1OW/Yr168RHKfHeDVlFtaZD1juZ1PdRelnjPNQ4S9L1vWs3Lc/1Z/1DAnZpGe0WF8D/VAqHNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared11.cyon.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim)
	(envelope-from <ig@drbeat.li>)
	id 1xI1Me-007OUu-2j
	for git@vger.kernel.org;
	Sat, 17 Oct 2026 12:10:11 +0200
Received: from [10.20.10.54] (port=6568 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.100.1)
	(envelope-from <ig@drbeat.li>)
	id 1xI1Md-0000000DUol-1dsF;
	Sat, 17 Oct 2026 12:10:03 +0200
Received: by oh4.internal (Postfix, from userid 1000)
	id 0AC6B40053; Sat, 17 Oct 2026 12:10:03 +0200 (CEST)
From: Beat Bolli <dev+git@drbeat.li>
To: git@vger.kernel.org
Cc: Xiangfei Ding <xfding@google.com>,
	Aniket Gupta <aniketgupta3001@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v3 2/3] imap-send: let OpenSSL do the hostname verification
Date: Sat, 17 Oct 2026 12:09:55 +0200
Message-ID: <20261017100956.529225-2-dev+git@drbeat.li>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261017100956.529225-1-dev+git@drbeat.li>
References: <20261012203057.969878-1-dev+git@drbeat.li>
 <20261017100956.529225-1-dev+git@drbeat.li>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li

imap-send performs its own TLS hostname verification. This is not ideal
because it does not support all certificate features.

Let's use OpenSSL built-in verification, which is supported in its
current form since OpenSSL 1.1.0. This gets us all present and future
improvements done by OpenSSL for free. E.g., the old code did not handle
IP addresses in the subject alternative names, while the new code does.

If the verification fails, print the error message as returned by
OpenSSL.

[1]: https://wiki.openssl.org/index.php/Hostname_validation

Suggested-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
We cannot easily print the certificate's hostname in case of a mismatch,
but the cURL branch does not, either.

Unfortuately, the diff looks bad because two functions are replaced by
the new verify_peer() function that is completely unrelated.

 imap-send.c | 101 +++++++++++++++++-----------------------------------
 1 file changed, 33 insertions(+), 68 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 9f21705d77..ec4e28e423 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -222,64 +222,30 @@ static int ssl_socket_connect(struct imap_socket *sock UNUSED,
 
 #else
 
-static int host_matches(const char *host, const ASN1_STRING *asn1_str)
+static int verify_peer(const SSL *ssl, int did_connect)
 {
-	const char *pattern = (const char *)ASN1_STRING_get0_data(asn1_str);
+	long verify;
 
-	/* embedded NUL characters may open a security hole */
-	if (memchr(pattern, '\0', ASN1_STRING_length(asn1_str)))
-	    return 0;
-
-	if (pattern[0] == '*' && pattern[1] == '.') {
-		pattern += 2;
-		if (!(host = strchr(host, '.')))
-			return 0;
-		host++;
-	}
-
-	return *host && *pattern && !strcasecmp(host, pattern);
-}
+	/*
+	 * If we connected, we require a certificate.
+	 * If we did not connect because of a certificate error, the server
+	 * certificate is not installed in the SSL*, but the verification
+	 * result will still be returned below.
+	 */
+	if (did_connect) {
+		X509 *cert = SSL_get_peer_certificate(ssl);
 
-static int verify_hostname(X509 *cert, const char *hostname)
-{
-#if (OPENSSL_VERSION_NUMBER >= 0x40000000L)
-	const X509_NAME *subj;
-#else
-	X509_NAME *subj;
-#endif
-	const X509_NAME_ENTRY *cname_entry;
-	const ASN1_STRING *cname;
-	int i, found;
-	STACK_OF(GENERAL_NAME) *subj_alt_names;
-
-	/* try the DNS subjectAltNames */
-	found = 0;
-	if ((subj_alt_names = X509_get_ext_d2i(cert, NID_subject_alt_name, NULL, NULL))) {
-		int num_subj_alt_names = sk_GENERAL_NAME_num(subj_alt_names);
-		for (i = 0; !found && i < num_subj_alt_names; i++) {
-			int ntype;
-			GENERAL_NAME *subj_alt_name = sk_GENERAL_NAME_value(subj_alt_names, i);
-			ASN1_STRING *subj_alt_str = GENERAL_NAME_get0_value(subj_alt_name, &ntype);
-
-			if (ntype == GEN_DNS && host_matches(hostname, subj_alt_str))
-				found = 1;
-		}
-		sk_GENERAL_NAME_pop_free(subj_alt_names, GENERAL_NAME_free);
+		if (!cert)
+			return error("unable to get peer certificate.");
+		X509_free(cert);
 	}
-	if (found)
-		return 0;
 
-	/* try the common name */
-	if (!(subj = X509_get_subject_name(cert)))
-		return error("cannot get certificate subject");
-	if ((i = X509_NAME_get_index_by_NID(subj, NID_commonName, -1)) < 0 ||
-	    (cname_entry = X509_NAME_get_entry(subj, i)) == NULL ||
-	    (cname = X509_NAME_ENTRY_get_data(cname_entry)) == NULL)
-		return error("cannot get certificate common name");
-	if (host_matches(hostname, cname))
-		return 0;
-	return error("certificate owner '%s' does not match hostname '%s'",
-		     ASN1_STRING_get0_data(cname), hostname);
+	/* check the verification result, ignoring the connection success */
+	verify = SSL_get_verify_result(ssl);
+	if (verify != X509_V_OK)
+		return error("unable to verify peer certificate: %s",
+			     X509_verify_cert_error_string(verify));
+	return 0;
 }
 
 static int ssl_socket_connect(struct imap_socket *sock,
@@ -293,7 +259,6 @@ static int ssl_socket_connect(struct imap_socket *sock,
 #endif
 	SSL_CTX *ctx;
 	int ret;
-	X509 *cert;
 
 	SSL_library_init();
 	SSL_load_error_strings();
@@ -313,9 +278,6 @@ static int ssl_socket_connect(struct imap_socket *sock,
 	if (use_tls_only)
 		SSL_CTX_set_options(ctx, SSL_OP_NO_SSLv2 | SSL_OP_NO_SSLv3);
 
-	if (cfg->ssl_verify)
-		SSL_CTX_set_verify(ctx, SSL_VERIFY_PEER, NULL);
-
 	if (!SSL_CTX_set_default_verify_paths(ctx)) {
 		ssl_socket_perror("SSL_CTX_set_default_verify_paths");
 		return -1;
@@ -325,6 +287,16 @@ static int ssl_socket_connect(struct imap_socket *sock,
 		ssl_socket_perror("SSL_new");
 		return -1;
 	}
+	if (cfg->ssl_verify) {
+		/* follow RFC 9525 section 6.3: no partial wildcards */
+		SSL_set_hostflags(sock->ssl, X509_CHECK_FLAG_NO_PARTIAL_WILDCARDS);
+		if (!SSL_set1_host(sock->ssl, cfg->host)) {
+			ssl_socket_perror("SSL_set1_host");
+			return -1;
+		}
+		SSL_set_verify(sock->ssl, SSL_VERIFY_PEER, NULL);
+	}
+
 	if (!SSL_set_rfd(sock->ssl, sock->fd[0])) {
 		ssl_socket_perror("SSL_set_rfd");
 		return -1;
@@ -348,20 +320,13 @@ static int ssl_socket_connect(struct imap_socket *sock,
 	ret = SSL_connect(sock->ssl);
 	if (ret <= 0) {
 		socket_perror("SSL_connect", sock, ret);
+		if (cfg->ssl_verify)
+			verify_peer(sock->ssl, 0);
 		return -1;
 	}
 
-	if (cfg->ssl_verify) {
-		/* make sure the hostname matches that of the certificate */
-		cert = SSL_get_peer_certificate(sock->ssl);
-		if (!cert)
-			return error("unable to get peer certificate.");
-		if (SSL_get_verify_result(sock->ssl) != X509_V_OK)
-			return error("unable to verify peer certificate");
-		if (verify_hostname(cert, cfg->host) < 0)
-			return -1;
-	}
-
+	if (cfg->ssl_verify)
+		return verify_peer(sock->ssl, 1);
 	return 0;
 }
 #endif
-- 
2.53.0

