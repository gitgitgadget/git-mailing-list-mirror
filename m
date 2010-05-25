From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [WIP PATCH] Add remote SVN helper
Date: Tue, 25 May 2010 19:00:18 +0200
Message-ID: <1274806818-10904-2-git-send-email-artagnon@gmail.com>
References: <1274806818-10904-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 25 18:59:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGxTa-0003ub-9X
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 18:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932721Ab0EYQ7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 12:59:19 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:46472 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932294Ab0EYQ7S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 12:59:18 -0400
Received: by mail-ew0-f216.google.com with SMTP id 8so604062ewy.28
        for <git@vger.kernel.org>; Tue, 25 May 2010 09:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=5ufTV2qmxCViNADSaBKckl4PB0L8c3+oFHpYzm6a8g4=;
        b=siVLQ0hAhfEmqMsGfns94MfMMCUAz9zK5W5oTBi1puwXeg1Mb7LWY4xgoTr9os3NF4
         U5OtTPrxj6NYhMe6F/qOiXay6u5pvunx3SJz0oxxxEpPphr28tqnvlfC/Fqq/ayfghO1
         K33kebt47pGZylQgeZKGZ7OkUQLYYNblRWpiw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vwiS2N8xq44ZWg/x3MukuE0jTKPEA21Rhq6yvirWhx+k5PrqWnVuieD60ZZMoUI9TC
         nJfbatxAc6Uj37AQfqTyNxIERtCpUf+cJbCQrqwGuK94R5LJMx+Pf+qRX7oglS1QC5G4
         bHjmBODX+Ul4aRLs1j2vy1zWUhfsSBSVo1X9k=
Received: by 10.213.10.16 with SMTP id n16mr611835ebn.2.1274806757298;
        Tue, 25 May 2010 09:59:17 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id 14sm2554810ewy.14.2010.05.25.09.59.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 25 May 2010 09:59:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1274806818-10904-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147716>

Add a remote helper for SVN that uses the exporter in vcs-svn/ with an
appropriate Makefile rule. For this to work, you must check out the
git-merge branch of svn-dump-fast-export [1] into vcs-svn/ and then
build git-remote-svn.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 .gitignore   |    1 +
 Makefile     |   14 ++++-
 remote-svn.c |  191 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 205 insertions(+), 1 deletions(-)
 create mode 100644 remote-svn.c

diff --git a/.gitignore b/.gitignore
index dbf1b90..6ac8a7c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -112,6 +112,7 @@
 /git-remote-https
 /git-remote-ftp
 /git-remote-ftps
+/git-remote-svn
 /git-repack
 /git-replace
 /git-repo-config
diff --git a/Makefile b/Makefile
index 4f7224a..fde0cdb 100644
--- a/Makefile
+++ b/Makefile
@@ -1746,6 +1746,14 @@ endif
 %.s: %.c GIT-CFLAGS FORCE
 	$(QUIET_CC)$(CC) -S $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
 
+vcs-svn/%.o: vcs-svn/%.c GIT-CFLAGS FORCE
+	$(QUIET_CC)$(CC) -o $@ -c $(dep_args) $(ALL_CFLAGS)	\
+	-I./vcs-svn $(EXTRA_CPPFLAGS) $<
+
+remote-svn.o: remote-svn.c $(GITLIBS) GIT-CFLAGS FORCE
+	$(QUIET_CC)$(CC) -o $@ -c $(dep_args) $(ALL_CFLAGS)	\
+	-I./vcs-svn $(EXTRA_CPPFLAGS) $<
+
 ifdef USE_COMPUTED_HEADER_DEPENDENCIES
 # Take advantage of gcc's on-the-fly dependency generation
 # See <http://gcc.gnu.org/gcc-3.0/features.html>.
@@ -1824,6 +1832,10 @@ $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
+git-remote-svn$X: remote-svn.o $(patsubst %.c,%.o,$(wildcard vcs-svn/*.c))
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+		$(LIBS)
+
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIB_OBJS)
 
@@ -2087,7 +2099,7 @@ distclean: clean
 
 clean:
 	$(RM) *.o block-sha1/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o \
-		builtin/*.o $(LIB_FILE) $(XDIFF_LIB)
+		builtin/*.o vcs-svn/*.o $(LIB_FILE) $(XDIFF_LIB)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) -r bin-wrappers
diff --git a/remote-svn.c b/remote-svn.c
new file mode 100644
index 0000000..def5b20
--- /dev/null
+++ b/remote-svn.c
@@ -0,0 +1,191 @@
+#include "cache.h"
+#include "strbuf.h"
+#include "remote.h"
+#include "strbuf.h"
+#include "exec_cmd.h"
+
+#include "svnclient.h"
+
+static struct remote *remote;
+
+struct options {
+	int verbosity;
+	unsigned long depth;
+	unsigned progress : 1,
+		dry_run : 1;
+};
+static struct options options;
+
+static int set_option(const char *name, const char *value)
+{
+	if (!strcmp(name, "verbosity")) {
+		char *end;
+		int v = strtol(value, &end, 10);
+		if (value == end || *end)
+			return -1;
+		options.verbosity = v;
+		return 0;
+	} else if (!strcmp(name, "progress")) {
+		if (!strcmp(value, "true"))
+			options.progress = 1;
+		else if (!strcmp(value, "false"))
+			options.progress = 0;
+		else
+			return -1;
+		return 0;
+	} else if (!strcmp(name, "dry-run")) {
+		if (!strcmp(value, "true"))
+			options.dry_run = 1;
+		else if (!strcmp(value, "false"))
+			options.dry_run = 0;
+		else
+			return -1;
+		return 0;
+	} else {
+		return 1;
+	}
+}
+
+static int export_handler(int nr_spec, char **specs)
+{
+	int err = 0;
+
+	/* TODO: The real exporting */
+        /* TODO: Write an importer for SVN */
+	
+	return err;
+}
+
+static int import_handler(int nr_spec, char **specs)
+{
+	int err = 0, i;
+	for (i = 0; i < nr_spec; i++)
+		FI_svn(specs[i]);
+	return err;
+}
+
+static void parse_import(struct strbuf *buf)
+{
+	char **specs = NULL;
+	int alloc_spec = 0, nr_spec = 0, i;
+
+	do {
+		if (!prefixcmp(buf->buf, "import ")) {
+			ALLOC_GROW(specs, nr_spec + 1, alloc_spec);
+			specs[nr_spec++] = xstrdup(buf->buf + 5);
+		}
+		else
+			die("remote helper does not support %s", buf->buf);
+
+		strbuf_reset(buf);
+		if (strbuf_getline(buf, stdin, '\n') == EOF)
+			return;
+		if (!*buf->buf)
+			break;
+	} while (1);
+
+	if (import_handler(nr_spec, specs))
+		exit(128); /* error already reported */
+	for (i = 0; i < nr_spec; i++)
+		free(specs[i]);
+	free(specs);
+
+	printf("\n");
+	fflush(stdout);
+}
+
+static void parse_export(struct strbuf *buf)
+{
+	char **specs = NULL;
+	int alloc_spec = 0, nr_spec = 0, i;
+
+	do {
+		if (!prefixcmp(buf->buf, "export ")) {
+			ALLOC_GROW(specs, nr_spec + 1, alloc_spec);
+			specs[nr_spec++] = xstrdup(buf->buf + 5);
+		} else
+			die("remote helper does not support %s", buf->buf);
+
+		strbuf_reset(buf);
+		if (strbuf_getline(buf, stdin, '\n') == EOF)
+			return;
+		if (!*buf->buf)
+			break;
+	} while (1);
+
+	if (export_handler(nr_spec, specs))
+		exit(128); /* error already reported */
+	for (i = 0; i < nr_spec; i++)
+		free(specs[i]);
+	free(specs);
+
+	printf("\n");
+	fflush(stdout);
+}
+
+int main(int argc, const char **argv)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int nongit;
+
+	git_extract_argv0_path(argv[0]);
+	setup_git_directory_gently(&nongit);
+	if (argc < 2) {
+		fprintf(stderr, "Remote needed\n");
+		return 1;
+	}
+
+	options.verbosity = 1;
+	options.progress = !!isatty(2);
+
+	remote = remote_get(argv[1]);
+
+	open_svn_connection(remote->url[0]);
+	do {
+		if (strbuf_getline(&buf, stdin, '\n') == EOF)
+			break;
+
+		else if (!strcmp(buf.buf, "list")) {
+			/* TODO: Code to list refs */
+			break;
+
+		} else if (!prefixcmp(buf.buf, "import ")) {
+			if (nongit)
+				die("Import attempted without a local repo");
+			parse_import(&buf);
+
+		} else if (!prefixcmp(buf.buf, "export ")) {
+			parse_export(&buf);
+
+		} else if (!prefixcmp(buf.buf, "option ")) {
+			char *name = buf.buf + strlen("option ");
+			char *value = strchr(name, ' ');
+			int result;
+			if (value)
+				*value++ = '\0';
+			else
+				value = "true";
+			result = set_option(name, value);
+			if (!result)
+				printf("ok\n");
+			else if (result < 0)
+				printf("error invalid value\n");
+			else
+				printf("unsupported\n");
+			fflush(stdout);
+
+		} else if (!strcmp(buf.buf, "capabilities")) {
+			printf("option\n");
+			printf("import\n");
+			printf("export\n");
+			printf("\n");
+			fflush(stdout);
+		} else
+			return 1;
+
+		strbuf_reset(&buf);
+	} while (1);
+
+	close_svn_connection();
+	return 0;
+}
-- 
1.7.1
