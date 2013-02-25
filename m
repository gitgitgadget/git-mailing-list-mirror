From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [RFC/WIP PATCH 1/3] teach config parsing to read from strbuf
Date: Mon, 25 Feb 2013 02:04:18 +0100
Message-ID: <6c69068b4e6a72a2cca5dc6eaffa9982032a7f2a.1361751905.git.hvoigt@hvoigt.net>
References: <cover.1361751905.git.hvoigt@hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <jens.lehmann@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 02:04:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9mUq-0003LC-Gf
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 02:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759488Ab3BYBEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 20:04:21 -0500
Received: from smtprelay02.ispgateway.de ([80.67.31.29]:41411 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759399Ab3BYBEU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2013 20:04:20 -0500
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1U9mUM-0001b1-JI; Mon, 25 Feb 2013 02:04:19 +0100
Content-Disposition: inline
In-Reply-To: <cover.1361751905.git.hvoigt@hvoigt.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217019>

This can be used to read configuration values directly from gits
database.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 .gitignore             |   1 +
 Makefile               |   1 +
 cache.h                |   1 +
 config.c               | 119 ++++++++++++++++++++++++++++++++++++++-----------
 t/t1300-repo-config.sh |   4 ++
 test-config.c          |  41 +++++++++++++++++
 6 files changed, 142 insertions(+), 25 deletions(-)
 create mode 100644 test-config.c

diff --git a/.gitignore b/.gitignore
index 6669bf0..386b7f2 100644
--- a/.gitignore
+++ b/.gitignore
@@ -178,6 +178,7 @@
 /gitweb/static/gitweb.min.*
 /test-chmtime
 /test-ctype
+/test-config
 /test-date
 /test-delta
 /test-dump-cache-tree
diff --git a/Makefile b/Makefile
index ba8e243..98da708 100644
--- a/Makefile
+++ b/Makefile
@@ -543,6 +543,7 @@ PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 
 TEST_PROGRAMS_NEED_X += test-chmtime
 TEST_PROGRAMS_NEED_X += test-ctype
+TEST_PROGRAMS_NEED_X += test-config
 TEST_PROGRAMS_NEED_X += test-date
 TEST_PROGRAMS_NEED_X += test-delta
 TEST_PROGRAMS_NEED_X += test-dump-cache-tree
diff --git a/cache.h b/cache.h
index e493563..ada2362 100644
--- a/cache.h
+++ b/cache.h
@@ -1128,6 +1128,7 @@ extern int update_server_info(int);
 typedef int (*config_fn_t)(const char *, const char *, void *);
 extern int git_default_config(const char *, const char *, void *);
 extern int git_config_from_file(config_fn_t fn, const char *, void *);
+extern int git_config_from_strbuf(config_fn_t fn, struct strbuf *strbuf, void *data);
 extern void git_config_push_parameter(const char *text);
 extern int git_config_from_parameters(config_fn_t fn, void *data);
 extern int git_config(config_fn_t fn, void *);
diff --git a/config.c b/config.c
index aefd80b..f995e98 100644
--- a/config.c
+++ b/config.c
@@ -13,6 +13,9 @@
 typedef struct config_file {
 	struct config_file *prev;
 	FILE *f;
+	int is_strbuf;
+	struct strbuf *strbuf_contents;
+	int strbuf_pos;
 	const char *name;
 	int linenr;
 	int eof;
@@ -24,6 +27,46 @@ static config_file *cf;
 
 static int zlib_compression_seen;
 
+static int config_file_valid(struct config_file *file)
+{
+	if (file->f)
+		return 1;
+	if (file->is_strbuf)
+		return 1;
+
+	return 0;
+}
+
+static int config_fgetc(struct config_file *file)
+{
+	if (!file->is_strbuf)
+		return fgetc(file->f);
+
+	if (file->strbuf_pos < file->strbuf_contents->len)
+		return file->strbuf_contents->buf[file->strbuf_pos++];
+
+	return EOF;
+}
+
+static int config_ungetc(int c, struct config_file *file)
+{
+	if (!file->is_strbuf)
+		return ungetc(c, file->f);
+
+	if (file->strbuf_pos > 0)
+		return file->strbuf_contents->buf[--file->strbuf_pos];
+
+	return EOF;
+}
+
+static long config_ftell(struct config_file *file)
+{
+	if (!file->is_strbuf)
+		return ftell(file->f);
+
+	return file->strbuf_pos;
+}
+
 #define MAX_INCLUDE_DEPTH 10
 static const char include_depth_advice[] =
 "exceeded maximum include depth (%d) while including\n"
@@ -169,16 +212,15 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 static int get_next_char(void)
 {
 	int c;
-	FILE *f;
 
 	c = '\n';
-	if (cf && ((f = cf->f) != NULL)) {
-		c = fgetc(f);
+	if (cf && config_file_valid(cf)) {
+		c = config_fgetc(cf);
 		if (c == '\r') {
 			/* DOS like systems */
-			c = fgetc(f);
+			c = config_fgetc(cf);
 			if (c != '\n') {
-				ungetc(c, f);
+				config_ungetc(c, cf);
 				c = '\r';
 			}
 		}
@@ -896,6 +938,38 @@ int git_default_config(const char *var, const char *value, void *dummy)
 	return 0;
 }
 
+static int do_config_from(struct config_file *top, config_fn_t fn, void *data)
+{
+	int ret;
+
+	/* push config-file parsing state stack */
+	top->prev = cf;
+	top->linenr = 1;
+	top->eof = 0;
+	strbuf_init(&top->value, 1024);
+	strbuf_init(&top->var, 1024);
+	cf = top;
+
+	ret = git_parse_file(fn, data);
+
+	/* pop config-file parsing state stack */
+	strbuf_release(&top->value);
+	strbuf_release(&top->var);
+	cf = top->prev;
+
+	return ret;
+}
+
+static void config_file_init(struct config_file *top, const char *filename,
+			     FILE *f, struct strbuf *string)
+{
+	top->f = f;
+	top->name = filename;
+	top->is_strbuf = f ? 0 : 1;
+	top->strbuf_contents = string;
+	top->strbuf_pos = 0;
+}
+
 int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 {
 	int ret;
@@ -905,28 +979,24 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 	if (f) {
 		config_file top;
 
-		/* push config-file parsing state stack */
-		top.prev = cf;
-		top.f = f;
-		top.name = filename;
-		top.linenr = 1;
-		top.eof = 0;
-		strbuf_init(&top.value, 1024);
-		strbuf_init(&top.var, 1024);
-		cf = &top;
-
-		ret = git_parse_file(fn, data);
+		config_file_init(&top, filename, f, NULL);
 
-		/* pop config-file parsing state stack */
-		strbuf_release(&top.value);
-		strbuf_release(&top.var);
-		cf = top.prev;
+		ret = do_config_from(&top, fn, data);
 
 		fclose(f);
 	}
 	return ret;
 }
 
+int git_config_from_strbuf(config_fn_t fn, struct strbuf *strbuf, void *data)
+{
+	config_file top;
+
+	config_file_init(&top, NULL, NULL, strbuf);
+
+	return do_config_from(&top, fn, data);
+}
+
 const char *git_etc_gitconfig(void)
 {
 	static const char *system_wide;
@@ -1053,7 +1123,6 @@ static int store_aux(const char *key, const char *value, void *cb)
 {
 	const char *ep;
 	size_t section_len;
-	FILE *f = cf->f;
 
 	switch (store.state) {
 	case KEY_SEEN:
@@ -1065,7 +1134,7 @@ static int store_aux(const char *key, const char *value, void *cb)
 				return 1;
 			}
 
-			store.offset[store.seen] = ftell(f);
+			store.offset[store.seen] = config_ftell(cf);
 			store.seen++;
 		}
 		break;
@@ -1092,19 +1161,19 @@ static int store_aux(const char *key, const char *value, void *cb)
 		 * Do not increment matches: this is no match, but we
 		 * just made sure we are in the desired section.
 		 */
-		store.offset[store.seen] = ftell(f);
+		store.offset[store.seen] = config_ftell(cf);
 		/* fallthru */
 	case SECTION_END_SEEN:
 	case START:
 		if (matches(key, value)) {
-			store.offset[store.seen] = ftell(f);
+			store.offset[store.seen] = config_ftell(cf);
 			store.state = KEY_SEEN;
 			store.seen++;
 		} else {
 			if (strrchr(key, '.') - key == store.baselen &&
 			      !strncmp(key, store.key, store.baselen)) {
 					store.state = SECTION_SEEN;
-					store.offset[store.seen] = ftell(f);
+					store.offset[store.seen] = config_ftell(cf);
 			}
 		}
 	}
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 3c96fda..3304bcd 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1087,4 +1087,8 @@ test_expect_success 'barf on incomplete string' '
 	grep " line 3 " error
 '
 
+test_expect_success 'reading config from strbuf' '
+	test-config strbuf
+'
+
 test_done
diff --git a/test-config.c b/test-config.c
new file mode 100644
index 0000000..7a4103c
--- /dev/null
+++ b/test-config.c
@@ -0,0 +1,41 @@
+#include "cache.h"
+
+static const char *config_string = "[some]\n"
+			    "	value = content\n";
+
+static int config_strbuf(const char *var, const char *value, void *data)
+{
+	int *success = data;
+	if (!strcmp(var, "some.value") && !strcmp(value, "content"))
+		*success = 0;
+
+	printf("var: %s, value: %s\n", var, value);
+
+	return 1;
+}
+
+static void die_usage(int argc, char **argv)
+{
+	fprintf(stderr, "Usage: %s strbuf\n", argv[0]);
+	exit(1);
+}
+
+int main(int argc, char **argv)
+{
+	if (argc < 2)
+		die_usage(argc, argv);
+
+	if (!strcmp(argv[1], "strbuf")) {
+		int success = 1;
+		struct strbuf buf = STRBUF_INIT;
+
+		strbuf_addstr(&buf, config_string);
+		git_config_from_strbuf(config_strbuf, &buf, &success);
+
+		return success;
+	}
+
+	die_usage(argc, argv);
+
+	return 1;
+}
-- 
1.8.2.rc0.25.g5062c01
