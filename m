From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 11/11] vcs-svn: Allow deltas to copy from preimage
Date: Wed, 13 Oct 2010 05:00:02 -0500
Message-ID: <20101013100002.GM32608@burratino>
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
X-From: git-owner@vger.kernel.org Wed Oct 13 12:03:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5yBH-0004MM-1B
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 12:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466Ab0JMKD0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 06:03:26 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41340 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730Ab0JMKDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 06:03:25 -0400
Received: by ywi6 with SMTP id 6so1404362ywi.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 03:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=+FRJfhBbna2xBt83ghx9HSxfh0mBrfYeQK1TwQi7bX4=;
        b=fduNOvNV3bcrUmQi8oEDCbmR4R/3P6p/eNAB8eoDfC4cmta8p07VevodIl+IirMDyN
         pqUrOubs3Pk/HYNcqL5mNkOTXDuv1+71B4Z4jgJXm4yT7xAsHW7mAeHMoORul4sIyd26
         BJeRNPZiktaKQ+TyT+I+iBvT27J4ui2XtIa90=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CnxKyCUq4xa0vwPi9N998n7DCUFKtvFocS1mpMJKy27GkmA/vVu9MT2mtSZCl6TgNP
         1VDCsq9K2xVI8TdmdFFlPN4V1+bgpZNpBuSszcoTF4BStl474O8TEpcWvxrIH8+D8kP9
         3xL9Zay2m/qrrlsvvaNkisOGuhSat2ra3uEWE=
Received: by 10.236.110.43 with SMTP id t31mr1433596yhg.81.1286964203956;
        Wed, 13 Oct 2010 03:03:23 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id 13sm7279255yhl.11.2010.10.13.03.03.21
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 03:03:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101013091714.GA32608@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158925>

The copyfrom_source instruction appends data from the preimage
buffer to the end of output.  Its arguments are a length and an
offset relative to the beginning of the source view.

Helped-by: Ramkumar Ramachandra <artagnon@gmail.com>
Helped-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
[resending with cc: samv]

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
