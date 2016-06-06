From: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
Subject: [PATCH V2 3/3] strbuf: allow to use preallocated memory
Date: Mon,  6 Jun 2016 17:13:40 +0200
Message-ID: <20160606151340.22424-4-william.duclot@ensimag.grenoble-inp.fr>
References: <20160606151340.22424-1-william.duclot@ensimag.grenoble-inp.fr>
Cc: antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr, mhagger@alum.mit.edu,
	Johannes.Schindelin@gmx.de, peff@peff.net, mh@glandium.org,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 17:14:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9wEq-0008Rd-Ml
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 17:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356AbcFFPOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 11:14:33 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:45410 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751091AbcFFPOa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2016 11:14:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 81D9E20A5;
	Mon,  6 Jun 2016 17:14:27 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0xcD7w6-iRC4; Mon,  6 Jun 2016 17:14:27 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 62D072071;
	Mon,  6 Jun 2016 17:14:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 5FF5C2066;
	Mon,  6 Jun 2016 17:14:27 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f0q5BWkjF3dn; Mon,  6 Jun 2016 17:14:27 +0200 (CEST)
Received: from Messiaen.grenet.fr (eduroam-032048.grenet.fr [130.190.32.48])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 389012055;
	Mon,  6 Jun 2016 17:14:27 +0200 (CEST)
X-Mailer: git-send-email 2.9.0.rc1.1.geac644e
In-Reply-To: <20160606151340.22424-1-william.duclot@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296518>

When working with strbufs (usually for dates or paths), the
malloc()/free() overhead could be easily avoided: as a sensible initial
buffer size is already known, it could be allocated on the stack. This
could avoid workarounds such as

    void f()
    {
        static struct strbuf path;
        strbuf_add(&path, ...);
        ...
        strbuf_setlen(&path, 0);
    }

which, by using a static variable, avoid most of the malloc()/free()
overhead, but makes the function unsafe to use recursively or from
multiple threads.

THE IDEA
--------

The idea here is to enhance strbuf to allow it to use memory that it
doesn't own (for example, stack-allocated memory), while (optionally)
allowing it to switch over to using allocated memory if the string grows
past the size of the pre-allocated buffer.

API ENHANCEMENT
---------------

All functions of the API can still be reliably called without
knowledge of the initialization (normal/preallocated/fixed) with the
exception that strbuf_grow() may die() if the string tries to overflow a
fixed buffer.

The API contract is still respected:

- The API users may peek strbuf.buf in-place until they perform an
  operation that makes its size change (at which point the .buf pointer
  may point at a new piece of memory).

- The API users may strbuf_detach() to obtain a piece of memory that
  belongs to them (at which point the strbuf becomes empty), hence
  needs to be freed by the callers.

- The API users letting a strbuf go out of scope without taking
  ownership of the string with strbuf_detach() _must_ release the
  resource by calling strbuf_release().

Full credit to Michael Haggerty for the idea and some of the wording of
this commit (http://mid.gmane.org/53512DB6.1070600@alum.mit.edu). The
implementation and bugs are all mine.

Signed-off by: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
Signed-off by: Simon Rabourg <simon.rabourg@ensimag.grenoble-inp.fr>
Signed-off by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
Changes since V1:
    * Refactoring: use a `strbuf_wrap_internal()` static function
    * Use bit fields for flags
    * Completing documentation & commit message
    * Rename `strbuf_wrap_preallocated()` to `strbuf_wrap()`
    * Introduce two initialization macros for wrapping

 strbuf.c               |  82 ++++++++++++++++++++++++++-----
 strbuf.h               |  44 ++++++++++++++++-
 t/helper/test-strbuf.c | 130 ++++++++++++++++++++++++++++++++++++++++++++++++-
 t/t0082-strbuf.sh      |  29 +++++++++++
 4 files changed, 270 insertions(+), 15 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 1ba600b..689469e 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,6 +1,9 @@
 #include "cache.h"
 #include "refs.h"
 #include "utf8.h"

+#define MAX_ALLOC(a, b) (((a)>(b))?(a):(b))
 
 int starts_with(const char *str, const char *prefix)
 {
@@ -20,16 +23,47 @@ char strbuf_slopbuf[1];
 
 void strbuf_init(struct strbuf *sb, size_t hint)
 {
+	sb->owns_memory = 0;
+	sb->fixed_memory = 0;
 	sb->alloc = sb->len = 0;
 	sb->buf = strbuf_slopbuf;
 	if (hint)
 		strbuf_grow(sb, hint);
 }
 
+static void strbuf_wrap_internal(struct strbuf *sb, char *buf,
+				 size_t buf_len, size_t alloc_len)
+{
+	if (!buf)
+		die("the buffer of a strbuf cannot be NULL");
+
+	strbuf_release(sb);
+	sb->len = buf_len;
+	sb->alloc = alloc_len;
+	sb->buf = buf;
+}
+
+void strbuf_wrap(struct strbuf *sb, char *buf,
+		 size_t buf_len, size_t alloc_len)
+{
+	strbuf_wrap_internal(sb, buf, buf_len, alloc_len);
+	sb->owns_memory = 0;
+	sb->fixed_memory = 0;
+}
+
+void strbuf_wrap_fixed(struct strbuf *sb, char *buf,
+		       size_t buf_len, size_t alloc_len)
+{
+	strbuf_wrap_internal(sb, buf, buf_len, alloc_len);
+	sb->owns_memory = 0;
+	sb->fixed_memory = 1;
+}
+
 void strbuf_release(struct strbuf *sb)
 {
 	if (sb->alloc) {
-		free(sb->buf);
+		if (sb->owns_memory)
+			free(sb->buf);
 		strbuf_init(sb, 0);
 	}
 }
@@ -37,8 +71,13 @@ void strbuf_release(struct strbuf *sb)
 char *strbuf_detach(struct strbuf *sb, size_t *sz)
 {
 	char *res;
+
 	strbuf_grow(sb, 0);
-	res = sb->buf;
+	if (sb->owns_memory)
+		res = sb->buf;
+	else
+		res = xmemdupz(sb->buf, sb->len);
+
 	if (sz)
 		*sz = sb->len;
 	strbuf_init(sb, 0);
@@ -47,25 +86,44 @@ char *strbuf_detach(struct strbuf *sb, size_t *sz)
 
 void strbuf_attach(struct strbuf *sb, void *buf, size_t len, size_t alloc)
 {
-	strbuf_release(sb);
-	sb->buf   = buf;
-	sb->len   = len;
-	sb->alloc = alloc;
+	strbuf_wrap_internal(sb, buf, len, alloc);
+	sb->owns_memory = 1;
+	sb->fixed_memory = 0;
 	strbuf_grow(sb, 0);
 	sb->buf[sb->len] = '\0';
 }
 
 void strbuf_grow(struct strbuf *sb, size_t extra)
 {
-	int new_buf = !sb->alloc;
 	if (unsigned_add_overflows(extra, 1) ||
 	    unsigned_add_overflows(sb->len, extra + 1))
 		die("you want to use way too much memory");
-	if (new_buf)
-		sb->buf = NULL;
-	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
-	if (new_buf)
-		sb->buf[0] = '\0';
+	if ((sb->fixed_memory) &&
+	    sb->len + extra + 1 > sb->alloc)
+		die("you try to overflow the buffer of a fixed strbuf");
+
+	/*
+	 * ALLOC_GROW may do a realloc() if needed, so we must not use it on
+	 * a buffer the strbuf doesn't own
+	 */
+	if (sb->owns_memory) {
+		ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
+	} else {
+		/*
+		 * The strbuf doesn't own the buffer: to avoid to realloc it,
+		 * the strbuf needs to use a new buffer without freeing the old
+		 */
+		if (sb->len + extra + 1 > sb->alloc) {
+			size_t new_alloc =
+				MAX_ALLOC(sb->len + extra + 1,
+					  alloc_nr(sb->alloc));
+			char *new_buf = xmalloc(new_alloc);
+			memcpy(new_buf, sb->buf, sb->len + 1);
+			sb->buf = new_buf;
+			sb->alloc = new_alloc;
+			sb->owns_memory = 1;
+		}
+	}
 }
 
 void strbuf_trim(struct strbuf *sb)
diff --git a/strbuf.h b/strbuf.h
index 7987405..57b5cd1 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -11,11 +11,16 @@
  * A strbuf is NUL terminated for convenience, but no function in the
  * strbuf API actually relies on the string being free of NULs.
  *
+ * You can avoid the malloc/free overhead of `strbuf_init()`, `strbuf_add()` and
+ * `strbuf_release()` by wrapping pre-allocated memory (stack-allocated for
+ * example) using `strbuf_wrap()` or `strbuf_wrap_fixed()`.
+ *
  * strbufs have some invariants that are very important to keep in mind:
  *
  *  - The `buf` member is never NULL, so it can be used in any usual C
  *    string operations safely. strbuf's _have_ to be initialized either by
- *    `strbuf_init()` or by `= STRBUF_INIT` before the invariants, though.
+ *    `strbuf_init()`, `= STRBUF_INIT`, `strbuf_wrap()` or `strbuf_wrap_fixed()`
+ *    before the invariants, though.
  *
  *    Do *not* assume anything on what `buf` really is (e.g. if it is
  *    allocated memory or not), use `strbuf_detach()` to unwrap a memory
@@ -45,12 +50,16 @@
  *    Doing so is safe, though if it has to be done in many places, adding the
  *    missing API to the strbuf module is the way to go.
  *
+ *    NOTE: strbuf_release can always be safely called, whether the strbuf is
+ *    wrapping a preallocated buffer or not.
+ *
  *    WARNING: Do _not_ assume that the area that is yours is of size `alloc
  *    - 1` even if it's true in the current implementation. Alloc is somehow a
  *    "private" member that should not be messed with. Use `strbuf_avail()`
  *    instead.
 */
 
+
 /**
  * Data Structures
  * ---------------
@@ -62,13 +71,23 @@
  * access to the string itself.
  */
 struct strbuf {
+	/*
+	 * The `owns_memory` flag is unset by default as strbuf_slopbuf is
+	 * shared by all buffers, thus owned by none.
+	 * The `fixed_memory` guarantees that the buffer will not be moved by
+	 * realloc().
+	 */
+	unsigned owns_memory:1, fixed_memory:1;
 	size_t alloc;
 	size_t len;
 	char *buf;
 };
 
 extern char strbuf_slopbuf[];
-#define STRBUF_INIT  { 0, 0, strbuf_slopbuf }
+#define STRBUF_INIT  { 0, 0, 0, 0, strbuf_slopbuf }
+#define STRBUF_WRAP(buf, buf_len, alloc_len) { 0, 0, alloc_len, buf_len, buf }
+#define STRBUF_WRAP_FIXED(buf, buf_len, alloc_len) \
+	{ 0, 1, alloc_len, buf_len, buf }
 
 /**
  * Life Cycle Functions
@@ -81,6 +100,25 @@ extern char strbuf_slopbuf[];
  */
 extern void strbuf_init(struct strbuf *, size_t);
 
+/**
+ * Allow the caller to give a pre-allocated piece of memory for the strbuf
+ * to use. It is possible then to strbuf_grow() the string past the size of the
+ * pre-allocated buffer: a new buffer will then be allocated. The pre-allocated
+ * buffer will never be freed.
+ */
+void strbuf_wrap(struct strbuf *sb, char *buf,
+		 size_t buf_len, size_t alloc_len);
+
+/**
+ * Allow the caller to give a pre-allocated piece of memory for the strbuf
+ * to use and indicate that the strbuf must use exclusively this buffer,
+ * never realloc() it or allocate a new one. It means that the string can
+ * grow or shrink but cannot overflow the pre-allocated buffer. The
+ * pre-allocated buffer will never be freed.
+ */
+void strbuf_wrap_fixed(struct strbuf *sb, char *buf,
+		       size_t buf_len, size_t alloc_len);
+
 /**
  * Release a string buffer and the memory it used. You should not use the
  * string buffer after using this function, unless you initialize it again.
@@ -91,6 +129,8 @@ extern void strbuf_release(struct strbuf *);
  * Detach the string from the strbuf and returns it; you now own the
  * storage the string occupies and it is your responsibility from then on
  * to release it with `free(3)` when you are done with it.
+ * Must allocate a copy of the buffer in case of a wrapped buffer.
+ * Performance-critical operations have to be aware of this.
  */
 extern char *strbuf_detach(struct strbuf *, size_t *);
 
diff --git a/t/helper/test-strbuf.c b/t/helper/test-strbuf.c
index 271592e..87628d9 100644
--- a/t/helper/test-strbuf.c
+++ b/t/helper/test-strbuf.c
@@ -55,6 +55,75 @@ static void grow_overflow(struct strbuf *sb)
 	strbuf_grow(sb, maximum_unsigned_value_of_type((size_t)1));
 }
 
+static void preallocated_NULL(struct strbuf *sb)
+{
+	char str_test[5] = "test";
+
+	strbuf_wrap(sb, NULL, 0, sizeof(str_test));
+}
+
+static void grow_fixed_overflow(struct strbuf *sb)
+{
+	char str_foo[7] = "foo";
+
+	strbuf_wrap_fixed(sb, (void *)str_foo,
+			  strlen(str_foo), sizeof(str_foo));
+	strbuf_grow(sb, 3);
+	strbuf_grow(sb, 1000);
+}
+
+static void grow_fixed_overflow_min(struct strbuf *sb)
+{
+	char str_foo[7] = "foo";
+
+	strbuf_wrap_fixed(sb, (void *)str_foo,
+			  strlen(str_foo), sizeof(str_foo));
+	strbuf_grow(sb, 4);
+}
+
+static int grow_fixed_success(struct strbuf *sb)
+{
+	char str_foo[7] = "foo";
+
+	strbuf_wrap_fixed(sb, (void *)str_foo,
+			  strlen(str_foo), sizeof(str_foo));
+	strbuf_grow(sb, 3);
+
+	return 0;
+}
+
+static int detach_fixed(struct strbuf *sb)
+{
+	size_t size = 1;
+	char str_test[5] = "test";
+	char *buf;
+
+	strbuf_wrap_fixed(sb, (void *)str_test,
+			  strlen(str_test), sizeof(str_test));
+	buf = strbuf_detach(sb, &size);
+	if (size != strlen(str_test))
+		die ("size is not as expected");
+
+	if (str_test == buf)
+		die("strbuf_detach does not copy the buffer");
+	free(buf);
+
+	return 0;
+}
+
+static int release_fixed(struct strbuf *sb)
+{
+	char str_test[5] = "test";
+
+	strbuf_wrap_fixed(sb, (void *)str_test, strlen(str_test),
+			  sizeof(sb) + 1);
+	strbuf_release(sb);
+	if (sb->buf != strbuf_slopbuf)
+		die("strbuf_release does not reinitialize the strbuf");
+
+	return 0;
+}
+
 int main(int argc, const char *argv[])
 {
 	struct strbuf sb;
@@ -62,7 +131,14 @@ int main(int argc, const char *argv[])
 		MODE_UNSPECIFIED = 0,
 		MODE_BASIC_GROW ,
 		MODE_STRBUF_CHECK,
-		MODE_GROW_OVERFLOW
+		MODE_GROW_OVERFLOW,
+		MODE_PREALLOC_CHECK,
+		MODE_PREALLOC_NULL,
+		MODE_GROW_FIXED_OVERFLOW,
+		MODE_GROW_FIXED_OVERFLOW_MIN,
+		MODE_GROW_FIXED_SUCCESS,
+		MODE_DETACH_FIXED,
+		MODE_RELEASE_FIXED
 	} cmdmode = MODE_UNSPECIFIED;
 	struct option options[] = {
 		OPT_CMDMODE(0, "basic_grow", &cmdmode,
@@ -74,6 +150,27 @@ int main(int argc, const char *argv[])
 		OPT_CMDMODE(0, "grow_overflow", &cmdmode,
 			    N_("test grow expecting overflow"),
 			    MODE_GROW_OVERFLOW),
+		OPT_CMDMODE(0, "preallocated_check_behavior", &cmdmode,
+			    N_("check the wrap's behavior"),
+			    MODE_PREALLOC_CHECK),
+		OPT_CMDMODE(0, "preallocated_NULL", &cmdmode,
+			    N_("initializing wrap with NULL"),
+			    MODE_PREALLOC_NULL),
+		OPT_CMDMODE(0, "grow_fixed_overflow", &cmdmode,
+			    N_("check grow, fixed memory expecting overflow"),
+			    MODE_GROW_FIXED_OVERFLOW),
+		OPT_CMDMODE(0, "grow_fixed_overflow_min", &cmdmode,
+			    N_("check grow, fixed memory and lower_bound for an overflow"),
+			    MODE_GROW_FIXED_OVERFLOW_MIN),
+		OPT_CMDMODE(0, "grow_fixed_success", &cmdmode,
+			    N_("check grow, fixed memory"),
+			    MODE_GROW_FIXED_SUCCESS),
+		OPT_CMDMODE(0, "detach_fixed", &cmdmode,
+			    N_("check detach, fixed memory"),
+			    MODE_DETACH_FIXED),
+		OPT_CMDMODE(0, "release_fixed", &cmdmode,
+			    N_("check release, fixed memory"),
+			    MODE_RELEASE_FIXED),
 		OPT_END()
 	};
 
@@ -93,6 +190,37 @@ int main(int argc, const char *argv[])
 		 * If this does not die(), fall through to returning success.
 		 */
 		grow_overflow(&sb);
+	} else if (cmdmode == MODE_PREALLOC_CHECK) {
+		char str_test[5] = "test";
+
+		strbuf_wrap(&sb, (void *)str_test,
+			    strlen(str_test), sizeof(str_test));
+		return strbuf_check_behavior(&sb);
+	} else if (cmdmode == MODE_PREALLOC_NULL) {
+		 /*
+		 * Violation of invariant "strbuf can't be NULL": should die().
+		 * If this does not die(), fall through to returning success.
+		 */
+		preallocated_NULL(&sb);
+	} else if (cmdmode == MODE_GROW_FIXED_OVERFLOW) {
+		/*
+		 * Overflowing the buffer of a fixed strbuf: should die().
+		 * If this does not die(), fall through to returning success.
+		 */
+		grow_fixed_overflow(&sb);
+	} else if (cmdmode == MODE_GROW_FIXED_OVERFLOW_MIN) {
+		/*
+		 * Minimum strbuf_grow() for overflowing a fixed strbuf: should
+		 * die().
+		 * If this does not die(), fall through to returning success.
+		 */
+		grow_fixed_overflow_min(&sb);
+	} else if (cmdmode == MODE_GROW_FIXED_SUCCESS) {
+		return grow_fixed_success(&sb);
+	} else if (cmdmode == MODE_DETACH_FIXED) {
+		return detach_fixed(&sb);
+	} else if (cmdmode == MODE_RELEASE_FIXED) {
+		return release_fixed(&sb);
 	} else {
 		usage("test-strbuf mode");
 	}
diff --git a/t/t0082-strbuf.sh b/t/t0082-strbuf.sh
index 6a579a3..6bea747 100755
--- a/t/t0082-strbuf.sh
+++ b/t/t0082-strbuf.sh
@@ -16,4 +16,33 @@ test_expect_success 'overflow while calling strbuf_grow' '
 	test_must_fail test-strbuf --grow_overflow
 '
 
+test_expect_success 'check preallocated strbuf behavior in usual use cases' '
+
+	test-strbuf --preallocated_check_behavior
+'
+
+test_expect_success 'strbuf_wrap_preallocated NULL initialization' '
+	test_must_fail test-strbuf --preallocated_NULL
+'
+
+test_expect_success 'strbuf_grow with wrap_fixed overflow' '
+	test_must_fail test-strbuf --grow_fixed_overflow
+'
+
+test_expect_success 'strbuf_grow with wrap_fixed minimum overflow' '
+	test_must_fail test-strbuf --grow_fixed_overflow_min
+'
+
+test_expect_success 'strbuf_grow with wrap_fixed in a successful case' '
+	test-strbuf --grow_fixed_success
+'
+
+test_expect_success 'stbuf_detach with wrap_fixed memory' '
+	test-strbuf --detach_fixed
+'
+
+test_expect_success 'stbuf_release with wrap_fixed memory' '
+	test-strbuf --release_fixed
+'
+
 test_done
-- 
2.9.0.rc1.1.geac644e
