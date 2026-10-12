Received: from mail-gateway-shared11.cyon.net (mail-gateway-shared11.cyon.net [194.126.200.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E2A4EDCDA
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 20:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791837077; cv=none; b=bGQbLbITyKcmxGfWhrnod1tzVbxkzRJ3LCmBio5yHo26JI7xfcAbnWuXlZnZd/GAFxS3nnGzEd+ACaa+hnBEI4EZnllFrDUm1Fa9Sn8fb/DSbvoIFBscknCGhfdxdFDlHULjGAez7AT2M2PK4VO+3cVcRFFoGMkx2M9Z1MBy0RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791837077; c=relaxed/simple;
	bh=drrV48kAlx9E1/04xkoUd3NFjM+74LTbR0r5C8XFNWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAR9lQiNtOyCH6cgRv4VjPRfQO6TBDan8tx7l8iaM+bAz38EvMaXuRhvJZ7XIh2Utip7CPCf3nKjdtYekjLeNG7YGaGLEGHX8wWwj8QjUy6XhmZ1T6qYk4s9CTb1+nUBKZaugp1EWDKpPLLmKaaUV/b+7031qSDR4qf3hfMWkYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared11.cyon.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim)
	(envelope-from <ig@drbeat.li>)
	id 1xGMft-000lKn-14
	for git@vger.kernel.org;
	Mon, 12 Oct 2026 22:31:11 +0200
Received: from [10.20.10.54] (port=65402 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.100.1)
	(envelope-from <ig@drbeat.li>)
	id 1xGMfp-0000000DigG-1H9y;
	Mon, 12 Oct 2026 22:31:04 +0200
Received: by oh4.internal (Postfix, from userid 1000)
	id CC0CD40610; Mon, 12 Oct 2026 22:31:03 +0200 (CEST)
From: Beat Bolli <dev+git@drbeat.li>
To: git@vger.kernel.org
Cc: Xiangfei Ding <xfding@google.com>,
	Aniket Gupta <aniketgupta3001@gmail.com>,
	Beat Bolli <dev+git@drbeat.li>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 2/2] imap-send: let OpenSSL do the hostname verification
Date: Mon, 12 Oct 2026 22:30:57 +0200
Message-ID: <20261012203057.969878-2-dev+git@drbeat.li>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907211210.2621693-1-dev+git@drbeat.li>
References: <20260907211210.2621693-1-dev+git@drbeat.li>
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

According to the OpenSSL Wiki[1], OpenSSL knows how to verify the peer's
hostname since version 1.0.2. A simpler interface is available since
1.1.0, which is what is implemented here.

As a side-effect, we get all present and future improvements done by
OpenSSL for free. E.g., the old code did not handle IP addresses in the
subject alternative names, while the new code does.

If the verification fails, print the error message as returned by
OpenSSL.

[1]: https://wiki.openssl.org/index.php/Hostname_validation

Suggested-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 imap-send.c | 86 +++++++++--------------------------------------------
 1 file changed, 14 insertions(+), 72 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 9f21705d77..cd9eae15d0 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -222,66 +222,6 @@ static int ssl_socket_connect(struct imap_socket *sock UNUSED,
 
 #else
 
-static int host_matches(const char *host, const ASN1_STRING *asn1_str)
-{
-	const char *pattern = (const char *)ASN1_STRING_get0_data(asn1_str);
-
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
-
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
-	}
-	if (found)
-		return 0;
-
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
-}
-
 static int ssl_socket_connect(struct imap_socket *sock,
 			      const struct imap_server_conf *cfg,
 			      int use_tls_only)
@@ -293,7 +233,6 @@ static int ssl_socket_connect(struct imap_socket *sock,
 #endif
 	SSL_CTX *ctx;
 	int ret;
-	X509 *cert;
 
 	SSL_library_init();
 	SSL_load_error_strings();
@@ -313,9 +252,6 @@ static int ssl_socket_connect(struct imap_socket *sock,
 	if (use_tls_only)
 		SSL_CTX_set_options(ctx, SSL_OP_NO_SSLv2 | SSL_OP_NO_SSLv3);
 
-	if (cfg->ssl_verify)
-		SSL_CTX_set_verify(ctx, SSL_VERIFY_PEER, NULL);
-
 	if (!SSL_CTX_set_default_verify_paths(ctx)) {
 		ssl_socket_perror("SSL_CTX_set_default_verify_paths");
 		return -1;
@@ -325,6 +261,15 @@ static int ssl_socket_connect(struct imap_socket *sock,
 		ssl_socket_perror("SSL_new");
 		return -1;
 	}
+	if (cfg->ssl_verify) {
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
@@ -352,14 +297,11 @@ static int ssl_socket_connect(struct imap_socket *sock,
 	}
 
 	if (cfg->ssl_verify) {
-		/* make sure the hostname matches that of the certificate */
-		cert = SSL_get_peer_certificate(sock->ssl);
-		if (!cert)
-			return error("unable to get peer certificate.");
-		if (SSL_get_verify_result(sock->ssl) != X509_V_OK)
-			return error("unable to verify peer certificate");
-		if (verify_hostname(cert, cfg->host) < 0)
-			return -1;
+		/* make sure the certificate was verified */
+		long res = SSL_get_verify_result(sock->ssl);
+		if (res != X509_V_OK)
+			return error("unable to verify peer certificate: %s",
+				     X509_verify_cert_error_string(res));
 	}
 
 	return 0;
-- 
2.53.0

