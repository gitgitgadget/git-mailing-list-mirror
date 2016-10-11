Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4C7A20989
	for <e@80x24.org>; Tue, 11 Oct 2016 00:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752803AbcJKAVw (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 20:21:52 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35464 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752739AbcJKAVq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 20:21:46 -0400
Received: by mail-pa0-f51.google.com with SMTP id qn10so3905025pac.2
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 17:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0e/mXsce6MTNECk5WH9x+I7A29fa6jgb9MDugmd5wmo=;
        b=l7+H4HqR3mI8gD9aT1b6IPXBpr8e6IctGWCWwIxRGoEo3z3ZuciMwamXWOI2puCnN5
         fkOTlCH/BQ6Bc4+AqIczIbWXk016ND7faBEx5+GA0jTr7ii8v/xVHmGIvl5GEY3WOEB1
         MPXmbTMk+XwPaUbBJpiT1jBFNBOu2mmpjIZUmCDy8Hj2Zd9MDQEWzyz4c9GNAjSYNzNL
         7p3LRsq3qmtiv0IiBnWMu1lqRJI61lj8c07N9PSPHbqlQrhw62O2OcXXbZTRlorXp8Ry
         yWuIZubrxOETftMvVeEv3qe91pg5XrjVPUQ/G6rKEcGrn1QsQa6GKL3s51BD2Nq+oXCu
         BVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0e/mXsce6MTNECk5WH9x+I7A29fa6jgb9MDugmd5wmo=;
        b=RA0rrK1n1Iyhcd1S0lvl3ECwaHx5Cv66VzoZl95Y48/ynyJiQIMVVwqVxcdL8cWxy5
         OtW+5RJESCTCXsoaJ2RnCfdVfhIQ2ihEu9PJ/ItrNw0UZrTgYA0ch2vUekRe2GwhSCqH
         o2LhdaPoaIMJRyXNvbWDP+GDp1s4pKGLdFzkDZYUHXKEY5Ba81TvyCofAlkijRoI8lkL
         eKITuSDit9Wu2box3yCx+3v2aLMIRZ7yQ2+vvcoI1FuuHyARxZRwYsX+eEnhcxTIRx33
         9QDWyPlnrcuY+AeM8Yl4eZtBXmuCaI3nlQKTGjpdoO5IhQ3o6dBrmptQBDtSfMqnCCCy
         MxIQ==
X-Gm-Message-State: AA6/9RlDdRo3CkV8PxHan5WUuezU9Loay72YCa+Ao6HfoLsIbnqRZAxBvh2ldTtoOyWWOOV5
X-Received: by 10.66.141.134 with SMTP id ro6mr1761210pab.14.1476145305856;
        Mon, 10 Oct 2016 17:21:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b8ee:61f5:e989:77a7])
        by smtp.gmail.com with ESMTPSA id xv9sm500384pab.36.2016.10.10.17.21.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Oct 2016 17:21:45 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 13/28] attr: convert git_check_attrs() callers to use the new API
Date:   Mon, 10 Oct 2016 17:21:00 -0700
Message-Id: <20161011002115.23312-14-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.382.ga23ca1b.dirty
In-Reply-To: <20161011002115.23312-1-sbeller@google.com>
References: <20161011002115.23312-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

The remaining callers are all simple "I have N attributes I am
interested in.  I'll ask about them with various paths one by one".

After this step, no caller to git_check_attrs() remains.  After
removing it, we can extend "struct git_attr_check" struct with data
that can be used in optimizing the query for the specific N
attributes it contains.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/pack-objects.c | 19 +++++--------------
 convert.c              | 18 +++++++-----------
 ll-merge.c             | 33 ++++++++++++++-------------------
 userdiff.c             | 19 ++++++++-----------
 ws.c                   | 19 ++++++-------------
 5 files changed, 40 insertions(+), 68 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 9df2b08..df4e6b6 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -895,24 +895,15 @@ static void write_pack_file(void)
 			written, nr_result);
 }
 
-static void setup_delta_attr_check(struct git_attr_check_elem *check)
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
-	struct git_attr_check_elem check[1];
+	static struct git_attr_check *check;
 
-	setup_delta_attr_check(check);
-	if (git_check_attrs(path, ARRAY_SIZE(check), check))
+	if (!check)
+		check = git_attr_check_initl("delta", NULL);
+	if (git_check_attr(path, check))
 		return 0;
-	if (ATTR_FALSE(check->value))
+	if (ATTR_FALSE(check->check[0].value))
 		return 1;
 	return 0;
 }
diff --git a/convert.c b/convert.c
index c95ae71..bb2435a 100644
--- a/convert.c
+++ b/convert.c
@@ -775,24 +775,20 @@ struct conv_attrs {
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
-	static struct git_attr_check_elem ccheck[NUM_CONV_ATTRS];
+	static struct git_attr_check *check;
 
-	if (!ccheck[0].attr) {
-		for (i = 0; i < NUM_CONV_ATTRS; i++)
-			ccheck[i].attr = git_attr(conv_attr_name[i]);
+	if (!check) {
+		check = git_attr_check_initl("crlf", "ident",
+					     "filter", "eol", "text",
+					     NULL);
 		user_convert_tail = &user_convert;
 		git_config(read_convert_config, NULL);
 	}
 
-	if (!git_check_attrs(path, NUM_CONV_ATTRS, ccheck)) {
+	if (!git_check_attr(path, check)) {
+		struct git_attr_check_elem *ccheck = check->check;
 		ca->crlf_action = git_path_check_crlf(ccheck + 4);
 		if (ca->crlf_action == CRLF_UNDEFINED)
 			ca->crlf_action = git_path_check_crlf(ccheck + 0);
diff --git a/ll-merge.c b/ll-merge.c
index eb2c37e..bc6479c 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -336,15 +336,6 @@ static const struct ll_merge_driver *find_ll_merge_driver(const char *merge_attr
 	return &ll_merge_drv[LL_TEXT_MERGE];
 }
 
-static int git_path_check_merge(const char *path, struct git_attr_check_elem check[2])
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
-	static struct git_attr_check_elem check[2];
+	static struct git_attr_check *check;
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
+		check = git_attr_check_initl("merge", "conflict-marker-size", NULL);
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
-	static struct git_attr_check_elem check;
+	static struct git_attr_check *check;
 	int marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
 
-	if (!check.attr)
-		check.attr = git_attr("conflict-marker-size");
-	if (!git_check_attrs(path, 1, &check) && check.value) {
-		marker_size = atoi(check.value);
+	if (!check)
+		check = git_attr_check_initl("conflict-marker-size", NULL);
+	if (!git_check_attr(path, check) && check->check[0].value) {
+		marker_size = atoi(check->check[0].value);
 		if (marker_size <= 0)
 			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
 	}
diff --git a/userdiff.c b/userdiff.c
index 4de3289..46dfd32 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -262,25 +262,22 @@ struct userdiff_driver *userdiff_find_by_name(const char *name) {
 
 struct userdiff_driver *userdiff_find_by_path(const char *path)
 {
-	static struct git_attr *attr;
-	struct git_attr_check_elem check;
-
-	if (!attr)
-		attr = git_attr("diff");
-	check.attr = attr;
+	static struct git_attr_check *check;
 
+	if (!check)
+		check = git_attr_check_initl("diff", NULL);
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
index 7350905..bb3270c 100644
--- a/ws.c
+++ b/ws.c
@@ -71,24 +71,17 @@ unsigned parse_whitespace_rule(const char *string)
 	return rule;
 }
 
-static void setup_whitespace_attr_check(struct git_attr_check_elem *check)
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
-	struct git_attr_check_elem attr_whitespace_rule;
+	static struct git_attr_check *attr_whitespace_rule;
+
+	if (!attr_whitespace_rule)
+		attr_whitespace_rule = git_attr_check_initl("whitespace", NULL);
 
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
2.10.1.382.ga23ca1b.dirty

