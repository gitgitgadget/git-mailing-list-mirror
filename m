Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC5E1E1DF8
	for <git@vger.kernel.org>; Thu, 22 May 2025 18:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747940177; cv=none; b=d7d8BSpJgsxd9/eFthg2xZmqZXLMV58+PsEqH29qoSMRecD5Sed2n4Ki21E20yQKI7z4or6yKhlvslI396m0nAaVkizgwbpdYjLNOLDhqccjgF8HQBAqh+4r9DAnvWu93UqG34Nj0jU/1nmeLPHJTz84EpdxQoFCcFYpAZE9mPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747940177; c=relaxed/simple;
	bh=RlE+KHR/v4l25IQFQsKG8Bb3rdOyP9uZR6YN1cMs3s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHlrvY/Ctw+K6HPPD/KV3scqRiNQ2hyj4tg43Faq49i1B4Cj2annM+4w8+vgdwDjjQf8mDfsYFE5KVNEjOIwXrvkhJbEa4i1G0msg+FyeP47xuIF0XpRj26mtqGlQYdGVEkNVtoBPAYGl3OREnsp1NDcqepOLmFYpwHTb2V11pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=0bHAFT6R; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="0bHAFT6R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1747940174;
	bh=RlE+KHR/v4l25IQFQsKG8Bb3rdOyP9uZR6YN1cMs3s0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=0bHAFT6Rxx/EL8pd3Un+bwkaHweCIOeNl1jGE1CqezAOBmdG267dAW1sRfLMrm7Jf
	 dDR9SjnPTfc4kBcTqMnRmA0WShE4udKcj3ZRb08b07stM8X+Tmjax4J9OWxc4gxB6Q
	 d85/wmmiRQZkMXXBXRTz1Tem/zeYaz0tyzDbQPkAgbxGT0xXc5avD6/dicKmYCxn+m
	 nvQ2REVJFovvUlMwZrUOnN+1TwkSXzXVIDx2/16L1vQdCIr3X6YDaxawyvQFheq3Rk
	 lML9Wnuo0jRYUXtDwShkyNQ0/xasc/en2UFCNVbAG1nLXWaTA7yTkU2s8XmwkNlkxR
	 6KMQGpSgDIinL51QSWPz5fYboeZ9BiuVOPWVZiwvmStGdp1mbDnbAOb7q9Gf9ajQLu
	 rjvoeTUWegHsZA79d9GclEOkDcItAb/P2WqRJXCpoyw8SIWViHbrB+Dvywrhf8vTU4
	 b73UGPh/skxzGYTznQlS61tAGGZSX5rfh8vQ9bp1cAMQauP597o
Received: from tapette.. (unknown [104.129.158.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D8D8520190;
	Thu, 22 May 2025 18:56:14 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	pwodd,
	"D. Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v6 3/5] builtin/stash: factor out revision parsing into a function
Date: Thu, 22 May 2025 18:55:22 +0000
Message-ID: <20250522185524.18398-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557c
In-Reply-To: <20250522185524.18398-1-sandals@crustytoothpaste.net>
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
 <20250522185524.18398-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We allow several special forms of stash names in this code.  In the
future, we'll want to allow these same forms without parsing a stash
commit, so let's refactor this code out into a function for reuse.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/stash.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index cfbd92852a..ab491d5ff6 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -169,6 +169,25 @@ static void assert_stash_like(struct stash_info *info, const char *revision)
 		die(_("'%s' is not a stash-like commit"), revision);
 }
 
+static int parse_stash_revision(struct strbuf *revision, const char *commit, int quiet)
+{
+	strbuf_reset(revision);
+	if (!commit) {
+		if (!refs_ref_exists(get_main_ref_store(the_repository), ref_stash)) {
+			if (!quiet)
+				fprintf_ln(stderr, _("No stash entries found."));
+			return -1;
+		}
+
+		strbuf_addf(revision, "%s@{0}", ref_stash);
+	} else if (strspn(commit, "0123456789") == strlen(commit)) {
+		strbuf_addf(revision, "%s@{%s}", ref_stash, commit);
+	} else {
+		strbuf_addstr(revision, commit);
+	}
+	return 0;
+}
+
 static int get_stash_info(struct stash_info *info, int argc, const char **argv)
 {
 	int ret;
@@ -196,17 +215,9 @@ static int get_stash_info(struct stash_info *info, int argc, const char **argv)
 	if (argc == 1)
 		commit = argv[0];
 
-	if (!commit) {
-		if (!refs_ref_exists(get_main_ref_store(the_repository), ref_stash)) {
-			fprintf_ln(stderr, _("No stash entries found."));
-			return -1;
-		}
-
-		strbuf_addf(&info->revision, "%s@{0}", ref_stash);
-	} else if (strspn(commit, "0123456789") == strlen(commit)) {
-		strbuf_addf(&info->revision, "%s@{%s}", ref_stash, commit);
-	} else {
-		strbuf_addstr(&info->revision, commit);
+	strbuf_init(&info->revision, 0);
+	if (parse_stash_revision(&info->revision, commit, 0)) {
+		return -1;
 	}
 
 	revision = info->revision.buf;
