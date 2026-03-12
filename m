Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EA63F0A9E
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 16:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773332427; cv=none; b=Lnxfy0knvyOSWErMTIgC4TyCouif0rbyfs7udDu8HlDgIOckcNCNos80eIjKhRJkDBk0sTGuERQUd5+c6okReolgaNdyKtHBm9vPYJ5ZufJpdkiD91Bs4gbpNN1Jneuhn7jLErvRUAI47yW7JzZ0KrjpCCt1HBehmP62Ej9gIRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773332427; c=relaxed/simple;
	bh=aTixew1igUCA3F6I9b3keo2BvzwGr388Hxw9Ddiki9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWSKfqCNwAIh9bIDkAvrUDntQsFTwxxJHd3eq9fKnKLZ9VJUU+Mhm6sUyv9fWysa/7fLFzIrWDFfQU3ekMe3Gbeup0VN49vBfwX2nKaNTYKvDwL/9T9c248fjJgZqAiVIKCF62ey9Sqn3Q/My4bhpl2TDzyCt6pBn/yzuE4VPio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=cCZ0vVTN; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="cCZ0vVTN"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773332417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y9Tyh16VUI/aN42wkip7Q5CZVRaIutKV8tmIAskOGDk=;
	b=cCZ0vVTNGdJ0xrKOiwjo5zc3GL2VjR0tu/E8WhK5iDn79q4Qw9EraBRkYJBlMx/BEYWcKD
	92tC5xb7VFsdgBDuoxDigsVlwB085EWGWyoZTYmRn0aryLJTvoE4ZUWdAdemvQ7shm2zcd
	n+wVBRWh9XWnLjuC+OURwztF2l5KqRjmZKfhmdkw3+5tcc6Wz04fgi5Z1ba/v8jenyBsF9
	tviH8Wlo3dvgKhP4//L8ltz2eIpTPBd2aYi+EyPcj41yP9pQfje7kcx0kejjVntvHXlLQY
	2Z1G6AqVOb83DRtnLK9jwL5PAtcTlSVYm38x70tJQgeFXCjsFVtuYpi11Be6vQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH v8 2/4] format-patch: add ability to use alt cover format
Date: Thu, 12 Mar 2026 17:20:09 +0100
Message-ID: <225065cc0dd54d1a592939d41783a904a98fb2ad.1773331753.git.mroik@delayed.space>
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

Often when sending patch series there's a need to clarify to the
reviewer what's the purpose of said series, since it might be difficult
to understand it from reading the commits messages one by one.

"git format-patch" provides the useful "--cover-letter" flag to declare
if we want it to generate a template for us to use. By default it will
generate a "git shortlog" of the changes, which developers find less
useful than they'd like, mainly because the shortlog groups commits by
author, and gives no obvious chronological order.

To better reference relevant patches in the coverletter this patch
introduces two new placeholders that can be used in the format spec:
%(count) and %(total). These are the chronological number of the patch
in the series and the total amount of patches in the series. Note that
the width of %(count) will always be the same witdh of %(total).

Give format-patch the ability to specify an alternative format spec
through the "--cover-letter-format" option. This option either takes
"shortlog", which is the current format, or a format spec prefixed with
"log:".

Example:
    git format-patch --cover-letter \
        --cover-letter-format="[%(count)/%(total)] %s (%an)" HEAD~3

    [1/3] this is a commit summary (Mirko Faina)
    [2/3] this is another commit summary (Mirko Faina)
    ...

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 Documentation/git-format-patch.adoc | 11 ++++++
 builtin/log.c                       | 36 ++++++++++++++++--
 pretty.c                            | 15 ++++++++
 t/t4014-format-patch.sh             | 58 +++++++++++++++++++++++++++++
 t/t9902-completion.sh               |  1 +
 5 files changed, 118 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
index 9a7807ca71..de36b87a85 100644
--- a/Documentation/git-format-patch.adoc
+++ b/Documentation/git-format-patch.adoc
@@ -24,6 +24,7 @@ SYNOPSIS
 		   [(--reroll-count|-v) <n>]
 		   [--to=<email>] [--cc=<email>]
 		   [--[no-]cover-letter] [--quiet]
+		   [--cover-letter-format=<format-spec>]
 		   [--[no-]encode-email-headers]
 		   [--no-notes | --notes[=<ref>]]
 		   [--interdiff=<previous>]
@@ -321,6 +322,16 @@ feeding the result to `git send-email`.
 	containing the branch description, shortlog and the overall diffstat.  You can
 	fill in a description in the file before sending it out.
 
+--cover-letter-format=<format-spec>::
+	Specify the format in which to generate the commit list of the patch
+	series. This option is available if the user wants to use an
+	alternative to the default `shortlog` format. The accepted values for
+	format-spec are "shortlog" or a format string.
+	e.g. `%s (%an)`
+	If defined, defaults to the `format.commitListFormat` configuration
+	variable.
+	This option is relevant only if a cover letter is generated.
+
 --encode-email-headers::
 --no-encode-email-headers::
 	Encode email headers that have non-ASCII characters with
diff --git a/builtin/log.c b/builtin/log.c
index 0d12272031..4f22012395 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1343,13 +1343,35 @@ static void generate_shortlog_cover_letter(struct shortlog *log,
 	shortlog_output(log);
 }
 
+static void generate_commit_list_cover(FILE *cover_file, const char *format,
+				       struct commit **list, int n)
+{
+	struct strbuf commit_line = STRBUF_INIT;
+	struct pretty_print_context ctx = {0};
+	struct rev_info rev = REV_INFO_INIT;
+
+	rev.total = n;
+	ctx.rev = &rev;
+	for (int i = 1; i <= n; i++) {
+		rev.nr = i;
+		repo_format_commit_message(the_repository, list[n - i], format,
+				&commit_line, &ctx);
+		fprintf(cover_file, "%s\n", commit_line.buf);
+		strbuf_reset(&commit_line);
+	}
+	fprintf(cover_file, "\n");
+
+	strbuf_release(&commit_line);
+}
+
 static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 			      struct commit *origin,
 			      int nr, struct commit **list,
 			      const char *description_file,
 			      const char *branch_name,
 			      int quiet,
-			      const struct format_config *cfg)
+			      const struct format_config *cfg,
+			      const char *format)
 {
 	const char *committer;
 	struct shortlog log;
@@ -1396,7 +1418,10 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 	free(pp.after_subject);
 	strbuf_release(&sb);
 
-	generate_shortlog_cover_letter(&log, rev, list, nr);
+	if (format == NULL || !strcmp(format, "shortlog"))
+		generate_shortlog_cover_letter(&log, rev, list, nr);
+	else
+		generate_commit_list_cover(rev->diffopt.file, format, list, nr);
 
 	/* We can only do diffstat with a unique reference point */
 	if (origin)
@@ -1914,6 +1939,7 @@ int cmd_format_patch(int argc,
 	int just_numbers = 0;
 	int ignore_if_in_upstream = 0;
 	int cover_letter = -1;
+	const char *cover_letter_fmt = NULL;
 	int boundary_count = 0;
 	int no_binary_diff = 0;
 	int zero_commit = 0;
@@ -1960,6 +1986,8 @@ int cmd_format_patch(int argc,
 			    N_("print patches to standard out")),
 		OPT_BOOL(0, "cover-letter", &cover_letter,
 			    N_("generate a cover letter")),
+		OPT_STRING(0, "cover-letter-format", &cover_letter_fmt, N_("format-spec"),
+			    N_("format spec used for the commit list in the cover letter")),
 		OPT_BOOL(0, "numbered-files", &just_numbers,
 			    N_("use simple number sequence for output file names")),
 		OPT_STRING(0, "suffix", &fmt_patch_suffix, N_("sfx"),
@@ -2297,6 +2325,7 @@ int cmd_format_patch(int argc,
 		/* nothing to do */
 		goto done;
 	total = list.nr;
+
 	if (cover_letter == -1) {
 		if (cfg.config_cover_letter == COVER_AUTO)
 			cover_letter = (total > 1);
@@ -2388,7 +2417,8 @@ int cmd_format_patch(int argc,
 			gen_message_id(&rev, "cover");
 		make_cover_letter(&rev, !!output_directory,
 				  origin, list.nr, list.items,
-				  description_file, branch_name, quiet, &cfg);
+				  description_file, branch_name, quiet, &cfg,
+				  cover_letter_fmt);
 		print_bases(&bases, rev.diffopt.file);
 		print_signature(signature, rev.diffopt.file);
 		total++;
diff --git a/pretty.c b/pretty.c
index e0646bbc5d..8f3c434817 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1549,6 +1549,21 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	if (!commit->object.parsed)
 		parse_object(the_repository, &commit->object.oid);
 
+	if (starts_with(placeholder, "(count)")) {
+		if (!c->pretty_ctx->rev)
+			die(_("%s is not supported by this command"), "%(count)");
+		strbuf_addf(sb, "%0*d", decimal_width(c->pretty_ctx->rev->total),
+			    c->pretty_ctx->rev->nr);
+		return 7;
+	}
+
+	if (starts_with(placeholder, "(total)")) {
+		if (!c->pretty_ctx->rev)
+			die(_("%s is not supported by this command"), "%(total)");
+		strbuf_addf(sb, "%d", c->pretty_ctx->rev->total);
+		return 7;
+	}
+
 	switch (placeholder[0]) {
 	case 'H':		/* commit hash */
 		strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_COMMIT));
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 21d6d0cd9e..631669c159 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -380,6 +380,64 @@ test_expect_success 'filename limit applies only to basename' '
 	done
 '
 
+test_expect_success 'cover letter with subject, author and count' '
+	rm -rf patches &&
+	test_when_finished "git reset --hard HEAD~1" &&
+	test_when_finished "rm -rf patches result test_file" &&
+	touch test_file &&
+	git add test_file &&
+	git commit -m "This is a subject" &&
+	git format-patch --cover-letter \
+	--cover-letter-format="[%(count)/%(total)] %s (%an)" -o patches HEAD~1 &&
+	test_grep "^\[1/1\] This is a subject (A U Thor)$" patches/0000-cover-letter.patch
+'
+
+cat > expected <<EOF
+
+
+
+
+
+
+
+
+
+
+A U Thor (1):
+  This is a subject
+
+
+
+
+
+
+
+
+EOF
+
+test_expect_success 'cover letter shortlog' '
+	test_when_finished "git reset --hard HEAD~1" &&
+	test_when_finished "rm -rf patches expected test_file result" &&
+	touch test_file &&
+	git add test_file &&
+	git commit -m "This is a subject" &&
+	git format-patch --cover-letter --cover-letter-format=shortlog \
+	-o patches HEAD~1 &&
+	sed -n -e "/^A U Thor (1):$\|^  This is a subject$/!s/.*//; /.*/p" patches/0000-cover-letter.patch >result &&
+	test_cmp expected result
+'
+
+test_expect_success 'cover letter no format' '
+	test_when_finished "git reset --hard HEAD~1" &&
+	test_when_finished "rm -rf patches result test_file" &&
+	touch test_file &&
+	git add test_file &&
+	git commit -m "This is a subject" &&
+	git format-patch --no-cover-letter-format --cover-letter -o patches HEAD~1 &&
+	sed -n -e "/^A U Thor/p;" patches/0000-cover-letter.patch >result &&
+	test_line_count = 1 result
+'
+
 test_expect_success 'reroll count' '
 	rm -fr patches &&
 	git format-patch -o patches --cover-letter --reroll-count 4 main..side >list &&
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 964e1f1569..4f760a7468 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2774,6 +2774,7 @@ test_expect_success PERL 'send-email' '
 	test_completion "git send-email --cov" <<-\EOF &&
 	--cover-from-description=Z
 	--cover-letter Z
+	--cover-letter-format=Z
 	EOF
 	test_completion "git send-email --val" <<-\EOF &&
 	--validate Z
-- 
2.53.0.904.g2727be2e99

