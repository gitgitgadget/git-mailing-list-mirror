From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 08/10] SVN dump parser
Date: Mon, 9 Aug 2010 17:55:00 -0500
Message-ID: <20100809225500.GD4429@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino>
 <20100809215719.GA4203@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 10 00:56:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OibGx-00047Q-B9
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 00:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756103Ab0HIW4h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Aug 2010 18:56:37 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48170 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755055Ab0HIW4g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 18:56:36 -0400
Received: by vws3 with SMTP id 3so7134505vws.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 15:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=0icosbEcuXbIDNBM6oXcCgHmAQwZVFO0Hr7T+oKV9YE=;
        b=eXuQpC/P46vBrBxdubMZ5hSvnvHkBZu0xy7BEZn/GgEk4/4edj41L6/mGkaR70Gfjc
         ZMj97GFIB/3jCbsfyVWc0KjiPo9c+E8zNMGMyr0Ts0g1DSl2lWad+Xr3+P2Iiy8zgE6t
         Vx3nnO+zhWTS0dYeGLHtg77pylY5dOitFJR7c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Et1eC2xSvPVFkr1vUOk7Kc3UALTyeF1I/Sf5U9DctiuX3QyiaqYGxNI3CRqtCGw4QM
         s/bT1l04FzHAx7QKXt/Q+nYNKk/c/W1+2xedqzg3uPirsgjLeRrl9KZwecHK5RNsDhRH
         EbMN6U4BDR5/DQ2LwEPfcD6WcUPo9MGujsDms=
Received: by 10.220.128.138 with SMTP id k10mr9930579vcs.256.1281394594995;
        Mon, 09 Aug 2010 15:56:34 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id e18sm1162338vcf.36.2010.08.09.15.56.31
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Aug 2010 15:56:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100809215719.GA4203@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153045>

=46rom: David Barr <david.barr@cordelta.com>

svndump parses data that is in SVN dumpfile format produced by
`svnadmin dump` with the help of line_buffer and uses repo_tree and
fast_export to emit a git fast-import stream.

Based roughly on com.hydrografix.svndump 0.92 from the SvnToCCase
project at <http://svn2cc.sarovar.org/>, by Stefan Hegny and
others.

[rr: allow input from files other than stdin]
[jn: with test, more error reporting]

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
New test.  It is slow; work by svn gurus to speed this up would
be nice.  The test program is very similar to svn-fe from contrib,
except it exercises Ram=E2=80=99s change to read from a file other than
stdin.

 .gitignore              |    1 +
 Makefile                |    8 +-
 contrib/svn-fe/svn-fe.c |    1 +
 t/t9010-svn-fe.sh       |   32 +++++
 test-svn-fe.c           |   18 +++
 vcs-svn/LICENSE         |    4 +
 vcs-svn/svndump.c       |  302 +++++++++++++++++++++++++++++++++++++++=
++++++++
 vcs-svn/svndump.h       |    9 ++
 8 files changed, 373 insertions(+), 2 deletions(-)
 create mode 100644 t/t9010-svn-fe.sh
 create mode 100644 test-svn-fe.c
 create mode 100644 vcs-svn/svndump.c
 create mode 100644 vcs-svn/svndump.h

diff --git a/.gitignore b/.gitignore
index 8c0512e..258723f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -175,6 +175,7 @@
 /test-sha1
 /test-sigchain
 /test-string-pool
+/test-svn-fe
 /test-treap
 /common-cmds.h
 *.tar.gz
diff --git a/Makefile b/Makefile
index b873399..6228f66 100644
--- a/Makefile
+++ b/Makefile
@@ -417,6 +417,7 @@ TEST_PROGRAMS_NEED_X +=3D test-run-command
 TEST_PROGRAMS_NEED_X +=3D test-sha1
 TEST_PROGRAMS_NEED_X +=3D test-sigchain
 TEST_PROGRAMS_NEED_X +=3D test-string-pool
+TEST_PROGRAMS_NEED_X +=3D test-svn-fe
 TEST_PROGRAMS_NEED_X +=3D test-treap
 TEST_PROGRAMS_NEED_X +=3D test-index-version
=20
@@ -1745,7 +1746,7 @@ endif
 XDIFF_OBJS =3D xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xe=
mit.o \
 	xdiff/xmerge.o xdiff/xpatience.o
 VCSSVN_OBJS =3D vcs-svn/string_pool.o vcs-svn/line_buffer.o \
-	vcs-svn/repo_tree.o vcs-svn/fast_export.o
+	vcs-svn/repo_tree.o vcs-svn/fast_export.o vcs-svn/svndump.o
 OBJECTS :=3D $(GIT_OBJS) $(XDIFF_OBJS) $(VCSSVN_OBJS)
=20
 dep_files :=3D $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
@@ -1870,7 +1871,8 @@ xdiff-interface.o $(XDIFF_OBJS): \
=20
 $(VCSSVN_OBJS): \
 	vcs-svn/obj_pool.h vcs-svn/trp.h vcs-svn/string_pool.h \
-	vcs-svn/line_buffer.h vcs-svn/repo_tree.h vcs-svn/fast_export.h
+	vcs-svn/line_buffer.h vcs-svn/repo_tree.h vcs-svn/fast_export.h \
+	vcs-svn/svndump.h
 endif
=20
 exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS =3D \
@@ -2025,6 +2027,8 @@ test-parse-options$X: parse-options.o
=20
 test-string-pool$X: vcs-svn/lib.a
=20
+test-svn-fe$X: vcs-svn/lib.a
+
 .PRECIOUS: $(TEST_OBJS)
=20
 test-%$X: test-%.o $(GITLIBS)
diff --git a/contrib/svn-fe/svn-fe.c b/contrib/svn-fe/svn-fe.c
index e9b9ba4..a2677b0 100644
--- a/contrib/svn-fe/svn-fe.c
+++ b/contrib/svn-fe/svn-fe.c
@@ -10,6 +10,7 @@ int main(int argc, char **argv)
 {
 	svndump_init(NULL);
 	svndump_read((argc > 1) ? argv[1] : NULL);
+	svndump_deinit();
 	svndump_reset();
 	return 0;
 }
diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
new file mode 100644
index 0000000..bf9bbd6
--- /dev/null
+++ b/t/t9010-svn-fe.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+
+test_description=3D'check svn dumpfile importer'
+
+. ./lib-git-svn.sh
+
+test_dump() {
+	label=3D$1
+	dump=3D$2
+	test_expect_success "$dump" '
+		svnadmin create "$label-svn" &&
+		svnadmin load "$label-svn" < "$TEST_DIRECTORY/$dump" &&
+		svn_cmd export "file://$(pwd)/$label-svn" "$label-svnco" &&
+		git init "$label-git" &&
+		test-svn-fe "$TEST_DIRECTORY/$dump" >"$label.fe" &&
+		(
+			cd "$label-git" &&
+			git fast-import < ../"$label.fe"
+		) &&
+		(
+			cd "$label-svnco" &&
+			git init &&
+			git add . &&
+			git fetch "../$label-git" master &&
+			git diff --exit-code FETCH_HEAD
+		)
+	'
+}
+
+test_dump simple t9111/svnsync.dump
+
+test_done
diff --git a/test-svn-fe.c b/test-svn-fe.c
new file mode 100644
index 0000000..616a474
--- /dev/null
+++ b/test-svn-fe.c
@@ -0,0 +1,18 @@
+/*
+ * test-svn-fe: Code to exercise the svn import lib
+ */
+
+#include "git-compat-util.h"
+#include "vcs-svn/svndump.h"
+
+int main(int argc, char *argv[])
+{
+	if (argc !=3D 2)
+		usage("test-svn-fe <file>");
+	svndump_init(argv[1]);
+	svndump_read(NULL);
+	svndump_deinit();
+	svndump_reset();
+	return 0;
+}
+
diff --git a/vcs-svn/LICENSE b/vcs-svn/LICENSE
index a3d384c..0a5e3c4 100644
--- a/vcs-svn/LICENSE
+++ b/vcs-svn/LICENSE
@@ -4,6 +4,10 @@ All rights reserved.
 Copyright (C) 2008 Jason Evans <jasone@canonware.com>.
 All rights reserved.
=20
+Copyright (C) 2005 Stefan Hegny, hydrografix Consulting GmbH,
+Frankfurt/Main, Germany
+and others, see http://svn2cc.sarovar.org
+
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions
 are met:
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
new file mode 100644
index 0000000..630eeb5
--- /dev/null
+++ b/vcs-svn/svndump.c
@@ -0,0 +1,302 @@
+/*
+ * Parse and rearrange a svnadmin dump.
+ * Create the dump with:
+ * svnadmin dump --incremental -r<startrev>:<endrev> <repository> >out=
file
+ *
+ * Licensed under a two-clause BSD-style license.
+ * See LICENSE for details.
+ */
+
+#include "cache.h"
+#include "repo_tree.h"
+#include "fast_export.h"
+#include "line_buffer.h"
+#include "obj_pool.h"
+#include "string_pool.h"
+
+#define NODEACT_REPLACE 4
+#define NODEACT_DELETE 3
+#define NODEACT_ADD 2
+#define NODEACT_CHANGE 1
+#define NODEACT_UNKNOWN 0
+
+#define DUMP_CTX 0
+#define REV_CTX  1
+#define NODE_CTX 2
+
+#define LENGTH_UNKNOWN (~0)
+#define DATE_RFC2822_LEN 31
+
+/* Create memory pool for log messages */
+obj_pool_gen(log, char, 4096)
+
+static char* log_copy(uint32_t length, char *log)
+{
+	char *buffer;
+	log_free(log_pool.size);
+	buffer =3D log_pointer(log_alloc(length));
+	strncpy(buffer, log, length);
+	return buffer;
+}
+
+static struct {
+	uint32_t action, propLength, textLength, srcRev, srcMode, mark, type;
+	uint32_t src[REPO_MAX_PATH_DEPTH], dst[REPO_MAX_PATH_DEPTH];
+} node_ctx;
+
+static struct {
+	uint32_t revision, author;
+	unsigned long timestamp;
+	char *log;
+} rev_ctx;
+
+static struct {
+	uint32_t uuid, url;
+} dump_ctx;
+
+static struct {
+	uint32_t svn_log, svn_author, svn_date, svn_executable, svn_special, =
uuid,
+		revision_number, node_path, node_kind, node_action,
+		node_copyfrom_path, node_copyfrom_rev, text_content_length,
+		prop_content_length, content_length;
+} keys;
+
+static void reset_node_ctx(char *fname)
+{
+	node_ctx.type =3D 0;
+	node_ctx.action =3D NODEACT_UNKNOWN;
+	node_ctx.propLength =3D LENGTH_UNKNOWN;
+	node_ctx.textLength =3D LENGTH_UNKNOWN;
+	node_ctx.src[0] =3D ~0;
+	node_ctx.srcRev =3D 0;
+	node_ctx.srcMode =3D 0;
+	pool_tok_seq(REPO_MAX_PATH_DEPTH, node_ctx.dst, "/", fname);
+	node_ctx.mark =3D 0;
+}
+
+static void reset_rev_ctx(uint32_t revision)
+{
+	rev_ctx.revision =3D revision;
+	rev_ctx.timestamp =3D 0;
+	rev_ctx.log =3D NULL;
+	rev_ctx.author =3D ~0;
+}
+
+static void reset_dump_ctx(uint32_t url)
+{
+	dump_ctx.url =3D url;
+	dump_ctx.uuid =3D ~0;
+}
+
+static void init_keys(void)
+{
+	keys.svn_log =3D pool_intern("svn:log");
+	keys.svn_author =3D pool_intern("svn:author");
+	keys.svn_date =3D pool_intern("svn:date");
+	keys.svn_executable =3D pool_intern("svn:executable");
+	keys.svn_special =3D pool_intern("svn:special");
+	keys.uuid =3D pool_intern("UUID");
+	keys.revision_number =3D pool_intern("Revision-number");
+	keys.node_path =3D pool_intern("Node-path");
+	keys.node_kind =3D pool_intern("Node-kind");
+	keys.node_action =3D pool_intern("Node-action");
+	keys.node_copyfrom_path =3D pool_intern("Node-copyfrom-path");
+	keys.node_copyfrom_rev =3D pool_intern("Node-copyfrom-rev");
+	keys.text_content_length =3D pool_intern("Text-content-length");
+	keys.prop_content_length =3D pool_intern("Prop-content-length");
+	keys.content_length =3D pool_intern("Content-length");
+}
+
+static void read_props(void)
+{
+	uint32_t len;
+	uint32_t key =3D ~0;
+	char *val =3D NULL;
+	char *t;
+	while ((t =3D buffer_read_line()) && strcmp(t, "PROPS-END")) {
+		if (!strncmp(t, "K ", 2)) {
+			len =3D atoi(&t[2]);
+			key =3D pool_intern(buffer_read_string(len));
+			buffer_read_line();
+		} else if (!strncmp(t, "V ", 2)) {
+			len =3D atoi(&t[2]);
+			val =3D buffer_read_string(len);
+			if (key =3D=3D keys.svn_log) {
+				/* Value length excludes terminating nul. */
+				rev_ctx.log =3D log_copy(len + 1, val);
+			} else if (key =3D=3D keys.svn_author) {
+				rev_ctx.author =3D pool_intern(val);
+			} else if (key =3D=3D keys.svn_date) {
+				if (parse_date_basic(val, &rev_ctx.timestamp, NULL))
+					fprintf(stderr, "Invalid timestamp: %s\n", val);
+			} else if (key =3D=3D keys.svn_executable) {
+				node_ctx.type =3D REPO_MODE_EXE;
+			} else if (key =3D=3D keys.svn_special) {
+				node_ctx.type =3D REPO_MODE_LNK;
+			}
+			key =3D ~0;
+			buffer_read_line();
+		}
+	}
+}
+
+static void handle_node(void)
+{
+	if (node_ctx.propLength !=3D LENGTH_UNKNOWN && node_ctx.propLength)
+		read_props();
+
+	if (node_ctx.srcRev)
+		node_ctx.srcMode =3D repo_copy(node_ctx.srcRev, node_ctx.src, node_c=
tx.dst);
+
+	if (node_ctx.textLength !=3D LENGTH_UNKNOWN &&
+	    node_ctx.type !=3D REPO_MODE_DIR)
+		node_ctx.mark =3D next_blob_mark();
+
+	if (node_ctx.action =3D=3D NODEACT_DELETE) {
+		repo_delete(node_ctx.dst);
+	} else if (node_ctx.action =3D=3D NODEACT_CHANGE ||
+			   node_ctx.action =3D=3D NODEACT_REPLACE) {
+		if (node_ctx.action =3D=3D NODEACT_REPLACE &&
+		    node_ctx.type =3D=3D REPO_MODE_DIR)
+			repo_replace(node_ctx.dst, node_ctx.mark);
+		else if (node_ctx.propLength !=3D LENGTH_UNKNOWN)
+			repo_modify(node_ctx.dst, node_ctx.type, node_ctx.mark);
+		else if (node_ctx.textLength !=3D LENGTH_UNKNOWN)
+			node_ctx.srcMode =3D repo_replace(node_ctx.dst, node_ctx.mark);
+	} else if (node_ctx.action =3D=3D NODEACT_ADD) {
+		if (node_ctx.srcRev && node_ctx.propLength !=3D LENGTH_UNKNOWN)
+			repo_modify(node_ctx.dst, node_ctx.type, node_ctx.mark);
+		else if (node_ctx.srcRev && node_ctx.textLength !=3D LENGTH_UNKNOWN)
+			node_ctx.srcMode =3D repo_replace(node_ctx.dst, node_ctx.mark);
+		else if ((node_ctx.type =3D=3D REPO_MODE_DIR && !node_ctx.srcRev) ||
+			 node_ctx.textLength !=3D LENGTH_UNKNOWN)
+			repo_add(node_ctx.dst, node_ctx.type, node_ctx.mark);
+	}
+
+	if (node_ctx.propLength =3D=3D LENGTH_UNKNOWN && node_ctx.srcMode)
+		node_ctx.type =3D node_ctx.srcMode;
+
+	if (node_ctx.mark)
+		fast_export_blob(node_ctx.type, node_ctx.mark, node_ctx.textLength);
+	else if (node_ctx.textLength !=3D LENGTH_UNKNOWN)
+		buffer_skip_bytes(node_ctx.textLength);
+}
+
+static void handle_revision(void)
+{
+	if (rev_ctx.revision)
+		repo_commit(rev_ctx.revision, rev_ctx.author, rev_ctx.log,
+			dump_ctx.uuid, dump_ctx.url, rev_ctx.timestamp);
+}
+
+void svndump_read(const char *url)
+{
+	char *val;
+	char *t;
+	uint32_t active_ctx =3D DUMP_CTX;
+	uint32_t len;
+	uint32_t key;
+
+	reset_dump_ctx(pool_intern(url));
+	while ((t =3D buffer_read_line())) {
+		val =3D strstr(t, ": ");
+		if (!val)
+			continue;
+		*val++ =3D '\0';
+		*val++ =3D '\0';
+		key =3D pool_intern(t);
+
+		if (key =3D=3D keys.uuid) {
+			dump_ctx.uuid =3D pool_intern(val);
+		} else if (key =3D=3D keys.revision_number) {
+			if (active_ctx =3D=3D NODE_CTX)
+				handle_node();
+			if (active_ctx !=3D DUMP_CTX)
+				handle_revision();
+			active_ctx =3D REV_CTX;
+			reset_rev_ctx(atoi(val));
+		} else if (key =3D=3D keys.node_path) {
+			if (active_ctx =3D=3D NODE_CTX)
+				handle_node();
+			active_ctx =3D NODE_CTX;
+			reset_node_ctx(val);
+		} else if (key =3D=3D keys.node_kind) {
+			if (!strcmp(val, "dir"))
+				node_ctx.type =3D REPO_MODE_DIR;
+			else if (!strcmp(val, "file"))
+				node_ctx.type =3D REPO_MODE_BLB;
+			else
+				fprintf(stderr, "Unknown node-kind: %s\n", val);
+		} else if (key =3D=3D keys.node_action) {
+			if (!strcmp(val, "delete")) {
+				node_ctx.action =3D NODEACT_DELETE;
+			} else if (!strcmp(val, "add")) {
+				node_ctx.action =3D NODEACT_ADD;
+			} else if (!strcmp(val, "change")) {
+				node_ctx.action =3D NODEACT_CHANGE;
+			} else if (!strcmp(val, "replace")) {
+				node_ctx.action =3D NODEACT_REPLACE;
+			} else {
+				fprintf(stderr, "Unknown node-action: %s\n", val);
+				node_ctx.action =3D NODEACT_UNKNOWN;
+			}
+		} else if (key =3D=3D keys.node_copyfrom_path) {
+			pool_tok_seq(REPO_MAX_PATH_DEPTH, node_ctx.src, "/", val);
+		} else if (key =3D=3D keys.node_copyfrom_rev) {
+			node_ctx.srcRev =3D atoi(val);
+		} else if (key =3D=3D keys.text_content_length) {
+			node_ctx.textLength =3D atoi(val);
+		} else if (key =3D=3D keys.prop_content_length) {
+			node_ctx.propLength =3D atoi(val);
+		} else if (key =3D=3D keys.content_length) {
+			len =3D atoi(val);
+			buffer_read_line();
+			if (active_ctx =3D=3D REV_CTX) {
+				read_props();
+			} else if (active_ctx =3D=3D NODE_CTX) {
+				handle_node();
+				active_ctx =3D REV_CTX;
+			} else {
+				fprintf(stderr, "Unexpected content length header: %d\n", len);
+				buffer_skip_bytes(len);
+			}
+		}
+	}
+	if (active_ctx =3D=3D NODE_CTX)
+		handle_node();
+	if (active_ctx !=3D DUMP_CTX)
+		handle_revision();
+}
+
+void svndump_init(const char *filename)
+{
+	buffer_init(filename);
+	repo_init();
+	reset_dump_ctx(~0);
+	reset_rev_ctx(0);
+	reset_node_ctx(NULL);
+	init_keys();
+}
+
+void svndump_deinit(void)
+{
+	log_reset();
+	repo_reset();
+	reset_dump_ctx(~0);
+	reset_rev_ctx(0);
+	reset_node_ctx(NULL);
+	if (buffer_deinit())
+		fprintf(stderr, "Input error\n");
+	if (ferror(stdout))
+		fprintf(stderr, "Output error\n");
+}
+
+void svndump_reset(void)
+{
+	log_reset();
+	buffer_reset();
+	repo_reset();
+	reset_dump_ctx(~0);
+	reset_rev_ctx(0);
+	reset_node_ctx(NULL);
+}
diff --git a/vcs-svn/svndump.h b/vcs-svn/svndump.h
new file mode 100644
index 0000000..93c412f
--- /dev/null
+++ b/vcs-svn/svndump.h
@@ -0,0 +1,9 @@
+#ifndef SVNDUMP_H_
+#define SVNDUMP_H_
+
+void svndump_init(const char *filename);
+void svndump_read(const char *url);
+void svndump_deinit(void);
+void svndump_reset(void);
+
+#endif
--=20
1.7.2.1.544.ga752d.dirty
