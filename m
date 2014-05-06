From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] let clang use the constant-return error() macro
Date: Tue, 6 May 2014 11:17:50 -0400
Message-ID: <20140506151750.GB25768@sigill.intra.peff.net>
References: <20140505212938.GA16715@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Max Horn <max@quendi.de>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 20:02:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiVK-0008Jm-4F
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757574AbaEFPRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 11:17:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:46007 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754234AbaEFPRw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 11:17:52 -0400
Received: (qmail 25675 invoked by uid 102); 6 May 2014 15:17:51 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 May 2014 10:17:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 May 2014 11:17:50 -0400
Content-Disposition: inline
In-Reply-To: <20140505212938.GA16715@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248199>

Commit e208f9c converted error() into a macro to make its
constant return value more apparent to calling code.  Commit
5ded807 prevents us using this macro with clang, since
clang's -Wunused-value is smart enough to realize that the
constant "-1" is useless in some contexts.

However, since the last commit puts the constant behind an
inline function call, this is enough to prevent the
-Wunused-value warning on both modern gcc and clang. So we
can now re-enable the macro when compiling with clang.

Tested with clang 3.3, 3.4, and 3.5.

Signed-off-by: Jeff King <peff@peff.net>
---
I still get warnings when compiling with clang -O3, due to
-Warray-bounds. It looks like a bug, though. Clang complains that:

  strcmp(argv[1], "git")

oversteps array bounds when the strcmp is expanded into a mess of
builtin magic. So I don't think we are doing anything wrong here.

 cache.h           | 2 +-
 git-compat-util.h | 2 +-
 parse-options.h   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index e2f12b0..35a3e6b 100644
--- a/cache.h
+++ b/cache.h
@@ -1271,7 +1271,7 @@ extern int check_repository_format_version(const char *var, const char *value, v
 extern int git_env_bool(const char *, int);
 extern int git_config_system(void);
 extern int config_error_nonbool(const char *);
-#if defined(__GNUC__) && ! defined(__clang__)
+#if defined(__GNUC__)
 #define config_error_nonbool(s) (config_error_nonbool(s), const_error())
 #endif
 extern const char *get_log_output_encoding(void);
diff --git a/git-compat-util.h b/git-compat-util.h
index b4c437e..70dc028 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -330,7 +330,7 @@ extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)))
  * trying to help gcc, anyway, it's OK; other compilers will fall back to
  * using the function as usual.
  */
-#if defined(__GNUC__) && ! defined(__clang__)
+#if defined(__GNUC__)
 static inline int const_error(void)
 {
 	return -1;
diff --git a/parse-options.h b/parse-options.h
index 2f9be96..7940bc7 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -176,7 +176,7 @@ extern NORETURN void usage_msg_opt(const char *msg,
 
 extern int optbug(const struct option *opt, const char *reason);
 extern int opterror(const struct option *opt, const char *reason, int flags);
-#if defined(__GNUC__) && ! defined(__clang__)
+#if defined(__GNUC__)
 #define opterror(o,r,f) (opterror((o),(r),(f)), const_error())
 #endif
 
-- 
2.0.0.rc1.436.g03cb729
