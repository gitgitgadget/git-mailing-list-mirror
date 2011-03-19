From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 09/16] vcs-svn: read inline data from deltas
Date: Sat, 19 Mar 2011 18:20:47 +1100
Message-ID: <1300519254-20201-10-git-send-email-david.barr@cordelta.com>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
 <1300519254-20201-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 19 08:21:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0qU0-0007ZM-64
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 08:21:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755519Ab1CSHVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 03:21:52 -0400
Received: from [119.15.97.146] ([119.15.97.146]:64231 "EHLO mailhost.cordelta"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754071Ab1CSHV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 03:21:27 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id C4FB5C050;
	Sat, 19 Mar 2011 18:17:54 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wBp0HMCAWMpP; Sat, 19 Mar 2011 18:17:47 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id 1D5FBC055;
	Sat, 19 Mar 2011 18:17:43 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <1300519254-20201-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169404>

From: Jonathan Nieder <jrnieder@gmail.com>

Each window of an svndiff0-format delta includes a section for new
data that will be copied into the preimage (in the order it appears in
the window, possibly interspersed with other data).

Read this data when encountering it.  It is not actually necessary to
do so --- it would be just as easy to copy straight from the delta
to output when interpreting the relevant instructions --- but this
way, the code that interprets svndiff0 instructions can proceed more
quickly because it does not require any I/O.

Subversion's implementation rejects deltas that do not consume all
the auxiliary data that is available.  Do not check that for now,
because it would make it impossible to test the function of this
patch until the instructions to consume data are implemented.

Do check for truncated data sections.  Since Subversion's applier
rejects deltas that end before the new-data section is declared to
end, it should be safe for this applier to reject such deltas, too.

Improved-by: Ramkumar Ramachandra <artagnon@gmail.com>
Improved-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Acked-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
---
 t/t9011-svn-da.sh |   12 ++++++++++++
 vcs-svn/svndiff.c |   46 +++++++++++++++++++++++++++++++++++-----------
 2 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/t/t9011-svn-da.sh b/t/t9011-svn-da.sh
index 986dce6..4919fae 100755
--- a/t/t9011-svn-da.sh
+++ b/t/t9011-svn-da.sh
@@ -123,4 +123,16 @@ test_expect_success 'preimage view: reject truncated preimage' '
 	test_must_fail test-svn-fe -d preimage clear.longread 9
 '
 
+test_expect_success 'inline data' '
+	printf "SVNQ%b%s%b%s" "QQQQ\003" "bar" "QQQQ\001" "x" |
+		q_to_nul >inline.clear &&
+	test-svn-fe -d preimage inline.clear 18 >actual &&
+	test_cmp empty actual
+'
+
+test_expect_success 'reject truncated inline data' '
+	printf "SVNQ%b%s" "QQQQ\003" "b" | q_to_nul >inline.trunc &&
+	test_must_fail test-svn-fe -d preimage inline.trunc 10
+'
+
 test_done
diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
index 1020275..74e0401 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -24,6 +24,17 @@
 #define VLI_DIGIT_MASK	0x7f
 #define VLI_BITS_PER_DIGIT 7
 
+struct window {
+	struct strbuf data;
+};
+
+#define WINDOW_INIT	{ STRBUF_INIT }
+
+static void window_release(struct window *ctx)
+{
+	strbuf_release(&ctx->data);
+}
+
 static int error_short_read(struct line_buffer *input)
 {
 	if (buffer_ferror(input))
@@ -31,24 +42,30 @@ static int error_short_read(struct line_buffer *input)
 	return error("invalid delta: unexpected end of file");
 }
 
+static int read_chunk(struct line_buffer *delta, off_t *delta_len,
+		      struct strbuf *buf, size_t len)
+{
+	strbuf_reset(buf);
+	if (len > *delta_len ||
+	    buffer_read_binary(delta, buf, len) != len)
+		return error_short_read(delta);
+	*delta_len -= buf->len;
+	return 0;
+}
+
 static int read_magic(struct line_buffer *in, off_t *len)
 {
 	static const char magic[] = {'S', 'V', 'N', '\0'};
 	struct strbuf sb = STRBUF_INIT;
 
-	if (*len < sizeof(magic) ||
-	    buffer_read_binary(in, &sb, sizeof(magic)) != sizeof(magic)) {
-		error_short_read(in);
+	if (read_chunk(in, len, &sb, sizeof(magic))) {
 		strbuf_release(&sb);
 		return -1;
 	}
-
 	if (memcmp(sb.buf, magic, sizeof(magic))) {
 		strbuf_release(&sb);
 		return error("invalid delta: unrecognized file type");
 	}
-
-	*len -= sizeof(magic);
 	strbuf_release(&sb);
 	return 0;
 }
@@ -98,6 +115,7 @@ static int read_length(struct line_buffer *in, size_t *result, off_t *len)
 
 static int apply_one_window(struct line_buffer *delta, off_t *delta_len)
 {
+	struct window ctx = WINDOW_INIT;
 	size_t out_len;
 	size_t instructions_len;
 	size_t data_len;
@@ -107,12 +125,18 @@ static int apply_one_window(struct line_buffer *delta, off_t *delta_len)
 	if (read_length(delta, &out_len, delta_len) ||
 	    read_length(delta, &instructions_len, delta_len) ||
 	    read_length(delta, &data_len, delta_len))
-		return -1;
-	if (instructions_len)
-		return error("What do you think I am?  A delta applier?");
-	if (data_len)
-		return error("No support for inline data yet");
+		goto error_out;
+	if (instructions_len) {
+		error("What do you think I am?  A delta applier?");
+		goto error_out;
+	}
+	if (read_chunk(delta, delta_len, &ctx.data, data_len))
+		goto error_out;
+	window_release(&ctx);
 	return 0;
+error_out:
+	window_release(&ctx);
+	return -1;
 }
 
 int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
-- 
1.7.3.2.846.gf4b062
