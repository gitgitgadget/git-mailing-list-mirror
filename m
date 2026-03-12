Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E8C3F20EA
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 16:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773332427; cv=none; b=lKksA7YHxiBUnyb92+ZIpnlm+ourb6tebxvVs4N9Pjg2g66KSGWTDSmmGsMKFgo1ihzkqzkWnBOPusU/oy930JXBOvRlS7sFNvDtEZV2ITUAFYQo9rB39PGdJTdnD/oEOLx7SCaogkA4o+GycudTlOkHe4oM9UqqfgWvPik9axQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773332427; c=relaxed/simple;
	bh=wocUx9EkZ4PTYUKNdYL4nEv8BGyBMIh/FS9nDoIoCbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBmKCfeDsVTHGJw8iXFjAnpCmF43v7zg20jla7ahW8wHD/dc8Bi8ZIOqg3pHaKSieQsGO8Obl20RLY9Pl+F+VVFHXeibVaQd+8hLZLbqgxFbtSjzNK6Xc3v7tRVWVqEbeiYHwGfo3MMby/s1SqkvfuHtk/dTMzl1KYMoweaFufI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=UZxmMhy/; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="UZxmMhy/"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773332418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bfOcgQhWIXuROFZmBLHuOA03jv+EgiE/uvqw4bC936s=;
	b=UZxmMhy/BhLEOwkcKl5KU67RPs26lXy4LcpuDmdQaL0oSh6kV+l5btkvMuz7lkpkitC7wT
	kLqaKFDyuI64WYNtPyZaelrMimESi8T3DTZkh9ebbI5OTrh5XurACRJ3uqWvjSeegsGB9D
	p1bAxTLHEjK5vRrcygBPRB9saa0XhueVwHjk8Hbbn+P/shF8ap3O0imUsNu7qkZUwUKk0L
	IIXvG3RW7AfhoTpX8ouK3c1Np3xWrMN/0e3BIh7ptjVd3ERgcFkYGd6m6SIlm/y9Es8uT4
	bt6JqaxzN3y0pQ+xdmhqDuqJbVJiiA2G9hd5YETEm7qHl3rGmZNhRtBEtqHqAQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH v8 4/4] format-patch: add commitListFormat config
Date: Thu, 12 Mar 2026 17:20:11 +0100
Message-ID: <50b1f37e8cd6091deca793f9a972b1d15d9aae7d.1773331754.git.mroik@delayed.space>
In-Reply-To: <cover.1773331753.git.mroik@delayed.space>
References: <cover.1772839973.git.mroik@delayed.space> <cover.1773331753.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ----

Using "--cover-letter" we can tell format-patch to generate a cover
letter, in this cover letter there's a list of commits included in the
patch series and the format is specified by the "--cover-letter-format"
option. Would be useful if this format could be configured from the
config file instead of always needing to pass it from the command line.

Teach format-patch how to read the format spec for the cover letter from
the config files. The variable it should look for is called
format.commitListFormat, it accepts the same values as the option
"--cover-letter-format".

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 Documentation/config/format.adoc    |  5 +++
 Documentation/git-format-patch.adoc |  1 +
 builtin/log.c                       | 13 +++++++
 t/t4014-format-patch.sh             | 57 +++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+)

diff --git a/Documentation/config/format.adoc b/Documentation/config/format.adoc
index ab0710e86a..ef1ed1d250 100644
--- a/Documentation/config/format.adoc
+++ b/Documentation/config/format.adoc
@@ -101,6 +101,11 @@ format.coverLetter::
 	generate a cover-letter only when there's more than one patch.
 	Default is false.
 
+format.commitListFormat::
+	When the `--cover-letter-format` option is not given, `format-patch`
+	uses the value of this variable to decide how to format the title of
+	each commit. Defaults to `shortlog`.
+
 format.outputDirectory::
 	Set a custom directory to store the resulting files instead of the
 	current working directory. All directory components will be created.
diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
index 6364fd1f5a..88e580d1b3 100644
--- a/Documentation/git-format-patch.adoc
+++ b/Documentation/git-format-patch.adoc
@@ -463,6 +463,7 @@ with configuration variables.
 	signOff = true
 	outputDirectory = <directory>
 	coverLetter = auto
+	commitListFormat = shortlog
 	coverFromDescription = auto
 ------------
 
diff --git a/builtin/log.c b/builtin/log.c
index 12877a0ac2..e19e122bc9 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -887,6 +887,7 @@ struct format_config {
 	char *signature;
 	char *signature_file;
 	enum cover_setting config_cover_letter;
+	char *fmt_cover_letter_commit_list;
 	char *config_output_directory;
 	enum cover_from_description cover_from_description_mode;
 	int show_notes;
@@ -931,6 +932,7 @@ static void format_config_release(struct format_config *cfg)
 	string_list_clear(&cfg->extra_cc, 0);
 	strbuf_release(&cfg->sprefix);
 	free(cfg->fmt_patch_suffix);
+	free(cfg->fmt_cover_letter_commit_list);
 }
 
 static enum cover_from_description parse_cover_from_description(const char *arg)
@@ -1053,6 +1055,11 @@ static int git_format_config(const char *var, const char *value,
 		cfg->config_cover_letter = git_config_bool(var, value) ? COVER_ON : COVER_OFF;
 		return 0;
 	}
+	if (!strcmp(var, "format.commitlistformat")) {
+		FREE_AND_NULL(cfg->fmt_cover_letter_commit_list);
+		git_config_string(&cfg->fmt_cover_letter_commit_list, var, value);
+		return 0;
+	}
 	if (!strcmp(var, "format.outputdirectory")) {
 		FREE_AND_NULL(cfg->config_output_directory);
 		return git_config_string(&cfg->config_output_directory, var, value);
@@ -2329,6 +2336,12 @@ int cmd_format_patch(int argc,
 		goto done;
 	total = list.nr;
 
+	if (!cover_letter_fmt) {
+		cover_letter_fmt = cfg.fmt_cover_letter_commit_list;
+		if (!cover_letter_fmt)
+			cover_letter_fmt = "shortlog";
+	}
+
 	if (cover_letter == -1) {
 		if (cfg.config_cover_letter == COVER_AUTO)
 			cover_letter = (total > 1);
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 5ec527bce9..2091b5e9bb 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -449,6 +449,63 @@ test_expect_success 'cover letter no format' '
 	test_line_count = 1 result
 '
 
+test_expect_success 'cover letter config with count, subject and author' '
+	test_when_finished "rm -rf patches result" &&
+	test_when_finished "git config unset format.coverletter" &&
+	test_when_finished "git config unset format.commitlistformat" &&
+	git config set format.coverletter true &&
+	git config set format.commitlistformat "[%(count)/%(total)] %s (%an)" &&
+	git format-patch -o patches HEAD~2 &&
+	grep -E "^[[[:digit:]]+/[[:digit:]]+] .* \(A U Thor\)" patches/0000-cover-letter.patch >result &&
+	test_line_count = 2 result
+'
+
+test_expect_success 'cover letter config with count and author' '
+	test_when_finished "rm -rf patches result" &&
+	test_when_finished "git config unset format.coverletter" &&
+	test_when_finished "git config unset format.commitlistformat" &&
+	git config set format.coverletter true &&
+	git config set format.commitlistformat "[%(count)/%(total)] (%an)" &&
+	git format-patch -o patches HEAD~2 &&
+	grep -E "^[[[:digit:]]+/[[:digit:]]+] \(A U Thor\)" patches/0000-cover-letter.patch >result &&
+	test_line_count = 2 result
+'
+
+test_expect_success 'cover letter config commitlistformat set to shortlog' '
+	test_when_finished "rm -rf patches result" &&
+	test_when_finished "git config unset format.coverletter" &&
+	test_when_finished "git config unset format.commitlistformat" &&
+	git config set format.coverletter true &&
+	git config set format.commitlistformat shortlog &&
+	git format-patch -o patches HEAD~2 &&
+	grep -E "^A U Thor \([[:digit:]]+\)" patches/0000-cover-letter.patch >result &&
+	test_line_count = 1 result
+'
+
+test_expect_success 'cover letter config commitlistformat set to chronological' '
+	test_when_finished "git reset --hard HEAD~1" &&
+	test_when_finished "rm -rf patches result test_file" &&
+	test_when_finished "git config unset format.coverletter" &&
+	test_when_finished "git config unset format.commitlistformat" &&
+	git config set format.coverletter true &&
+	git config set format.commitlistformat chronological &&
+	touch test_file &&
+	git add test_file &&
+	git commit -m "This is a subject" &&
+	git format-patch -o patches HEAD~1 &&
+	grep -E "^[[[:digit:]]+/[[:digit:]]+]" patches/0000-cover-letter.patch >result &&
+	test_line_count = 1 result
+'
+
+test_expect_success 'cover letter config commitlistformat not set' '
+	test_when_finished "rm -rf patches result" &&
+	test_when_finished "git config unset format.coverletter" &&
+	git config set format.coverletter true &&
+	git format-patch -o patches HEAD~2 &&
+	grep -E "^A U Thor \([[:digit:]]+\)" patches/0000-cover-letter.patch >result &&
+	test_line_count = 1 result
+'
+
 test_expect_success 'reroll count' '
 	rm -fr patches &&
 	git format-patch -o patches --cover-letter --reroll-count 4 main..side >list &&
-- 
2.53.0.904.g2727be2e99

