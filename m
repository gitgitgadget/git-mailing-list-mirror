From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 16/16] vcs-svn: implement text-delta handling
Date: Sat, 19 Mar 2011 18:20:54 +1100
Message-ID: <1300519254-20201-17-git-send-email-david.barr@cordelta.com>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
 <1300519254-20201-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 19 08:22:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0qUR-0007jt-Ou
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 08:22:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756154Ab1CSHWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 03:22:14 -0400
Received: from [119.15.97.146] ([119.15.97.146]:62036 "EHLO mailhost.cordelta"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753948Ab1CSHVe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 03:21:34 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id A9769C040;
	Sat, 19 Mar 2011 18:18:00 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gCiS2atTe8GX; Sat, 19 Mar 2011 18:17:49 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id A37A5C05D;
	Sat, 19 Mar 2011 18:17:43 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <1300519254-20201-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169411>

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
The backflow fd is not needed when parsing streams without deltas,
though, so existing scripts using svn-fe on v2 dumps should
continue to work.

NEEDSWORK: generalize interface so caller sets the backflow fd, close
temporary file before exiting

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
---
 contrib/svn-fe/svn-fe.txt |    5 +--
 t/t9010-svn-fe.sh         |  108 +++++++++++++++++++++++++++++++++++++++++++-
 vcs-svn/fast_export.c     |  109 ++++++++++++++++++++++++++++++++++++++++++++-
 vcs-svn/fast_export.h     |    3 +
 vcs-svn/svndump.c         |   13 ++++--
 5 files changed, 227 insertions(+), 11 deletions(-)

diff --git a/contrib/svn-fe/svn-fe.txt b/contrib/svn-fe/svn-fe.txt
index 85f7b83..2dd27ce 100644
--- a/contrib/svn-fe/svn-fe.txt
+++ b/contrib/svn-fe/svn-fe.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 mkfifo backchannel &&
-svnadmin dump --incremental REPO |
+svnadmin dump --deltas REPO |
 	svn-fe [url] 3<backchannel |
 	git fast-import --cat-blob-fd=3 3>backchannel
 
@@ -32,9 +32,6 @@ Subversion's repository dump format is documented in full in
 Files in this format can be generated using the 'svnadmin dump' or
 'svk admin dump' command.
 
-Dumps produced with 'svnadmin dump --deltas' (dumpfile format v3)
-are not supported.
-
 OUTPUT FORMAT
 -------------
 The fast-import format is documented by the git-fast-import(1)
diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index 720fd6b..cd7a215 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -568,7 +568,7 @@ test_expect_success PIPE 'change file mode and reiterate content' '
 	test_cmp hello actual.target
 '
 
-test_expect_success PIPE 'deltas not supported' '
+test_expect_success PIPE 'deltas supported' '
 	reinit_git &&
 	{
 		# (old) h + (inline) ello + (old) \n
@@ -629,7 +629,7 @@ test_expect_success PIPE 'deltas not supported' '
 		echo PROPS-END &&
 		cat delta
 	} >delta.dump &&
-	test_must_fail try_dump delta.dump
+	try_dump delta.dump
 '
 
 test_expect_success PIPE 'property deltas supported' '
@@ -836,6 +836,110 @@ test_expect_success PIPE 'deltas for typechange' '
 	test_cmp expect actual
 '
 
+test_expect_success PIPE 'deltas need not consume the whole preimage' '
+	reinit_git &&
+	cat >expect <<-\EOF &&
+	OBJID
+	:120000 100644 OBJID OBJID T	postimage
+	OBJID
+	:100644 120000 OBJID OBJID T	postimage
+	OBJID
+	:000000 100644 OBJID OBJID A	postimage
+	EOF
+	echo "first preimage" >expect.1 &&
+	printf target >expect.2 &&
+	printf lnk >expect.3 &&
+	{
+		printf "SVNQ%b%b%b" "QQ\017\001\017" "\0217" "first preimage\n" |
+		q_to_nul
+	} >delta.1 &&
+	{
+		properties svn:special "*" &&
+		echo PROPS-END
+	} >symlink.props &&
+	{
+		printf "SVNQ%b%b%b" "Q\002\013\004\012" "\0201\001\001\0211" "lnk target" |
+		q_to_nul
+	} >delta.2 &&
+	{
+		printf "SVNQ%b%b" "Q\004\003\004Q" "\001Q\002\002" |
+		q_to_nul
+	} >delta.3 &&
+	{
+		cat <<-\EOF &&
+		SVN-fs-dump-format-version: 3
+
+		Revision-number: 1
+		Prop-content-length: 10
+		Content-length: 10
+
+		PROPS-END
+
+		Node-path: postimage
+		Node-kind: file
+		Node-action: add
+		Text-delta: true
+		Prop-content-length: 10
+		EOF
+		echo Text-content-length: $(wc -c <delta.1) &&
+		echo Content-length: $((10 + $(wc -c <delta.1))) &&
+		echo &&
+		echo PROPS-END &&
+		cat delta.1 &&
+		cat <<-\EOF &&
+
+		Revision-number: 2
+		Prop-content-length: 10
+		Content-length: 10
+
+		PROPS-END
+
+		Node-path: postimage
+		Node-kind: file
+		Node-action: change
+		Text-delta: true
+		EOF
+		echo Prop-content-length: $(wc -c <symlink.props) &&
+		echo Text-content-length: $(wc -c <delta.2) &&
+		echo Content-length: $(($(wc -c <symlink.props) + $(wc -c <delta.2))) &&
+		echo &&
+		cat symlink.props &&
+		cat delta.2 &&
+		cat <<-\EOF &&
+
+		Revision-number: 3
+		Prop-content-length: 10
+		Content-length: 10
+
+		PROPS-END
+
+		Node-path: postimage
+		Node-kind: file
+		Node-action: change
+		Text-delta: true
+		Prop-content-length: 10
+		EOF
+		echo Text-content-length: $(wc -c <delta.3) &&
+		echo Content-length: $((10 + $(wc -c <delta.3))) &&
+		echo &&
+		echo PROPS-END &&
+		cat delta.3 &&
+		echo
+	} >deltapartial.dump &&
+	try_dump deltapartial.dump &&
+	{
+		git rev-list HEAD |
+		git diff-tree --root --stdin |
+		sed "s/$_x40/OBJID/g"
+	} >actual &&
+	test_cmp expect actual &&
+	git show HEAD:postimage >actual.3 &&
+	git show HEAD^:postimage >actual.2 &&
+	git show HEAD^^:postimage >actual.1 &&
+	test_cmp expect.1 actual.1 &&
+	test_cmp expect.2 actual.2 &&
+	test_cmp expect.3 actual.3
+'
 
 test_expect_success 'set up svn repo' '
 	svnconf=$PWD/svnconf &&
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 4748253..94f12dc 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -7,15 +7,38 @@
 #include "strbuf.h"
 #include "quote.h"
 #include "fast_export.h"
-#include "line_buffer.h"
 #include "repo_tree.h"
 #include "strbuf.h"
+#include "svndiff.h"
+#include "sliding_window.h"
+#include "line_buffer.h"
 
 #define MAX_GITSVN_LINE_LEN 4096
+#define REPORT_FILENO 3
 
 static uint32_t first_commit_done;
+static struct line_buffer postimage = LINE_BUFFER_INIT;
 static struct line_buffer report_buffer = LINE_BUFFER_INIT;
 
+/* NEEDSWORK: move to fast_export_init() */
+static int init_postimage(void)
+{
+	static int postimage_initialized;
+	if (postimage_initialized)
+		return 0;
+	postimage_initialized = 1;
+	return buffer_tmpfile_init(&postimage);
+}
+
+static int init_report_buffer(int fd)
+{
+	static int report_buffer_initialized;
+	if (report_buffer_initialized)
+		return 0;
+	report_buffer_initialized = 1;
+	return buffer_fdinit(&report_buffer, fd);
+}
+
 void fast_export_init(int fd)
 {
 	if (buffer_fdinit(&report_buffer, fd))
@@ -127,6 +150,73 @@ static void die_short_read(struct line_buffer *input)
 	die("invalid dump: unexpected end of file");
 }
 
+static int ends_with(const char *s, size_t len, const char *suffix)
+{
+	const size_t suffixlen = strlen(suffix);
+	if (len < suffixlen)
+		return 0;
+	return !memcmp(s + len - suffixlen, suffix, suffixlen);
+}
+
+static int parse_cat_response_line(const char *header, off_t *len)
+{
+	size_t headerlen = strlen(header);
+	const char *type;
+	const char *end;
+
+	if (ends_with(header, headerlen, " missing"))
+		return error("cat-blob reports missing blob: %s", header);
+	type = memmem(header, headerlen, " blob ", strlen(" blob "));
+	if (!type)
+		return error("cat-blob header has wrong object type: %s", header);
+	*len = strtoumax(type + strlen(" blob "), (char **) &end, 10);
+	if (end == type + strlen(" blob "))
+		return error("cat-blob header does not contain length: %s", header);
+	if (*end)
+		return error("cat-blob header contains garbage after length: %s", header);
+	return 0;
+}
+
+static long apply_delta(off_t len, struct line_buffer *input,
+			const char *old_data, uint32_t old_mode)
+{
+	long ret;
+	off_t preimage_len = 0;
+	struct sliding_view preimage = SLIDING_VIEW_INIT(&report_buffer);
+	FILE *out;
+
+	if (init_postimage() || !(out = buffer_tmpfile_rewind(&postimage)))
+		die("cannot open temporary file for blob retrieval");
+	if (init_report_buffer(REPORT_FILENO))
+		die("cannot open fd 3 for feedback from fast-import");
+	if (old_data) {
+		const char *response;
+		printf("cat-blob %s\n", old_data);
+		fflush(stdout);
+		response = get_response_line();
+		if (parse_cat_response_line(response, &preimage_len))
+			die("invalid cat-blob response: %s", response);
+	}
+	if (old_mode == REPO_MODE_LNK) {
+		strbuf_addstr(&preimage.buf, "link ");
+		preimage_len += strlen("link ");
+	}
+	if (svndiff0_apply(input, len, &preimage, out))
+		die("cannot apply delta");
+	if (old_data) {
+		/* Read the remainder of preimage and trailing newline. */
+		if (move_window(&preimage, preimage_len, 1))
+			die("cannot seek to end of input");
+		if (preimage.buf.buf[0] != '\n')
+			die("missing newline after cat-blob response");
+	}
+	ret = buffer_tmpfile_prepare_to_read(&postimage);
+	if (ret < 0)
+		die("cannot read temporary file for blob retrieval");
+	strbuf_release(&preimage.buf);
+	return ret;
+}
+
 void fast_export_data(uint32_t mode, uint32_t len, struct line_buffer *input)
 {
 	if (mode == REPO_MODE_LNK) {
@@ -194,3 +284,20 @@ int fast_export_ls(const char *path, uint32_t *mode, struct strbuf *dataref)
 	ls_from_active_commit(path);
 	return parse_ls_response(get_response_line(), mode, dataref);
 }
+
+void fast_export_blob_delta(uint32_t mode,
+				uint32_t old_mode, const char *old_data,
+				uint32_t len, struct line_buffer *input)
+{
+	long postimage_len;
+	if (len > maximum_signed_value_of_type(off_t))
+		die("enormous delta");
+	postimage_len = apply_delta((off_t) len, input, old_data, old_mode);
+	if (mode == REPO_MODE_LNK) {
+		buffer_skip_bytes(&postimage, strlen("link "));
+		postimage_len -= strlen("link ");
+	}
+	printf("data %ld\n", postimage_len);
+	buffer_copy_bytes(&postimage, postimage_len);
+	fputc('\n', stdout);
+}
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
index bc5bddf..a01774c 100644
--- a/vcs-svn/fast_export.h
+++ b/vcs-svn/fast_export.h
@@ -15,6 +15,9 @@ void fast_export_begin_commit(uint32_t revision, const char *author,
 			unsigned long timestamp);
 void fast_export_end_commit(uint32_t revision);
 void fast_export_data(uint32_t mode, uint32_t len, struct line_buffer *input);
+void fast_export_blob_delta(uint32_t mode,
+			uint32_t old_mode, const char *old_data,
+			uint32_t len, struct line_buffer *input);
 
 /* If there is no such file at that rev, returns -1, errno == ENOENT. */
 int fast_export_ls_rev(uint32_t rev, const char *path,
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index dbb9c16..0c7ac64 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -206,9 +206,7 @@ static void handle_node(void)
 	 */
 	static const char *const empty_blob = "::empty::";
 	const char *old_data = NULL;
-
-	if (node_ctx.text_delta)
-		die("text deltas not supported");
+	uint32_t old_mode = REPO_MODE_BLB;
 
 	if (node_ctx.action == NODEACT_DELETE) {
 		if (have_text || have_props || node_ctx.srcRev)
@@ -243,6 +241,7 @@ static void handle_node(void)
 		if (mode != REPO_MODE_DIR && type == REPO_MODE_DIR)
 			die("invalid dump: cannot modify a file into a directory");
 		node_ctx.type = mode;
+		old_mode = mode;
 	} else if (node_ctx.action == NODEACT_ADD) {
 		if (type == REPO_MODE_DIR)
 			old_data = NULL;
@@ -277,8 +276,14 @@ static void handle_node(void)
 		fast_export_modify(node_ctx.dst.buf, node_ctx.type, old_data);
 		return;
 	}
+	if (!node_ctx.text_delta) {
+		fast_export_modify(node_ctx.dst.buf, node_ctx.type, "inline");
+		fast_export_data(node_ctx.type, node_ctx.textLength, &input);
+		return;
+	}
 	fast_export_modify(node_ctx.dst.buf, node_ctx.type, "inline");
-	fast_export_data(node_ctx.type, node_ctx.textLength, &input);
+	fast_export_blob_delta(node_ctx.type, old_mode, old_data,
+				node_ctx.textLength, &input);
 }
 
 static void begin_revision(void)
-- 
1.7.3.2.846.gf4b062
