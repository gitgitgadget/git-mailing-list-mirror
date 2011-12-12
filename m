From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3 2/3] grep: enable threading with -p and -W using lazy attribute lookup
Date: Mon, 12 Dec 2011 22:16:07 +0100
Message-ID: <138b930c0c96029f2fb9a816e73e70a4d5bce1de.1323723759.git.trast@student.ethz.ch>
References: <cover.1323723759.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Jeff King <peff@peff.net>, Eric Herman <eric@freesa.org>
To: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 22:16:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaDEa-0004jc-TN
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 22:16:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754095Ab1LLVQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 16:16:22 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:29994 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754048Ab1LLVQP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 16:16:15 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Dec
 2011 22:16:09 +0100
Received: from thomas.inf.ethz.ch (129.132.208.62) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Dec
 2011 22:16:11 +0100
X-Mailer: git-send-email 1.7.8.431.g2abf2
In-Reply-To: <cover.1323723759.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.208.62]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186952>

Lazily load the userdiff attributes in match_funcname().  Use a
separate mutex around this loading to protect the (not thread-safe)
attributes machinery.  This lets us re-enable threading with -p and
-W while reducing the overhead caused by looking up attributes.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 builtin/grep.c |   12 +++++++--
 grep.c         |   74 ++++++++++++++++++++++++++++++++++----------------------
 grep.h         |    7 +++++
 3 files changed, 61 insertions(+), 32 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 988ea1d..bc23c3c 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -256,6 +256,7 @@ static void start_threads(struct grep_opt *opt)
 
 	pthread_mutex_init(&grep_mutex, NULL);
 	pthread_mutex_init(&read_sha1_mutex, NULL);
+	pthread_mutex_init(&grep_attr_mutex, NULL);
 	pthread_cond_init(&cond_add, NULL);
 	pthread_cond_init(&cond_write, NULL);
 	pthread_cond_init(&cond_result, NULL);
@@ -303,6 +304,7 @@ static int wait_all(void)
 
 	pthread_mutex_destroy(&grep_mutex);
 	pthread_mutex_destroy(&read_sha1_mutex);
+	pthread_mutex_destroy(&grep_attr_mutex);
 	pthread_cond_destroy(&cond_add);
 	pthread_cond_destroy(&cond_write);
 	pthread_cond_destroy(&cond_result);
@@ -1002,17 +1004,21 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		opt.regflags |= REG_ICASE;
 
 #ifndef NO_PTHREADS
-	if (online_cpus() == 1 || !grep_threads_ok(&opt))
+	if (online_cpus() == 1)
 		use_threads = 0;
+#else
+	use_threads = 0;
+#endif
+
+	opt.use_threads = use_threads;
 
+#ifndef NO_PTHREADS
 	if (use_threads) {
 		if (opt.pre_context || opt.post_context || opt.file_break ||
 		    opt.funcbody)
 			skip_first_line = 1;
 		start_threads(&opt);
 	}
-#else
-	use_threads = 0;
 #endif
 
 	compile_grep_patterns(&opt);
diff --git a/grep.c b/grep.c
index 7a070e9..4dd7da2 100644
--- a/grep.c
+++ b/grep.c
@@ -2,6 +2,7 @@
 #include "grep.h"
 #include "userdiff.h"
 #include "xdiff-interface.h"
+#include "thread-utils.h"
 
 void append_header_grep_pattern(struct grep_opt *opt, enum grep_header_field field, const char *pat)
 {
@@ -806,10 +807,46 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 	opt->output(opt, "\n", 1);
 }
 
-static int match_funcname(struct grep_opt *opt, char *bol, char *eol)
+#ifndef NO_PTHREADS
+/*
+ * This lock protects access to the gitattributes machinery, which is
+ * not thread-safe.
+ */
+pthread_mutex_t grep_attr_mutex;
+
+static inline void grep_attr_lock(struct grep_opt *opt)
+{
+	if (opt->use_threads)
+		pthread_mutex_lock(&grep_attr_mutex);
+}
+
+static inline void grep_attr_unlock(struct grep_opt *opt)
+{
+	if (opt->use_threads)
+		pthread_mutex_unlock(&grep_attr_mutex);
+}
+#else
+#define grep_attr_lock(opt)
+#define grep_attr_unlock(opt)
+#endif
+
+static int match_funcname(struct grep_opt *opt, const char *name, char *bol, char *eol)
 {
 	xdemitconf_t *xecfg = opt->priv;
-	if (xecfg && xecfg->find_func) {
+	if (xecfg && !xecfg->find_func) {
+		struct userdiff_driver *drv;
+		grep_attr_lock(opt);
+		drv = userdiff_find_by_path(name);
+		grep_attr_unlock(opt);
+		if (drv && drv->funcname.pattern) {
+			const struct userdiff_funcname *pe = &drv->funcname;
+			xdiff_set_find_func(xecfg, pe->pattern, pe->cflags);
+		} else {
+			xecfg = opt->priv = NULL;
+		}
+	}
+
+	if (xecfg) {
 		char buf[1];
 		return xecfg->find_func(bol, eol - bol, buf, 1,
 					xecfg->find_func_priv) >= 0;
@@ -835,7 +872,7 @@ static void show_funcname_line(struct grep_opt *opt, const char *name,
 		if (lno <= opt->last_shown)
 			break;
 
-		if (match_funcname(opt, bol, eol)) {
+		if (match_funcname(opt, name, bol, eol)) {
 			show_line(opt, bol, eol, name, lno, '=');
 			break;
 		}
@@ -848,7 +885,7 @@ static void show_pre_context(struct grep_opt *opt, const char *name, char *buf,
 	unsigned cur = lno, from = 1, funcname_lno = 0;
 	int funcname_needed = !!opt->funcname;
 
-	if (opt->funcbody && !match_funcname(opt, bol, end))
+	if (opt->funcbody && !match_funcname(opt, name, bol, end))
 		funcname_needed = 2;
 
 	if (opt->pre_context < lno)
@@ -864,7 +901,7 @@ static void show_pre_context(struct grep_opt *opt, const char *name, char *buf,
 		while (bol > buf && bol[-1] != '\n')
 			bol--;
 		cur--;
-		if (funcname_needed && match_funcname(opt, bol, eol)) {
+		if (funcname_needed && match_funcname(opt, name, bol, eol)) {
 			funcname_lno = cur;
 			funcname_needed = 0;
 		}
@@ -942,19 +979,6 @@ static int look_ahead(struct grep_opt *opt,
 	return 0;
 }
 
-int grep_threads_ok(const struct grep_opt *opt)
-{
-	/* If this condition is true, then we may use the attribute
-	 * machinery in grep_buffer_1. The attribute code is not
-	 * thread safe, so we disable the use of threads.
-	 */
-	if ((opt->funcname || opt->funcbody)
-	    && !opt->unmatch_name_only && !opt->status_only && !opt->name_only)
-		return 0;
-
-	return 1;
-}
-
 static void std_output(struct grep_opt *opt, const void *buf, size_t size)
 {
 	fwrite(buf, size, 1, stdout);
@@ -1008,16 +1032,8 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 	}
 
 	memset(&xecfg, 0, sizeof(xecfg));
-	if ((opt->funcname || opt->funcbody)
-	    && !opt->unmatch_name_only && !opt->status_only &&
-	    !opt->name_only && !binary_match_only && !collect_hits) {
-		struct userdiff_driver *drv = userdiff_find_by_path(name);
-		if (drv && drv->funcname.pattern) {
-			const struct userdiff_funcname *pe = &drv->funcname;
-			xdiff_set_find_func(&xecfg, pe->pattern, pe->cflags);
-			opt->priv = &xecfg;
-		}
-	}
+	opt->priv = &xecfg;
+
 	try_lookahead = should_lookahead(opt);
 
 	while (left) {
@@ -1093,7 +1109,7 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 				show_function = 1;
 			goto next_line;
 		}
-		if (show_function && match_funcname(opt, bol, eol))
+		if (show_function && match_funcname(opt, name, bol, eol))
 			show_function = 0;
 		if (show_function ||
 		    (last_hit && lno <= last_hit + opt->post_context)) {
diff --git a/grep.h b/grep.h
index a652800..15d227c 100644
--- a/grep.h
+++ b/grep.h
@@ -115,6 +115,7 @@ struct grep_opt {
 	int show_hunk_mark;
 	int file_break;
 	int heading;
+	int use_threads;
 	void *priv;
 
 	void (*output)(struct grep_opt *opt, const void *data, size_t size);
@@ -131,4 +132,10 @@ struct grep_opt {
 extern struct grep_opt *grep_opt_dup(const struct grep_opt *opt);
 extern int grep_threads_ok(const struct grep_opt *opt);
 
+#ifndef NO_PTHREADS
+/* Mutex used around access to the attributes machinery if
+ * opt->use_threads.  Must be initialized/destroyed by callers! */
+extern pthread_mutex_t grep_attr_mutex;
+#endif
+
 #endif
-- 
1.7.8.431.g2abf2
