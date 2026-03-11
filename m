Received: from mail-gateway-shared02.cyon.net (mail-gateway-shared02.cyon.net [194.126.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6897E36C9CA
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 22:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773267048; cv=none; b=PzdTkTwwoC+qfEQoKojOih9ZGmWcQZ+6nulPpvGn/NjHaUWUV0nX4Jd6foQinT6BEzdjgqLRp8Q9BZFrI9MbuPAyYgMvaLAzx4U1AQUy3ayZsiOkez0W5xFG7krTgZRrHjQGyJBATK9+oeUKBqNiJOVt8YTU4wexHg3kwAXShRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773267048; c=relaxed/simple;
	bh=fm+9zR0CkwOOvatW7Zpc5/+9Ve3rG4mS2K9lUCkUqYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYO5MuX1ElesUZxsET9wKwgTqKHzhTNxPWBcSDOARbxCBg7dazdJKy4TeISDiWhoD52vNK0J1VAq7PXKIsFPCfdE2H8rzRyRhe6Is8Gm0GcrCATZylRanBmc6xWBrJMRZbYwBwYczRCmMNj5TU0uY2vRRb3pyvPDyw6DFpyZIKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared02.cyon.net with esmtpsa (TLS1.2:ECDHE_SECP256R1__RSA_SHA512__AES_256_GCM:256)
	(Exim)
	(envelope-from <ig@drbeat.li>)
	id 1w0RlM-00AgPs-0Q
	for git@vger.kernel.org;
	Wed, 11 Mar 2026 23:10:45 +0100
Received: from [10.20.10.52] (port=57798 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.98.1)
	(envelope-from <ig@drbeat.li>)
	id 1w0RlG-0000000FgNH-43fW
	for git@vger.kernel.org;
	Wed, 11 Mar 2026 23:10:38 +0100
Received: from eap.internal (eap.internal [192.168.11.6])
	by oh4.internal (Postfix) with ESMTP id 2521C40465
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 23:10:38 +0100 (CET)
Received: from bb (uid 1000)
	(envelope-from bb@eap.internal)
	id 5403b4
	by eap.internal (DragonFly Mail Agent v0.14 on eap);
	Wed, 11 Mar 2026 23:10:38 +0100
From: Beat Bolli <dev+git@drbeat.li>
To: git@vger.kernel.org
Cc: Beat Bolli <dev+git@drbeat.li>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH v2 3/3] imap-send: move common code into function host_matches()
Date: Wed, 11 Mar 2026 23:10:27 +0100
Message-ID: <20260311221027.1404476-4-dev+git@drbeat.li>
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

Move the ASN1_STRING access, the associated cast and the check for
embedded NUL bytes into host_matches() to simplify both callers.

Reformulate the NUL check using memchr() and add a comment to make it
more obvious what it is about.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 imap-send.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 2a904314dd..af02c6a689 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -219,8 +219,14 @@ static int ssl_socket_connect(struct imap_socket *sock UNUSED,
 
 #else
 
-static int host_matches(const char *host, const char *pattern)
+static int host_matches(const char *host, const ASN1_STRING *asn1_str)
 {
+	const char *pattern = (const char *)ASN1_STRING_get0_data(asn1_str);
+
+	/* embedded NUL characters may open a security hole */
+	if (memchr(pattern, '\0', ASN1_STRING_length(asn1_str)))
+	    return 0;
+
 	if (pattern[0] == '*' && pattern[1] == '.') {
 		pattern += 2;
 		if (!(host = strchr(host, '.')))
@@ -252,10 +258,7 @@ static int verify_hostname(X509 *cert, const char *hostname)
 			GENERAL_NAME *subj_alt_name = sk_GENERAL_NAME_value(subj_alt_names, i);
 			ASN1_STRING *subj_alt_str = GENERAL_NAME_get0_value(subj_alt_name, &ntype);
 
-			if (ntype == GEN_DNS &&
-			    strlen((const char *)ASN1_STRING_get0_data(subj_alt_str)) ==
-				    ASN1_STRING_length(subj_alt_str) &&
-			    host_matches(hostname, (const char *)ASN1_STRING_get0_data(subj_alt_str)))
+			if (ntype == GEN_DNS && host_matches(hostname, subj_alt_str))
 				found = 1;
 		}
 		sk_GENERAL_NAME_pop_free(subj_alt_names, GENERAL_NAME_free);
@@ -270,8 +273,7 @@ static int verify_hostname(X509 *cert, const char *hostname)
 	    (cname_entry = X509_NAME_get_entry(subj, i)) == NULL ||
 	    (cname = X509_NAME_ENTRY_get_data(cname_entry)) == NULL)
 		return error("cannot get certificate common name");
-	if (strlen((const char *)ASN1_STRING_get0_data(cname)) == ASN1_STRING_length(cname) &&
-	    host_matches(hostname, (const char *)ASN1_STRING_get0_data(cname)))
+	if (host_matches(hostname, cname))
 		return 0;
 	return error("certificate owner '%s' does not match hostname '%s'",
 		     ASN1_STRING_get0_data(cname), hostname);
-- 
2.51.0

