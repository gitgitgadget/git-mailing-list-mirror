From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] make error()'s constant return value more visible
Date: Sat, 15 Dec 2012 12:37:36 -0500
Message-ID: <20121215173736.GA22069@sigill.intra.peff.net>
References: <20121215173621.GA21011@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Dec 15 18:37:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjvgS-0002s7-3X
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 18:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995Ab2LORhj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 12:37:39 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55525 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751057Ab2LORhi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 12:37:38 -0500
Received: (qmail 22451 invoked by uid 107); 15 Dec 2012 17:38:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 15 Dec 2012 12:38:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 15 Dec 2012 12:37:36 -0500
Content-Disposition: inline
In-Reply-To: <20121215173621.GA21011@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211537>

When git is compiled with "gcc -Wuninitialized -O3", some
inlined calls provide an additional opportunity for the
compiler to do static analysis on variable initialization.
For example, with two functions like this:

  int get_foo(int *foo)
  {
	if (something_that_might_fail() < 0)
		return error("unable to get foo");
	*foo = 0;
	return 0;
  }

  void some_fun(void)
  {
	  int foo;
	  if (get_foo(&foo) < 0)
		  return -1;
	  printf("foo is %d\n", foo);
  }

If get_foo() is not inlined, then when compiling some_fun,
gcc sees only that a pointer to the local variable is
passed, and must assume that it is an out parameter that
is initialized after get_foo returns.

However, when get_foo() is inlined, the compiler may look at
all of the code together and see that some code paths in
get_foo() do not initialize the variable. As a result, it
prints a warning. But what the compiler can't see is that
error() always returns -1, and therefore we know that either
we return early from some_fun, or foo ends up initialized,
and the code is safe.  The warning is a false positive.

If we can make the compiler aware that error() will always
return -1, it can do a better job of analysis. The simplest
method would be to inline the error() function. However,
this doesn't work, because gcc will not inline a variadc
function. We can work around this by defining a macro. This
relies on two gcc extensions:

  1. Variadic macros (these are present in C99, but we do
     not rely on that).

  2. Gcc treats the "##" paste operator specially between a
     comma and __VA_ARGS__, which lets our variadic macro
     work even if no format parameters are passed to
     error().

Since we are using these extra features, we hide the macro
behind an #ifdef. This is OK, though, because our goal was
just to help gcc.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-compat-util.h | 11 +++++++++++
 usage.c           |  1 +
 2 files changed, 12 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 2e79b8a..9002bca 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -288,6 +288,17 @@ extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)))
 extern int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
+/*
+ * Let callers be aware of the constant return value; this can help
+ * gcc with -Wuninitialized analysis. We have to restrict this trick to
+ * gcc, though, because of the variadic macro and the magic ## comma pasting
+ * behavior. But since we're only trying to help gcc, anyway, it's OK; other
+ * compilers will fall back to using the function as usual.
+ */
+#ifdef __GNUC__
+#define error(fmt, ...) (error((fmt), ##__VA_ARGS__), -1)
+#endif
+
 extern void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params));
 extern void set_error_routine(void (*routine)(const char *err, va_list params));
 
diff --git a/usage.c b/usage.c
index 8eab281..40b3de5 100644
--- a/usage.c
+++ b/usage.c
@@ -130,6 +130,7 @@ void NORETURN die_errno(const char *fmt, ...)
 	va_end(params);
 }
 
+#undef error
 int error(const char *err, ...)
 {
 	va_list params;
-- 
1.8.0.2.4.g59402aa
