Received: from mail-gateway-shared02.cyon.net (mail-gateway-shared02.cyon.net [194.126.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A023D669F
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 12:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773232029; cv=none; b=Wn+7s76zWCEaRhAl8eRHc0m9GPhKWpIM/D+uzpDUXZ+VqdkuthDH0xmozbFchyAV2g48MeOFztWrZbPbxHsYu17cETsLSnULjeOLIvjwwTGLwSVNrazTu/pl6delcvHdsM334qKOUjjQuZdVsRAvaM251cXB05ySv/POCiihWQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773232029; c=relaxed/simple;
	bh=YPymcFgsme8scai7FFFxj2zq2CX4VJ6R2FzOkIxr0oE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aTiL243t0andtwtIxf19jK0oX5oriLf0/1cjtj9Q2RKPqGEG3jXvwrglnieQGW1gC6fx50e4H0icrzB9ul88N+4oNGHIdQbUwgBqjJJz8p8pJ93+m8ucrrp0fv9OH43TMOf/ukxwq39xuHrLwA1+NvqAaUN0MmSycLmxiZZxY8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared02.cyon.net with esmtpsa (TLS1.2:ECDHE_SECP256R1__RSA_SHA512__AES_256_GCM:256)
	(Exim)
	(envelope-from <ig@drbeat.li>)
	id 1w0IPW-008JrH-0m
	for git@vger.kernel.org;
	Wed, 11 Mar 2026 13:11:36 +0100
Received: from [10.20.10.54] (port=60622 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.98.1)
	(envelope-from <ig@drbeat.li>)
	id 1w0IPR-0000000BEoU-0Wy0
	for git@vger.kernel.org;
	Wed, 11 Mar 2026 13:11:29 +0100
Received: from eap.internal (eap.internal [192.168.11.6])
	by oh4.internal (Postfix) with ESMTP id B5B82402AD
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 13:11:28 +0100 (CET)
Received: from bb (uid 1000)
	(envelope-from bb@eap.internal)
	id 5402fb
	by eap.internal (DragonFly Mail Agent v0.14 on eap);
	Wed, 11 Mar 2026 13:11:28 +0100
From: Beat Bolli <dev+git@drbeat.li>
To: git@vger.kernel.org
Cc: Beat Bolli <dev+git@drbeat.li>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH 1/4] imap-send: use the OpenSSL API to access the subject alternative names
Date: Wed, 11 Mar 2026 13:11:04 +0100
Message-ID: <20260311121107.1122387-2-dev+git@drbeat.li>
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

The OpenSSL 4.0 branch has made the ASN1_STRING structure opaque,
forbidding access to its internal fields. Use the official accessor
functions instead. They have existed since OpenSSL 1.1.0.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 imap-send.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 26dda7f328..1c934c2487 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -244,10 +244,14 @@ static int verify_hostname(X509 *cert, const char *hostname)
 	if ((subj_alt_names = X509_get_ext_d2i(cert, NID_subject_alt_name, NULL, NULL))) {
 		int num_subj_alt_names = sk_GENERAL_NAME_num(subj_alt_names);
 		for (i = 0; !found && i < num_subj_alt_names; i++) {
+			int ntype;
 			GENERAL_NAME *subj_alt_name = sk_GENERAL_NAME_value(subj_alt_names, i);
-			if (subj_alt_name->type == GEN_DNS &&
-			    strlen((const char *)subj_alt_name->d.ia5->data) == (size_t)subj_alt_name->d.ia5->length &&
-			    host_matches(hostname, (const char *)(subj_alt_name->d.ia5->data)))
+			ASN1_STRING *subj_alt_str = GENERAL_NAME_get0_value(subj_alt_name, &ntype);
+
+			if (ntype == GEN_DNS &&
+			    strlen((const char *)ASN1_STRING_get0_data(subj_alt_str)) ==
+				    ASN1_STRING_length(subj_alt_str) &&
+			    host_matches(hostname, (const char *)ASN1_STRING_get0_data(subj_alt_str)))
 				found = 1;
 		}
 		sk_GENERAL_NAME_pop_free(subj_alt_names, GENERAL_NAME_free);
-- 
2.51.0

