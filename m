From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 09/11] vcs-svn: Let deltas use data from postimage
Date: Wed, 13 Oct 2010 04:50:07 -0500
Message-ID: <20101013095007.GJ32608@burratino>
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
X-From: git-owner@vger.kernel.org Wed Oct 13 11:53:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5y1u-0000ZB-Gs
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 11:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175Ab0JMJxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 05:53:45 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43832 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078Ab0JMJxo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 05:53:44 -0400
Received: by gyg13 with SMTP id 13so27044gyg.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 02:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=TJxxvmGEC+sHmEZ7UF76KD6S4UDb7QXu+tF8VCuOwZo=;
        b=aXcg2N4jzs/78rmq1VJ7I7D21S5ra9sNSIW2uHwfEJ2HKBoBCEaw2MQ/0IOz4iZfc7
         gHnE0RpPdeRqy9j+N+vHrQj02SP6KkT292UYWv67dZ0+BbsFCGLj4fqGx1Gsmxey7M+a
         VoyR634RDC5fUkIEFym9tvrj7wGM17i92Y2As=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Yorsv1ZyHz+0pWycHiaCkAQDiHbLO6g8AqyrEwNW7EK0aU4AnNg8gGrP1ctCc7cXI2
         emZgceT/ixDPEE0psn4EFfNzA2xd9aPWGaoJQjW7D0nOT4rboWF2A+Tk97zGI3U6ifDv
         xCBnuvKabQmng37OXlJMuBgJtJkDMQPc7HXhE=
Received: by 10.150.32.1 with SMTP id f1mr660888ybf.62.1286963608806;
        Wed, 13 Oct 2010 02:53:28 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id v33sm4864736yba.2.2010.10.13.02.53.27
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 02:53:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101013091714.GA32608@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158922>

The copyfrom_target instruction copies appends data that is already
present in the current output view to the end of output.  (The offset
argument is relative to the beginning of output produced by the
current window.)

The region copied is allowed to run past the end of the existing
output.  To support that case, copy one character at a time
rather than using memcpy() or memmove().  This allows copyfrom_target
to be used once to repeat a string many times.  For example:

	COPYFROM_DATA 2
	COPYFROM_OUTPUT 10, 0
	DATA "ab"

would produce the output "ababababababababababab".

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9011-svn-da.sh |   42 ++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/svndiff.c |   30 ++++++++++++++++++++++++++++--
 2 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/t/t9011-svn-da.sh b/t/t9011-svn-da.sh
index c9f4768..ccd31e9 100755
--- a/t/t9011-svn-da.sh
+++ b/t/t9011-svn-da.sh
@@ -159,4 +159,46 @@ test_expect_success 'catch attempt to copy missing data' '
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
index 8755c83..8f1b61e 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -20,7 +20,12 @@
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
@@ -28,6 +33,7 @@
  */
 
 #define INSN_MASK	0xc0
+#define INSN_COPYFROM_TARGET	0x40
 #define INSN_COPYFROM_DATA	0x80
 #define OPERAND_MASK	0x3f
 
@@ -138,6 +144,21 @@ static int read_chunk(struct line_buffer *delta, off_t *delta_len,
 	return 0;
 }
 
+static int copyfrom_target(struct window *ctx, const char **instructions,
+			   size_t nbytes, const char *insns_end)
+{
+	size_t offset;
+	if (parse_int(instructions, &offset, insns_end))
+		return -1;
+	if (offset >= ctx->out.len)
+		return error("Invalid delta: copies from the future.");
+	while (nbytes) {
+		strbuf_addch(&ctx->out, ctx->out.buf[offset++]);
+		nbytes--;
+	}
+	return 0;
+}
+
 static int copyfrom_data(struct window *ctx, size_t *data_pos, size_t nbytes)
 {
 	const size_t pos = *data_pos;
@@ -171,9 +192,14 @@ static int step(struct window *ctx, const char **instructions, size_t *data_pos)
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
1.7.2.3
