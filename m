Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CD6320989
	for <e@80x24.org>; Tue, 11 Oct 2016 00:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752932AbcJKAWS (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 20:22:18 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35586 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752910AbcJKAWO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 20:22:14 -0400
Received: by mail-pa0-f41.google.com with SMTP id qn10so3911645pac.2
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 17:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u5fIZP5Cx1rr/K20qziKoyZRjPHWR+ydj9Flx7ruSh4=;
        b=Y0d0soXq0W6EAXIyCUXg91K/4US9B5xckE2gVeg4asPWt2EPqQ0WnBOvahB2SOB/br
         uShM2Cg4+vsEQMzH3rkt+9PNeTRWwvZKeqr4Hu0G8enz+QUojhKUMVbgY6zDNcWZtp0b
         VXJVox2wOpd6n4BHUP7X3L7m2g/0uV8zhJDJslbd24CeduHMUtjWxe0f14IxXveMrsns
         2TUCLvdJJ4o/oRCDZQeeschwWwOppr9UXeobRzMIdO6+9QN9toLeiqlwOMfCKPniN/V0
         vqTniQv0jUSslaWTZizim6iPCzO2iGkvoyZyS8s/Gqp8iuyHxc1BgC3QayULmTO4mW60
         BEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u5fIZP5Cx1rr/K20qziKoyZRjPHWR+ydj9Flx7ruSh4=;
        b=jQST2GTgVtBM6LHGBbR7/gatteEEHIVTnEM0ZxZpsc0cHJFehQvcq3UL9vGqE5s3Zr
         K3TjJpycqB4eeLWEz9GSjH+sGh4CO3cZpn7F0++rp2MhucCN+v6AlU7MSKzT99J0a3c9
         6oqVTun2Ofh0IYHt9XzB+am4+WAiADKcuagTvqfjAyJrb/+qGzTY8j3VIiDg6Veysj6Q
         kIiwSzZJoDoMNaU4qfTCoT/8XgnjTEMZ1Yeb64JyDEUSzf+J/Nc7FSWRmElmHZLT86eN
         FbtNsYnbEe8hhNiRBoIGgzEhysYoHS27dA8xfFROa9V9lEZA1UeyFfRKYmY6gH27SZNf
         +ByA==
X-Gm-Message-State: AA6/9Rlw5NQm8kGEtbTXbLm77fCcfCVmu7iihCNTMv4ioo1H3u4TcsgLDZTh/REF4EB9LwZN
X-Received: by 10.66.197.228 with SMTP id ix4mr1694705pac.47.1476145332981;
        Mon, 10 Oct 2016 17:22:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b8ee:61f5:e989:77a7])
        by smtp.gmail.com with ESMTPSA id k89sm546316pfg.6.2016.10.10.17.22.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Oct 2016 17:22:12 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 28/28] attr: convert to new threadsafe API
Date:   Mon, 10 Oct 2016 17:21:15 -0700
Message-Id: <20161011002115.23312-29-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.382.ga23ca1b.dirty
In-Reply-To: <20161011002115.23312-1-sbeller@google.com>
References: <20161011002115.23312-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This revamps the API of the attr subsystem to be thread safe.
Before we had the question and its results in one struct type.
The typical usage of the API was

    static struct git_attr_check;

    if (!check)
        check = git_attr_check_initl("text", NULL);

    git_check_attr(path, check);
    act_on(check->value[0]);

This has a couple of issues when it comes to thread safety:

* the initialization is racy in this implementation. To make it
  thread safe, we need to acquire a mutex, such that only one
  thread is executing the code in git_attr_check_initl.
  As we do not want to introduce a mutex at each call site,
  this is best done in the attr code. However to do so, we need
  to have access to the `check` variable, i.e. the API has to
  look like
    git_attr_check_initl(struct git_attr_check*, ...);
  Then one of the threads calling git_attr_check_initl will
  acquire the mutex and init the `check`, while all other threads
  will wait on the mutex just to realize they're late to the
  party and they'll return with no work done.

* While the check for attributes to be questioned only need to
  be initalized once as that part will be read only after its
  initialisation, the answer may be different for each path.
  Because of that we need to decouple the check and the answer,
  such that each thread can obtain an answer for the path it
  is currently processing.

This commit only changes the API, i.e. this doesn't implement
actual thread safety. However a later commit that introduces
thread safety needs to touch code in attr.c only and doesn't
have to add changes all over the place.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/technical/api-gitattributes.txt |  80 +++++++++++++-------
 archive.c                                     |  11 ++-
 attr.c                                        | 101 +++++++++++++++-----------
 attr.h                                        |  67 ++++++++++-------
 builtin/check-attr.c                          |  27 ++++---
 builtin/pack-objects.c                        |   9 ++-
 convert.c                                     |  36 ++++-----
 ll-merge.c                                    |  21 ++++--
 userdiff.c                                    |  15 ++--
 ws.c                                          |  13 ++--
 10 files changed, 230 insertions(+), 150 deletions(-)

diff --git a/Documentation/technical/api-gitattributes.txt b/Documentation/technical/api-gitattributes.txt
index 92fc32a..2059aab 100644
--- a/Documentation/technical/api-gitattributes.txt
+++ b/Documentation/technical/api-gitattributes.txt
@@ -8,6 +8,18 @@ attributes to set of paths.
 Data Structure
 --------------
 
+extern struct git_attr *git_attr(const char *);
+
+/*
+ * Return the name of the attribute represented by the argument.  The
+ * return value is a pointer to a null-delimited string that is part
+ * of the internal data structure; it should not be modified or freed.
+ */
+extern const char *git_attr_name(const struct git_attr *);
+
+extern int attr_name_valid(const char *name, size_t namelen);
+extern void invalid_attr_name_message(struct strbuf *, const char *, int);
+
 `struct git_attr`::
 
 	An attribute is an opaque object that is identified by its name.
@@ -16,15 +28,17 @@ Data Structure
 	of no interest to the calling programs.  The name of the
 	attribute can be retrieved by calling `git_attr_name()`.
 
-`struct git_attr_check_elem`::
-
-	This structure represents one attribute and its value.
-
 `struct git_attr_check`::
 
-	This structure represents a collection of `git_attr_check_elem`.
+	This structure represents a collection of `struct git_attrs`.
 	It is passed to `git_check_attr()` function, specifying the
-	attributes to check, and receives their values.
+	attributes to check, and receives their values into a corresponding
+	`struct git_attr_result`.
+
+`struct git_attr_result`::
+
+	This structure represents a collection of results to its
+	corresponding `struct git_attr_check`, that has the same order.
 
 
 Attribute Values
@@ -56,16 +70,22 @@ Querying Specific Attributes
 * Prepare `struct git_attr_check` using git_attr_check_initl()
   function, enumerating the names of attributes whose values you are
   interested in, terminated with a NULL pointer.  Alternatively, an
-  empty `struct git_attr_check` can be prepared by calling
-  `git_attr_check_alloc()` function and then attributes you want to
-  ask about can be added to it with `git_attr_check_append()`
-  function.
+  empty `struct git_attr_check` as alloced by git_attr_check_alloc()
+  can be prepared by calling `git_attr_check_alloc()` function and
+  then attributes you want to ask about can be added to it with
+  `git_attr_check_append()` function.
+  git_attr_check_initl is thread safe, i.e. you can call it
+  from different threads at the same time; internally however only one
+  call at a time is processed. If the calls from different threads have
+  the same arguments, the returned `git_attr_check` may be the same.
 
-* Call `git_check_attr()` to check the attributes for the path.
+* Call `git_check_attr()` to check the attributes for the path,
+  the returned `git_attr_result` contains the result.
 
-* Inspect `git_attr_check` structure to see how each of the
-  attribute in the array is defined for the path.
+* Inspect the returned `git_attr_result` structure to see how
+  each of the attribute in the array is defined for the path.
 
+* Do not free the result as the memory is owned by the attr subsystem.
 
 Example
 -------
@@ -89,15 +109,20 @@ static void setup_check(void)
 
 ------------
 	const char *path;
+	struct git_attr_result *result;
 
 	setup_check();
-	git_check_attr(path, check);
+	result = git_check_attr(path, check);
 ------------
 
-. Act on `.value` member of the result, left in `check->check[]`:
+The `result` must not be free'd as it is owned by the attr subsystem.
+It is reused by the same thread, so a subsequent call to git_check_attr
+in the same thread will overwrite the result.
+
+. Act on `result->value[]`:
 
 ------------
-	const char *value = check->check[0].value;
+	const char *value = result->value[0];
 
 	if (ATTR_TRUE(value)) {
 		The attribute is Set, by listing only the name of the
@@ -123,6 +148,8 @@ the first step in the above would be different.
 static struct git_attr_check *check;
 static void setup_check(const char **argv)
 {
+	if (check)
+		return; /* already done */
 	check = git_attr_check_alloc();
 	while (*argv) {
 		struct git_attr *attr = git_attr(*argv);
@@ -138,17 +165,20 @@ Querying All Attributes
 
 To get the values of all attributes associated with a file:
 
-* Prepare an empty `git_attr_check` structure by calling
-  `git_attr_check_alloc()`.
+* Setup a local variables on the stack for both the question
+  `struct git_attr_check` as well as the result `struct git_attr_result`.
+  Zero them out via their respective _INIT macro.
 
-* Call `git_all_attrs()`, which populates the `git_attr_check`
-  with the attributes attached to the path.
+* Call `git_all_attrs()`
 
-* Iterate over the `git_attr_check.check[]` array to examine
-  the attribute names and values.  The name of the attribute
-  described by a  `git_attr_check.check[]` object can be retrieved via
-  `git_attr_name(check->check[i].attr)`.  (Please note that no items
+* Iterate over the `git_attr_check.attr[]` array to examine the
+  attribute names.  The name of the attribute described by a
+  `git_attr_check.attr[]` object can be retrieved via
+  `git_attr_name(check->attr[i])`.  (Please note that no items
   will be returned for unset attributes, so `ATTR_UNSET()` will return
   false for all returned `git_array_check` objects.)
+  The respective value for an attribute can be found in the same
+  index position in of `git_attr_result`.
 
-* Free the `git_array_check` by calling `git_attr_check_free()`.
+* Clear the local variables by calling `git_attr_check_clear()` and
+  `git_attr_result_clear()`.
diff --git a/archive.c b/archive.c
index 11e3951..795678a 100644
--- a/archive.c
+++ b/archive.c
@@ -111,6 +111,7 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 	struct archiver_args *args = c->args;
 	write_archive_entry_fn_t write_entry = c->write_entry;
 	static struct git_attr_check *check;
+	struct git_attr_result *result;
 	const char *path_without_prefix;
 	int err;
 
@@ -125,11 +126,13 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 	path_without_prefix = path.buf + args->baselen;
 
 	if (!check)
-		check = git_attr_check_initl("export-ignore", "export-subst", NULL);
-	if (!git_check_attr(path_without_prefix, check)) {
-		if (ATTR_TRUE(check->check[0].value))
+		git_attr_check_initl(&check, "export-ignore", "export-subst", NULL);
+
+	result = git_check_attr(path_without_prefix, check);
+	if (result) {
+		if (ATTR_TRUE(result->value[0]))
 			return 0;
-		args->convert = ATTR_TRUE(check->check[1].value);
+		args->convert = ATTR_TRUE(result->value[1]);
 	}
 
 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
diff --git a/attr.c b/attr.c
index fea0f10..12205b7 100644
--- a/attr.c
+++ b/attr.c
@@ -55,6 +55,16 @@ static struct git_attr *(git_attr_hash[HASHSIZE]);
  */
 static int cannot_trust_maybe_real;
 
+/*
+ * Send one or more git_attr_check to git_check_attrs(), and
+ * each 'value' member tells what its value is.
+ * Unset one is returned as NULL.
+ */
+struct git_attr_check_elem {
+	const struct git_attr *attr;
+	const char *value;
+};
+
 /* NEEDSWORK: This will become per git_attr_check */
 static struct git_attr_check_elem *check_all_attr;
 
@@ -781,7 +791,7 @@ static int macroexpand_one(int nr, int rem)
 
 static int attr_check_is_dynamic(const struct git_attr_check *check)
 {
-	return (void *)(check->check) != (void *)(check + 1);
+	return (void *)(check->attr) != (void *)(check + 1);
 }
 
 static void empty_attr_check_elems(struct git_attr_check *check)
@@ -799,7 +809,8 @@ static void empty_attr_check_elems(struct git_attr_check *check)
  * any and all attributes that are visible are collected in it.
  */
 static void collect_some_attrs(const char *path, int pathlen,
-			       struct git_attr_check *check, int collect_all)
+			       struct git_attr_check *check,
+			       struct git_attr_result *result, int collect_all)
 
 {
 	struct attr_stack *stk;
@@ -825,13 +836,11 @@ static void collect_some_attrs(const char *path, int pathlen,
 		check_all_attr[i].value = ATTR__UNKNOWN;
 
 	if (!collect_all && !cannot_trust_maybe_real) {
-		struct git_attr_check_elem *celem = check->check;
-
 		rem = 0;
 		for (i = 0; i < check->check_nr; i++) {
-			if (!celem[i].attr->maybe_real) {
+			if (!check->attr[i]->maybe_real) {
 				struct git_attr_check_elem *c;
-				c = check_all_attr + celem[i].attr->attr_nr;
+				c = check_all_attr + check->attr[i]->attr_nr;
 				c->value = ATTR__UNSET;
 				rem++;
 			}
@@ -845,38 +854,45 @@ static void collect_some_attrs(const char *path, int pathlen,
 		rem = fill(path, pathlen, basename_offset, stk, rem);
 
 	if (collect_all) {
-		empty_attr_check_elems(check);
 		for (i = 0; i < attr_nr; i++) {
 			const struct git_attr *attr = check_all_attr[i].attr;
 			const char *value = check_all_attr[i].value;
 			if (value == ATTR__UNSET || value == ATTR__UNKNOWN)
 				continue;
-			git_attr_check_append(check, attr)->value = value;
+
+			git_attr_check_append(check, attr);
+
+			ALLOC_GROW(result->value,
+				   result->check_nr + 1,
+				   result->check_alloc);
+			result->value[result->check_nr++] = value;
 		}
 	}
 }
 
 static int git_check_attrs(const char *path, int pathlen,
-			   struct git_attr_check *check)
+			   struct git_attr_check *check,
+			   struct git_attr_result *result)
 {
 	int i;
-	struct git_attr_check_elem *celem = check->check;
 
-	collect_some_attrs(path, pathlen, check, 0);
+	collect_some_attrs(path, pathlen, check, result, 0);
 
 	for (i = 0; i < check->check_nr; i++) {
-		const char *value = check_all_attr[celem[i].attr->attr_nr].value;
+		const char *value = check_all_attr[check->attr[i]->attr_nr].value;
 		if (value == ATTR__UNKNOWN)
 			value = ATTR__UNSET;
-		celem[i].value = value;
+		result->value[i] = value;
 	}
 
 	return 0;
 }
 
-void git_all_attrs(const char *path, struct git_attr_check *check)
+void git_all_attrs(const char *path,
+		   struct git_attr_check *check,
+		   struct git_attr_result *result)
 {
-	collect_some_attrs(path, strlen(path), check, 1);
+	collect_some_attrs(path, strlen(path), check, result, 1);
 }
 
 void git_attr_set_direction(enum git_attr_direction new, struct index_state *istate)
@@ -892,36 +908,41 @@ void git_attr_set_direction(enum git_attr_direction new, struct index_state *ist
 	use_index = istate;
 }
 
-static int git_check_attr_counted(const char *path, int pathlen,
-				  struct git_attr_check *check)
+struct git_attr_result *git_check_attr(const char *path,
+				       struct git_attr_check *check)
 {
-	check->finalized = 1;
-	return git_check_attrs(path, pathlen, check);
-}
+	static struct git_attr_result *result;
+	if (!result)
+		result = xcalloc(1, sizeof(*result));
 
-int git_check_attr(const char *path, struct git_attr_check *check)
-{
-	return git_check_attr_counted(path, strlen(path), check);
+	ALLOC_GROW(result->value, check->check_nr, result->check_alloc);
+	result->check_nr = check->check_nr;
+
+	check->finalized = 1;
+	git_check_attrs(path, strlen(path), check, result);
+	return result;
 }
 
-struct git_attr_check *git_attr_check_initl(const char *one, ...)
+extern void git_attr_check_initl(struct git_attr_check **check_,
+				 const char *one, ...)
 {
-	struct git_attr_check *check;
 	int cnt;
 	va_list params;
 	const char *param;
+	struct git_attr_check *check;
 
 	va_start(params, one);
 	for (cnt = 1; (param = va_arg(params, const char *)) != NULL; cnt++)
 		;
 	va_end(params);
+
 	check = xcalloc(1,
-			sizeof(*check) + cnt * sizeof(*(check->check)));
+			sizeof(*check) + cnt * sizeof(*(check->attr)));
 	check->check_nr = cnt;
 	check->finalized = 1;
-	check->check = (struct git_attr_check_elem *)(check + 1);
+	check->attr = (const struct git_attr **)(check + 1);
 
-	check->check[0].attr = git_attr(one);
+	check->attr[0] = git_attr(one);
 	va_start(params, one);
 	for (cnt = 1; cnt < check->check_nr; cnt++) {
 		struct git_attr *attr;
@@ -932,10 +953,10 @@ struct git_attr_check *git_attr_check_initl(const char *one, ...)
 		attr = git_attr(param);
 		if (!attr)
 			die("BUG: %s: not a valid attribute name", param);
-		check->check[cnt].attr = attr;
+		check->attr[cnt] = attr;
 	}
 	va_end(params);
-	return check;
+	*check_ = check;
 }
 
 struct git_attr_check *git_attr_check_alloc(void)
@@ -943,18 +964,15 @@ struct git_attr_check *git_attr_check_alloc(void)
 	return xcalloc(1, sizeof(struct git_attr_check));
 }
 
-struct git_attr_check_elem *git_attr_check_append(struct git_attr_check *check,
-						  const struct git_attr *attr)
+void git_attr_check_append(struct git_attr_check *check,
+			   const struct git_attr *attr)
 {
-	struct git_attr_check_elem *elem;
 	if (check->finalized)
 		die("BUG: append after git_attr_check structure is finalized");
 	if (!attr_check_is_dynamic(check))
 		die("BUG: appending to a statically initialized git_attr_check");
-	ALLOC_GROW(check->check, check->check_nr + 1, check->check_alloc);
-	elem = &check->check[check->check_nr++];
-	elem->attr = attr;
-	return elem;
+	ALLOC_GROW(check->attr, check->check_nr + 1, check->check_alloc);
+	check->attr[check->check_nr++] = attr;
 }
 
 void git_attr_check_clear(struct git_attr_check *check)
@@ -962,12 +980,13 @@ void git_attr_check_clear(struct git_attr_check *check)
 	empty_attr_check_elems(check);
 	if (!attr_check_is_dynamic(check))
 		die("BUG: clearing a statically initialized git_attr_check");
-	free(check->check);
+	free(check->attr);
 	check->check_alloc = 0;
 }
 
-void git_attr_check_free(struct git_attr_check *check)
+void git_attr_result_clear(struct git_attr_result *result)
 {
-	git_attr_check_clear(check);
-	free(check);
+	free(result->value);
+	result->check_nr = 0;
+	result->check_alloc = 0;
 }
diff --git a/attr.h b/attr.h
index 163fcd6..30bed1e 100644
--- a/attr.h
+++ b/attr.h
@@ -10,6 +10,13 @@ struct git_attr;
  */
 extern struct git_attr *git_attr(const char *);
 
+/*
+ * Return the name of the attribute represented by the argument.  The
+ * return value is a pointer to a null-delimited string that is part
+ * of the internal data structure; it should not be modified or freed.
+ */
+extern const char *git_attr_name(const struct git_attr *);
+
 extern int attr_name_valid(const char *name, size_t namelen);
 extern void invalid_attr_name_message(struct strbuf *, const char *, int);
 
@@ -22,44 +29,52 @@ extern const char git_attr__false[];
 #define ATTR_FALSE(v) ((v) == git_attr__false)
 #define ATTR_UNSET(v) ((v) == NULL)
 
-/*
- * Send one or more git_attr_check to git_check_attrs(), and
- * each 'value' member tells what its value is.
- * Unset one is returned as NULL.
- */
-struct git_attr_check_elem {
-	const struct git_attr *attr;
-	const char *value;
-};
-
 struct git_attr_check {
 	int finalized;
 	int check_nr;
 	int check_alloc;
-	struct git_attr_check_elem *check;
+	const struct git_attr **attr;
 };
+#define GIT_ATTR_CHECK_INIT {0, 0, 0, NULL}
 
-extern struct git_attr_check *git_attr_check_initl(const char *, ...);
-extern int git_check_attr(const char *path, struct git_attr_check *);
+struct git_attr_result {
+	int check_nr;
+	int check_alloc;
+	const char **value;
+};
+#define GIT_ATTR_RESULT_INIT {0, 0, NULL}
 
+/*
+ * Initialize the `git_attr_check` via one of the following three functions:
+ *
+ * git_attr_check_alloc allocates an empty check, add more attributes via
+ *                      git_attr_check_append.
+ * git_all_attrs        allocates a check and fills in all attributes that
+ *                      are set for the given path.
+ * git_attr_check_initl takes a pointer to where the check will be initialized,
+ *                      followed by all attributes that are to be checked.
+ *                      This makes it potentially thread safe as it could
+ *                      internally have a mutex for that memory location.
+ *                      Currently it is not thread safe!
+ */
 extern struct git_attr_check *git_attr_check_alloc(void);
-extern struct git_attr_check_elem *git_attr_check_append(struct git_attr_check *, const struct git_attr *);
+extern void git_attr_check_append(struct git_attr_check *, const struct git_attr *);
+extern void git_all_attrs(const char *path, struct git_attr_check *, struct git_attr_result *);
+extern void git_attr_check_initl(struct git_attr_check **, const char *, ...);
 
-extern void git_attr_check_clear(struct git_attr_check *);
-extern void git_attr_check_free(struct git_attr_check *);
+/* Query a path for its attributes */
+extern struct git_attr_result *git_check_attr(const char *path,
+					      struct git_attr_check *);
 
-/*
- * Return the name of the attribute represented by the argument.  The
- * return value is a pointer to a null-delimited string that is part
- * of the internal data structure; it should not be modified or freed.
+/**
+ * Free or clear the result struct. The underlying strings are not free'd
+ * as they are globally known.
  */
-extern const char *git_attr_name(const struct git_attr *);
+extern void git_attr_result_free(struct git_attr_result *);
+extern void git_attr_result_clear(struct git_attr_result *);
+
+extern void git_attr_check_clear(struct git_attr_check *);
 
-/*
- * Retrieve all attributes that apply to the specified path.
- * check holds the attributes and their values.
- */
-void git_all_attrs(const char *path, struct git_attr_check *check);
 
 enum git_attr_direction {
 	GIT_ATTR_CHECKIN,
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index ec61476..609b192 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -24,13 +24,17 @@ static const struct option check_attr_options[] = {
 	OPT_END()
 };
 
-static void output_attr(struct git_attr_check *check, const char *file)
+static void output_attr(struct git_attr_check *check,
+			struct git_attr_result *result, const char *file)
 {
 	int j;
 	int cnt = check->check_nr;
 
+	if (check->check_nr != result->check_nr)
+		die("BUG: confused check and result internally");
+
 	for (j = 0; j < cnt; j++) {
-		const char *value = check->check[j].value;
+		const char *value = result->value[j];
 
 		if (ATTR_TRUE(value))
 			value = "set";
@@ -44,11 +48,11 @@ static void output_attr(struct git_attr_check *check, const char *file)
 			       "%s%c" /* attrname */
 			       "%s%c" /* attrvalue */,
 			       file, 0,
-			       git_attr_name(check->check[j].attr), 0, value, 0);
+			       git_attr_name(check->attr[j]), 0, value, 0);
 		} else {
 			quote_c_style(file, NULL, stdout, 0);
 			printf(": %s: %s\n",
-			       git_attr_name(check->check[j].attr), value);
+			       git_attr_name(check->attr[j]), value);
 		}
 	}
 }
@@ -60,14 +64,17 @@ static void check_attr(const char *prefix,
 	char *full_path =
 		prefix_path(prefix, prefix ? strlen(prefix) : 0, file);
 	if (check != NULL) {
-		if (git_check_attr(full_path, check))
+		struct git_attr_result *result = git_check_attr(full_path, check);
+		if (!result)
 			die("git_check_attr died");
-		output_attr(check, file);
+		output_attr(check, result, file);
 	} else {
-		check = git_attr_check_alloc();
-		git_all_attrs(full_path, check);
-		output_attr(check, file);
-		git_attr_check_free(check);
+		struct git_attr_check check = GIT_ATTR_CHECK_INIT;
+		struct git_attr_result result = GIT_ATTR_RESULT_INIT;
+		git_all_attrs(full_path, &check, &result);
+		output_attr(&check, &result, file);
+		git_attr_result_clear(&result);
+		git_attr_check_clear(&check);
 	}
 	free(full_path);
 }
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index df4e6b6..fa8d7a9 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -898,12 +898,15 @@ static void write_pack_file(void)
 static int no_try_delta(const char *path)
 {
 	static struct git_attr_check *check;
+	struct git_attr_result *result;
 
 	if (!check)
-		check = git_attr_check_initl("delta", NULL);
-	if (git_check_attr(path, check))
+		git_attr_check_initl(&check, "delta", NULL);
+
+	result = git_check_attr(path, check);
+	if (!result)
 		return 0;
-	if (ATTR_FALSE(check->check[0].value))
+	if (ATTR_FALSE(result->value[0]))
 		return 1;
 	return 0;
 }
diff --git a/convert.c b/convert.c
index bb2435a..8f1c405 100644
--- a/convert.c
+++ b/convert.c
@@ -718,10 +718,8 @@ static int ident_to_worktree(const char *path, const char *src, size_t len,
 	return 1;
 }
 
-static enum crlf_action git_path_check_crlf(struct git_attr_check_elem *check)
+static enum crlf_action git_path_check_crlf(const char *value)
 {
-	const char *value = check->value;
-
 	if (ATTR_TRUE(value))
 		return CRLF_TEXT;
 	else if (ATTR_FALSE(value))
@@ -735,10 +733,8 @@ static enum crlf_action git_path_check_crlf(struct git_attr_check_elem *check)
 	return CRLF_UNDEFINED;
 }
 
-static enum eol git_path_check_eol(struct git_attr_check_elem *check)
+static enum eol git_path_check_eol(const char *value)
 {
-	const char *value = check->value;
-
 	if (ATTR_UNSET(value))
 		;
 	else if (!strcmp(value, "lf"))
@@ -748,9 +744,8 @@ static enum eol git_path_check_eol(struct git_attr_check_elem *check)
 	return EOL_UNSET;
 }
 
-static struct convert_driver *git_path_check_convert(struct git_attr_check_elem *check)
+static struct convert_driver *git_path_check_convert(const char *value)
 {
-	const char *value = check->value;
 	struct convert_driver *drv;
 
 	if (ATTR_TRUE(value) || ATTR_FALSE(value) || ATTR_UNSET(value))
@@ -761,10 +756,8 @@ static struct convert_driver *git_path_check_convert(struct git_attr_check_elem
 	return NULL;
 }
 
-static int git_path_check_ident(struct git_attr_check_elem *check)
+static int git_path_check_ident(const char *value)
 {
-	const char *value = check->value;
-
 	return !!ATTR_TRUE(value);
 }
 
@@ -778,25 +771,26 @@ struct conv_attrs {
 static void convert_attrs(struct conv_attrs *ca, const char *path)
 {
 	static struct git_attr_check *check;
+	struct git_attr_result *result;
 
 	if (!check) {
-		check = git_attr_check_initl("crlf", "ident",
-					     "filter", "eol", "text",
-					     NULL);
+		git_attr_check_initl(&check, "crlf", "ident", "filter",
+				     "eol", "text", NULL);
 		user_convert_tail = &user_convert;
 		git_config(read_convert_config, NULL);
 	}
 
-	if (!git_check_attr(path, check)) {
-		struct git_attr_check_elem *ccheck = check->check;
-		ca->crlf_action = git_path_check_crlf(ccheck + 4);
+	result = git_check_attr(path, check);
+
+	if (result) {
+		ca->crlf_action = git_path_check_crlf(result->value[4]);
 		if (ca->crlf_action == CRLF_UNDEFINED)
-			ca->crlf_action = git_path_check_crlf(ccheck + 0);
+			ca->crlf_action = git_path_check_crlf(result->value[0]);
 		ca->attr_action = ca->crlf_action;
-		ca->ident = git_path_check_ident(ccheck + 1);
-		ca->drv = git_path_check_convert(ccheck + 2);
+		ca->ident = git_path_check_ident(result->value[1]);
+		ca->drv = git_path_check_convert(result->value[2]);
 		if (ca->crlf_action != CRLF_BINARY) {
-			enum eol eol_attr = git_path_check_eol(ccheck + 3);
+			enum eol eol_attr = git_path_check_eol(result->value[3]);
 			if (ca->crlf_action == CRLF_AUTO && eol_attr == EOL_LF)
 				ca->crlf_action = CRLF_AUTO_INPUT;
 			else if (ca->crlf_action == CRLF_AUTO && eol_attr == EOL_CRLF)
diff --git a/ll-merge.c b/ll-merge.c
index bc6479c..385c26a 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -355,6 +355,7 @@ int ll_merge(mmbuffer_t *result_buf,
 {
 	static struct git_attr_check *check;
 	static const struct ll_merge_options default_opts;
+	struct git_attr_result *result;
 	const char *ll_driver_name = NULL;
 	int marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
 	const struct ll_merge_driver *driver;
@@ -369,12 +370,13 @@ int ll_merge(mmbuffer_t *result_buf,
 	}
 
 	if (!check)
-		check = git_attr_check_initl("merge", "conflict-marker-size", NULL);
+		git_attr_check_initl(&check, "merge", "conflict-marker-size", NULL);
 
-	if (!git_check_attr(path, check)) {
-		ll_driver_name = check->check[0].value;
-		if (check->check[1].value) {
-			marker_size = atoi(check->check[1].value);
+	result = git_check_attr(path, check);
+	if (result) {
+		ll_driver_name = result->value[0];
+		if (result->value[1]) {
+			marker_size = atoi(result->value[1]);
 			if (marker_size <= 0)
 				marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
 		}
@@ -394,12 +396,15 @@ int ll_merge(mmbuffer_t *result_buf,
 int ll_merge_marker_size(const char *path)
 {
 	static struct git_attr_check *check;
+	struct git_attr_result *result;
 	int marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
 
 	if (!check)
-		check = git_attr_check_initl("conflict-marker-size", NULL);
-	if (!git_check_attr(path, check) && check->check[0].value) {
-		marker_size = atoi(check->check[0].value);
+		git_attr_check_initl(&check, "conflict-marker-size", NULL);
+
+	result = git_check_attr(path, check);
+	if (result && result->value[0]) {
+		marker_size = atoi(result->value[0]);
 		if (marker_size <= 0)
 			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
 	}
diff --git a/userdiff.c b/userdiff.c
index 46dfd32..afc142a 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -263,21 +263,24 @@ struct userdiff_driver *userdiff_find_by_name(const char *name) {
 struct userdiff_driver *userdiff_find_by_path(const char *path)
 {
 	static struct git_attr_check *check;
+	struct git_attr_result *result;
 
 	if (!check)
-		check = git_attr_check_initl("diff", NULL);
+		git_attr_check_initl(&check, "diff", NULL);
 	if (!path)
 		return NULL;
-	if (git_check_attr(path, check))
+
+	result = git_check_attr(path, check);
+	if (!result)
 		return NULL;
 
-	if (ATTR_TRUE(check->check[0].value))
+	if (ATTR_TRUE(result->value[0]))
 		return &driver_true;
-	if (ATTR_FALSE(check->check[0].value))
+	if (ATTR_FALSE(result->value[0]))
 		return &driver_false;
-	if (ATTR_UNSET(check->check[0].value))
+	if (ATTR_UNSET(result->value[0]))
 		return NULL;
-	return userdiff_find_by_name(check->check[0].value);
+	return userdiff_find_by_name(result->value[0]);
 }
 
 struct userdiff_driver *userdiff_get_textconv(struct userdiff_driver *driver)
diff --git a/ws.c b/ws.c
index bb3270c..a6ffbae 100644
--- a/ws.c
+++ b/ws.c
@@ -73,15 +73,16 @@ unsigned parse_whitespace_rule(const char *string)
 
 unsigned whitespace_rule(const char *pathname)
 {
-	static struct git_attr_check *attr_whitespace_rule;
+	static struct git_attr_check *check;
+	struct git_attr_result *result;
 
-	if (!attr_whitespace_rule)
-		attr_whitespace_rule = git_attr_check_initl("whitespace", NULL);
+	if (!check)
+		git_attr_check_initl(&check, "whitespace", NULL);
 
-	if (!git_check_attr(pathname, attr_whitespace_rule)) {
-		const char *value;
+	result = git_check_attr(pathname, check);
 
-		value = attr_whitespace_rule->check[0].value;
+	if (result) {
+		const char *value = result->value[0];
 		if (ATTR_TRUE(value)) {
 			/* true (whitespace) */
 			unsigned all_rule = ws_tab_width(whitespace_rule_cfg);
-- 
2.10.1.382.ga23ca1b.dirty

