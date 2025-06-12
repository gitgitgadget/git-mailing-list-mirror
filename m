Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9B442A80
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 01:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749690746; cv=none; b=K2s0jBXhm0zxq6kzdig7dyVgRpJ7kGqtxe55aCJZ2EM8E+iAa6P0JAe6GUQBcau6/7ua1X/G7LgBh6m6sdOdKtDEx35yW5IX3BEPircfpf2UMyPEyV3zlh57bqluc4UHvi56JyFKbtaacSmc9rXGgEEQOWqhJ4dwhCvBQBpUy8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749690746; c=relaxed/simple;
	bh=RlE+KHR/v4l25IQFQsKG8Bb3rdOyP9uZR6YN1cMs3s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDpZJ6xt7HfYVywaIo4njdgWgvKAe6ah42Kyci5nUB9eAJGpS6oIFjz7hvfn06wHwvk4qNFrBVjHkNu/lgJSTAz/da3Ft3zLBWiJfKzpwFW1JryNSKQeAKTOqonxT64wjTATmG3BkujV8OYQPo4sdVJqTOLU9DpZfpOIKgGXfP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=MXG7TC0G; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="MXG7TC0G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1749690744;
	bh=RlE+KHR/v4l25IQFQsKG8Bb3rdOyP9uZR6YN1cMs3s0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=MXG7TC0Gy5D7KhA78y2nwsTGEsC9W9/jBJBxQg31Pq0S4COB045z5wAfhAed3recE
	 DVeTj9N/ndpAJAJFEXFUGCIFDSG24J2CFBbJTbthSkninDwRShukIo5DFRMr/6jIMk
	 O1codMbERx9IWCLkhXJe4PmCJN56je7jVcDTHYji93Zl4oYcqCEJ5L14bkmSP0UWlc
	 pPa8NuwcTxopqO7KIQcOyl3xjvGNiZA1XZruA57PQI3GqpqeDGH9SqdqoTYsj5uP/N
	 8SBcR4aM9S3puYKql+kH/K3yOI7mfDfDKxoHts/7BnAg/Rb4qcd8JPUtaTcS17Lbt3
	 sF93mAZeYVaLFDARwqnKjiToxFFeu3kzYnu9DtK/CawX1igIKHopheuYcT/oGdfnhA
	 Q6Y8D0AZ49dcrXpjteRTHn92QRN+cyoVuH5oPe3ytJ+xzF78iqGZnNqIxuYawqUf1z
	 l1BoD+aZ9rYtaudUbEKc9ZYAd5XtCxvWnzY02hIVY1Pd86J2jJm
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:828b:3227:a916:b7f5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id ED2A22018F;
	Thu, 12 Jun 2025 01:12:23 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v8 2/4] builtin/stash: factor out revision parsing into a function
Date: Thu, 12 Jun 2025 01:12:18 +0000
Message-ID: <20250612011221.4158484-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.50.0.rc0.567.gd817f1499f4
In-Reply-To: <20250612011221.4158484-1-sandals@crustytoothpaste.net>
References: <20250601223225.464076-1-sandals@crustytoothpaste.net>
 <20250612011221.4158484-1-sandals@crustytoothpaste.net>
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
