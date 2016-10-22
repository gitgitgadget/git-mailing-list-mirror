Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7449720986
	for <e@80x24.org>; Sat, 22 Oct 2016 23:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965114AbcJVXdm (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 19:33:42 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:38233 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965032AbcJVXd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 19:33:27 -0400
Received: by mail-it0-f41.google.com with SMTP id 66so74099976itl.1
        for <git@vger.kernel.org>; Sat, 22 Oct 2016 16:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RrNPr6jALoIaxcC34mKWe0kaksafmHwA+ovJ5PlEr6M=;
        b=bukU2aQHxJxg6VjLAUMQhoF6FdHxrTe7FpzDTnGP/4z222kGYNKS9U/UBpKjkDOdwk
         aC/WAaPmhbNa6LNGgcVlT8zz8r7NXN1QX26Qxd0gk+nIyiRqP1dk7Ya48cLse8HeAnBJ
         9u9Ze9nUovxTaaOf5vmBz3ybRITQj8qEcg3XlBlTwn2NKzp195g1Lkh5mUanR7fcZEI9
         Fd+rXHJHFPpIiCZxukcU1pwFHPGnEhoUj0/Wo68zlfX9FkWdYOdhpY8SlKvFklZwcCp8
         fjlWhwJyx+9jCo1B01OaaxwbmhH1/eeLJpHVot4T0y6X3DDCHY7dTgZx8CGzLM85WOJx
         njrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RrNPr6jALoIaxcC34mKWe0kaksafmHwA+ovJ5PlEr6M=;
        b=hbPM4ZEgUZDTUCZNZDT2487edu0iU4rpEZmN5OEa8u36Iwc6a3Q+Pk86LVlfhyPcnJ
         iwtidAFppl6KyaLvV970UpuQ+9+1giMBq+e3svwFuz3uPeALJrw6Hlt46aqrcJb2EKLO
         I9TIGgSpdDSwDVPwCCZewRIIkQE1Z0uu6rbxEi2r203yVaERT4DejpHkA5LtqhFAVR7R
         zLg5f42qKaQUHs6DAfIFChYwQV9k8GLWIUJuv+VFD/2c19huK8PEPqDM5D+eyLJ2ukiG
         NxinrmcGewY8uf/c62q14hjvRF3ZYKaxtjikm9dMBtWEqvHSH74G3Rj1GZ7NXwYrBO7o
         fHGQ==
X-Gm-Message-State: ABUngvfmgRm9Vsve034qMOb9jf39OtdrXmrk5CWyhLZy5T1R07YR8ShI17R+1cStmMRTUMUc
X-Received: by 10.36.237.70 with SMTP id r67mr7839840ith.71.1477179205943;
        Sat, 22 Oct 2016 16:33:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:4ca0:b1d9:cc22:1c7b])
        by smtp.gmail.com with ESMTPSA id q77sm1957910itb.19.2016.10.22.16.33.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 22 Oct 2016 16:33:25 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 28/36] attr: keep attr stack for each check
Date:   Sat, 22 Oct 2016 16:32:17 -0700
Message-Id: <20161022233225.8883-29-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.508.g6572022
In-Reply-To: <20161022233225.8883-1-sbeller@google.com>
References: <20161022233225.8883-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of having a global attr stack, attach the stack to each check.
This allows to use the attr in a multithreaded way.



Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c    | 101 +++++++++++++++++++++++++++++++++++++++-----------------------
 attr.h    |   4 ++-
 hashmap.h |   2 ++
 3 files changed, 69 insertions(+), 38 deletions(-)

diff --git a/attr.c b/attr.c
index 89ae155..b65437d 100644
--- a/attr.c
+++ b/attr.c
@@ -372,15 +372,17 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
  * .gitignore file and info/excludes file as a fallback.
  */
 
-/* NEEDSWORK: This will become per git_attr_check */
-static struct attr_stack {
+struct attr_stack {
 	struct attr_stack *prev;
 	char *origin;
 	size_t originlen;
 	unsigned num_matches;
 	unsigned alloc;
 	struct match_attr **attrs;
-} *attr_stack;
+};
+
+struct hashmap all_attr_stacks;
+int all_attr_stacks_init;
 
 static void free_attr_elem(struct attr_stack *e)
 {
@@ -561,11 +563,23 @@ static void debug_set(const char *what, const char *match, struct git_attr *attr
 
 static void drop_attr_stack(void)
 {
-	while (attr_stack) {
-		struct attr_stack *elem = attr_stack;
-		attr_stack = elem->prev;
-		free_attr_elem(elem);
+	struct hashmap_iter iter;
+	struct git_attr_check *check;
+
+	attr_lock();
+	if (!all_attr_stacks_init) {
+		attr_unlock();
+		return;
 	}
+	hashmap_iter_init(&all_attr_stacks, &iter);
+	while ((check = hashmap_iter_next(&iter))) {
+		while (check->attr_stack) {
+			struct attr_stack *elem = check->attr_stack;
+			check->attr_stack = elem->prev;
+			free_attr_elem(elem);
+		}
+	}
+	attr_unlock();
 }
 
 static const char *git_etc_gitattributes(void)
@@ -595,40 +609,42 @@ static void push_stack(struct attr_stack **attr_stack_p,
 	}
 }
 
-static void bootstrap_attr_stack(void)
+static void bootstrap_attr_stack(struct git_attr_check *check)
 {
 	struct attr_stack *elem;
 
-	if (attr_stack)
+	if (check->attr_stack)
 		return;
 
-	push_stack(&attr_stack, read_attr_from_array(builtin_attr), NULL, 0);
+	push_stack(&check->attr_stack,
+		   read_attr_from_array(builtin_attr), NULL, 0);
 
 	if (git_attr_system())
-		push_stack(&attr_stack,
+		push_stack(&check->attr_stack,
 			   read_attr_from_file(git_etc_gitattributes(), 1),
 			   NULL, 0);
 
 	if (!git_attributes_file)
 		git_attributes_file = xdg_config_home("attributes");
 	if (git_attributes_file)
-		push_stack(&attr_stack,
+		push_stack(&check->attr_stack,
 			   read_attr_from_file(git_attributes_file, 1),
 			   NULL, 0);
 
 	if (!is_bare_repository() || direction == GIT_ATTR_INDEX) {
 		elem = read_attr(GITATTRIBUTES_FILE, 1);
-		push_stack(&attr_stack, elem, xstrdup(""), 0);
+		push_stack(&check->attr_stack, elem, xstrdup(""), 0);
 		debug_push(elem);
 	}
 
 	elem = read_attr_from_file(git_path_info_attributes(), 1);
 	if (!elem)
 		elem = xcalloc(1, sizeof(*elem));
-	push_stack(&attr_stack, elem, NULL, 0);
+	push_stack(&check->attr_stack, elem, NULL, 0);
 }
 
-static void prepare_attr_stack(const char *path, int dirlen)
+static void prepare_attr_stack(const char *path, int dirlen,
+			       struct git_attr_check *check)
 {
 	struct attr_stack *elem, *info;
 	const char *cp;
@@ -648,13 +664,13 @@ static void prepare_attr_stack(const char *path, int dirlen)
 	 * .gitattributes in deeper directories to shallower ones,
 	 * and finally use the built-in set as the default.
 	 */
-	bootstrap_attr_stack();
+	bootstrap_attr_stack(check);
 
 	/*
 	 * Pop the "info" one that is always at the top of the stack.
 	 */
-	info = attr_stack;
-	attr_stack = info->prev;
+	info = check->attr_stack;
+	check->attr_stack = info->prev;
 
 	/*
 	 * Pop the ones from directories that are not the prefix of
@@ -662,17 +678,17 @@ static void prepare_attr_stack(const char *path, int dirlen)
 	 * the root one (whose origin is an empty string "") or the builtin
 	 * one (whose origin is NULL) without popping it.
 	 */
-	while (attr_stack->origin) {
-		int namelen = strlen(attr_stack->origin);
+	while (check->attr_stack->origin) {
+		int namelen = strlen(check->attr_stack->origin);
 
-		elem = attr_stack;
+		elem = check->attr_stack;
 		if (namelen <= dirlen &&
 		    !strncmp(elem->origin, path, namelen) &&
 		    (!namelen || path[namelen] == '/'))
 			break;
 
 		debug_pop(elem);
-		attr_stack = elem->prev;
+		check->attr_stack = elem->prev;
 		free_attr_elem(elem);
 	}
 
@@ -688,9 +704,9 @@ static void prepare_attr_stack(const char *path, int dirlen)
 		 */
 		struct strbuf pathbuf = STRBUF_INIT;
 
-		assert(attr_stack->origin);
+		assert(check->attr_stack->origin);
 		while (1) {
-			size_t len = strlen(attr_stack->origin);
+			size_t len = strlen(check->attr_stack->origin);
 			char *origin;
 
 			if (dirlen <= len)
@@ -704,7 +720,7 @@ static void prepare_attr_stack(const char *path, int dirlen)
 			elem = read_attr(pathbuf.buf, 0);
 			strbuf_setlen(&pathbuf, cp - path);
 			origin = strbuf_detach(&pathbuf, &len);
-			push_stack(&attr_stack, elem, origin, len);
+			push_stack(&check->attr_stack, elem, origin, len);
 			debug_push(elem);
 		}
 
@@ -714,7 +730,13 @@ static void prepare_attr_stack(const char *path, int dirlen)
 	/*
 	 * Finally push the "info" one at the top of the stack.
 	 */
-	push_stack(&attr_stack, info, NULL, 0);
+	push_stack(&check->attr_stack, info, NULL, 0);
+	if (!all_attr_stacks_init) {
+		hashmap_init(&all_attr_stacks, NULL, 0);
+		all_attr_stacks_init = 1;
+	}
+	if (!hashmap_get(&all_attr_stacks, check, NULL))
+		hashmap_put(&all_attr_stacks, check);
 }
 
 static int path_matches(const char *pathname, int pathlen,
@@ -740,9 +762,10 @@ static int path_matches(const char *pathname, int pathlen,
 			      pattern, prefix, pat->patternlen, pat->flags);
 }
 
-static int macroexpand_one(int attr_nr, int rem);
+static int macroexpand_one(int attr_nr, int rem, struct git_attr_check *check);
 
-static int fill_one(const char *what, struct match_attr *a, int rem)
+static int fill_one(const char *what, struct match_attr *a, int rem,
+		    struct git_attr_check *check)
 {
 	struct git_attr_check_elem *celem = check_all_attr;
 	int i;
@@ -758,14 +781,14 @@ static int fill_one(const char *what, struct match_attr *a, int rem)
 				  attr, v);
 			*n = v;
 			rem--;
-			rem = macroexpand_one(attr->attr_nr, rem);
+			rem = macroexpand_one(attr->attr_nr, rem, check);
 		}
 	}
 	return rem;
 }
 
 static int fill(const char *path, int pathlen, int basename_offset,
-		struct attr_stack *stk, int rem)
+		struct attr_stack *stk, int rem, struct git_attr_check *check)
 {
 	int i;
 	const char *base = stk->origin ? stk->origin : "";
@@ -776,12 +799,12 @@ static int fill(const char *path, int pathlen, int basename_offset,
 			continue;
 		if (path_matches(path, pathlen, basename_offset,
 				 &a->u.pat, base, stk->originlen))
-			rem = fill_one("fill", a, rem);
+			rem = fill_one("fill", a, rem, check);
 	}
 	return rem;
 }
 
-static int macroexpand_one(int nr, int rem)
+static int macroexpand_one(int nr, int rem, struct git_attr_check *check)
 {
 	struct attr_stack *stk;
 	int i;
@@ -790,13 +813,13 @@ static int macroexpand_one(int nr, int rem)
 	    !check_all_attr[nr].attr->maybe_macro)
 		return rem;
 
-	for (stk = attr_stack; stk; stk = stk->prev) {
+	for (stk = check->attr_stack; stk; stk = stk->prev) {
 		for (i = stk->num_matches - 1; 0 <= i; i--) {
 			struct match_attr *ma = stk->attrs[i];
 			if (!ma->is_macro)
 				continue;
 			if (ma->u.attr->attr_nr == nr)
-				return fill_one("expand", ma, rem);
+				return fill_one("expand", ma, rem, check);
 		}
 	}
 
@@ -845,7 +868,7 @@ static void collect_some_attrs(const char *path, int pathlen,
 		dirlen = 0;
 	}
 
-	prepare_attr_stack(path, dirlen);
+	prepare_attr_stack(path, dirlen, check);
 
 	for (i = 0; i < attr_nr; i++)
 		check_all_attr[i].value = ATTR__UNKNOWN;
@@ -865,8 +888,8 @@ static void collect_some_attrs(const char *path, int pathlen,
 	}
 
 	rem = attr_nr;
-	for (stk = attr_stack; 0 < rem && stk; stk = stk->prev)
-		rem = fill(path, pathlen, basename_offset, stk, rem);
+	for (stk = check->attr_stack; 0 < rem && stk; stk = stk->prev)
+		rem = fill(path, pathlen, basename_offset, stk, rem, check);
 
 	if (collect_all) {
 		int check_nr = 0, check_alloc = 0;
@@ -898,6 +921,8 @@ static int git_check_attrs(const char *path, int pathlen,
 {
 	int i;
 
+	attr_lock();
+
 	collect_some_attrs(path, pathlen, check, &result, 0);
 
 	for (i = 0; i < check->check_nr; i++) {
@@ -907,6 +932,8 @@ static int git_check_attrs(const char *path, int pathlen,
 		result[i].value = value;
 	}
 
+	attr_unlock();
+
 	return 0;
 }
 
diff --git a/attr.h b/attr.h
index 219b8c7..60d90f2 100644
--- a/attr.h
+++ b/attr.h
@@ -32,12 +32,14 @@ extern const char git_attr__false[];
 #define ATTR_UNSET(v) ((v) == NULL)
 
 struct git_attr_check {
+	struct hashmap_entry entry;
 	int finalized;
 	int check_nr;
 	int check_alloc;
 	const struct git_attr **attr;
+	struct attr_stack *attr_stack;
 };
-#define GIT_ATTR_CHECK_INIT {0, 0, 0, NULL}
+#define GIT_ATTR_CHECK_INIT {HASHMAP_ENTRY_INIT, 0, 0, 0, NULL, NULL}
 
 struct git_attr_result {
 	const char *value;
diff --git a/hashmap.h b/hashmap.h
index ab7958a..d247c62 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -31,6 +31,8 @@ struct hashmap_entry {
 	unsigned int hash;
 };
 
+#define HASHMAP_ENTRY_INIT {NULL, 0}
+
 typedef int (*hashmap_cmp_fn)(const void *entry, const void *entry_or_key,
 		const void *keydata);
 
-- 
2.10.1.508.g6572022

