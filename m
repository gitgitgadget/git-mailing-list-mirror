From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 11/16] vcs-svn: implement copyfrom_data delta instruction
Date: Sat, 19 Mar 2011 18:20:49 +1100
Message-ID: <1300519254-20201-12-git-send-email-david.barr@cordelta.com>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
 <1300519254-20201-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 19 08:22:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0qUR-0007jt-8F
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 08:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756094Ab1CSHWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 03:22:11 -0400
Received: from [119.15.97.146] ([119.15.97.146]:51488 "EHLO mailhost.cordelta"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754500Ab1CSHVc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 03:21:32 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id 26555C060;
	Sat, 19 Mar 2011 18:17:58 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rm3jD33P8T+B; Sat, 19 Mar 2011 18:17:47 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id 43858C057;
	Sat, 19 Mar 2011 18:17:43 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <1300519254-20201-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169409>

From: Jonathan Nieder <jrnieder@gmail.com>

The copyfrom_data instruction copies a few bytes verbatim from the
auxiliary data section of a window to the postimage.

[jn: with memory leak fix from David]

Improved-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Acked-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
---
 t/t9011-svn-da.sh |   31 ++++++++++++++
 vcs-svn/svndiff.c |  114 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 139 insertions(+), 6 deletions(-)

diff --git a/t/t9011-svn-da.sh b/t/t9011-svn-da.sh
index e909d92..c6dbb21 100755
--- a/t/t9011-svn-da.sh
+++ b/t/t9011-svn-da.sh
@@ -140,4 +140,35 @@ test_expect_success 'reject truncated inline data (after instruction section)' '
 	test_must_fail test-svn-fe -d preimage insn.trunc 11
 '
 
+test_expect_success 'copyfrom_data' '
+	echo hi >expect &&
+	printf "SVNQ%b%b%b" "QQ\003\001\003" "\0203" "hi\n" | q_to_nul >copydat &&
+	test-svn-fe -d preimage copydat 13 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'multiple copyfrom_data' '
+	echo hi >expect &&
+	printf "SVNQ%b%b%b%b%b" "QQ\003\002\003" "\0201\0202" "hi\n" \
+		"QQQ\002Q" "\0200Q" | q_to_nul >copy.multi &&
+	len=$(wc -c <copy.multi) &&
+	test-svn-fe -d preimage copy.multi $len >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'incomplete multiple insn' '
+	printf "SVNQ%b%b%b" "QQ\003\002\003" "\0203\0200" "hi\n" |
+		q_to_nul >copy.partial &&
+	len=$(wc -c <copy.partial) &&
+	test_must_fail test-svn-fe -d preimage copy.partial $len
+'
+
+test_expect_success 'catch attempt to copy missing data' '
+	printf "SVNQ%b%b%s%b%s" "QQ\002\002\001" "\0201\0201" "X" \
+			"QQQQ\002" "YZ" |
+		q_to_nul >copy.incomplete &&
+	len=$(wc -c <copy.incomplete) &&
+	test_must_fail test-svn-fe -d preimage copy.incomplete $len
+'
+
 test_done
diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
index a2dd9b6..118e8c6 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -15,28 +15,49 @@
  *
  * svndiff0 ::= 'SVN\0' window*
  * window ::= int int int int int instructions inline_data;
+ * instructions ::= instruction*;
+ * instruction ::= view_selector int int
+ *   | copyfrom_data int
+ *   | packed_view_selector int
+ *   | packed_copyfrom_data
+ *   ;
+ * copyfrom_data ::= # binary 10 000000;
+ * packed_copyfrom_data ::= # copyfrom_data OR-ed with 6 bit value;
  * int ::= highdigit* lowdigit;
  * highdigit ::= # binary 1000 0000 OR-ed with 7 bit value;
  * lowdigit ::= # 7 bit value;
  */
 
+#define INSN_MASK	0xc0
+#define INSN_COPYFROM_DATA	0x80
+#define OPERAND_MASK	0x3f
+
 #define VLI_CONTINUE	0x80
 #define VLI_DIGIT_MASK	0x7f
 #define VLI_BITS_PER_DIGIT 7
 
 struct window {
+	struct strbuf out;
 	struct strbuf instructions;
 	struct strbuf data;
 };
 
-#define WINDOW_INIT	{ STRBUF_INIT, STRBUF_INIT }
+#define WINDOW_INIT	{ STRBUF_INIT, STRBUF_INIT, STRBUF_INIT }
 
 static void window_release(struct window *ctx)
 {
+	strbuf_release(&ctx->out);
 	strbuf_release(&ctx->instructions);
 	strbuf_release(&ctx->data);
 }
 
+static int write_strbuf(struct strbuf *sb, FILE *out)
+{
+	if (fwrite(sb->buf, 1, sb->len, out) == sb->len)	/* Success. */
+		return 0;
+	return error("cannot write delta postimage: %s", strerror(errno));
+}
+
 static int error_short_read(struct line_buffer *input)
 {
 	if (buffer_ferror(input))
@@ -93,6 +114,25 @@ static int read_int(struct line_buffer *in, uintmax_t *result, off_t *len)
 	return error_short_read(in);
 }
 
+static int parse_int(const char **buf, size_t *result, const char *end)
+{
+	size_t rv = 0;
+	const char *pos;
+	for (pos = *buf; pos != end; pos++) {
+		unsigned char ch = *pos;
+
+		rv <<= VLI_BITS_PER_DIGIT;
+		rv += (ch & VLI_DIGIT_MASK);
+		if (ch & VLI_CONTINUE)
+			continue;
+
+		*result = rv;
+		*buf = pos + 1;
+		return 0;
+	}
+	return error("invalid delta: unexpected end of instructions section");
+}
+
 static int read_offset(struct line_buffer *in, off_t *result, off_t *len)
 {
 	uintmax_t val;
@@ -115,7 +155,64 @@ static int read_length(struct line_buffer *in, size_t *result, off_t *len)
 	return 0;
 }
 
-static int apply_one_window(struct line_buffer *delta, off_t *delta_len)
+static int copyfrom_data(struct window *ctx, size_t *data_pos, size_t nbytes)
+{
+	const size_t pos = *data_pos;
+	if (unsigned_add_overflows(pos, nbytes) ||
+	    pos + nbytes > ctx->data.len)
+		return error("invalid delta: copies unavailable inline data.");
+	strbuf_add(&ctx->out, ctx->data.buf + pos, nbytes);
+	*data_pos += nbytes;
+	return 0;
+}
+
+static int parse_first_operand(const char **buf, size_t *out, const char *end)
+{
+	size_t result = (unsigned char) *(*buf)++ & OPERAND_MASK;
+	if (result) {	/* immediate operand */
+		*out = result;
+		return 0;
+	}
+	return parse_int(buf, out, end);
+}
+
+static int execute_one_instruction(struct window *ctx,
+				const char **instructions, size_t *data_pos)
+{
+	unsigned int instruction;
+	const char *insns_end = ctx->instructions.buf + ctx->instructions.len;
+	size_t nbytes;
+	assert(ctx);
+	assert(instructions && *instructions);
+	assert(data_pos);
+
+	instruction = (unsigned char) **instructions;
+	if (parse_first_operand(instructions, &nbytes, insns_end))
+		return -1;
+	if ((instruction & INSN_MASK) != INSN_COPYFROM_DATA)
+		return error("Unknown instruction %x", instruction);
+	return copyfrom_data(ctx, data_pos, nbytes);
+}
+
+static int apply_window_in_core(struct window *ctx)
+{
+	const char *instructions;
+	size_t data_pos = 0;
+
+	/*
+	 * Fill ctx->out.buf using data from the source, target,
+	 * and inline data views.
+	 */
+	for (instructions = ctx->instructions.buf;
+	     instructions != ctx->instructions.buf + ctx->instructions.len;
+	     )
+		if (execute_one_instruction(ctx, &instructions, &data_pos))
+			return -1;
+	return 0;
+}
+
+static int apply_one_window(struct line_buffer *delta, off_t *delta_len,
+			    FILE *out)
 {
 	struct window ctx = WINDOW_INIT;
 	size_t out_len;
@@ -130,11 +227,16 @@ static int apply_one_window(struct line_buffer *delta, off_t *delta_len)
 		goto error_out;
 	if (read_chunk(delta, delta_len, &ctx.instructions, instructions_len))
 		goto error_out;
-	if (instructions_len) {
-		error("What do you think I am?  A delta applier?");
+	if (read_chunk(delta, delta_len, &ctx.data, data_len))
+		goto error_out;
+	strbuf_grow(&ctx.out, out_len);
+	if (apply_window_in_core(&ctx))
+		goto error_out;
+	if (ctx.out.len != out_len) {
+		error("invalid delta: incorrect postimage length");
 		goto error_out;
 	}
-	if (read_chunk(delta, delta_len, &ctx.data, data_len))
+	if (write_strbuf(&ctx.out, out))
 		goto error_out;
 	window_release(&ctx);
 	return 0;
@@ -157,7 +259,7 @@ int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
 		if (read_offset(delta, &pre_off, &delta_len) ||
 		    read_length(delta, &pre_len, &delta_len) ||
 		    move_window(preimage, pre_off, pre_len) ||
-		    apply_one_window(delta, &delta_len))
+		    apply_one_window(delta, &delta_len, postimage))
 			return -1;
 	}
 	return 0;
-- 
1.7.3.2.846.gf4b062
