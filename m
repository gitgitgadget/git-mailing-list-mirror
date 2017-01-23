Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D88A20A17
	for <e@80x24.org>; Mon, 23 Jan 2017 20:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751651AbdAWUoS (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 15:44:18 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33137 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750723AbdAWUoR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 15:44:17 -0500
Received: by mail-pf0-f181.google.com with SMTP id y143so43790091pfb.0
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 12:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qGyH8r27uAijXOKpLAtL4G7e2V9lt0xAa6Pz93Dn1Ac=;
        b=gnek4H6R9w/6LDCeFkBEBRtoQ/bhtcFuh4ke8ZbwfeIcMzDPHeKHcHmtiXiHqafcFJ
         9M0vN6WcqBgUE+U7fMnXs6bMWN5hb0HohscbrVJYPkr3pIo1ow9mlB8r5vgXrY9wzZY+
         m19cCZUXxBmZ53IivQmjfFJbNbCrRZyZ4P9i2/nqSPO3hdJxjJWD71ur2KBqrkpLE57v
         hrZ11SjGvGnPxG9aSgLoZ+MSRkJEnvK4WjexN1SGFynxBhrvEtNrzfMDVkIFRahmLCv8
         x8jHZOv9VOo/M+1GJs03sv0JmPiSEWXvrxKAKeZs6bHbpqKn64OCrboTlWuyXuOmqdE6
         wcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qGyH8r27uAijXOKpLAtL4G7e2V9lt0xAa6Pz93Dn1Ac=;
        b=feTBe8MoftgdFNgIEcHthbSnqBGr/ea5dgrixMW67FSFKIC93cXWRCWL5qkNaUQfnB
         CRGaTjxEHMCbFSUzMCb3jn3NNb9giCfDTKnGWUQlktgnRGQFdUV9RsSyGoUFj0PwWyFc
         aoCK9LN2WzIZVyaecOPkz8vMoWNdgwNq5YcKxwASFlk2gSZHgdHy36Q6iP4FWmQRYisJ
         T042sCUEtzYpLS4ja+FG/zp9Flv2HEYQv0I4+SjSMp0JZFQZ437pqvf2mZdwTXWTJObt
         sQJ1XcsBnVUNKysTaWRN8KBPyT7xbDdu8eEyxUk3QLHJqL2A26WlrzGa4t5A/AU5KTzS
         YJ5Q==
X-Gm-Message-State: AIkVDXKYDzB70Ciq33rugy11VO+Nz4+3xYM1fTNcDoO87HyjMubksTyVYWo8VLmvBPJL0e2f
X-Received: by 10.84.211.7 with SMTP id b7mr45230816pli.82.1485203774401;
        Mon, 23 Jan 2017 12:36:14 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id z29sm39280832pgc.7.2017.01.23.12.36.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jan 2017 12:36:13 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com, pclouds@gmail.com
Subject: [PATCH v2 25/27] attr: store attribute stack in attr_check structure
Date:   Mon, 23 Jan 2017 12:35:23 -0800
Message-Id: <20170123203525.185058-26-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170123203525.185058-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
 <20170123203525.185058-1-bmwill@google.com>
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
 attr.c | 277 ++++++++++++++++++++++++++++++++++++++++++++---------------------
 attr.h |   3 +
 2 files changed, 193 insertions(+), 87 deletions(-)

diff --git a/attr.c b/attr.c
index 95456503e..d64d1959e 100644
--- a/attr.c
+++ b/attr.c
@@ -434,17 +434,16 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
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
@@ -467,6 +466,85 @@ static void free_attr_elem(struct attr_stack *e)
 	free(e);
 }
 
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
+static void drop_attr_stack(void)
+{
+	int i;
+
+	vector_lock();
+
+	for (i = 0; i < check_vector.nr; i++) {
+		struct attr_stack **stack = &check_vector.checks[i]->stack;
+
+		while (*stack) {
+			struct attr_stack *elem = *stack;
+			*stack = elem->prev;
+			attr_stack_free(elem);
+		}
+	}
+
+	vector_unlock();
+}
+
 static const char *builtin_attr[] = {
 	"[attr]binary -diff -merge -text",
 	NULL,
@@ -621,15 +699,6 @@ static void debug_set(const char *what, const char *match, struct git_attr *attr
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
@@ -638,6 +707,14 @@ static const char *git_etc_gitattributes(void)
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
@@ -657,47 +734,50 @@ static void push_stack(struct attr_stack **attr_stack_p,
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
@@ -714,13 +794,13 @@ static void prepare_attr_stack(const char *path, int dirlen)
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
@@ -728,18 +808,19 @@ static void prepare_attr_stack(const char *path, int dirlen)
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
@@ -754,33 +835,43 @@ static void prepare_attr_stack(const char *path, int dirlen)
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
 
+			next = read_attr(pathbuf.buf, 0);
+
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
@@ -831,20 +922,23 @@ static int fill_one(const char *what, struct attr_check_item *all_attrs,
 }
 
 static int fill(const char *path, int pathlen, int basename_offset,
-		struct attr_stack *stk, struct attr_check_item *all_attrs,
-		int rem)
+		const struct attr_stack *stack,
+		struct attr_check_item *all_attrs, int rem)
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
 
@@ -887,7 +981,6 @@ static void determine_macros(struct attr_check_item *all_attrs,
  */
 static void collect_some_attrs(const char *path, struct attr_check *check)
 {
-	struct attr_stack *stk;
 	int i, pathlen, rem, dirlen;
 	const char *cp, *last_slash = NULL;
 	int basename_offset;
@@ -905,9 +998,9 @@ static void collect_some_attrs(const char *path, struct attr_check *check)
 		dirlen = 0;
 	}
 
-	prepare_attr_stack(path, dirlen);
+	prepare_attr_stack(path, dirlen, &check->stack);
 	all_attrs_init(&g_attr_hashmap, check);
-	determine_macros(check->all_attrs, attr_stack);
+	determine_macros(check->all_attrs, check->stack);
 
 	if (check->check_nr) {
 		rem = 0;
@@ -924,8 +1017,7 @@ static void collect_some_attrs(const char *path, struct attr_check *check)
 	}
 
 	rem = check->all_attrs_nr;
-	for (stk = attr_stack; 0 < rem && stk; stk = stk->prev)
-		rem = fill(path, pathlen, basename_offset, stk, check->all_attrs, rem);
+	fill(path, pathlen, basename_offset, check->stack, check->all_attrs, rem);
 }
 
 int git_check_attr(const char *path, struct attr_check *check)
@@ -965,7 +1057,12 @@ void git_all_attrs(const char *path, struct attr_check *check)
 
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
@@ -1032,8 +1129,13 @@ void attr_check_clear(struct attr_check *check)
 
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
 
 void git_attr_set_direction(enum git_attr_direction new, struct index_state *istate)
@@ -1053,5 +1155,6 @@ void attr_start(void)
 {
 #ifndef NO_PTHREADS
 	pthread_mutex_init(&g_attr_hashmap.mutex, NULL);
+	pthread_mutex_init(&check_vector.mutex, NULL);
 #endif
 }
diff --git a/attr.h b/attr.h
index 9b4dc07d8..da7c3a229 100644
--- a/attr.h
+++ b/attr.h
@@ -4,6 +4,8 @@
 /* An attribute is a pointer to this opaque structure */
 struct git_attr;
 
+struct attr_stack;
+
 /*
  * Given a string, return the gitattribute object that
  * corresponds to it.
@@ -41,6 +43,7 @@ struct attr_check {
 	struct attr_check_item *check;
 	int all_attrs_nr;
 	struct attr_check_item *all_attrs;
+	struct attr_stack *stack;
 };
 
 extern struct attr_check *attr_check_alloc(void);
-- 
2.11.0.483.g087da7b7c-goog

