From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 07/16] vcs-svn: parse svndiff0 window header
Date: Sat, 19 Mar 2011 18:20:45 +1100
Message-ID: <1300519254-20201-8-git-send-email-david.barr@cordelta.com>
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
	id 1Q0qUQ-0007jt-No
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 08:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756035Ab1CSHWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 03:22:08 -0400
Received: from [119.15.97.146] ([119.15.97.146]:59363 "EHLO mailhost.cordelta"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753693Ab1CSHVd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 03:21:33 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id 385BBC057;
	Sat, 19 Mar 2011 18:18:00 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8rabjV96Hfia; Sat, 19 Mar 2011 18:17:46 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id D5FD7C053;
	Sat, 19 Mar 2011 18:17:42 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <1300519254-20201-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169410>

From: Jonathan Nieder <jrnieder@gmail.com>

Each window in a subversion delta (svndiff0-format file) starts with a
window header, consisting of five integers with variable-length
representation:

	source view offset
	source view length
	output length
	instructions length
	auxiliary data length

Parse it.  The result is not usable for deltas with nonempty postimage
yet; in fact, this only adds support for deltas without any
instructions or auxiliary data.  This is a good place to stop, though,
since that little support lets us add some simple passing tests
concerning error handling to the test suite.

Improved-by: Ramkumar Ramachandra <artagnon@gmail.com>
Improved-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
---
 t/t9011-svn-da.sh |   56 +++++++++++++++++++++++++++++++-
 vcs-svn/svndiff.c |   92 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 142 insertions(+), 6 deletions(-)

diff --git a/t/t9011-svn-da.sh b/t/t9011-svn-da.sh
index 6d6a406..2ab580a 100755
--- a/t/t9011-svn-da.sh
+++ b/t/t9011-svn-da.sh
@@ -28,10 +28,64 @@ test_expect_success 'reject svndiff2' '
 	test_must_fail test-svn-fe -d preimage bad.filetype 4
 '
 
-test_expect_failure 'one-window empty delta' '
+test_expect_success 'one-window empty delta' '
 	printf "SVNQ%s" "QQQQQ" | q_to_nul >clear.onewindow &&
 	test-svn-fe -d preimage clear.onewindow 9 >actual &&
 	test_cmp empty actual
 '
 
+test_expect_success 'reject incomplete window header' '
+	printf "SVNQ%s" "QQQQQ" | q_to_nul >clear.onewindow &&
+	printf "SVNQ%s" "QQ" | q_to_nul >clear.partialwindow &&
+	test_must_fail test-svn-fe -d preimage clear.onewindow 6 &&
+	test_must_fail test-svn-fe -d preimage clear.partialwindow 6
+'
+
+test_expect_success 'reject declared delta longer than actual delta' '
+	printf "SVNQ%s" "QQQQQ" | q_to_nul >clear.onewindow &&
+	printf "SVNQ%s" "QQ" | q_to_nul >clear.partialwindow &&
+	test_must_fail test-svn-fe -d preimage clear.onewindow 14 &&
+	test_must_fail test-svn-fe -d preimage clear.partialwindow 9
+'
+
+test_expect_success 'two-window empty delta' '
+	printf "SVNQ%s%s" "QQQQQ" "QQQQQ" | q_to_nul >clear.twowindow &&
+	test-svn-fe -d preimage clear.twowindow 14 >actual &&
+	test_must_fail test-svn-fe -d preimage clear.twowindow 13 &&
+	test_cmp empty actual
+'
+
+test_expect_success 'noisy zeroes' '
+	printf "SVNQ%s" \
+		"RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRQQQQQ" |
+		tr R "\200" |
+		q_to_nul >clear.noisy &&
+	len=$(wc -c <clear.noisy) &&
+	test-svn-fe -d preimage clear.noisy $len &&
+	test_cmp empty actual
+'
+
+test_expect_success 'reject variable-length int in magic' '
+	printf "SVNRQ" | tr R "\200" | q_to_nul >clear.badmagic &&
+	test_must_fail test-svn-fe -d preimage clear.badmagic 5
+'
+
+test_expect_success 'reject truncated integer' '
+	printf "SVNQ%s%s" "QQQQQ" "QQQQRRQ" |
+		tr R "\200" |
+		q_to_nul >clear.fullint &&
+	printf "SVNQ%s%s" "QQQQQ" "QQQQRR" |
+		tr RT "\201" |
+		q_to_nul >clear.partialint &&
+	test_must_fail test-svn-fe -d preimage clear.fullint 15 &&
+	test-svn-fe -d preimage clear.fullint 16 &&
+	test_must_fail test-svn-fe -d preimage clear.partialint 15
+'
+
+test_expect_success 'nonempty (but unused) preimage view' '
+	printf "SVNQ%b" "Q\003QQQ" | q_to_nul >clear.readpreimage &&
+	test-svn-fe -d preimage clear.readpreimage 9 >actual &&
+	test_cmp empty actual
+'
+
 test_done
diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
index 5916036..249efb6 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -13,8 +13,16 @@
  * See http://svn.apache.org/repos/asf/subversion/trunk/notes/svndiff.
  *
  * svndiff0 ::= 'SVN\0' window*
+ * window ::= int int int int int instructions inline_data;
+ * int ::= highdigit* lowdigit;
+ * highdigit ::= # binary 1000 0000 OR-ed with 7 bit value;
+ * lowdigit ::= # 7 bit value;
  */
 
+#define VLI_CONTINUE	0x80
+#define VLI_DIGIT_MASK	0x7f
+#define VLI_BITS_PER_DIGIT 7
+
 static int error_short_read(struct line_buffer *input)
 {
 	if (buffer_ferror(input))
@@ -28,17 +36,84 @@ static int read_magic(struct line_buffer *in, off_t *len)
 	struct strbuf sb = STRBUF_INIT;
 
 	if (*len < sizeof(magic) ||
-	    buffer_read_binary(in, &sb, sizeof(magic)) != sizeof(magic))
-		return error_short_read(in);
+	    buffer_read_binary(in, &sb, sizeof(magic)) != sizeof(magic)) {
+		error_short_read(in);
+		strbuf_release(&sb);
+		return -1;
+	}
 
-	if (memcmp(sb.buf, magic, sizeof(magic)))
+	if (memcmp(sb.buf, magic, sizeof(magic))) {
+		strbuf_release(&sb);
 		return error("invalid delta: unrecognized file type");
+	}
 
 	*len -= sizeof(magic);
 	strbuf_release(&sb);
 	return 0;
 }
 
+static int read_int(struct line_buffer *in, uintmax_t *result, off_t *len)
+{
+	uintmax_t rv = 0;
+	off_t sz;
+	for (sz = *len; sz; sz--) {
+		const int ch = buffer_read_char(in);
+		if (ch == EOF)
+			break;
+
+		rv <<= VLI_BITS_PER_DIGIT;
+		rv += (ch & VLI_DIGIT_MASK);
+		if (ch & VLI_CONTINUE)
+			continue;
+
+		*result = rv;
+		*len = sz - 1;
+		return 0;
+	}
+	return error_short_read(in);
+}
+
+static int read_offset(struct line_buffer *in, off_t *result, off_t *len)
+{
+	uintmax_t val;
+	if (read_int(in, &val, len))
+		return -1;
+	if (val > maximum_signed_value_of_type(off_t))
+		return error("unrepresentable offset in delta: %"PRIuMAX"", val);
+	*result = val;
+	return 0;
+}
+
+static int read_length(struct line_buffer *in, size_t *result, off_t *len)
+{
+	uintmax_t val;
+	if (read_int(in, &val, len))
+		return -1;
+	if (val > SIZE_MAX)
+		return error("unrepresentable length in delta: %"PRIuMAX"", val);
+	*result = val;
+	return 0;
+}
+
+static int apply_one_window(struct line_buffer *delta, off_t *delta_len)
+{
+	size_t out_len;
+	size_t instructions_len;
+	size_t data_len;
+	assert(delta_len);
+
+	/* "source view" offset and length already handled; */
+	if (read_length(delta, &out_len, delta_len) ||
+	    read_length(delta, &instructions_len, delta_len) ||
+	    read_length(delta, &data_len, delta_len))
+		return -1;
+	if (instructions_len)
+		return error("What do you think I am?  A delta applier?");
+	if (data_len)
+		return error("No support for inline data yet");
+	return 0;
+}
+
 int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
 			struct sliding_view *preimage, FILE *postimage)
 {
@@ -46,7 +121,14 @@ int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
 
 	if (read_magic(delta, &delta_len))
 		return -1;
-	if (delta_len)
-		return error("What do you think I am?  A delta applier?");
+	while (delta_len) {	/* For each window: */
+		off_t pre_off;
+		size_t pre_len;
+
+		if (read_offset(delta, &pre_off, &delta_len) ||
+		    read_length(delta, &pre_len, &delta_len) ||
+		    apply_one_window(delta, &delta_len))
+			return -1;
+	}
 	return 0;
 }
-- 
1.7.3.2.846.gf4b062
