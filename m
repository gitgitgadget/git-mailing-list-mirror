From: Jeff King <peff@peff.net>
Subject: [PATCH/RFC 2/3] inline error functions with constant returns
Date: Fri, 14 Dec 2012 17:12:35 -0500
Message-ID: <20121214221235.GB19677@sigill.intra.peff.net>
References: <20121214220903.GA18418@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 23:12:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjdV0-0006uf-Nx
	for gcvg-git-2@plane.gmane.org; Fri, 14 Dec 2012 23:12:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756165Ab2LNWMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2012 17:12:38 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55056 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755876Ab2LNWMh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2012 17:12:37 -0500
Received: (qmail 16214 invoked by uid 107); 14 Dec 2012 22:13:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 14 Dec 2012 17:13:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Dec 2012 17:12:35 -0500
Content-Disposition: inline
In-Reply-To: <20121214220903.GA18418@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211507>

The error() function reports an error message to stderr and
returns -1. That makes it handy for returning errors from
functions with a single-line:

  return error("something went wrong", ...);

In this case, we know something that the compiler does not,
namely that this is equivalent to:

  error("something went wrong", ...);
  return -1;

Knowing that the return value is constant can let the
compiler do better control flow analysis, which means it can
give more accurate answers for static warnings, like
-Wuninitialized. But because error() is found in a different
compilation unit, the compiler doesn't get to see the code
when making decisions about the caller.

This patch makes error(), along with a handful of functions
which wrap it, an inline function, giving the compiler the
extra information. This prevents some false positives when
-Wunitialized is used with -O3.

Signed-off-by: Jeff King <peff@peff.net>
---
Not really meant for inclusion.  The opterror() bit does silence one
warning, but I think the error() inlining is doing absolutely nothing.

 cache.h           | 10 +++++++++-
 config.c          |  9 ---------
 git-compat-util.h | 13 ++++++++++++-
 parse-options.c   | 11 ++++++-----
 parse-options.h   |  8 +++++++-
 usage.c           | 12 +-----------
 6 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/cache.h b/cache.h
index 18fdd18..fb7c5e2 100644
--- a/cache.h
+++ b/cache.h
@@ -1135,10 +1135,18 @@ extern const char *get_commit_output_encoding(void);
 extern int check_repository_format_version(const char *var, const char *value, void *cb);
 extern int git_env_bool(const char *, int);
 extern int git_config_system(void);
-extern int config_error_nonbool(const char *);
 extern const char *get_log_output_encoding(void);
 extern const char *get_commit_output_encoding(void);
 
+/*
+ * Call this to report error for your variable that should not
+ * get a boolean value (i.e. "[my] var" means "true").
+ */
+static inline int config_error_nonbool(const char *var)
+{
+	return error("Missing value for '%s'", var);
+}
+
 extern int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
 
 struct config_include_data {
diff --git a/config.c b/config.c
index fb3f868..ea4a98f 100644
--- a/config.c
+++ b/config.c
@@ -1655,12 +1655,3 @@ int git_config_rename_section(const char *old_name, const char *new_name)
 {
 	return git_config_rename_section_in_file(NULL, old_name, new_name);
 }
-
-/*
- * Call this to report error for your variable that should not
- * get a boolean value (i.e. "[my] var" means "true").
- */
-int config_error_nonbool(const char *var)
-{
-	return error("Missing value for '%s'", var);
-}
diff --git a/git-compat-util.h b/git-compat-util.h
index 2e79b8a..c38de42 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -285,9 +285,20 @@ extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)))
 extern NORETURN void usagef(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern NORETURN void die_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
-extern int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
+extern void (*error_routine)(const char *err, va_list params);
+
+__attribute__((format (printf, 1, 2)))
+static inline int error(const char *err, ...)
+{
+	va_list params;
+	va_start(params, err);
+	error_routine(err, params);
+	va_end(params);
+	return -1;
+}
+
 extern void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params));
 extern void set_error_routine(void (*routine)(const char *err, va_list params));
 
diff --git a/parse-options.c b/parse-options.c
index c1c66bd..5268d4e 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -18,13 +18,14 @@ int opterror(const struct option *opt, const char *reason, int flags)
 	return error("BUG: switch '%c' %s", opt->short_name, reason);
 }
 
-int opterror(const struct option *opt, const char *reason, int flags)
+void opterror_report(const struct option *opt, const char *reason, int flags)
 {
 	if (flags & OPT_SHORT)
-		return error("switch `%c' %s", opt->short_name, reason);
-	if (flags & OPT_UNSET)
-		return error("option `no-%s' %s", opt->long_name, reason);
-	return error("option `%s' %s", opt->long_name, reason);
+		error("switch `%c' %s", opt->short_name, reason);
+	else if (flags & OPT_UNSET)
+		error("option `no-%s' %s", opt->long_name, reason);
+	else
+		error("option `%s' %s", opt->long_name, reason);
 }
 
 static int get_arg(struct parse_opt_ctx_t *p, const struct option *opt,
diff --git a/parse-options.h b/parse-options.h
index 71a39c6..23673c7 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -176,7 +176,13 @@ extern int optbug(const struct option *opt, const char *reason);
 				   const struct option *options);
 
 extern int optbug(const struct option *opt, const char *reason);
-extern int opterror(const struct option *opt, const char *reason, int flags);
+extern void opterror_report(const struct option *opt, const char *reason, int flags);
+static inline int opterror(const struct option *opt, const char *reason, int flags)
+{
+	opterror_report(opt, reason, flags);
+	return -1;
+}
+
 /*----- incremental advanced APIs -----*/
 
 enum {
diff --git a/usage.c b/usage.c
index 8eab281..9f8e342 100644
--- a/usage.c
+++ b/usage.c
@@ -53,7 +53,7 @@ static NORETURN_PTR void (*die_routine)(const char *err, va_list params) = die_b
  * (ugh), so keep things static. */
 static NORETURN_PTR void (*usage_routine)(const char *err, va_list params) = usage_builtin;
 static NORETURN_PTR void (*die_routine)(const char *err, va_list params) = die_builtin;
-static void (*error_routine)(const char *err, va_list params) = error_builtin;
+void (*error_routine)(const char *err, va_list params) = error_builtin;
 static void (*warn_routine)(const char *err, va_list params) = warn_builtin;
 
 void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params))
@@ -130,16 +130,6 @@ void NORETURN die_errno(const char *fmt, ...)
 	va_end(params);
 }
 
-int error(const char *err, ...)
-{
-	va_list params;
-
-	va_start(params, err);
-	error_routine(err, params);
-	va_end(params);
-	return -1;
-}
-
 void warning(const char *warn, ...)
 {
 	va_list params;
-- 
1.8.0.2.4.g59402aa
