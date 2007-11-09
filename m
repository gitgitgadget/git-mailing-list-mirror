From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH REPLACEMENT for 2/2] git status: show relative paths when
 run in a subdirectory
Date: Fri, 9 Nov 2007 15:30:52 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711091529570.4362@racer.site>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com>
 <Pine.LNX.4.64.0711072242230.4362@racer.site>
 <9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com>
 <Pine.LNX.4.64.0711072255420.4362@racer.site>
 <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com>
 <243E1E6E-4723-42D3-933C-D2A0D1ACE287@silverinsanity.com>
 <ee77f5c20711071531q5acc4d06u264f5daad7c04cc4@mail.gmail.com>
 <Pine.LNX.4.64.0711080011170.4362@racer.site> <7v8x593zyv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Symonds <dsymonds@gmail.com>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>, gitster@pobox.com
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 16:31:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqVpJ-0007mK-UM
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 16:31:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760349AbXKIPbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 10:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760432AbXKIPbF
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 10:31:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:57178 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760358AbXKIPbD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 10:31:03 -0500
Received: (qmail invoked by alias); 09 Nov 2007 15:31:01 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp054) with SMTP; 09 Nov 2007 16:31:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/0/dQ3WJr0LemYHmyfBYu/Di6GoD+t9aL64V35Qf
	e7fPAOj402HoGl
X-X-Sender: gene099@racer.site
In-Reply-To: <7v8x593zyv.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64200>


To show the relative paths, the function formerly called quote_crlf()
(now called quote_path()) takes the prefix as an additional argument.

While at it, the static buffers were replaced by strbufs.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Thu, 8 Nov 2007, Junio C Hamano wrote:

	> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
	> 
	> > -static const char *quote_crlf(const char *in, char *buf, size_t sz)
	> > +static const char *quote_crlf(const char *in, int len, char *buf, size_t sz,
	> > +	const char *prefix)
	> >  {
	> 
	> This is not quote_*crlf* anymore.
	> 
	> > @@ -118,8 +150,8 @@ static void wt_status_print_filepair(struct wt_status *s,
	> >  	const char *one, *two;
	> >  	char onebuf[PATH_MAX], twobuf[PATH_MAX];
	> >  
	> > -	one = quote_crlf(p->one->path, onebuf, sizeof(onebuf));
	> > -	two = quote_crlf(p->two->path, twobuf, sizeof(twobuf));
	> > +	one = quote_crlf(p->one->path, -1, onebuf, sizeof(onebuf), s->prefix);
	> > +	two = quote_crlf(p->two->path, -1, twobuf, sizeof(twobuf), s->prefix);
	> 
	> I wonder if it makes more sense to use strbuf here...

	Here you are.

 builtin-runstatus.c |    1 +
 t/t7502-status.sh   |   91 +++++++++++++++++++++++++++++++++++++++++++++++++++
 wt-status.c         |   69 ++++++++++++++++++++++++++-------------
 wt-status.h         |    1 +
 4 files changed, 139 insertions(+), 23 deletions(-)
 create mode 100755 t/t7502-status.sh

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
1.5.3.5.1645.g1f4df
