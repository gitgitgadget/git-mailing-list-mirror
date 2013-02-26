From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH 4/4] teach config parsing to read from strbuf
Date: Tue, 26 Feb 2013 20:43:13 +0100
Message-ID: <20130226194313.GE22756@sandbox-ub>
References: <cover.1361751905.git.hvoigt@hvoigt.net>
 <6c69068b4e6a72a2cca5dc6eaffa9982032a7f2a.1361751905.git.hvoigt@hvoigt.net>
 <7v4nh13plo.fsf@alter.siamese.dyndns.org>
 <20130226193050.GA22756@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 20:46:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAQTY-0005MO-Sv
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 20:46:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759884Ab3BZTpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 14:45:43 -0500
Received: from smtprelay03.ispgateway.de ([80.67.29.7]:60554 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759849Ab3BZTpm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 14:45:42 -0500
X-Greylist: delayed 310 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Feb 2013 14:45:42 EST
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UAQQk-0005TL-2S; Tue, 26 Feb 2013 20:43:14 +0100
Content-Disposition: inline
In-Reply-To: <20130226193050.GA22756@sandbox-ub>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217166>

This can be used to read configuration values directly from gits
database.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 .gitignore             |  1 +
 Makefile               |  1 +
 cache.h                |  1 +
 config.c               | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 t/t1300-repo-config.sh |  4 ++++
 test-config.c          | 41 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 95 insertions(+)
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
index 19aa205..492873a 100644
--- a/config.c
+++ b/config.c
@@ -46,6 +46,37 @@ static long config_file_ftell(struct config *conf)
 	return ftell(f);
 }
 
+struct config_strbuf {
+	struct strbuf *strbuf;
+	int pos;
+};
+
+static int config_strbuf_fgetc(struct config *conf)
+{
+	struct config_strbuf *str = conf->data;
+
+	if (str->pos < str->strbuf->len)
+		return str->strbuf->buf[str->pos++];
+
+	return EOF;
+}
+
+static int config_strbuf_ungetc(int c, struct config *conf)
+{
+	struct config_strbuf *str = conf->data;
+
+	if (str->pos > 0)
+		return str->strbuf->buf[--str->pos];
+
+	return EOF;
+}
+
+static long config_strbuf_ftell(struct config *conf)
+{
+	struct config_strbuf *str = conf->data;
+	return str->pos;
+}
+
 #define MAX_INCLUDE_DEPTH 10
 static const char include_depth_advice[] =
 "exceeded maximum include depth (%d) while including\n"
@@ -961,6 +992,22 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 	return ret;
 }
 
+int git_config_from_strbuf(config_fn_t fn, struct strbuf *strbuf, void *data)
+{
+	struct config top;
+	struct config_strbuf str;
+
+	str.strbuf = strbuf;
+	str.pos = 0;
+
+	top.data = &str;
+	top.fgetc = config_strbuf_fgetc;
+	top.ungetc = config_strbuf_ungetc;
+	top.ftell = config_strbuf_ftell;
+
+	return do_config_from(&top, fn, data);
+}
+
 const char *git_etc_gitconfig(void)
 {
 	static const char *system_wide;
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
1.8.2.rc0.26.gf7384c5
