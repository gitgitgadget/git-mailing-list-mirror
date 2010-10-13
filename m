From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 11/11] vcs-svn: Allow deltas to copy from preimage
Date: Wed, 13 Oct 2010 04:58:30 -0500
Message-ID: <20101013095829.GL32608@burratino>
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
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 12:02:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5y9l-0003iL-8j
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 12:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860Ab0JMKBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 06:01:52 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:49292 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab0JMKBv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 06:01:51 -0400
Received: by gwj17 with SMTP id 17so1774318gwj.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 03:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=FgiJ/k14equKFyU+GyuejHp4XUqNT0VkqJ/tsmG/Cr4=;
        b=SmXYip7huvfigPxHcvKuE/sTP7cRovAFvHrd62i+qoKuVadzwFht6NH6N/1LwgCSLj
         vN995vVCVT3ItqqlOICvrxq+Ud9u4ziTCKsZZCL3mSjFOVHDwxoYdGVUztg5Rb2eNaDF
         tzXCR6MjfuSKh24sCNWAgs712y8EnNCIcqXBs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=BCRAoKj/aExcXxM/YB2q35fGgOMCxQZxmF3IJXfoa5HE4alICi7HDIMQzFtdN24WQu
         4kSF36g/JUJr3oViKLB2sIqsA6dM9yHSRWfyNvKt+83JroPoWk3ArBRAgXkq49i3Mend
         l0pklsh/XSTHRqknDAdof0SdR3svJseIQKuCM=
Received: by 10.150.69.22 with SMTP id r22mr734820yba.167.1286964110763;
        Wed, 13 Oct 2010 03:01:50 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id q34sm7873384yba.10.2010.10.13.03.01.49
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 03:01:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101013091714.GA32608@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158924>

The copyfrom_source instruction appends data from the preimage
buffer to the end of output.  Its arguments are a length and an
offset relative to the beginning of the source view.

Helped-by: Ramkumar Ramachandra <artagnon@gmail.com>
Helped-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
That's the end of the series.  Thanks for reading.  Hopefully this
round did not introduce too many bugs but if it did, I'd be glad to
hear about them.

Good night,
Jonathan

 t/t9011-svn-da.sh |   35 +++++++++++++++++++++++++++++++++++
 vcs-svn/svndiff.c |   27 +++++++++++++++++++++++----
 2 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/t/t9011-svn-da.sh b/t/t9011-svn-da.sh
index c4bd1f3..c8959e2 100755
--- a/t/t9011-svn-da.sh
+++ b/t/t9011-svn-da.sh
@@ -198,4 +198,39 @@ test_expect_success 'catch copy that overflows' '
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
index 8f1b61e..d3d1dba 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -23,6 +23,7 @@
  * view_selector ::= copyfrom_source
  *   | copyfrom_target
  *   ;
+ * copyfrom_source ::= # binary 00 000000;
  * copyfrom_target ::= # binary 01 000000;
  * copyfrom_data ::= # binary 10 000000;
  * packed_view_selector ::= # view_selector OR-ed with 6 bit value;
@@ -33,6 +34,7 @@
  */
 
 #define INSN_MASK	0xc0
+#define INSN_COPYFROM_SOURCE	0x00
 #define INSN_COPYFROM_TARGET	0x40
 #define INSN_COPYFROM_DATA	0x80
 #define OPERAND_MASK	0x3f
@@ -42,6 +44,7 @@
 #define VLI_BITS_PER_DIGIT 7
 
 struct window {
+	struct view *in;
 	struct strbuf out;
 	struct strbuf instructions;
 	struct strbuf data;
@@ -144,6 +147,19 @@ static int read_chunk(struct line_buffer *delta, off_t *delta_len,
 	return 0;
 }
 
+static int copyfrom_source(struct window *ctx, const char **instructions,
+			   size_t nbytes, const char *insns_end)
+{
+	size_t offset;
+	if (parse_int(instructions, &offset, insns_end))
+		return -1;
+	if (unsigned_add_overflows(offset, nbytes) ||
+	    offset + nbytes > ctx->in->buf.len)
+		return error("Invalid delta: copies source data outside view.");
+	strbuf_add(&ctx->out, ctx->in->buf.buf + offset, nbytes);
+	return 0;
+}
+
 static int copyfrom_target(struct window *ctx, const char **instructions,
 			   size_t nbytes, const char *insns_end)
 {
@@ -193,12 +209,14 @@ static int step(struct window *ctx, const char **instructions, size_t *data_pos)
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
+		return error("Invalid instruction %x", instruction);
 	}
 }
 
@@ -220,9 +238,9 @@ static int apply_window_in_core(struct window *ctx)
 }
 
 static int apply_one_window(struct line_buffer *delta, off_t *delta_len,
-			    FILE *out)
+			    struct view *preimage, FILE *out)
 {
-	struct window ctx = {STRBUF_INIT, STRBUF_INIT, STRBUF_INIT};
+	struct window ctx = {preimage, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT};
 	size_t out_len;
 	size_t instructions_len;
 	size_t data_len;
@@ -277,7 +295,8 @@ int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
 		if (read_offset(delta, &pre_off, &delta_len) ||
 		    read_length(delta, &pre_len, &delta_len) ||
 		    move_window(&preimage_view, pre_off, pre_len) ||
-		    apply_one_window(delta, &delta_len, postimage))
+		    apply_one_window(delta, &delta_len,
+				     &preimage_view, postimage))
 			goto fail;
 		if (delta_len && buffer_at_eof(delta)) {
 			error("Delta ends early! (%"PRIu64" bytes remaining)",
-- 
1.7.2.3
