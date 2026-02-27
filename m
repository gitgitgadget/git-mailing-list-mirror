Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5B221771C
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 13:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772198313; cv=none; b=ZUE9CXsTB3NGevm7NWrziYfxAkmDxjl0/yK4kycbag/b92KxACNKCa1nYf9V1g82/3oH6iZlyL1lEr78V+w2e+YUgRkuqWaovX0SnJQcDzo2Q5gMI4a3Wcb3IZAvmknI9aRosKnrPMp2ucsfDEiy1Y3GBlNAphWykPGkf5M5iiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772198313; c=relaxed/simple;
	bh=RBe1CX6GLkm59KBJVoKaRbpryGS3ETH6ozB4SQhr1Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SqtZbOOelICUrlDkBl5h9CAnajjQ94a+zHPmlwJHu7cqW0j7crgxLeWAnj7lFHOsTpM8ZhgrcBVyjbGu/OsbJtR7PVBd4Xtl1RoSbh9Yl3Z8bLNEi4OlF4iqiHpHUqunrSYe2ewNQHcU1slrEPAp0iyDfTgCdBRFz+xjQPZArAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=hOwg8P9t; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="hOwg8P9t"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1772198310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V5+G2ciiZVXd1X0pJlxnEgarMIHEt2FLe30Hro1rmn8=;
	b=hOwg8P9t0VK+w6aUgM3rmDTAyITxxXHZmjKlZyqnHbMvv//Hs4msVnv3YuhqWyTdXC5Yce
	ZZk2gt9F4K1EfLKj4M1oSVBQ/jFglM6fkfNgpGpnTF473BQasht33Ol+HT2djxhttfig5s
	3dwGJEeM0ki6SlPj/UcwL6zeW297OODzOS/ZPbZsfhlXNfDXQOaeojd1EaTCaHgtjzHNYj
	bYnSe8ehp3ibA61p9oGby78UxGMDZOHbhzcc9CvwjD/HHD4jpXvjIRYnTA89rGabXe/H37
	KsihHVaSheXAJQe7vUhh4WLKbV09DyF4754Y58BEU8i9A+G39NLKEXwG0e+bGQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v4 4/4] format-patch: add commitListFormat config
Date: Fri, 27 Feb 2026 14:18:12 +0100
Message-ID: <f9ee8e24001aa16e5df3dc0bbfccd1b381e37d85.1772196510.git.mroik@delayed.space>
In-Reply-To: <cover.1772196510.git.mroik@delayed.space>
References: <cover.1772156996.git.mroik@delayed.space> <cover.1772196510.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

Using "--cover-letter" we can tell format-patch to generate a cover
letter, in this cover letter there's a list of commits included in the
patch series and the format is specified by the "--cover-letter-format"
option. Would be useful if this format could be configured from the
config file instead of always needing to pass it from the command line.

Teach format-patch how to read the format spec for the cover letter from
the config files. The variable it should look for is called
format.commitListFormat.

Possible values:
  - commitListFormat is set but no string is passed: it will default to
    "[%(count)/%(total)] %s"

  - if a string is passed: will use it as a format spec. Note that this
    is either "shortlog" or a format spec without the "log:" prefix e.g.
    "%s (%an)"

  - if commitListFormat is not set: it will default to the shortlog
    format.

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
2.53.0.4.gf9ee8e2400

