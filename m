From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 14/16] vcs-svn: let deltas use data from preimage
Date: Sat, 19 Mar 2011 18:20:52 +1100
Message-ID: <1300519254-20201-15-git-send-email-david.barr@cordelta.com>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
 <1300519254-20201-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 19 08:22:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0qUP-0007jt-4i
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 08:22:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755696Ab1CSHV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 03:21:59 -0400
Received: from [119.15.97.146] ([119.15.97.146]:54788 "EHLO mailhost.cordelta"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754185Ab1CSHVa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 03:21:30 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id 99D0DC054;
	Sat, 19 Mar 2011 18:17:56 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7WTJGo8wZ0v5; Sat, 19 Mar 2011 18:17:49 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id 7AD90C05A;
	Sat, 19 Mar 2011 18:17:43 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <1300519254-20201-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169407>

From: Jonathan Nieder <jrnieder@gmail.com>

The copyfrom_source instruction appends data from the preimage buffer
to the end of output.  Its arguments are a length and an offset
relative to the beginning of the source view.

With this change, the delta applier is able to reproduce all 5,636,613
blobs in the early history of the ASF repository.  Tested with

	mkfifo backflow
	svn-fe <svn-asf-public-r0:940166 3<backflow |
	git fast-import --cat-blob-fd=3 3>backflow

with svn-asf-public-r0:940166 produced by whatever version of
Subversion the dumps in /dump/ on svn.apache.org use (presumably
1.6.something).

Improved-by: Ramkumar Ramachandra <artagnon@gmail.com>
Improved-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Acked-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
---
 t/t9011-svn-da.sh |   35 +++++++++++++++++++++++++++++++++++
 vcs-svn/svndiff.c |   28 +++++++++++++++++++++++-----
 2 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/t/t9011-svn-da.sh b/t/t9011-svn-da.sh
index d13115a..45e396f 100755
--- a/t/t9011-svn-da.sh
+++ b/t/t9011-svn-da.sh
@@ -212,4 +212,39 @@ test_expect_success 'catch copy that overflows' '
 	test_must_fail test-svn-fe -d preimage copytarget.overflow $len
 '
 
+test_expect_success 'copyfrom source' '
+	printf foo >expect &&
+	printf "SVNQ%b%b" "Q\003\003\002Q" "\003Q" | q_to_nul >copysource.all &&
+	test-svn-fe -d preimage copysource.all 11 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'copy backwards' '
+	printf oof >expect &&
+	printf "SVNQ%b%b" "Q\003\003\006Q" "\001\002\001\001\001Q" |
+		q_to_nul >copysource.rev &&
+	test-svn-fe -d preimage copysource.rev 15 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'offsets are relative to window' '
+	printf fo >expect &&
+	printf "SVNQ%b%b%b%b" "Q\003\001\002Q" "\001Q" \
+		"\002\001\001\002Q" "\001Q" |
+		q_to_nul >copysource.two &&
+	test-svn-fe -d preimage copysource.two 18 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'example from notes/svndiff' '
+	printf aaaaccccdddddddd >expect &&
+	printf aaaabbbbcccc >source &&
+	printf "SVNQ%b%b%s" "Q\014\020\007\001" \
+		"\004Q\004\010\0201\0107\010" d |
+		q_to_nul >delta.example &&
+	len=$(wc -c <delta.example) &&
+	test-svn-fe -d source delta.example $len >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
index f4c5dae..b7d40c8 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -24,6 +24,7 @@
  * view_selector ::= copyfrom_source
  *   | copyfrom_target
  *   ;
+ * copyfrom_source ::= # binary 00 000000;
  * copyfrom_target ::= # binary 01 000000;
  * copyfrom_data ::= # binary 10 000000;
  * packed_view_selector ::= # view_selector OR-ed with 6 bit value;
@@ -34,6 +35,7 @@
  */
 
 #define INSN_MASK	0xc0
+#define INSN_COPYFROM_SOURCE	0x00
 #define INSN_COPYFROM_TARGET	0x40
 #define INSN_COPYFROM_DATA	0x80
 #define OPERAND_MASK	0x3f
@@ -43,12 +45,13 @@
 #define VLI_BITS_PER_DIGIT 7
 
 struct window {
+	struct sliding_view *in;
 	struct strbuf out;
 	struct strbuf instructions;
 	struct strbuf data;
 };
 
-#define WINDOW_INIT	{ STRBUF_INIT, STRBUF_INIT, STRBUF_INIT }
+#define WINDOW_INIT(w)	{ w, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT }
 
 static void window_release(struct window *ctx)
 {
@@ -161,6 +164,19 @@ static int read_length(struct line_buffer *in, size_t *result, off_t *len)
 	return 0;
 }
 
+static int copyfrom_source(struct window *ctx, const char **instructions,
+			   size_t nbytes, const char *insns_end)
+{
+	size_t offset;
+	if (parse_int(instructions, &offset, insns_end))
+		return -1;
+	if (unsigned_add_overflows(offset, nbytes) ||
+	    offset + nbytes > ctx->in->width)
+		return error("invalid delta: copies source data outside view");
+	strbuf_add(&ctx->out, ctx->in->buf.buf + offset, nbytes);
+	return 0;
+}
+
 static int copyfrom_target(struct window *ctx, const char **instructions,
 			   size_t nbytes, const char *instructions_end)
 {
@@ -209,12 +225,14 @@ static int execute_one_instruction(struct window *ctx,
 	if (parse_first_operand(instructions, &nbytes, insns_end))
 		return -1;
 	switch (instruction & INSN_MASK) {
+	case INSN_COPYFROM_SOURCE:
+		return copyfrom_source(ctx, instructions, nbytes, insns_end);
 	case INSN_COPYFROM_TARGET:
 		return copyfrom_target(ctx, instructions, nbytes, insns_end);
 	case INSN_COPYFROM_DATA:
 		return copyfrom_data(ctx, data_pos, nbytes);
 	default:
-		return error("Unknown instruction %x", instruction);
+		return error("invalid delta: unrecognized instruction");
 	}
 }
 
@@ -238,9 +256,9 @@ static int apply_window_in_core(struct window *ctx)
 }
 
 static int apply_one_window(struct line_buffer *delta, off_t *delta_len,
-			    FILE *out)
+			    struct sliding_view *preimage, FILE *out)
 {
-	struct window ctx = WINDOW_INIT;
+	struct window ctx = WINDOW_INIT(preimage);
 	size_t out_len;
 	size_t instructions_len;
 	size_t data_len;
@@ -285,7 +303,7 @@ int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
 		if (read_offset(delta, &pre_off, &delta_len) ||
 		    read_length(delta, &pre_len, &delta_len) ||
 		    move_window(preimage, pre_off, pre_len) ||
-		    apply_one_window(delta, &delta_len, postimage))
+		    apply_one_window(delta, &delta_len, preimage, postimage))
 			return -1;
 	}
 	return 0;
-- 
1.7.3.2.846.gf4b062
