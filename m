Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B94F820986
	for <e@80x24.org>; Sat, 22 Oct 2016 23:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965141AbcJVXeI (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 19:34:08 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:37126 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935144AbcJVXc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 19:32:58 -0400
Received: by mail-it0-f53.google.com with SMTP id m138so74585644itm.0
        for <git@vger.kernel.org>; Sat, 22 Oct 2016 16:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MTX34A+6jnFtsUKRYNrDDe5xpaAbO2D1Kz4kVj91F30=;
        b=CEFPnzWDs6e5ciC2buhTIIRz107ZlImfZba3F/N80jy4k546pfviujLz/c7uaCDt6K
         +zUFl22HmvdW5TpFijMw9p4Rpb5xH5UoeRDaspgW+KxAeFQWg5ceX/gK4cebdxAN9tKz
         Ag0OaeXH3oSO04hSHoLip4WmLagvHcjWUvO6DCwkruxMR9dMEDI3O4cOGKeY9k45w3xa
         cjtXtblw98qgZ4aX2Ysgc02DS00WghDf1h3Nnub9tQMrYCw/StWh/hAl+Xxun0YuPsoK
         6WDOKWsvjl0VieLxAHRQFsVmBVarx3h7MIYgX+qjaCREC2MYe4n+A0bQWXKjiingx7TN
         /oIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MTX34A+6jnFtsUKRYNrDDe5xpaAbO2D1Kz4kVj91F30=;
        b=ILJDuzdHWzStMh9Rn3URxCF89p/XQka7f1lssbS/ICIsk7GEZadWYoynpTZLh8/7r0
         zsAGuD+hMy9mlXAzdpv3uEaHqBjq7NRwYMrf379Ggzh9laNqRbDJ16AJezEGV1rKCcq6
         3IM3f1A3djMn5GOYsN8y9E8oz7LAQeCy6tZQZO6ruCd0pyklBu9MuKV/Vc8yCRqGSRUk
         VIn7iEcOzko72d9trRvQRYdTnyZm7o8wfMqtaATqSmGdHYvx6QVE5UDh8XV4u3GLyvnK
         Sc/kbCUDsn/747PcB0bu1FyZzVfct+IDuSJC2AXXjz/wg+omtgldUzuZZu7ydT8f2/6e
         9t9w==
X-Gm-Message-State: ABUngvflNgCmb8sz1+C410pmuAg+8fgzlMbFqinXkzS55BtOwLZy1pDORnebTJfPzhI2VSxF
X-Received: by 10.107.59.199 with SMTP id i190mr6948376ioa.233.1477179177010;
        Sat, 22 Oct 2016 16:32:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:4ca0:b1d9:cc22:1c7b])
        by smtp.gmail.com with ESMTPSA id q6sm427135ioe.12.2016.10.22.16.32.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 22 Oct 2016 16:32:56 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 13/36] attr: convert git_check_attrs() callers to use the new API
Date:   Sat, 22 Oct 2016 16:32:02 -0700
Message-Id: <20161022233225.8883-14-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.508.g6572022
In-Reply-To: <20161022233225.8883-1-sbeller@google.com>
References: <20161022233225.8883-1-sbeller@google.com>
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
index 3cb38ed..3918c07 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -896,24 +896,15 @@ static void write_pack_file(void)
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
2.10.1.508.g6572022

