Received: from mail.lohmann.sh (mail.lohmann.sh [23.88.42.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A7A2581
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 19:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.42.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759262100; cv=none; b=A779KKGPhoRfc3zc9i/dWL/bqGyS26wariKvHX7Y4dr9feaVljgBwiYAX/fslL80drR+M4mYWbVNZ7vCZUcPrcuX8Snh/kjawoiaQflOmOdIt5J2IjhG2n7yfUKZV/DNFONcFHcH+8ReSKRni0y9pP9/afgkyGPysXMFcDGu2yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759262100; c=relaxed/simple;
	bh=TDLe1GFae2X+4/fwuqSaCa6YnUGPqZ6y2F2RAIHqlAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y801zsS0iZCOVfO9yDB5udHeSG+kZmkXItD8V5flCLvdrLgM8U5I3wvjvnagg0irF+jL9Q+6fiIJEA9MvFOdWhgKp7GB4V8srmninvApVoAkzhIYspBVa3CmWixbBHNBoa9OHAkTFjxX5Ktu5U20tGBdSZXPMkpPVXgvCfBgNeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh; spf=pass smtp.mailfrom=lohmann.sh; dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b=TEtMvj5z; arc=none smtp.client-ip=23.88.42.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b="TEtMvj5z"
From: Michael Lohmann <git@lohmann.sh>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lohmann.sh; s=mail3;
	t=1759262090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dGEy8EdjX9JzxogrzBWXPTKkVfOiUA1zAkOsUvo9Z7Q=;
	b=TEtMvj5zZmIFP8kK2M/+SI4cDFJpxSP8bHPoPaJyKXIzo2qu5hH7NWyAIDBrZxWQ6cVM2g
	d3xnTxg4Q/ZsoLqzB597THqzqxkqjpfikQhk6M+p0cTqxmHLLvOGTO8rplXnjAMU4cdW7z
	gA2lKorVM2BLQTi9h5Fl7hkBUnqYsmJBjhnwoT9w9Bu/sQp0H20539yEapHjgsBaUjJkvA
	2nHwEyF8D+ON9GxaEaoYy9NmNVkQi7sGPN4aiiRz39UY6t/ZkeXusarYtt26k2B/h/D41s
	tSf3G2NocCdtKZPSSouJGQ8pr6Ov1LXkizFpzuP6NbnzJjWUhwPfdBuwV4HrIQ==
To: gitster@pobox.com
Cc: git@lohmann.sh,
	git@vger.kernel.org,
	ps@pks.im
Subject: [PATCH v3] builtin/reflog: respect user config in "write" subcommand
Date: Tue, 30 Sep 2025 21:53:20 +0200
Message-ID: <20250930195320.23825-1-git@lohmann.sh>
In-Reply-To: <xmqqplb750f2.fsf@gitster.g>
References: <xmqqplb750f2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reflog write recognizes only GIT_COMMITTER_NAME and
GIT_COMMITTER_EMAIL environment variables, but forgot to honor the
user.name and user.email configuration variables, due to lack of
repo_config() call to grab these values from the configuration files.

The test suite sets these variables, so this behavior was unnoticed.

Ensure that the reflog write also uses the values of user.name and
user.email if set in the Git configuration.

Co-authored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Michael Lohmann <git@lohmann.sh>
---
- Improved commit message according to Junio Hamanos suggestion
- moved repo_config() call above parse_options() (I can't judge where
  the proper place would be)
- add test to check if env variables overwrite config
- use $GIT_COMMITTER_DATE instead of that timestamp in existing test
  case

 builtin/reflog.c        |  2 ++
 t/t1421-reflog-write.sh | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index c8f6b93d60..dcbfe89339 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -418,6 +418,8 @@ static int cmd_reflog_write(int argc, const char **argv, const char *prefix,
 	const char *ref, *message;
 	int ret;
 
+	repo_config(repo, git_ident_config, NULL);
+
 	argc = parse_options(argc, argv, prefix, options, reflog_write_usage, 0);
 	if (argc != 4)
 		usage_with_options(reflog_write_usage, options);
diff --git a/t/t1421-reflog-write.sh b/t/t1421-reflog-write.sh
index 46df64c176..603ec3f6ed 100755
--- a/t/t1421-reflog-write.sh
+++ b/t/t1421-reflog-write.sh
@@ -108,6 +108,42 @@ test_expect_success 'simple writes' '
 	)
 '
 
+test_expect_success 'uses user.name and user.email config' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		COMMIT_OID=$(git rev-parse HEAD) &&
+
+		sane_unset GIT_COMMITTER_NAME &&
+		sane_unset GIT_COMMITTER_EMAIL &&
+		git config --local user.name "Author" &&
+		git config --local user.email "a@uth.or" &&
+		git reflog write refs/heads/something $ZERO_OID $COMMIT_OID first &&
+		test_reflog_matches . refs/heads/something <<-EOF
+		$ZERO_OID $COMMIT_OID Author <a@uth.or> $GIT_COMMITTER_DATE	first
+		EOF
+	)
+'
+
+test_expect_success 'environment variables take precedence over config' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		COMMIT_OID=$(git rev-parse HEAD) &&
+
+		git config --local user.name "Author" &&
+		git config --local user.email "a@uth.or" &&
+		git reflog write refs/heads/something $ZERO_OID $COMMIT_OID first &&
+		test_reflog_matches . refs/heads/something <<-EOF
+		$ZERO_OID $COMMIT_OID $SIGNATURE	first
+		EOF
+	)
+'
+
 test_expect_success 'can write to root ref' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&

base-commit: 821f583da6d30a84249f75f33501504d597bc16b
-- 
2.51.0.373.g6d4c29e8d5.dirty

