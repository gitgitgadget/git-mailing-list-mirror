Received: from mail.lohmann.sh (mail.lohmann.sh [23.88.42.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1D92F6588
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 09:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.42.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759225163; cv=none; b=FMqG7wj6RvajQGuyidevXx0K1F+Hm8GROhuo/Tf1dvhPTDFGp7nXeVO2Vvs02B4xdRxEd/u63XntCRozQHg090SjrZc7EKJJZ5ggq0oPytx3R/wyJhWc1SS8l565F7oKZ7GloePH3geYO5/tpbfBhYwkNgpl+r4Gc6jvrJBVN90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759225163; c=relaxed/simple;
	bh=6KZYO4+dL4Sx2GRZC2CmzW3EEJCwsMXlCndjdqxPgCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDxwpqRsq3baedwVGd0KWuYbIZIvjwJ8YA93d/szdmktEZuFz82H9cKrzF4DlvltRIQEIZapo/3NyV6JSzrMCBTsmyNy6RQ3S0yXuhWkqiCDcr7rtExrsNtJQ/PJ9hOwMqw6Qh5YYt3NPTIfs0ioJcba5NEW3A3xVxTD3R8/uRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=not-evil.de; spf=pass smtp.mailfrom=not-evil.de; dkim=pass (2048-bit key) header.d=not-evil.de header.i=@not-evil.de header.b=nVdUjG06; arc=none smtp.client-ip=23.88.42.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=not-evil.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=not-evil.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=not-evil.de header.i=@not-evil.de header.b="nVdUjG06"
From: gitmlko@not-evil.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=not-evil.de; s=mail3;
	t=1759225152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RIFrep4GLXPiCuD5rNjNJTpjvjbUczWqH3TengIXzLk=;
	b=nVdUjG06E2qSD4ifwyehOVAsaV4lU//6k2PDCqaWe6OBFENr/veUTz5ipO2kjDPfjDZDxZ
	R6IJo6ziWjeVcV3QuOKX1uUFQ0xUC/V0N01xM7unaB2BEzQyLGsklRu9pxMdjZaxZ3MOxN
	vYFyu34/I9cUBSEus/kJFRLkVH/yl2/kNW2pllp0JGE6DjSruPyhCllGrg8DpDERcU+MYU
	FuVPnnMtDGhfY9/s+kfdhA3Pd5oE2CMo0K2qCFi0Ayw19KLFk6jMBa9mBcyKcLbabMqntF
	VUi5A+y3N7N67QCW7uGCP86Xbs8SzB484qLLM3feg6J5l315lwkZm2sgY0Q/jg==
To: git@vger.kernel.org
Cc: ps@pks.im,
	Michael Lohmann <git@lohmann.sh>
Subject: [PATCH] builtin/reflog: respect user config in "write" subcommand
Date: Tue, 30 Sep 2025 11:14:11 +0200
Message-ID: <20250930091411.14179-1-gitmlko@not-evil.de>
In-Reply-To: <aNsc9En-DjxVOLcV@pks.im>
References: <aNsc9En-DjxVOLcV@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Lohmann <git@lohmann.sh>

Previously, the reflog write command only recognized the environment
variables GIT_COMMITTER_NAME and GIT_COMMITTER_EMAIL. It did not account
for user.name and user.email settings from the Git configuration.

Since the test suite always sets these variables, it was unnoticed that
not present, it would use the system config as defaults instead of the
git config.

Co-Authored-By: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Michael Lohmann <git@lohmann.sh>
---
 builtin/reflog.c        |  2 ++
 t/t1421-reflog-write.sh | 11 ++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index c8f6b93d60..40884787b9 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -422,6 +422,8 @@ static int cmd_reflog_write(int argc, const char **argv, const char *prefix,
 	if (argc != 4)
 		usage_with_options(reflog_write_usage, options);
 
+	repo_config(repo, git_ident_config, NULL);
+
 	ref = argv[0];
 	if (!is_root_ref(ref) && check_refname_format(ref, 0))
 		die(_("invalid reference name: %s"), ref);
diff --git a/t/t1421-reflog-write.sh b/t/t1421-reflog-write.sh
index 46df64c176..65fc4cae93 100755
--- a/t/t1421-reflog-write.sh
+++ b/t/t1421-reflog-write.sh
@@ -101,10 +101,19 @@ test_expect_success 'simple writes' '
 		EOF
 
 		git reflog write refs/heads/something $COMMIT_OID $COMMIT_OID second &&
-		test_reflog_matches . refs/heads/something <<-EOF
+		test_reflog_matches . refs/heads/something <<-EOF &&
 		$ZERO_OID $COMMIT_OID $SIGNATURE	first
 		$COMMIT_OID $COMMIT_OID $SIGNATURE	second
 		EOF
+
+		sane_unset GIT_COMMITTER_NAME &&
+		sane_unset GIT_COMMITTER_EMAIL &&
+		git config --local user.name "Author" &&
+		git config --local user.email "a@uth.or" &&
+		git reflog write refs/heads/something_new $ZERO_OID $COMMIT_OID first &&
+		test_reflog_matches . refs/heads/something_new <<-EOF
+		$ZERO_OID $COMMIT_OID Author <a@uth.or> 1112911993 -0700	first
+		EOF
 	)
 '
 

base-commit: 821f583da6d30a84249f75f33501504d597bc16b
-- 
2.51.GIT

