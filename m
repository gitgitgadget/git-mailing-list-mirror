Received: from mail-gateway-shared11.cyon.net (mail-gateway-shared11.cyon.net [194.126.200.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3350D47D44D
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792231822; cv=none; b=qMCKO5M+kP0StBxxfQkewaeqtNLTaEtd9Maol31lcbiNH5R2ZpDCttCIecy/b7t9AzGhT7m7acdjXayTeMSfUwBRj22TCwP5ihRQ2jGuab3Lm5sDVRa8cFkBGazs/zAihGAtKyZR3OipRQayVLUZ52fxRK9NKx8KhHpl+1zOGEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792231822; c=relaxed/simple;
	bh=ktdgCucIRiSfUH+L9p7Ufy/Koi/5/tLWQL1lK/m2Ji4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knYy1+X2GDjAbbtYly9f1IejioUAikKOz6rUdWOQIy9zo4Dza6f/K3Febi/rHJHGyTihRJm+7m1LVZxHY47HfpnNGW8cMZgDI+nLJkykaZqCizWQ8k6fQAuYZlGLSzRwczt967j3POa2ZeMQB5Tw1xMd77zuqMszzv8qvyEsd+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared11.cyon.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim)
	(envelope-from <ig@drbeat.li>)
	id 1xI1Me-007OV3-2h
	for git@vger.kernel.org;
	Sat, 17 Oct 2026 12:10:10 +0200
Received: from [10.20.10.52] (port=32722 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.100.1)
	(envelope-from <ig@drbeat.li>)
	id 1xI1Md-0000000DUop-1n4i;
	Sat, 17 Oct 2026 12:10:03 +0200
Received: by oh4.internal (Postfix, from userid 1000)
	id 109DC40058; Sat, 17 Oct 2026 12:10:03 +0200 (CEST)
From: Beat Bolli <dev+git@drbeat.li>
To: git@vger.kernel.org
Cc: Xiangfei Ding <xfding@google.com>,
	Aniket Gupta <aniketgupta3001@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v3 3/3] imap-send: prepare for OpenSSL 4.0
Date: Sat, 17 Oct 2026 12:09:56 +0200
Message-ID: <20261017100956.529225-3-dev+git@drbeat.li>
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

OpenSSL 4.0 deprecated the SSL_set1_host function if favor of the new
function SSL_set1_dnsname, which fortunately takes the same parameters.

Add compatibility #defines for the function and its string variant for
the error message.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 imap-send.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index ec4e28e423..526bde2f55 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -248,6 +248,13 @@ static int verify_peer(const SSL *ssl, int did_connect)
 	return 0;
 }
 
+#if (OPENSSL_VERSION_NUMBER < 0x40000000L)
+#define SSL_set1_dnsname(ssl, host) SSL_set1_host((ssl), (host))
+#define SSL_SET_DNSNAME_FN "SSL_set1_host"
+#else
+#define SSL_SET_DNSNAME_FN "SSL_set1_dnsname"
+#endif
+
 static int ssl_socket_connect(struct imap_socket *sock,
 			      const struct imap_server_conf *cfg,
 			      int use_tls_only)
@@ -290,8 +297,8 @@ static int ssl_socket_connect(struct imap_socket *sock,
 	if (cfg->ssl_verify) {
 		/* follow RFC 9525 section 6.3: no partial wildcards */
 		SSL_set_hostflags(sock->ssl, X509_CHECK_FLAG_NO_PARTIAL_WILDCARDS);
-		if (!SSL_set1_host(sock->ssl, cfg->host)) {
-			ssl_socket_perror("SSL_set1_host");
+		if (!SSL_set1_dnsname(sock->ssl, cfg->host)) {
+			ssl_socket_perror(SSL_SET_DNSNAME_FN);
 			return -1;
 		}
 		SSL_set_verify(sock->ssl, SSL_VERIFY_PEER, NULL);
-- 
2.53.0

