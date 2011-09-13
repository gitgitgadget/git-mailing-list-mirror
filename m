From: Jeff King <peff@peff.net>
Subject: [PATCH 3/7] refactor argv_array into generic code
Date: Tue, 13 Sep 2011 17:57:57 -0400
Message-ID: <20110913215757.GC24490@sigill.intra.peff.net>
References: <20110913215026.GA26743@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 13 23:58:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3azW-0001aP-Lu
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 23:58:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932921Ab1IMV6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 17:58:00 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51527
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932834Ab1IMV6A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 17:58:00 -0400
Received: (qmail 2019 invoked by uid 107); 13 Sep 2011 21:58:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Sep 2011 17:58:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Sep 2011 17:57:57 -0400
Content-Disposition: inline
In-Reply-To: <20110913215026.GA26743@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181310>

The submodule code recently grew generic code to build a
dynamic argv array. Many other parts of the code can reuse
this, too, so let's make it generically available.

There are two enhancements not found in the original code:

  1. We now handle the NULL-termination invariant properly,
     even when no strings have been pushed (before, you
     could have an empty, NULL argv). This was not a problem
     for the submodule code, which always pushed at least
     one argument, but was not sufficiently safe for
     generic code.

  2. There is a formatted variant of the "push" function.
     This is a convenience function which was not needed by
     the submodule code, but will make it easier to port
     other users to the new code.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/api-argv-array.txt |   46 ++++++++++++++++++++++++
 Makefile                                   |    2 +
 argv-array.c                               |   52 ++++++++++++++++++++++++++++
 argv-array.h                               |   20 +++++++++++
 submodule.c                                |   41 +++-------------------
 5 files changed, 126 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/technical/api-argv-array.txt
 create mode 100644 argv-array.c
 create mode 100644 argv-array.h

diff --git a/Documentation/technical/api-argv-array.txt b/Documentation/technical/api-argv-array.txt
new file mode 100644
index 0000000..49b3d52
--- /dev/null
+++ b/Documentation/technical/api-argv-array.txt
@@ -0,0 +1,46 @@
+argv-array API
+==============
+
+The argv-array API allows one to dynamically build and store
+NULL-terminated lists.  An argv-array maintains the invariant that the
+`argv` member always points to a non-NULL array, and that the array is
+always NULL-terminated at the element pointed to by `argv[argc]`. This
+makes the result suitable for passing to functions expecting to receive
+argv from main(), or the link:api-run-command.html[run-command API].
+
+The link:api-string-list.html[string-list API] is similar, but cannot be
+used for these purposes; instead of storing a straight string pointer,
+it contains an item structure with a `util` field that is not compatible
+with the traditional argv interface.
+
+Each `argv_array` manages its own memory. Any strings pushed into the
+array are duplicated, and all memory is freed by argv_array_clear().
+
+Data Structures
+---------------
+
+`struct argv_array`::
+
+	A single array. This should be initialized by assignment from
+	`ARGV_ARRAY_INIT`, or by calling `argv_array_init`. The `argv`
+	member contains the actual array; the `argc` member contains the
+	number of elements in the array, not including the terminating
+	NULL.
+
+Functions
+---------
+
+`argv_array_init`::
+	Initialize an array. This is no different than assigning from
+	`ARGV_ARRAY_INIT`.
+
+`argv_array_push`::
+	Push a copy of a string onto the end of the array.
+
+`argv_array_pushf`::
+	Format a string and push it onto the end of the array. This is a
+	convenience wrapper combining `strbuf_addf` and `argv_array_push`.
+
+`argv_array_clear`::
+	Free all memory associated with the array and return it to the
+	initial, empty state.
diff --git a/Makefile b/Makefile
index e40ac0c..ec7d06c 100644
--- a/Makefile
+++ b/Makefile
@@ -497,6 +497,7 @@ VCSSVN_LIB=vcs-svn/lib.a
 
 LIB_H += advice.h
 LIB_H += archive.h
+LIB_H += argv-array.h
 LIB_H += attr.h
 LIB_H += blob.h
 LIB_H += builtin.h
@@ -575,6 +576,7 @@ LIB_OBJS += alloc.o
 LIB_OBJS += archive.o
 LIB_OBJS += archive-tar.o
 LIB_OBJS += archive-zip.o
+LIB_OBJS += argv-array.o
 LIB_OBJS += attr.o
 LIB_OBJS += base85.o
 LIB_OBJS += bisect.o
diff --git a/argv-array.c b/argv-array.c
new file mode 100644
index 0000000..a50507a
--- /dev/null
+++ b/argv-array.c
@@ -0,0 +1,52 @@
+#include "cache.h"
+#include "argv-array.h"
+#include "strbuf.h"
+
+static const char *empty_argv_storage = NULL;
+const char **empty_argv = &empty_argv_storage;
+
+void argv_array_init(struct argv_array *array)
+{
+	array->argv = empty_argv;
+	array->argc = 0;
+	array->alloc = 0;
+}
+
+static void argv_array_push_nodup(struct argv_array *array, const char *value)
+{
+	if (array->argv == empty_argv)
+		array->argv = NULL;
+
+	ALLOC_GROW(array->argv, array->argc + 2, array->alloc);
+	array->argv[array->argc++] = value;
+	array->argv[array->argc] = NULL;
+}
+
+void argv_array_push(struct argv_array *array, const char *value)
+{
+	argv_array_push_nodup(array, xstrdup(value));
+}
+
+void argv_array_pushf(struct argv_array *array, const char *fmt, ...)
+{
+	va_list ap;
+	struct strbuf v = STRBUF_INIT;
+
+	va_start(ap, fmt);
+	strbuf_vaddf(&v, fmt, ap);
+	va_end(ap);
+
+	argv_array_push_nodup(array, strbuf_detach(&v, NULL));
+}
+
+void argv_array_clear(struct argv_array *array)
+{
+	if (array->argv != empty_argv) {
+		int i;
+		for (i = 0; i < array->argc; i++)
+			free((char **)array->argv[i]);
+		free(array->argv);
+	}
+	argv_array_init(array);
+}
+
diff --git a/argv-array.h b/argv-array.h
new file mode 100644
index 0000000..2b6273b
--- /dev/null
+++ b/argv-array.h
@@ -0,0 +1,20 @@
+#ifndef ARGV_ARRAY_H
+#define ARGV_ARRAY_H
+
+extern const char **empty_argv;
+
+struct argv_array {
+	const char **argv;
+	int argc;
+	int alloc;
+};
+
+#define ARGV_ARRAY_INIT { empty_argv, 0, 0 };
+
+void argv_array_init(struct argv_array *);
+void argv_array_push(struct argv_array *, const char *);
+__attribute__((format (printf,2,3)))
+void argv_array_pushf(struct argv_array *, const char *fmt, ...);
+void argv_array_clear(struct argv_array *);
+
+#endif /* ARGV_ARRAY_H */
diff --git a/submodule.c b/submodule.c
index 9431c42..6306737 100644
--- a/submodule.c
+++ b/submodule.c
@@ -9,6 +9,7 @@
 #include "refs.h"
 #include "string-list.h"
 #include "sha1-array.h"
+#include "argv-array.h"
 
 static struct string_list config_name_for_path;
 static struct string_list config_fetch_recurse_submodules_for_name;
@@ -388,52 +389,22 @@ void check_for_new_submodule_commits(unsigned char new_sha1[20])
 	sha1_array_append(&ref_tips_after_fetch, new_sha1);
 }
 
-struct argv_array {
-	const char **argv;
-	unsigned int argc;
-	unsigned int alloc;
-};
-
-static void init_argv(struct argv_array *array)
-{
-	array->argv = NULL;
-	array->argc = 0;
-	array->alloc = 0;
-}
-
-static void push_argv(struct argv_array *array, const char *value)
-{
-	ALLOC_GROW(array->argv, array->argc + 2, array->alloc);
-	array->argv[array->argc++] = xstrdup(value);
-	array->argv[array->argc] = NULL;
-}
-
-static void clear_argv(struct argv_array *array)
-{
-	int i;
-	for (i = 0; i < array->argc; i++)
-		free((char **)array->argv[i]);
-	free(array->argv);
-	init_argv(array);
-}
-
 static void add_sha1_to_argv(const unsigned char sha1[20], void *data)
 {
-	push_argv(data, sha1_to_hex(sha1));
+	argv_array_push(data, sha1_to_hex(sha1));
 }
 
 static void calculate_changed_submodule_paths(void)
 {
 	struct rev_info rev;
 	struct commit *commit;
-	struct argv_array argv;
+	struct argv_array argv = ARGV_ARRAY_INIT;
 
 	init_revisions(&rev, NULL);
-	init_argv(&argv);
-	push_argv(&argv, "--"); /* argv[0] program name */
+	argv_array_push(&argv, "--"); /* argv[0] program name */
 	sha1_array_for_each_unique(&ref_tips_after_fetch,
 				   add_sha1_to_argv, &argv);
-	push_argv(&argv, "--not");
+	argv_array_push(&argv, "--not");
 	sha1_array_for_each_unique(&ref_tips_before_fetch,
 				   add_sha1_to_argv, &argv);
 	setup_revisions(argv.argc, argv.argv, &rev, NULL);
@@ -460,7 +431,7 @@ static void calculate_changed_submodule_paths(void)
 		}
 	}
 
-	clear_argv(&argv);
+	argv_array_clear(&argv);
 	sha1_array_clear(&ref_tips_before_fetch);
 	sha1_array_clear(&ref_tips_after_fetch);
 	initialized_fetch_ref_tips = 0;
-- 
1.7.7.rc1.2.gb2409
