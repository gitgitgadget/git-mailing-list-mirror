Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88103C43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 07:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E00920772
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 07:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQcE6bjw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731885AbgDAHaZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 03:30:25 -0400
Received: from mail-qv1-f47.google.com ([209.85.219.47]:35326 "EHLO
        mail-qv1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731680AbgDAHaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 03:30:25 -0400
Received: by mail-qv1-f47.google.com with SMTP id q73so12340879qvq.2
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 00:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lz34pCkALQ+PeFbRbx83AnmToW+xYIHszcCnScw5ktQ=;
        b=GQcE6bjwH8EL366dJH7laG7VjXXRej9aKeVrtzPQ6EzuReHMVcRKRwzDXAEvAepzk/
         vH6IYK+2dwn1MnobiYPc/SXeuPXjHI6fm604F2r+J1KmUqnG6Mr/PPrXorEhWaI+j+Q9
         9dQUHBmt7X0zIMBLnawqiWKK3yFCJrq6sGr9vwZj+W4eza3lV5HCAalHRrQofDkX6P91
         rACy++1Maacdy2PSrcn9WRJK6dfHM99n8lfmwfz7moBhW5q0MIL4Vf9fYZVLU3q/Gfsj
         sEsMHkJ4CkGCVdYXMW4yCMl1ynsAI5RLSyxDpFOk5c8ZI6b7SBytOGsnK1Az9YYPA/Ef
         +uXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lz34pCkALQ+PeFbRbx83AnmToW+xYIHszcCnScw5ktQ=;
        b=VOplEQxiwvttmy9plujXSIwdEqHMTfLuuGYYdickaeNTEI3+8j22w/wzHYIJ9UE7a9
         pvpqZl98JmZqH6mhGPFt1Agt7QBMjS0mO4APTTACX/wUhh/UXKA7+p4wEV+WkUltYaxE
         3F8lM6wF5KdNHkYHdE5+D/339Aloo9rVutpLgF26QlZEqPEPMjm9crKabJAPfKKyykeK
         NpGV7c89fJ/hdRHVbiB2cfs+0NgnvFH4ovM/Dp+7AjBUd90bLEE0ZXsLT6T9knPRyS/m
         Y46xkwFAOakh+42NtnB1R0m8dq6Gsg4twhcZWTmN1tgYS32JXO16LyD9A9YLdOdibuyl
         LySQ==
X-Gm-Message-State: ANhLgQ2rv2LqCMTcTZzdwLAh+BcDDTQaKTu8Z6dUVNU87H375Cl+GsMB
        vMKRLg4g5FPjFC7F+WUDZkakMCQb
X-Google-Smtp-Source: ADFU+vsINnd3S1vT5OTu4hxRBP+rLV8IekfDe28RycPJ1BCqCYO7QRC8WUutYuRjS3nOs/SRnzW9fw==
X-Received: by 2002:a0c:e886:: with SMTP id b6mr20099404qvo.31.1585726222934;
        Wed, 01 Apr 2020 00:30:22 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id m53sm1004247qta.15.2020.04.01.00.30.21
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 00:30:22 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] Fix -Wmaybe-uninitialized warnings under -O0
Date:   Wed,  1 Apr 2020 03:30:16 -0400
Message-Id: <33984eeaabbfbcfd4b9d3903549d8b7d6c4ced7e.1585726172.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When compiling Git under -O0, gcc (Arch Linux 9.3.0-1) 9.3.0 produces
many -Wmaybe-uninitialized warnings. These are false positives since
when Git is compiled under -O2, gcc is smart enough to see that the
code paths that use these variables all initialise them beforehand.
Nonetheless, these warnings block the compilation process when
DEVELOPER=1 is enabled (which enables -Werror).

Fix these warnings by initializing these variables with dummy values (0,
-1 or NULL as appropriate).

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/branch.c          | 2 +-
 diff.c                    | 2 +-
 fast-import.c             | 4 ++--
 http-backend.c            | 2 +-
 ref-filter.c              | 2 +-
 refs/packed-backend.c     | 2 +-
 t/helper/test-ref-store.c | 2 +-
 trace2/tr2_dst.c          | 2 +-
 trailer.c                 | 2 +-
 9 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index d8297f80ff..3669fba546 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -455,7 +455,7 @@ static void print_current_branch_name(void)
 {
 	int flags;
 	const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, &flags);
-	const char *shortname;
+	const char *shortname = NULL;
 	if (!refname)
 		die(_("could not resolve HEAD"));
 	else if (!(flags & REF_ISSYMREF))
diff --git a/diff.c b/diff.c
index f2cfbf2214..99a35774d7 100644
--- a/diff.c
+++ b/diff.c
@@ -3263,7 +3263,7 @@ static void emit_binary_diff_body(struct diff_options *o,
 	void *delta;
 	void *deflated;
 	void *data;
-	unsigned long orig_size;
+	unsigned long orig_size = 0;
 	unsigned long delta_size;
 	unsigned long deflate_size;
 	unsigned long data_size;
diff --git a/fast-import.c b/fast-import.c
index b8b65a801c..0509c0b92f 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1829,7 +1829,7 @@ static void parse_original_identifier(void)
 
 static int parse_data(struct strbuf *sb, uintmax_t limit, uintmax_t *len_res)
 {
-	const char *data;
+	const char *data = NULL;
 	strbuf_reset(sb);
 
 	if (!skip_prefix(command_buf.buf, "data ", &data))
@@ -2719,7 +2719,7 @@ static void parse_new_commit(const char *arg)
 static void parse_new_tag(const char *arg)
 {
 	static struct strbuf msg = STRBUF_INIT;
-	const char *from;
+	const char *from = NULL;
 	char *tagger;
 	struct branch *s;
 	struct tag *t;
diff --git a/http-backend.c b/http-backend.c
index ec3144b444..1091cdf2cd 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -252,7 +252,7 @@ static void http_config(void)
 
 static struct rpc_service *select_service(struct strbuf *hdr, const char *name)
 {
-	const char *svc_name;
+	const char *svc_name = NULL;
 	struct rpc_service *svc = NULL;
 	int i;
 
diff --git a/ref-filter.c b/ref-filter.c
index b1812cb69a..6abd48f81a 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1938,7 +1938,7 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 {
 	struct string_list prefixes = STRING_LIST_INIT_DUP;
 	struct string_list_item *prefix;
-	int ret;
+	int ret = 0;
 
 	if (!filter->match_as_path) {
 		/*
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 4458a0f69c..f37c6d19a6 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -627,7 +627,7 @@ static struct snapshot *create_snapshot(struct packed_ref_store *refs)
 
 	/* If the file has a header line, process it: */
 	if (snapshot->buf < snapshot->eof && *snapshot->buf == '#') {
-		char *tmp, *p, *eol;
+		char *tmp, *p = NULL, *eol;
 		struct string_list traits = STRING_LIST_INIT_NODUP;
 
 		eol = memchr(snapshot->buf, '\n',
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 799fc00aa1..d82dcb83a3 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -19,7 +19,7 @@ static unsigned int arg_flags(const char *arg, const char *name)
 
 static const char **get_store(const char **argv, struct ref_store **refs)
 {
-	const char *gitdir;
+	const char *gitdir = NULL;
 
 	if (!argv[0]) {
 		die("ref store required");
diff --git a/trace2/tr2_dst.c b/trace2/tr2_dst.c
index ae052a07fe..910301a53d 100644
--- a/trace2/tr2_dst.c
+++ b/trace2/tr2_dst.c
@@ -227,7 +227,7 @@ static int tr2_dst_try_unix_domain_socket(struct tr2_dst *dst,
 {
 	unsigned int uds_try = 0;
 	int fd;
-	int e;
+	int e = 0;
 	const char *path = NULL;
 
 	/*
diff --git a/trailer.c b/trailer.c
index 0c414f2fed..cac9d0a4d9 100644
--- a/trailer.c
+++ b/trailer.c
@@ -507,7 +507,7 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
 	struct arg_item *item;
 	struct conf_info *conf;
 	char *name = NULL;
-	enum trailer_info_type type;
+	enum trailer_info_type type = -1;
 	int i;
 
 	if (!skip_prefix(conf_key, "trailer.", &trailer_item))
-- 
2.26.0.159.g23e2136ad0

