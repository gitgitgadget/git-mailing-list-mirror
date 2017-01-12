Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A924E1FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 23:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750927AbdALXzh (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 18:55:37 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34079 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbdALXz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 18:55:26 -0500
Received: by mail-pf0-f180.google.com with SMTP id 127so20409248pfg.1
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 15:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rmch+5V7IAGHRBf02hGLjqKepDyZOQSa2vYSGnFZTjw=;
        b=LZUFTCM/956xx7EgGqOWCUTvkpNZh6BH22mVEDB2MvIBp4KuTw0Siyx1DOrkxBs4DI
         HJte0kZCpmrqkzjMoqyot798rKW2vJq591UVe6+/dd+4dqKN9k7Jutcw/3cwidVJh1lW
         OIFWA8bn9bLZ9mAPvmHfJl8a23sXXBCW0KF1iq+crP9mugAi1kGtuLivy42UDYJHq4wH
         4YLjK4/Os20iTAh8sCI1jBsqqglywjB/6OLXKbNP7ZJ1X49ZlUIWJMKq4Qjv/EhSLCgR
         Hxkrmsk8KtdBA2P8NFQss9K4FQXBcRt4KYEy1YcHM/92G1sCQvz720MR+0diIO2tsDMn
         VCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rmch+5V7IAGHRBf02hGLjqKepDyZOQSa2vYSGnFZTjw=;
        b=aVkjAliwNXNVyw4d1nbXTv5W6SBLmso8zB7EFuWgOsNvQCg8cLPWpYcmQMct/Z2To8
         NgRMBRPAZgOIvbVV1EkLQUHZWZHmHl5g1nfxDTt9glA/hQGz3FvMqYqd6KclOGkT4Qyx
         V1YkTsD99hhmqgH+LYp3ohrtIHP5xljmaUtoY8cBX1QMBzxemM8Dw2V7tF2f/60TcPIM
         WkQTwP9bcSIl+kJjbUpIlRAnCz9+/2KYc+sTFmOUXXrJIb2N9BygMOBRYI9R2ErH1jy3
         yIEnvsx8ejtz8wdRIrSfsexsN+cErMoCnL2JcMz8PmLpWXacVQZHibK9Jpwn13TRJcc8
         lP1w==
X-Gm-Message-State: AIkVDXIp/DL+uzJ05G3QRsnjR/15mB+37fjCd2KBVT6zrn3GgPJ8aaXposlnCe7X33EFIk2B
X-Received: by 10.84.209.204 with SMTP id y70mr25414537plh.180.1484265278010;
        Thu, 12 Jan 2017 15:54:38 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id e6sm24312192pgf.4.2017.01.12.15.54.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jan 2017 15:54:36 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, gitster@pobox.com,
        pclouds@gmail.com, sbeller@google.com
Subject: [PATCH 23/27] attr: remove maybe-real, maybe-macro from git_attr
Date:   Thu, 12 Jan 2017 15:53:50 -0800
Message-Id: <20170112235354.153403-24-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170112235354.153403-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Whether or not a git attribute is real or a macro isn't a property of
the attribute but rather it depends on the attribute stack (which
.gitattribute files were read).

This patch removes the 'maybe_real' and 'maybe_macro' fields in a
git_attr and instead adds the 'macro' field to a attr_check_item.  The
'macro' indicates (if non-NULL) that a particular attribute is a macro
for the given attribute stack.  It's populated, through a quick scan of
the attribute stack, with the match_attr that corresponds to the macro's
definition.  This way the attribute stack only needs to be scanned a
single time prior to attribute collection instead of each time a macro
needs to be expanded.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c | 69 ++++++++++++++++++++++++++++++------------------------------------
 attr.h |  6 ++++++
 2 files changed, 37 insertions(+), 38 deletions(-)

diff --git a/attr.c b/attr.c
index 38b0d4347..633a12cc3 100644
--- a/attr.c
+++ b/attr.c
@@ -30,20 +30,9 @@ static const char git_attr__unknown[] = "(builtin)unknown";
 
 struct git_attr {
 	int attr_nr; /* unique attribute number */
-	int maybe_macro;
-	int maybe_real;
 	char name[FLEX_ARRAY]; /* attribute name */
 };
 
-/*
- * NEEDSWORK: maybe-real, maybe-macro are not property of
- * an attribute, as it depends on what .gitattributes are
- * read.  Once we introduce per git_attr_check attr_stack
- * and check_all_attr, the optimization based on them will
- * become unnecessary and can go away.  So is this variable.
- */
-static int cannot_trust_maybe_real;
-
 const char *git_attr_name(const struct git_attr *attr)
 {
 	return attr->name;
@@ -182,6 +171,7 @@ static void all_attrs_init(struct attr_hashmap *map, struct attr_check *check)
 	 */
 	for (i = 0; i < check->all_attrs_nr; i++) {
 		check->all_attrs[i].value = ATTR__UNKNOWN;
+		check->all_attrs[i].macro = NULL;
 	}
 }
 
@@ -233,8 +223,6 @@ static struct git_attr *git_attr_internal(const char *name, int namelen)
 	if (!a) {
 		FLEX_ALLOC_MEM(a, name, name, namelen);
 		a->attr_nr = g_attr_hashmap.map.size;
-		a->maybe_real = 0;
-		a->maybe_macro = 0;
 
 		attr_hashmap_add(&g_attr_hashmap, a->name, namelen, a);
 		assert(a->attr_nr == (g_attr_hashmap.map.size - 1));
@@ -397,7 +385,6 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 		      (is_macro ? 0 : namelen + 1));
 	if (is_macro) {
 		res->u.attr = git_attr_internal(name, namelen);
-		res->u.attr->maybe_macro = 1;
 	} else {
 		char *p = (char *)&(res->state[num_attr]);
 		memcpy(p, name, namelen);
@@ -418,10 +405,6 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 	/* Second pass to fill the attr_states */
 	for (cp = states, i = 0; *cp; i++) {
 		cp = parse_attr(src, lineno, cp, &(res->state[i]));
-		if (!is_macro)
-			res->state[i].attr->maybe_real = 1;
-		if (res->state[i].attr->maybe_macro)
-			cannot_trust_maybe_real = 1;
 	}
 
 	strbuf_release(&pattern);
@@ -826,7 +809,7 @@ static int path_matches(const char *pathname, int pathlen,
 static int macroexpand_one(struct attr_check_item *all_attrs, int nr, int rem);
 
 static int fill_one(const char *what, struct attr_check_item *all_attrs,
-		    struct match_attr *a, int rem)
+		    const struct match_attr *a, int rem)
 {
 	int i;
 
@@ -867,24 +850,34 @@ static int fill(const char *path, int pathlen, int basename_offset,
 
 static int macroexpand_one(struct attr_check_item *all_attrs, int nr, int rem)
 {
-	struct attr_stack *stk;
-	int i;
+	const struct attr_check_item *item = &all_attrs[nr];
 
-	if (all_attrs[nr].value != ATTR__TRUE ||
-	    !all_attrs[nr].attr->maybe_macro)
+	if (item->macro && item->value == ATTR__TRUE)
+		return fill_one("expand", all_attrs, item->macro, rem);
+	else
 		return rem;
+}
 
-	for (stk = attr_stack; stk; stk = stk->prev) {
-		for (i = stk->num_matches - 1; 0 <= i; i--) {
-			struct match_attr *ma = stk->attrs[i];
-			if (!ma->is_macro)
-				continue;
-			if (ma->u.attr->attr_nr == nr)
-				return fill_one("expand", all_attrs, ma, rem);
+/*
+ * Marks the attributes which are macros based on the attribute stack.
+ * This prevents having to search through the attribute stack each time
+ * a macro needs to be expanded during the fill stage.
+ */
+static void determine_macros(struct attr_check_item *all_attrs,
+			     const struct attr_stack *stack)
+{
+	for (; stack; stack = stack->prev) {
+		int i;
+		for (i = stack->num_matches - 1; i >= 0; i--) {
+			const struct match_attr *ma = stack->attrs[i];
+			if (ma->is_macro) {
+				int n = ma->u.attr->attr_nr;
+				if (!all_attrs[n].macro) {
+					all_attrs[n].macro = ma;
+				}
+			}
 		}
 	}
-
-	return rem;
 }
 
 /*
@@ -914,15 +907,15 @@ static void collect_some_attrs(const char *path, struct attr_check *check)
 
 	prepare_attr_stack(path, dirlen);
 	all_attrs_init(&g_attr_hashmap, check);
+	determine_macros(check->all_attrs, attr_stack);
 
-	if (check->check_nr && !cannot_trust_maybe_real) {
+	if (check->check_nr) {
 		rem = 0;
 		for (i = 0; i < check->check_nr; i++) {
-			const struct git_attr *a = check->check[i].attr;
-			if (!a->maybe_real) {
-				struct attr_check_item *c;
-				c = check->all_attrs + a->attr_nr;
-				c->value = ATTR__UNSET;
+			int n = check->check[i].attr->attr_nr;
+			struct attr_check_item *item = &check->all_attrs[n];
+			if (item->macro) {
+				item->value = ATTR__UNSET;
 				rem++;
 			}
 		}
diff --git a/attr.h b/attr.h
index 44b21d82c..f40524875 100644
--- a/attr.h
+++ b/attr.h
@@ -27,6 +27,12 @@ extern const char git_attr__false[];
 struct attr_check_item {
 	const struct git_attr *attr;
 	const char *value;
+	/*
+	 * If 'macro' is non-NULL, indicates that 'attr' is a macro based on
+	 * the current attribute stack and contains a pointer to the match_attr
+	 * definition of the macro
+	 */
+	const struct match_attr *macro;
 };
 
 struct attr_check {
-- 
2.11.0.390.gc69c2f50cf-goog

