Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C96B71FAAD
	for <e@80x24.org>; Sat, 28 Jan 2017 02:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751367AbdA1CDq (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 21:03:46 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:33227 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751302AbdA1CDK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 21:03:10 -0500
Received: by mail-pg0-f47.google.com with SMTP id 204so85675629pge.0
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 18:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7KJ3w7rP5RByF1x3jXyRQNl2ZOaqAgsjgIJAw21GNl4=;
        b=LxW2V0As8azWwhAg8qasF9IYGcVuyFbogjybs48jHuhHcR9uTtVTJoRgGe/iVREglL
         eRkR/WTOyFNL0reCHkPSwCVoBUd7qrmYEKiX0fHreT5jExypH5Y+R7tzVcSis+4Eeus/
         HCYCn7pUCZS3x8LZiAwteLEXci6B3GI/Gtx3jR9TzUtVpsXNcIqBPvMYdLuxcRJ2bjp4
         To/gaiZ/tyB2F2SXnkUFStJjNq2F8KYhmmEkbuhC9Ahx2VxNDllgiNl6BTVRQy0bg+S8
         0gS88o9mycykti4h6uTW54YwV/al30mLHvidoDjkNTqetZUfYYLvaGDnA939LyXc2bmp
         QifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7KJ3w7rP5RByF1x3jXyRQNl2ZOaqAgsjgIJAw21GNl4=;
        b=LZHP8rpnshGb/2xbG6oO1Q5rKmj+smgP6uoAzcuUFtOVDajhx9rWBiKiQ6E0g0lPHe
         duYcYV53XYbcFKf0Z/RDuSM7NL6GsPWdX6t+mjSmJlABTAcPyP77mnofSLYMegpYztNW
         aahC3sn8PNgbuhIiB+KQ5iIVNxkJX+Pi//JjooLtkLdtx+h3XX0s7cNOki7nhvGkE18U
         BT4IYU9eLIz3ZyJ6rqqzrBM0bDqjZGktxcxev2pqEzHPYzfL1pnwQpuz3GF+6q1xzX1g
         c4fU4RhoQa8zl4K+ctklWsKTqyOqI/g4YDQehTT1fSphIWwW+16WXqVmY/Hrhida9mT6
         hOSQ==
X-Gm-Message-State: AIkVDXKR735LX/DaBCc/BSQq14mvGofZDLzfBp79MTJxb+xXCnaAB/WuyPfa1OyICYn3+qe3
X-Received: by 10.98.210.3 with SMTP id c3mr12183851pfg.7.1485568983736;
        Fri, 27 Jan 2017 18:03:03 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id w76sm14136185pfd.74.2017.01.27.18.03.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jan 2017 18:03:02 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com, pclouds@gmail.com
Subject: [PATCH v3 23/27] attr: remove maybe-real, maybe-macro from git_attr
Date:   Fri, 27 Jan 2017 18:02:03 -0800
Message-Id: <20170128020207.179015-24-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170128020207.179015-1-bmwill@google.com>
References: <20170123203525.185058-1-bmwill@google.com>
 <20170128020207.179015-1-bmwill@google.com>
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
 attr.c | 75 +++++++++++++++++++++++++++++++++---------------------------------
 1 file changed, 37 insertions(+), 38 deletions(-)

diff --git a/attr.c b/attr.c
index 2637804b1..8f4402ef3 100644
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
@@ -142,6 +131,12 @@ static void attr_hashmap_add(struct attr_hashmap *map,
 struct all_attrs_item {
 	const struct git_attr *attr;
 	const char *value;
+	/*
+	 * If 'macro' is non-NULL, indicates that 'attr' is a macro based on
+	 * the current attribute stack and contains a pointer to the match_attr
+	 * definition of the macro
+	 */
+	const struct match_attr *macro;
 };
 
 /*
@@ -187,6 +182,7 @@ static void all_attrs_init(struct attr_hashmap *map, struct attr_check *check)
 	 */
 	for (i = 0; i < check->all_attrs_nr; i++) {
 		check->all_attrs[i].value = ATTR__UNKNOWN;
+		check->all_attrs[i].macro = NULL;
 	}
 }
 
@@ -238,8 +234,6 @@ static struct git_attr *git_attr_internal(const char *name, int namelen)
 	if (!a) {
 		FLEX_ALLOC_MEM(a, name, name, namelen);
 		a->attr_nr = g_attr_hashmap.map.size;
-		a->maybe_real = 0;
-		a->maybe_macro = 0;
 
 		attr_hashmap_add(&g_attr_hashmap, a->name, namelen, a);
 		assert(a->attr_nr == (g_attr_hashmap.map.size - 1));
@@ -402,7 +396,6 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 		      (is_macro ? 0 : namelen + 1));
 	if (is_macro) {
 		res->u.attr = git_attr_internal(name, namelen);
-		res->u.attr->maybe_macro = 1;
 	} else {
 		char *p = (char *)&(res->state[num_attr]);
 		memcpy(p, name, namelen);
@@ -423,10 +416,6 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 	/* Second pass to fill the attr_states */
 	for (cp = states, i = 0; *cp; i++) {
 		cp = parse_attr(src, lineno, cp, &(res->state[i]));
-		if (!is_macro)
-			res->state[i].attr->maybe_real = 1;
-		if (res->state[i].attr->maybe_macro)
-			cannot_trust_maybe_real = 1;
 	}
 
 	strbuf_release(&pattern);
@@ -904,7 +893,7 @@ static int path_matches(const char *pathname, int pathlen,
 static int macroexpand_one(struct all_attrs_item *all_attrs, int nr, int rem);
 
 static int fill_one(const char *what, struct all_attrs_item *all_attrs,
-		    struct match_attr *a, int rem)
+		    const struct match_attr *a, int rem)
 {
 	int i;
 
@@ -945,24 +934,34 @@ static int fill(const char *path, int pathlen, int basename_offset,
 
 static int macroexpand_one(struct all_attrs_item *all_attrs, int nr, int rem)
 {
-	struct attr_stack *stk;
-	int i;
+	const struct all_attrs_item *item = &all_attrs[nr];
 
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
+static void determine_macros(struct all_attrs_item *all_attrs,
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
@@ -992,15 +991,15 @@ static void collect_some_attrs(const char *path, struct attr_check *check)
 
 	prepare_attr_stack(path, dirlen);
 	all_attrs_init(&g_attr_hashmap, check);
+	determine_macros(check->all_attrs, attr_stack);
 
-	if (check->nr && !cannot_trust_maybe_real) {
+	if (check->nr) {
 		rem = 0;
 		for (i = 0; i < check->nr; i++) {
-			const struct git_attr *a = check->items[i].attr;
-			if (!a->maybe_real) {
-				struct all_attrs_item *c;
-				c = check->all_attrs + a->attr_nr;
-				c->value = ATTR__UNSET;
+			int n = check->items[i].attr->attr_nr;
+			struct all_attrs_item *item = &check->all_attrs[n];
+			if (item->macro) {
+				item->value = ATTR__UNSET;
 				rem++;
 			}
 		}
-- 
2.11.0.483.g087da7b7c-goog

