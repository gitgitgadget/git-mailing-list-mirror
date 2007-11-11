From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/6] git status: show relative paths when run in a subdirectory
Date: Sun, 11 Nov 2007 17:35:41 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711111735280.4362@racer.site>
References: <Pine.LNX.4.64.0711111730580.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, krh@redhat.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Nov 11 18:36:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrGjC-0005yQ-Gp
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 18:36:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756070AbXKKRfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 12:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755769AbXKKRfy
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 12:35:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:53364 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755437AbXKKRfx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 12:35:53 -0500
Received: (qmail invoked by alias); 11 Nov 2007 17:35:51 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp027) with SMTP; 11 Nov 2007 18:35:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19RLZ8EAgFRFYXFEefcYJXIoUfOfNjPD1EpS1jyaE
	Xqpt3s+X4Qdqzx
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0711111730580.4362@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64480>


To show the relative paths, the function formerly called quote_crlf()
(now called quote_path()) takes the prefix as an additional argument.

While at it, the static buffers were replaced by strbufs.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-commit.c    |   13 ++++---
 builtin-runstatus.c |    1 +
 t/t7502-status.sh   |   91 +++++++++++++++++++++++++++++++++++++++++++++++++++
 wt-status.c         |   69 ++++++++++++++++++++++++++-------------
 wt-status.h         |    1 +
 5 files changed, 146 insertions(+), 29 deletions(-)
 create mode 100755 t/t7502-status.sh

diff --git a/builtin-commit.c b/builtin-commit.c
index 6be6def..5c7d4df 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -118,11 +118,12 @@ static char *prepare_index(const char **files, const char *prefix)
 	return next_index_lock->filename;
 }
 
-static int run_status(FILE *fp, const char *index_file)
+static int run_status(FILE *fp, const char *index_file, const char *prefix)
 {
 	struct wt_status s;
 
 	wt_status_prepare(&s);
+	s.prefix = prefix;
 
 	if (amend) {
 		s.amend = 1;
@@ -140,7 +141,7 @@ static int run_status(FILE *fp, const char *index_file)
 
 static const char sign_off_header[] = "Signed-off-by: ";
 
-static int prepare_log_message(const char *index_file)
+static int prepare_log_message(const char *index_file, const char *prefix)
 {
 	struct stat statbuf;
 	int commitable;
@@ -216,7 +217,7 @@ static int prepare_log_message(const char *index_file)
 	if (only_include_assumed)
 		fprintf(fp, "# %s\n", only_include_assumed);
 
-	commitable = run_status(fp, index_file);
+	commitable = run_status(fp, index_file, prefix);
 
 	fclose(fp);
 
@@ -409,7 +410,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 
 	index_file = prepare_index(argv, prefix);
 
-	commitable = run_status(stdout, index_file);
+	commitable = run_status(stdout, index_file, prefix);
 
 	rollback_lock_file(&lock_file);
 
@@ -503,8 +504,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	if (!no_verify && run_hook(index_file, "pre-commit", NULL))
 		exit(1);
 
-	if (!prepare_log_message(index_file) && !in_merge) {
-		run_status(stdout, index_file);
+	if (!prepare_log_message(index_file, prefix) && !in_merge) {
+		run_status(stdout, index_file, prefix);
 		unlink(commit_editmsg);
 		return 1;
 	}
diff --git a/builtin-runstatus.c b/builtin-runstatus.c
index 2db25c8..8d167a9 100644
--- a/builtin-runstatus.c
+++ b/builtin-runstatus.c
@@ -14,6 +14,7 @@ int cmd_runstatus(int argc, const char **argv, const char *prefix)
 
 	git_config(git_status_config);
 	wt_status_prepare(&s);
+	s.prefix = prefix;
 
 	for (i = 1; i < argc; i++) {
 		if (!strcmp(argv[i], "--color"))
diff --git a/t/t7502-status.sh b/t/t7502-status.sh
new file mode 100755
index 0000000..269b334
--- /dev/null
+++ b/t/t7502-status.sh
@@ -0,0 +1,91 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Johannes E. Schindelin
+#
+
+test_description='git-status'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	: > tracked &&
+	: > modified &&
+	mkdir dir1 &&
+	: > dir1/tracked &&
+	: > dir1/modified &&
+	mkdir dir2 &&
+	: > dir1/tracked &&
+	: > dir1/modified &&
+	git add . &&
+	test_tick &&
+	git commit -m initial &&
+	: > untracked &&
+	: > dir1/untracked &&
+	: > dir2/untracked &&
+	echo 1 > dir1/modified &&
+	echo 2 > dir2/modified &&
+	echo 3 > dir2/added &&
+	git add dir2/added
+'
+
+cat > expect << \EOF
+# On branch master
+# Changes to be committed:
+#   (use "git reset HEAD <file>..." to unstage)
+#
+#	new file:   dir2/added
+#
+# Changed but not updated:
+#   (use "git add <file>..." to update what will be committed)
+#
+#	modified:   dir1/modified
+#
+# Untracked files:
+#   (use "git add <file>..." to include in what will be committed)
+#
+#	dir1/untracked
+#	dir2/modified
+#	dir2/untracked
+#	expect
+#	output
+#	untracked
+EOF
+
+test_expect_success 'status' '
+
+	git status > output &&
+	git diff expect output
+
+'
+
+cat > expect << \EOF
+# On branch master
+# Changes to be committed:
+#   (use "git reset HEAD <file>..." to unstage)
+#
+#	new file:   ../dir2/added
+#
+# Changed but not updated:
+#   (use "git add <file>..." to update what will be committed)
+#
+#	modified:   ../dir1/modified
+#
+# Untracked files:
+#   (use "git add <file>..." to include in what will be committed)
+#
+#	untracked
+#	../dir2/modified
+#	../dir2/untracked
+#	../expect
+#	../output
+#	../untracked
+EOF
+
+test_expect_success 'status with relative paths' '
+
+	(cd dir1 && git status) > output &&
+	git diff expect output
+
+'
+
+test_done
diff --git a/wt-status.c b/wt-status.c
index 03b5ec4..0d25362 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -82,33 +82,46 @@ static void wt_status_print_trailer(struct wt_status *s)
 	color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "#");
 }
 
-static const char *quote_crlf(const char *in, char *buf, size_t sz)
+static char *quote_path(const char *in, int len,
+		struct strbuf *out, const char *prefix)
 {
-	const char *scan;
-	char *out;
-	const char *ret = in;
+	if (len > 0)
+		strbuf_grow(out, len);
+	strbuf_setlen(out, 0);
+
+	if (prefix) {
+		int off = 0;
+		while (prefix[off] && off < len && prefix[off] == in[off])
+			if (prefix[off] == '/') {
+				prefix += off + 1;
+				in += off + 1;
+				len -= off + 1;
+				off = 0;
+			} else
+				off++;
+
+		for (; *prefix; prefix++)
+			if (*prefix == '/')
+				strbuf_addstr(out, "../");
+	}
 
-	for (scan = in, out = buf; *scan; scan++) {
-		int ch = *scan;
-		int quoted;
+	for (; (len < 0 && *in) || len > 0; in++, len--) {
+		int ch = *in;
 
 		switch (ch) {
 		case '\n':
-			quoted = 'n';
+			strbuf_addstr(out, "\\n");
 			break;
 		case '\r':
-			quoted = 'r';
+			strbuf_addstr(out, "\\r");
 			break;
 		default:
-			*out++ = ch;
+			strbuf_addch(out, ch);
 			continue;
 		}
-		*out++ = '\\';
-		*out++ = quoted;
-		ret = buf;
 	}
-	*out = '\0';
-	return ret;
+
+	return out->buf;
 }
 
 static void wt_status_print_filepair(struct wt_status *s,
@@ -116,10 +129,12 @@ static void wt_status_print_filepair(struct wt_status *s,
 {
 	const char *c = color(t);
 	const char *one, *two;
-	char onebuf[PATH_MAX], twobuf[PATH_MAX];
+	struct strbuf onebuf, twobuf;
 
-	one = quote_crlf(p->one->path, onebuf, sizeof(onebuf));
-	two = quote_crlf(p->two->path, twobuf, sizeof(twobuf));
+	strbuf_init(&onebuf, 0);
+	strbuf_init(&twobuf, 0);
+	one = quote_path(p->one->path, -1, &onebuf, s->prefix);
+	two = quote_path(p->two->path, -1, &twobuf, s->prefix);
 
 	color_fprintf(s->fp, color(WT_STATUS_HEADER), "#\t");
 	switch (p->status) {
@@ -151,6 +166,8 @@ static void wt_status_print_filepair(struct wt_status *s,
 		die("bug: unhandled diff status %c", p->status);
 	}
 	fprintf(s->fp, "\n");
+	strbuf_release(&onebuf);
+	strbuf_release(&twobuf);
 }
 
 static void wt_status_print_updated_cb(struct diff_queue_struct *q,
@@ -205,8 +222,9 @@ static void wt_read_cache(struct wt_status *s)
 static void wt_status_print_initial(struct wt_status *s)
 {
 	int i;
-	char buf[PATH_MAX];
+	struct strbuf buf;
 
+	strbuf_init(&buf, 0);
 	wt_read_cache(s);
 	if (active_nr) {
 		s->commitable = 1;
@@ -215,11 +233,12 @@ static void wt_status_print_initial(struct wt_status *s)
 	for (i = 0; i < active_nr; i++) {
 		color_fprintf(s->fp, color(WT_STATUS_HEADER), "#\t");
 		color_fprintf_ln(s->fp, color(WT_STATUS_UPDATED), "new file: %s",
-				quote_crlf(active_cache[i]->name,
-					   buf, sizeof(buf)));
+				quote_path(active_cache[i]->name, -1,
+					   &buf, s->prefix));
 	}
 	if (active_nr)
 		wt_status_print_trailer(s);
+	strbuf_release(&buf);
 }
 
 static void wt_status_print_updated(struct wt_status *s)
@@ -254,7 +273,9 @@ static void wt_status_print_untracked(struct wt_status *s)
 	const char *x;
 	int i;
 	int shown_header = 0;
+	struct strbuf buf;
 
+	strbuf_init(&buf, 0);
 	memset(&dir, 0, sizeof(dir));
 
 	dir.exclude_per_dir = ".gitignore";
@@ -291,9 +312,11 @@ static void wt_status_print_untracked(struct wt_status *s)
 			shown_header = 1;
 		}
 		color_fprintf(s->fp, color(WT_STATUS_HEADER), "#\t");
-		color_fprintf_ln(s->fp, color(WT_STATUS_UNTRACKED), "%.*s",
-				ent->len, ent->name);
+		color_fprintf_ln(s->fp, color(WT_STATUS_UNTRACKED), "%s",
+				quote_path(ent->name, ent->len,
+					&buf, s->prefix));
 	}
+	strbuf_release(&buf);
 }
 
 static void wt_status_print_verbose(struct wt_status *s)
diff --git a/wt-status.h b/wt-status.h
index 7744932..f58ebcb 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -23,6 +23,7 @@ struct wt_status {
 	int workdir_untracked;
 	const char *index_file;
 	FILE *fp;
+	const char *prefix;
 };
 
 int git_status_config(const char *var, const char *value);
-- 
1.5.3.5.1693.g26ed
