From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 8/8] vcs-svn: Implement text-delta handling
Date: Sat, 20 Nov 2010 13:29:28 -0600
Message-ID: <20101120192928.GI17823@burratino>
References: <20101118050023.GA14861@burratino>
 <20101120004525.GA17445@burratino>
 <20101120192153.GA17823@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 20 20:29:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJt81-0003Ck-VM
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 20:29:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754809Ab0KTT3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Nov 2010 14:29:37 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:51130 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753Ab0KTT3g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Nov 2010 14:29:36 -0500
Received: by gwb20 with SMTP id 20so636694gwb.19
        for <git@vger.kernel.org>; Sat, 20 Nov 2010 11:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=EXAB75Uv5RZi8agEFuYZVDdA9RRhmzkXKGHgmn0Y1XE=;
        b=QJsVFVGFlZamXJM4UMG/HoyfwQwfgvvg2X5AejSP3ndRbaVxqqUeNUIlRVEjRN9UOM
         7etcLT03WbY8LgRkeQ8j8SZgj07qYbl5b8Wz3y9St5AZIxk+OpHJKdC2k6o+AsUIj4in
         FzGDUclzgA/es+QofF1iNtsWCb+n08pO15B5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=i79+KYt+KYFoLSeMqRlQ7FfeTZOge/a8gkO8RwUkIkyACwhm45uPI5rKnm03gxzVGQ
         yB1rukIS0gmpLOdEAu6IGzRbQIUT8r5KD6YRazEgmf+xu93B63ah3fGhidDGUDJGU0+x
         xBJFjaffdiZu8oV1ooc+Ily9Fq9YlVr63rSQQ=
Received: by 10.91.42.23 with SMTP id u23mr4724366agj.67.1290281376008;
        Sat, 20 Nov 2010 11:29:36 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id i64sm1989040yha.10.2010.11.20.11.29.33
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Nov 2010 11:29:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101120192153.GA17823@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161838>

From: David Barr <david.barr@cordelta.com>

Handle input in Subversion's dumpfile format, version 3.  This is the
format produced by "svnrdump dump" and "svnadmin dump --deltas", and
the main difference between v3 dumpfiles and the dumpfiles already
handled is that these can include nodes whose properties and text are
expressed relative to some other node.

To handle such nodes, we find which node the text and properties are
based on, handle its property changes, use the cat-blob command to
request the basis blob from the fast-import backend, use the
svndiff0_apply() helper to apply the text delta on the fly, writing
output to a temporary file, and then measure that postimage file's
length and write its content to the fast-import stream.

The temporary postimage file is shared between delta-using nodes to
avoid some file system overhead.

The svn-fe interface needs to be more complicated to accomodate the
backward flow of information from the fast-import backend to svn-fe.
The interface for parsing streams without deltas is unchanged,
though.

NEEDSWORK: generalize interface so caller sets the backflow fd, close
temporary file before exiting

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/svn-fe/svn-fe.txt |   11 ++++--
 t/t9010-svn-fe.sh         |   16 +++++++-
 vcs-svn/fast_export.c     |   88 +++++++++++++++++++++++++++++++-------------
 vcs-svn/fast_export.h     |    3 ++
 vcs-svn/svndump.c         |   19 +++++++---
 5 files changed, 99 insertions(+), 38 deletions(-)

diff --git a/contrib/svn-fe/svn-fe.txt b/contrib/svn-fe/svn-fe.txt
index 35f84bd..6af989f 100644
--- a/contrib/svn-fe/svn-fe.txt
+++ b/contrib/svn-fe/svn-fe.txt
@@ -7,7 +7,13 @@ svn-fe - convert an SVN "dumpfile" to a fast-import stream
 
 SYNOPSIS
 --------
-svnadmin dump --incremental REPO | svn-fe [url] | git fast-import
+svnadmin dump REPO | svn-fe [url] | git fast-import
+
+[verse]
+mkfifo backchannel &&
+svnadmin dump --deltas REPO |
+	svn-fe [url] 3<backchannel |
+	git fast-import --cat-blob-fd=3 3>backchannel
 
 DESCRIPTION
 -----------
@@ -25,9 +31,6 @@ Subversion's repository dump format is documented in full in
 Files in this format can be generated using the 'svnadmin dump' or
 'svk admin dump' command.
 
-Dumps produced with 'svnadmin dump --deltas' (dumpfile format v3)
-are not supported.
-
 OUTPUT FORMAT
 -------------
 The fast-import format is documented by the git-fast-import(1)
diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index 7dc0670..6c8b803 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -35,6 +35,14 @@ text_no_props () {
 
 >empty
 
+test_expect_success 'setup: have pipes?' '
+	rm -f frob &&
+	if mkfifo frob
+	then
+		test_set_prereq PIPE
+	fi
+'
+
 test_expect_success 'empty dump' '
 	reinit_git &&
 	echo "SVN-fs-dump-format-version: 2" >input &&
@@ -451,7 +459,9 @@ test_expect_success 'change file mode and reiterate content' '
 	test_cmp hello actual.target
 '
 
-test_expect_success 'deltas not supported' '
+test_expect_success PIPE 'deltas supported' '
+	reinit_git &&
+	rm -f backflow &&
 	{
 		# (old) h + (inline) ello + (old) \n
 		printf "SVNQ%b%b%s" "Q\003\006\005\004" "\001Q\0204\001\002" "ello" |
@@ -511,7 +521,9 @@ test_expect_success 'deltas not supported' '
 		echo PROPS-END &&
 		cat delta
 	} >delta.dump &&
-	test_must_fail test-svn-fe delta.dump
+	mkfifo backflow &&
+	test_must_fail test-svn-fe delta.dump 3<backflow |
+	git fast-import --cat-blob-fd=3 3>backflow
 '
 
 test_expect_success 'property deltas supported' '
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index ebaab72..ceb1fc5 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -5,9 +5,11 @@
 
 #include "git-compat-util.h"
 #include "fast_export.h"
+#include "repo_tree.h"
+#include "svndiff.h"
+#include "sliding_window.h"
 #include "line_buffer.h"
 #include "fd_buffer.h"
-#include "repo_tree.h"
 #include "string_pool.h"
 #include "strbuf.h"
 
@@ -15,6 +17,17 @@
 #define REPORT_FILENO 3
 
 static uint32_t first_commit_done;
+static struct line_buffer postimage = LINE_BUFFER_INIT;
+
+/* NEEDSWORK: move to fast_export_init() */
+static int init_postimage(void)
+{
+	static int postimage_initialized;
+	if (postimage_initialized)
+		return 0;
+	postimage_initialized = 1;
+	return buffer_tmpfile_init(&postimage);
+}
 
 void fast_export_delete(uint32_t depth, uint32_t *path)
 {
@@ -102,33 +115,39 @@ static const char *get_response_line(void)
 	return response_line.buf;
 }
 
-static int copy_bytes(FILE *out, off_t len)
+static long apply_delta(uint32_t mark, off_t len, struct line_buffer *input,
+			uint32_t old_mark, uint32_t old_mode)
 {
-	off_t ret = fd_copy_bytes(out, REPORT_FILENO, len);
-	if (!ret)
-		return error("read error: file ends early");
-	if (ret <= 0)
-		return error("cannot copy cat-blob result");
-	return 0;
-}
+	long ret;
+	struct view preimage = {REPORT_FILENO, 0, STRBUF_INIT};
+	FILE *out;
 
-static int fast_export_save_blob(FILE *out)
-{
-	off_t len = len;
-	const char *header, *tail;
-
-	header = get_response_line();
-	if (!header || parse_cat_response_line(header, &len))
-		return -1;
-	copy_bytes(out, len);
-
-	/* Discard trailing newline. */
-	tail = get_response_line();
-	if (!tail)
-		return -1;
-	if (*tail)
-		return error("line following cat-blob response contains garbage: %s", tail);
-	return 0;
+	if (init_postimage() || !(out = buffer_tmpfile_rewind(&postimage)))
+		die("cannot open temporary file for blob retrieval");
+	if (old_mark) {
+		const char *response;
+		off_t dummy;
+		printf("cat-blob :%"PRIu32"\n", old_mark);
+		fflush(stdout);
+		response = get_response_line();
+		/* Not necessary, just for robustness */
+		if (parse_cat_response_line(response, &dummy))
+			die("invalid cat-blob response: %s", response);
+	}
+	if (old_mode == REPO_MODE_LNK)
+		strbuf_addstr(&preimage.buf, "link ");
+	if (svndiff0_apply(input, len, &preimage, out))
+		die("cannot apply delta");
+	if (old_mark) {
+		/* Discard trailing newline from cat-blob-fd. */
+		const char *tail = get_response_line();
+		if (!tail || *tail)
+			die("missing newline after cat-blob response");
+	}
+	ret = buffer_tmpfile_prepare_to_read(&postimage);
+	if (ret < 0)
+		die("cannot read temporary file for blob retrieval");
+	return ret;
 }
 
 void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len, struct line_buffer *input)
@@ -142,3 +161,20 @@ void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len, struct line_bu
 	buffer_copy_bytes(input, len);
 	fputc('\n', stdout);
 }
+
+void fast_export_blob_delta(uint32_t mode, uint32_t mark,
+				uint32_t old_mode, uint32_t old_mark,
+				uint32_t len, struct line_buffer *input)
+{
+	long postimage_len;
+	if (len > maximum_signed_value_of_type(off_t))
+		die("enormous delta");
+	postimage_len = apply_delta(mark, (off_t) len, input, old_mark, old_mode);
+	if (mode == REPO_MODE_LNK) {
+		buffer_skip_bytes(&postimage, strlen("link "));
+		postimage_len -= strlen("link ");
+	}
+	printf("blob\nmark :%"PRIu32"\ndata %ld\n", mark, postimage_len);
+	buffer_copy_bytes(&postimage, postimage_len);
+	fputc('\n', stdout);
+}
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
index 054e7d5..6f77c3b 100644
--- a/vcs-svn/fast_export.h
+++ b/vcs-svn/fast_export.h
@@ -10,5 +10,8 @@ void fast_export_commit(uint32_t revision, uint32_t author, char *log,
 			uint32_t uuid, uint32_t url, unsigned long timestamp);
 void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len,
 		      struct line_buffer *input);
+void fast_export_blob_delta(uint32_t mode, uint32_t mark,
+			uint32_t old_mode, uint32_t old_mark,
+			uint32_t len, struct line_buffer *input);
 
 #endif
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 3e7fb9b..a6c849e 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -198,12 +198,10 @@ static void read_props(void)
 
 static void handle_node(void)
 {
-	uint32_t mark = 0;
+	uint32_t mark = 0, old_mode, old_mark;
 	const uint32_t type = node_ctx.type;
 	const int have_props = node_ctx.propLength != LENGTH_UNKNOWN;
 
-	if (node_ctx.text_delta)
-		die("text deltas not supported");
 	if (node_ctx.textLength != LENGTH_UNKNOWN)
 		mark = next_blob_mark();
 	if (node_ctx.action == NODEACT_DELETE) {
@@ -224,7 +222,9 @@ static void handle_node(void)
 	if (mark && type == REPO_MODE_DIR)
 		die("invalid dump: directories cannot have text attached");
 	if (node_ctx.action == NODEACT_CHANGE) {
-		uint32_t mode = repo_modify_path(node_ctx.dst, 0, mark);
+		uint32_t mode;
+		old_mark = repo_read_path(node_ctx.dst);
+		mode = repo_modify_path(node_ctx.dst, 0, mark);
 		if (!mode)
 			die("invalid dump: path to be modified is missing");
 		if (mode == REPO_MODE_DIR && type != REPO_MODE_DIR)
@@ -236,11 +236,12 @@ static void handle_node(void)
 		if (!mark && type != REPO_MODE_DIR)
 			die("invalid dump: adds node without text");
 		repo_add(node_ctx.dst, type, mark);
+		old_mark = 0;
 	} else {
 		die("invalid dump: Node-path block lacks Node-action");
 	}
+	old_mode = node_ctx.type;
 	if (have_props) {
-		const uint32_t old_mode = node_ctx.type;
 		if (!node_ctx.prop_delta)
 			node_ctx.type = type;
 		if (node_ctx.propLength)
@@ -248,8 +249,14 @@ static void handle_node(void)
 		if (node_ctx.type != old_mode)
 			repo_modify_path(node_ctx.dst, node_ctx.type, mark);
 	}
-	if (mark)
+	if (!mark)
+		return;
+	if (!node_ctx.text_delta) {
 		fast_export_blob(node_ctx.type, mark, node_ctx.textLength, &input);
+		return;
+	}
+	fast_export_blob_delta(node_ctx.type, mark, old_mode, old_mark,
+				node_ctx.textLength, &input);
 }
 
 static void handle_revision(void)
-- 
1.7.2.3
