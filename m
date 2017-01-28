Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 541551F437
	for <e@80x24.org>; Sat, 28 Jan 2017 02:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751352AbdA1CDd (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 21:03:33 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:34612 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751285AbdA1CDI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 21:03:08 -0500
Received: by mail-pg0-f49.google.com with SMTP id 14so85555113pgg.1
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 18:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DLzhPXwAvC5pqQolM5E7CKky1fsJbInvkOlGCj0vPS8=;
        b=jetYvJJLqNcW3SvcmWrAxw9ucsYnOpGEPN0FKMfC/bpLPECJH+n9v6jrI80V/GYmU5
         AKjoFwxWHNQhWp/tda+GxxwYwnF0YXDjQwkD8I8xZDmHB4pF99R0S9NYFLC/LhwgQ5Ec
         36DC1v02xe6RJ6jMqgDtnMinhjavCMu5yCa1LNnOPrgwcpeYGrSU3EPGB4E9O2tuHoy5
         kGOFIlhNRGSVPib1nTiYZEBBI9UWLRmAJyof5L4ZzS6fLFFzLamXOJi+wh7RiwfjJwPg
         kS68JlQFRCwBQX4np9Eo0W69JiH5TnnPgqZcQFcCfJmYzYXKREr29u6u5y9crmFrkBtI
         o2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DLzhPXwAvC5pqQolM5E7CKky1fsJbInvkOlGCj0vPS8=;
        b=YfUMzYWop4Hd9WznE0E4zDGPLhRdcb3ZDB6sFiBNGIFoHMEDavy7479W7S82EwAT60
         u6bt7XClKJlvEKtmoCesUU+AD06hMA/l/x15I4FrKCCBHINV2Y1S2YHPPnpCMwO0HDbY
         KU9J8CSQ/47ASwJP2/RITw+RCGaBozpOJyUT6HnKbPq4AMtNBWOkYDqyuyp7BPS+GVI0
         wC11rKFts6YnNTm39ZJIp5U86Xj4wGdNtVXkeighoR37a9f3yjhe+FvAa/4xXsjdkTnD
         GtZxqrr3tV0bpbB2KabtD0nhvfc2ykog3IQwuzO1ZlkNMue7J0SA4VTSyRlRW4te536+
         3/Ug==
X-Gm-Message-State: AIkVDXJ9sSezc991hSe4SVm9eYxw2Yi9gwXizlKF74PqxXc0qWolpHn8kIhaa4jBCdZf79qN
X-Received: by 10.84.210.107 with SMTP id z98mr16477415plh.171.1485568987495;
        Fri, 27 Jan 2017 18:03:07 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id w76sm14136185pfd.74.2017.01.27.18.03.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jan 2017 18:03:06 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com, pclouds@gmail.com
Subject: [PATCH v3 25/27] attr: store attribute stack in attr_check structure
Date:   Fri, 27 Jan 2017 18:02:05 -0800
Message-Id: <20170128020207.179015-26-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170128020207.179015-1-bmwill@google.com>
References: <20170123203525.185058-1-bmwill@google.com>
 <20170128020207.179015-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The last big hurdle towards a thread-safe API for the attribute system
is the reliance on a global attribute stack that is modified during each
call into the attribute system.

This patch removes this global stack and instead a stack is stored
locally in each attr_check instance.  This opens up the opportunity for
future optimizations to customize the attribute stack for the attributes
that a particular attr_check struct is interested in.

One caveat with pushing the attribute stack into the attr_check
structure is that the attribute system now needs to keep track of all
active attr_check instances.  Due to the direction mechanism the stack
needs to be dropped when the direction is switched.  In order to ensure
correctness when the direction is changed the attribute system needs to
iterate through all active attr_check instances and drop each of their
stacks.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c | 284 +++++++++++++++++++++++++++++++++++++++++++++--------------------
 attr.h |   4 +-
 2 files changed, 199 insertions(+), 89 deletions(-)

diff --git a/attr.c b/attr.c
index 69643ae77..bcee0921d 100644
--- a/attr.c
+++ b/attr.c
@@ -445,17 +445,16 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
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
 
-static void free_attr_elem(struct attr_stack *e)
+static void attr_stack_free(struct attr_stack *e)
 {
 	int i;
 	free(e->origin);
@@ -478,9 +477,96 @@ static void free_attr_elem(struct attr_stack *e)
 	free(e);
 }
 
+static void drop_attr_stack(struct attr_stack **stack)
+{
+	while (*stack) {
+		struct attr_stack *elem = *stack;
+		*stack = elem->prev;
+		attr_stack_free(elem);
+	}
+}
+
+/* List of all attr_check structs; access should be surrounded by mutex */
+static struct check_vector {
+	size_t nr;
+	size_t alloc;
+	struct attr_check **checks;
+#ifndef NO_PTHREADS
+	pthread_mutex_t mutex;
+#endif
+} check_vector;
+
+static inline void vector_lock(void)
+{
+#ifndef NO_PTHREADS
+	pthread_mutex_lock(&check_vector.mutex);
+#endif
+}
+
+static inline void vector_unlock(void)
+{
+#ifndef NO_PTHREADS
+	pthread_mutex_unlock(&check_vector.mutex);
+#endif
+}
+
+static void check_vector_add(struct attr_check *c)
+{
+	vector_lock();
+
+	ALLOC_GROW(check_vector.checks,
+		   check_vector.nr + 1,
+		   check_vector.alloc);
+	check_vector.checks[check_vector.nr++] = c;
+
+	vector_unlock();
+}
+
+static void check_vector_remove(struct attr_check *check)
+{
+	int i;
+
+	vector_lock();
+
+	/* Find entry */
+	for (i = 0; i < check_vector.nr; i++)
+		if (check_vector.checks[i] == check)
+			break;
+
+	if (i >= check_vector.nr)
+		die("BUG: no entry found");
+
+	/* shift entries over */
+	for (; i < check_vector.nr - 1; i++)
+		check_vector.checks[i] = check_vector.checks[i + 1];
+
+	check_vector.nr--;
+
+	vector_unlock();
+}
+
+/* Iterate through all attr_check instances and drop their stacks */
+static void drop_all_attr_stacks(void)
+{
+	int i;
+
+	vector_lock();
+
+	for (i = 0; i < check_vector.nr; i++) {
+		drop_attr_stack(&check_vector.checks[i]->stack);
+	}
+
+	vector_unlock();
+}
+
 struct attr_check *attr_check_alloc(void)
 {
-	return xcalloc(1, sizeof(struct attr_check));
+	struct attr_check *c = xcalloc(1, sizeof(struct attr_check));
+
+	/* save pointer to the check struct */
+	check_vector_add(c);
+
+	return c;
 }
 
 struct attr_check *attr_check_initl(const char *one, ...)
@@ -543,12 +629,19 @@ void attr_check_clear(struct attr_check *check)
 	free(check->all_attrs);
 	check->all_attrs = NULL;
 	check->all_attrs_nr = 0;
+
+	drop_attr_stack(&check->stack);
 }
 
 void attr_check_free(struct attr_check *check)
 {
-	attr_check_clear(check);
-	free(check);
+	if (check) {
+		/* Remove check from the check vector */
+		check_vector_remove(check);
+
+		attr_check_clear(check);
+		free(check);
+	}
 }
 
 static const char *builtin_attr[] = {
@@ -705,15 +798,6 @@ static void debug_set(const char *what, const char *match, struct git_attr *attr
 #define debug_set(a,b,c,d) do { ; } while (0)
 #endif /* DEBUG_ATTR */
 
-static void drop_attr_stack(void)
-{
-	while (attr_stack) {
-		struct attr_stack *elem = attr_stack;
-		attr_stack = elem->prev;
-		free_attr_elem(elem);
-	}
-}
-
 static const char *git_etc_gitattributes(void)
 {
 	static const char *system_wide;
@@ -722,6 +806,14 @@ static const char *git_etc_gitattributes(void)
 	return system_wide;
 }
 
+static const char *get_home_gitattributes(void)
+{
+	if (!git_attributes_file)
+		git_attributes_file = xdg_config_home("attributes");
+
+	return git_attributes_file;
+}
+
 static int git_attr_system(void)
 {
 	return !git_env_bool("GIT_ATTR_NOSYSTEM", 0);
@@ -741,47 +833,50 @@ static void push_stack(struct attr_stack **attr_stack_p,
 	}
 }
 
-static void bootstrap_attr_stack(void)
+static void bootstrap_attr_stack(struct attr_stack **stack)
 {
-	struct attr_stack *elem;
+	struct attr_stack *e;
 
-	if (attr_stack)
+	if (*stack)
 		return;
 
-	push_stack(&attr_stack, read_attr_from_array(builtin_attr), NULL, 0);
-
-	if (git_attr_system())
-		push_stack(&attr_stack,
-			   read_attr_from_file(git_etc_gitattributes(), 1),
-			   NULL, 0);
+	/* builtin frame */
+	e = read_attr_from_array(builtin_attr);
+	push_stack(stack, e, NULL, 0);
 
-	if (!git_attributes_file)
-		git_attributes_file = xdg_config_home("attributes");
-	if (git_attributes_file)
-		push_stack(&attr_stack,
-			   read_attr_from_file(git_attributes_file, 1),
-			   NULL, 0);
+	/* system-wide frame */
+	if (git_attr_system()) {
+		e = read_attr_from_file(git_etc_gitattributes(), 1);
+		push_stack(stack, e, NULL, 0);
+	}
 
-	if (!is_bare_repository() || direction == GIT_ATTR_INDEX) {
-		elem = read_attr(GITATTRIBUTES_FILE, 1);
-		push_stack(&attr_stack, elem, xstrdup(""), 0);
-		debug_push(elem);
+	/* home directory */
+	if (get_home_gitattributes()) {
+		e = read_attr_from_file(get_home_gitattributes(), 1);
+		push_stack(stack, e, NULL, 0);
 	}
 
-	if (startup_info->have_repository)
-		elem = read_attr_from_file(git_path_info_attributes(), 1);
+	/* root directory */
+	if (!is_bare_repository() || direction == GIT_ATTR_INDEX)
+		e = read_attr(GITATTRIBUTES_FILE, 1);
 	else
-		elem = NULL;
+		e = xcalloc(1, sizeof(struct attr_stack));
+	push_stack(stack, e, xstrdup(""), 0);
 
-	if (!elem)
-		elem = xcalloc(1, sizeof(*elem));
-	push_stack(&attr_stack, elem, NULL, 0);
+	/* info frame */
+	if (startup_info->have_repository)
+		e = read_attr_from_file(git_path_info_attributes(), 1);
+	else
+		e = NULL;
+	if (!e)
+		e = xcalloc(1, sizeof(struct attr_stack));
+	push_stack(stack, e, NULL, 0);
 }
 
-static void prepare_attr_stack(const char *path, int dirlen)
+static void prepare_attr_stack(const char *path, int dirlen,
+			       struct attr_stack **stack)
 {
-	struct attr_stack *elem, *info;
-	const char *cp;
+	struct attr_stack *info;
 
 	/*
 	 * At the bottom of the attribute stack is the built-in
@@ -798,13 +893,13 @@ static void prepare_attr_stack(const char *path, int dirlen)
 	 * .gitattributes in deeper directories to shallower ones,
 	 * and finally use the built-in set as the default.
 	 */
-	bootstrap_attr_stack();
+	bootstrap_attr_stack(stack);
 
 	/*
 	 * Pop the "info" one that is always at the top of the stack.
 	 */
-	info = attr_stack;
-	attr_stack = info->prev;
+	info = *stack;
+	*stack = info->prev;
 
 	/*
 	 * Pop the ones from directories that are not the prefix of
@@ -812,18 +907,19 @@ static void prepare_attr_stack(const char *path, int dirlen)
 	 * the root one (whose origin is an empty string "") or the builtin
 	 * one (whose origin is NULL) without popping it.
 	 */
-	while (attr_stack->origin) {
-		int namelen = strlen(attr_stack->origin);
+	while ((*stack)->origin) {
+		int namelen = (*stack)->originlen;
+		struct attr_stack *elem;
 
-		elem = attr_stack;
+		elem = *stack;
 		if (namelen <= dirlen &&
 		    !strncmp(elem->origin, path, namelen) &&
 		    (!namelen || path[namelen] == '/'))
 			break;
 
 		debug_pop(elem);
-		attr_stack = elem->prev;
-		free_attr_elem(elem);
+		*stack = elem->prev;
+		attr_stack_free(elem);
 	}
 
 	/*
@@ -838,33 +934,43 @@ static void prepare_attr_stack(const char *path, int dirlen)
 		 */
 		struct strbuf pathbuf = STRBUF_INIT;
 
-		assert(attr_stack->origin);
-		while (1) {
-			size_t len = strlen(attr_stack->origin);
+		assert((*stack)->origin);
+		strbuf_addstr(&pathbuf, (*stack)->origin);
+		/* Build up to the directory 'path' is in */
+		while (pathbuf.len < dirlen) {
+			size_t len = pathbuf.len;
+			struct attr_stack *next;
 			char *origin;
 
-			if (dirlen <= len)
-				break;
-			cp = memchr(path + len + 1, '/', dirlen - len - 1);
-			if (!cp)
-				cp = path + dirlen;
-			strbuf_addf(&pathbuf,
-				    "%.*s/%s", (int)(cp - path), path,
-				    GITATTRIBUTES_FILE);
-			elem = read_attr(pathbuf.buf, 0);
-			strbuf_setlen(&pathbuf, cp - path);
-			origin = strbuf_detach(&pathbuf, &len);
-			push_stack(&attr_stack, elem, origin, len);
-			debug_push(elem);
-		}
+			/* Skip path-separator */
+			if (len < dirlen && is_dir_sep(path[len]))
+				len++;
+			/* Find the end of the next component */
+			while (len < dirlen && !is_dir_sep(path[len]))
+				len++;
+
+			if (pathbuf.len > 0)
+				strbuf_addch(&pathbuf, '/');
+			strbuf_add(&pathbuf, path + pathbuf.len,
+				   (len - pathbuf.len));
+			strbuf_addf(&pathbuf, "/%s", GITATTRIBUTES_FILE);
+
+			next = read_attr(pathbuf.buf, 0);
 
+			/* reset the pathbuf to not include "/.gitattributes" */
+			strbuf_setlen(&pathbuf, len);
+
+			origin = xstrdup(pathbuf.buf);
+			push_stack(stack, next, origin, len);
+
+		}
 		strbuf_release(&pathbuf);
 	}
 
 	/*
 	 * Finally push the "info" one at the top of the stack.
 	 */
-	push_stack(&attr_stack, info, NULL, 0);
+	push_stack(stack, info, NULL, 0);
 }
 
 static int path_matches(const char *pathname, int pathlen,
@@ -915,20 +1021,23 @@ static int fill_one(const char *what, struct all_attrs_item *all_attrs,
 }
 
 static int fill(const char *path, int pathlen, int basename_offset,
-		struct attr_stack *stk, struct all_attrs_item *all_attrs,
-		int rem)
+		const struct attr_stack *stack,
+		struct all_attrs_item *all_attrs, int rem)
 {
-	int i;
-	const char *base = stk->origin ? stk->origin : "";
-
-	for (i = stk->num_matches - 1; 0 < rem && 0 <= i; i--) {
-		const struct match_attr *a = stk->attrs[i];
-		if (a->is_macro)
-			continue;
-		if (path_matches(path, pathlen, basename_offset,
-				 &a->u.pat, base, stk->originlen))
-			rem = fill_one("fill", all_attrs, a, rem);
+	for (; rem > 0 && stack; stack = stack->prev) {
+		int i;
+		const char *base = stack->origin ? stack->origin : "";
+
+		for (i = stack->num_matches - 1; 0 < rem && 0 <= i; i--) {
+			const struct match_attr *a = stack->attrs[i];
+			if (a->is_macro)
+				continue;
+			if (path_matches(path, pathlen, basename_offset,
+					 &a->u.pat, base, stack->originlen))
+				rem = fill_one("fill", all_attrs, a, rem);
+		}
 	}
+
 	return rem;
 }
 
@@ -971,7 +1080,6 @@ static void determine_macros(struct all_attrs_item *all_attrs,
  */
 static void collect_some_attrs(const char *path, struct attr_check *check)
 {
-	struct attr_stack *stk;
 	int i, pathlen, rem, dirlen;
 	const char *cp, *last_slash = NULL;
 	int basename_offset;
@@ -989,9 +1097,9 @@ static void collect_some_attrs(const char *path, struct attr_check *check)
 		dirlen = 0;
 	}
 
-	prepare_attr_stack(path, dirlen);
+	prepare_attr_stack(path, dirlen, &check->stack);
 	all_attrs_init(&g_attr_hashmap, check);
-	determine_macros(check->all_attrs, attr_stack);
+	determine_macros(check->all_attrs, check->stack);
 
 	if (check->nr) {
 		rem = 0;
@@ -1008,8 +1116,7 @@ static void collect_some_attrs(const char *path, struct attr_check *check)
 	}
 
 	rem = check->all_attrs_nr;
-	for (stk = attr_stack; 0 < rem && stk; stk = stk->prev)
-		rem = fill(path, pathlen, basename_offset, stk, check->all_attrs, rem);
+	fill(path, pathlen, basename_offset, check->stack, check->all_attrs, rem);
 }
 
 int git_check_attr(const char *path, struct attr_check *check)
@@ -1056,7 +1163,7 @@ void git_attr_set_direction(enum git_attr_direction new, struct index_state *ist
 
 	direction = new;
 	if (new != old)
-		drop_attr_stack();
+		drop_all_attr_stacks();
 	use_index = istate;
 }
 
@@ -1064,5 +1171,6 @@ void attr_start(void)
 {
 #ifndef NO_PTHREADS
 	pthread_mutex_init(&g_attr_hashmap.mutex, NULL);
+	pthread_mutex_init(&check_vector.mutex, NULL);
 #endif
 }
diff --git a/attr.h b/attr.h
index abebbc19c..6f4961fdb 100644
--- a/attr.h
+++ b/attr.h
@@ -4,8 +4,9 @@
 /* An attribute is a pointer to this opaque structure */
 struct git_attr;
 
-/* opaque structure used internally for attribute collection */
+/* opaque structures used internally for attribute collection */
 struct all_attrs_item;
+struct attr_stack;
 
 /*
  * Given a string, return the gitattribute object that
@@ -38,6 +39,7 @@ struct attr_check {
 	struct attr_check_item *items;
 	int all_attrs_nr;
 	struct all_attrs_item *all_attrs;
+	struct attr_stack *stack;
 };
 
 extern struct attr_check *attr_check_alloc(void);
-- 
2.11.0.483.g087da7b7c-goog

