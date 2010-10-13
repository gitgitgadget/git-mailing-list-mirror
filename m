From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 04/11] vcs-svn: Read inline data from deltas
Date: Wed, 13 Oct 2010 04:35:59 -0500
Message-ID: <20101013093559.GE32608@burratino>
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
X-From: git-owner@vger.kernel.org Wed Oct 13 11:39:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5xo0-0003iP-AX
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 11:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837Ab0JMJjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 05:39:22 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:56657 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730Ab0JMJjV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 05:39:21 -0400
Received: by gxk6 with SMTP id 6so846881gxk.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 02:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=I+8jOirK70BkbBsi8HP+p9JHbL8mjViq8zldAEATQWM=;
        b=IIgH0FkRHOWgET6PNRpMqCDo95nPY6cuune4W4ixS756Ah567HGKhy2iNrh4A5TbSM
         FUwINHJ5u4l2On9JvWKqGv7dlL4WEHIFGjh9MHd4DVKAcYwu1HycXVRjMYx0zoTWXuLc
         8yTBcHSLs+0yRfi8a5wjTDpKOZEkKN31cqI18=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GAdtYx1oa1IAJKZ2IqdwVUHlW5EosLfOozZegM7b9+XoxzXoYXb5eS0gibAGN3nXvT
         s6X4xTTbhmt2qLfaBEqX8mzTXZLNeVfMQCozORcTIRuJuYPT/+cayFsHKtaYjmI/xXg6
         sX1j8T47Z+6ItANWc6iT0eUUhcLUiMvwEbrd0=
Received: by 10.101.71.8 with SMTP id y8mr2532416ank.252.1286962760569;
        Wed, 13 Oct 2010 02:39:20 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id d15sm12091233ana.0.2010.10.13.02.39.19
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 02:39:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101013091714.GA32608@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158917>

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

Helped-by: Ramkumar Ramachandra <artagnon@gmail.com>
Helped-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9011-svn-da.sh |   12 ++++++++++++
 vcs-svn/svndiff.c |   27 ++++++++++++++++++++++++---
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/t/t9011-svn-da.sh b/t/t9011-svn-da.sh
index b9aad70..44832b0 100755
--- a/t/t9011-svn-da.sh
+++ b/t/t9011-svn-da.sh
@@ -117,4 +117,16 @@ test_expect_success 'preimage view: accept truncated preimage' '
 	test_cmp empty actual.longread
 '
 
+test_expect_success 'inline data' '
+	printf "SVNQ%b%s%b%s" "QQQQ\003" "bar" "QQQQ\001" "x" |
+		q_to_nul >inline.clear &&
+	test-svn-fe -d preimage inline.clear 18 >actual &&
+	test_cmp empty actual
+'
+
+test_expect_success 'truncated inline data' '
+	printf "SVNQ%b%s" "QQQQ\003" "b" | q_to_nul >inline.trunc &&
+	test_must_fail test-svn-fe -d preimage inline.trunc 10
+'
+
 test_done
diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
index f2876b3..c60d732 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -23,6 +23,10 @@
 #define VLI_DIGIT_MASK	0x7f
 #define VLI_BITS_PER_DIGIT 7
 
+struct window {
+	struct strbuf data;
+};
+
 static int read_magic(struct line_buffer *in, off_t *len)
 {
 	static const char magic[] = {'S', 'V', 'N', '\0'};
@@ -101,11 +105,25 @@ static int read_length(struct line_buffer *in, size_t *result, off_t *len)
 	return 0;
 }
 
+static int read_chunk(struct line_buffer *delta, off_t *delta_len,
+		      struct strbuf *buf, size_t len)
+{
+	if (len > maximum_signed_value_of_type(off_t) ||
+	    (off_t) len > *delta_len)
+		return -1;
+	strbuf_reset(buf);
+	buffer_read_binary(buf, len, delta);
+	*delta_len -= buf->len;
+	return 0;
+}
+
 static int apply_one_window(struct line_buffer *delta, off_t *delta_len)
 {
+	struct window ctx = {STRBUF_INIT};
 	size_t out_len;
 	size_t instructions_len;
 	size_t data_len;
+	int rv = 0;
 	assert(delta_len);
 
 	/* "source view" offset and length already handled; */
@@ -115,9 +133,12 @@ static int apply_one_window(struct line_buffer *delta, off_t *delta_len)
 		return -1;
 	if (instructions_len > 0)
 		return error("What do you think I am?  A delta applier?");
-	if (data_len > 0)
-		return error("No support for inline data yet");
-	return 0;
+	if (read_chunk(delta, delta_len, &ctx.data, data_len))
+		return error("Invalid delta: incomplete data section");
+	if (buffer_ferror(delta))
+		rv = error("Cannot read delta: %s", strerror(errno));
+	strbuf_release(&ctx.data);
+	return rv;
 }
 
 int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
-- 
1.7.2.3
