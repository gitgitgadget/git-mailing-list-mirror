From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/5] vcs-svn: Introduce svnload, a dumpfile producer
Date: Tue, 29 Mar 2011 23:43:11 +0530
Message-ID: <1301422392-21177-5-git-send-email-artagnon@gmail.com>
References: <1301422392-21177-1-git-send-email-artagnon@gmail.com>
Cc: Peter Baumann <waste.manager@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 29 20:15:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4dRg-0000eo-1P
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 20:15:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017Ab1C2SPD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 14:15:03 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39619 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444Ab1C2SPA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 14:15:00 -0400
Received: by ywj3 with SMTP id 3so186829ywj.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 11:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=jaghX8I3aB7etBxk8OfUeh7vT//BsF4Yi4csx/F96Kk=;
        b=q2T/52WFme8WBX7fYcV85ntpeOuzMx7SoLid8V+yazDL1ye1ZNz5vx7PwfSWJVvit7
         ivfUTsjUSAMwuN6ZoJ6BZpvad3V14R0j0z7VwqN/OqXK2xbZFQDfAidCWWkiNkUbjcEo
         QqRV1zHnJKmWYSpNJytqUhVHk+0qyVfaDF3kE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qON0x6rOz76/vt0u2jnyPNv556VAe68mm1Z6Ffsuqrg3btA9Ij+1Xl899cYtwluD+o
         eMkb7roRclBMYgn5UZIdPDget3Fnx4xuqutYO9VAaMlSQwbiO7Qj8uEaDTxwIse7x6OZ
         QtgWc6CBV0iRlHgfUT/vL14+IxDkeBJvQEv3A=
Received: by 10.150.239.4 with SMTP id m4mr444375ybh.402.1301422499867;
        Tue, 29 Mar 2011 11:14:59 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id o2sm1971669ybn.21.2011.03.29.11.14.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Mar 2011 11:14:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1301422392-21177-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170294>

Design-wise, svnload resembles svndump. Include a Makefile rule to
build it into vcs-svn/lib.a.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
I'm not very happy with the parse_data and parse_data_len API.  It's
probably too cryptic? See also: two skip_optional_lf() calls in the
parse_data function.  It seems to be necessary- is the fast-import
documentation wrong about one optional lf?

 Makefile              |    3 +-
 vcs-svn/dir_cache.c   |   52 ++++++
 vcs-svn/dir_cache.h   |   11 +
 vcs-svn/dump_export.c |  164 +++++++++++++++++
 vcs-svn/dump_export.h |   26 +++
 vcs-svn/svnload.c     |  485 +++++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/svnload.h     |   19 ++
 7 files changed, 759 insertions(+), 1 deletions(-)
 create mode 100644 vcs-svn/dir_cache.c
 create mode 100644 vcs-svn/dir_cache.h
 create mode 100644 vcs-svn/dump_export.c
 create mode 100644 vcs-svn/dump_export.h
 create mode 100644 vcs-svn/svnload.c
 create mode 100644 vcs-svn/svnload.h

diff --git a/Makefile b/Makefile
index b0f155a..7206d35 100644
--- a/Makefile
+++ b/Makefile
@@ -1838,7 +1838,8 @@ endif
 XDIFF_OBJS = xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o xdiff/xpatience.o
 VCSSVN_OBJS = vcs-svn/string_pool.o vcs-svn/line_buffer.o \
-	vcs-svn/repo_tree.o vcs-svn/fast_export.o vcs-svn/svndump.o
+	vcs-svn/repo_tree.o vcs-svn/fast_export.o vcs-svn/svndump.o \
+	vcs-svn/svnload.o vcs-svn/dump_export.o vcs-svn/dir_cache.o
 VCSSVN_TEST_OBJS = test-obj-pool.o test-string-pool.o \
 	test-line-buffer.o test-treap.o
 OBJECTS := $(GIT_OBJS) $(XDIFF_OBJS) $(VCSSVN_OBJS)
diff --git a/vcs-svn/dir_cache.c b/vcs-svn/dir_cache.c
new file mode 100644
index 0000000..551558a
--- /dev/null
+++ b/vcs-svn/dir_cache.c
@@ -0,0 +1,52 @@
+/*
+ * Licensed under a two-clause BSD-style license.
+ * See LICENSE for details.
+ */
+
+#include "cache.h"
+#include "git-compat-util.h"
+#include "string-list.h"
+#include "dir_cache.h"
+
+static struct string_list dirents = STRING_LIST_INIT_DUP;
+
+void dir_cache_add(const char *path, mode_t mode)
+{
+	struct string_list_item *dir;
+	dir = string_list_insert(&dirents, path);
+	dir->util = xmalloc(sizeof(uint16_t));
+	*((mode_t *)(dir->util)) = mode;
+}
+
+void dir_cache_remove(const char *path)
+{
+	struct string_list_item *dir;
+	dir = string_list_lookup(&dirents, path);
+	if (dir)
+		*((mode_t *)(dir->util)) = S_IFINVALID;
+}
+
+mode_t dir_cache_lookup(const char *path)
+{
+	struct string_list_item *dir;
+	dir = string_list_lookup(&dirents, path);
+	if (dir)
+		return *((mode_t *)(dir->util));
+	else
+		return S_IFINVALID;
+}
+
+void dir_cache_mkdir_p(const char *path) {
+	char *t, *p;
+
+	p = (char *) path;
+	while ((t = strchr(p, '/'))) {
+			*t = '\0';
+			if (dir_cache_lookup(path) == S_IFINVALID) {
+				dir_cache_add(path, S_IFDIR);
+				dump_export_mkdir(path);
+			}
+			*t = '/';   /* Change it back */
+			p = t + 1;
+	}
+}
diff --git a/vcs-svn/dir_cache.h b/vcs-svn/dir_cache.h
new file mode 100644
index 0000000..e7e83fb
--- /dev/null
+++ b/vcs-svn/dir_cache.h
@@ -0,0 +1,11 @@
+#ifndef DIR_CACHE_H_
+#define DIR_CACHE_H_
+
+#include "dump_export.h"
+
+void dir_cache_add(const char *path, mode_t mode);
+void dir_cache_remove(const char *path);
+mode_t dir_cache_lookup(const char *path);
+void dir_cache_mkdir_p(const char *path);
+
+#endif
diff --git a/vcs-svn/dump_export.c b/vcs-svn/dump_export.c
new file mode 100644
index 0000000..33ff852
--- /dev/null
+++ b/vcs-svn/dump_export.c
@@ -0,0 +1,164 @@
+/*
+ * Licensed under a two-clause BSD-style license.
+ * See LICENSE for details.
+ */
+
+#include "cache.h"
+#include "git-compat-util.h"
+#include "dump_export.h"
+#include "dir_cache.h"
+
+static struct strbuf props = STRBUF_INIT;
+static unsigned long revn = 0;
+
+/* Fills props and tells if the mode represents a file */
+static int populate_props(mode_t mode)
+{
+	int is_file = 1;
+
+	strbuf_reset(&props);
+	switch (mode) {
+	case S_IFINVALID:
+		break;
+	case 0644:
+	case S_IFREG | 0644:
+		break;
+	case 0755:
+	case S_IFREG | 0755:
+		strbuf_addf(&props, "K 14\nsvn:executable\nV 1\n*\n");
+		break;
+	case S_IFLNK:
+		strbuf_addf(&props, "K 11\nsvn:special\nV 1\n*\n");
+		break;
+	case S_IFGITLINK:
+		die("Gitlinks unsupported"); /* TODO */
+	case S_IFDIR:
+		is_file = 0;
+		break;
+	default:
+		die("Corrupt mode: %d", mode);
+	}
+	strbuf_add(&props, "PROPS-END\n", 10);
+	return is_file;
+}
+
+void dump_export_revision(struct strbuf *revprops)
+{
+	printf("Revision-number: %lu\n", ++ revn);
+	printf("Prop-content-length: %lu\n", revprops->len);
+	printf("Content-length: %lu\n\n", revprops->len);
+	printf("%s\n", revprops->buf);
+}
+
+static void dump_export_action(enum node_action action)
+{
+	switch (action) {
+	case NODE_ACTION_CHANGE:
+		printf("Node-action: change\n");
+		break;
+	case NODE_ACTION_ADD:
+		printf("Node-action: add\n");
+		break;
+	case NODE_ACTION_DELETE:
+		printf("Node-action: delete\n");
+		break;
+	case NODE_ACTION_REPLACE:
+		printf("Node-action: replace\n");
+		break;
+	default:
+		die("Corrupt action: %d", action);
+	}
+}
+
+void dump_export_node(const char *path, mode_t mode,
+		enum node_action action, size_t text_len,
+		const char *copyfrom_path)
+{
+	/* Node-path, Node-kind, and Node-action */
+	printf("Node-path: %s\n", path);
+	printf("Node-kind: %s\n", populate_props(mode) ? "file" : "dir");
+	dump_export_action(action);
+
+	if (copyfrom_path) {
+		printf("Node-copyfrom-rev: %lu\n", revn - 1);
+		printf("Node-copyfrom-path: %s\n", copyfrom_path);
+	}
+	if (props.len) {
+		printf("Prop-delta: false\n");
+		printf("Prop-content-length: %lu\n", props.len);
+	}
+	if (text_len) {
+		printf("Text-delta: false\n");
+		printf("Text-content-length: %lu\n", text_len);
+	}
+	if (text_len || props.len) {
+		printf("Content-length: %lu\n\n", text_len + props.len);
+		printf("%s", props.buf);
+	}
+
+	/* When no data is present, pad with two newlines */
+	if (!text_len)
+		printf("\n\n");
+}
+
+void dump_export_mkdir(const char *path)
+{
+	dump_export_node(path, S_IFDIR, NODE_ACTION_ADD, 0, NULL);
+}
+
+void dump_export_m(const char *path, mode_t mode, size_t text_len)
+{
+	enum node_action action = NODE_ACTION_CHANGE;
+	mode_t old_mode;
+
+	old_mode = dir_cache_lookup(path);
+
+	if (mode != old_mode) {
+		if (old_mode != S_IFINVALID) {
+			dump_export_d(path);
+			dir_cache_remove(path);
+		}
+		action = NODE_ACTION_ADD;
+		dir_cache_mkdir_p(path);
+		dir_cache_add(path, mode);
+	}
+
+	dump_export_node(path, mode, action, text_len, NULL);
+}
+
+void dump_export_d(const char *path)
+{
+	printf("Node-path: %s\n", path);
+	dump_export_action(NODE_ACTION_DELETE);
+	printf("\n\n");
+	dir_cache_remove(path);
+}
+
+void dump_export_cr(const char *path, const char *copyfrom_path,
+		int delete_old)
+{
+	enum node_action action = NODE_ACTION_REPLACE;
+	mode_t mode, old_mode;
+
+	mode = dir_cache_lookup(path);
+	old_mode = dir_cache_lookup(copyfrom_path);
+
+	if (old_mode == S_IFINVALID)
+		die("Can't copy from non-existant path: %s", copyfrom_path);
+	if (mode != old_mode) {
+		action = NODE_ACTION_ADD;
+		dir_cache_mkdir_p(path);
+		dir_cache_add(path, mode);
+	}
+	if (delete_old) {
+		dump_export_d(copyfrom_path);
+		dir_cache_remove(copyfrom_path);
+	}
+
+	dump_export_node(path, old_mode, action, 0, copyfrom_path);
+}
+
+void dump_export_init()
+{
+	printf("SVN-fs-dump-format-version: 3\n\n");
+}
diff --git a/vcs-svn/dump_export.h b/vcs-svn/dump_export.h
new file mode 100644
index 0000000..647701d
--- /dev/null
+++ b/vcs-svn/dump_export.h
@@ -0,0 +1,26 @@
+#ifndef DUMP_EXPORT_H_
+#define DUMP_EXPORT_H_
+
+#define MAX_GITSVN_LINE_LEN 4096
+#define SVN_INVALID_REV 0
+
+enum node_action {
+	NODE_ACTION_CHANGE,
+	NODE_ACTION_ADD,
+	NODE_ACTION_DELETE,
+	NODE_ACTION_REPLACE,
+	NODE_ACTION_COUNT
+};
+
+void dump_export_revision(struct strbuf *revprops);
+void dump_export_node(const char *path, mode_t mode,
+		enum node_action action, size_t text_len,
+		const char *copyfrom_path);
+void dump_export_mkdir(const char *path);
+void dump_export_m(const char *path, mode_t mode, size_t text_len);
+void dump_export_d(const char *path);
+void dump_export_cr(const char *path, const char *copyfrom_path,
+		int delete_old);
+void dump_export_init();
+
+#endif
diff --git a/vcs-svn/svnload.c b/vcs-svn/svnload.c
new file mode 100644
index 0000000..c07e475
--- /dev/null
+++ b/vcs-svn/svnload.c
@@ -0,0 +1,485 @@
+/*
+ * Produce a dumpfile v3 from a fast-import stream.
+ * Load the dump into the SVN repository with:
+ * svnrdump load <URL> <dumpfile
+ *
+ * Licensed under a two-clause BSD-style license.
+ * See LICENSE for details.
+ */
+
+#include "cache.h"
+#include "quote.h"
+#include "svnload.h"
+#include "dump_export.h"
+#include "dir_cache.h"
+
+static FILE *infile;
+static struct strbuf command_buf = STRBUF_INIT;
+static struct strbuf path_d = STRBUF_INIT;
+
+static int read_next_command(void)
+{
+	strbuf_reset(&command_buf);
+	return strbuf_getline(&command_buf, infile, '\n');
+}
+
+static void populate_revprops(struct strbuf *revprops,
+			struct ident *svn_ident, struct strbuf *log)
+{
+	strbuf_reset(revprops);
+	strbuf_addf(revprops, "K 10\nsvn:author\nV %lu\n%s\n",
+		svn_ident->name.len, svn_ident->name.buf);
+	strbuf_addf(revprops, "K 7\nsvn:log\nV %lu\n%s\n",
+		log->len, log->buf);
+	if (svn_ident->date)
+		/* SVN doesn't like an empty svn:date value */
+		strbuf_addf(revprops, "K 8\nsvn:date\nV %d\n%s\n",
+			SVN_DATE_LEN - 1, svn_ident->date);
+	strbuf_add(revprops, "PROPS-END\n", 10);
+}
+
+static void parse_ident(const char *buf, struct ident *identp)
+{
+	char *original_buf, *t, *tz_off;
+	int tz_off_buf;
+	const struct tm *tm_time;
+
+	/* John Doe <johndoe@email.com> 1170199019 +0530 */
+	strbuf_reset(&(identp->name));
+	strbuf_reset(&(identp->email));
+
+	original_buf = strdup(buf);
+	if (!(tz_off = strrchr(buf, ' ')))
+		goto error;
+	*tz_off++ = '\0';
+	if (!(t = strrchr(buf, ' ')))
+		goto error;
+	*(t - 1) = '\0'; /* Ignore '>' from email */
+	t++;
+	tz_off_buf = atoi(tz_off);
+
+	/* UTC -1200 to UTC +1400 are valid */
+	if (tz_off_buf > 1400 || tz_off_buf < -1200)
+		goto error;
+	tm_time = time_to_tm(strtoul(t, NULL, 10), tz_off_buf);
+	strftime(identp->date, SVN_DATE_LEN, SVN_DATE_FORMAT, tm_time);
+	if (!(t = strchr(buf, '<')))
+		goto error;
+	*(t - 1) = '\0'; /* Ignore ' <' from email */
+	t++;
+
+	strbuf_add(&(identp->email), t, strlen(t));
+	strbuf_add(&(identp->name), buf, strlen(buf));
+	free(original_buf);
+	return;
+error:
+	die("Malformed ident line: %s", original_buf);
+}
+
+static void skip_optional_lf(void)
+{
+	int term_char = fgetc(infile);
+	if (term_char != '\n' && term_char != EOF)
+		ungetc(term_char, infile);
+}
+
+/* Either sets term and returns terminator length or returns data
+   length after setting term to NULL */
+static size_t parse_data_len(char *term)
+{
+	uintmax_t length;
+
+	term = NULL;
+	if (prefixcmp(command_buf.buf, "data "))
+		die("Expected 'data n' command, found: %s", command_buf.buf);
+
+	if (!prefixcmp(command_buf.buf + 5, "<<")) {
+		term = xstrdup(command_buf.buf + 5 + 2);
+		if (!(command_buf.len - 5 - 2))
+			die("Missing delimeter after 'data <<' in: %s", command_buf.buf);
+		return (size_t) (command_buf.len - 5 - 2);
+	}
+
+	length = strtoumax(command_buf.buf + 5, NULL, 10);
+	if ((size_t) length < length)
+		die("Data is too large to use in this context");
+
+	return (size_t) length;
+}
+
+/* When term is filled in, nbytes refers to the size of the
+   terminator; otherwise, it refers to the size of the actual data.
+   The parsed data is written to dst and out, if they exist. */
+static void parse_data(char *term, size_t nbytes, struct strbuf *dst, FILE *out)
+{
+	size_t in;
+	size_t done = 0;
+
+	if (term) {
+		/* Read line-by-line until terminator is encountered */
+		while (1) {
+			if (read_next_command() == EOF)
+				die("Expected terminator '%s', found EOF", term);
+
+			/* If the terminator is encountered, stop reading */
+			if (nbytes == command_buf.len
+				&& !memcmp(term, command_buf.buf, nbytes))
+				break;
+
+			if (dst) {
+				strbuf_addbuf(dst, &command_buf);
+				strbuf_addch(dst, '\n');
+			}
+			if (out) {
+				strbuf_fwrite(&command_buf, command_buf.len, out);
+				fprintf(out, "\n");
+			}
+		}
+		free(term);
+		goto END;
+	}
+
+	/*  Read nbytes bytes in chunks */
+	while (done < nbytes && !feof(infile) && !ferror(infile)) {
+		in = (nbytes - done) < COPY_BUFFER_LEN ?
+			(nbytes - done) : COPY_BUFFER_LEN;
+		strbuf_reset(&command_buf);
+		in = strbuf_fread(&command_buf, in, infile);
+		done += in;
+		if (dst)
+			strbuf_addbuf(dst, &command_buf);
+		if (out)
+			strbuf_fwrite(&command_buf, command_buf.len, out);
+	}
+	if (done != nbytes)
+		die("Expected %lu bytes, read %lu bytes", nbytes, done);
+
+	if (out)
+		fprintf(out, "\n"); /* Hack: Incase data is not terminated with lf */
+END:
+	skip_optional_lf();
+	skip_optional_lf();
+}
+
+static const char *get_mode(const char *str, uint16_t *modep)
+{
+	unsigned char c;
+	uint16_t mode = 0;
+
+	while ((c = *str++) != ' ') {
+		if (c < '0' || c > '7')
+			return NULL;
+		mode = (mode << 3) + (c - '0');
+	}
+	*modep = mode;
+	return str;
+}
+
+static void file_change_m(const char *p)
+{
+	struct strbuf dst = STRBUF_INIT;
+	const char *endp;
+	uint16_t mode;
+	size_t nbytes;
+	char *term;
+
+	if (!p)
+		die("Missing mode after filemodify in: %s", command_buf.buf);
+
+	if (!(p = get_mode(p, &mode)))
+		die("Corrupt mode: %s", command_buf.buf);
+	if (!prefixcmp(p, "inline "))
+		p += 7;
+	else
+		die("Non-inlined data unsupported");
+
+	/* Parse out path into path_d */
+	strbuf_reset(&path_d);
+	if (!unquote_c_style(&path_d, p, &endp)) {
+		if (*endp)
+			die("Garbage after path in: %s", command_buf.buf);
+	} else
+		strbuf_addstr(&path_d, p);
+
+	read_next_command();
+	nbytes = parse_data_len(term);
+	if (term) {
+		strbuf_reset(&dst);
+		parse_data(term, nbytes, &dst, NULL);
+		dump_export_m(path_d.buf, mode, dst.len);
+		fwrite(&dst.buf, 1, dst.len, stdout);
+		return;
+	}
+	dump_export_m(path_d.buf, mode, nbytes);
+	parse_data(NULL, nbytes, NULL, stdout);
+}
+
+static void file_change_d(const char *p)
+{
+	const char *endp;
+
+	if (!p)
+		die("Missing path after filedelete in: %s", command_buf.buf);
+
+	strbuf_reset(&path_d);
+	if (!unquote_c_style(&path_d, p, &endp)) {
+		if (*endp)
+			die("Garbage after path in: %s", command_buf.buf);
+	} else
+		strbuf_addstr(&path_d, p);
+	dump_export_d(path_d.buf);
+}
+
+static void file_change_cr(const char *p, int delete_old)
+{
+	struct strbuf path_s = STRBUF_INIT;
+	const char *endp;
+
+	if (!p)
+		die("Missing source after %s in: %s",
+			delete_old ? "filerename" : "filecopy", command_buf.buf);
+
+	strbuf_reset(&path_s);
+	if (!unquote_c_style(&path_s, p, &endp)) {
+		if (*endp != ' ')
+			die("Missing destination after source in: %s", command_buf.buf);
+	} else {
+		endp = strchr(p, ' ');
+		if (!endp)
+			die("Missing destination after source in: %s", command_buf.buf);
+		strbuf_add(&path_s, p, endp - p);
+	}
+
+	endp++;
+	if (!*endp)
+		die("Missing destination in: %s", command_buf.buf);
+
+	p = endp;
+	strbuf_reset(&path_d);
+	if (!unquote_c_style(&path_d, p, &endp)) {
+		if (*endp)
+			die("Garbage after destination in: %s", command_buf.buf);
+	} else
+		strbuf_addstr(&path_d, p);
+
+	/* TODO: Check C "path/to/subdir" "" */
+	dump_export_cr(path_d.buf, path_s.buf, delete_old);
+}
+
+static void build_svn_ident(struct ident *svn_ident,
+			struct ident *author, struct ident *committer)
+{
+	char *t, *email;
+
+	strbuf_reset(&(svn_ident->name));
+	memcpy(svn_ident->date, committer->date, SVN_DATE_LEN);
+	email = author->email.len ? author->email.buf : committer->email.buf;
+	if ((t = strchr(email, '@')))
+		strbuf_add(&(svn_ident->name), email, t - email);
+	else
+		strbuf_addstr(&(svn_ident->name), email);
+}
+
+static void parse_ignore_notemodify(const char *p)
+{
+	char *term;
+	size_t nbytes;
+
+	if (!p)
+		die("Missing dataref after notemodify in: %s", command_buf.buf);
+	if (!(p = strchr(p, ' ')))
+		die ("Missing committish after dataref in: %s", command_buf.buf);
+
+	read_next_command();
+	term = NULL;
+	nbytes = parse_data_len(term);
+	parse_data(term, nbytes, NULL, NULL);
+}
+
+static void parse_commit(const char *p)
+{
+	static struct strbuf log = STRBUF_INIT;
+	static struct strbuf revprops = STRBUF_INIT;
+	static struct ident author = {STRBUF_INIT, STRBUF_INIT, ""};
+	static struct ident committer = {STRBUF_INIT, STRBUF_INIT, ""};
+	static struct ident svn_ident = {STRBUF_INIT, {0, 0, NULL}, ""};
+
+	char *ident_buf, *term;
+	size_t nbytes;
+
+	/* TODO: Parse and use branch */
+	if (!p)
+		die("Missing ref after commit in: %s", command_buf.buf);
+	read_next_command();
+
+	/* Parse and ignore mark line */
+	if (!prefixcmp(command_buf.buf, "mark :"))
+		read_next_command();
+
+	if (!prefixcmp(command_buf.buf, "author ")) {
+		ident_buf = strbuf_detach(&command_buf, &command_buf.len);
+		parse_ident(ident_buf + 7, &author);
+		free(ident_buf);
+		read_next_command();
+	}
+	if (!prefixcmp(command_buf.buf, "committer ")) {
+		ident_buf = strbuf_detach(&command_buf, &command_buf.len);
+		parse_ident(ident_buf + 10, &committer);
+		free(ident_buf);
+		read_next_command();
+	}
+	if (!committer.name.len)
+		die("Missing committer line in stream");
+
+	/* Parse the log */
+	strbuf_reset(&log);
+	term = NULL;
+	nbytes = parse_data_len(term);
+	parse_data(term, nbytes, &log, NULL);
+	read_next_command();
+
+	if (!prefixcmp(command_buf.buf, "from "))
+		/* TODO: Support copyfrom */
+		read_next_command();
+	while (!prefixcmp(command_buf.buf, "merge "))
+		/* TODO: Support merges */
+		read_next_command();
+
+	/* Translation from Git metadata to SVN metadata */
+	build_svn_ident(&svn_ident, &author, &committer);
+	populate_revprops(&revprops, &svn_ident, &log);
+	dump_export_revision(&revprops);
+
+	do {
+		if (!prefixcmp(command_buf.buf, "M "))
+			file_change_m(command_buf.buf + 2);
+		else if (!prefixcmp(command_buf.buf, "D "))
+			file_change_d(command_buf.buf + 2);
+		else if (!prefixcmp(command_buf.buf, "R "))
+			file_change_cr(command_buf.buf + 2, 1);
+		else if (!prefixcmp(command_buf.buf, "C "))
+			file_change_cr(command_buf.buf + 2, 0);
+		else if (!prefixcmp(command_buf.buf, "N "))
+			parse_ignore_notemodify(command_buf.buf + 2);
+		else if (!prefixcmp(command_buf.buf, "ls "))
+			goto error; /* TODO */
+		else if (!strcmp("deleteall", command_buf.buf))
+			goto error; /* TODO */
+		else
+			/* Unrecognized command is left on command_buf */
+			break;
+	} while (read_next_command() != EOF);
+
+	/* Eat up optional trailing lf */
+	if (!command_buf.len)
+		read_next_command();
+	return;
+error:
+	die("Unsupported command: %s", command_buf.buf);
+}
+
+static void parse_tag(const char *p)
+{
+	char *term;
+	size_t nbytes;
+
+	if (!p)
+		die("Missing name after tag in: %s", command_buf.buf);
+	read_next_command();
+
+	if (prefixcmp(command_buf.buf, "from "))
+		die("Expected 'from committish', found: %s", command_buf.buf);
+	p = command_buf.buf + 5;
+	if (!p)
+		die("Missing committish after from in: %s", command_buf.buf);
+	read_next_command();
+
+	if (prefixcmp(command_buf.buf, "tagger "))
+		die("Expected 'tagger (name?) email when', found: %s", command_buf.buf);
+	p = command_buf.buf + 7;
+	if (*p != '<')
+		p = strchr(p, '<');
+	if (!p)
+		die("Missing name or email after tagger in: %s", command_buf.buf);
+	if (!(p = strchr(p, '>')))
+		die("Malformed email in: %s", command_buf.buf);
+	if (!(++ p))
+		die("Missing when after email in: %s", command_buf.buf);
+	read_next_command();
+
+	term = NULL;
+	nbytes = parse_data_len(term);
+	parse_data(term, nbytes, NULL, NULL);
+	read_next_command();
+}
+
+void parse_reset_branch(const char *p)
+{
+	if (!p)
+		die("Missing ref after reset in: %s", command_buf.buf);
+	read_next_command();
+
+	if (!prefixcmp(command_buf.buf, "from ")) {
+		p = command_buf.buf + 5;
+		if (!p)
+			die("Missing committish after from in: %s", command_buf.buf);
+		read_next_command();
+	}
+
+	skip_optional_lf();
+}
+
+void svnload_read(void)
+{
+	read_next_command();
+
+	/* Every function in the loop keeps reading until it
+	   encounteres EOF or an unrecognized command; the
+	   unrecognized command is left on command_buf */
+	while (!feof(infile)) {
+		if (!strcmp("blob", command_buf.buf))
+			die("Non-inlined blobs unsupported");
+		else if (!prefixcmp(command_buf.buf, "ls "))
+			goto error; /* TODO */
+		else if (!prefixcmp(command_buf.buf, "cat-blob "))
+			goto error; /* TODO */
+		else if (!prefixcmp(command_buf.buf, "commit "))
+			parse_commit(command_buf.buf + 7);
+		else if (!prefixcmp(command_buf.buf, "tag "))
+			/* TODO: No-op */
+			parse_tag(command_buf.buf + 4);
+		else if (!prefixcmp(command_buf.buf, "reset "))
+			/* TODO: No-op */
+			parse_reset_branch(command_buf.buf + 6);
+		else if (!strcmp(command_buf.buf, "checkpoint")
+			|| !prefixcmp(command_buf.buf, "progress ")) {
+			/* Ignored */
+			read_next_command();
+			skip_optional_lf();
+		}
+		else if (!prefixcmp(command_buf.buf, "feature ")
+			|| !prefixcmp(command_buf.buf, "option "))
+			/* Ignored */
+			read_next_command();
+		else
+			goto error;
+	};
+	return;
+error:
+	die("Unsupported command: %s", command_buf.buf);
+}
+
+int svnload_init(const char *filename)
+{
+	infile = filename ? fopen(filename, "r") : stdin;
+	if (!infile)
+		die("Cannot open %s: %s", filename, strerror(errno));
+	dump_export_init();
+	return 0;
+}
+
+void svnload_deinit(void)
+{
+	strbuf_release(&command_buf);
+	strbuf_release(&path_d);
+}
diff --git a/vcs-svn/svnload.h b/vcs-svn/svnload.h
new file mode 100644
index 0000000..12bb559
--- /dev/null
+++ b/vcs-svn/svnload.h
@@ -0,0 +1,19 @@
+#ifndef SVNLOAD_H_
+#define SVNLOAD_H_
+
+#include "strbuf.h"
+
+#define SVN_DATE_FORMAT "%Y-%m-%dT%H:%M:%S.000000Z"
+#define SVN_DATE_LEN 28
+#define COPY_BUFFER_LEN 4096
+
+struct ident {
+	struct strbuf name, email;
+	char date[SVN_DATE_LEN];
+};
+
+int svnload_init(const char *filename);
+void svnload_deinit(void);
+void svnload_read(void);
+
+#endif
-- 
1.7.4.rc1.7.g2cf08.dirty
