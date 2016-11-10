Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9237220229
	for <e@80x24.org>; Thu, 10 Nov 2016 20:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965789AbcKJUfV (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 15:35:21 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33139 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965572AbcKJUfM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 15:35:12 -0500
Received: by mail-pf0-f173.google.com with SMTP id d2so152093323pfd.0
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 12:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2r3BtrYUctbMoZTOPuz3TYKzIjBqW4Po0k9ojpOkG+o=;
        b=cx7iYSl8BZWIGxMLGNH3VHa906stSGw4AXDAMeYxpwzw7zgsG02wrsoJ8XqC4KyrQd
         w5cBktXvwKU2+WJkoqkLuYBKVuZtBfDQQzRxHSwJDVHa3YSGX0A3g9k1o57Fg6w1BZSo
         JczNsWcf9jgf4oQ5WOzJ4lWhqsx83Lyvkcy/n/elgf6iwmv+7sBOCI+5xAtmOy8XPEx/
         SXcOLnFIhoR3drKVZsBzt3gaTmB9BicJXz914s2YQoH6LXcVmMluI4/2T6X2bwxFrHEU
         TrwUtrrhqFKV0KSGJLU1H+9+cFsEXDO2V3g8p65fqGHlKZL6fr1fhllOpaM0gH6R3t5N
         CGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2r3BtrYUctbMoZTOPuz3TYKzIjBqW4Po0k9ojpOkG+o=;
        b=fs93dbS/oh2uV+rZp09huZCX/pw5O/OY/KAEH+jUQxTGmvSj30U+5izEBy/saEG1kD
         hEpi/cvP9/vIX4+MvnbJrmT07EG9T/z5H5NlEadh54wG8/LfUvB4yjqb0EO+Wenq/pUO
         on0aL3BrsyQIMdKg3EoNapQTTB1ozV/hdPEopToiNJN8FptOK8rWKfx7u7tPDwmAilIv
         2Inm/H3MbF8Hvx/Tcp9j+TZqslw7D3FgMSVTAitqfvQ0z//VlE0gs2ufJaJO4YmGtwrS
         QaVi64UZHwoPBiwU2vk5pWsjE2JPZaPdq8LUtWJBpU5wzPZoEehUHbnZLzODJUCD1j5W
         Kh9g==
X-Gm-Message-State: ABUngvd0Y4bpOBWIuMcqp1X4tM5wMJplqh37q5w/EGsiX5xjFUYUPZLfJM87OB+l0z68WnEe
X-Received: by 10.99.217.21 with SMTP id r21mr26542946pgg.78.1478810110649;
        Thu, 10 Nov 2016 12:35:10 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:b504:dcf8:965a:7ab8])
        by smtp.gmail.com with ESMTPSA id f132sm9276412pfa.72.2016.11.10.12.35.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Nov 2016 12:35:10 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com, pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 26/35] attr: convert to new threadsafe API
Date:   Thu, 10 Nov 2016 12:34:19 -0800
Message-Id: <20161110203428.30512-27-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161110203428.30512-1-sbeller@google.com>
References: <20161110203428.30512-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This revamps the API of the attr subsystem to be thread safe.
Before we had the question and its results in one struct type.
The typical usage of the API was

    static struct git_attr_check *check;

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
    git_attr_check_initl(struct git_attr_check**, ...);
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

This commit changes the API and adds locking in
git_attr_check_initl that provides the thread safety for constructing
`struct git_attr_check`.

The usage of the new API will be:

    /*
     * The initl call will thread-safely check whether the
     * struct git_attr_check has been initialized. We only
     * want to do the initialization work once, hence we do
     * that work inside a thread safe environment.
     */
    static struct git_attr_check *check;
    git_attr_check_initl(&check, "text", NULL);

    /* We're just asking for one attribute "text". */
    git_attr_result myresult[1];

    /* Perform the check and act on it: */
    git_check_attr(path, check, myresult);
    act_on(myresult[0].value);

    /*
     * No need to free the check as it is static, hence doesn't leak
     * memory. The result is also static, so no need to free there either.
     */

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>

# Conflicts:
#	attr.h

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/technical/api-gitattributes.txt | 136 +++++++++++---------
 archive.c                                     |  11 +-
 attr.c                                        | 172 +++++++++++++++++---------
 attr.h                                        |  72 ++++++-----
 builtin/check-attr.c                          |  50 ++++----
 builtin/pack-objects.c                        |  16 +--
 common-main.c                                 |   2 +
 convert.c                                     |  40 +++---
 ll-merge.c                                    |  24 ++--
 userdiff.c                                    |  16 +--
 ws.c                                          |   8 +-
 11 files changed, 323 insertions(+), 224 deletions(-)

diff --git a/Documentation/technical/api-gitattributes.txt b/Documentation/technical/api-gitattributes.txt
index 92fc32a..7dd6616 100644
--- a/Documentation/technical/api-gitattributes.txt
+++ b/Documentation/technical/api-gitattributes.txt
@@ -10,21 +10,23 @@ Data Structure
 
 `struct git_attr`::
 
-	An attribute is an opaque object that is identified by its name.
-	Pass the name to `git_attr()` function to obtain the object of
-	this type.  The internal representation of this structure is
+	The internal representation of this structure is
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
+	This structure represents one results for a check, such that an
+	array of `struct git_attr_results` corresponds to a
+	`struct git_attr_check`. The answers given in that array are in
+	the the same order as the check struct.
 
 
 Attribute Values
@@ -32,7 +34,7 @@ Attribute Values
 
 An attribute for a path can be in one of four states: Set, Unset,
 Unspecified or set to a string, and `.value` member of `struct
-git_attr_check` records it.  There are three macros to check these:
+git_attr_result` records it.  There are three macros to check these:
 
 `ATTR_TRUE()`::
 
@@ -53,19 +55,28 @@ value of the attribute for the path.
 Querying Specific Attributes
 ----------------------------
 
-* Prepare `struct git_attr_check` using git_attr_check_initl()
-  function, enumerating the names of attributes whose values you are
-  interested in, terminated with a NULL pointer.  Alternatively, an
-  empty `struct git_attr_check` can be prepared by calling
-  `git_attr_check_alloc()` function and then attributes you want to
-  ask about can be added to it with `git_attr_check_append()`
-  function.
-
-* Call `git_check_attr()` to check the attributes for the path.
-
-* Inspect `git_attr_check` structure to see how each of the
-  attribute in the array is defined for the path.
-
+* Prepare a `struct git_attr_check` using `git_attr_check_initl()` or
+  `git_attr_check_initv()` function, enumerating the names of
+  attributes whose values you are interested in, terminated with
+  a NULL.
+  Preparing the `struct git_attr_check` is thread safe, i.e. you
+  can call it from different threads at the same time; when check
+  determines the initialization is still needed, the threads will
+  use a single global mutex to perform the initialization just once,
+  the others will wait on the the thread to actually perform the
+  initialization.
+
+* Allocate an array of `struct git_attr_result` either on the stack
+  or via `git_attr_result_alloc` on the heap when the result size
+  is not known at compile time.
+
+* Call `git_check_attr()` to check the attributes for the path,
+  the given `git_attr_result` will be filled with the result.
+  You must not change the `struct git_attr_check` after calling
+  `git_check_attr()`.
+
+* Inspect each `git_attr_result` structure to see how
+  each of the attribute in the array is defined for the path.
 
 Example
 -------
@@ -73,31 +84,22 @@ Example
 To see how attributes "crlf" and "ident" are set for different paths.
 
 . Prepare a `struct git_attr_check` with two elements (because
-  we are checking two attributes):
-
-------------
-static struct git_attr_check *check;
-static void setup_check(void)
-{
-	if (check)
-		return; /* already done */
-	check = git_attr_check_initl("crlf", "ident", NULL);
-}
-------------
-
-. Call `git_check_attr()` with the prepared `struct git_attr_check`:
+  we are checking two attributes) and then call `git_check_attr()`
+  with the prepared `struct git_attr_check`:
 
 ------------
 	const char *path;
+	struct git_attr_result result[2];
+	static struct git_attr_check *check;
 
-	setup_check();
-	git_check_attr(path, check);
+	git_attr_check_initl(&check, "crlf", "ident", NULL);
+	git_check_attr(path, check, result);
 ------------
 
-. Act on `.value` member of the result, left in `check->check[]`:
+. Act on `result.value[]`:
 
 ------------
-	const char *value = check->check[0].value;
+	const char *value = result.value[0];
 
 	if (ATTR_TRUE(value)) {
 		The attribute is Set, by listing only the name of the
@@ -116,19 +118,28 @@ static void setup_check(void)
 	}
 ------------
 
-To see how attributes in argv[] are set for different paths, only
-the first step in the above would be different.
+To see how attributes in argv[] are set for different paths, use
+`git_attr_check_initv` instead. When an invalid attr name is given
+both init functions die unconditionally with a non user friendly message.
+So you want to check the attr values first:
 
 ------------
 static struct git_attr_check *check;
 static void setup_check(const char **argv)
 {
-	check = git_attr_check_alloc();
-	while (*argv) {
-		struct git_attr *attr = git_attr(*argv);
-		git_attr_check_append(check, attr);
-		argv++;
+	const char **argv_copy = argv;
+	while (*argv_copy) {
+		const char *name = argv_copy[0];
+		const int len = strlen(argv_copy[0]);
+		if (!attr_name_valid(name, len)) {
+			struct strbuf sb = STRBUF_INIT;
+			invalid_attr_name_message(&sb, name, len);
+			die ("Oops this is bad: %s", sb.buf);
+		}
+		argv_copy++;
 	}
+	git_attr_check_initv(&check, argv);
+	struct git_attr_result *result = git_attr_result_alloc(check);
 }
 ------------
 
@@ -138,17 +149,30 @@ Querying All Attributes
 
 To get the values of all attributes associated with a file:
 
-* Prepare an empty `git_attr_check` structure by calling
-  `git_attr_check_alloc()`.
+* Setup a local variables for the question
+  `struct git_attr_check` as well as a pointer where the result
+  `struct git_attr_result` will be stored. Both should be initialized
+  to NULL.
+
+------------
+  struct git_attr_check *check = NULL;
+  struct git_attr_result *result = NULL;
+------------
+
+* Call `git_all_attrs()`.
 
-* Call `git_all_attrs()`, which populates the `git_attr_check`
-  with the attributes attached to the path.
+------------
+  git_all_attrs(full_path, &check, &result);
+------------
 
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
+* Clear the variables by calling `git_attr_check_clear()` and
+  `git_attr_result_free()`.
diff --git a/archive.c b/archive.c
index 11e3951..65bc6b7 100644
--- a/archive.c
+++ b/archive.c
@@ -111,6 +111,7 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 	struct archiver_args *args = c->args;
 	write_archive_entry_fn_t write_entry = c->write_entry;
 	static struct git_attr_check *check;
+	struct git_attr_result result[2];
 	const char *path_without_prefix;
 	int err;
 
@@ -124,12 +125,12 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 		strbuf_addch(&path, '/');
 	path_without_prefix = path.buf + args->baselen;
 
-	if (!check)
-		check = git_attr_check_initl("export-ignore", "export-subst", NULL);
-	if (!git_check_attr(path_without_prefix, check)) {
-		if (ATTR_TRUE(check->check[0].value))
+	git_attr_check_initl(&check, "export-ignore", "export-subst", NULL);
+
+	if (!git_check_attr(path_without_prefix, check, result)) {
+		if (ATTR_TRUE(result[0].value))
 			return 0;
-		args->convert = ATTR_TRUE(check->check[1].value);
+		args->convert = ATTR_TRUE(result[1].value);
 	}
 
 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
diff --git a/attr.c b/attr.c
index 19a3651..32ec453 100644
--- a/attr.c
+++ b/attr.c
@@ -14,6 +14,8 @@
 #include "dir.h"
 #include "utf8.h"
 #include "quote.h"
+#include "thread-utils.h"
+#include "argv-array.h"
 
 const char git_attr__true[] = "(builtin)true";
 const char git_attr__false[] = "\0(builtin)false";
@@ -46,6 +48,21 @@ struct git_attr {
 static int attr_nr;
 static struct git_attr *(git_attr_hash[HASHSIZE]);
 
+#ifndef NO_PTHREADS
+
+static pthread_mutex_t attr_mutex;
+#define attr_lock()		pthread_mutex_lock(&attr_mutex)
+#define attr_unlock()		pthread_mutex_unlock(&attr_mutex)
+void attr_start(void) { pthread_mutex_init(&attr_mutex, NULL); }
+
+#else
+
+#define attr_lock()		(void)0
+#define attr_unlock()		(void)0
+void attr_start(void) {;}
+
+#endif /* NO_PTHREADS */
+
 /*
  * NEEDSWORK: maybe-real, maybe-macro are not property of
  * an attribute, as it depends on what .gitattributes are
@@ -55,6 +72,16 @@ static struct git_attr *(git_attr_hash[HASHSIZE]);
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
 
@@ -781,7 +808,7 @@ static int macroexpand_one(int nr, int rem)
 
 static int attr_check_is_dynamic(const struct git_attr_check *check)
 {
-	return (void *)(check->check) != (void *)(check + 1);
+	return (void *)(check->attr) != (void *)(check + 1);
 }
 
 static void empty_attr_check_elems(struct git_attr_check *check)
@@ -799,7 +826,9 @@ static void empty_attr_check_elems(struct git_attr_check *check)
  * any and all attributes that are visible are collected in it.
  */
 static void collect_some_attrs(const char *path, int pathlen,
-			       struct git_attr_check *check, int collect_all)
+			       struct git_attr_check *check,
+			       struct git_attr_result **result,
+			       int collect_all)
 
 {
 	struct attr_stack *stk;
@@ -825,13 +854,11 @@ static void collect_some_attrs(const char *path, int pathlen,
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
@@ -845,38 +872,53 @@ static void collect_some_attrs(const char *path, int pathlen,
 		rem = fill(path, pathlen, basename_offset, stk, rem);
 
 	if (collect_all) {
-		empty_attr_check_elems(check);
+		int check_nr = 0, check_alloc = 0;
+		const char **res = NULL;
+
 		for (i = 0; i < attr_nr; i++) {
 			const struct git_attr *attr = check_all_attr[i].attr;
 			const char *value = check_all_attr[i].value;
 			if (value == ATTR__UNSET || value == ATTR__UNKNOWN)
 				continue;
-			git_attr_check_append(check, attr)->value = value;
+
+			ALLOC_GROW(check->attr, check->check_nr + 1, check->check_alloc);
+			check->attr[check->check_nr++] = attr;
+
+			ALLOC_GROW(res, check_nr + 1, check_alloc);
+			res[check_nr++] = value;
 		}
+
+		*result = git_attr_result_alloc(check);
+		for (i = 0; i < check->check_nr; i++)
+			(*result)[i].value = res[i];
+
+		free(res);
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
+	collect_some_attrs(path, pathlen, check, &result, 0);
 
 	for (i = 0; i < check->check_nr; i++) {
-		const char *value = check_all_attr[celem[i].attr->attr_nr].value;
+		const char *value = check_all_attr[check->attr[i]->attr_nr].value;
 		if (value == ATTR__UNKNOWN)
 			value = ATTR__UNSET;
-		celem[i].value = value;
+		result[i].value = value;
 	}
 
 	return 0;
 }
 
-void git_all_attrs(const char *path, struct git_attr_check *check)
+void git_all_attrs(const char *path,
+		   struct git_attr_check *check,
+		   struct git_attr_result **result)
 {
-	collect_some_attrs(path, strlen(path), check, 1);
+	collect_some_attrs(path, strlen(path), check, result, 1);
 }
 
 void git_attr_set_direction(enum git_attr_direction new, struct index_state *istate)
@@ -892,69 +934,79 @@ void git_attr_set_direction(enum git_attr_direction new, struct index_state *ist
 	use_index = istate;
 }
 
-static int git_check_attr_counted(const char *path, int pathlen,
-				  struct git_attr_check *check)
+int git_check_attr(const char *path,
+		    struct git_attr_check *check,
+		    struct git_attr_result *result)
 {
 	check->finalized = 1;
-	return git_check_attrs(path, pathlen, check);
+	return git_check_attrs(path, strlen(path), check, result);
 }
 
-int git_check_attr(const char *path, struct git_attr_check *check)
+static void git_attr_check_initv_unlocked(struct git_attr_check **check_,
+				 const char **argv)
 {
-	return git_check_attr_counted(path, strlen(path), check);
+	int cnt;
+	struct git_attr_check *check;
+
+	for (cnt = 0; argv[cnt] != NULL; cnt++)
+		;
+
+	check = xcalloc(1, sizeof(*check) + cnt * sizeof(*(check->attr)));
+	check->check_nr = cnt;
+	check->finalized = 1;
+	check->attr = (const struct git_attr **)(check + 1);
+
+	for (cnt = 0; cnt < check->check_nr; cnt++) {
+		struct git_attr *attr = git_attr(argv[cnt]);
+		if (!attr)
+			die("BUG: %s: not a valid attribute name", argv[cnt]);
+		check->attr[cnt] = attr;
+	}
+
+	*check_ = check;
 }
 
-struct git_attr_check *git_attr_check_initl(const char *one, ...)
+void git_attr_check_initl(struct git_attr_check **check,
+			  const char *one, ...)
 {
-	struct git_attr_check *check;
 	int cnt;
 	va_list params;
 	const char *param;
+	struct argv_array attrs = ARGV_ARRAY_INIT;
+
+	attr_lock();
+	if (*check) {
+		attr_unlock();
+		return;
+	}
 
 	va_start(params, one);
+	argv_array_push(&attrs, one);
 	for (cnt = 1; (param = va_arg(params, const char *)) != NULL; cnt++)
-		;
+		argv_array_push(&attrs, param);
 	va_end(params);
-	check = xcalloc(1,
-			sizeof(*check) + cnt * sizeof(*(check->check)));
-	check->check_nr = cnt;
-	check->finalized = 1;
-	check->check = (struct git_attr_check_elem *)(check + 1);
 
-	check->check[0].attr = git_attr(one);
-	va_start(params, one);
-	for (cnt = 1; cnt < check->check_nr; cnt++) {
-		struct git_attr *attr;
-		param = va_arg(params, const char *);
-		if (!param)
-			die("BUG: counted %d != ended at %d",
-			    check->check_nr, cnt);
-		attr = git_attr(param);
-		if (!attr)
-			die("BUG: %s: not a valid attribute name", param);
-		check->check[cnt].attr = attr;
-	}
-	va_end(params);
-	return check;
+	git_attr_check_initv_unlocked(check, attrs.argv);
+
+	attr_unlock();
+	argv_array_clear(&attrs);
 }
 
-struct git_attr_check *git_attr_check_alloc(void)
+void git_attr_check_initv(struct git_attr_check **check, const char **argv)
 {
-	return xcalloc(1, sizeof(struct git_attr_check));
+	attr_lock();
+	if (*check) {
+		attr_unlock();
+		return;
+	}
+	git_attr_check_initv_unlocked(check, argv);
+
+	attr_unlock();
 }
 
-struct git_attr_check_elem *git_attr_check_append(struct git_attr_check *check,
-						  const struct git_attr *attr)
+struct git_attr_result *git_attr_result_alloc(struct git_attr_check *check)
 {
-	struct git_attr_check_elem *elem;
-	if (check->finalized)
-		die("BUG: append after git_attr_check structure is finalized");
-	if (!attr_check_is_dynamic(check))
-		die("BUG: appending to a statically initialized git_attr_check");
-	ALLOC_GROW(check->check, check->check_nr + 1, check->check_alloc);
-	elem = &check->check[check->check_nr++];
-	elem->attr = attr;
-	return elem;
+	return xcalloc(1, sizeof(struct git_attr_result) * check->check_nr);
 }
 
 void git_attr_check_clear(struct git_attr_check *check)
@@ -962,12 +1014,12 @@ void git_attr_check_clear(struct git_attr_check *check)
 	empty_attr_check_elems(check);
 	if (!attr_check_is_dynamic(check))
 		die("BUG: clearing a statically initialized git_attr_check");
-	free(check->check);
+	free(check->attr);
 	check->check_alloc = 0;
 }
 
-void git_attr_check_free(struct git_attr_check *check)
+void git_attr_result_free(struct git_attr_result *result)
 {
-	git_attr_check_clear(check);
-	free(check);
+	/* No need to free values as they are interned. */
+	free(result);
 }
diff --git a/attr.h b/attr.h
index 7416b14..1a50288 100644
--- a/attr.h
+++ b/attr.h
@@ -1,14 +1,14 @@
 #ifndef ATTR_H
 #define ATTR_H
 
-/* An attribute is a pointer to this opaque structure */
-struct git_attr;
-
 /*
- * Given a string, return the gitattribute object that
- * corresponds to it.
+ * Must be called on platforms that do not support static initialization
+ * of mutexes.
  */
-struct git_attr *git_attr(const char *);
+extern void attr_start(void);
+
+/* An attribute is a pointer to this opaque structure */
+struct git_attr;
 
 /*
  * Return the name of the attribute represented by the argument.  The
@@ -29,44 +29,48 @@ extern const char git_attr__false[];
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
-
-extern struct git_attr_check *git_attr_check_alloc(void);
-extern struct git_attr_check_elem *git_attr_check_append(struct git_attr_check *, const struct git_attr *);
-
-extern void git_attr_check_clear(struct git_attr_check *);
-extern void git_attr_check_free(struct git_attr_check *);
+struct git_attr_result {
+	const char *value;
+};
 
 /*
- * Return the name of the attribute represented by the argument.  The
- * return value is a pointer to a null-delimited string that is part
- * of the internal data structure; it should not be modified or freed.
+ * Initialize the `git_attr_check` via one of the following three functions:
+ *
+ * git_all_attrs         allocates a check and fills in all attributes and
+ *                       results that are set for the given path.
+ * git_attr_check_initl  takes a pointer to where the check will be initialized,
+ *                       followed by all attributes that are to be checked.
+ * git_attr_check_initv  takes a pointer to where the check will be initialized,
+ *                       and a NULL terminated array of attributes.
+ *
+ * All initialization methods are thread safe.
+ * To allocate memory for the result of a given check,
+ * use git_attr_result_alloc.
  */
-extern const char *git_attr_name(const struct git_attr *);
+extern void git_attr_check_initl(struct git_attr_check **,
+				 const char *, ...);
+extern void git_attr_check_initv(struct git_attr_check **,
+				 const char **);
+extern void git_all_attrs(const char *path,
+			  struct git_attr_check *,
+			  struct git_attr_result **);
+extern struct git_attr_result *git_attr_result_alloc(struct git_attr_check *check);
 
-/*
- * Retrieve all attributes that apply to the specified path.
- * check holds the attributes and their values.
- */
-void git_all_attrs(const char *path, struct git_attr_check *check);
+/* Query a path for its attributes */
+extern int git_check_attr(const char *path,
+			  struct git_attr_check *,
+			  struct git_attr_result *result);
+
+extern void git_attr_check_clear(struct git_attr_check *);
+extern void git_attr_result_free(struct git_attr_result *);
 
 enum git_attr_direction {
 	GIT_ATTR_CHECKIN,
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index ec61476..418c3da 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -3,6 +3,7 @@
 #include "attr.h"
 #include "quote.h"
 #include "parse-options.h"
+#include "argv-array.h"
 
 static int all_attrs;
 static int cached_attrs;
@@ -24,13 +25,14 @@ static const struct option check_attr_options[] = {
 	OPT_END()
 };
 
-static void output_attr(struct git_attr_check *check, const char *file)
+static void output_attr(struct git_attr_check *check,
+			struct git_attr_result *result, const char *file)
 {
 	int j;
 	int cnt = check->check_nr;
 
 	for (j = 0; j < cnt; j++) {
-		const char *value = check->check[j].value;
+		const char *value = result[j].value;
 
 		if (ATTR_TRUE(value))
 			value = "set";
@@ -44,11 +46,11 @@ static void output_attr(struct git_attr_check *check, const char *file)
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
@@ -59,16 +61,20 @@ static void check_attr(const char *prefix,
 {
 	char *full_path =
 		prefix_path(prefix, prefix ? strlen(prefix) : 0, file);
+	struct git_attr_check local_check = GIT_ATTR_CHECK_INIT;
+	struct git_attr_result *result = NULL;
+
 	if (check != NULL) {
-		if (git_check_attr(full_path, check))
-			die("git_check_attr died");
-		output_attr(check, file);
+		result = git_attr_result_alloc(check);
+		git_check_attr(full_path, check, result);
 	} else {
-		check = git_attr_check_alloc();
-		git_all_attrs(full_path, check);
-		output_attr(check, file);
-		git_attr_check_free(check);
+		git_all_attrs(full_path, &local_check, &result);
+		check = &local_check;
 	}
+	output_attr(check, result, file);
+	git_attr_check_clear(&local_check);
+
+	git_attr_result_free(result);
 	free(full_path);
 }
 
@@ -102,7 +108,7 @@ static NORETURN void error_with_usage(const char *msg)
 
 int cmd_check_attr(int argc, const char **argv, const char *prefix)
 {
-	struct git_attr_check *check;
+	struct git_attr_check *check = NULL;
 	int cnt, i, doubledash, filei;
 
 	if (!is_bare_repository())
@@ -162,17 +168,19 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 			error_with_usage("No file specified");
 	}
 
-	if (all_attrs) {
-		check = NULL;
-	} else {
-		check = git_attr_check_alloc();
+	if (!all_attrs) {
+		struct argv_array attrs = ARGV_ARRAY_INIT;
 		for (i = 0; i < cnt; i++) {
-			struct git_attr *a = git_attr(argv[i]);
-			if (!a)
-				return error("%s: not a valid attribute name",
-					     argv[i]);
-			git_attr_check_append(check, a);
+			if (!attr_name_valid(argv[i], strlen(argv[i]))) {
+				struct strbuf sb = STRBUF_INIT;
+				invalid_attr_name_message(&sb, argv[i],
+							  strlen(argv[i]));
+				return error("%s", strbuf_detach(&sb, NULL));
+			}
+			argv_array_push(&attrs, argv[i]);
 		}
+		git_attr_check_initv(&check, attrs.argv);
+		argv_array_clear(&attrs);
 	}
 
 	if (stdin_paths)
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3918c07..3751836 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -899,14 +899,16 @@ static void write_pack_file(void)
 static int no_try_delta(const char *path)
 {
 	static struct git_attr_check *check;
+	int ret = 0;
+	struct git_attr_result result[1];
 
-	if (!check)
-		check = git_attr_check_initl("delta", NULL);
-	if (git_check_attr(path, check))
-		return 0;
-	if (ATTR_FALSE(check->check[0].value))
-		return 1;
-	return 0;
+	git_attr_check_initl(&check, "delta", NULL);
+
+	if (!git_check_attr(path, check, result)) {
+		if (ATTR_FALSE(result[0].value))
+			ret = 1;
+	}
+	return ret;
 }
 
 /*
diff --git a/common-main.c b/common-main.c
index 44a29e8..d4699cd 100644
--- a/common-main.c
+++ b/common-main.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "exec_cmd.h"
+#include "attr.h"
 
 /*
  * Many parts of Git have subprograms communicate via pipe, expect the
@@ -32,6 +33,7 @@ int main(int argc, const char **argv)
 	sanitize_stdfds();
 
 	git_setup_gettext();
+	attr_start();
 
 	argv[0] = git_extract_argv0_path(argv[0]);
 
diff --git a/convert.c b/convert.c
index bb2435a..fe861ce 100644
--- a/convert.c
+++ b/convert.c
@@ -718,9 +718,9 @@ static int ident_to_worktree(const char *path, const char *src, size_t len,
 	return 1;
 }
 
-static enum crlf_action git_path_check_crlf(struct git_attr_check_elem *check)
+static enum crlf_action git_path_check_crlf(struct git_attr_result *result)
 {
-	const char *value = check->value;
+	const char *value = result->value;
 
 	if (ATTR_TRUE(value))
 		return CRLF_TEXT;
@@ -735,9 +735,9 @@ static enum crlf_action git_path_check_crlf(struct git_attr_check_elem *check)
 	return CRLF_UNDEFINED;
 }
 
-static enum eol git_path_check_eol(struct git_attr_check_elem *check)
+static enum eol git_path_check_eol(struct git_attr_result *result)
 {
-	const char *value = check->value;
+	const char *value = result->value;
 
 	if (ATTR_UNSET(value))
 		;
@@ -748,9 +748,9 @@ static enum eol git_path_check_eol(struct git_attr_check_elem *check)
 	return EOL_UNSET;
 }
 
-static struct convert_driver *git_path_check_convert(struct git_attr_check_elem *check)
+static struct convert_driver *git_path_check_convert(struct git_attr_result *result)
 {
-	const char *value = check->value;
+	const char *value = result->value;
 	struct convert_driver *drv;
 
 	if (ATTR_TRUE(value) || ATTR_FALSE(value) || ATTR_UNSET(value))
@@ -761,9 +761,9 @@ static struct convert_driver *git_path_check_convert(struct git_attr_check_elem
 	return NULL;
 }
 
-static int git_path_check_ident(struct git_attr_check_elem *check)
+static int git_path_check_ident(struct git_attr_result *result)
 {
-	const char *value = check->value;
+	const char *value = result->value;
 
 	return !!ATTR_TRUE(value);
 }
@@ -778,25 +778,27 @@ struct conv_attrs {
 static void convert_attrs(struct conv_attrs *ca, const char *path)
 {
 	static struct git_attr_check *check;
+	static int init_user_convert_tail;
+	struct git_attr_result result[5];
 
-	if (!check) {
-		check = git_attr_check_initl("crlf", "ident",
-					     "filter", "eol", "text",
-					     NULL);
+	git_attr_check_initl(&check, "crlf", "ident", "filter",
+			     "eol", "text", NULL);
+
+	if (!init_user_convert_tail) {
 		user_convert_tail = &user_convert;
 		git_config(read_convert_config, NULL);
+		init_user_convert_tail = 1;
 	}
 
-	if (!git_check_attr(path, check)) {
-		struct git_attr_check_elem *ccheck = check->check;
-		ca->crlf_action = git_path_check_crlf(ccheck + 4);
+	if (!git_check_attr(path, check, result)) {
+		ca->crlf_action = git_path_check_crlf(&result[4]);
 		if (ca->crlf_action == CRLF_UNDEFINED)
-			ca->crlf_action = git_path_check_crlf(ccheck + 0);
+			ca->crlf_action = git_path_check_crlf(&result[0]);
 		ca->attr_action = ca->crlf_action;
-		ca->ident = git_path_check_ident(ccheck + 1);
-		ca->drv = git_path_check_convert(ccheck + 2);
+		ca->ident = git_path_check_ident(&result[1]);
+		ca->drv = git_path_check_convert(&result[2]);
 		if (ca->crlf_action != CRLF_BINARY) {
-			enum eol eol_attr = git_path_check_eol(ccheck + 3);
+			enum eol eol_attr = git_path_check_eol(&result[3]);
 			if (ca->crlf_action == CRLF_AUTO && eol_attr == EOL_LF)
 				ca->crlf_action = CRLF_AUTO_INPUT;
 			else if (ca->crlf_action == CRLF_AUTO && eol_attr == EOL_CRLF)
diff --git a/ll-merge.c b/ll-merge.c
index bc6479c..d71354a 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -353,12 +353,14 @@ int ll_merge(mmbuffer_t *result_buf,
 	     mmfile_t *theirs, const char *their_label,
 	     const struct ll_merge_options *opts)
 {
-	static struct git_attr_check *check;
 	static const struct ll_merge_options default_opts;
 	const char *ll_driver_name = NULL;
 	int marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
 	const struct ll_merge_driver *driver;
 
+	static struct git_attr_check *check;
+	struct git_attr_result result[2];
+
 	if (!opts)
 		opts = &default_opts;
 
@@ -368,13 +370,12 @@ int ll_merge(mmbuffer_t *result_buf,
 		normalize_file(theirs, path);
 	}
 
-	if (!check)
-		check = git_attr_check_initl("merge", "conflict-marker-size", NULL);
+	git_attr_check_initl(&check, "merge", "conflict-marker-size", NULL);
 
-	if (!git_check_attr(path, check)) {
-		ll_driver_name = check->check[0].value;
-		if (check->check[1].value) {
-			marker_size = atoi(check->check[1].value);
+	if (!git_check_attr(path, check, result)) {
+		ll_driver_name = result[0].value;
+		if (result[1].value) {
+			marker_size = atoi(result[1].value);
 			if (marker_size <= 0)
 				marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
 		}
@@ -395,11 +396,12 @@ int ll_merge_marker_size(const char *path)
 {
 	static struct git_attr_check *check;
 	int marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
+	struct git_attr_result result[1];
+
+	git_attr_check_initl(&check, "conflict-marker-size", NULL);
 
-	if (!check)
-		check = git_attr_check_initl("conflict-marker-size", NULL);
-	if (!git_check_attr(path, check) && check->check[0].value) {
-		marker_size = atoi(check->check[0].value);
+	if (!git_check_attr(path, check, result) && !ATTR_UNSET(result[0].value)) {
+		marker_size = atoi(result[0].value);
 		if (marker_size <= 0)
 			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
 	}
diff --git a/userdiff.c b/userdiff.c
index 46dfd32..1d6d363 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -263,21 +263,23 @@ struct userdiff_driver *userdiff_find_by_name(const char *name) {
 struct userdiff_driver *userdiff_find_by_path(const char *path)
 {
 	static struct git_attr_check *check;
+	struct git_attr_result result[1];
 
-	if (!check)
-		check = git_attr_check_initl("diff", NULL);
 	if (!path)
 		return NULL;
-	if (git_check_attr(path, check))
+
+	git_attr_check_initl(&check, "diff", NULL);
+
+	if (git_check_attr(path, check, result))
 		return NULL;
 
-	if (ATTR_TRUE(check->check[0].value))
+	if (ATTR_TRUE(result[0].value))
 		return &driver_true;
-	if (ATTR_FALSE(check->check[0].value))
+	if (ATTR_FALSE(result[0].value))
 		return &driver_false;
-	if (ATTR_UNSET(check->check[0].value))
+	if (ATTR_UNSET(result[0].value))
 		return NULL;
-	return userdiff_find_by_name(check->check[0].value);
+	return userdiff_find_by_name(result[0].value);
 }
 
 struct userdiff_driver *userdiff_get_textconv(struct userdiff_driver *driver)
diff --git a/ws.c b/ws.c
index bb3270c..7e355c4 100644
--- a/ws.c
+++ b/ws.c
@@ -74,14 +74,14 @@ unsigned parse_whitespace_rule(const char *string)
 unsigned whitespace_rule(const char *pathname)
 {
 	static struct git_attr_check *attr_whitespace_rule;
+	struct git_attr_result result[1];
 
-	if (!attr_whitespace_rule)
-		attr_whitespace_rule = git_attr_check_initl("whitespace", NULL);
+	git_attr_check_initl(&attr_whitespace_rule, "whitespace", NULL);
 
-	if (!git_check_attr(pathname, attr_whitespace_rule)) {
+	if (!git_check_attr(pathname, attr_whitespace_rule, result)) {
 		const char *value;
 
-		value = attr_whitespace_rule->check[0].value;
+		value = result[0].value;
 		if (ATTR_TRUE(value)) {
 			/* true (whitespace) */
 			unsigned all_rule = ws_tab_width(whitespace_rule_cfg);
-- 
2.10.1.469.g00a8914

