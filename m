From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 06/11] vcs-svn: Implement copyfrom_data delta instruction
Date: Wed, 13 Oct 2010 04:39:44 -0500
Message-ID: <20101013093944.GG32608@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino>
 <20100809215719.GA4203@burratino>
 <20100810125317.GB3921@kytes>
 <20101011023435.GA706@burratino>
 <20101011040140.GC5649@burratino>
 <20101013091714.GA32608@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 11:43:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5xre-0004s2-Cq
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 11:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326Ab0JMJnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 05:43:08 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61169 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844Ab0JMJnF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 05:43:05 -0400
Received: by gxk6 with SMTP id 6so848161gxk.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 02:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=akThTCHQGxpf3ltmjGjcfW5GpXwBySrWYEoUQ01FO/E=;
        b=TzNpeMN05zS4Sao46wQ9GGpwSbAF0FpYPV0+J1OkjLcmTlFSc92QIsgvpNz3o1L/4e
         qgnKvQJPnIxq0XRp+OFSsN+rNhpJlS8vy9YXzYzbEl7BgskgpJZLL8h+ElYrhnX5o4bA
         j53YKR97Je9JnasZLLWmloqBzsez6rKQhg5Fs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bhrSS02ByrsG6iaE7ULmtC1if8bgJ8ynqau8aIYY5oc9h09FS0k5GlXmTN63G+Mabp
         9ac0OS4/sRGP3rP0Z7WtjY800NrDSumtlYFzNVEqiJN5h4Uj/w76rl34xWeLFb8o4dxj
         P28lPYfxVutxSId/SoMhjnPM6Dp56IISXYZ8I=
Received: by 10.236.109.44 with SMTP id r32mr17774717yhg.16.1286962984974;
        Wed, 13 Oct 2010 02:43:04 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id 43sm5734416yhl.37.2010.10.13.02.43.03
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 02:43:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101013091714.GA32608@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158919>

The copyfrom_data instruction copies a few bytes verbatim from the
auxiliary data section of a window to the postimage.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9011-svn-da.sh |   31 +++++++++++++++++++
 vcs-svn/svndiff.c |   86 +++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 112 insertions(+), 5 deletions(-)

diff --git a/t/t9011-svn-da.sh b/t/t9011-svn-da.sh
index 1383263..9279924 100755
--- a/t/t9011-svn-da.sh
+++ b/t/t9011-svn-da.sh
@@ -134,4 +134,35 @@ test_expect_success 'truncated inline data (after instruction section)' '
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
index 72fe716..ac776e0 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -14,20 +14,40 @@
  *
  * svndiff0 ::= 'SVN\0' window window*;
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
 
+static int write_strbuf(struct strbuf *sb, FILE *out)
+{
+	if (fwrite(sb->buf, 1, sb->len, out) == sb->len)	/* Success. */
+		return 0;
+	return error("Cannot write: %s\n", strerror(errno));
+}
+
 static int read_magic(struct line_buffer *in, off_t *len)
 {
 	static const char magic[] = {'S', 'V', 'N', '\0'};
@@ -118,9 +138,63 @@ static int read_chunk(struct line_buffer *delta, off_t *delta_len,
 	return 0;
 }
 
-static int apply_one_window(struct line_buffer *delta, off_t *delta_len)
+static int copyfrom_data(struct window *ctx, size_t *data_pos, size_t nbytes)
 {
-	struct window ctx = {STRBUF_INIT, STRBUF_INIT};
+	const size_t pos = *data_pos;
+	if (unsigned_add_overflows(pos, nbytes) ||
+	    pos + nbytes > ctx->data.len)
+		return error("Invalid delta: copies unavailable inline data.");
+	strbuf_add(&ctx->out, ctx->data.buf + pos, nbytes);
+	*data_pos += nbytes;
+	return 0;
+}
+
+static int parse_first_operand(const char **buf, size_t *out, const char *end)
+{
+	size_t result = (unsigned char) *(*buf)++ & OPERAND_MASK;
+	if (result) {
+		*out = result;
+		return 0;
+	}
+	return parse_int(buf, out, end);
+}
+
+static int step(struct window *ctx, const char **instructions, size_t *data_pos)
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
+	const char *insn = ctx->instructions.buf;
+	size_t data_pos = 0;
+
+	/*
+	 * Populate ctx->out.buf using data from the source, target,
+	 * and inline data views.
+	 */
+	while (insn != ctx->instructions.buf + ctx->instructions.len)
+		if (step(ctx, &insn, &data_pos))
+			return -1;
+	return 0;
+}
+
+static int apply_one_window(struct line_buffer *delta, off_t *delta_len,
+			    FILE *out)
+{
+	struct window ctx = {STRBUF_INIT, STRBUF_INIT, STRBUF_INIT};
 	size_t out_len;
 	size_t instructions_len;
 	size_t data_len;
@@ -146,8 +220,10 @@ static int apply_one_window(struct line_buffer *delta, off_t *delta_len)
 		rv = error("Cannot read delta: %s", strerror(errno));
 		goto done;
 	}
-	if (instructions_len > 0)
-		return error("What do you think I am?  A delta applier?");
+	if (apply_window_in_core(&ctx) || write_strbuf(&ctx.out, out)) {
+		rv = -1;
+		goto done;
+	}
  done:
 	strbuf_release(&ctx.data);
 	strbuf_release(&ctx.instructions);
@@ -168,7 +244,7 @@ int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
 		if (read_offset(delta, &pre_off, &delta_len) ||
 		    read_length(delta, &pre_len, &delta_len) ||
 		    move_window(&preimage_view, pre_off, pre_len) ||
-		    apply_one_window(delta, &delta_len))
+		    apply_one_window(delta, &delta_len, postimage))
 			goto fail;
 		if (delta_len && buffer_at_eof(delta)) {
 			error("Delta ends early! (%"PRIu64" bytes remaining)",
-- 
1.7.2.3
