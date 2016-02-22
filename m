From: Jeff King <peff@peff.net>
Subject: [PATCH v3 05/22] add helpers for allocating flex-array structs
Date: Mon, 22 Feb 2016 17:43:25 -0500
Message-ID: <20160222224324.GE10075@sigill.intra.peff.net>
References: <20160222224059.GA3857@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 23:43:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXzCY-0004G5-4O
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 23:43:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756039AbcBVWn3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 17:43:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:47056 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755877AbcBVWn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 17:43:27 -0500
Received: (qmail 21594 invoked by uid 102); 22 Feb 2016 22:43:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 17:43:27 -0500
Received: (qmail 22946 invoked by uid 107); 22 Feb 2016 22:43:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 17:43:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Feb 2016 17:43:25 -0500
Content-Disposition: inline
In-Reply-To: <20160222224059.GA3857@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286973>

Allocating a struct with a flex array is pretty simple in
practice: you over-allocate the struct, then copy some data
into the over-allocation. But it can be a slight pain to
make sure you're allocating and copying the right amounts.

This patch adds a few helpers to turn simple cases of
flex-array struct allocation into a one-liner that properly
checks for overflow. See the embedded documentation for
details.

Ideally we could provide a more flexible version that could
handle multiple strings, like:

  FLEX_ALLOC_FMT(ref, name, "%s%s", prefix, name);

But we have to implement this as a macro (because of the
offset calculation of the flex member), which means we would
need all compilers to support variadic macros.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-compat-util.h | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 81f2347..57ff9fb 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -782,6 +782,68 @@ extern FILE *fopen_for_writing(const char *path);
 #define ALLOC_ARRAY(x, alloc) (x) = xmalloc(st_mult(sizeof(*(x)), (alloc)))
 #define REALLOC_ARRAY(x, alloc) (x) = xrealloc((x), st_mult(sizeof(*(x)), (alloc)))
 
+/*
+ * These functions help you allocate structs with flex arrays, and copy
+ * the data directly into the array. For example, if you had:
+ *
+ *   struct foo {
+ *     int bar;
+ *     char name[FLEX_ARRAY];
+ *   };
+ *
+ * you can do:
+ *
+ *   struct foo *f;
+ *   FLEX_ALLOC_MEM(f, name, src, len);
+ *
+ * to allocate a "foo" with the contents of "src" in the "name" field.
+ * The resulting struct is automatically zero'd, and the flex-array field
+ * is NUL-terminated (whether the incoming src buffer was or not).
+ *
+ * The FLEXPTR_* variants operate on structs that don't use flex-arrays,
+ * but do want to store a pointer to some extra data in the same allocated
+ * block. For example, if you have:
+ *
+ *   struct foo {
+ *     char *name;
+ *     int bar;
+ *   };
+ *
+ * you can do:
+ *
+ *   struct foo *f;
+ *   FLEX_ALLOC_STR(f, name, src);
+ *
+ * and "name" will point to a block of memory after the struct, which will be
+ * freed along with the struct (but the pointer can be repointed anywhere).
+ *
+ * The *_STR variants accept a string parameter rather than a ptr/len
+ * combination.
+ *
+ * Note that these macros will evaluate the first parameter multiple
+ * times, and it must be assignable as an lvalue.
+ */
+#define FLEX_ALLOC_MEM(x, flexname, buf, len) do { \
+	(x) = NULL; /* silence -Wuninitialized for offset calculation */ \
+	(x) = xalloc_flex(sizeof(*(x)), (char *)(&((x)->flexname)) - (char *)(x), (buf), (len)); \
+} while (0)
+#define FLEXPTR_ALLOC_MEM(x, ptrname, buf, len) do { \
+	(x) = xalloc_flex(sizeof(*(x)), sizeof(*(x)), (buf), (len)); \
+	(x)->ptrname = (void *)((x)+1); \
+} while(0)
+#define FLEX_ALLOC_STR(x, flexname, str) \
+	FLEX_ALLOC_MEM((x), flexname, (str), strlen(str))
+#define FLEXPTR_ALLOC_STR(x, ptrname, str) \
+	FLEXPTR_ALLOC_MEM((x), ptrname, (str), strlen(str))
+
+static inline void *xalloc_flex(size_t base_len, size_t offset,
+				const void *src, size_t src_len)
+{
+	unsigned char *ret = xcalloc(1, st_add3(base_len, src_len, 1));
+	memcpy(ret + offset, src, src_len);
+	return ret;
+}
+
 static inline char *xstrdup_or_null(const char *str)
 {
 	return str ? xstrdup(str) : NULL;
-- 
2.7.2.645.g4e1306c
