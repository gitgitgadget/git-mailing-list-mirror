Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC02742124D
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791461813; cv=none; b=pY7EIZ1OPm2x7KAIhiA1cZOZ77AIfjFb5jwOd3DSWV76xY+xKWJ3c2hroFFucsC8nMTMhv7we25Bod8n9BYSAIvrgcMeGY5yWET/PwosmiblYQWb7BHORPWa9tpqCt1voFL0ULaRJQ+uz3NjuUM+UaHyHioXWwTpLvlmjs/g2Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791461813; c=relaxed/simple;
	bh=83shE7xw9Q8ZUO1ZpWLZhHq7KkBlf/6/RwdWaFOUg6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mU2mC2XFxTEc9mR54zT/SFsgGF8yV8Art49K6i/M6i0hkbPfCX47LHO+UjaFtCKgDCsDkLUDpuGBPhQ9OdrLusyIiDsuSNNoY9j+HaFvJCkNBia8Vdc618yMSDP9BkTeHfwERl/9T0G+SEA5K0HyCzZPt0vpovdZpNdtY85CNa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=ZVgxx6gU; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="ZVgxx6gU"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1791461252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q3sXIS/Z6DlEWhPgOKPoroTbhBS/TXbUGdfJqZCbuLE=;
	b=ZVgxx6gUXytP0mDZNL9gsLi+5cJK4qNsWnyxHxAG9yJlbHVS/pAteVWur5pJk7xGBpTMni
	SAjagaHvFYhQKmvLzAAWIx84/LIRZWW00/tyR61o+HykGS04uh8uDTgXTIPH0CutQXRkJK
	v6BCyUB0X4CA5WFUzM9cCel8Q0apCdZJDgYVNVfKkyy0hX9Li8CEEkDa/vFTO3Y8/R4llN
	4G9qjHCd6gO2ej6URB79pmD+bK2JzOs12/J97WZWJFEMqAM8iItiCKH2AOO69pZEb+DXmd
	Tr7IdHjD0MQzkoruogH1vpOQZtBaLZ3pxE+JBKqlRGiKA5wegwYm3Lp4Gmkcew==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: [RFC PATCH 4/6] dir.c: teach add_pattern() reject precious pattern
Date: Thu,  8 Oct 2026 14:07:00 +0200
Message-ID: <b4e2d50f6f5da34a9720d23f487f0db41d2bf3ee.1791460418.git.mroik@delayed.space>
In-Reply-To: <cover.1791460418.git.mroik@delayed.space>
References: <cover.1791460418.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8783; i=mroik@delayed.space; h=from:subject:message-id; bh=83shE7xw9Q8ZUO1ZpWLZhHq7KkBlf/6/RwdWaFOUg6U=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBqx4diBo+j1Ln5lRPY/tKktDipKPMpKhbOArKmr MklZmGviQSJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaseHYgAKCRBIeX6hnBm+ 0bxdD/4jlVIPc6zHrXsBFiaI9nhuZv0OP/zAgLBW7q/dsdog7MUiLwR0He/iRUWNDpOgYHeOSy1 k715NPU8UKPfO142MnuxGNYGti0ndlVT7Q1hqDRp/VU+hMwQVoqpHbRgQHHBDEAsMqUrtiE5TfU ZhKODiB2QpfNNDSeqp1Ht2iakkmwMN2B8ZTDw9LI9Q1lz6XQvb2xEGCOQuNhK04WER6iSmj01J8 M8FTmHnvCsZAbLBuAzRQfOEx3I9WuC6uzt/3sYfUHKRcA+XrQEUtAGj9vOQh1TLVfRm8TmcabhI WM5jseU484OloYzcLrmBOEfspF1X6+c/RVlKp4yCT4qCFqHMS4az4/6WLFozsJU22sM170yiR/o XpjLS4kE1DssDrTwbk2fMHCmJANmQDMTW5FC1EAaZSmekJq/9PQGOeH4/uG1t1bFOPsRoc4G22z x29y2hx/deAumr9w3h0V1Ip28bDQRmpaazUaKhQN0RHiRyW05y75vL3E3XlmEvuLM4CWNE+P4ik 8RKw/hlTg9rkF1gez461RdGKb4/B6uaXp+62DSiAeGU3Mi5US67mcuyWFjl+hJQpNW1HCiVoq+u wta3z7dAisk8esU79JBZbyfDQp0wbt1hiVlyYW3iA3FqcTcGUQ4jEn3ZZkABwfdhRemLveUsagz TGr+35nmZ
 08JAoQ==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

There are some places where we want to disallow precious files patterns
altogether. This is the case with $GIT_DIR/info/sparse-checkout.

Teach add_pattern() a flag to indicate if we want it to reject
precious files patterns. If that's the case it fails the same way it
would when we encounter a pattern that starts with '!$', with a warning.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 builtin/clean.c                    |  4 ++--
 builtin/ls-files.c                 |  2 +-
 builtin/sparse-checkout.c          | 15 +++++++++------
 dir.c                              | 20 +++++++++++++++-----
 dir.h                              |  5 +++--
 t/helper/test-path-walk.c          |  2 +-
 t/t1091-sparse-checkout-builtin.sh |  8 ++++++++
 7 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 1d5e7e5366..73408da5c2 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -707,7 +707,7 @@ static int filter_by_patterns_cmd(void)
 			item = &ignore_list.items[i];
 			if (!*item->string)
 				continue;
-			add_pattern(item->string, "", 0, pl, -(i+1));
+			add_pattern(item->string, "", 0, pl, -(i+1), 0);
 		}
 
 		changed = 0;
@@ -1018,7 +1018,7 @@ int cmd_clean(int argc,
 
 	pl = add_pattern_list(&dir, EXC_CMDL, "--exclude option");
 	for (i = 0; i < exclude_list.nr; i++)
-		add_pattern(exclude_list.items[i].string, "", 0, pl, -(i+1));
+		add_pattern(exclude_list.items[i].string, "", 0, pl, -(i+1), 0);
 
 	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_CWD,
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index b044520f9e..d1cc7e92f4 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -685,7 +685,7 @@ int cmd_ls_files(int argc,
 			ls_files_usage, 0);
 	pl = add_pattern_list(&dir, EXC_CMDL, "--exclude option");
 	for (i = 0; i < exclude_list.nr; i++) {
-		add_pattern(exclude_list.items[i].string, "", 0, pl, --exclude_args);
+		add_pattern(exclude_list.items[i].string, "", 0, pl, --exclude_args, 0);
 	}
 
 	if (format && (show_stage || show_others || show_killed ||
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 83981e2b1e..615007148e 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -455,6 +455,8 @@ static struct sparse_checkout_init_opts {
 	int sparse_index;
 } init_opts;
 
+#define PATTERN_DISALLOW_PRECIOUS (1<<1)
+
 static int sparse_checkout_init(int argc, const char **argv, const char *prefix,
 				struct repository *repo)
 {
@@ -487,7 +489,8 @@ static int sparse_checkout_init(int argc, const char **argv, const char *prefix,
 	memset(&pl, 0, sizeof(pl));
 
 	sparse_filename = get_sparse_checkout_filename();
-	res = add_patterns_from_file_to_list(sparse_filename, "", 0, &pl, NULL, 0);
+	res = add_patterns_from_file_to_list(sparse_filename, "", 0, &pl, NULL,
+					     PATTERN_DISALLOW_PRECIOUS);
 
 	/* If we already have a sparse-checkout file, use it. */
 	if (res >= 0) {
@@ -515,8 +518,8 @@ static int sparse_checkout_init(int argc, const char **argv, const char *prefix,
 
 	free(sparse_filename);
 
-	add_pattern("/*", empty_base, 0, &pl, 0);
-	add_pattern("!/*/", empty_base, 0, &pl, 0);
+	add_pattern("/*", empty_base, 0, &pl, 0, 0);
+	add_pattern("!/*/", empty_base, 0, &pl, 0, 0);
 	pl.use_cone_patterns = init_opts.cone_mode;
 
 	return write_patterns_and_update(repo, &pl);
@@ -618,12 +621,12 @@ static void add_patterns_from_input(struct pattern_list *pl,
 			struct strbuf line = STRBUF_INIT;
 
 			while (!strbuf_getline(&line, file))
-				add_pattern(line.buf, empty_base, 0, pl, 0);
+				add_pattern(line.buf, empty_base, 0, pl, 0, 0);
 
 			strbuf_release(&line);
 		} else {
 			for (i = 0; i < argc; i++)
-				add_pattern(argv[i], empty_base, 0, pl, 0);
+				add_pattern(argv[i], empty_base, 0, pl, 0, 0);
 		}
 	}
 }
@@ -1079,7 +1082,7 @@ static int sparse_checkout_disable(int argc, const char **argv,
 	pl.use_cone_patterns = 0;
 	cfg->apply_sparse_checkout = 1;
 
-	add_pattern("/*", empty_base, 0, &pl, 0);
+	add_pattern("/*", empty_base, 0, &pl, 0, 0);
 
 	prepare_repo_settings(the_repository);
 	repo->settings.sparse_index = 0;
diff --git a/dir.c b/dir.c
index c6f1bed429..9aba1716a6 100644
--- a/dir.c
+++ b/dir.c
@@ -993,7 +993,8 @@ int hashmap_contains_parent(struct hashmap *map,
  * which are negated precious-files.
  */
 void add_pattern(const char *string, const char *base,
-		 int baselen, struct pattern_list *pl, int srcpos)
+		 int baselen, struct pattern_list *pl, int srcpos,
+		 int disable_precious)
 {
 	struct path_pattern *pattern;
 	int patternlen;
@@ -1004,6 +1005,12 @@ void add_pattern(const char *string, const char *base,
 		warning(_("pattern '%s' is problematic, skipping"), string);
 		return;
 	}
+
+	if (disable_precious && (flags & PATTERN_FLAG_PRECIOUS)) {
+		warning(_("'$%s' precious-files pattern not allowed here, skipping"),
+			string);
+		return;
+	}
 	FLEX_ALLOC_MEM(pattern, pattern, string, patternlen);
 	pattern->patternlen = patternlen;
 	pattern->nowildcardlen = nowildcardlen;
@@ -1162,6 +1169,7 @@ static void invalidate_directory(struct untracked_cache *uc,
 
 /* Flags for add_patterns() */
 #define PATTERN_NOFOLLOW (1<<0)
+#define PATTERN_DISALLOW_PRECIOUS (1<<1)
 
 /*
  * Given a file with name "fname", read it (either from disk, or from
@@ -1244,14 +1252,15 @@ static int add_patterns(const char *fname, const char *base, int baselen,
 		return -1;
 	}
 
-	add_patterns_from_buffer(buf, size, base, baselen, pl);
+	add_patterns_from_buffer(buf, size, base, baselen, pl,
+				 flags & PATTERN_DISALLOW_PRECIOUS);
 	free(buf);
 	return 0;
 }
 
 int add_patterns_from_buffer(char *buf, size_t size,
 			     const char *base, int baselen,
-			     struct pattern_list *pl)
+			     struct pattern_list *pl, int disable_precious)
 {
 	char *orig = buf;
 	int i, lineno = 1;
@@ -1270,7 +1279,8 @@ int add_patterns_from_buffer(char *buf, size_t size,
 			if (entry != buf + i && entry[0] != '#') {
 				buf[i - (i && buf[i-1] == '\r')] = 0;
 				trim_trailing_spaces(entry);
-				add_pattern(entry, base, baselen, pl, lineno);
+				add_pattern(entry, base, baselen, pl, lineno,
+					    disable_precious);
 			}
 			lineno++;
 			entry = buf + i + 1;
@@ -1307,7 +1317,7 @@ int add_patterns_from_blob_to_list(
 		return -1;
 	}
 
-	add_patterns_from_buffer(buf, size, base, baselen, pl);
+	add_patterns_from_buffer(buf, size, base, baselen, pl, 0);
 	free(buf);
 	return 0;
 }
diff --git a/dir.h b/dir.h
index 5cda2cdba7..a6977149b8 100644
--- a/dir.h
+++ b/dir.h
@@ -464,10 +464,11 @@ int add_patterns_from_blob_to_list(struct object_id *oid,
 				   struct pattern_list *pl);
 int add_patterns_from_buffer(char *buf, size_t size,
 			     const char *base, int baselen,
-			     struct pattern_list *pl);
+			     struct pattern_list *pl, int disable_precious);
 int parse_path_pattern(const char **string, int *patternlen, enum pattern_flags *flags, int *nowildcardlen);
 void add_pattern(const char *string, const char *base,
-		 int baselen, struct pattern_list *pl, int srcpos);
+		 int baselen, struct pattern_list *pl, int srcpos,
+		 int disable_precious);
 void clear_pattern_list(struct pattern_list *pl);
 void dir_clear(struct dir_struct *dir);
 
diff --git a/t/helper/test-path-walk.c b/t/helper/test-path-walk.c
index 4233badb58..fefe885ec6 100644
--- a/t/helper/test-path-walk.c
+++ b/t/helper/test-path-walk.c
@@ -124,7 +124,7 @@ int cmd__path_walk(int argc, const char **argv)
 		info.pl->use_cone_patterns = 1;
 
 		strbuf_fread(&in, 2048, stdin);
-		add_patterns_from_buffer(in.buf, in.len, "", 0, info.pl);
+		add_patterns_from_buffer(in.buf, in.len, "", 0, info.pl, 0);
 		strbuf_release(&in);
 	}
 
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 74b1761e0c..caae112037 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -252,6 +252,14 @@ test_expect_success 'sparse-checkout disable' '
 	check_files repo a deep folder1 folder2
 '
 
+test_expect_success 'skip precious-file pattern in $GIT_DIR/info/sparse-checkout' "
+	test_when_finished rm actual .git/info/sparse-checkout &&
+	test_when_finished git sparse-checkout disable &&
+	echo \"$/ciao\" > .git/info/sparse-checkout &&
+	git sparse-checkout init >actual 2>&1 &&
+	test_grep \"warning: '$/ciao' precious-files pattern not allowed here, skipping\" actual
+"
+
 test_expect_success 'sparse-index enabled and disabled' '
 	git -C repo sparse-checkout init --cone --sparse-index &&
 	test_cmp_config -C repo true index.sparse &&
-- 
2.56.0

