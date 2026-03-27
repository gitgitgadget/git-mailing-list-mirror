Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABAD388E67
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 19:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774640941; cv=none; b=IZ7zrLpWSNN+ycrwdA7SSTFV1Y6Ki5KzueUoBlu9JfwcqVWXHKnopJTw9GpxJtg3/H33UAzBg+SMPQa4Bb9+Ga+Gmsh7bfbSemj+HSMg+m0Q2tVxDMgJfr6z4Pw1G6Ptk5QGrXMJc9tbDm/Iq2C1e+W98oXj7T1OX2pJ8w3M9jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774640941; c=relaxed/simple;
	bh=jZw8SZYc1zKTeB+F8Gw+yYDsPCEczTwKIBzbOnWD9xE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jEcxF7k01NZQH9W+7I3+5FjWqpfGbBwoehDDUiO8Tp1H34EQd46hM4dY9FG4x3yD9rkOXMy9Ab2a5fMvsQzT88eClYLFqtvO7LqLDItd4YhcykwZQOj9ance/ylpf6NyJZBHv0sebkFOE+3MF01zkhN4ZUsTc/gQ5zAetpGNO6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=DOrt6yJj; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="DOrt6yJj"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1774640930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yV5HbLRYP4fzkZiq5wwsa6ZJFvU/EmF+nQTD6gOoZvw=;
	b=DOrt6yJjTRDBlEpedylP9A5ANe3QmDt98oo99Hb6/FtdSBPHulRnDZ9UhlVi1J/b4jC/Ui
	lw9L7Zc3BhnE4vAkdNiOGsUNEqVgzPgD2pwi57R5uzoOCeas0hMldP2HlJg4m7lE7/y+Za
	4WMA5MpPxF/WszsXfH2+PVaH9hAjjfuMdGyntWAZT+VD+hP4ZgZKn/vLVF7AIPI9JOyk86
	06K+6DCLmRxCn4Q6sdAffV/9YXuhaMKLb7/wpcLsJCkQOs8AIdFTCLIT0IIObo4axqUlt1
	KHH8X4sMj853k4W0SNvSU6YTzD+FEB8fpv92oAMYGXWqXqt5kzrRf+ixGnBAqQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] format-patch: removing unconditional wrapping
Date: Fri, 27 Mar 2026 20:48:10 +0100
Message-ID: <204b9320f46529d16d3a4d9a9c4a57253b4db028.1774640789.git.mroik@delayed.space>
In-Reply-To: <cover.1774640789.git.mroik@delayed.space>
References: <20260326200643.20251-1-mroik@delayed.space> <cover.1774640789.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

Using format-patch with --commit-list-format different than shortlog,
causes the commit entry lines to wrap if they get longer than
MAIL_DEFAULT_WRAP (72 characters).

While this might be sensible for many when sending changes through
email, it forces this decision of wrapping on the user, reducing the
control granularity of --commit-list-format.

Teach generate_commit_list_cover() to respect commit entry line lengths
and place this wrapping rule on the "modern" preset format instead.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 Documentation/git-format-patch.adoc | 2 +-
 builtin/log.c                       | 9 ++-------
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
index cbbb292cb5..5662382450 100644
--- a/Documentation/git-format-patch.adoc
+++ b/Documentation/git-format-patch.adoc
@@ -327,7 +327,7 @@ feeding the result to `git send-email`.
 	Specify the format in which to generate the commit list of the patch
 	series. The accepted values for format-spec are `shortlog`, `modern` or
 	a format-string prefixed with `log:`. E.g. `log: %s (%an)`.
-	`modern` is the same as `log:[%(count)/%(total)] %s`.
+	`modern` is the same as `log:%w(72)[%(count)/%(total)] %s`.
 	The `log:` prefix can be omitted if the format-string has a `%` in it
 	(expecting that it is part of `%<placeholder>`).
 	Defaults to the `format.commitListFormat` configuration variable, if
diff --git a/builtin/log.c b/builtin/log.c
index ad7b7215fe..8c0939dd42 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1365,7 +1365,6 @@ static void generate_commit_list_cover(FILE *cover_file, const char *format,
 				       struct commit **list, int n)
 {
 	struct strbuf commit_line = STRBUF_INIT;
-	struct strbuf wrapped_line = STRBUF_INIT;
 	struct pretty_print_context ctx = {0};
 	struct rev_info rev = REV_INFO_INIT;
 
@@ -1375,16 +1374,12 @@ static void generate_commit_list_cover(FILE *cover_file, const char *format,
 		rev.nr = i;
 		repo_format_commit_message(the_repository, list[n - i], format,
 				&commit_line, &ctx);
-		strbuf_add_wrapped_text(&wrapped_line, commit_line.buf, 0, 0,
-					MAIL_DEFAULT_WRAP);
-		fprintf(cover_file, "%s\n", wrapped_line.buf);
+		fprintf(cover_file, "%s\n", commit_line.buf);
 		strbuf_reset(&commit_line);
-		strbuf_reset(&wrapped_line);
 	}
 	fprintf(cover_file, "\n");
 
 	strbuf_release(&commit_line);
-	strbuf_release(&wrapped_line);
 }
 
 static void make_cover_letter(struct rev_info *rev, int use_separate_file,
@@ -1446,7 +1441,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 	else if (!strcmp(format, "shortlog"))
 		generate_shortlog_cover_letter(&log, rev, list, nr);
 	else if (!strcmp(format, "modern"))
-		generate_commit_list_cover(rev->diffopt.file, "[%(count)/%(total)] %s",
+		generate_commit_list_cover(rev->diffopt.file, "%w(72)[%(count)/%(total)] %s",
 					   list, nr);
 	else if (strchr(format, '%'))
 		generate_commit_list_cover(rev->diffopt.file, format, list, nr);
-- 
2.53.0.1181.g1066ffbbbe

