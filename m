From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] silence some -Wuninitialized false positives
Date: Sat, 15 Dec 2012 12:42:10 -0500
Message-ID: <20121215174210.GB22069@sigill.intra.peff.net>
References: <20121215173621.GA21011@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Dec 15 18:42:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tjvkt-0006VZ-2O
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 18:42:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451Ab2LORmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 12:42:13 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55530 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795Ab2LORmM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 12:42:12 -0500
Received: (qmail 22499 invoked by uid 107); 15 Dec 2012 17:43:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 15 Dec 2012 12:43:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 15 Dec 2012 12:42:10 -0500
Content-Disposition: inline
In-Reply-To: <20121215173621.GA21011@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211538>

There are a few error functions that simply wrap error() and
provide a standardized message text. Like error(), they
always return -1; knowing that can help the compiler silence
some false positive -Wuninitialized warnings.

One strategy would be to just declare these as inline in the
header file so that the compiler can see that they always
return -1. However, gcc does not always inline them (e.g.,
it will not inline opterror, even with -O3), which renders
our change pointless.

Instead, let's follow the same route we did with error() in
the last patch, and define a macro that makes the constant
return value obvious to the compiler.

Signed-off-by: Jeff King <peff@peff.net>
---
Another option would be to force inlining with
__attribute(always_inline)__.  But I don't like that, as we are
affecting the generated code in that case (and any time we are
overriding gcc's decision, I have to assume that it is smarter about
when to inline than we are).

Other variants include:

  1. Inline functions, but keep them as one-liners. E.g.:

     int opterror(...)
     {
            real_opterror(...);
            return -1;
     }

  2. Using these macros even when __GNUC__ isn't set. Unlike the
     variadic error() macro, these do not use any special features.
     If we used them everywhere, the functions themselves could be
     converted to a void return. That would make it less likely that
     somebody modifying the function in the future would fail to realize
     that the error return must always be -1.

I dunno. All the solutions are a bit ugly. I really do like being -Wall
clean, but I wonder if this is spending too much effort to work around
the compiler (we could also just mark these few cases as "int foo =
foo" to say we have manually verified that they're OK).

 cache.h         |  3 +++
 config.c        |  1 +
 parse-options.c | 18 +++++++++---------
 parse-options.h |  4 ++++
 4 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/cache.h b/cache.h
index 18fdd18..0e8e5d8 100644
--- a/cache.h
+++ b/cache.h
@@ -1136,6 +1136,9 @@ extern int config_error_nonbool(const char *);
 extern int git_env_bool(const char *, int);
 extern int git_config_system(void);
 extern int config_error_nonbool(const char *);
+#ifdef __GNUC__
+#define config_error_nonbool(s) (config_error_nonbool(s), -1)
+#endif
 extern const char *get_log_output_encoding(void);
 extern const char *get_commit_output_encoding(void);
 
diff --git a/config.c b/config.c
index fb3f868..526f682 100644
--- a/config.c
+++ b/config.c
@@ -1660,6 +1660,7 @@ int git_config_rename_section(const char *old_name, const char *new_name)
  * Call this to report error for your variable that should not
  * get a boolean value (i.e. "[my] var" means "true").
  */
+#undef config_error_nonbool
 int config_error_nonbool(const char *var)
 {
 	return error("Missing value for '%s'", var);
diff --git a/parse-options.c b/parse-options.c
index c1c66bd..67e98a6 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -18,15 +18,6 @@ int optbug(const struct option *opt, const char *reason)
 	return error("BUG: switch '%c' %s", opt->short_name, reason);
 }
 
-int opterror(const struct option *opt, const char *reason, int flags)
-{
-	if (flags & OPT_SHORT)
-		return error("switch `%c' %s", opt->short_name, reason);
-	if (flags & OPT_UNSET)
-		return error("option `no-%s' %s", opt->long_name, reason);
-	return error("option `%s' %s", opt->long_name, reason);
-}
-
 static int get_arg(struct parse_opt_ctx_t *p, const struct option *opt,
 		   int flags, const char **arg)
 {
@@ -594,3 +585,12 @@ static int parse_options_usage(struct parse_opt_ctx_t *ctx,
 	return usage_with_options_internal(ctx, usagestr, opts, 0, err);
 }
 
+#undef opterror
+int opterror(const struct option *opt, const char *reason, int flags)
+{
+	if (flags & OPT_SHORT)
+		return error("switch `%c' %s", opt->short_name, reason);
+	if (flags & OPT_UNSET)
+		return error("option `no-%s' %s", opt->long_name, reason);
+	return error("option `%s' %s", opt->long_name, reason);
+}
diff --git a/parse-options.h b/parse-options.h
index 71a39c6..e703853 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -177,6 +177,10 @@ extern int opterror(const struct option *opt, const char *reason, int flags);
 
 extern int optbug(const struct option *opt, const char *reason);
 extern int opterror(const struct option *opt, const char *reason, int flags);
+#ifdef __GNUC__
+#define opterror(o,r,f) (opterror((o),(r),(f)), -1)
+#endif
+
 /*----- incremental advanced APIs -----*/
 
 enum {
-- 
1.8.0.2.4.g59402aa
