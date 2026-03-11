Received: from mail-gateway-shared02.cyon.net (mail-gateway-shared02.cyon.net [194.126.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0286A3D891C
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 12:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773231341; cv=none; b=t3GymOyIqYTnXWrQML+pl/ZZDYUfEo0PqZWVDKapq33R5yTXGMDIJnjPGl324xr55tk/pGFTQdGBSny0mKEHQ+2qHrbhtROrkjpTuJ04aTKZW+mmlTakDXf9PUXWAnJRfJPd6WzmctJLZdvhaeMmJIOSsnJzOSAskKHA1EmIg0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773231341; c=relaxed/simple;
	bh=Bu0NoD5cJddoQgqnyehx3J5WKPKpVI081+G3MZRPEaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvKciSR9Q171lPOy4hgMckheoL1pJyyTy3IUilHIOKqslwN52F+Dd4QOg8SRf7yoSo7uPP0nEsrVOXQVnjL+xZLLw5C0i+3wpMBFo+GdPc2t77YeSI3Eyi7txEGd33uwaQpBpwjObAN8XOHZ6bMY+2hwcELhevRkSkWqvAKCC4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared02.cyon.net with esmtpsa (TLS1.2:ECDHE_SECP256R1__RSA_SHA512__AES_256_GCM:256)
	(Exim)
	(envelope-from <ig@drbeat.li>)
	id 1w0IPW-008JrY-2N
	for git@vger.kernel.org;
	Wed, 11 Mar 2026 13:11:36 +0100
Received: from [10.20.10.52] (port=2998 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.98.1)
	(envelope-from <ig@drbeat.li>)
	id 1w0IPR-0000000BEpA-2bgU
	for git@vger.kernel.org;
	Wed, 11 Mar 2026 13:11:29 +0100
Received: from eap.internal (eap.internal [192.168.11.6])
	by oh4.internal (Postfix) with ESMTP id C270B4035E
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 13:11:28 +0100 (CET)
Received: from bb (uid 1000)
	(envelope-from bb@eap.internal)
	id 5403b4
	by eap.internal (DragonFly Mail Agent v0.14 on eap);
	Wed, 11 Mar 2026 13:11:28 +0100
From: Beat Bolli <dev+git@drbeat.li>
To: git@vger.kernel.org
Cc: Beat Bolli <dev+git@drbeat.li>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH 3/4] imap-send: remove two string length checks
Date: Wed, 11 Mar 2026 13:11:06 +0100
Message-ID: <20260311121107.1122387-4-dev+git@drbeat.li>
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

At this point, these two checks verify that the ASN1_STRINGs are
internally consistent. This may have been ok when the fields were
accessed directly, but now that the API is used, is unnecessary.

Remove the two checks.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 imap-send.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 2a904314dd..2bb0003f08 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -253,8 +253,6 @@ static int verify_hostname(X509 *cert, const char *hostname)
 			ASN1_STRING *subj_alt_str = GENERAL_NAME_get0_value(subj_alt_name, &ntype);
 
 			if (ntype == GEN_DNS &&
-			    strlen((const char *)ASN1_STRING_get0_data(subj_alt_str)) ==
-				    ASN1_STRING_length(subj_alt_str) &&
 			    host_matches(hostname, (const char *)ASN1_STRING_get0_data(subj_alt_str)))
 				found = 1;
 		}
@@ -270,8 +268,7 @@ static int verify_hostname(X509 *cert, const char *hostname)
 	    (cname_entry = X509_NAME_get_entry(subj, i)) == NULL ||
 	    (cname = X509_NAME_ENTRY_get_data(cname_entry)) == NULL)
 		return error("cannot get certificate common name");
-	if (strlen((const char *)ASN1_STRING_get0_data(cname)) == ASN1_STRING_length(cname) &&
-	    host_matches(hostname, (const char *)ASN1_STRING_get0_data(cname)))
+	if (host_matches(hostname, (const char *)ASN1_STRING_get0_data(cname)))
 		return 0;
 	return error("certificate owner '%s' does not match hostname '%s'",
 		     ASN1_STRING_get0_data(cname), hostname);
-- 
2.51.0

