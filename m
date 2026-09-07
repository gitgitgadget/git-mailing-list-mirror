Received: from mail-gateway-shared15.cyon.net (mail-gateway-shared15.cyon.net [194.126.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02473BADAA
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 21:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788816192; cv=none; b=dJ7xqcd96LtHMgBzf3hPJ5C9f9VO7WiTjNP1qR7aKOFGAoJRRkNMlgFEnn+JH/Ryj974yl5ut1eG69TJvth9M1vGy3GjYK+W05JaShUbKs8BUX9K+x8qRRlyR7pdBVBkZiO+khyj47lTP1n867Qdwfi9E6LPhoamHRlhskZz49g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788816192; c=relaxed/simple;
	bh=XtypgurtOIVmHs61ElcntS+7WwkPYcJhABKmtNxNe4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ssQe39A7TY8tWEosU0QIRNMwDrdFdYLcEktB40EwBIme86DdU+ZHIh2NOX6tIsdao4QXJNXH8af3k8JS20bXmBjjIaSS0dCsLmcyb4yAruY3YxwqCnzIVsag2SWhHO1A4qB/46JKNnz5WysbPn0ONeOZ6d+5ICOZxVlRkvA2NzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared15.cyon.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim)
	(envelope-from <ig@drbeat.li>)
	id 1x3gdm-00ASma-0E
	for git@vger.kernel.org;
	Mon, 07 Sep 2026 23:12:35 +0200
Received: from [10.20.10.52] (port=25668 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.99.4)
	(envelope-from <ig@drbeat.li>)
	id 1x3gdg-00000005Wd9-3xwI;
	Mon, 07 Sep 2026 23:12:28 +0200
Received: by oh4.internal (Postfix, from userid 1000)
	id AF3743FF23; Mon, 07 Sep 2026 23:12:28 +0200 (CEST)
From: Beat Bolli <dev+git@drbeat.li>
To: git@vger.kernel.org
Cc: Oswald Buddenhagen <ossi@kde.org>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 1/3] imap-send: prepare for OpenSSL 4.1
Date: Mon,  7 Sep 2026 23:12:08 +0200
Message-ID: <20260907211210.2621693-2-dev+git@drbeat.li>
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

OpenSSL master (to be v4.1 after the release) renamed the function
ASN1_STRING_length() to ASN1_STRING_get_length(). Map the new name to
the old one if we're compiling with a pre-4.1 version.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 imap-send.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index 0d16d02029..977d78005c 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -219,12 +219,17 @@ static int ssl_socket_connect(struct imap_socket *sock UNUSED,
 
 #else
 
+#if (OPENSSL_VERSION_NUMBER < 0x40100000L)
+// map to the pre-4.1 name
+#define ASN1_STRING_get_length(s) ASN1_STRING_length(s)
+#endif
+
 static int host_matches(const char *host, const ASN1_STRING *asn1_str)
 {
 	const char *pattern = (const char *)ASN1_STRING_get0_data(asn1_str);
 
 	/* embedded NUL characters may open a security hole */
-	if (memchr(pattern, '\0', ASN1_STRING_length(asn1_str)))
+	if (memchr(pattern, '\0', ASN1_STRING_get_length(asn1_str)))
 	    return 0;
 
 	if (pattern[0] == '*' && pattern[1] == '.') {
-- 
2.53.0

