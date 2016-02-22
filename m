From: Jeff King <peff@peff.net>
Subject: [PATCH v3 02/22] add helpers for detecting size_t overflow
Date: Mon, 22 Feb 2016 17:43:11 -0500
Message-ID: <20160222224310.GB10075@sigill.intra.peff.net>
References: <20160222224059.GA3857@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 23:43:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXzCH-0003zo-4g
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 23:43:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755928AbcBVWnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 17:43:14 -0500
Received: from cloud.peff.net ([50.56.180.127]:47042 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755726AbcBVWnN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 17:43:13 -0500
Received: (qmail 21515 invoked by uid 102); 22 Feb 2016 22:43:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 17:43:13 -0500
Received: (qmail 22905 invoked by uid 107); 22 Feb 2016 22:43:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 17:43:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Feb 2016 17:43:11 -0500
Content-Disposition: inline
In-Reply-To: <20160222224059.GA3857@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286972>

Performing computations on size_t variables that we feed to
xmalloc and friends can be dangerous, as an integer overflow
can cause us to allocate a much smaller chunk than we
realized.

We already have unsigned_add_overflows(), but let's add
unsigned_mult_overflows() to that. Furthermore, rather than
have each site manually check and die on overflow, we can
provide some helpers that will:

  - promote the arguments to size_t, so that we know we are
    doing our computation in the same size of integer that
    will ultimately be fed to xmalloc

  - check and die on overflow

  - return the result so that computations can be done in
    the parameter list of xmalloc.

These functions are a lot uglier to use than normal
arithmetic operators (you have to do "st_add(foo, bar)"
instead of "foo + bar"). To at least limit the damage, we
also provide multi-valued versions. So rather than:

  st_add(st_add(a, b), st_add(c, d));

you can write:

  st_add4(a, b, c, d);

This isn't nearly as elegant as a varargs function, but it's
a lot harder to get it wrong. You don't have to remember to
add a sentinel value at the end, and the compiler will
complain if you get the number of arguments wrong. This
patch adds only the numbered variants required to convert
the current code base; we can easily add more later if
needed.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-compat-util.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 693a336..0c65033 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -96,6 +96,14 @@
 #define unsigned_add_overflows(a, b) \
     ((b) > maximum_unsigned_value_of_type(a) - (a))
 
+/*
+ * Returns true if the multiplication of "a" and "b" will
+ * overflow. The types of "a" and "b" must match and must be unsigned.
+ * Note that this macro evaluates "a" twice!
+ */
+#define unsigned_mult_overflows(a, b) \
+    ((a) && (b) > maximum_unsigned_value_of_type(a) / (a))
+
 #ifdef __GNUC__
 #define TYPEOF(x) (__typeof__(x))
 #else
@@ -713,6 +721,32 @@ extern void release_pack_memory(size_t);
 typedef void (*try_to_free_t)(size_t);
 extern try_to_free_t set_try_to_free_routine(try_to_free_t);
 
+static inline size_t st_add(size_t a, size_t b)
+{
+	if (unsigned_add_overflows(a, b))
+		die("size_t overflow: %"PRIuMAX" + %"PRIuMAX,
+		    (uintmax_t)a, (uintmax_t)b);
+	return a + b;
+}
+#define st_add3(a,b,c)   st_add((a),st_add((b),(c)))
+#define st_add4(a,b,c,d) st_add((a),st_add3((b),(c),(d)))
+
+static inline size_t st_mult(size_t a, size_t b)
+{
+	if (unsigned_mult_overflows(a, b))
+		die("size_t overflow: %"PRIuMAX" * %"PRIuMAX,
+		    (uintmax_t)a, (uintmax_t)b);
+	return a * b;
+}
+
+static inline size_t st_sub(size_t a, size_t b)
+{
+	if (a < b)
+		die("size_t underflow: %"PRIuMAX" - %"PRIuMAX,
+		    (uintmax_t)a, (uintmax_t)b);
+	return a - b;
+}
+
 #ifdef HAVE_ALLOCA_H
 # include <alloca.h>
 # define xalloca(size)      (alloca(size))
-- 
2.7.2.645.g4e1306c
