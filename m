From: Jeff King <peff@peff.net>
Subject: [PATCH 1/9] grep: make locking flag global
Date: Thu, 2 Feb 2012 03:18:29 -0500
Message-ID: <20120202081829.GA6786@sigill.intra.peff.net>
References: <20120202081747.GA10271@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Conrad Irwin <conrad.irwin@gmail.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 09:18:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsrsL-0008IE-TU
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 09:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754443Ab2BBISd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 03:18:33 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52843
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754063Ab2BBISd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 03:18:33 -0500
Received: (qmail 17760 invoked by uid 107); 2 Feb 2012 08:25:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 Feb 2012 03:25:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Feb 2012 03:18:29 -0500
Content-Disposition: inline
In-Reply-To: <20120202081747.GA10271@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189593>

The low-level grep code traditionally didn't care about
threading, as it doesn't do any threading itself and didn't
call out to other non-thread-safe code.  That changed with
0579f91 (grep: enable threading with -p and -W using lazy
attribute lookup, 2011-12-12), which pushed the lookup of
funcname attributes (which is not thread-safe) into the
low-level grep code.

As a result, the low-level code learned about a new global
"grep_attr_mutex" to serialize access to the attribute code.
A multi-threaded caller (e.g., builtin/grep.c) is expected
to initialize the mutex and set "use_threads" in the
grep_opt structure. The low-level code only uses the lock if
use_threads is set.

However, putting the use_threads flag into the grep_opt
struct is not the most logical place. Whether threading is
in use is not something that matters for each call to
grep_buffer, but is instead global to the whole program
(i.e., if any thread is doing multi-threaded grep, every
other thread, even if it thinks it is doing its own
single-threaded grep, would need to use the locking).  In
practice, this distinction isn't a problem for us, because
the only user of multi-threaded grep is "git-grep", which
does nothing except call grep.

This patch turns the opt->use_threads flag into a global
flag. More important than the nit-picking semantic argument
above is that this means that the locking functions don't
need to actually have access to a grep_opt to know whether
to lock. Which in turn can make adding new locks simpler, as
we don't need to pass around a grep_opt.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/grep.c |    4 ++--
 grep.c         |   18 ++++++++++--------
 grep.h         |    2 +-
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 5c2ae94..06983f9 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -259,6 +259,7 @@ static void start_threads(struct grep_opt *opt)
 	pthread_cond_init(&cond_add, NULL);
 	pthread_cond_init(&cond_write, NULL);
 	pthread_cond_init(&cond_result, NULL);
+	grep_use_locks = 1;
 
 	for (i = 0; i < ARRAY_SIZE(todo); i++) {
 		strbuf_init(&todo[i].out, 0);
@@ -307,6 +308,7 @@ static int wait_all(void)
 	pthread_cond_destroy(&cond_add);
 	pthread_cond_destroy(&cond_write);
 	pthread_cond_destroy(&cond_result);
+	grep_use_locks = 0;
 
 	return hit;
 }
@@ -1030,8 +1032,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	use_threads = 0;
 #endif
 
-	opt.use_threads = use_threads;
-
 #ifndef NO_PTHREADS
 	if (use_threads) {
 		if (!(opt.name_only || opt.unmatch_name_only || opt.count)
diff --git a/grep.c b/grep.c
index 486230b..7a67c2f 100644
--- a/grep.c
+++ b/grep.c
@@ -807,26 +807,28 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 }
 
 #ifndef NO_PTHREADS
+int grep_use_locks;
+
 /*
  * This lock protects access to the gitattributes machinery, which is
  * not thread-safe.
  */
 pthread_mutex_t grep_attr_mutex;
 
-static inline void grep_attr_lock(struct grep_opt *opt)
+static inline void grep_attr_lock(void)
 {
-	if (opt->use_threads)
+	if (grep_use_locks)
 		pthread_mutex_lock(&grep_attr_mutex);
 }
 
-static inline void grep_attr_unlock(struct grep_opt *opt)
+static inline void grep_attr_unlock(void)
 {
-	if (opt->use_threads)
+	if (grep_use_locks)
 		pthread_mutex_unlock(&grep_attr_mutex);
 }
 #else
-#define grep_attr_lock(opt)
-#define grep_attr_unlock(opt)
+#define grep_attr_lock()
+#define grep_attr_unlock()
 #endif
 
 static int match_funcname(struct grep_opt *opt, const char *name, char *bol, char *eol)
@@ -834,9 +836,9 @@ static int match_funcname(struct grep_opt *opt, const char *name, char *bol, cha
 	xdemitconf_t *xecfg = opt->priv;
 	if (xecfg && !xecfg->find_func) {
 		struct userdiff_driver *drv;
-		grep_attr_lock(opt);
+		grep_attr_lock();
 		drv = userdiff_find_by_path(name);
-		grep_attr_unlock(opt);
+		grep_attr_unlock();
 		if (drv && drv->funcname.pattern) {
 			const struct userdiff_funcname *pe = &drv->funcname;
 			xdiff_set_find_func(xecfg, pe->pattern, pe->cflags);
diff --git a/grep.h b/grep.h
index fb205f3..3653bb3 100644
--- a/grep.h
+++ b/grep.h
@@ -116,7 +116,6 @@ struct grep_opt {
 	int show_hunk_mark;
 	int file_break;
 	int heading;
-	int use_threads;
 	void *priv;
 
 	void (*output)(struct grep_opt *opt, const void *data, size_t size);
@@ -138,6 +137,7 @@ extern int grep_threads_ok(const struct grep_opt *opt);
  * Mutex used around access to the attributes machinery if
  * opt->use_threads.  Must be initialized/destroyed by callers!
  */
+extern int grep_use_locks;
 extern pthread_mutex_t grep_attr_mutex;
 #endif
 
-- 
1.7.9.3.gc3fce1.dirty
