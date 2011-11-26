From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] grep: enable multi-threading for -p and -W
Date: Sat, 26 Nov 2011 13:15:49 +0100
Message-ID: <4ED0D875.5050900@lsrfire.ath.cx>
References: <5e3bcf651b31b299ca411296e6e7c4d11f6ae617.1322232319.git.trast@student.ethz.ch> <4ECFC320.4030003@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Nov 26 13:19:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUHEM-00061q-UT
	for gcvg-git-2@lo.gmane.org; Sat, 26 Nov 2011 13:19:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754615Ab1KZMP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Nov 2011 07:15:58 -0500
Received: from india601.server4you.de ([85.25.151.105]:37204 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754459Ab1KZMP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Nov 2011 07:15:57 -0500
Received: from [192.168.2.104] (p4FFDBDDB.dip.t-dialin.net [79.253.189.219])
	by india601.server4you.de (Postfix) with ESMTPSA id 81E862F8038;
	Sat, 26 Nov 2011 13:15:55 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <4ECFC320.4030003@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185952>

Move attribute reading, which is not thread-safe, into add_work(), under
grep_mutex.  That way we can stop turning off multi-threading if -p or -W
is given, as the diff attribute for each file is gotten safely now.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
Goes on top of your patch.  Needs testing..

 builtin/grep.c |   33 +++++++++++++++++++++++++--------
 grep.c         |   25 +++++++------------------
 grep.h         |    5 +++--
 revision.c     |    2 +-
 4 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 3d7329d..5534111 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -18,6 +18,7 @@
 #include "quote.h"
 #include "dir.h"
 #include "thread-utils.h"
+#include "userdiff.h"
 
 static char const * const grep_usage[] = {
 	"git grep [options] [-e] <pattern> [<rev>...] [[--] <path>...]",
@@ -43,6 +44,7 @@ enum work_type {WORK_SHA1, WORK_FILE};
 struct work_item {
 	enum work_type type;
 	char *name;
+	struct userdiff_driver *userdiff_driver;
 
 	/* if type == WORK_SHA1, then 'identifier' is a SHA1,
 	 * otherwise type == WORK_FILE, and 'identifier' is a NUL
@@ -114,7 +116,17 @@ static pthread_cond_t cond_result;
 
 static int skip_first_line;
 
-static void add_work(enum work_type type, char *name, void *id)
+/* Reading attributes is not thread-safe, so callers need to lock. */
+static struct userdiff_driver *get_userdiff_driver(struct grep_opt *opt,
+						   const char *name)
+{
+	if (opt->funcbody || opt->funcname)
+		return userdiff_find_by_path(name);
+	return NULL;
+}
+
+static void add_work(struct grep_opt *opt, enum work_type type, char *name,
+		     void *id)
 {
 	grep_lock();
 
@@ -124,6 +136,7 @@ static void add_work(enum work_type type, char *name, void *id)
 
 	todo[todo_end].type = type;
 	todo[todo_end].name = name;
+	todo[todo_end].userdiff_driver = get_userdiff_driver(opt, name);
 	todo[todo_end].identifier = id;
 	todo[todo_end].done = 0;
 	strbuf_reset(&todo[todo_end].out);
@@ -158,13 +171,13 @@ static void grep_sha1_async(struct grep_opt *opt, char *name,
 	unsigned char *s;
 	s = xmalloc(20);
 	memcpy(s, sha1, 20);
-	add_work(WORK_SHA1, name, s);
+	add_work(opt, WORK_SHA1, name, s);
 }
 
 static void grep_file_async(struct grep_opt *opt, char *name,
 			    const char *filename)
 {
-	add_work(WORK_FILE, name, xstrdup(filename));
+	add_work(opt, WORK_FILE, name, xstrdup(filename));
 }
 
 static void work_done(struct work_item *w)
@@ -212,24 +225,26 @@ static void *run(void *arg)
 	struct grep_opt *opt = arg;
 
 	while (1) {
+		struct userdiff_driver *drv;
 		struct work_item *w = get_work();
 		if (!w)
 			break;
 
 		opt->output_priv = w;
+		drv = w->userdiff_driver;
 		if (w->type == WORK_SHA1) {
 			unsigned long sz;
 			void* data = load_sha1(w->identifier, &sz, w->name);
 
 			if (data) {
-				hit |= grep_buffer(opt, w->name, data, sz);
+				hit |= grep_buffer(opt, w->name, drv, data, sz);
 				free(data);
 			}
 		} else if (w->type == WORK_FILE) {
 			size_t sz;
 			void* data = load_file(w->identifier, &sz);
 			if (data) {
-				hit |= grep_buffer(opt, w->name, data, sz);
+				hit |= grep_buffer(opt, w->name, drv, data, sz);
 				free(data);
 			}
 		} else {
@@ -417,10 +432,11 @@ static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1,
 		int hit;
 		unsigned long sz;
 		void *data = load_sha1(sha1, &sz, name);
+		struct userdiff_driver *drv = get_userdiff_driver(opt, name);
 		if (!data)
 			hit = 0;
 		else
-			hit = grep_buffer(opt, name, data, sz);
+			hit = grep_buffer(opt, name, drv, data, sz);
 
 		free(data);
 		free(name);
@@ -479,10 +495,11 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 		int hit;
 		size_t sz;
 		void *data = load_file(filename, &sz);
+		struct userdiff_driver *drv = get_userdiff_driver(opt, name);
 		if (!data)
 			hit = 0;
 		else
-			hit = grep_buffer(opt, name, data, sz);
+			hit = grep_buffer(opt, name, drv, data, sz);
 
 		free(data);
 		free(name);
@@ -1001,7 +1018,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		opt.regflags |= REG_ICASE;
 
 #ifndef NO_PTHREADS
-	if (online_cpus() == 1 || !grep_threads_ok(&opt))
+	if (online_cpus() == 1)
 		use_threads = 0;
 
 	if (use_threads) {
diff --git a/grep.c b/grep.c
index 7a070e9..ff14a98 100644
--- a/grep.c
+++ b/grep.c
@@ -942,25 +942,13 @@ static int look_ahead(struct grep_opt *opt,
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
 }
 
 static int grep_buffer_1(struct grep_opt *opt, const char *name,
+			 struct userdiff_driver *drv,
 			 char *buf, unsigned long size, int collect_hits)
 {
 	char *bol = buf;
@@ -1011,7 +999,6 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 	if ((opt->funcname || opt->funcbody)
 	    && !opt->unmatch_name_only && !opt->status_only &&
 	    !opt->name_only && !binary_match_only && !collect_hits) {
-		struct userdiff_driver *drv = userdiff_find_by_path(name);
 		if (drv && drv->funcname.pattern) {
 			const struct userdiff_funcname *pe = &drv->funcname;
 			xdiff_set_find_func(&xecfg, pe->pattern, pe->cflags);
@@ -1167,23 +1154,25 @@ static int chk_hit_marker(struct grep_expr *x)
 	}
 }
 
-int grep_buffer(struct grep_opt *opt, const char *name, char *buf, unsigned long size)
+int grep_buffer(struct grep_opt *opt, const char *name,
+		struct userdiff_driver *userdiff_driver,
+		char *buf, unsigned long size)
 {
 	/*
 	 * we do not have to do the two-pass grep when we do not check
 	 * buffer-wide "all-match".
 	 */
 	if (!opt->all_match)
-		return grep_buffer_1(opt, name, buf, size, 0);
+		return grep_buffer_1(opt, name, userdiff_driver, buf, size, 0);
 
 	/* Otherwise the toplevel "or" terms hit a bit differently.
 	 * We first clear hit markers from them.
 	 */
 	clr_hit_marker(opt->pattern_expression);
-	grep_buffer_1(opt, name, buf, size, 1);
+	grep_buffer_1(opt, name, userdiff_driver, buf, size, 1);
 
 	if (!chk_hit_marker(opt->pattern_expression))
 		return 0;
 
-	return grep_buffer_1(opt, name, buf, size, 0);
+	return grep_buffer_1(opt, name, userdiff_driver, buf, size, 0);
 }
diff --git a/grep.h b/grep.h
index a652800..20224b5 100644
--- a/grep.h
+++ b/grep.h
@@ -121,14 +121,15 @@ struct grep_opt {
 	void *output_priv;
 };
 
+struct userdiff_driver;
+
 extern void append_grep_pat(struct grep_opt *opt, const char *pat, size_t patlen, const char *origin, int no, enum grep_pat_token t);
 extern void append_grep_pattern(struct grep_opt *opt, const char *pat, const char *origin, int no, enum grep_pat_token t);
 extern void append_header_grep_pattern(struct grep_opt *, enum grep_header_field, const char *);
 extern void compile_grep_patterns(struct grep_opt *opt);
 extern void free_grep_patterns(struct grep_opt *opt);
-extern int grep_buffer(struct grep_opt *opt, const char *name, char *buf, unsigned long size);
+extern int grep_buffer(struct grep_opt *opt, const char *name, struct userdiff_driver *userdiff_driver, char *buf, unsigned long size);
 
 extern struct grep_opt *grep_opt_dup(const struct grep_opt *opt);
-extern int grep_threads_ok(const struct grep_opt *opt);
 
 #endif
diff --git a/revision.c b/revision.c
index 8764dde..95cb8c2 100644
--- a/revision.c
+++ b/revision.c
@@ -2126,7 +2126,7 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 	if (!opt->grep_filter.pattern_list && !opt->grep_filter.header_list)
 		return 1;
 	return grep_buffer(&opt->grep_filter,
-			   NULL, /* we say nothing, not even filename */
+			   NULL, NULL, /* we say nothing, not even filename */
 			   commit->buffer, strlen(commit->buffer));
 }
 
-- 
1.7.7
