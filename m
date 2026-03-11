Received: from mail-gateway-shared02.cyon.net (mail-gateway-shared02.cyon.net [194.126.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D3231E82A
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 12:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773231516; cv=none; b=fejqfOFoaz/Z3GYln7E+8DuyRANJJ0abManagrEnqYka3uBihoSMXgYmrww2ZIte4KuazpJDD7QrMHva7fQZwgoWvIXgS+0GXLYXKDNPiHuEoMtf2c4YvcDmYWFFWR+aPVmOVXRcYqETXtkdKPGB/KXbJwZXprQfE8xxuHEXUuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773231516; c=relaxed/simple;
	bh=vnVTh/RXO/IWmkWkTp6+ynGTZpd2mCadk2FuoLgiMC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YNs+5JAx649SxgqYd/VmJ38lsEPfYfckETdQO8HBm68jLD9zFYH2emqF8OXbN987U5jBL/4yq69afwtVHjizbokHMRRY0NCvWoZGmT8D8SHdl91TCFfrWFGQbMBDz52q4iEOXfdubUX1hDMyg5hVvI8/1Ohb4edvBTDBKP1LIVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared02.cyon.net with esmtpsa (TLS1.2:ECDHE_SECP256R1__RSA_SHA512__AES_256_GCM:256)
	(Exim)
	(envelope-from <ig@drbeat.li>)
	id 1w0IPW-008JrX-2N
	for git@vger.kernel.org;
	Wed, 11 Mar 2026 13:11:36 +0100
Received: from [10.20.10.53] (port=50538 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.98.1)
	(envelope-from <ig@drbeat.li>)
	id 1w0IPR-0000000BEp9-2Y0d
	for git@vger.kernel.org;
	Wed, 11 Mar 2026 13:11:29 +0100
Received: from eap.internal (eap.internal [192.168.11.6])
	by oh4.internal (Postfix) with ESMTP id C2D6140463
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 13:11:28 +0100 (CET)
Received: from bb (uid 1000)
	(envelope-from bb@eap.internal)
	id 5404ad
	by eap.internal (DragonFly Mail Agent v0.14 on eap);
	Wed, 11 Mar 2026 13:11:28 +0100
From: Beat Bolli <dev+git@drbeat.li>
To: git@vger.kernel.org
Cc: Beat Bolli <dev+git@drbeat.li>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH 4/4] imap-send: refactor function host_matches()
Date: Wed, 11 Mar 2026 13:11:07 +0100
Message-ID: <20260311121107.1122387-5-dev+git@drbeat.li>
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

Move the ASN1_STRING access and the associated cast into host_matches()
to simplify both callers.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 imap-send.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 2bb0003f08..789055d7fd 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -219,8 +219,9 @@ static int ssl_socket_connect(struct imap_socket *sock UNUSED,
 
 #else
 
-static int host_matches(const char *host, const char *pattern)
+static int host_matches(const char *host, const ASN1_STRING *asn1_str)
 {
+	const char *pattern = (const char *)ASN1_STRING_get0_data(asn1_str);
 	if (pattern[0] == '*' && pattern[1] == '.') {
 		pattern += 2;
 		if (!(host = strchr(host, '.')))
@@ -252,8 +253,7 @@ static int verify_hostname(X509 *cert, const char *hostname)
 			GENERAL_NAME *subj_alt_name = sk_GENERAL_NAME_value(subj_alt_names, i);
 			ASN1_STRING *subj_alt_str = GENERAL_NAME_get0_value(subj_alt_name, &ntype);
 
-			if (ntype == GEN_DNS &&
-			    host_matches(hostname, (const char *)ASN1_STRING_get0_data(subj_alt_str)))
+			if (ntype == GEN_DNS && host_matches(hostname, subj_alt_str))
 				found = 1;
 		}
 		sk_GENERAL_NAME_pop_free(subj_alt_names, GENERAL_NAME_free);
@@ -268,7 +268,7 @@ static int verify_hostname(X509 *cert, const char *hostname)
 	    (cname_entry = X509_NAME_get_entry(subj, i)) == NULL ||
 	    (cname = X509_NAME_ENTRY_get_data(cname_entry)) == NULL)
 		return error("cannot get certificate common name");
-	if (host_matches(hostname, (const char *)ASN1_STRING_get0_data(cname)))
+	if (host_matches(hostname, cname))
 		return 0;
 	return error("certificate owner '%s' does not match hostname '%s'",
 		     ASN1_STRING_get0_data(cname), hostname);
-- 
2.51.0

