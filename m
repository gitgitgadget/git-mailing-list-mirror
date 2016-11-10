Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4575F20229
	for <e@80x24.org>; Thu, 10 Nov 2016 20:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965000AbcKJUeu (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 15:34:50 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35169 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933893AbcKJUet (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 15:34:49 -0500
Received: by mail-pf0-f175.google.com with SMTP id i88so151078961pfk.2
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 12:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UVSOfBr7SKKFvMbNVh0xgo8DWgpOP2+GACZHgsd2eXA=;
        b=omCR0I3HqHTqZS6V9HhlFLaRJs4qPecdaMbOup+T7lLvpT7/Yf74yTdU5Ym0ZQO0Iq
         4yXTc0YU2bxeklcLwQP34ukjnx0EfkXlfBszpeoYxB2tBNm7vvXbdPPpBsphLEWg27Ve
         CgsBc0Hhys6jDfDEgkncXJchKbwqak8qStRMPEocczLj+OWay1tmlsjLDSCCmP9+aAkc
         e6h/Zq87HBLTTUBMyI1cojvrff++XqWhbh1x9mGa/QVRsHc6baUlZXisEsy9BZIlg2Zs
         H9ak3EjbgfHUV6L2QDO1gpPg3MRpM9FO6aEUIQhEipF5Mun3O5EefvXXK/6MwBh1aodM
         gPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UVSOfBr7SKKFvMbNVh0xgo8DWgpOP2+GACZHgsd2eXA=;
        b=eM6Ers4K0IBqW5n9+FD9kgRqVKdzSOJIKclqEcU7NXzc9g13vFV7bYvJxd2N5ruNSM
         GH8Sl0cGn+IZb5YYct8z7wuh6IXNvWqU3qINmJf7J3x2YGOapAYioYIYlCvZwHvCdZqZ
         /6on7t97Tzen2UH7lYG5View6gBuYg9M55eVx//h6+RnklTGgtovGd78IlqaVHyCEGOP
         HGB6AAILB0zay7fb5z6dldVRDtJ844S5A1uzK7O39z7wW0Je9gmSPydnLdK097snRMMA
         Hc38tflPrpKbNM7dAuhag+VIjJMW4oh/mYpqVpnfWZj+eKTL77AwpvLQ5ja69+uHFZDG
         QVDQ==
X-Gm-Message-State: ABUngvdljhLdw3hB0tlwVELwnOy04jxTTKwBL2dqGMCbo52JWhh/Sl7g+YFBLNh4ioR14fap
X-Received: by 10.99.128.198 with SMTP id j189mr38681743pgd.151.1478810088007;
        Thu, 10 Nov 2016 12:34:48 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:b504:dcf8:965a:7ab8])
        by smtp.gmail.com with ESMTPSA id e90sm9357707pfd.5.2016.11.10.12.34.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Nov 2016 12:34:47 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com, pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 10/35] attr: rename function and struct related to checking attributes
Date:   Thu, 10 Nov 2016 12:34:03 -0800
Message-Id: <20161110203428.30512-11-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161110203428.30512-1-sbeller@google.com>
References: <20161110203428.30512-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

The traditional API to check attributes is to prepare an N-element
array of "struct git_attr_check" and pass N and the array to the
function "git_check_attr()" as arguments.

In preparation to revamp the API to pass a single structure, in
which these N elements are held, rename the type used for these
individual array elements to "struct git_attr_check_elem" and rename
the function to "git_check_attrs()".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 archive.c              |  6 +++---
 attr.c                 | 12 ++++++------
 attr.h                 |  8 ++++----
 builtin/check-attr.c   | 19 ++++++++++---------
 builtin/pack-objects.c |  6 +++---
 convert.c              | 12 ++++++------
 ll-merge.c             | 10 +++++-----
 userdiff.c             |  4 ++--
 ws.c                   |  6 +++---
 9 files changed, 42 insertions(+), 41 deletions(-)

diff --git a/archive.c b/archive.c
index dde1ab4..2dc8d6c 100644
--- a/archive.c
+++ b/archive.c
@@ -87,7 +87,7 @@ void *sha1_file_to_archive(const struct archiver_args *args,
 	return buffer;
 }
 
-static void setup_archive_check(struct git_attr_check *check)
+static void setup_archive_check(struct git_attr_check_elem *check)
 {
 	static struct git_attr *attr_export_ignore;
 	static struct git_attr *attr_export_subst;
@@ -123,7 +123,7 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 	struct archiver_context *c = context;
 	struct archiver_args *args = c->args;
 	write_archive_entry_fn_t write_entry = c->write_entry;
-	struct git_attr_check check[2];
+	struct git_attr_check_elem check[2];
 	const char *path_without_prefix;
 	int err;
 
@@ -138,7 +138,7 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 	path_without_prefix = path.buf + args->baselen;
 
 	setup_archive_check(check);
-	if (!git_check_attr(path_without_prefix, ARRAY_SIZE(check), check)) {
+	if (!git_check_attrs(path_without_prefix, ARRAY_SIZE(check), check)) {
 		if (ATTR_TRUE(check[0].value))
 			return 0;
 		args->convert = ATTR_TRUE(check[1].value);
diff --git a/attr.c b/attr.c
index 1877f7a..c99e23a 100644
--- a/attr.c
+++ b/attr.c
@@ -40,7 +40,7 @@ struct git_attr {
 static int attr_nr;
 static int cannot_trust_maybe_real;
 
-static struct git_attr_check *check_all_attr;
+static struct git_attr_check_elem *check_all_attr;
 static struct git_attr *(git_attr_hash[HASHSIZE]);
 
 const char *git_attr_name(const struct git_attr *attr)
@@ -665,7 +665,7 @@ static int macroexpand_one(int attr_nr, int rem);
 
 static int fill_one(const char *what, struct match_attr *a, int rem)
 {
-	struct git_attr_check *check = check_all_attr;
+	struct git_attr_check_elem *check = check_all_attr;
 	int i;
 
 	for (i = a->num_attr - 1; 0 < rem && 0 <= i; i--) {
@@ -730,7 +730,7 @@ static int macroexpand_one(int nr, int rem)
  * collected. Otherwise all attributes are collected.
  */
 static void collect_some_attrs(const char *path, int num,
-			       struct git_attr_check *check)
+			       struct git_attr_check_elem *check)
 
 {
 	struct attr_stack *stk;
@@ -758,7 +758,7 @@ static void collect_some_attrs(const char *path, int num,
 		rem = 0;
 		for (i = 0; i < num; i++) {
 			if (!check[i].attr->maybe_real) {
-				struct git_attr_check *c;
+				struct git_attr_check_elem *c;
 				c = check_all_attr + check[i].attr->attr_nr;
 				c->value = ATTR__UNSET;
 				rem++;
@@ -773,7 +773,7 @@ static void collect_some_attrs(const char *path, int num,
 		rem = fill(path, pathlen, basename_offset, stk, rem);
 }
 
-int git_check_attr(const char *path, int num, struct git_attr_check *check)
+int git_check_attrs(const char *path, int num, struct git_attr_check_elem *check)
 {
 	int i;
 
@@ -789,7 +789,7 @@ int git_check_attr(const char *path, int num, struct git_attr_check *check)
 	return 0;
 }
 
-int git_all_attrs(const char *path, int *num, struct git_attr_check **check)
+int git_all_attrs(const char *path, int *num, struct git_attr_check_elem **check)
 {
 	int i, count, j;
 
diff --git a/attr.h b/attr.h
index 00d7a66..dd3c4a3 100644
--- a/attr.h
+++ b/attr.h
@@ -20,11 +20,11 @@ extern const char git_attr__false[];
 #define ATTR_UNSET(v) ((v) == NULL)
 
 /*
- * Send one or more git_attr_check to git_check_attr(), and
+ * Send one or more git_attr_check to git_check_attrs(), and
  * each 'value' member tells what its value is.
  * Unset one is returned as NULL.
  */
-struct git_attr_check {
+struct git_attr_check_elem {
 	const struct git_attr *attr;
 	const char *value;
 };
@@ -36,7 +36,7 @@ struct git_attr_check {
  */
 extern const char *git_attr_name(const struct git_attr *);
 
-int git_check_attr(const char *path, int, struct git_attr_check *);
+int git_check_attrs(const char *path, int, struct git_attr_check_elem *);
 
 /*
  * Retrieve all attributes that apply to the specified path.  *num
@@ -45,7 +45,7 @@ int git_check_attr(const char *path, int, struct git_attr_check *);
  * objects describing the attributes and their values.  *check must be
  * free()ed by the caller.
  */
-int git_all_attrs(const char *path, int *num, struct git_attr_check **check);
+int git_all_attrs(const char *path, int *num, struct git_attr_check_elem **check);
 
 enum git_attr_direction {
 	GIT_ATTR_CHECKIN,
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 53a5a18..97e3837 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -24,8 +24,8 @@ static const struct option check_attr_options[] = {
 	OPT_END()
 };
 
-static void output_attr(int cnt, struct git_attr_check *check,
-	const char *file)
+static void output_attr(int cnt, struct git_attr_check_elem *check,
+			const char *file)
 {
 	int j;
 	for (j = 0; j < cnt; j++) {
@@ -51,14 +51,15 @@ static void output_attr(int cnt, struct git_attr_check *check,
 	}
 }
 
-static void check_attr(const char *prefix, int cnt,
-	struct git_attr_check *check, const char *file)
+static void check_attr(const char *prefix,
+		       int cnt, struct git_attr_check_elem *check,
+		       const char *file)
 {
 	char *full_path =
 		prefix_path(prefix, prefix ? strlen(prefix) : 0, file);
 	if (check != NULL) {
-		if (git_check_attr(full_path, cnt, check))
-			die("git_check_attr died");
+		if (git_check_attrs(full_path, cnt, check))
+			die("git_check_attrs died");
 		output_attr(cnt, check, file);
 	} else {
 		if (git_all_attrs(full_path, &cnt, &check))
@@ -69,8 +70,8 @@ static void check_attr(const char *prefix, int cnt,
 	free(full_path);
 }
 
-static void check_attr_stdin_paths(const char *prefix, int cnt,
-	struct git_attr_check *check)
+static void check_attr_stdin_paths(const char *prefix,
+				   int cnt, struct git_attr_check_elem *check)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf unquoted = STRBUF_INIT;
@@ -99,7 +100,7 @@ static NORETURN void error_with_usage(const char *msg)
 
 int cmd_check_attr(int argc, const char **argv, const char *prefix)
 {
-	struct git_attr_check *check;
+	struct git_attr_check_elem *check;
 	int cnt, i, doubledash, filei;
 
 	if (!is_bare_repository())
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1e7c2a9..3cb38ed 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -896,7 +896,7 @@ static void write_pack_file(void)
 			written, nr_result);
 }
 
-static void setup_delta_attr_check(struct git_attr_check *check)
+static void setup_delta_attr_check(struct git_attr_check_elem *check)
 {
 	static struct git_attr *attr_delta;
 
@@ -908,10 +908,10 @@ static void setup_delta_attr_check(struct git_attr_check *check)
 
 static int no_try_delta(const char *path)
 {
-	struct git_attr_check check[1];
+	struct git_attr_check_elem check[1];
 
 	setup_delta_attr_check(check);
-	if (git_check_attr(path, ARRAY_SIZE(check), check))
+	if (git_check_attrs(path, ARRAY_SIZE(check), check))
 		return 0;
 	if (ATTR_FALSE(check->value))
 		return 1;
diff --git a/convert.c b/convert.c
index 077f5e6..c95ae71 100644
--- a/convert.c
+++ b/convert.c
@@ -718,7 +718,7 @@ static int ident_to_worktree(const char *path, const char *src, size_t len,
 	return 1;
 }
 
-static enum crlf_action git_path_check_crlf(struct git_attr_check *check)
+static enum crlf_action git_path_check_crlf(struct git_attr_check_elem *check)
 {
 	const char *value = check->value;
 
@@ -735,7 +735,7 @@ static enum crlf_action git_path_check_crlf(struct git_attr_check *check)
 	return CRLF_UNDEFINED;
 }
 
-static enum eol git_path_check_eol(struct git_attr_check *check)
+static enum eol git_path_check_eol(struct git_attr_check_elem *check)
 {
 	const char *value = check->value;
 
@@ -748,7 +748,7 @@ static enum eol git_path_check_eol(struct git_attr_check *check)
 	return EOL_UNSET;
 }
 
-static struct convert_driver *git_path_check_convert(struct git_attr_check *check)
+static struct convert_driver *git_path_check_convert(struct git_attr_check_elem *check)
 {
 	const char *value = check->value;
 	struct convert_driver *drv;
@@ -761,7 +761,7 @@ static struct convert_driver *git_path_check_convert(struct git_attr_check *chec
 	return NULL;
 }
 
-static int git_path_check_ident(struct git_attr_check *check)
+static int git_path_check_ident(struct git_attr_check_elem *check)
 {
 	const char *value = check->value;
 
@@ -783,7 +783,7 @@ static const char *conv_attr_name[] = {
 static void convert_attrs(struct conv_attrs *ca, const char *path)
 {
 	int i;
-	static struct git_attr_check ccheck[NUM_CONV_ATTRS];
+	static struct git_attr_check_elem ccheck[NUM_CONV_ATTRS];
 
 	if (!ccheck[0].attr) {
 		for (i = 0; i < NUM_CONV_ATTRS; i++)
@@ -792,7 +792,7 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 		git_config(read_convert_config, NULL);
 	}
 
-	if (!git_check_attr(path, NUM_CONV_ATTRS, ccheck)) {
+	if (!git_check_attrs(path, NUM_CONV_ATTRS, ccheck)) {
 		ca->crlf_action = git_path_check_crlf(ccheck + 4);
 		if (ca->crlf_action == CRLF_UNDEFINED)
 			ca->crlf_action = git_path_check_crlf(ccheck + 0);
diff --git a/ll-merge.c b/ll-merge.c
index ad8be42..eb2c37e 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -336,13 +336,13 @@ static const struct ll_merge_driver *find_ll_merge_driver(const char *merge_attr
 	return &ll_merge_drv[LL_TEXT_MERGE];
 }
 
-static int git_path_check_merge(const char *path, struct git_attr_check check[2])
+static int git_path_check_merge(const char *path, struct git_attr_check_elem check[2])
 {
 	if (!check[0].attr) {
 		check[0].attr = git_attr("merge");
 		check[1].attr = git_attr("conflict-marker-size");
 	}
-	return git_check_attr(path, 2, check);
+	return git_check_attrs(path, 2, check);
 }
 
 static void normalize_file(mmfile_t *mm, const char *path)
@@ -362,7 +362,7 @@ int ll_merge(mmbuffer_t *result_buf,
 	     mmfile_t *theirs, const char *their_label,
 	     const struct ll_merge_options *opts)
 {
-	static struct git_attr_check check[2];
+	static struct git_attr_check_elem check[2];
 	static const struct ll_merge_options default_opts;
 	const char *ll_driver_name = NULL;
 	int marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
@@ -398,12 +398,12 @@ int ll_merge(mmbuffer_t *result_buf,
 
 int ll_merge_marker_size(const char *path)
 {
-	static struct git_attr_check check;
+	static struct git_attr_check_elem check;
 	int marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
 
 	if (!check.attr)
 		check.attr = git_attr("conflict-marker-size");
-	if (!git_check_attr(path, 1, &check) && check.value) {
+	if (!git_check_attrs(path, 1, &check) && check.value) {
 		marker_size = atoi(check.value);
 		if (marker_size <= 0)
 			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
diff --git a/userdiff.c b/userdiff.c
index 2125d6d..4de3289 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -263,7 +263,7 @@ struct userdiff_driver *userdiff_find_by_name(const char *name) {
 struct userdiff_driver *userdiff_find_by_path(const char *path)
 {
 	static struct git_attr *attr;
-	struct git_attr_check check;
+	struct git_attr_check_elem check;
 
 	if (!attr)
 		attr = git_attr("diff");
@@ -271,7 +271,7 @@ struct userdiff_driver *userdiff_find_by_path(const char *path)
 
 	if (!path)
 		return NULL;
-	if (git_check_attr(path, 1, &check))
+	if (git_check_attrs(path, 1, &check))
 		return NULL;
 
 	if (ATTR_TRUE(check.value))
diff --git a/ws.c b/ws.c
index ea4b2b1..7350905 100644
--- a/ws.c
+++ b/ws.c
@@ -71,7 +71,7 @@ unsigned parse_whitespace_rule(const char *string)
 	return rule;
 }
 
-static void setup_whitespace_attr_check(struct git_attr_check *check)
+static void setup_whitespace_attr_check(struct git_attr_check_elem *check)
 {
 	static struct git_attr *attr_whitespace;
 
@@ -82,10 +82,10 @@ static void setup_whitespace_attr_check(struct git_attr_check *check)
 
 unsigned whitespace_rule(const char *pathname)
 {
-	struct git_attr_check attr_whitespace_rule;
+	struct git_attr_check_elem attr_whitespace_rule;
 
 	setup_whitespace_attr_check(&attr_whitespace_rule);
-	if (!git_check_attr(pathname, 1, &attr_whitespace_rule)) {
+	if (!git_check_attrs(pathname, 1, &attr_whitespace_rule)) {
 		const char *value;
 
 		value = attr_whitespace_rule.value;
-- 
2.10.1.469.g00a8914

