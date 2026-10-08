Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C2248CD41
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791461812; cv=none; b=k4/62lqYlWAMbkk9n2AD1Rm7mEzSzPjkPx9fQ7QtEb+3lcW0/kh+QMwsdo0KmtD+cI52GvsjxvSuiWUBehm8q8bq/mXKuwZbizs43BJtnyIqRe4fk0wSO2qLp6JYGcLFQA582PLzMcZmdin1+qovpPdg1NsIxDye2WnwAyVn7sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791461812; c=relaxed/simple;
	bh=E9bMxRc+2P7HKb7x4mLZuccgg1/4U15euUCtmZHCtyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HtSqWANNAhGxCesmqVk+WOeQEullU8MT/JhcPT6LupDHEeJLvdl4ALSMCpFCvlknKx1RHRLesD7oMmq+1Kh3h/htjVeGgxddajaqnXSsl7tykYaRAlrnNMHTIRMlemnf6tHj0XuzdO6b7eywQIv7zOSolxr2jL/iKruWuV5XNG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=CJgcLSBZ; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="CJgcLSBZ"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1791461252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KIISSuuzw43ltALK2ELyC8pP/yK9ROXuv914c5my3oE=;
	b=CJgcLSBZ/yeIbILllAe7K6ZU9HmA9HvXPfLSCBUgRTfgsUytOJ2pZpSHZRYz5TFhbfokOS
	cr02tq5IAAVwOd0LN4xamS7dHSSa7dTAcnI9hB58CEIyX6K4OC2mMB3gmgN6HeAIBT0wjg
	pDNiBEAf43rFKsWdGu4nKRmX1VuVC5QtUHk5f6zOOZDBy1b5jXjq3qu3mMZKzaSKAr9I/B
	gsjsKLsqNLJhxRFToZGz0tPVWhBBjTFyZds8fvSD8KTb4MY9X2n1aiPho6bjT6Z5MPtJ5F
	0LFimwj89E+x0+CnCIKKPV0oQDo2ch/v3DDvtwhRImlhLUjBkxL/byER+1QlYQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: [RFC PATCH 3/6] dir.c: teach parse_path_pattern() precious files
Date: Thu,  8 Oct 2026 14:06:59 +0200
Message-ID: <677a1af4c6bacf129450e3c0c150d27bf65baecf.1791460418.git.mroik@delayed.space>
In-Reply-To: <cover.1791460418.git.mroik@delayed.space>
References: <cover.1791460418.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5349; i=mroik@delayed.space; h=from:subject:message-id; bh=E9bMxRc+2P7HKb7x4mLZuccgg1/4U15euUCtmZHCtyk=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBqx4dhbB3GOWxzYWAkRg/GfVEeclJqfGig0yD2D GgcxuYMXmKJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaseHYQAKCRBIeX6hnBm+ 0Y9zD/9XmoB9MmeCbwAzhGbChbrUqTHa4hXEXxDL0rUF0uFXYIpzrjz3Npy5S0U5YMYHREBFT0Z MM9Y0tMT/KYwbCK/aT5ZYt3I6jjBoAFucjudhEgy/DzzrTMoH47dZl1nv9ZlP4cDeJunl20As7p G526wwWfCjXfiQnQf6YvEH+ZqKe9EBETIaTaA/zZd7mM9XQPveCaDnOWTO8Nwn3/o4gPGklIASh cXtRC1cYEbw1RCBbwXcN8yk+VIp/MvG2YowlUHz5GtclQbXsGtLoGzMv5P3I1RuOnbDeCaMVje6 J3uFbkK2wR1Jov8B0odjDkgjjx9biJ4SL1sOyVIOZ0RRBogCRJTgf96IvGi6eLwQpWwRCezEUL5 l+1tTv5WKEa4y/1sC0iMXFWBRQ0stSTHzCAhD+NYP+uGW2SKm5Yvtp4cQ7iigZZhslVV78jZtnj LaoynDp9SK6d6P12z7zmwjVWkZLlZSAWoZVf+VufAsY00GDTLNyqb1FnZZT2cnbxfqpPnnC34wR RT1S1wjG1fek6UfGkM+swMUuiYpp5FThx7BFmg8/Nh8LcKGQAPLvRGYxW1rD804HKsxwXynhPHN O86GJwJ2zJUvLhirxovMEfs8ZgjtdyDrIJVZolDVLnVv0D/hGq8wFLTVhzT00FWwwLlZ93qD2le C7rax6Wad
 5Fj8jQ==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

parse_path_pattern() knows only to recognize patterns that are either
directories or normal files. It also knows that there are negated
patterns, but it doesn't know about patterns that indicate
precious files.

Teach about precious files to parse_path_pattern(). We teach it also to
detect the invalid patterns starting with '!$' which would mean a
negated precious file, that we don't allow. This is reported back to the
caller so we change its signature to return an int. We also teach the
callers parse_attr_line() and add_pattern() to handle such errors.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 attr.c            |  8 ++++++--
 attr.h            |  1 +
 dir.c             | 26 +++++++++++++++++++++++---
 dir.h             |  2 +-
 t/t7508-status.sh |  9 +++++++++
 5 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/attr.c b/attr.c
index 0e63f1b6de..5c60ca6b23 100644
--- a/attr.c
+++ b/attr.c
@@ -382,10 +382,14 @@ struct match_attr *parse_attr_line(const char *line, const char *src,
 		char *p = (char *)&(res->state[num_attr]);
 		memcpy(p, name, namelen);
 		res->u.pat.pattern = p;
-		parse_path_pattern(&res->u.pat.pattern,
+		if (parse_path_pattern(&res->u.pat.pattern,
 				      &res->u.pat.patternlen,
 				      &res->u.pat.flags,
-				      &res->u.pat.nowildcardlen);
+				      &res->u.pat.nowildcardlen)) {
+			warning(_("pattern '%s' is invalid, skipping"),
+				  (char *)&res->u.pat.pattern);
+			goto fail_return;
+		}
 		if (res->u.pat.flags & PATTERN_FLAG_NEGATIVE) {
 			warning(_("Negative patterns are ignored in git attributes\n"
 				  "Use '\\!' for literal leading exclamation."));
diff --git a/attr.h b/attr.h
index c083d47df5..d00939732b 100644
--- a/attr.h
+++ b/attr.h
@@ -255,6 +255,7 @@ enum pattern_flags {
 	PATTERN_FLAG_ENDSWITH = 4,
 	PATTERN_FLAG_MUSTBEDIR = 8,
 	PATTERN_FLAG_NEGATIVE = 16,
+	PATTERN_FLAG_PRECIOUS = 32,
 };
 
 struct pattern {
diff --git a/dir.c b/dir.c
index c6342c882a..c6f1bed429 100644
--- a/dir.c
+++ b/dir.c
@@ -700,7 +700,10 @@ int no_wildcard(const char *string)
 	return string[simple_length(string)] == '\0';
 }
 
-void parse_path_pattern(const char **pattern,
+/*
+ * Returns 1 if the pattern is problematic, 0 otherwise
+ */
+int parse_path_pattern(const char **pattern,
 			   int *patternlen,
 			   enum pattern_flags *flags,
 			   int *nowildcardlen)
@@ -709,7 +712,12 @@ void parse_path_pattern(const char **pattern,
 	size_t i, len;
 
 	*flags = 0;
-	if (*p == '!') {
+	if (simple_length(p) >= 2 && p[0] == '!' && p[1] == '$') {
+		return 1;
+	} else if (*p == '$') {
+		*flags |= PATTERN_FLAG_PRECIOUS;
+		p++;
+	} else if (*p == '!') {
 		*flags |= PATTERN_FLAG_NEGATIVE;
 		p++;
 	}
@@ -736,6 +744,7 @@ void parse_path_pattern(const char **pattern,
 		*flags |= PATTERN_FLAG_ENDSWITH;
 	*pattern = p;
 	*patternlen = len;
+	return 0;
 }
 
 int pl_hashmap_cmp(const void *cmp_data UNUSED,
@@ -975,6 +984,14 @@ int hashmap_contains_parent(struct hashmap *map,
 	return 0;
 }
 
+/*
+ * Parses the pattern for its type and sets flags accordingly, then adds it to
+ * the pattern list. If the pattern is invalid the function returns early with a
+ * warning.
+ *
+ * The only problematic patterns at the moment are the one starting with '!$'
+ * which are negated precious-files.
+ */
 void add_pattern(const char *string, const char *base,
 		 int baselen, struct pattern_list *pl, int srcpos)
 {
@@ -983,7 +1000,10 @@ void add_pattern(const char *string, const char *base,
 	enum pattern_flags flags;
 	int nowildcardlen;
 
-	parse_path_pattern(&string, &patternlen, &flags, &nowildcardlen);
+	if (parse_path_pattern(&string, &patternlen, &flags, &nowildcardlen)) {
+		warning(_("pattern '%s' is problematic, skipping"), string);
+		return;
+	}
 	FLEX_ALLOC_MEM(pattern, pattern, string, patternlen);
 	pattern->patternlen = patternlen;
 	pattern->nowildcardlen = nowildcardlen;
diff --git a/dir.h b/dir.h
index 210ee8a98d..5cda2cdba7 100644
--- a/dir.h
+++ b/dir.h
@@ -465,7 +465,7 @@ int add_patterns_from_blob_to_list(struct object_id *oid,
 int add_patterns_from_buffer(char *buf, size_t size,
 			     const char *base, int baselen,
 			     struct pattern_list *pl);
-void parse_path_pattern(const char **string, int *patternlen, enum pattern_flags *flags, int *nowildcardlen);
+int parse_path_pattern(const char **string, int *patternlen, enum pattern_flags *flags, int *nowildcardlen);
 void add_pattern(const char *string, const char *base,
 		 int baselen, struct pattern_list *pl, int srcpos);
 void clear_pattern_list(struct pattern_list *pl);
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 0fd7c79911..aa251c6abd 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -301,6 +301,15 @@ EOF
 	test_cmp expect output
 '
 
+test_expect_success 'parse invalid pattern' "
+	test_when_finished rm actual gitignore_backup &&
+	test_when_finished cp gitignore_backup .gitignore &&
+	cp .gitignore gitignore_backup &&
+	echo '!$/ciao' >> .gitignore &&
+	git status >actual 2>&1 &&
+	test_grep \"warning: pattern '!$/ciao' is problematic, skipping\" actual
+"
+
 test_expect_success 'status with gitignore (nothing untracked)' '
 	{
 		echo ".gitignore" &&
-- 
2.56.0

