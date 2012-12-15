From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 0/3] compiling git with gcc -O3 -Wuninitialized
Date: Sat, 15 Dec 2012 06:09:30 -0500
Message-ID: <20121215110930.GA23727@sigill.intra.peff.net>
References: <20121214220903.GA18418@sigill.intra.peff.net>
 <50CC55B5.8000205@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Dec 15 12:09:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tjpcr-00064z-Tr
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 12:09:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756295Ab2LOLJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 06:09:32 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55360 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752733Ab2LOLJc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 06:09:32 -0500
Received: (qmail 20562 invoked by uid 107); 15 Dec 2012 11:10:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 15 Dec 2012 06:10:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 15 Dec 2012 06:09:30 -0500
Content-Disposition: inline
In-Reply-To: <50CC55B5.8000205@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211529>

On Sat, Dec 15, 2012 at 11:49:25AM +0100, Johannes Sixt wrote:

> Am 14.12.2012 23:09, schrieb Jeff King:
> > Can anybody think of a clever way to expose the constant return value of
> > error() to the compiler? We could do it with a macro, but that is also
> > out for error(), as we do not assume the compiler has variadic macros. I
> > guess we could hide it behind "#ifdef __GNUC__", since it is after all
> > only there to give gcc's analyzer more information. But I'm not sure
> > there is a way to make a macro that is syntactically identical. I.e.,
> > you cannot just replace "error(...)" in "return error(...);" with a
> > function call plus a value for the return statement. You'd need
> > something more like:
> > 
> >   #define RETURN_ERROR(fmt, ...) \
> >   do { \
> >     error(fmt, __VA_ARGS__); \
> >     return -1; \
> >   } while(0) \
> > 
> > which is awfully ugly.
> 
> Does
> 
>   #define error(fmt, ...) (error_impl(fmt, __VA_ARGS__), -1)
> 
> cause problems when not used in a return statement?

Thanks, that was the cleverness I was missing. The only problem is that
in standard C, doing this:

  error("no other arguments");

generates:

  (error_impl(fmt, ), 1);

which is bogus. This is a common problem with variadic macros, and
fortunately gcc has a solution (and since we are already inside a
gcc-only #ifdef, we should be OK).

So doing this works for me:

diff --git a/git-compat-util.h b/git-compat-util.h
index 2e79b8a..a036323 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -285,9 +285,18 @@ extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)))
 extern NORETURN void usagef(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern NORETURN void die_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
-extern int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
+#ifdef __GNUC__
+#define ERROR_FUNC_NAME error_impl
+#define error(fmt, ...) (error_impl((fmt), ##__VA_ARGS__), -1)
+#else
+#define ERROR_FUNC_NAME error
+#endif
+
+extern int ERROR_FUNC_NAME(const char *err, ...)
+__attribute__((format (printf, 1, 2)));
+
 extern void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params));
 extern void set_error_routine(void (*routine)(const char *err, va_list params));
 
diff --git a/usage.c b/usage.c
index 8eab281..d1a58fa 100644
--- a/usage.c
+++ b/usage.c
@@ -130,7 +130,7 @@ void NORETURN die_errno(const char *fmt, ...)
 	va_end(params);
 }
 
-int error(const char *err, ...)
+int ERROR_FUNC_NAME(const char *err, ...)
 {
 	va_list params;
 

I think we could even get rid of the ERROR_FUNC_NAME ugliness by just
calling it "error", and doing an "#undef error" right before we define
it in usage.c.

-Peff
