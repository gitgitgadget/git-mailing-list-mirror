From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v2 4/4] teach config parsing to read from strbuf
Date: Sun, 10 Mar 2013 18:00:52 +0100
Message-ID: <20130310170052.GE1136@sandbox-ub.fritz.box>
References: <20130310165642.GA1136@sandbox-ub.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 10 18:01:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEjch-0007hZ-O7
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 18:01:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991Ab3CJRAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 13:00:55 -0400
Received: from smtprelay02.ispgateway.de ([80.67.29.24]:37553 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954Ab3CJRAy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 13:00:54 -0400
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UEjcD-0005fB-11; Sun, 10 Mar 2013 18:00:53 +0100
Content-Disposition: inline
In-Reply-To: <20130310165642.GA1136@sandbox-ub.fritz.box>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217815>

This can be used to read configuration values directly from gits
database.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 .gitignore             |  1 +
 Makefile               |  1 +
 cache.h                |  2 ++
 config.c               | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 t/t1300-repo-config.sh | 24 ++++++++++++++++++++++++
 test-config.c          | 40 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 116 insertions(+)
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
index 26d3332..1a9ea10 100644
--- a/Makefile
+++ b/Makefile
@@ -541,6 +541,7 @@ PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 
 TEST_PROGRAMS_NEED_X += test-chmtime
 TEST_PROGRAMS_NEED_X += test-ctype
+TEST_PROGRAMS_NEED_X += test-config
 TEST_PROGRAMS_NEED_X += test-date
 TEST_PROGRAMS_NEED_X += test-delta
 TEST_PROGRAMS_NEED_X += test-dump-cache-tree
diff --git a/cache.h b/cache.h
index e493563..a2621fa 100644
--- a/cache.h
+++ b/cache.h
@@ -1128,6 +1128,8 @@ extern int update_server_info(int);
 typedef int (*config_fn_t)(const char *, const char *, void *);
 extern int git_default_config(const char *, const char *, void *);
 extern int git_config_from_file(config_fn_t fn, const char *, void *);
+extern int git_config_from_strbuf(config_fn_t fn, const char *name,
+				  struct strbuf *strbuf, void *data);
 extern void git_config_push_parameter(const char *text);
 extern int git_config_from_parameters(config_fn_t fn, void *data);
 extern int git_config(config_fn_t fn, void *);
diff --git a/config.c b/config.c
index fe1c0e5..b8c8640 100644
--- a/config.c
+++ b/config.c
@@ -46,6 +46,37 @@ static long config_file_ftell(struct config_source *conf)
 	return ftell(f);
 }
 
+struct config_strbuf {
+	struct strbuf *strbuf;
+	int pos;
+};
+
+static int config_strbuf_fgetc(struct config_source *conf)
+{
+	struct config_strbuf *str = conf->data;
+
+	if (str->pos < str->strbuf->len)
+		return str->strbuf->buf[str->pos++];
+
+	return EOF;
+}
+
+static int config_strbuf_ungetc(int c, struct config_source *conf)
+{
+	struct config_strbuf *str = conf->data;
+
+	if (str->pos > 0)
+		return str->strbuf->buf[--str->pos];
+
+	return EOF;
+}
+
+static long config_strbuf_ftell(struct config_source *conf)
+{
+	struct config_strbuf *str = conf->data;
+	return str->pos;
+}
+
 #define MAX_INCLUDE_DEPTH 10
 static const char include_depth_advice[] =
 "exceeded maximum include depth (%d) while including\n"
@@ -961,6 +992,23 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 	return ret;
 }
 
+int git_config_from_strbuf(config_fn_t fn, const char *name, struct strbuf *strbuf, void *data)
+{
+	struct config_source top;
+	struct config_strbuf str;
+
+	str.strbuf = strbuf;
+	str.pos = 0;
+
+	top.data = &str;
+	top.name = name;
+	top.fgetc = config_strbuf_fgetc;
+	top.ungetc = config_strbuf_ungetc;
+	top.ftell = config_strbuf_ftell;
+
+	return do_config_from_source(&top, fn, data);
+}
+
 const char *git_etc_gitconfig(void)
 {
 	static const char *system_wide;
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 3c96fda..5103f66 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1087,4 +1087,28 @@ test_expect_success 'barf on incomplete string' '
 	grep " line 3 " error
 '
 
+test_expect_success 'reading config from strbuf' '
+	cat >expect <<-\EOF &&
+	var: some.value, value: content
+	EOF
+	test-config strbuf 12345:.gitmodules >actual <<-\EOF &&
+	[some]
+		value = content
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'reading config from strbuf with error' '
+	touch expect.out &&
+	cat >expect.err <<-\EOF &&
+	fatal: bad config file line 2 in 12345:.gitmodules
+	EOF
+	test_must_fail test-config strbuf 12345:.gitmodules >actual.out 2>actual.err <<-\EOF &&
+	[some]
+		value = "
+	EOF
+	test_cmp expect.out actual.out &&
+	test_cmp expect.err actual.err
+'
+
 test_done
diff --git a/test-config.c b/test-config.c
new file mode 100644
index 0000000..c650837
--- /dev/null
+++ b/test-config.c
@@ -0,0 +1,40 @@
+#include "cache.h"
+
+static int config_strbuf(const char *var, const char *value, void *data)
+{
+	printf("var: %s, value: %s\n", var, value);
+
+	return 1;
+}
+
+static void die_usage(int argc, char **argv)
+{
+	fprintf(stderr, "Usage: %s strbuf <name>\n", argv[0]);
+	exit(1);
+}
+
+int main(int argc, char **argv)
+{
+	if (argc < 3)
+		die_usage(argc, argv);
+
+	if (!strcmp(argv[1], "strbuf")) {
+		struct strbuf buf = STRBUF_INIT;
+		const char *name = argv[2];
+
+		while (strbuf_fread(&buf, 1024, stdin) == 1024)
+			;
+
+		if (ferror(stdin))
+			die("An error occurred while reading from stdin");
+
+		git_config_from_strbuf(config_strbuf, name, &buf, NULL);
+		strbuf_release(&buf);
+
+		return 0;
+	}
+
+	die_usage(argc, argv);
+
+	return 1;
+}
-- 
1.8.2.rc0.26.gf7384c5
