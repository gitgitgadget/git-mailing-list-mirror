Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3901E20A17
	for <e@80x24.org>; Mon, 23 Jan 2017 20:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751686AbdAWUgW (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 15:36:22 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35988 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbdAWUgM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 15:36:12 -0500
Received: by mail-pf0-f170.google.com with SMTP id 189so43794783pfu.3
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 12:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l61FQ6TJr1GXvCE/ZaL2AcgWZ+5ptisQrimSNP89lro=;
        b=dAxL48TSErqNMLkbAHF8BzCoHc6FhmwC5RhrJWHJFQXtnysZ+nh5837NaD1F8ex3wv
         k2trUO+5VR0g8mtGCncWgGfzvUeWpclAQFphiZQQjFimqKjp2Vqr1t8f37asS3ccKCYp
         WY3V3klsmJmJL+BnWWX00mWFgp2+UesDsbYjM8zwrdnX68hcjUTDTbkXcBgOgRU8dKe0
         KYFbyqcd4mcm31NchchJQETtyZgjD1+AMzO6XLwvJzXc8+7od0egsXW7meYCb8RaKq6z
         qA5PzahpmULhTihKRgt+tVO+7r/v60SQYkrqy58orJ5WgISiE+DCR9aftgVhcdjUKPXB
         J8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l61FQ6TJr1GXvCE/ZaL2AcgWZ+5ptisQrimSNP89lro=;
        b=LPc9yY8fKrppUQr0P/2x1n89FVmn23olNUJWdsJDQuY4jMb60srMyOOnloskG3+b/E
         AK38I+gW1QUXqewuaPgb3GaPBDggugo1Jsy1m4gTlysjD06OCbwMNRvnrKjZDb6liRbQ
         Dts5z/8MN0yywh+hJuAg559yufq6x4f9hRw/gGfRm3gr+RiaumycXnbI4r3ZrbRNmC+t
         qlHJGme/satWDGj4vBZgizMtWihlTOnfWnt3VJsp4zh5HVGlYNYXjt9gZ/1KAyuVe+hQ
         NFhlcRfksMXow7kYzytsFxZGfCx0DGO9lIjx3ANEZcHWyqpRmo2MOwg0KQg37v0c9Ef+
         2rTQ==
X-Gm-Message-State: AIkVDXLFanwJWY2UB23XoPrY7Na865V3joKo7onDk615zjvx7vh90vStV+/G2lfo+cf/paiu
X-Received: by 10.84.133.163 with SMTP id f32mr30263122plf.64.1485203771514;
        Mon, 23 Jan 2017 12:36:11 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id z29sm39280832pgc.7.2017.01.23.12.36.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jan 2017 12:36:10 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com, pclouds@gmail.com
Subject: [PATCH v2 23/27] attr: remove maybe-real, maybe-macro from git_attr
Date:   Mon, 23 Jan 2017 12:35:21 -0800
Message-Id: <20170123203525.185058-24-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170123203525.185058-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
 <20170123203525.185058-1-bmwill@google.com>
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
index 6d2468790..ed9ba3756 100644
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
2.11.0.483.g087da7b7c-goog

