Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6A6D1FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 23:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750805AbdALXzi (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 18:55:38 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33155 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750808AbdALXz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 18:55:26 -0500
Received: by mail-pf0-f173.google.com with SMTP id y143so20696260pfb.0
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 15:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0+OnzZ/c/+xutf0CbQPr5ezoSFQQEwr/j/iNRKr+KbU=;
        b=oBfQJGb25hRWcuga30QesSeBPmnROz5q+SMKnjUTaR1d20GpbUM3vZs5Y8EOSLEq6J
         hpkgrDl/eHYJ/Q+FwPkdge3h508Dp7rlaxKcxQ7dRX5TiyP5N0+8FIuna36TqEmLZWFG
         9L6TR/udDl19W+6ycrjg3QOB9lSi6YdLKc+1zLBn0R5AGpzz/WlimOUB4qXdSOi0b7DA
         eciCo7nlIMjBRewLmiJIRlyZx/vLIbRO9rqqEU5lNsm2q2VIjuade5uAsE+6RZMTPknt
         UviIpKKUPe/26eDSj9HdTMnZurBH3HEGKZ2QKTcaJlg2JNgtZhQSDMYtz21PqyNmf5w9
         QnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0+OnzZ/c/+xutf0CbQPr5ezoSFQQEwr/j/iNRKr+KbU=;
        b=OgqyuFp2LIsswCTteJmpWYcMGyIUjMM23zuQpTZMrAL175Twd99Ak6Z9Teze35EZZJ
         F0AtZiQatik6uSAt6BnetTp3UPc03Q3gYmLxFNFQ0V+pHgZeio6B/0qtyk/i6wY5dYLA
         oHC7DAWqxZNbEOt49PW9LmED3LaJZgJOuFMqy8aYn4UoJfRHMvUDuqj6P6fT8Vv/IGJj
         0UDMMqLfbePRdpN6wdW31t8lcreZfxVP8V4svMpnoQNr1NYnMO0xegIc17j52k4BuO1j
         0hHhP3X9KPqdLmdmUtLCkBnOIldTOfNkj6pJHZ0fKWSKy568c3QQFkd0XFx3oCVA2d0E
         W8uQ==
X-Gm-Message-State: AIkVDXJ7cE5JSZXBsPDyK+rextJiCMxFELwv83Pvb7/zaPwjVjY8/LtsWaKKWuI17lId9Bdr
X-Received: by 10.99.217.21 with SMTP id r21mr20562067pgg.78.1484265268556;
        Thu, 12 Jan 2017 15:54:28 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id e6sm24312192pgf.4.2017.01.12.15.54.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jan 2017 15:54:27 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, pclouds@gmail.com,
        sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 17/27] attr: convert git_check_attrs() callers to use the new API
Date:   Thu, 12 Jan 2017 15:53:44 -0800
Message-Id: <20170112235354.153403-18-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170112235354.153403-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

The remaining callers are all simple "I have N attributes I am
interested in.  I'll ask about them with various paths one by one".

After this step, no caller to git_check_attrs() remains.  After
removing it, we can extend "struct attr_check" struct with data
that can be used in optimizing the query for the specific N
attributes it contains.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 archive.c              | 24 ++++++------------------
 builtin/pack-objects.c | 19 +++++--------------
 convert.c              | 17 ++++++-----------
 ll-merge.c             | 33 ++++++++++++++-------------------
 userdiff.c             | 19 ++++++++-----------
 ws.c                   | 19 ++++++-------------
 6 files changed, 45 insertions(+), 86 deletions(-)

diff --git a/archive.c b/archive.c
index b76bd4691..3591f7d55 100644
--- a/archive.c
+++ b/archive.c
@@ -87,19 +87,6 @@ void *sha1_file_to_archive(const struct archiver_args *args,
 	return buffer;
 }
 
-static void setup_archive_check(struct attr_check_item *check)
-{
-	static struct git_attr *attr_export_ignore;
-	static struct git_attr *attr_export_subst;
-
-	if (!attr_export_ignore) {
-		attr_export_ignore = git_attr("export-ignore");
-		attr_export_subst = git_attr("export-subst");
-	}
-	check[0].attr = attr_export_ignore;
-	check[1].attr = attr_export_subst;
-}
-
 struct directory {
 	struct directory *up;
 	struct object_id oid;
@@ -120,10 +107,10 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 		void *context)
 {
 	static struct strbuf path = STRBUF_INIT;
+	static struct attr_check *check;
 	struct archiver_context *c = context;
 	struct archiver_args *args = c->args;
 	write_archive_entry_fn_t write_entry = c->write_entry;
-	struct attr_check_item check[2];
 	const char *path_without_prefix;
 	int err;
 
@@ -137,11 +124,12 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 		strbuf_addch(&path, '/');
 	path_without_prefix = path.buf + args->baselen;
 
-	setup_archive_check(check);
-	if (!git_check_attrs(path_without_prefix, ARRAY_SIZE(check), check)) {
-		if (ATTR_TRUE(check[0].value))
+	if (!check)
+		check = attr_check_initl("export-ignore", "export-subst", NULL);
+	if (!git_check_attr(path_without_prefix, check)) {
+		if (ATTR_TRUE(check->check[0].value))
 			return 0;
-		args->convert = ATTR_TRUE(check[1].value);
+		args->convert = ATTR_TRUE(check->check[1].value);
 	}
 
 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 8b8fbd814..ff8b3c12d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -894,24 +894,15 @@ static void write_pack_file(void)
 			written, nr_result);
 }
 
-static void setup_delta_attr_check(struct attr_check_item *check)
-{
-	static struct git_attr *attr_delta;
-
-	if (!attr_delta)
-		attr_delta = git_attr("delta");
-
-	check[0].attr = attr_delta;
-}
-
 static int no_try_delta(const char *path)
 {
-	struct attr_check_item check[1];
+	static struct attr_check *check;
 
-	setup_delta_attr_check(check);
-	if (git_check_attrs(path, ARRAY_SIZE(check), check))
+	if (!check)
+		check = attr_check_initl("delta", NULL);
+	if (git_check_attr(path, check))
 		return 0;
-	if (ATTR_FALSE(check->value))
+	if (ATTR_FALSE(check->check[0].value))
 		return 1;
 	return 0;
 }
diff --git a/convert.c b/convert.c
index 1b9829279..affd8ce9b 100644
--- a/convert.c
+++ b/convert.c
@@ -1085,24 +1085,19 @@ struct conv_attrs {
 	int ident;
 };
 
-static const char *conv_attr_name[] = {
-	"crlf", "ident", "filter", "eol", "text",
-};
-#define NUM_CONV_ATTRS ARRAY_SIZE(conv_attr_name)
-
 static void convert_attrs(struct conv_attrs *ca, const char *path)
 {
-	int i;
-	static struct attr_check_item ccheck[NUM_CONV_ATTRS];
+	static struct attr_check *check;
 
-	if (!ccheck[0].attr) {
-		for (i = 0; i < NUM_CONV_ATTRS; i++)
-			ccheck[i].attr = git_attr(conv_attr_name[i]);
+	if (!check) {
+		check = attr_check_initl("crlf", "ident", "filter",
+					 "eol", "text", NULL);
 		user_convert_tail = &user_convert;
 		git_config(read_convert_config, NULL);
 	}
 
-	if (!git_check_attrs(path, NUM_CONV_ATTRS, ccheck)) {
+	if (!git_check_attr(path, check)) {
+		struct attr_check_item *ccheck = check->check;
 		ca->crlf_action = git_path_check_crlf(ccheck + 4);
 		if (ca->crlf_action == CRLF_UNDEFINED)
 			ca->crlf_action = git_path_check_crlf(ccheck + 0);
diff --git a/ll-merge.c b/ll-merge.c
index 198f07aca..3a4227a1c 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -336,15 +336,6 @@ static const struct ll_merge_driver *find_ll_merge_driver(const char *merge_attr
 	return &ll_merge_drv[LL_TEXT_MERGE];
 }
 
-static int git_path_check_merge(const char *path, struct attr_check_item check[2])
-{
-	if (!check[0].attr) {
-		check[0].attr = git_attr("merge");
-		check[1].attr = git_attr("conflict-marker-size");
-	}
-	return git_check_attrs(path, 2, check);
-}
-
 static void normalize_file(mmfile_t *mm, const char *path)
 {
 	struct strbuf strbuf = STRBUF_INIT;
@@ -362,7 +353,7 @@ int ll_merge(mmbuffer_t *result_buf,
 	     mmfile_t *theirs, const char *their_label,
 	     const struct ll_merge_options *opts)
 {
-	static struct attr_check_item check[2];
+	static struct attr_check *check;
 	static const struct ll_merge_options default_opts;
 	const char *ll_driver_name = NULL;
 	int marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
@@ -376,10 +367,14 @@ int ll_merge(mmbuffer_t *result_buf,
 		normalize_file(ours, path);
 		normalize_file(theirs, path);
 	}
-	if (!git_path_check_merge(path, check)) {
-		ll_driver_name = check[0].value;
-		if (check[1].value) {
-			marker_size = atoi(check[1].value);
+
+	if (!check)
+		check = attr_check_initl("merge", "conflict-marker-size", NULL);
+
+	if (!git_check_attr(path, check)) {
+		ll_driver_name = check->check[0].value;
+		if (check->check[1].value) {
+			marker_size = atoi(check->check[1].value);
 			if (marker_size <= 0)
 				marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
 		}
@@ -398,13 +393,13 @@ int ll_merge(mmbuffer_t *result_buf,
 
 int ll_merge_marker_size(const char *path)
 {
-	static struct attr_check_item check;
+	static struct attr_check *check;
 	int marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
 
-	if (!check.attr)
-		check.attr = git_attr("conflict-marker-size");
-	if (!git_check_attrs(path, 1, &check) && check.value) {
-		marker_size = atoi(check.value);
+	if (!check)
+		check = attr_check_initl("conflict-marker-size", NULL);
+	if (!git_check_attr(path, check) && check->check[0].value) {
+		marker_size = atoi(check->check[0].value);
 		if (marker_size <= 0)
 			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
 	}
diff --git a/userdiff.c b/userdiff.c
index b0b44467a..109d4b9fc 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -262,25 +262,22 @@ struct userdiff_driver *userdiff_find_by_name(const char *name) {
 
 struct userdiff_driver *userdiff_find_by_path(const char *path)
 {
-	static struct git_attr *attr;
-	struct attr_check_item check;
-
-	if (!attr)
-		attr = git_attr("diff");
-	check.attr = attr;
+	static struct attr_check *check;
 
+	if (!check)
+		check = attr_check_initl("diff", NULL);
 	if (!path)
 		return NULL;
-	if (git_check_attrs(path, 1, &check))
+	if (git_check_attr(path, check))
 		return NULL;
 
-	if (ATTR_TRUE(check.value))
+	if (ATTR_TRUE(check->check[0].value))
 		return &driver_true;
-	if (ATTR_FALSE(check.value))
+	if (ATTR_FALSE(check->check[0].value))
 		return &driver_false;
-	if (ATTR_UNSET(check.value))
+	if (ATTR_UNSET(check->check[0].value))
 		return NULL;
-	return userdiff_find_by_name(check.value);
+	return userdiff_find_by_name(check->check[0].value);
 }
 
 struct userdiff_driver *userdiff_get_textconv(struct userdiff_driver *driver)
diff --git a/ws.c b/ws.c
index fbd876e84..7556adbd0 100644
--- a/ws.c
+++ b/ws.c
@@ -71,24 +71,17 @@ unsigned parse_whitespace_rule(const char *string)
 	return rule;
 }
 
-static void setup_whitespace_attr_check(struct attr_check_item *check)
-{
-	static struct git_attr *attr_whitespace;
-
-	if (!attr_whitespace)
-		attr_whitespace = git_attr("whitespace");
-	check[0].attr = attr_whitespace;
-}
-
 unsigned whitespace_rule(const char *pathname)
 {
-	struct attr_check_item attr_whitespace_rule;
+	static struct attr_check *attr_whitespace_rule;
+
+	if (!attr_whitespace_rule)
+		attr_whitespace_rule = attr_check_initl("whitespace", NULL);
 
-	setup_whitespace_attr_check(&attr_whitespace_rule);
-	if (!git_check_attrs(pathname, 1, &attr_whitespace_rule)) {
+	if (!git_check_attr(pathname, attr_whitespace_rule)) {
 		const char *value;
 
-		value = attr_whitespace_rule.value;
+		value = attr_whitespace_rule->check[0].value;
 		if (ATTR_TRUE(value)) {
 			/* true (whitespace) */
 			unsigned all_rule = ws_tab_width(whitespace_rule_cfg);
-- 
2.11.0.390.gc69c2f50cf-goog

