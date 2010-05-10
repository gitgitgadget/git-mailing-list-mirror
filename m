From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [WIP PATCH] Add skeleton remote helper for SVN
Date: Mon, 10 May 2010 13:39:34 +0200
Message-ID: <1273491574-31870-2-git-send-email-artagnon@gmail.com>
References: <1273491574-31870-1-git-send-email-artagnon@gmail.com>
Cc: srabbelier@gmail.com
To: Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 10 13:38:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBRJi-0001ME-Ns
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 13:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756692Ab0EJLiY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 07:38:24 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:50392 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754053Ab0EJLiW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 07:38:22 -0400
Received: by mail-ew0-f220.google.com with SMTP id 20so863231ewy.1
        for <git@vger.kernel.org>; Mon, 10 May 2010 04:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=YAwEVl331Viy18GnnZEO8KowPG2KKJV5sggpuTLZgW4=;
        b=bnhtYx+6Bowio+f4CZzlk2XBglJ/uIu2hlR9sVGrSgbaghZRkWFkvwumIfjnITfATi
         946lVgq5wZatVQRWIWm1z0I6xRP2oJf0s5fb+C1cXjEHexiby+sa8iFJYvRrIjjqoq/B
         ZoMgG5EZ3JIzeIyKPPwRkf67iULM9BG0EkDXc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=buvEfe6/mM8gG7C5dOOHHsmvU2Gjo4cy5xT7TOelBpK8cYylaLP+hvL21gtwUlJx2R
         H/tVapG8EJY4T4088lEo3XB/uuQBgkc47/TR5euS0oDxWt53qAUdJQ06ScyQdAbl2TPB
         VyBFaOi1kGplHkd+QyfOWYjWLCie4iP3EQb/w=
Received: by 10.213.66.5 with SMTP id l5mr1506453ebi.71.1273491502145;
        Mon, 10 May 2010 04:38:22 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id 15sm2474900ewy.0.2010.05.10.04.38.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 04:38:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1273491574-31870-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146801>

Create remote-svn.c, which is essentially a stripped-down version of
remote-curl.c to build the SVN remote helper upon. Also add a Makefile
rule to build it.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Makefile     |    6 ++-
 remote-svn.c |  202 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 207 insertions(+), 1 deletions(-)
 create mode 100644 remote-svn.c

diff --git a/Makefile b/Makefile
index 4f7224a..06b969f 100644
--- a/Makefile
+++ b/Makefile
@@ -1658,7 +1658,7 @@ git.o git.spec \
 
 TEST_OBJS := $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))
 GIT_OBJS := $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS) \
-	git.o http.o http-walker.o remote-curl.o
+	git.o http.o http-walker.o remote-curl.o remote-svn.o
 XDIFF_OBJS = xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o xdiff/xpatience.o
 OBJECTS := $(GIT_OBJS) $(XDIFF_OBJS)
@@ -1824,6 +1824,10 @@ $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
+git-remote-svn$X: remote-svn.o $(GITLIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@	\
+		$(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
+
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIB_OBJS)
 
diff --git a/remote-svn.c b/remote-svn.c
new file mode 100644
index 0000000..dafbd6a
--- /dev/null
+++ b/remote-svn.c
@@ -0,0 +1,202 @@
+#include "cache.h"
+#include "strbuf.h"
+#include "remote.h"
+#include "strbuf.h"
+
+static struct remote *remote;
+static const char *url;
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
+	}
+	else if (!strcmp(name, "progress")) {
+		if (!strcmp(value, "true"))
+			options.progress = 1;
+		else if (!strcmp(value, "false"))
+			options.progress = 0;
+		else
+			return -1;
+		return 0;
+	}
+	else if (!strcmp(name, "dry-run")) {
+		if (!strcmp(value, "true"))
+			options.dry_run = 1;
+		else if (!strcmp(value, "false"))
+			options.dry_run = 0;
+		else
+			return -1;
+		return 0;
+	}
+	else {
+		return 1;
+	}
+}
+
+static int export_handler(int nr_spec, char **specs)
+{
+	int err = 0;
+
+	// TODO: The real exporting
+        // TODO: Write an importer for SVN
+	
+	return err;
+}
+
+static int import_handler(int nr_spec, char **specs)
+{
+	int err = 0;
+	
+	// TODO: The real importing
+	// TODO: Hook up an SVN exporter's fast-export stream
+
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
+	// git_extract_argv0_path(argv[0]);
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
+	if (argc > 2) {
+		url = argv[2];
+	} else {
+		url = remote->url[0];
+	}
+
+	// open_svn_connection(remote);
+	do {
+		if (strbuf_getline(&buf, stdin, '\n') == EOF)
+			break;
+
+		else if (!strcmp(buf.buf, "list")) {
+			// TODO: Code to list refs
+			break;
+
+		} else if (!prefixcmp(buf.buf, "import ")) {
+			if (nongit)
+				die("Import attempted without a local repo");
+
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
+	// close_svn_connection(remote);
+	return 0;
+}
-- 
1.7.1
