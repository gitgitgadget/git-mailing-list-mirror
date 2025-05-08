Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4BD2367B1
	for <git@vger.kernel.org>; Thu,  8 May 2025 23:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746747913; cv=none; b=U6aIBQpzgYGMOclOfljUSBp7ZTUdrgVuUgAMkQXbMiZBa+lm+xKMoxohFfEiz12owl1P31psszfdutWz6WIL+/xXSn/6xNLMgCxk9Mvgvriw0ev552e5QwGgMMt2HFuWhX0FslUoPKUzpU0e3wJDolqc06K2RMeci7CILJ8fYkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746747913; c=relaxed/simple;
	bh=I1NvdRccfvf7mjfaHR9StSBawm9S+nWojACyXy9PcqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFBLkCoWwRIMK3TuR9PpM7peO4xRjXCWZJYERvp7hHXMmhMIPl85HUerDV7Nty6ezoCZeZVWnQfbqM11w5h6bnyDfE3gxqmKmBhvhY9cl2a4VfQhE+grPnwBajkgyiJ1ckvF8AKXoe//7Orl4NoEkZ7hGrNytiGS8/m5ydvlQjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=gwD/h+QU; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="gwD/h+QU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1746747903;
	bh=I1NvdRccfvf7mjfaHR9StSBawm9S+nWojACyXy9PcqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=gwD/h+QUnyvYZlGiq98YGmFd+EOF1rIq6yFPW6e3WdHM3f6GxDpnCVasls75Lx0uN
	 cVqFlvo4qiI3tTu1Ol9zw+leo1w4uZzitD1t/QxL4Tr7eaactxGyOge0ZVuF8PQBav
	 jrZ+Xdt3ZkB2nkO+4IfhKA+YmNf/u7hhDRzmHL7EAgL3SKf6wbJpr5QHI7LA82pKI8
	 QQx7/ZsCYPX/+lUS9pwuRWnWQH2wMDSKaDmhYNEp4kGD+sTLGuk3S9mHus8hIU8hOj
	 uriuZdevBI6ZLDh9MeMaZiFt8q6ptGq1UvMJtnQmKh4nDzUZNerDBG0++wJw6R6hAI
	 47GyiwZK4bXD6y5guvqjE49RORSKNqwGQ1cykwQ09+1o+64xFprMPaKDya8pYa2Kqt
	 o22WaYd82di0ZNWXbYwwl2B2RAkGmZOjmk4ZnETdbxiW5vohNI7w2McxPC7kLsoVl+
	 5Kkw7s3UxpLYcxmAwDHYLjlgpDBcQQQ9eTS+XQXCcG3tGjb/wD6
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:df25:78ac:1a43:dee8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id F06D420125;
	Thu,  8 May 2025 23:45:03 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v5 2/4] builtin/stash: factor out revision parsing into a function
Date: Thu,  8 May 2025 23:44:55 +0000
Message-ID: <20250508234458.3665894-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557c
In-Reply-To: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
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
 builtin/stash.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index cfbd92852a..8ee6752efa 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -169,6 +169,25 @@ static void assert_stash_like(struct stash_info *info, const char *revision)
 		die(_("'%s' is not a stash-like commit"), revision);
 }
 
+static int parse_revision(struct strbuf *revision, const char *commit, int quiet)
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
@@ -196,17 +215,10 @@ static int get_stash_info(struct stash_info *info, int argc, const char **argv)
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
+	if (parse_revision(&info->revision, commit, 0)) {
+		free_stash_info(info);
+		return -1;
 	}
 
 	revision = info->revision.buf;
