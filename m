Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF79DDAB
	for <git@vger.kernel.org>; Sun,  1 Jun 2025 22:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748817167; cv=none; b=do5DMG3GY29LBifcie5h4AaA+OFIsJD/LlvPwRU0HlrTPWiKn86dB8KLayRycwa7CY3pD9IbaiLNJ0rXONGTR4oP+D7+er+hFysXQoO91lgGjYk4hWG2vUoBCPPgf9xuYbmczfw60ZuRC1omSJiufjU+gl5dZTFLOshy0d7bdIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748817167; c=relaxed/simple;
	bh=RlE+KHR/v4l25IQFQsKG8Bb3rdOyP9uZR6YN1cMs3s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acR3CxwSO1Vl6ExwuACE8SMTVES7wg6445ZVbEUuH4JY3GtSya354fk/prlToyOxdfXeoBtVxwN2ZvNMzwYT7JWOc0K3kFdxVfb0SEuXmZ10bJ96cN2NWS/sgPWNG5XeXJ3GOJiVO5u1Ou0qC3SEexMFMaIDUOJBHd+5xizKL8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=ONeUpQp4; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ONeUpQp4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1748817157;
	bh=RlE+KHR/v4l25IQFQsKG8Bb3rdOyP9uZR6YN1cMs3s0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=ONeUpQp4nODb/jwT3/J9CFu71E8SRfaq89Pg/zc1h+FJvMfTxorEErUcydRPXCYjY
	 OHAOMXdSchLjY3bambvJYGmy1vrAwqagjfu2Gc8/ggtqALg6Cp9+kpwdkw/scPXBaU
	 2vo4ie2q3FfUWkBZho+s6EggiCXVeEDkmya2ANMtgpfT5WPv+T3YEyq+zZitono6R6
	 gm35xml7oRBCIMvMECu2QcorULGiZXVIptjUMSK/F0GZ7H9zi5q2KHHw9zrWeDYOEo
	 BZTcTxdDxTct3vFnRMKCdcpAv+h+irIySv1TMDh2ud6HyNWMU1V5p3/4FB7dn59DJ6
	 7fOdbno5bIWRfvTXTDgcs1XwrlP5/q4tL+rh7Kgqo+Z/lqjSR7iSyspR5624JZgZTn
	 8djVTqBCaMAP6qk9BvbNcncj0W3HVTvpYW1QxaZvCpPCzyGBMc6gQ7ID5UttJjWfbr
	 1ZffzmXEIeqzr0daDUePiVQLkUoLnwt3HxuFgYuPg8QX9Jcty9t
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:df25:78ac:1a43:dee8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id CD35A20188;
	Sun,  1 Jun 2025 22:32:37 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v7 2/4] builtin/stash: factor out revision parsing into a function
Date: Sun,  1 Jun 2025 22:32:23 +0000
Message-ID: <20250601223225.464076-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.50.0.rc0.567.gd817f1499f4
In-Reply-To: <20250601223225.464076-1-sandals@crustytoothpaste.net>
References: <20250522185524.18398-2-sandals@crustytoothpaste.net>
 <20250601223225.464076-1-sandals@crustytoothpaste.net>
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
