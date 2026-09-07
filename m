Received: from mail-gateway-shared15.cyon.net (mail-gateway-shared15.cyon.net [194.126.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB17C37F8C1
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 21:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788815779; cv=none; b=iIC/OHzEp3bwzEk/sfG8zZ1nOoAtOFIn0HtJuM2H9jw1cPCm69Ln+mZAdsviX5tFtc4JLWjHk5+euf63D5zPQHirukKRBj4m2R01+DlKD5N5zSFGfS9itf20Ep+1F9vqyIIz+gnOOUcgVgITHxBtnfjDRGdm6p6SyAHjaZ7WvP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788815779; c=relaxed/simple;
	bh=DBtXmFBxy/weVsQvY+IZmPBTFRfpvgbMm3m2HNYlhQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u++C8GCdV0uPiZzFnVNrxgi2Gmuc6LGsf2Rp3xJ0F8L5msbFx93imQky4c0ugn1CPM1uLMSuA4qJZKAf3/Cxy8hnQGmmGHcaBfexb2lkGUEzlnbxEp7mnVEUMRi2C+eTi4N/V0dcfMXgvKyNh8YER9P948E6xEmQkaXrwUYJIr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared15.cyon.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim)
	(envelope-from <ig@drbeat.li>)
	id 1x3gdm-00ASmg-0O
	for git@vger.kernel.org;
	Mon, 07 Sep 2026 23:12:36 +0200
Received: from [10.20.10.52] (port=25684 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.99.4)
	(envelope-from <ig@drbeat.li>)
	id 1x3gdh-00000005WdC-09H7;
	Mon, 07 Sep 2026 23:12:29 +0200
Received: by oh4.internal (Postfix, from userid 1000)
	id BBCB240099; Mon, 07 Sep 2026 23:12:28 +0200 (CEST)
From: Beat Bolli <dev+git@drbeat.li>
To: git@vger.kernel.org
Cc: Oswald Buddenhagen <ossi@kde.org>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 3/3] imap-send: only check the CN if no SAN DNS names are present
Date: Mon,  7 Sep 2026 23:12:10 +0200
Message-ID: <20260907211210.2621693-4-dev+git@drbeat.li>
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

Checking the certificate subject's common name may only be done if the
subjectAltNames extension contains no DNS entries. If no SAN DNS name
matches, there's no match.

Per RFC 6125 section 6.4.4[1]:

    As noted, a client MUST NOT seek a match for a reference identifier
    of CN-ID if the presented identifiers include a DNS-ID, SRV-ID,
    URI-ID, or any application-specific identifier types supported by the
    client.

This change was inspired by a similar commit in the HAProxy project[2].

[1]: https://datatracker.ietf.org/doc/html/rfc6125#section-6.4.4
[2]: https://github.com/haproxy/haproxy/commit/75129aaacb7a7b172f4e5334db71d6c1c50a3dbf

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 imap-send.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 9a807cdde8..66d3dbfaa5 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -256,11 +256,11 @@ static int verify_hostname(X509 *cert, const char *hostname)
 #endif
 	const X509_NAME_ENTRY *cname_entry;
 	const ASN1_STRING *cname;
-	int i, found;
+	int i, found, has_san_dns;
 	STACK_OF(GENERAL_NAME) *subj_alt_names;
 
 	/* try the DNS subjectAltNames */
-	found = 0;
+	found = has_san_dns = 0;
 	if ((subj_alt_names = X509_get_ext_d2i(cert, NID_subject_alt_name, NULL, NULL))) {
 		int num_subj_alt_names = sk_GENERAL_NAME_num(subj_alt_names);
 		for (i = 0; !found && i < num_subj_alt_names; i++) {
@@ -268,13 +268,18 @@ static int verify_hostname(X509 *cert, const char *hostname)
 			GENERAL_NAME *subj_alt_name = sk_GENERAL_NAME_value(subj_alt_names, i);
 			ASN1_STRING *subj_alt_str = GENERAL_NAME_get0_value(subj_alt_name, &ntype);
 
-			if (ntype == GEN_DNS && host_matches(hostname, subj_alt_str))
-				found = 1;
+			if (ntype == GEN_DNS) {
+				has_san_dns = 1;
+				if (host_matches(hostname, subj_alt_str))
+					found = 1;
+			}
 		}
 		sk_GENERAL_NAME_pop_free(subj_alt_names, GENERAL_NAME_free);
 	}
 	if (found)
 		return 0;
+	if (has_san_dns)
+		return error("none of the subjectAltNames matches hostname '%s'", hostname);
 
 	/* try the common name */
 	if (!(subj = X509_get_subject_name(cert)))
-- 
2.53.0

