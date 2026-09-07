Received: from mail-gateway-shared15.cyon.net (mail-gateway-shared15.cyon.net [194.126.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0544E367B92
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 21:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788816186; cv=none; b=riYUd7EizowgG0mZd05nmOqgmpyUGQhXoelUCoTjUZP7XUPEw0Bk/n4WgMSji6I39wg/mgMTVVTDxC25DhbA1idTC7FE7aRfps8m+gK4L1byeXnwmsAPYCKBBmsktehJ/BH9ouMrNANTRzUAZ0JQKFY2NZOjIZ9Y6TSfra8f40U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788816186; c=relaxed/simple;
	bh=xTn8RohfzoEsJon1aMwTSjvBbx82PuXmzEq5veFyU9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n098jwd/uf8pF/gSeLItnOjjmgQ5ANIjljLFdxKpemR54t1cUAuSbngYJOUKnW1NJiAlcs2ym+/1YxDKs0mCLfPJkcf9SaKxOsssCtxB7DcDYkX2R8HzjtHohGkwk/gc9x/5AlX1VYV4P++0oisX6i4vkSTB0Kf/CICB/x2ON8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared15.cyon.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim)
	(envelope-from <ig@drbeat.li>)
	id 1x3gdm-00ASmX-0D
	for git@vger.kernel.org;
	Mon, 07 Sep 2026 23:12:35 +0200
Received: from [10.20.10.51] (port=27010 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.99.4)
	(envelope-from <ig@drbeat.li>)
	id 1x3gdg-00000005WdA-40gd;
	Mon, 07 Sep 2026 23:12:28 +0200
Received: by oh4.internal (Postfix, from userid 1000)
	id B5C954008E; Mon, 07 Sep 2026 23:12:28 +0200 (CEST)
From: Beat Bolli <dev+git@drbeat.li>
To: git@vger.kernel.org
Cc: Oswald Buddenhagen <ossi@kde.org>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 2/3] imap-send: don't expect an ASN1_STRING to be NUL-terminated
Date: Mon,  7 Sep 2026 23:12:09 +0200
Message-ID: <20260907211210.2621693-3-dev+git@drbeat.li>
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

As highlighted by a recent OpenSSL commit[1], ASN1_STRINGs were never
documented to be terminated by a NUL byte, but our code treats the
pattern as such in the strcasecmp() call.

Make a NUL-terminated copy to avoid Undefined Behavior.

[1]: https://github.com/openssl/openssl/commit/4b581a4666c3e470a01a7323801b2ba8ccfa478c
     (Add a migration entry for ASN1_STRINGs, 2026-08-06)

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 imap-send.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 977d78005c..9a807cdde8 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -226,20 +226,25 @@ static int ssl_socket_connect(struct imap_socket *sock UNUSED,
 
 static int host_matches(const char *host, const ASN1_STRING *asn1_str)
 {
-	const char *pattern = (const char *)ASN1_STRING_get0_data(asn1_str);
+	int ret = 0;
+	size_t len = ASN1_STRING_get_length(asn1_str);
+	char *pattern = xmemdupz(ASN1_STRING_get0_data(asn1_str), len);
 
 	/* embedded NUL characters may open a security hole */
-	if (memchr(pattern, '\0', ASN1_STRING_get_length(asn1_str)))
-	    return 0;
+	if (memchr(pattern, '\0', len))
+	    goto out;
 
 	if (pattern[0] == '*' && pattern[1] == '.') {
 		pattern += 2;
 		if (!(host = strchr(host, '.')))
-			return 0;
+			goto out;
 		host++;
 	}
 
-	return *host && *pattern && !strcasecmp(host, pattern);
+	ret = *host && *pattern && !strcasecmp(host, pattern);
+out:
+	free(pattern);
+	return ret;
 }
 
 static int verify_hostname(X509 *cert, const char *hostname)
-- 
2.53.0

