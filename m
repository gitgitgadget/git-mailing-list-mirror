From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] Revert "make error()'s constant return value more
 visible"
Date: Mon, 5 May 2014 01:49:01 -0400
Message-ID: <20140505054901.GA19331@sigill.intra.peff.net>
References: <1399183975-2346-1-git-send-email-felipe.contreras@gmail.com>
 <1399183975-2346-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 18:19:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whht7-0005Yp-Oc
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754535AbaEEFtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 01:49:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:45090 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754412AbaEEFtE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 01:49:04 -0400
Received: (qmail 22262 invoked by uid 102); 5 May 2014 05:49:04 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 05 May 2014 00:49:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 May 2014 01:49:01 -0400
Content-Disposition: inline
In-Reply-To: <1399183975-2346-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248128>

On Sun, May 04, 2014 at 01:12:53AM -0500, Felipe Contreras wrote:

> So it looks like gcc is smarter now, and in trying to fix a few warnings
> we generated hundreds more.
> 
> This reverts commit e208f9cc7574f5980faba498d0aa30b4defeb34f.

And now we've gone the other way, and re-enabled the initial warnings.
Can we come up with a solution that helps both cases?

I could not find a way to annotate a value as "maybe unused", but we can
hide it inside a function, like:

-- >8 --
Subject: inline error() function

The error() function does two things: it prints an error,
and it returns "-1" as a convenience to allow:

  return error("foo");

Commit e208f9c converted this to a macro to make the
constant return value more visible to the compiler. However,
recent versions of gcc complain when error is used in a void
context, as the constant "-1" ends up unused.

Instead, let's convert error() to a static inline, which
should accomplish the same thing without the extra warnings
(because gcc will not warn about unused return values unless
warn_unused_result is specified for the particular
function).

Signed-off-by: Jeff King <peff@peff.net>
---
 git-compat-util.h | 20 ++++++++++++--------
 usage.c           |  8 +-------
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index f6d3a46..3aef0d3 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -310,7 +310,6 @@ extern NORETURN void usage(const char *err);
 extern NORETURN void usagef(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern NORETURN void die_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
-extern int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
 #ifndef NO_OPENSSL
@@ -325,14 +324,19 @@ extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)))
 
 /*
  * Let callers be aware of the constant return value; this can help
- * gcc with -Wuninitialized analysis. We restrict this trick to gcc, though,
- * because some compilers may not support variadic macros. Since we're only
- * trying to help gcc, anyway, it's OK; other compilers will fall back to
- * using the function as usual.
+ * gcc with -Wuninitialized analysis.
  */
-#if defined(__GNUC__) && ! defined(__clang__)
-#define error(...) (error(__VA_ARGS__), -1)
-#endif
+__attribute__((format (printf, 1, 0)))
+extern void error_impl(const char *err, va_list params);
+__attribute__((format (printf, 1, 2)))
+static inline int error(const char *err, ...)
+{
+    va_list params;
+    va_start(params, err);
+    error_impl(err, params);
+    va_end(params);
+    return -1;
+}
 
 extern void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params));
 extern void set_error_routine(void (*routine)(const char *err, va_list params));
diff --git a/usage.c b/usage.c
index ed14645..5456e4b 100644
--- a/usage.c
+++ b/usage.c
@@ -138,15 +138,9 @@ void NORETURN die_errno(const char *fmt, ...)
 	va_end(params);
 }
 
-#undef error
-int error(const char *err, ...)
+void error_impl(const char *err, va_list params)
 {
-	va_list params;
-
-	va_start(params, err);
 	error_routine(err, params);
-	va_end(params);
-	return -1;
 }
 
 void warning(const char *warn, ...)
-- 
2.0.0.rc1.436.g03cb729
