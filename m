Received: from mail-gateway-shared02.cyon.net (mail-gateway-shared02.cyon.net [194.126.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C16366553
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 22:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773267050; cv=none; b=H1o4bHVn2AGdOd9XuXV5cIknnO1OPDYo6yGZCq9UA7orPC+8yM9bHlsyBpMhBsXYhUM8pTLxcYP2XVqdVnWCCcbk2+nCpjj5WeDClp9oyavFf9HRdLpxDtlJ8zF2E3+KAsp2ka+9dwFPntCAjPnlBqda5BuWNKMndtgzkmVAJd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773267050; c=relaxed/simple;
	bh=RFf7VJIkV9DzMfkOpWF8aeAD+eadwmeTOyud4uRzxHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SfJVSuN0PlxLKv9wRYVC1lqcAfsPBaDTqkcoxTDjOaDOgiYg7uBPEBj3K8EPvQ38Ray6SbwqmlJgNGKTqt5hFDxPDTKurM44N3gW6tAT62hmUotNppPfrItdCI/HT6MQfux2spseXak58JyExqzl+zMzuPvRtvPsmOA2dn2JhDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared02.cyon.net with esmtpsa (TLS1.2:ECDHE_SECP256R1__RSA_SHA512__AES_256_GCM:256)
	(Exim)
	(envelope-from <ig@drbeat.li>)
	id 1w0RlM-00AgPq-0Q
	for git@vger.kernel.org;
	Wed, 11 Mar 2026 23:10:45 +0100
Received: from [10.20.10.53] (port=31806 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.98.1)
	(envelope-from <ig@drbeat.li>)
	id 1w0RlG-0000000FgN8-3qSU
	for git@vger.kernel.org;
	Wed, 11 Mar 2026 23:10:38 +0100
Received: from eap.internal (eap.internal [192.168.11.6])
	by oh4.internal (Postfix) with ESMTP id 223524045B
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 23:10:38 +0100 (CET)
Received: from bb (uid 1000)
	(envelope-from bb@eap.internal)
	id 54030d
	by eap.internal (DragonFly Mail Agent v0.14 on eap);
	Wed, 11 Mar 2026 23:10:38 +0100
From: Beat Bolli <dev+git@drbeat.li>
To: git@vger.kernel.org
Cc: Beat Bolli <dev+git@drbeat.li>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH v2 2/3] imap-send: use the OpenSSL API to access the subject common name
Date: Wed, 11 Mar 2026 23:10:26 +0100
Message-ID: <20260311221027.1404476-3-dev+git@drbeat.li>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260311121107.1122387-1-dev+git@drbeat.li>
References: <20260311121107.1122387-1-dev+git@drbeat.li>
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

The OpenSSL 4.0 master branch has deprecated the
X509_NAME_get_text_by_NID function. Use the recommended replacement APIs
instead. They have existed since OpenSSL v1.1.0.

Take care to get the constness right for pre-4.0 versions.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 imap-send.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 1c934c2487..2a904314dd 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -233,9 +233,13 @@ static int host_matches(const char *host, const char *pattern)
 
 static int verify_hostname(X509 *cert, const char *hostname)
 {
-	int len;
+#if (OPENSSL_VERSION_NUMBER >= 0x40000000L)
+	const X509_NAME *subj;
+#else
 	X509_NAME *subj;
-	char cname[1000];
+#endif
+	const X509_NAME_ENTRY *cname_entry;
+	const ASN1_STRING *cname;
 	int i, found;
 	STACK_OF(GENERAL_NAME) *subj_alt_names;
 
@@ -262,12 +266,15 @@ static int verify_hostname(X509 *cert, const char *hostname)
 	/* try the common name */
 	if (!(subj = X509_get_subject_name(cert)))
 		return error("cannot get certificate subject");
-	if ((len = X509_NAME_get_text_by_NID(subj, NID_commonName, cname, sizeof(cname))) < 0)
+	if ((i = X509_NAME_get_index_by_NID(subj, NID_commonName, -1)) < 0 ||
+	    (cname_entry = X509_NAME_get_entry(subj, i)) == NULL ||
+	    (cname = X509_NAME_ENTRY_get_data(cname_entry)) == NULL)
 		return error("cannot get certificate common name");
-	if (strlen(cname) == (size_t)len && host_matches(hostname, cname))
+	if (strlen((const char *)ASN1_STRING_get0_data(cname)) == ASN1_STRING_length(cname) &&
+	    host_matches(hostname, (const char *)ASN1_STRING_get0_data(cname)))
 		return 0;
 	return error("certificate owner '%s' does not match hostname '%s'",
-		     cname, hostname);
+		     ASN1_STRING_get0_data(cname), hostname);
 }
 
 static int ssl_socket_connect(struct imap_socket *sock,
-- 
2.51.0

