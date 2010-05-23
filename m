From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [WIP PATCH 1/7] Add skeleton remote helper for SVN
Date: Sun, 23 May 2010 23:40:26 +0200
Message-ID: <1274650832-7411-2-git-send-email-artagnon@gmail.com>
References: <1274650832-7411-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 23 23:39:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGItN-0004R9-Ii
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 23:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755336Ab0EWVjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 May 2010 17:39:15 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40688 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754973Ab0EWVjM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 May 2010 17:39:12 -0400
Received: by wyb29 with SMTP id 29so1098038wyb.19
        for <git@vger.kernel.org>; Sun, 23 May 2010 14:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=acfxrWQMAK/Ga18RFiLAMx5i3LGAFzOsPraopbwk3nk=;
        b=An5kK26OBlD0Y+pfj6b2M4Xm2wZwBAKAhpGI65UqvsP8wK9C4jKUO0DJr+Ypsk11QT
         Ujujyb0Zv+JCziTGJKov8TetyW6I8XYez8a93s7aLvyUxP7BDHZ29DUrH8sXQTwpuuE4
         Inle5/l/h8CkwtAhjHLRancghnNO5kWSFzUbs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hVX3Mto78dJAVQnDOoSoJW72My0FyYrK/Q4EGDetvM7bZio0vkxmr36xUMPGVAPh29
         YPOgLTDPKgsOxAuZE91Myl77Z7ddWhvk6N1uZ+i4qBxm5Bz9UgET/xu7MWOHfeaBbcYa
         lm1iJLumhKeXgKMtq2QQEggCXhfj2tEvoFRMQ=
Received: by 10.216.87.82 with SMTP id x60mr2760368wee.173.1274650750611;
        Sun, 23 May 2010 14:39:10 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id 13sm1622104ewy.1.2010.05.23.14.39.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 May 2010 14:39:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1274650832-7411-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147590>

Create remote-svn.c, which is essentially a stripped-down version of
remote-curl.c to build the SVN remote helper upon. Also add a Makefile
rule to build it.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Makefile            |    9 ++-
 remote-svn.c        |  201 +++++++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/svnclient.c |   20 +++++
 vcs-svn/svnclient.h |    7 ++
 4 files changed, 236 insertions(+), 1 deletions(-)
 create mode 100644 remote-svn.c
 create mode 100644 vcs-svn/svnclient.c
 create mode 100644 vcs-svn/svnclient.h

diff --git a/Makefile b/Makefile
index 4f7224a..91077a8 100644
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
@@ -1746,6 +1746,9 @@ endif
 %.s: %.c GIT-CFLAGS FORCE
 	$(QUIET_CC)$(CC) -S $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
 
+remote-svn.o: remote-svn.c GIT-CFLAGS FORCE
+	$(QUIET_CC)$(CC) -S $(ALL_CFLAGS) -I./vcs-svn $(EXTRA_CPPFLAGS) $<
+
 ifdef USE_COMPUTED_HEADER_DEPENDENCIES
 # Take advantage of gcc's on-the-fly dependency generation
 # See <http://gcc.gnu.org/gcc-3.0/features.html>.
@@ -1824,6 +1827,10 @@ $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o $(GITLIBS)
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
index 0000000..69d09c7
--- /dev/null
+++ b/remote-svn.c
@@ -0,0 +1,201 @@
+#include "cache.h"
+#include "strbuf.h"
+#include "remote.h"
+#include "strbuf.h"
+#include "exec_cmd.h"
+
+#include "svnclient.h"
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
+	int err = 0;
+	
+	/* TODO: The real importing */
+	/* TODO: Hook up an SVN exporter's fast-export stream */
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
+	if (argc > 2) {
+		url = argv[2];
+	} else {
+		url = remote->url[0];
+	}
+
+	open_svn_connection(remote);
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
+	close_svn_connection(remote);
+	return 0;
+}
diff --git a/vcs-svn/svnclient.c b/vcs-svn/svnclient.c
new file mode 100644
index 0000000..2a3ca44
--- /dev/null
+++ b/vcs-svn/svnclient.c
@@ -0,0 +1,20 @@
+int open_svn_connection(struct remote *remote)
+{
+        /* TODO: Open connection to remote */
+}
+
+int close_svn_connection(struct remote *remote)
+{
+        /* TODO: Close connection */
+}
+
+int FI_svn (unsigned char *sha1, const char *ref)
+{
+        /* TODO: Hook up fast-export stream from SVN exporter */
+}
+
+int FE_svn (unsigned char *sha1, const char *ref)
+{
+        /* TODO: Write a fast-import module for SVN to import from the
+           Git fast-export stream */
+}
diff --git a/vcs-svn/svnclient.h b/vcs-svn/svnclient.h
new file mode 100644
index 0000000..ecd5e8b
--- /dev/null
+++ b/vcs-svn/svnclient.h
@@ -0,0 +1,7 @@
+#ifndef SVNCLIENT_H
+#define SVNCLIENT_H
+
+int open_svn_connection(struct remote *remote);
+int close_svn_connection(struct remote *remote);
+
+#endif
-- 
1.7.1
