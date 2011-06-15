From: Jeff King <peff@peff.net>
Subject: [PATCH 2/7] archive: add user-configurable tar-filter infrastructure
Date: Wed, 15 Jun 2011 18:33:01 -0400
Message-ID: <20110615223301.GB16807@sigill.intra.peff.net>
References: <20110615223030.GA16110@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Jun 16 00:33:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWye5-0007r4-RO
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 00:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754202Ab1FOWdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 18:33:05 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45231
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752415Ab1FOWdE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 18:33:04 -0400
Received: (qmail 7448 invoked by uid 107); 15 Jun 2011 22:33:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Jun 2011 18:33:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Jun 2011 18:33:01 -0400
Content-Disposition: inline
In-Reply-To: <20110615223030.GA16110@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175858>

Archive supports two output formats: tar and zip. The tar
files are totally uncompressed, and it is up to the user to
pipe them through gzip or similar. This is no more than
a minor inconvenience when running archive locally. However,
for remote calls to upload-archive, having the server do the
compression can save a lot of bandwidth.

This patch lays the foundation for tar filters; it parses
user configuration into an internal representation, but
doesn't yet do anything with the result.

It also introduces some tests to document the intended
usage.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile             |    1 +
 archive-tar-filter.c |  112 ++++++++++++++++++++++++++++++++++++++++++++++++++
 archive.c            |    1 +
 archive.h            |   15 +++++++
 t/t5000-tar-tree.sh  |   54 ++++++++++++++++++++++++
 5 files changed, 183 insertions(+), 0 deletions(-)
 create mode 100644 archive-tar-filter.c

diff --git a/Makefile b/Makefile
index e40ac0c..bd3002f 100644
--- a/Makefile
+++ b/Makefile
@@ -573,6 +573,7 @@ LIB_OBJS += advice.o
 LIB_OBJS += alias.o
 LIB_OBJS += alloc.o
 LIB_OBJS += archive.o
+LIB_OBJS += archive-tar-filter.o
 LIB_OBJS += archive-tar.o
 LIB_OBJS += archive-zip.o
 LIB_OBJS += attr.o
diff --git a/archive-tar-filter.c b/archive-tar-filter.c
new file mode 100644
index 0000000..211f1df
--- /dev/null
+++ b/archive-tar-filter.c
@@ -0,0 +1,112 @@
+#include "cache.h"
+#include "archive.h"
+
+struct tar_filter *tar_filters;
+static struct tar_filter **tar_filters_tail = &tar_filters;
+
+static struct tar_filter *tar_filter_new(const char *name, int namelen)
+{
+	struct tar_filter *tf;
+	tf = xcalloc(1, sizeof(*tf));
+	tf->name = xmemdupz(name, namelen);
+	tf->extensions.strdup_strings = 1;
+	*tar_filters_tail = tf;
+	tar_filters_tail = &tf->next;
+	return tf;
+}
+
+static void tar_filter_free(struct tar_filter *tf)
+{
+	string_list_clear(&tf->extensions, 0);
+	free(tf->name);
+	free(tf->command);
+	free(tf);
+}
+
+static struct tar_filter *tar_filter_by_namelen(const char *name,
+						int len)
+{
+	struct tar_filter *p;
+	for (p = tar_filters; p; p = p->next)
+		if (!strncmp(p->name, name, len) && !p->name[len])
+			return p;
+	return NULL;
+}
+
+struct tar_filter *tar_filter_by_name(const char *name)
+{
+	return tar_filter_by_namelen(name, strlen(name));
+}
+
+static int tar_filter_config(const char *var, const char *value, void *data)
+{
+	struct tar_filter *tf;
+	const char *dot;
+	const char *name;
+	const char *type;
+	int namelen;
+
+	if (prefixcmp(var, "tarfilter."))
+		return 0;
+	dot = strrchr(var, '.');
+	if (dot == var + 9)
+		return 0;
+
+	name = var + 10;
+	namelen = dot - name;
+	type = dot + 1;
+
+	tf = tar_filter_by_namelen(name, namelen);
+	if (!tf)
+		tf = tar_filter_new(name, namelen);
+
+	if (!strcmp(type, "command")) {
+		if (!value)
+			return config_error_nonbool(var);
+		tf->command = xstrdup(value);
+		return 0;
+	}
+	else if (!strcmp(type, "extension")) {
+		if (!value)
+			return config_error_nonbool(var);
+		string_list_append(&tf->extensions, value);
+		return 0;
+	}
+	else if (!strcmp(type, "compressionlevels")) {
+		tf->use_compression = git_config_bool(var, value);
+		return 0;
+	}
+
+	return 0;
+}
+
+static void remove_filters_without_command(void)
+{
+	struct tar_filter *p = tar_filters;
+	struct tar_filter **last = &tar_filters;
+
+	while (p) {
+		if (p->command && *p->command)
+			last = &p->next;
+		else {
+			*last = p->next;
+			tar_filter_free(p);
+		}
+		p = *last;
+	}
+}
+
+/*
+ * We don't want to load twice, since some of our
+ * values actually append rather than overwrite.
+ */
+static int tar_filter_config_loaded;
+extern void tar_filter_load_config(void)
+{
+	if (tar_filter_config_loaded)
+		return;
+	tar_filter_config_loaded = 1;
+
+	git_config(tar_filter_config, NULL);
+	remove_filters_without_command();
+}
diff --git a/archive.c b/archive.c
index 2616676..2ed9259 100644
--- a/archive.c
+++ b/archive.c
@@ -395,6 +395,7 @@ int write_archive(int argc, const char **argv, const char *prefix,
 		prefix = setup_git_directory_gently(&nongit);
 
 	git_config(git_default_config, NULL);
+	tar_filter_load_config();
 
 	argc = parse_archive_args(argc, argv, &ar, &args);
 	if (nongit) {
diff --git a/archive.h b/archive.h
index 038ac35..8386c46 100644
--- a/archive.h
+++ b/archive.h
@@ -1,6 +1,8 @@
 #ifndef ARCHIVE_H
 #define ARCHIVE_H
 
+#include "string-list.h"
+
 struct archiver_args {
 	const char *base;
 	size_t baselen;
@@ -27,4 +29,17 @@ extern int write_zip_archive(struct archiver_args *);
 extern int write_archive_entries(struct archiver_args *args, write_archive_entry_fn_t write_entry);
 extern int write_archive(int argc, const char **argv, const char *prefix, int setup_prefix);
 
+struct tar_filter {
+	char *name;
+	char *command;
+	struct string_list extensions;
+	unsigned use_compression:1;
+	struct tar_filter *next;
+};
+
+extern struct tar_filter *tar_filters;
+extern struct tar_filter *tar_filter_by_name(const char *name);
+
+extern void tar_filter_load_config(void);
+
 #endif	/* ARCHIVE_H */
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index cff1b3e..c3e1a4e 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -252,4 +252,58 @@ test_expect_success 'git-archive --prefix=olde-' '
 	test -f h/olde-a/bin/sh
 '
 
+test_expect_success 'setup fake tar filter' '
+	git config tarfilter.fake.command "cat >/dev/null; echo args: "
+'
+
+test_expect_failure 'filter does not allow compression levels by default' '
+	test_must_fail git archive --format=fake -9 HEAD >output
+'
+
+test_expect_failure 'filters can allow compression levels' '
+	git config tarfilter.fake.compressionlevels true &&
+	echo "args: -9" >expect &&
+	git archive --format=fake -9 HEAD >output &&
+	test_cmp expect output
+'
+
+test_expect_failure 'archive --list mentions user filter' '
+	git archive --list >output &&
+	grep "^fake\$" output
+'
+
+test_expect_failure 'archive --list shows remote user filters' '
+	git archive --list --remote=. >output &&
+	grep "^fake\$" output
+'
+
+test_expect_success 'setup slightly more useful tar filter' '
+	git config tarfilter.foo.command "tr ab ba" &&
+	git config --add tarfilter.foo.extension tar.foo &&
+	git config --add tarfilter.foo.extension bar
+'
+
+test_expect_failure 'archive outputs in configurable format' '
+	git archive --format=foo HEAD >config.tar.foo &&
+	tr ab ba <config.tar.foo >config.tar &&
+	test_cmp b.tar config.tar
+'
+
+test_expect_failure 'archive selects implicit format by configured extension' '
+	git archive -o config-implicit.tar.foo HEAD &&
+	test_cmp config.tar.foo config-implicit.tar.foo &&
+	git archive -o config-implicit.bar HEAD &&
+	test_cmp config.tar.foo config-implicit.bar
+'
+
+test_expect_success 'default output format remains tar' '
+	git archive -o config-implicit.baz HEAD &&
+	test_cmp b.tar config-implicit.baz
+'
+
+test_expect_failure 'extension matching requires dot' '
+	git archive -o config-implicittar.foo HEAD &&
+	test_cmp b.tar config-implicittar.foo
+'
+
 test_done
-- 
1.7.6.rc1.4.g49204
