From: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
Subject: [PATCH 2/2] strbuf: allow to use preallocated memory
Date: Mon, 30 May 2016 12:36:42 +0200
Message-ID: <20160530103642.7213-3-william.duclot@ensimag.grenoble-inp.fr>
References: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr>
Cc: simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	antoine.queru@ensimag.grenoble-inp.fr,
	matthieu.moy@grenoble-inp.fr, mhagger@alum.mit.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 12:37:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7KZb-0000bQ-Gr
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 12:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754615AbcE3KhA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 06:37:00 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:53536 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754249AbcE3Kgz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2016 06:36:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 7BF962098;
	Mon, 30 May 2016 12:36:52 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BzajZsR2ToZD; Mon, 30 May 2016 12:36:52 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 603F320AD;
	Mon, 30 May 2016 12:36:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 5DBFC2077;
	Mon, 30 May 2016 12:36:52 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q5D3NUm31Wdg; Mon, 30 May 2016 12:36:52 +0200 (CEST)
Received: from Messiaen.grenet.fr (eduroam-033086.grenet.fr [130.190.33.86])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 3D4072079;
	Mon, 30 May 2016 12:36:52 +0200 (CEST)
X-Mailer: git-send-email 2.8.2.403.ge2646ba.dirty
In-Reply-To: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295877>

It is unfortunate that it is currently impossible to use a strbuf
without doing a memory allocation. So code like

void f()
{
    char path[PATH_MAX];
    ...
}

typically gets turned into either

void f()
{
    struct strbuf path;
    strbuf_add(&path, ...); <-- does a malloc
    ...
    strbuf_release(&path);  <-- does a free
}

which costs extra memory allocations, or

void f()
{
    static struct strbuf path;
    strbuf_add(&path, ...);
    ...
    strbuf_setlen(&path, 0);
}

which, by using a static variable, avoids most of the malloc/free
overhead, but makes the function unsafe to use recursively or from
multiple threads. Those limitations prevent strbuf to be used in
performance-critical operations.

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
exception that strbuf_grow() may die() if the string try to overflow a
fixed buffer.

The API contract is still respected:

- The API users may peek strbuf.buf in-place until they perform an
  operation that makes it longer (at which point the .buf pointer
  may point at a new piece of memory).

- The API users may strbuf_detach() to obtain a piece of memory that
  belongs to them (at which point the strbuf becomes empty), hence
  needs to be freed by the callers.

Full credit to Michael Haggerty for the idea and most of the wording of
this commit (http://mid.gmane.org/53512DB6.1070600@alum.mit.edu). The
implementation and bugs are all mine.

Signed-off by: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
Signed-off by: Simon Rabourg <simon.rabourg@ensimag.grenoble-inp.fr>
Signed-off by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 strbuf.c               | 68 ++++++++++++++++++++++++++++++++++++++++++++++----
 strbuf.h               | 31 +++++++++++++++++++++--
 t/helper/test-strbuf.c | 42 +++++++++++++++++++++++++++++++
 t/t0082-strbuf.sh      | 28 +++++++++++++++++++++
 4 files changed, 162 insertions(+), 7 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 1ba600b..527b986 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,6 +1,14 @@
 #include "cache.h"
 #include "refs.h"
 #include "utf8.h"
+#include <sys/param.h>
+
+/**
+ * Flags
+ * --------------
+ */
+#define STRBUF_OWNS_MEMORY 1
+#define STRBUF_FIXED_MEMORY (1 << 1)
 
 int starts_with(const char *str, const char *prefix)
 {
@@ -20,16 +28,37 @@ char strbuf_slopbuf[1];
 
 void strbuf_init(struct strbuf *sb, size_t hint)
 {
+	sb->flags = 0;
 	sb->alloc = sb->len = 0;
 	sb->buf = strbuf_slopbuf;
 	if (hint)
 		strbuf_grow(sb, hint);
 }
 
+void strbuf_wrap_preallocated(struct strbuf *sb, char *path_buf,
+			      size_t path_buf_len, size_t alloc_len)
+{
+	if (!path_buf)
+		die("you try to use a NULL buffer to initialize a strbuf");
+
+	strbuf_init(sb, 0);
+	strbuf_attach(sb, path_buf, path_buf_len, alloc_len);
+	sb->flags &= ~STRBUF_OWNS_MEMORY;
+	sb->flags &= ~STRBUF_FIXED_MEMORY;
+}
+
+void strbuf_wrap_fixed(struct strbuf *sb, char *path_buf,
+		       size_t path_buf_len, size_t alloc_len)
+{
+	strbuf_wrap_preallocated(sb, path_buf, path_buf_len, alloc_len);
+	sb->flags |= STRBUF_FIXED_MEMORY;
+}
+
 void strbuf_release(struct strbuf *sb)
 {
 	if (sb->alloc) {
-		free(sb->buf);
+		if (sb->flags & STRBUF_OWNS_MEMORY)
+			free(sb->buf);
 		strbuf_init(sb, 0);
 	}
 }
@@ -38,7 +67,11 @@ char *strbuf_detach(struct strbuf *sb, size_t *sz)
 {
 	char *res;
 	strbuf_grow(sb, 0);
-	res = sb->buf;
+	if (sb->flags & STRBUF_OWNS_MEMORY)
+		res = sb->buf;
+	else
+		res = xmemdupz(sb->buf, sb->alloc - 1);
+
 	if (sz)
 		*sz = sb->len;
 	strbuf_init(sb, 0);
@@ -51,6 +84,8 @@ void strbuf_attach(struct strbuf *sb, void *buf, size_t len, size_t alloc)
 	sb->buf   = buf;
 	sb->len   = len;
 	sb->alloc = alloc;
+	sb->flags |= STRBUF_OWNS_MEMORY;
+	sb->flags &= ~STRBUF_FIXED_MEMORY;
 	strbuf_grow(sb, 0);
 	sb->buf[sb->len] = '\0';
 }
@@ -61,9 +96,32 @@ void strbuf_grow(struct strbuf *sb, size_t extra)
 	if (unsigned_add_overflows(extra, 1) ||
 	    unsigned_add_overflows(sb->len, extra + 1))
 		die("you want to use way too much memory");
-	if (new_buf)
-		sb->buf = NULL;
-	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
+	if ((sb->flags & STRBUF_FIXED_MEMORY) && sb->len + extra + 1 > sb->alloc)
+		die("you try to make a string overflow the buffer of a fixed strbuf");
+
+	/*
+	 * ALLOC_GROW may do a realloc() if needed, so we must not use it on
+	 * a buffer the strbuf doesn't own
+	 */
+	if (sb->flags & STRBUF_OWNS_MEMORY) {
+		if (new_buf)
+			sb->buf = NULL;
+		ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
+	} else {
+		/*
+		 * The strbuf doesn't own the buffer: to avoid to realloc it,
+		 * the strbuf needs to use a new buffer without freeing the old
+		 */
+		if (sb->len + extra + 1 > sb->alloc) {
+			size_t new_alloc = MAX(sb->len + extra + 1, alloc_nr(sb->alloc));
+			char *buf = xmalloc(new_alloc);
+			memcpy(buf, sb->buf, sb->alloc);
+			sb->buf = buf;
+			sb->alloc = new_alloc;
+			sb->flags |= STRBUF_OWNS_MEMORY;
+		}
+	}
+
 	if (new_buf)
 		sb->buf[0] = '\0';
 }
diff --git a/strbuf.h b/strbuf.h
index 7987405..634759c 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -11,11 +11,16 @@
  * A strbuf is NUL terminated for convenience, but no function in the
  * strbuf API actually relies on the string being free of NULs.
  *
+ * You can avoid the malloc/free overhead of `strbuf_init()`, `strbuf_add()` and
+ * `strbuf_release()` by wrapping pre-allocated memory (stack-allocated for
+ * example) using `strbuf_wrap_preallocated()` or `strbuf_wrap_fixed()`.
+ *
  * strbufs have some invariants that are very important to keep in mind:
  *
  *  - The `buf` member is never NULL, so it can be used in any usual C
  *    string operations safely. strbuf's _have_ to be initialized either by
- *    `strbuf_init()` or by `= STRBUF_INIT` before the invariants, though.
+ *    `strbuf_init()`, `= STRBUF_INIT`, `strbuf_wrap_preallocated()` or
+ *    `strbuf_wrap_fixed()` before the invariants, though.
  *
  *    Do *not* assume anything on what `buf` really is (e.g. if it is
  *    allocated memory or not), use `strbuf_detach()` to unwrap a memory
@@ -62,13 +67,14 @@
  * access to the string itself.
  */
 struct strbuf {
+	unsigned int flags;
 	size_t alloc;
 	size_t len;
 	char *buf;
 };
 
 extern char strbuf_slopbuf[];
-#define STRBUF_INIT  { 0, 0, strbuf_slopbuf }
+#define STRBUF_INIT  { 0, 0, 0, strbuf_slopbuf }
 
 /**
  * Life Cycle Functions
@@ -81,6 +87,25 @@ extern char strbuf_slopbuf[];
  */
 extern void strbuf_init(struct strbuf *, size_t);
 
+/**
+ * Allow the caller to give a pre-allocated piece of memory for the strbuf
+ * to use. It is possible then to strbuf_grow() the string past the size of the
+ * pre-allocated buffer: a new buffer will be allocated. The pre-allocated
+ * buffer will never be freed.
+ */
+void strbuf_wrap_preallocated(struct strbuf *sb, char *path_buf,
+			      size_t path_buf_len, size_t alloc_len);
+
+/**
+ * Allow the caller to give a pre-allocated piece of memory for the strbuf
+ * to use and indicate that the strbuf must use exclusively this buffer,
+ * never realloc() it or allocate a new one. It means that the string can
+ * be manipulated but cannot overflow the pre-allocated buffer. The
+ * pre-allocated buffer will never be freed.
+ */
+void strbuf_wrap_fixed(struct strbuf *sb, char *path_buf,
+		       size_t path_buf_len, size_t alloc_len);
+
 /**
  * Release a string buffer and the memory it used. You should not use the
  * string buffer after using this function, unless you initialize it again.
@@ -91,6 +116,8 @@ extern void strbuf_release(struct strbuf *);
  * Detach the string from the strbuf and returns it; you now own the
  * storage the string occupies and it is your responsibility from then on
  * to release it with `free(3)` when you are done with it.
+ * Must allocate a copy of the buffer in case of a preallocated/fixed buffer.
+ * Performance-critical operations have to be aware of this.
  */
 extern char *strbuf_detach(struct strbuf *, size_t *);
 
diff --git a/t/helper/test-strbuf.c b/t/helper/test-strbuf.c
index 622f627..1aaacb5 100644
--- a/t/helper/test-strbuf.c
+++ b/t/helper/test-strbuf.c
@@ -61,6 +61,48 @@ int main(int argc, char *argv[])
 		 */
 		strbuf_init(&sb, 1000);
 		strbuf_grow(&sb, maximum_unsigned_value_of_type((size_t)1));
+	} else if (!strcmp(argv[1], "preallocated_check_behavior")) {
+		strbuf_wrap_preallocated(&sb, (void *)str_test,
+					 strlen(str_test), sizeof(str_test));
+		return test_usual(&sb);
+	} else if (!strcmp(argv[1], "preallocated_NULL")) {
+		/*
+		 * Violation of invariant "strbuf must not be NULL": should die()
+		 */
+		strbuf_wrap_preallocated(&sb, NULL, 0, sizeof(str_test));
+	} else if (!strcmp(argv[1], "grow_fixed_overflow")) {
+		/*
+		 * Overflowing the buffer of a fixed strbuf: should die()
+		 */
+		strbuf_wrap_fixed(&sb, (void *)str_foo,
+				  strlen(str_foo), sizeof(str_foo));
+		strbuf_grow(&sb, 3);
+		strbuf_grow(&sb, 1000);
+	} else if (!strcmp(argv[1], "grow_fixed_overflow_min")) {
+		/*
+		 * Minimum strbuf_grow() for overflowing a fixed strbuf: should die()
+		 */
+		strbuf_wrap_fixed(&sb, (void *)str_foo,
+				  strlen(str_foo), sizeof(str_foo));
+		strbuf_grow(&sb, 4);
+	} else if (!strcmp(argv[1], "grow_fixed_success")) {
+		strbuf_wrap_fixed(&sb, (void *)str_foo,
+				  strlen(str_foo), sizeof(str_foo));
+		strbuf_grow(&sb, 3);
+	} else if (!strcmp(argv[1], "detach_fixed")) {
+		char *buf;
+		strbuf_wrap_fixed(&sb, (void *)str_test,
+				  strlen(str_test), sizeof(str_test));
+		buf = strbuf_detach(&sb, &size);
+		if (str_test == buf)
+			die("strbuf_detach does not copy the buffer");
+		free(buf);
+	} else if (!strcmp(argv[1], "release_fixed")) {
+		strbuf_wrap_fixed(&sb, (void *)str_test, strlen(str_test),
+				  sizeof(sb) + 1);
+		strbuf_release(&sb);
+		if (sb.buf != strbuf_slopbuf)
+			die("strbuf_release does not reinitialize the strbuf");
 	} else {
 		usage("test-strbuf mode");
 	}
diff --git a/t/t0082-strbuf.sh b/t/t0082-strbuf.sh
index 0800d26..5de909d 100755
--- a/t/t0082-strbuf.sh
+++ b/t/t0082-strbuf.sh
@@ -16,4 +16,32 @@ test_expect_success 'overflow while calling strbuf_grow' '
 	test_must_fail test-strbuf grow_overflow
 '
 
+test_expect_success 'check preallocated strbuf behavior in usual use cases' '
+	test-strbuf preallocated_check_behavior
+'
+
+test_expect_success 'strbuf_wrap_preallocated NULL initialization' '
+	test_must_fail test-strbuf preallocated_NULL
+'
+
+test_expect_success 'strbuf_grow with wrap_fixed overflow' '
+	test_must_fail test-strbuf grow_fixed_overflow
+'
+
+test_expect_success 'strbuf_grow with wrap_fixed minimum overflow' '
+	test_must_fail test-strbuf grow_fixed_overflow_min
+'
+
+test_expect_success 'strbuf_grow with wrap_fixed in a successful case' '
+	test-strbuf grow_fixed_success
+'
+
+test_expect_success 'stbuf_detach with wrap_fixed memory' '
+	test-strbuf detach_fixed
+'
+
+test_expect_success 'stbuf_release with wrap_fixed memory' '
+	test-strbuf release_fixed
+'
+
 test_done
-- 
2.8.2.403.ge2646ba.dirty
