Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A514840822F
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 22:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959931; cv=none; b=lD08umLY48Ch11sSL9A+Hfs4Jqhe+eI/V1xRXsvORGMuDQsKFe2UEPqsAbqwd0e/2tIuiRaUgjRPAFR7ChHkpMHT7Jfp9U3YgmWGt69lBr8K28pW00WRRKh16S+hyRZ1QAK5cxjPcxfpWWjRWycsD13fw3iXsyCU2ZP/z2EHaDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959931; c=relaxed/simple;
	bh=cU2qvumNBWfLCJemIORyLfIHNw2H1fCFjYkMAHBTP88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y8IHhJnuzz0lGoPW7ow8Kfcz5QXX9nTXa67i96GJqIX74sSiKDhCFo8U7u02zYL1ax9pjbWd0Fosk+H+mAL1A6E27GsbPEfSZFvaAVn+RXry6WhI4ve5TS/+JDQSbxHZF9LUXeKc4WzDZsxYVvgbiJu/8fVMG3+IrKi5HwuyuM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=E0AgejdW; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="E0AgejdW"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773959920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RuBriNv0chZBVmhkBsBXsrCWW8BCfXfG3ffBqlbv9dw=;
	b=E0AgejdWVWjFrLBR4zt4cC5SQTAKV3Vb6Xk/HyfR0fK3ym3+RmuVy/KybdG++/fUZovzL1
	fsKrj9/YuaP1QGcdYSqANOvg/70kxhlqoRKbqk4vMgp6dttelFohyZsLYfCAzAxqApg8mG
	ucuiBCZiQKu203gopL0wJTl3zdCE1yKjkxGB8wN/XVLyoysPX60pebEBkZv7IQ3c8X6/Gk
	6imwu5coHzWCmwS1oSyJ0okgtR1FzcvzHWR7oyIKKFcIKYImz7cN9QyV5EVN66XBxqCtJP
	ENNH4ZRy1nk7/+kYxslNdXKY2JeZK3213y3bnj3TyGDbggcU1cuwFF5ylw4vmA==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v2 8/8] format-patch: --commit-list-format without prefix
Date: Thu, 19 Mar 2026 23:38:18 +0100
Message-ID: <ef0d3ed876d210503c85a547b8d7e78bdbd8f32a.1773959395.git.mroik@delayed.space>
In-Reply-To: <cover.1773959395.git.mroik@delayed.space>
References: <cover.1773530191.git.mroik@delayed.space> <cover.1773959395.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

Having to prefix a custom format-string with "log:" when passed from the
CLI can be annoying. It would be great if this prefix wasn't required.

Teach make_cover_letter() to accept custom format-strings without the
"log:" prefix if a placeholder is detected.

Note that both here and in "git log --format" the check is done naively
by just checking for the presence of a '%'.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 Documentation/git-format-patch.adoc |  4 +++-
 builtin/log.c                       |  2 ++
 t/t4014-format-patch.sh             | 24 ++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
index 55cc680685..c52dbcc170 100644
--- a/Documentation/git-format-patch.adoc
+++ b/Documentation/git-format-patch.adoc
@@ -326,8 +326,10 @@ feeding the result to `git send-email`.
 --commit-list-format=<format-spec>::
 	Specify the format in which to generate the commit list of the patch
 	series. The accepted values for format-spec are `shortlog`, `modern` or a
-	format string prefixed with `log:`.
+	format-string prefixed with `log:`.
 	e.g. `log: %s (%an)`
+	The user is allowed to drop the prefix if the format-string contains a
+	`%<placeholder>`.
 	If not given, defaults to the `format.commitListFormat` configuration
 	variable.
 	This option implies the use of `--cover-letter` unless
diff --git a/builtin/log.c b/builtin/log.c
index c6cf04350a..ad7b7215fe 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1448,6 +1448,8 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 	else if (!strcmp(format, "modern"))
 		generate_commit_list_cover(rev->diffopt.file, "[%(count)/%(total)] %s",
 					   list, nr);
+	else if (strchr(format, '%'))
+		generate_commit_list_cover(rev->diffopt.file, format, list, nr);
 	else
 		die(_("'%s' is not a valid format string"), format);
 
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 7571cc582b..7517094bd6 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -392,6 +392,30 @@ test_expect_success 'cover letter with subject, author and count' '
 	test_grep "^\[1/1\] This is a subject (A U Thor)$" patches/0000-cover-letter.patch
 '
 
+test_expect_success 'cover letter with custom format no prefix' '
+	rm -rf patches &&
+	test_when_finished "git reset --hard HEAD~1" &&
+	test_when_finished "rm -rf patches test_file" &&
+	touch test_file &&
+	git add test_file &&
+	git commit -m "This is a subject" &&
+	git format-patch --commit-list-format="[%(count)/%(total)] %s (%an)" \
+	-o patches HEAD~1 &&
+	test_grep "^\[1/1\] This is a subject (A U Thor)$" patches/0000-cover-letter.patch
+'
+
+test_expect_success 'cover letter fail when no prefix and no placeholder' '
+	rm -rf patches &&
+	test_when_finished "git reset --hard HEAD~1" &&
+	test_when_finished "rm -rf patches test_file err" &&
+	touch test_file &&
+	git add test_file &&
+	git commit -m "This is a subject" &&
+	test_must_fail git format-patch --commit-list-format="this should fail" \
+	-o patches HEAD~1 2>err &&
+	test_grep "is not a valid format string" err
+'
+
 test_expect_success 'cover letter modern format' '
 	test_when_finished "git reset --hard HEAD~1" &&
 	test_when_finished "rm -rf patches test_file" &&
-- 
2.53.0.1018.g2bb0e51243

