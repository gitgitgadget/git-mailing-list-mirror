Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952CA40822A
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 22:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959931; cv=none; b=X7bk09TO0EqW2FNY8LSVMIPS6522ASSs7KoATCGSa0DyuIMbBzA0H72pDtisohkwBvJl6n2KDB7PNp//WcABtNVhQ6ysjwBhB+vm/9bxDErYfMXQgE0x8++SyHlONQ2D+B6ObR2bdqRpZFBfQR76gllmPE7KmA0OTPjBsNV4MCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959931; c=relaxed/simple;
	bh=jrPj3u760pxycJiBUOgApH8tvDEttM4xA4Mc8TRr38w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6+ud2l9ZbcsCFMJe8XNz3YHF5S++oWXhaTsbuL/7RYk8gn4xq9Q8GRq7dNgPgRVirPzw8dRK2HQzRqCepQaRRFTzVhph+Z/YVrXpdcl3YoKEhuwYUudWPxCmonSezqqogGd1QRdVT7vyFLinWdMkzrelSrokuIMvfGSqDi0S5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=kRTeaWFk; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="kRTeaWFk"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773959920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5j+Bosjc16DSQoP74LPnP/dPE4ZAmeno6Ou/V91J3k=;
	b=kRTeaWFkrg4XaMZ9SfVI1H9TQXQAVlG2Ln2KF5BkBfpgu3xwOZSxA3EPfhIrbM3UC0oI0U
	RDCYdB0krE984plcEGB21+Hv1afCffhAjxVKEGvikQFpfZBlNWBCQOolXuPq2g73Dp2b5h
	QvRvfrvSkf/7EVdJtF97VENhNvP5OLsMYKrntAwoBPTY0lpmOoD0+7XNBm4dgRlJFjxC55
	dbUJBWL56Z1CdFE78cRFu7NvXO76/oPxIX8qOwqP0TUICvUpmHGGUep6y3kHkOZ4fRHu23
	qACr94F0EJZxE9HvgGigqw/5aw1zFPA2QN/eNNYzg+kHwfOUbVg3oRX0uhUudA==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v2 7/8] format-patch: add preset for --commit-list-format
Date: Thu, 19 Mar 2026 23:38:17 +0100
Message-ID: <fdcb68e650e09a2a8432b7164ac28ca5b90ab670.1773959395.git.mroik@delayed.space>
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

"git format-patch --commit-list-format" enables the user to make their
own format for the commit list in the cover letter. It would be nice to
have a ready to use format to replace shortlog.

Teach make_cover_letter() the "modern" format preset.
This new format is the same as: "log:[%(count)/%(total)] %s".

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 Documentation/config/format.adoc    |  2 +-
 Documentation/git-format-patch.adoc |  4 ++--
 builtin/log.c                       |  3 +++
 t/t4014-format-patch.sh             | 20 +++++++++++++++-----
 4 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/Documentation/config/format.adoc b/Documentation/config/format.adoc
index ea5ec5df7a..ef1ed1d250 100644
--- a/Documentation/config/format.adoc
+++ b/Documentation/config/format.adoc
@@ -104,7 +104,7 @@ format.coverLetter::
 format.commitListFormat::
 	When the `--cover-letter-format` option is not given, `format-patch`
 	uses the value of this variable to decide how to format the title of
-	each commit. Default to `shortlog`.
+	each commit. Defaults to `shortlog`.
 
 format.outputDirectory::
 	Set a custom directory to store the resulting files instead of the
diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
index 45ca72e670..55cc680685 100644
--- a/Documentation/git-format-patch.adoc
+++ b/Documentation/git-format-patch.adoc
@@ -325,8 +325,8 @@ feeding the result to `git send-email`.
 
 --commit-list-format=<format-spec>::
 	Specify the format in which to generate the commit list of the patch
-	series. The accepted values for format-spec are "shortlog" or a format
-	string prefixed with `log:`.
+	series. The accepted values for format-spec are `shortlog`, `modern` or a
+	format string prefixed with `log:`.
 	e.g. `log: %s (%an)`
 	If not given, defaults to the `format.commitListFormat` configuration
 	variable.
diff --git a/builtin/log.c b/builtin/log.c
index d1765ce4ad..c6cf04350a 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1445,6 +1445,9 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 		generate_commit_list_cover(rev->diffopt.file, format, list, nr);
 	else if (!strcmp(format, "shortlog"))
 		generate_shortlog_cover_letter(&log, rev, list, nr);
+	else if (!strcmp(format, "modern"))
+		generate_commit_list_cover(rev->diffopt.file, "[%(count)/%(total)] %s",
+					   list, nr);
 	else
 		die(_("'%s' is not a valid format string"), format);
 
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index ca37f40a6a..7571cc582b 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -392,18 +392,17 @@ test_expect_success 'cover letter with subject, author and count' '
 	test_grep "^\[1/1\] This is a subject (A U Thor)$" patches/0000-cover-letter.patch
 '
 
-test_expect_success 'cover letter with author and count' '
+test_expect_success 'cover letter modern format' '
 	test_when_finished "git reset --hard HEAD~1" &&
 	test_when_finished "rm -rf patches test_file" &&
 	touch test_file &&
 	git add test_file &&
 	git commit -m "This is a subject" &&
-	git format-patch --commit-list-format="log:[%(count)/%(total)] %an" \
-	-o patches HEAD~1 &&
-	test_grep "^\[1/1\] A U Thor$" patches/0000-cover-letter.patch
+	git format-patch --commit-list-format="modern" -o patches HEAD~1 &&
+	test_grep "^\[1/1\] This is a subject$" patches/0000-cover-letter.patch
 '
 
-test_expect_success 'cover letter shortlog' '
+test_expect_success 'cover letter shortlog format' '
 	test_when_finished "git reset --hard HEAD~1" &&
 	test_when_finished "rm -rf expect patches result test_file" &&
 	cat >expect <<-"EOF" &&
@@ -451,6 +450,17 @@ test_expect_success 'cover letter config with count and author' '
 	test_line_count = 2 result
 '
 
+test_expect_success 'cover letter config commitlistformat set to modern' '
+	test_when_finished "rm -rf patches result" &&
+	test_when_finished "git config unset format.coverletter" &&
+	test_when_finished "git config unset format.commitlistformat" &&
+	git config set format.coverletter true &&
+	git config set format.commitlistformat modern &&
+	git format-patch -o patches HEAD~2 &&
+	grep -E "^[[[:digit:]]+/[[:digit:]]+] .*$" patches/0000-cover-letter.patch >result &&
+	test_line_count = 2 result
+'
+
 test_expect_success 'cover letter config commitlistformat set to shortlog' '
 	test_when_finished "rm -rf patches result" &&
 	test_when_finished "git config unset format.coverletter" &&
-- 
2.53.0.1018.g2bb0e51243

