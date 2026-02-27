Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2B4242D91
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 01:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772157184; cv=none; b=Es+Rg2ffS/BHxRPIw90XzgjNZwWzmvD9WM/6ODR0J8nUqDuoc4DC7V8ZbCkk3fdbrzz1xNED0SvsCkKPSmgm4jkc5KvFVjFuGe9rswL7w+8zwog/b3J2pab25jD4198zoTLOTdCs77L/TBACSFtjk3/JlzcB+Ux3GRPSD4hbDlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772157184; c=relaxed/simple;
	bh=CZ4Yy5syCpudrywwkU/OG+y+21s0zBbu389l3YvWDAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rIRkZcTen+uq8Zb4jtvenuSFXcNrfe1Hv+W4RlOYp/NDGS46j3rCZ4uXcS8MOFg5lajznAKNKN+eoqLbhDCsivq4iEsJ/oQ7vtz0yyk0UZ234j5SpFpFfPkLeQYATN9BGct7SGzl1H6GmRye4MoO7QhewE5wDU1b9dA8ycwo/B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=iRQW3po1; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="iRQW3po1"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1772157176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zN+Odnj9eFumm8TiX7c0PeK0N4aEiwnYSScx1Dw+tQM=;
	b=iRQW3po1J+UPKhSP+M95rKXuOj7uXbENDbEdIHwpIqMgu9UrxDR/80QgRFHLtTjXICvK++
	EE1XFgs/qthdw9Wlqg8Smd2uLnBxL+ObClVcZX5ACxSeowhgBp8+ZvzoFYGGjLAg/TzupM
	ejpLoVTN3dfDazZhUyi+NI1Est00l7nWxC+GHQRcCdgh0fBiZWA9qc2eRhYgg0e/YgfqDG
	SPcX/BNmSOzWpDGKvGJHfFiCOPffCSDrqoqVM+DljvxhWnZJIlNuI/cibgUnDK27us/uBe
	Tm0UDfXkmqThatTbMeUYDVWGwuaNOafcpZCweGB6KkCHJ8ObtBi8TkGjhoPCfQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 4/4] format-patch: add commitListFormat config
Date: Fri, 27 Feb 2026 02:52:39 +0100
Message-ID: <55f3102ead7e9a5887138bc62706ab76ed7236bd.1772156996.git.mroik@delayed.space>
In-Reply-To: <cover.1772156996.git.mroik@delayed.space>
References: <cover.1771925291.git.mroik@delayed.space> <cover.1772156996.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5993; i=mroik@delayed.space; h=from:subject:message-id; bh=CZ4Yy5syCpudrywwkU/OG+y+21s0zBbu389l3YvWDAU=; b=kA0DAAoBSHl+oZwZvtEByyZiAGmg+JqiJNxP0Vx4752XFKAhBv5tqwWSwh+0XLjTUR0/85YAQ 4kCMwQAAQoAHRYhBP8rLfsrSlLCbCzJtkh5fqGcGb7RBQJpoPiaAAoJEEh5fqGcGb7RCVcP/2FA qW56/SMNOCij/ej0g9BSzerQSA+lmEQgh9Ad0bwPzgvmLkhsdTNOLZ669sdqbDxxKtE+0rIg5Nc OjzUaAitFL2N8p8lIHfVv7yHxjb5aYhWnPLWdKmHymPMnWw2BLUTr2j+zwFXVhcLGl/RNGiwv1s QssJkjXNrjDyKjbV+/0THHltJqCO37K1LuCs7uBLNjvE23Hr7wpNP2m2Yqg/txW+aiFeMtOHTSL JSRZPgkpRNjQ69JCGJXbgOCS+SRo6TXByN0GzwDYBUPVj8MGMg6K7ZAPVnCBRA9yn8XbUm8qFOP eTBugxdUTxlPMWBjK2GDgvcZflFaoes0rgbJrSeNf4pD8JQ3jUstrA0Pjc+wKyzP6nFN6zVQk4K ynaEdIAypbiNslpiToj81JG1zfJE2BmwpS+8SWuV+cFlDtJa948Lt82M4etziAEL0wTRcbHEi6M v812DmclJRbnpwqaChnTEeLGODL0YIAw4YjcvKbLK3PNTalfxJEcAC+XpFAJXlAoMqG3LWf3vQb LSq0n/+X623rviefZnxsrLbowtYjyQPATQ0eflVDaepoubYlwwlCGapvBrul2I+pz2/+mR94XEb w7cS7JsakCeENqkzEykbU9AN+6GEnWcF6sUJgk9G0NYc0xKeODgSo7txRjO7R/U+V7HrVN2kTSi izXaW
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

Using "--cover-letter" we can tell format-patch to generate a cover
letter, in this cover letter there's a list of commits included in the
patch series and the format is specified by the "--cover-letter-format"
option. Would be useful if this format could be configured from the
config file instead of always needing to pass it from the command line.

Teach format-patch how to read the format spec for the cover letter from
the config files. The variable it should look for is called
"commitListFormat".

Possible values:
- commitListFormat is set but no string is passed: it will default to
  "[%(count)/%(total)] %s"
- if a string is passed: will use it as a format spec. Note that this is
  either "shortlog" or a format spec without the "log:" prefix
  e.g. "%s (%an)"
- if commitListFormat is not set: it will default to "shortlog"
shortlog format.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 builtin/log.c           | 24 +++++++++++++++++++
 t/t4014-format-patch.sh | 53 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index 46c8e33773..dcf7cd1792 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -886,6 +886,7 @@ struct format_config {
 	char *signature;
 	char *signature_file;
 	enum cover_setting config_cover_letter;
+	char *fmt_cover_letter_commit_list;
 	char *config_output_directory;
 	enum cover_from_description cover_from_description_mode;
 	int show_notes;
@@ -930,6 +931,7 @@ static void format_config_release(struct format_config *cfg)
 	string_list_clear(&cfg->extra_cc, 0);
 	strbuf_release(&cfg->sprefix);
 	free(cfg->fmt_patch_suffix);
+	free(cfg->fmt_cover_letter_commit_list);
 }
 
 static enum cover_from_description parse_cover_from_description(const char *arg)
@@ -1052,6 +1054,22 @@ static int git_format_config(const char *var, const char *value,
 		cfg->config_cover_letter = git_config_bool(var, value) ? COVER_ON : COVER_OFF;
 		return 0;
 	}
+	if (!strcmp(var, "format.commitlistformat")) {
+		struct strbuf tmp = STRBUF_INIT;
+		strbuf_init(&tmp, 0);
+		if (value) {
+			if (strcmp(value, "shortlog"))
+				strbuf_addstr(&tmp, "log:");
+			strbuf_addstr(&tmp, value);
+		} else {
+			strbuf_addstr(&tmp, "log:[%(count)/%(total)] %s");
+		}
+
+		FREE_AND_NULL(cfg->fmt_cover_letter_commit_list);
+		git_config_string(&cfg->fmt_cover_letter_commit_list, var, tmp.buf);
+		strbuf_release(&tmp);
+		return 0;
+	}
 	if (!strcmp(var, "format.outputdirectory")) {
 		FREE_AND_NULL(cfg->config_output_directory);
 		return git_config_string(&cfg->config_output_directory, var, value);
@@ -2329,6 +2347,12 @@ int cmd_format_patch(int argc,
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
index 458da80721..c43c6972af 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -428,6 +428,59 @@ test_expect_success 'cover letter no format' '
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
+test_expect_success 'cover letter config commitlistformat set but no format' '
+	test_when_finished "rm -rf patches result" &&
+	test_when_finished "git config unset format.coverletter" &&
+	test_when_finished "git config unset format.commitlistformat" &&
+	git config set format.coverletter true &&
+	printf "\tcommitlistformat" >> .git/config &&
+	git format-patch -o patches HEAD~2 &&
+	grep -E "^[[[:digit:]]+/[[:digit:]]+] .*" patches/0000-cover-letter.patch >result &&
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
2.53.0.4.g55f3102ead

