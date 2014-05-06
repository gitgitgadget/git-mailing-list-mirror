From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] inline constant return from error() function
Date: Tue, 6 May 2014 11:14:42 -0400
Message-ID: <20140506151441.GA25768@sigill.intra.peff.net>
References: <20140505212938.GA16715@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 20:18:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiVD-0008Jm-UE
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755952AbaEFPOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 11:14:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:46000 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752511AbaEFPOn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 11:14:43 -0400
Received: (qmail 25507 invoked by uid 102); 6 May 2014 15:14:43 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 May 2014 10:14:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 May 2014 11:14:42 -0400
Content-Disposition: inline
In-Reply-To: <20140505212938.GA16715@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248204>

Commit e208f9c introduced a macro to turn error() calls
into:

  (error(), -1)

to make the constant return value more visible to the
calling code (and thus let the compiler make better
decisions about the code).

This works well for code like:

  return error(...);

but the "-1" is superfluous in code that just calls error()
without caring about the return value. In older versions of
gcc, that was fine, but gcc 4.9 complains with -Wunused-value.

We can work around this by encapsulating the constant return
value in a static inline function, as gcc specifically
avoids complaining about unused function returns unless the
function has been specifically marked with the
warn_unused_result attribute.

We also use the same trick for config_error_nonbool and
opterror, which learned the same error technique in a469a10.

Reported-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
On Mon, May 05, 2014 at 05:29:38PM -0400, Jeff King wrote:

> I cannot think of any other way to make the compiler aware of the
> constant value, but perhaps somebody else is more clever than I am.

This came to me in a dream, and seems to work.

 cache.h           | 2 +-
 git-compat-util.h | 6 +++++-
 parse-options.h   | 2 +-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 107ac61..e2f12b0 100644
--- a/cache.h
+++ b/cache.h
@@ -1272,7 +1272,7 @@ extern int git_env_bool(const char *, int);
 extern int git_config_system(void);
 extern int config_error_nonbool(const char *);
 #if defined(__GNUC__) && ! defined(__clang__)
-#define config_error_nonbool(s) (config_error_nonbool(s), -1)
+#define config_error_nonbool(s) (config_error_nonbool(s), const_error())
 #endif
 extern const char *get_log_output_encoding(void);
 extern const char *get_commit_output_encoding(void);
diff --git a/git-compat-util.h b/git-compat-util.h
index f6d3a46..b4c437e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -331,7 +331,11 @@ extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)))
  * using the function as usual.
  */
 #if defined(__GNUC__) && ! defined(__clang__)
-#define error(...) (error(__VA_ARGS__), -1)
+static inline int const_error(void)
+{
+	return -1;
+}
+#define error(...) (error(__VA_ARGS__), const_error())
 #endif
 
 extern void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params));
diff --git a/parse-options.h b/parse-options.h
index 3189676..2f9be96 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -177,7 +177,7 @@ extern NORETURN void usage_msg_opt(const char *msg,
 extern int optbug(const struct option *opt, const char *reason);
 extern int opterror(const struct option *opt, const char *reason, int flags);
 #if defined(__GNUC__) && ! defined(__clang__)
-#define opterror(o,r,f) (opterror((o),(r),(f)), -1)
+#define opterror(o,r,f) (opterror((o),(r),(f)), const_error())
 #endif
 
 /*----- incremental advanced APIs -----*/
-- 
2.0.0.rc1.436.g03cb729
