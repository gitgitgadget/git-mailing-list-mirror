From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 05/11] vcs-svn: Read instructions from deltas
Date: Wed, 13 Oct 2010 04:38:01 -0500
Message-ID: <20101013093801.GF32608@burratino>
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
X-From: git-owner@vger.kernel.org Wed Oct 13 11:41:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5xpx-0004J6-Ep
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 11:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313Ab0JMJlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 05:41:24 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:57214 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175Ab0JMJlX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 05:41:23 -0400
Received: by yxm8 with SMTP id 8so973594yxm.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 02:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=GXzZ5zGTCZ3+tP2QzbvpG/OvyEeLmTg++v4/MBkNWwE=;
        b=Qn7ytDoQNRXmR74DTgPlpAOCEQE5HlPz6CO1KoVVNPSc+u3qveEoEAKhuqKHrWFZcN
         xDiekWxrDrAWmDNKnvct85S8xKGta7n5q3GjyW8WS3LMVSlSDKKffVmhT1G4tBm0+irr
         gtfiflS15bubpUg8ZJ2fl2wwdKYCgOgkbjEew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=k/4IRuVHeW5oDeRfTG63tfM1S+LBaR0rEE9FNNeGji25VRo1Bm3BAGxuCJUQNMKp2t
         suY56YZFbTlOQ2PcYO67M81jpBxnKwUUcoSG5CMMOYX7SL/TgDGi/xuNlmHBHI+BOFfy
         m12NIY0cDi+nnGJNN9xrHNmwO9nMmrreFu+C4=
Received: by 10.101.74.11 with SMTP id b11mr4495789anl.204.1286962882742;
        Wed, 13 Oct 2010 02:41:22 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id i10sm10490956ane.9.2010.10.13.02.41.21
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 02:41:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101013091714.GA32608@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158918>

Buffer the instruction section upon encountering it for later
interpretation.

An alternative design would involve parsing the instructions
at this point and buffering them in some processed form.  Using
the unprocessed form is simpler.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9011-svn-da.sh |    5 +++++
 vcs-svn/svndiff.c |   23 ++++++++++++++++++-----
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/t/t9011-svn-da.sh b/t/t9011-svn-da.sh
index 44832b0..1383263 100755
--- a/t/t9011-svn-da.sh
+++ b/t/t9011-svn-da.sh
@@ -129,4 +129,9 @@ test_expect_success 'truncated inline data' '
 	test_must_fail test-svn-fe -d preimage inline.trunc 10
 '
 
+test_expect_success 'truncated inline data (after instruction section)' '
+	printf "SVNQ%b%b%s" "QQ\001\001\003" "\0201" "b" | q_to_nul >insn.trunc &&
+	test_must_fail test-svn-fe -d preimage insn.trunc 11
+'
+
 test_done
diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
index c60d732..72fe716 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -24,6 +24,7 @@
 #define VLI_BITS_PER_DIGIT 7
 
 struct window {
+	struct strbuf instructions;
 	struct strbuf data;
 };
 
@@ -119,7 +120,7 @@ static int read_chunk(struct line_buffer *delta, off_t *delta_len,
 
 static int apply_one_window(struct line_buffer *delta, off_t *delta_len)
 {
-	struct window ctx = {STRBUF_INIT};
+	struct window ctx = {STRBUF_INIT, STRBUF_INIT};
 	size_t out_len;
 	size_t instructions_len;
 	size_t data_len;
@@ -131,13 +132,25 @@ static int apply_one_window(struct line_buffer *delta, off_t *delta_len)
 	    read_length(delta, &instructions_len, delta_len) ||
 	    read_length(delta, &data_len, delta_len))
 		return -1;
+	if (read_chunk(delta, delta_len, &ctx.instructions, instructions_len))
+		return error("Invalid delta: incomplete instructions section");
+	if (buffer_ferror(delta)) {
+		rv = error("Cannot read delta: %s", strerror(errno));
+		goto done;
+	}
+	if (read_chunk(delta, delta_len, &ctx.data, data_len)) {
+		rv = error("Invalid delta: incomplete data section");
+		goto done;
+	}
+	if (buffer_ferror(delta)) {
+		rv = error("Cannot read delta: %s", strerror(errno));
+		goto done;
+	}
 	if (instructions_len > 0)
 		return error("What do you think I am?  A delta applier?");
-	if (read_chunk(delta, delta_len, &ctx.data, data_len))
-		return error("Invalid delta: incomplete data section");
-	if (buffer_ferror(delta))
-		rv = error("Cannot read delta: %s", strerror(errno));
+ done:
 	strbuf_release(&ctx.data);
+	strbuf_release(&ctx.instructions);
 	return rv;
 }
 
-- 
1.7.2.3
