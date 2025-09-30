Received: from mail.lohmann.sh (mail.lohmann.sh [23.88.42.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C7B8F7D
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.42.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759243095; cv=none; b=tJX2r4lXxAkSZ6ZrSyU1DUpwlHm3i5F3+5kOb4BftZc0JV8EXrmmY5/RIqfV1EQha95rMEejXMdGIqM3SxdwAaQyK1UXvMOxP/KP4hkSbLnCHGCmZ/+gihujmkjuQoloyIRVHe7i7bgIHmivq8qe1HE3I6LnQzA5TD34oizCbHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759243095; c=relaxed/simple;
	bh=OeSi+aBCin9uniecULaKsn2p0Opv767+qu9Cr/dhluI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g/8DkAan2TNR+v4Kv7v+HoxGmuZ/5VqH9hNz50VGEXk0LxWMlFq+4m+X1nJbL+GBRLzE8qp9PlM47sxSbcYGhnFJ4LO24AD7rCNxc88tfTlo0dNuRNj2+Ls08RjtqMhabfFrE0nK8A0UGvzzk72+NGln49ZQ6hKUjI5Q4gdz8xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh; spf=pass smtp.mailfrom=lohmann.sh; dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b=B2AnoW5A; arc=none smtp.client-ip=23.88.42.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b="B2AnoW5A"
From: git@lohmann.sh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lohmann.sh; s=mail3;
	t=1759243075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eWTkIlUaOd/pEvqXluVmLHpxknIHxX2mQNsTMgEGudI=;
	b=B2AnoW5ANIyngbPGK3j9FlgEy58eN95JcDCBlXcFYFZa9MU52+HAQo9dpyTzJeen5D3uBr
	7D5MsbTRE13YRAU4QBH08eGiKBtSU9T2dzrzW4IKx0IJm5jCi6iBSRFLbyKMQ87UP+qUMw
	eMWug4TZtXi2/3rwsqzs37r7hAmHqn7UiWjnJbfu8frP4TEH4OgMXsstzovHwF8Q+no/WY
	AYD7Prpsmzc5iac3I1hvButpxe1RssSbKWG2e7kZixGi/VHpMTMxITxsXnN5BZCjD6LvRE
	827oBQOrctVWzGMNdMgKRXiEe+blz+yUVoahJdXH0Lz4O22y8GeKGs9eCmITNg==
To: ps@pks.im
Cc: git@vger.kernel.org,
	Michael Lohmann <git@lohmann.sh>
Subject: [PATCH v2] builtin/reflog: respect user config in "write" subcommand
Date: Tue, 30 Sep 2025 16:37:41 +0200
Message-ID: <20250930143741.18331-1-git@lohmann.sh>
In-Reply-To: <aNu-cTrJwPdcW6hq@pks.im>
References: <aNu-cTrJwPdcW6hq@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Lohmann <git@lohmann.sh>

The reflog write recognizes only GIT_COMMITTER_NAME and
GIT_COMMITTER_EMAIL environment variables, ignoring the user.name and
user.email settings from the Git configuration.

The test suite sets these variables, so this behavior was unnoticed.

Ensure that the reflog write also uses the values of user.name and
user.email if set in the Git configuration.

Co-authored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Michael Lohmann <git@lohmann.sh>
---
Thank you for your feedback! Is this better now or how could I improve
it?

The reason why I sent it from my other email address was that originally
I didn't expect to submit a patch. Since I sent the first email from the
other address, I wasn't sure if it was easier to keep the context, but I
didn't have the other perspective. Now sent from the git email.

Change compared to last version:
- aligned commit message with style guide
- created a separate test case

Michael

 builtin/reflog.c        |  2 ++
 t/t1421-reflog-write.sh | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

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
index 46df64c176..cf0e8608fe 100755
--- a/t/t1421-reflog-write.sh
+++ b/t/t1421-reflog-write.sh
@@ -108,6 +108,25 @@ test_expect_success 'simple writes' '
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
+		$ZERO_OID $COMMIT_OID Author <a@uth.or> 1112911993 -0700	first
+		EOF
+	)
+'
+
 test_expect_success 'can write to root ref' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&

base-commit: 821f583da6d30a84249f75f33501504d597bc16b
-- 
2.50.1 (Apple Git-155)

