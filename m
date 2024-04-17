Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58785D2F5
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 03:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713324775; cv=none; b=KXOcJNbl+krH/PZY6vr57agCab+if73/TigvL/9wiZAQ36N28jljfjBFp889dLS9T4ho94n4B7pLQFmHC9DSoEXjFcetmCRVy4OFy2SjZRNUQ4imYCA31hidBt+LTZqnGVlHHKzPQH9UILbaZp3pCSBx9dB9/q1CirbLDRVKyAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713324775; c=relaxed/simple;
	bh=w3vZjU2ZukjzPVe/3mE+1zklHfqbFye7FOK63NG+LN8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ee5CbImu91DFCnMCAD5QvegKSqr3RykMJr7SBpGVwaWXaZd6zrz53T/TFHKHivHpxa/QGdm5tGpO+9z0+LRB+eo6078PC2u95mtY0TOZwKQhm4xKxE8SVxmXnGr8/R0MbwU6xjHUGM9Q6VTJR9vOfPg0Xtv6+CEhXUzzdoHg0Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=HJVHgt0F; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="HJVHgt0F"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713324770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hPtvoofQRoHM1orP9jvIwV7p5cXi991cC80IQiCf8w8=;
	b=HJVHgt0F3CPMBVTg7OghLBa238Qirep/HzGznPD1zmtltXoUmpAynfwC594WTfWD0lTFkc
	xkIPxk9QqOIOkH81HiqLmgdp3AZR7gsPks7FnzY6JVibdxf9wvueHevMR0W/iGVDyDlOs7
	kXwphWN0xm8wmNoDDFCcoimxVGon4AY7e6hrnhbi3O3hO429AnHHiiz3KgTPjBhGX3HADf
	6Qqw2N6f8KqrwnMThRUlImjkj9GNp15vTpNB3/njWsjujzzdaAZahaQRvQ8cmsAlyzfnxn
	D+l/hPAjL4m0R6DtnHl7x8aTvzOsV26XUVhJ33BAPw0OHbeDPY7MYfc5TgsQtw==
To: git@vger.kernel.org
Subject: [PATCH 2/4] format-patch: fix a bug in option exclusivity and add a test to t4014
Date: Wed, 17 Apr 2024 05:32:42 +0200
Message-Id: <c975f961779b4a7b10c0743b4b8b3ad8c89cb617.1713324598.git.dsimic@manjaro.org>
In-Reply-To: <cover.1713324598.git.dsimic@manjaro.org>
References: <cover.1713324598.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Fix a bug that allows --rfc and -k options to be specified together when
executing "git format-patch".  This bug was introduced back in the commit
e0d7db7423a9 ("format-patch: --rfc honors what --subject-prefix sets"),
about eight months ago, but it has remained undetected so far, presumably
because of no associated test coverage.

Add a new test to the t4014 that covers the mutual exclusivity of the --rfc
and -k command-line options for "git format-patch", for future coverage.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 builtin/log.c           | 5 ++++-
 t/t4014-format-patch.sh | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index c0a8bb95e983..e5a238f1cf2c 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2050,8 +2050,11 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (cover_from_description_arg)
 		cover_from_description_mode = parse_cover_from_description(cover_from_description_arg);
 
-	if (rfc)
+	/* Also mark the subject prefix as modified, for later checks */
+	if (rfc) {
 		strbuf_insertstr(&sprefix, 0, "RFC ");
+		subject_prefix = 1;
+	}
 
 	if (reroll_count) {
 		strbuf_addf(&sprefix, " v%s", reroll_count);
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index e37a1411ee24..e22c4ac34e6e 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1397,6 +1397,10 @@ test_expect_success '--rfc is argument order independent' '
 	test_cmp expect actual
 '
 
+test_expect_success '--rfc and -k cannot be used together' '
+	test_must_fail git format-patch -1 --stdout --rfc -k >patch
+'
+
 test_expect_success '--from=ident notices bogus ident' '
 	test_must_fail git format-patch -1 --stdout --from=foo >patch
 '
