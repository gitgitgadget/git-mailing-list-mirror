From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 13/16] vcs-svn: let deltas use data from postimage
Date: Sat, 19 Mar 2011 18:20:51 +1100
Message-ID: <1300519254-20201-14-git-send-email-david.barr@cordelta.com>
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
	id 1Q0qUQ-0007jt-77
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 08:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754491Ab1CSHWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 03:22:05 -0400
Received: from [119.15.97.146] ([119.15.97.146]:55904 "EHLO mailhost.cordelta"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754564Ab1CSHVc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 03:21:32 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id CE9E7C058;
	Sat, 19 Mar 2011 18:17:58 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aBZ7KyXUNzPG; Sat, 19 Mar 2011 18:17:47 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id 68B11C059;
	Sat, 19 Mar 2011 18:17:43 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <1300519254-20201-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169412>

From: Jonathan Nieder <jrnieder@gmail.com>

The copyfrom_target instruction copies appends data that is already
present in the current output view to the end of output.  (The offset
argument is relative to the beginning of output produced in the
current window.)

The region copied is allowed to run past the end of the existing
output.  To support that case, copy one character at a time rather
than calling memcpy or memmove.  This allows copyfrom_target to be
used once to repeat a string many times.  For example:

	COPYFROM_DATA 2
	COPYFROM_OUTPUT 10, 0
	DATA "ab"

would produce the output "ababababababababababab".

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Acked-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
---
 t/t9011-svn-da.sh |   42 ++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/svndiff.c |   28 ++++++++++++++++++++++++++--
 2 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/t/t9011-svn-da.sh b/t/t9011-svn-da.sh
index 7f422ca..d13115a 100755
--- a/t/t9011-svn-da.sh
+++ b/t/t9011-svn-da.sh
@@ -170,4 +170,46 @@ test_expect_success 'catch attempt to copy missing data' '
 	test_must_fail test-svn-fe -d preimage copy.incomplete $len
 '
 
+test_expect_success 'copyfrom target to repeat data' '
+	printf foofoo >expect &&
+	printf "SVNQ%b%b%s" "QQ\006\004\003" "\0203\0100\003Q" "foo" |
+		q_to_nul >copytarget.repeat &&
+	len=$(wc -c <copytarget.repeat) &&
+	test-svn-fe -d preimage copytarget.repeat $len >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'copyfrom target out of order' '
+	printf foooof >expect &&
+	printf "SVNQ%b%b%s" \
+		"QQ\006\007\003" "\0203\0101\002\0101\001\0101Q" "foo" |
+		q_to_nul >copytarget.reverse &&
+	len=$(wc -c <copytarget.reverse) &&
+	test-svn-fe -d preimage copytarget.reverse $len >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'catch copyfrom future' '
+	printf "SVNQ%b%b%s" "QQ\004\004\003" "\0202\0101\002\0201" "XYZ" |
+		q_to_nul >copytarget.infuture &&
+	len=$(wc -c <copytarget.infuture) &&
+	test_must_fail test-svn-fe -d preimage copytarget.infuture $len
+'
+
+test_expect_success 'copy to sustain' '
+	printf XYXYXYXYXYXZ >expect &&
+	printf "SVNQ%b%b%s" "QQ\014\004\003" "\0202\0111Q\0201" "XYZ" |
+		q_to_nul >copytarget.sustain &&
+	len=$(wc -c <copytarget.sustain) &&
+	test-svn-fe -d preimage copytarget.sustain $len >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'catch copy that overflows' '
+	printf "SVNQ%b%b%s" "QQ\003\003\001" "\0201\0177Q" X |
+		q_to_nul >copytarget.overflow &&
+	len=$(wc -c <copytarget.overflow) &&
+	test_must_fail test-svn-fe -d preimage copytarget.overflow $len
+'
+
 test_done
diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
index 6b505dc..f4c5dae 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -21,7 +21,12 @@
  *   | packed_view_selector int
  *   | packed_copyfrom_data
  *   ;
+ * view_selector ::= copyfrom_source
+ *   | copyfrom_target
+ *   ;
+ * copyfrom_target ::= # binary 01 000000;
  * copyfrom_data ::= # binary 10 000000;
+ * packed_view_selector ::= # view_selector OR-ed with 6 bit value;
  * packed_copyfrom_data ::= # copyfrom_data OR-ed with 6 bit value;
  * int ::= highdigit* lowdigit;
  * highdigit ::= # binary 1000 0000 OR-ed with 7 bit value;
@@ -29,6 +34,7 @@
  */
 
 #define INSN_MASK	0xc0
+#define INSN_COPYFROM_TARGET	0x40
 #define INSN_COPYFROM_DATA	0x80
 #define OPERAND_MASK	0x3f
 
@@ -155,6 +161,19 @@ static int read_length(struct line_buffer *in, size_t *result, off_t *len)
 	return 0;
 }
 
+static int copyfrom_target(struct window *ctx, const char **instructions,
+			   size_t nbytes, const char *instructions_end)
+{
+	size_t offset;
+	if (parse_int(instructions, &offset, instructions_end))
+		return -1;
+	if (offset >= ctx->out.len)
+		return error("invalid delta: copies from the future.");
+	for (; nbytes > 0; nbytes--)
+		strbuf_addch(&ctx->out, ctx->out.buf[offset++]);
+	return 0;
+}
+
 static int copyfrom_data(struct window *ctx, size_t *data_pos, size_t nbytes)
 {
 	const size_t pos = *data_pos;
@@ -189,9 +208,14 @@ static int execute_one_instruction(struct window *ctx,
 	instruction = (unsigned char) **instructions;
 	if (parse_first_operand(instructions, &nbytes, insns_end))
 		return -1;
-	if ((instruction & INSN_MASK) != INSN_COPYFROM_DATA)
+	switch (instruction & INSN_MASK) {
+	case INSN_COPYFROM_TARGET:
+		return copyfrom_target(ctx, instructions, nbytes, insns_end);
+	case INSN_COPYFROM_DATA:
+		return copyfrom_data(ctx, data_pos, nbytes);
+	default:
 		return error("Unknown instruction %x", instruction);
-	return copyfrom_data(ctx, data_pos, nbytes);
+	}
 }
 
 static int apply_window_in_core(struct window *ctx)
-- 
1.7.3.2.846.gf4b062
