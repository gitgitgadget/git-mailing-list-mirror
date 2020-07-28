Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D03EC433EB
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1225420809
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbgG1UX2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:23:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:40196 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728437AbgG1UX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 16:23:27 -0400
Received: (qmail 29716 invoked by uid 109); 28 Jul 2020 20:23:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Jul 2020 20:23:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28496 invoked by uid 111); 28 Jul 2020 20:23:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jul 2020 16:23:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Jul 2020 16:23:25 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 02/11] argv-array: rename to strvec
Message-ID: <20200728202325.GB1021513@coredump.intra.peff.net>
References: <20200728202124.GA1021264@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200728202124.GA1021264@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The name "argv-array" isn't very good, because it describes what the
data type can be used for (program argument arrays), not what it
actually is (a dynamically-growing string array that maintains a
NULL-terminator invariant). This leads to people being hesitant to use
it for other cases where it would actually be a good fit. The existing
name is also clunky to use. It's overly long, and the name often leads
to saying things like "argv.argv" (i.e., the field names overlap with
variable names, since they're describing the use, not the type). Let's
give it a more neutral name.

I settled on "strvec" because "vector" is the name for a dynamic array
type in many programming languages. "strarray" would work, too, but it's
longer and a bit more awkward to say (and don't we all say these things
in our mind as we type them?).

A more extreme direction would be a generic data structure which stores
a NULL-terminated of _any_ type. That would be easy to do with void
pointers, but we'd lose some type safety for the existing cases. Plus it
raises questions about memory allocation and ownership. So I limited
myself here to changing names only, and not semantics. If we do find a
use for that more generic data type, we could perhaps implement it at a
lower level and then provide type-safe wrappers around it for strings.
But that can come later.

This patch does the minimum to convert the struct and function names in
the header and implementation, leaving a few things for follow-on
patches:

  - files retain their original names for now

  - struct field names are retained for now

  - there's a preprocessor compat layer that lets most users remain the
    same for now. The exception is headers which made a manual forward
    declaration of the struct. I've converted them (and their dependent
    function declarations) here.

Signed-off-by: Jeff King <peff@peff.net>
---
 argv-array.c         | 44 +++++++++++++++++++-------------------
 argv-array.h         | 51 +++++++++++++++++++++++++++-----------------
 exec-cmd.h           |  4 ++--
 ls-refs.h            |  4 ++--
 quote.h              |  4 ++--
 refs.h               |  4 ++--
 refspec.h            |  4 ++--
 remote.h             |  4 ++--
 serve.h              |  4 ++--
 submodule.h          |  6 +++---
 transport-internal.h |  2 +-
 upload-pack.h        |  4 ++--
 12 files changed, 74 insertions(+), 61 deletions(-)

diff --git a/argv-array.c b/argv-array.c
index 61ef8c0dfd..b7461c47e4 100644
--- a/argv-array.c
+++ b/argv-array.c
@@ -2,32 +2,32 @@
 #include "argv-array.h"
 #include "strbuf.h"
 
-const char *empty_argv[] = { NULL };
+const char *empty_strvec[] = { NULL };
 
-void argv_array_init(struct argv_array *array)
+void strvec_init(struct strvec *array)
 {
-	array->argv = empty_argv;
+	array->argv = empty_strvec;
 	array->argc = 0;
 	array->alloc = 0;
 }
 
-static void argv_array_push_nodup(struct argv_array *array, const char *value)
+static void strvec_push_nodup(struct strvec *array, const char *value)
 {
-	if (array->argv == empty_argv)
+	if (array->argv == empty_strvec)
 		array->argv = NULL;
 
 	ALLOC_GROW(array->argv, array->argc + 2, array->alloc);
 	array->argv[array->argc++] = value;
 	array->argv[array->argc] = NULL;
 }
 
-const char *argv_array_push(struct argv_array *array, const char *value)
+const char *strvec_push(struct strvec *array, const char *value)
 {
-	argv_array_push_nodup(array, xstrdup(value));
+	strvec_push_nodup(array, xstrdup(value));
 	return array->argv[array->argc - 1];
 }
 
-const char *argv_array_pushf(struct argv_array *array, const char *fmt, ...)
+const char *strvec_pushf(struct strvec *array, const char *fmt, ...)
 {
 	va_list ap;
 	struct strbuf v = STRBUF_INIT;
@@ -36,28 +36,28 @@ const char *argv_array_pushf(struct argv_array *array, const char *fmt, ...)
 	strbuf_vaddf(&v, fmt, ap);
 	va_end(ap);
 
-	argv_array_push_nodup(array, strbuf_detach(&v, NULL));
+	strvec_push_nodup(array, strbuf_detach(&v, NULL));
 	return array->argv[array->argc - 1];
 }
 
-void argv_array_pushl(struct argv_array *array, ...)
+void strvec_pushl(struct strvec *array, ...)
 {
 	va_list ap;
 	const char *arg;
 
 	va_start(ap, array);
 	while ((arg = va_arg(ap, const char *)))
-		argv_array_push(array, arg);
+		strvec_push(array, arg);
 	va_end(ap);
 }
 
-void argv_array_pushv(struct argv_array *array, const char **argv)
+void strvec_pushv(struct strvec *array, const char **argv)
 {
 	for (; *argv; argv++)
-		argv_array_push(array, *argv);
+		strvec_push(array, *argv);
 }
 
-void argv_array_pop(struct argv_array *array)
+void strvec_pop(struct strvec *array)
 {
 	if (!array->argc)
 		return;
@@ -66,7 +66,7 @@ void argv_array_pop(struct argv_array *array)
 	array->argc--;
 }
 
-void argv_array_split(struct argv_array *array, const char *to_split)
+void strvec_split(struct strvec *array, const char *to_split)
 {
 	while (isspace(*to_split))
 		to_split++;
@@ -78,32 +78,32 @@ void argv_array_split(struct argv_array *array, const char *to_split)
 
 		while (*p && !isspace(*p))
 			p++;
-		argv_array_push_nodup(array, xstrndup(to_split, p - to_split));
+		strvec_push_nodup(array, xstrndup(to_split, p - to_split));
 
 		while (isspace(*p))
 			p++;
 		to_split = p;
 	}
 }
 
-void argv_array_clear(struct argv_array *array)
+void strvec_clear(struct strvec *array)
 {
-	if (array->argv != empty_argv) {
+	if (array->argv != empty_strvec) {
 		int i;
 		for (i = 0; i < array->argc; i++)
 			free((char *)array->argv[i]);
 		free(array->argv);
 	}
-	argv_array_init(array);
+	strvec_init(array);
 }
 
-const char **argv_array_detach(struct argv_array *array)
+const char **strvec_detach(struct strvec *array)
 {
-	if (array->argv == empty_argv)
+	if (array->argv == empty_strvec)
 		return xcalloc(1, sizeof(const char *));
 	else {
 		const char **ret = array->argv;
-		argv_array_init(array);
+		strvec_init(array);
 		return ret;
 	}
 }
diff --git a/argv-array.h b/argv-array.h
index 4fc57b6902..ca66a338ad 100644
--- a/argv-array.h
+++ b/argv-array.h
@@ -14,76 +14,89 @@
  * it contains an item structure with a `util` field that is not compatible
  * with the traditional argv interface.
  *
- * Each `argv_array` manages its own memory. Any strings pushed into the
- * array are duplicated, and all memory is freed by argv_array_clear().
+ * Each `strvec` manages its own memory. Any strings pushed into the
+ * array are duplicated, and all memory is freed by strvec_clear().
  */
 
-extern const char *empty_argv[];
+extern const char *empty_strvec[];
 
 /**
  * A single array. This should be initialized by assignment from
- * `ARGV_ARRAY_INIT`, or by calling `argv_array_init`. The `argv`
+ * `STRVEC_INIT`, or by calling `strvec_init`. The `argv`
  * member contains the actual array; the `argc` member contains the
  * number of elements in the array, not including the terminating
  * NULL.
  */
-struct argv_array {
+struct strvec {
 	const char **argv;
 	size_t argc;
 	size_t alloc;
 };
 
-#define ARGV_ARRAY_INIT { empty_argv, 0, 0 }
+#define STRVEC_INIT { empty_strvec, 0, 0 }
 
 /**
  * Initialize an array. This is no different than assigning from
- * `ARGV_ARRAY_INIT`.
+ * `STRVEC_INIT`.
  */
-void argv_array_init(struct argv_array *);
+void strvec_init(struct strvec *);
 
 /* Push a copy of a string onto the end of the array. */
-const char *argv_array_push(struct argv_array *, const char *);
+const char *strvec_push(struct strvec *, const char *);
 
 /**
  * Format a string and push it onto the end of the array. This is a
- * convenience wrapper combining `strbuf_addf` and `argv_array_push`.
+ * convenience wrapper combining `strbuf_addf` and `strvec_push`.
  */
 __attribute__((format (printf,2,3)))
-const char *argv_array_pushf(struct argv_array *, const char *fmt, ...);
+const char *strvec_pushf(struct strvec *, const char *fmt, ...);
 
 /**
  * Push a list of strings onto the end of the array. The arguments
  * should be a list of `const char *` strings, terminated by a NULL
  * argument.
  */
 LAST_ARG_MUST_BE_NULL
-void argv_array_pushl(struct argv_array *, ...);
+void strvec_pushl(struct strvec *, ...);
 
 /* Push a null-terminated array of strings onto the end of the array. */
-void argv_array_pushv(struct argv_array *, const char **);
+void strvec_pushv(struct strvec *, const char **);
 
 /**
  * Remove the final element from the array. If there are no
  * elements in the array, do nothing.
  */
-void argv_array_pop(struct argv_array *);
+void strvec_pop(struct strvec *);
 
 /* Splits by whitespace; does not handle quoted arguments! */
-void argv_array_split(struct argv_array *, const char *);
+void strvec_split(struct strvec *, const char *);
 
 /**
  * Free all memory associated with the array and return it to the
  * initial, empty state.
  */
-void argv_array_clear(struct argv_array *);
+void strvec_clear(struct strvec *);
 
 /**
- * Disconnect the `argv` member from the `argv_array` struct and
+ * Disconnect the `argv` member from the `strvec` struct and
  * return it. The caller is responsible for freeing the memory used
  * by the array, and by the strings it references. After detaching,
- * the `argv_array` is in a reinitialized state and can be pushed
+ * the `strvec` is in a reinitialized state and can be pushed
  * into again.
  */
-const char **argv_array_detach(struct argv_array *);
+const char **strvec_detach(struct strvec *);
+
+/* compatibility for historic argv_array interface */
+#define argv_array strvec
+#define ARGV_ARRAY_INIT STRVEC_INIT
+#define argv_array_init strvec_init
+#define argv_array_push strvec_push
+#define argv_array_pushf strvec_pushf
+#define argv_array_pushl strvec_pushl
+#define argv_array_pushv strvec_pushv
+#define argv_array_pop strvec_pop
+#define argv_array_split strvec_split
+#define argv_array_clear strvec_clear
+#define argv_array_detach strvec_detach
 
 #endif /* ARGV_ARRAY_H */
diff --git a/exec-cmd.h b/exec-cmd.h
index 8cd1df28d3..330b41d54d 100644
--- a/exec-cmd.h
+++ b/exec-cmd.h
@@ -1,13 +1,13 @@
 #ifndef GIT_EXEC_CMD_H
 #define GIT_EXEC_CMD_H
 
-struct argv_array;
+struct strvec;
 
 void git_set_exec_path(const char *exec_path);
 void git_resolve_executable_dir(const char *path);
 const char *git_exec_path(void);
 void setup_path(void);
-const char **prepare_git_cmd(struct argv_array *out, const char **argv);
+const char **prepare_git_cmd(struct strvec *out, const char **argv);
 int execv_git_cmd(const char **argv); /* NULL terminated */
 LAST_ARG_MUST_BE_NULL
 int execl_git_cmd(const char *cmd, ...);
diff --git a/ls-refs.h b/ls-refs.h
index 7e5646f5f6..7b33a7c6b8 100644
--- a/ls-refs.h
+++ b/ls-refs.h
@@ -2,9 +2,9 @@
 #define LS_REFS_H
 
 struct repository;
-struct argv_array;
+struct strvec;
 struct packet_reader;
-int ls_refs(struct repository *r, struct argv_array *keys,
+int ls_refs(struct repository *r, struct strvec *keys,
 	    struct packet_reader *request);
 
 #endif /* LS_REFS_H */
diff --git a/quote.h b/quote.h
index ca8ee3144a..210d580229 100644
--- a/quote.h
+++ b/quote.h
@@ -60,8 +60,8 @@ int sq_dequote_to_argv(char *arg, const char ***argv, int *nr, int *alloc);
  * still modify arg in place, but unlike sq_dequote_to_argv, the argv_array
  * will duplicate and take ownership of the strings.
  */
-struct argv_array;
-int sq_dequote_to_argv_array(char *arg, struct argv_array *);
+struct strvec;
+int sq_dequote_to_argv_array(char *arg, struct strvec *);
 
 int unquote_c_style(struct strbuf *, const char *quoted, const char **endp);
 size_t quote_c_style(const char *name, struct strbuf *, FILE *, int no_dq);
diff --git a/refs.h b/refs.h
index f212f8945e..29e28124cd 100644
--- a/refs.h
+++ b/refs.h
@@ -145,8 +145,8 @@ int refname_match(const char *abbrev_name, const char *full_name);
  * Given a 'prefix' expand it by the rules in 'ref_rev_parse_rules' and add
  * the results to 'prefixes'
  */
-struct argv_array;
-void expand_ref_prefix(struct argv_array *prefixes, const char *prefix);
+struct strvec;
+void expand_ref_prefix(struct strvec *prefixes, const char *prefix);
 
 int expand_ref(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
 int repo_dwim_ref(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
diff --git a/refspec.h b/refspec.h
index 3f2bd4aaa5..23e1555b88 100644
--- a/refspec.h
+++ b/refspec.h
@@ -60,12 +60,12 @@ void refspec_clear(struct refspec *rs);
 
 int valid_fetch_refspec(const char *refspec);
 
-struct argv_array;
+struct strvec;
 /*
  * Determine what <prefix> values to pass to the peer in ref-prefix lines
  * (see Documentation/technical/protocol-v2.txt).
  */
 void refspec_ref_prefixes(const struct refspec *rs,
-			  struct argv_array *ref_prefixes);
+			  struct strvec *ref_prefixes);
 
 #endif /* REFSPEC_H */
diff --git a/remote.h b/remote.h
index 5cc26c1b3b..5e3ea5a26d 100644
--- a/remote.h
+++ b/remote.h
@@ -168,7 +168,7 @@ void free_refs(struct ref *ref);
 
 struct oid_array;
 struct packet_reader;
-struct argv_array;
+struct strvec;
 struct string_list;
 struct ref **get_remote_heads(struct packet_reader *reader,
 			      struct ref **list, unsigned int flags,
@@ -178,7 +178,7 @@ struct ref **get_remote_heads(struct packet_reader *reader,
 /* Used for protocol v2 in order to retrieve refs from a remote */
 struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 			     struct ref **list, int for_push,
-			     const struct argv_array *ref_prefixes,
+			     const struct strvec *ref_prefixes,
 			     const struct string_list *server_options,
 			     int stateless_rpc);
 
diff --git a/serve.h b/serve.h
index 42ddca7f8b..fc2683e24d 100644
--- a/serve.h
+++ b/serve.h
@@ -1,8 +1,8 @@
 #ifndef SERVE_H
 #define SERVE_H
 
-struct argv_array;
-int has_capability(const struct argv_array *keys, const char *capability,
+struct strvec;
+int has_capability(const struct strvec *keys, const char *capability,
 		   const char **value);
 
 struct serve_options {
diff --git a/submodule.h b/submodule.h
index 4dad649f94..9ce85c03fe 100644
--- a/submodule.h
+++ b/submodule.h
@@ -1,7 +1,7 @@
 #ifndef SUBMODULE_H
 #define SUBMODULE_H
 
-struct argv_array;
+struct strvec;
 struct cache_entry;
 struct diff_options;
 struct index_state;
@@ -84,7 +84,7 @@ int should_update_submodules(void);
 const struct submodule *submodule_from_ce(const struct cache_entry *ce);
 void check_for_new_submodule_commits(struct object_id *oid);
 int fetch_populated_submodules(struct repository *r,
-			       const struct argv_array *options,
+			       const struct strvec *options,
 			       const char *prefix,
 			       int command_line_option,
 			       int default_option,
@@ -143,7 +143,7 @@ void submodule_unset_core_worktree(const struct submodule *sub);
  * a submodule by clearing any repo-specific environment variables, but
  * retaining any config in the environment.
  */
-void prepare_submodule_repo_env(struct argv_array *out);
+void prepare_submodule_repo_env(struct strvec *out);
 
 #define ABSORB_GITDIR_RECURSE_SUBMODULES (1<<0)
 void absorb_git_dir_into_superproject(const char *path,
diff --git a/transport-internal.h b/transport-internal.h
index 1cde6258a7..284784a2a6 100644
--- a/transport-internal.h
+++ b/transport-internal.h
@@ -3,7 +3,7 @@
 
 struct ref;
 struct transport;
-struct argv_array;
+struct strvec;
 
 struct transport_vtable {
 	/**
diff --git a/upload-pack.h b/upload-pack.h
index 4bafe16a22..27ddcdc6cb 100644
--- a/upload-pack.h
+++ b/upload-pack.h
@@ -11,9 +11,9 @@ struct upload_pack_options {
 void upload_pack(struct upload_pack_options *options);
 
 struct repository;
-struct argv_array;
+struct strvec;
 struct packet_reader;
-int upload_pack_v2(struct repository *r, struct argv_array *keys,
+int upload_pack_v2(struct repository *r, struct strvec *keys,
 		   struct packet_reader *request);
 
 struct strbuf;
-- 
2.28.0.rc2.475.g53c7e1c7f4

