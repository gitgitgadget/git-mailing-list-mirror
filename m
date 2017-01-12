Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 769F21FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 23:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750900AbdALXze (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 18:55:34 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35907 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbdALXz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 18:55:26 -0500
Received: by mail-pf0-f177.google.com with SMTP id 189so20633569pfu.3
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 15:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=42ZXErpz3Ddp9QgaSYWi/Fg8uX6s1WKIFbcrv/mRH7Y=;
        b=smRK1L39gzSsp0wGrV1Mi2KP4yVKJ9Gw6zOonXOxFad9hoCnODbCMKC67v+v0uizzv
         uSUrEmrx2kwiurFQMFkEWFYLtyAEnqXMCz99JGYH7REEcStfD6lS/yWJUU+njYYB89jQ
         scDk2YFfhf3zyhIQuoWLC7Pn1ikh3OzkFKqBEoCpgpFES6wbCONmoy+6f1PGo/mWdlhT
         OCNqAdBO9IMt+78llIQ6FmN2bDRyPQ/zwqWVt88Owg5c8jTWTr9Gm9NJ+L6G/ysQRpsM
         fAA/KiTpRQ3ToZCDOif0wPu18nqXjod5Tod2+EXdn6JVcmrWXtYGJ8b76b/CGF87YHFL
         vLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=42ZXErpz3Ddp9QgaSYWi/Fg8uX6s1WKIFbcrv/mRH7Y=;
        b=L36nPoMh9wRjN0RYLfjhbBnG20ZTVbEzST67A2yuUFUUH5eefP/ZO75F/GpBIRShFV
         k58D/DrgOG0vEWLfybRYQe412QzIia1JiS/vjCOfm3hVyorW9zT/jj8LcAypXTELVZnj
         dZB7ROaC92oYh2VRkeT3tafvc6Zq8XvVUJqVOQ+CVwLf0rSuRcUJvP3kprj85IKoHccl
         uPElTtNUxAMVfyIHkoNXWJwipIfj5fXIQ+lDyuT+/tdQZzLYfv1p4rVCoD184Ja3s9gD
         qIPW4TCDvuSSLP/o6ZUilA82zB0A6JfnRxXpfBDWXxC90NlE9+OkPoZVQakhYsLXp9Zx
         UTRA==
X-Gm-Message-State: AIkVDXLXUCOGjlKBz3mDvGuBnX7BBxbIwV/OoL+Br8+NhVaroMux0Ds5ynXoGgcJUqAOhbYB
X-Received: by 10.98.210.3 with SMTP id c3mr19373148pfg.7.1484265282824;
        Thu, 12 Jan 2017 15:54:42 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id e6sm24312192pgf.4.2017.01.12.15.54.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jan 2017 15:54:41 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, gitster@pobox.com,
        pclouds@gmail.com, sbeller@google.com
Subject: [PATCH 25/27] attr: store attribute stacks in hashmap
Date:   Thu, 12 Jan 2017 15:53:52 -0800
Message-Id: <20170112235354.153403-26-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170112235354.153403-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The last big hurdle towards a thread-safe API for the attribute system
is the reliance on a global attribute stack that is modified during each
call into the attribute system.

This patch removes this global stack and instead a stack is retrieved or
constructed locally.  Since each of these stacks is only used as a
read-only structure once constructed, they can be stored in a hashmap
and shared between threads.  The key into the hashmap of attribute
stacks is, in the general case, the directory that corresponds to the
attribute stack frame.  For the core stack frames (builtin, system,
home, and info) a key of ".git/<name>-attr" is used to prevent potential
collisions since a directory or file named ".git" is disallowed.

One caveat with storing and sharing the stack frames like this is that
the info stack needs to be treated separately from the rest of the
attribute stack.  This is because each stack frame holds a pointer to
the stack that comes before it and if it was placed on top of the rest
of the attribute stack then this pointer would be different for each
attribute stack and wouldn't be able to be shared between threads.  In
order to allow for sharing the info stack frame it needs to be its own
isolated frame and can simply be processed first to have the same affect
of being at the top of the stack.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c | 375 +++++++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 235 insertions(+), 140 deletions(-)

diff --git a/attr.c b/attr.c
index 90f576044..78562592b 100644
--- a/attr.c
+++ b/attr.c
@@ -434,17 +434,19 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
  * .gitignore file and info/excludes file as a fallback.
  */
 
-/* NEEDSWORK: This will become per git_attr_check */
-static struct attr_stack {
-	struct attr_stack *prev;
+struct attr_stack {
+	const struct attr_stack *prev;
 	char *origin;
 	size_t originlen;
 	unsigned num_matches;
 	unsigned alloc;
 	struct match_attr **attrs;
-} *attr_stack;
+};
+
+/* Dictionary of stack frames; access should be surrounded by mutex */
+static struct attr_hashmap g_stack_hashmap;
 
-static void free_attr_elem(struct attr_stack *e)
+static void attr_stack_free(struct attr_stack *e)
 {
 	int i;
 	free(e->origin);
@@ -467,6 +469,25 @@ static void free_attr_elem(struct attr_stack *e)
 	free(e);
 }
 
+static void drop_attr_stack(void)
+{
+	struct hashmap_iter iter;
+	struct attr_hash_entry *e;
+
+	hashmap_lock(&g_stack_hashmap);
+
+	hashmap_iter_init(&g_stack_hashmap.map, &iter);
+	while ((e = hashmap_iter_next(&iter))) {
+		struct attr_stack *stack = e->value;
+		attr_stack_free(stack);
+		free(e);
+	}
+
+	hashmap_free(&g_stack_hashmap.map, 0);
+
+	hashmap_unlock(&g_stack_hashmap);
+}
+
 static const char *builtin_attr[] = {
 	"[attr]binary -diff -merge -text",
 	NULL,
@@ -621,15 +642,6 @@ static void debug_set(const char *what, const char *match, struct git_attr *attr
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
@@ -638,6 +650,14 @@ static const char *git_etc_gitattributes(void)
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
@@ -645,142 +665,208 @@ static int git_attr_system(void)
 
 static GIT_PATH_FUNC(git_path_info_attributes, INFOATTRIBUTES_FILE)
 
-static void push_stack(struct attr_stack **attr_stack_p,
-		       struct attr_stack *elem, char *origin, size_t originlen)
+/*
+ * This funciton should only be called from 'get_attr_stack()' or
+ * 'get_info_stack()', which already needs to acquire the lock to the stack
+ * hashmap, so there is no need to also acquire the lock in this function.
+ */
+static void push_stack(const struct attr_stack **attr_stack_p,
+		       struct attr_stack *elem,
+		       const char *origin, size_t originlen)
 {
 	if (elem) {
-		elem->origin = origin;
-		if (origin)
-			elem->originlen = originlen;
+		elem->origin = xmemdupz(origin, originlen);
+		elem->originlen = originlen;
 		elem->prev = *attr_stack_p;
 		*attr_stack_p = elem;
+		attr_hashmap_add(&g_stack_hashmap, elem->origin,
+				 elem->originlen, elem);
 	}
 }
 
-static void bootstrap_attr_stack(void)
+/*
+ * Return the path base that can be used in the pattern matching operation.  In
+ * order to enable storing the core and info stack frames in the stack hashmap
+ * an origin string other than NULL needed to be used.  Since git disallows
+ * tracking a ".git" file or directory the core and info stack frames have an
+ * origin string of ".git/<frame>" and must be converted to the empty string
+ * when being used to pattern match.
+ */
+static const char *attr_stack_get_base(const struct attr_stack *stack,
+				       size_t *baselen)
 {
-	struct attr_stack *elem;
+	const char *base;
 
-	if (attr_stack)
-		return;
+	if (starts_with(stack->origin, ".git/")) {
+		base = "";
+		*baselen = 0;
+	} else {
+		base = stack->origin;
+		*baselen = stack->originlen;
+	}
 
-	push_stack(&attr_stack, read_attr_from_array(builtin_attr), NULL, 0);
+	return base;
+}
 
-	if (git_attr_system())
-		push_stack(&attr_stack,
-			   read_attr_from_file(git_etc_gitattributes(), 1),
-			   NULL, 0);
+/*
+ * At the bottom of the attribute stack is the built-in
+ * set of attribute definitions, followed by the contents
+ * of $(prefix)/etc/gitattributes and a file specified by
+ * core.attributesfile.  Then, contents from
+ * .gitattribute files from directories closer to the
+ * root to the ones in deeper directories are pushed
+ * to the stack.  Finally, at the very top of the stack
+ * we always keep the contents of $GIT_DIR/info/attributes.
+ *
+ * When checking, we use entries from near the top of the
+ * stack, preferring $GIT_DIR/info/attributes, then
+ * .gitattributes in deeper directories to shallower ones,
+ * and finally use the built-in set as the default.
+ *
+ * The info stack needs to be treated separately from the rest of the attribute
+ * stack.  This is because each stack frame holds a pointer to the stack that
+ * comes before it and if it was placed on top of the rest of the attribute
+ * stack then this pointer would be different for each attribute stack and
+ * wouldn't be able to be shared between threads.  If the info stack is to be
+ * shared then it needs to be its own isolated frame and can simply be
+ * processed first to have the same affect of being at the top of the stack.
+ */
+static const struct attr_stack *get_info_stack(void)
+{
+	const struct attr_stack *info;
+	const char *key = ".git/info-attr";
+	size_t keylen = strlen(key);
 
-	if (!git_attributes_file)
-		git_attributes_file = xdg_config_home("attributes");
-	if (git_attributes_file)
-		push_stack(&attr_stack,
-			   read_attr_from_file(git_attributes_file, 1),
-			   NULL, 0);
-
-	if (!is_bare_repository() || direction == GIT_ATTR_INDEX) {
-		elem = read_attr(GITATTRIBUTES_FILE, 1);
-		push_stack(&attr_stack, elem, xstrdup(""), 0);
-		debug_push(elem);
+	hashmap_lock(&g_stack_hashmap);
+
+	info = attr_hashmap_get(&g_stack_hashmap, key, keylen);
+
+	if (!info) {
+		struct attr_stack *e = NULL;
+
+		if (startup_info->have_repository)
+			e = read_attr_from_file(git_path_info_attributes(), 1);
+
+		if (!e)
+			e = xcalloc(1, sizeof(struct attr_stack));
+		e->origin = xstrdup(key);
+		e->originlen = keylen;
+
+		attr_hashmap_add(&g_stack_hashmap, e->origin, e->originlen, e);
+		info = e;
 	}
 
-	if (startup_info->have_repository)
-		elem = read_attr_from_file(git_path_info_attributes(), 1);
-	else
-		elem = NULL;
+	hashmap_unlock(&g_stack_hashmap);
 
-	if (!elem)
-		elem = xcalloc(1, sizeof(*elem));
-	push_stack(&attr_stack, elem, NULL, 0);
+	return info;
 }
 
-static void prepare_attr_stack(const char *path, int dirlen)
+/*
+ * This funciton should only be called from 'get_attr_stack()', which already
+ * needs to acquire the lock to the stack hashmap, so there is no need to also
+ * acquire the lock in this function.
+ */
+static const struct attr_stack *core_attr_stack(void)
 {
-	struct attr_stack *elem, *info;
-	const char *cp;
+	const struct attr_stack *core;
 
-	/*
-	 * At the bottom of the attribute stack is the built-in
-	 * set of attribute definitions, followed by the contents
-	 * of $(prefix)/etc/gitattributes and a file specified by
-	 * core.attributesfile.  Then, contents from
-	 * .gitattribute files from directories closer to the
-	 * root to the ones in deeper directories are pushed
-	 * to the stack.  Finally, at the very top of the stack
-	 * we always keep the contents of $GIT_DIR/info/attributes.
-	 *
-	 * When checking, we use entries from near the top of the
-	 * stack, preferring $GIT_DIR/info/attributes, then
-	 * .gitattributes in deeper directories to shallower ones,
-	 * and finally use the built-in set as the default.
-	 */
-	bootstrap_attr_stack();
+	core = attr_hashmap_get(&g_stack_hashmap, "", 0);
 
-	/*
-	 * Pop the "info" one that is always at the top of the stack.
-	 */
-	info = attr_stack;
-	attr_stack = info->prev;
+	if (!core) {
+		struct attr_stack *e;
+		const char *key;
 
-	/*
-	 * Pop the ones from directories that are not the prefix of
-	 * the path we are checking. Break out of the loop when we see
-	 * the root one (whose origin is an empty string "") or the builtin
-	 * one (whose origin is NULL) without popping it.
-	 */
-	while (attr_stack->origin) {
-		int namelen = strlen(attr_stack->origin);
-
-		elem = attr_stack;
-		if (namelen <= dirlen &&
-		    !strncmp(elem->origin, path, namelen) &&
-		    (!namelen || path[namelen] == '/'))
-			break;
-
-		debug_pop(elem);
-		attr_stack = elem->prev;
-		free_attr_elem(elem);
-	}
+		/* builtin frame */
+		e = read_attr_from_array(builtin_attr);
+		key = ".git/builtin-attr";
+		push_stack(&core, e, key, strlen(key));
 
-	/*
-	 * Read from parent directories and push them down
-	 */
-	if (!is_bare_repository() || direction == GIT_ATTR_INDEX) {
-		/*
-		 * bootstrap_attr_stack() should have added, and the
-		 * above loop should have stopped before popping, the
-		 * root element whose attr_stack->origin is set to an
-		 * empty string.
-		 */
-		struct strbuf pathbuf = STRBUF_INIT;
-
-		assert(attr_stack->origin);
-		while (1) {
-			size_t len = strlen(attr_stack->origin);
-			char *origin;
-
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
+		/* system-wide frame */
+		if (git_attr_system()) {
+			e = read_attr_from_file(git_etc_gitattributes(), 1);
+			key = ".git/system-attr";
+			push_stack(&core, e, key, strlen(key));
 		}
 
-		strbuf_release(&pathbuf);
+		/* home directory */
+		if (get_home_gitattributes()) {
+			e = read_attr_from_file(get_home_gitattributes(), 1);
+			key = ".git/home-attr";
+			push_stack(&core, e, key, strlen(key));
+		}
+
+		/* root directory */
+		if (!is_bare_repository() || direction == GIT_ATTR_INDEX) {
+			e = read_attr(GITATTRIBUTES_FILE, 1);
+		} else {
+			e = xcalloc(1, sizeof(struct attr_stack));
+		}
+		key = "";
+		push_stack(&core, e, key, strlen(key));
 	}
 
-	/*
-	 * Finally push the "info" one at the top of the stack.
-	 */
-	push_stack(&attr_stack, info, NULL, 0);
+	assert(core);
+	return core;
+}
+
+static const struct attr_stack *get_attr_stack(const char *path, int dirlen)
+{
+	const struct attr_stack *stack = NULL;
+	struct strbuf key = STRBUF_INIT;
+
+	strbuf_addstr(&key, path);
+
+	hashmap_lock(&g_stack_hashmap);
+
+	/* Search for the deepest, pre-constructed stack frame */
+	while (key.len && !stack) {
+		size_t len = key.len;
+
+		/* Find start of the last component */
+		while (len > 0 && !is_dir_sep(key.buf[len - 1]))
+			len--;
+		/* Skip path-separator */
+		if (len > 0 && is_dir_sep(key.buf[len - 1]))
+			len--;
+		strbuf_setlen(&key, len);
+
+		stack = attr_hashmap_get(&g_stack_hashmap, key.buf, key.len);
+	}
+
+	/* At least start with the core stack */
+	if (!stack) {
+		stack = core_attr_stack();
+	}
+
+	/* Build up to the directory 'path' is in */
+	while (key.len < dirlen) {
+		size_t len = key.len;
+		struct attr_stack *next;
+
+		/* Skip path-separator */
+		if (len < dirlen && is_dir_sep(path[len]))
+			len++;
+		/* Find the end of the next component */
+		while (len < dirlen && !is_dir_sep(path[len]))
+			len++;
+
+		if (key.len > 0)
+			strbuf_addch(&key, '/');
+		strbuf_add(&key, path + key.len, (len - key.len));
+		strbuf_addf(&key, "/%s", GITATTRIBUTES_FILE);
+
+		next = read_attr(key.buf, 0);
+
+		/* reset the keybuffer to not include "/.gitattributes" */
+		strbuf_setlen(&key, len);
+
+		push_stack(&stack, next, key.buf, key.len);
+	}
+
+	hashmap_unlock(&g_stack_hashmap);
+
+	strbuf_release(&key);
+	return stack;
 }
 
 static int path_matches(const char *pathname, int pathlen,
@@ -831,20 +917,24 @@ static int fill_one(const char *what, struct attr_check_item *all_attrs,
 }
 
 static int fill(const char *path, int pathlen, int basename_offset,
-		struct attr_stack *stk, struct attr_check_item *all_attrs,
+		const struct attr_stack *stack, struct attr_check_item *all_attrs,
 		int rem)
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
+		size_t baselen;
+		const char *base = attr_stack_get_base(stack, &baselen);
+
+		for (i = stack->num_matches - 1; rem > 0 && i >= 0; i--) {
+			const struct match_attr *a = stack->attrs[i];
+			if (a->is_macro)
+				continue;
+			if (path_matches(path, pathlen, basename_offset,
+					 &a->u.pat, base, baselen))
+				rem = fill_one("fill", all_attrs, a, rem);
+		}
 	}
+
 	return rem;
 }
 
@@ -887,10 +977,11 @@ static void determine_macros(struct attr_check_item *all_attrs,
  */
 static void collect_some_attrs(const char *path, struct attr_check *check)
 {
-	struct attr_stack *stk;
 	int i, pathlen, rem, dirlen;
 	const char *cp, *last_slash = NULL;
 	int basename_offset;
+	const struct attr_stack *stack;
+	const struct attr_stack *info;
 
 	for (cp = path; *cp; cp++) {
 		if (*cp == '/' && cp[1])
@@ -905,9 +996,12 @@ static void collect_some_attrs(const char *path, struct attr_check *check)
 		dirlen = 0;
 	}
 
-	prepare_attr_stack(path, dirlen);
+	info = get_info_stack();
+	stack = get_attr_stack(path, dirlen);
+
 	all_attrs_init(&g_attr_hashmap, check);
-	determine_macros(check->all_attrs, attr_stack);
+	determine_macros(check->all_attrs, info);
+	determine_macros(check->all_attrs, stack);
 
 	if (check->check_nr) {
 		rem = 0;
@@ -924,8 +1018,8 @@ static void collect_some_attrs(const char *path, struct attr_check *check)
 	}
 
 	rem = check->all_attrs_nr;
-	for (stk = attr_stack; 0 < rem && stk; stk = stk->prev)
-		rem = fill(path, pathlen, basename_offset, stk, check->all_attrs, rem);
+	rem = fill(path, pathlen, basename_offset, info, check->all_attrs, rem);
+	fill(path, pathlen, basename_offset, stack, check->all_attrs, rem);
 }
 
 int git_check_attr(const char *path, struct attr_check *check)
@@ -1052,4 +1146,5 @@ void git_attr_set_direction(enum git_attr_direction new, struct index_state *ist
 void attr_start(void)
 {
 	pthread_mutex_init(&g_attr_hashmap.mutex, NULL);
+	pthread_mutex_init(&g_stack_hashmap.mutex, NULL);
 }
-- 
2.11.0.390.gc69c2f50cf-goog

